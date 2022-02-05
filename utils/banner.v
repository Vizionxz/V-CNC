module utils

import os
import net
import utils

const (

    blue = '\u001b[34m'
    black = '\u001b[30m'
    red = '\u001b[31m'
    green = '\u001b[32m'
    yellow = '\u001b[33m'
    magenta = '\u001b[35m'
    cyan = '\u001b[36m'
    white = '\u001b[37m'
    reset = '\u001b[0m'                     

)


pub fn home(mut conn net.TcpConn) {
	mut ban := os.read_file("banners/home.txf") or {
		panic("Failed!")
	}
	conn.write_string(replace_code(ban)) or { 0 }

}


pub fn replace_code(yes string) string {
	mut i := yes

	i = i.replace("{red}", "\u001b[31m")
    i = i.replace("{blue}", "\u001b[34m")
    i = i.replace("{reset}", "\u001b[0m")
    i = i.replace("{yellow}", "\u001b[33m")
	return i
}

pub fn help(mut conn net.TcpConn) {

    mut ban := os.read_file("banners/help.txf") or {
	panic("Failed!")
	}
	conn.write_string(replace_code(ban)) or { 0 }

}