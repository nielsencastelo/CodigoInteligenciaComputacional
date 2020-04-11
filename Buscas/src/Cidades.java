import java.io.*;
import java.util.*;
import java.util.StringTokenizer;

public class Cidades {
   public static Vector cidades = new Vector();
   public int local = 0;
   boolean primeira = true;
   public String cidadeLocal = "";

   public static void carregarDados() {
      try {
         StringTokenizer lineToken;
         FileReader file = new FileReader("cidades.txt");
         BufferedReader buffer = new BufferedReader(file);
         boolean eof = false;
         while (!eof) {
            String line = buffer.readLine();
            if (line == null) eof = true;
            else {
               lineToken = new StringTokenizer(line, "-");
               String origem = lineToken.nextToken();
               String destino = lineToken.nextToken();
               int distancia = Integer.parseInt(lineToken.nextToken());
               Registro reg = new Registro(origem, destino, distancia);
               cidades.add(reg);
               reg = new Registro(destino, origem, distancia);
               cidades.add(reg);
            }
         }
         buffer.close();
      } catch (IOException e) {
         System.out.println("Error: " + e.toString());
      }
   }

   public void resetaLocal() {
      local = 0;
      primeira = true;
   }

   public String pegaProxima() {
      Registro reg;
      String destino = null;
      // Se não for a primeira, vai pra proxima
      if (!primeira) local++;
      else primeira = false;
      while ((destino == null) && (local < cidades.size())) {
         reg = (Registro)cidades.get(local);
         if (reg.origem.equals(cidadeLocal)) destino = reg.destino;
         else local++;
      }
      return destino;
   }

   public int pegaDistancia() {
      Registro reg;
      int distancia = 0;
      if (local < cidades.size()) {
         reg = (Registro)cidades.get(local);
         distancia = reg.distancia;
      }
      return distancia;
   }

   public void listarCidades() {
      Registro reg;
      for (int i = 0; i < cidades.size(); i++) {
         reg = (Registro)cidades.get(i);
         System.out.println("" + i + " - " + reg.origem + " - " + reg.destino + " - " + reg.distancia);
      }
   }
   /*
   public static void main(String[] arguments) {
      Cidades c = new Cidades();
      c.listarCidades();
   }
   */
}

class Registro {
   String origem;
   String destino;
   int distancia;

   Registro(String orig, String dest, int dist) {
      origem = orig;
      destino = dest;
      distancia = dist;
   }
}