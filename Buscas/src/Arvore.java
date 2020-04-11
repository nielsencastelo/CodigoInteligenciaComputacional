import java.util.*;

public class Arvore {
   public No origem;
   public No local;
   public String destino;
   final int MENOR = 0;
   final int MAIOR = 1;

   // Inicializa a arvore com o primeiro elemento
   Arvore (String o, String d) {
      origem = new No(null, o, 0);
      destino = d;
      local = origem;
   }

   // Insere um novo elemento, a cidade e sua distancia até a cidade local
   public void insereCidade(String c, int d) {
      No novoNo = new No(local, c, d);
      local.insereFilho(novoNo);
   }

   public void volta() {
      local.aberto = false;
      local = local.pai;
   }

   public void segue(int tipo) {
      No valor = null;
      No noDestino = null;
      boolean achou = false;
      for (int i = 0; i < local.size; i++) {
         No filho = local.getFilho(i);
         if (!achou){ // para executar na primeira vez
            if (filho.cidade.equals(destino)) {
               noDestino = filho;
            } else if (filho.aberto) {
               valor = filho;
               achou = true;
            }
         } else {
            if (filho.aberto) {
               if (filho.cidade.equals(destino)) {
                  noDestino = filho;
               } else if (tipo == MAIOR){
                  if (filho.distancia > valor.distancia)
                     valor = filho;
               } else if (tipo == MENOR) {
                  if (filho.distancia < valor.distancia)
                     valor = filho;
               }
            }
         }
      }
      if (noDestino != null)
         local = noDestino;
      else local = valor;
   }
}

class No {
   public No pai;
   public String cidade = "";
   public int distancia = 0;
   public boolean aberto = true;
   public boolean filhosCriados = false;
   public Vector filhos = new Vector();
   public int size = 0;

   No(No p, String c, int d) {
      pai = p;
      cidade = c;
      distancia = d;
   }

   public void insereFilho(No f) {
      filhos.add(f);
      size++;
      filhosCriados = true;
   }

   public boolean temFilhosAbertos() {
      boolean filhosAbertos = false;
      int i = 0;
      while ((!filhosAbertos) && (i < filhos.size())) {
         No filho = (No)filhos.get(i);
         if (filho.aberto) filhosAbertos = true;
         i++;
      }
      return filhosAbertos;
   }

   public No getFilho(int i) {
      if ((i > size) || (i < 0)) return null;
      return (No)filhos.get(i);
   }
}