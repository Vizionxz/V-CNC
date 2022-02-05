module utils

import os
import net
import io
import net.http



pub fn geoip(mut conn net.TcpConn) {
	mut reader := io.new_buffered_reader(reader: conn)
	mut i := conn.write_string("Enter IP:") or { 0 }
	mut redf := reader.read_line() or {" "}

	if redf.int() > 0 {

	mut d := http.get("yourgeoapi" + "$redf") or {
		panic("Failed!")
	}
	conn.write_string("\033[H\033[2J") or { 0 }
	conn.write_string(replace_s(d.text)) or { 0 }
 	}
}


pub fn main_title(mut conn net.TcpConn) {
	mut g := os.read_file("banners/title.txt") or {
		panic("Failed!")
	}
	conn.write_string("\033]0;${g}\007") or { 0 }
}

pub fn login_title(mut conn net.TcpConn) {
	mut i := " Login "
	conn.write_string("\033]0;${i}\007") or { 0 }
}


pub fn replace_s(yes string) string {
	mut d := yes

	d = d.replace("<br>", "\r\n")
	return d
}