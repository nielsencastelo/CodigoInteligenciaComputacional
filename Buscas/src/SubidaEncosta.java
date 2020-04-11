import java.util.*;

public class SubidaEncosta implements Runnable {
   // public Vector cidades = new Vector();
   public static String origem = "";
   public static String destino = "";
   public boolean terminado = false;
   public boolean solucionado = false;
   public int tipo = 0;
   final int MENOR = 0;
   final int MAIOR = 1;
   private Vector percurso = new Vector(); // Cidades das quais já pasou
   private int kilometragem = 0; // Kilometragem total

   private Thread runner;

   SubidaEncosta(int t) {
      tipo = t;
      if (runner == null) {
         runner = new Thread(this);
         runner.start();
      }
   }

   public void mostraResultado() {
      System.out.print("Subida de Encosta Pela Trilha Mais Ingreme, escolhendo");
      if (tipo == MENOR) System.out.println(" o menor primeiro.");
      else System.out.println(" o maior primeiro.");
      for (int i = 0; i < percurso.size(); i++) {
         String cidade = (String)percurso.get(i);
         System.out.println(cidade);
      }
      System.out.println("Kilometragem total: " + kilometragem);
      if (solucionado) {
         System.out.println("Problema solucionado...");
      } else {
         System.out.println("Problema não solucionado...");
      }
   }

   public void run() {
      boolean encontrouDestino = false;
      percurso.add(origem);   // Inicializa no ponto de origem
      Arvore ar = new Arvore(origem, destino);
      Cidades c = new Cidades();
      c.cidadeLocal = origem;
      String cidadeVizinha = null;
      while ((!encontrouDestino) && (!terminado)) {
         // Se não foi visitado o no ainda, entao monta a arvore com os nós filhos.
         boolean temFilhos = false;
         if (!ar.local.filhosCriados) {
            c.resetaLocal();
            do {
               cidadeVizinha = c.pegaProxima();
               if (cidadeVizinha != null) {
                  // Se a cidade ainda não está no percurso, então...
                  // isto serve para evitar loopings na arvore.
                  if (!percurso.contains(cidadeVizinha)) {
                     ar.insereCidade(cidadeVizinha, c.pegaDistancia());
                     temFilhos = true;
                  }
               }
            } while (cidadeVizinha != null);
         } else {
            if (ar.local.temFilhosAbertos()) temFilhos = true;
         }
         // Se não tiver filhos, faz um backtracking
         if (!temFilhos) {
            kilometragem -= ar.local.distancia;
            percurso.removeElement(ar.local.cidade);
            ar.volta();
            Debug.dbg("PROCESSO " + tipo ,"<-" + ar.local.cidade);
            c.cidadeLocal = ar.local.cidade;
            // se o elemento da arvore é nulo, então não achou solução
            if (ar.local == null) terminado = true;
         } else {
            // segue o menor ou maior, conforme o tipo
            ar.segue(tipo);
            Debug.dbg("PROCESSO " + tipo,"->" + ar.local.cidade);
            // adiciona a nova cidade no percurso.
            percurso.add(ar.local.cidade);
            c.cidadeLocal = ar.local.cidade;
            kilometragem += ar.local.distancia;
            // Se encontrou a solução, então termina.
            if (ar.local.cidade.equals(destino)) {
               terminado = true;
               solucionado = true;
            }
         }
      }
      // Acho que não precisa, mas só por garantia, vai lá...
      terminado = true;
      Debug.dbg("PROCESSO " + tipo, "Terminado");
   }
}