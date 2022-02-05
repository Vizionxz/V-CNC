module auth

import net
import utils
import auth
import io
import os
import time
import rand
import server

const (
    red = '\u001b[31m'
    reset = '\u001b[0m'
    white = '\u001b[37m'
    black = '\u001b[30m'                     
)


pub fn login(mut conn net.TcpConn) { 
	
	utils.login_title(mut conn)
	mut ip := conn.peer_ip() or {
		panic("Failed!")
	}
	mut timee := time.now()
	mut users := os.read_file("db/users.txt") or {" "}
	mut reader := io.new_buffered_reader(reader: conn)
	conn.write_string("${red}Enter Username${reset}: ") or { 0 }
	mut iu := reader.read_line() or {" "}
	conn.write_string("${red}Enter Password${reset}:${black} ") or { 0 }
	mut dp := reader.read_line() or {" "}
	
	if users.contains("$iu $dp") {          
		conn.write_string("\033[H\033[2J") or { 0 }
		captcha(mut conn, "$iu", "$ip", "$timee")

	} else {
		conn.write_string("Incorrect Login!") or { 0 }
		time.sleep(300*time.nanosecond)
		conn.close() or {
			panic("Failed!")
		}
	}
}

pub fn test(mut conn net.TcpConn) {
	conn.write_string("Help") or { 0 }
}

pub fn captcha(mut conn net.TcpConn, user string, ip string, time string) {
	mut reader := io.new_buffered_reader(reader: conn)
	mut rand := rand.int_in_range(1, 1000)
	conn.write_string("\u001b[0m") or { 0 }
	conn.write_string("Enter Captcha<$rand>:") or { 0 }
	mut read := reader.read_line() or {" "}

	if read == "$rand" {
		
		utils.main_title(mut conn)
		println("${user} ${ip} has successfully logged in at ${time}")
		mut w := os.open_append("logs/login_logs.txt") or {
			panic("Failed!")
		}
		w.write("\r\n${user} ${ip} logged in at ${time}".bytes()) or {
			panic("Failed to write login log!")
		}
		w.close()
		conn.write_string("\033[H\033[2J") or { 0 }
		utils.home(mut conn)
		server.input(mut conn, "$user")

	}
}
