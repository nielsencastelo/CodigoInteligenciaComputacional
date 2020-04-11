public class Debug {
   public static boolean DBG = false;

   public static void dbg(String local, String info) {
      if (Debug.DBG)
         System.out.println("DBG: [" + local + "] " + info);
   }
}