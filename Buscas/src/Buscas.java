public class Buscas {
   public static String origem = "";
   public static String destino = "";
   public static final int PROCESSOS = 2; // 2 processos

   public static void main(String[] arguments) {
      // Pega os argumentos da linha de comando
      //if (arguments.length > 1) {
       //  origem = arguments[0];
         //destino = arguments[1];
	   origem = "Florianopolis";
	   destino = "Itajai";
      //}
      //if (arguments.length > 2) {
        // if (arguments[2].equals("DEBUG")){
          //  Debug.DBG = true;
         //}
     // }
      // Inicializa as classes
      Cidades.carregarDados();
      SubidaEncosta.origem = origem;
      SubidaEncosta.destino = destino;
      // Cria as 2 threads, uma para cada tipo de metodo de busca
      SubidaEncosta[] se = new SubidaEncosta[PROCESSOS];
      for (int i=0; i<PROCESSOS; i++) {
         try {
            se[i] = new SubidaEncosta(i);
         } catch (Exception e) {
            System.out.println("Erro: " + e.toString());
         }
      }

      // Enquanto as threads estao rodando e eh primo
      boolean terminou = false;
      while (!terminou) {
         terminou = true;
         for (int i = 0; i < PROCESSOS; i++){
            if (!se[i].terminado) terminou = false;
         }
      }

      // Imprime o resultado
      System.out.println("Metodos de Busca:");
      System.out.println("Origem: " + origem + " Destino: " + destino);
      for (int i = 0; i < PROCESSOS; i++) {
         se[i].mostraResultado();
      }
   }
}