module server

import os
import net
import utils
import io


pub fn input(mut conn net.TcpConn, user string) {
   for {

      mut reader := io.new_buffered_reader(reader: conn)
      conn.write_string("\r\n[$user@SovietC2]:") or { 0 }
      mut data := reader.read_line() or { return }

       if data.len > 0 {

         if data == "help" {

          conn.write_string("\033[H\033[2J") or { 0 }
          utils.help(mut conn)

         } else if data == "attack" {

           server.attack(mut conn, "$user")

         } else if data == "clear" {

            conn.write_string("\033[H\033[2J") or { 0 }
            utils.home(mut conn)

         } else if data == "geoip" {

            utils.geoip(mut conn)

         }
      }
   }
}