;; ----------------------------------------------------------------------------
;; Callback :: chat :: Phoenix Down
;; Recupera todo o HP de um usuário (consumível)
;; ----------------------------------------------------------------------------

alias cb.phoenixdown {
  user.vigor.set 100
  msgtopo
  msgt Você usou o 7Phoenix Down15!
  msgdiv
  msgl
  msgl 0   `-._     `-.     `.   \      :      /   .'     .-'     _.-'
  msgl 0._     `-._    `-.    `.  `.    :    .'  .'    .-'    _.-'     _
  msgl 0  `--._    `-._   `-.   `.  \   :   /  .'   .-'   _.-'    _.--'
  msgl 0__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __
  msgl 0  `--.__    `--._  `-.  `-. `. \:/ .' .-'  .-'  _.--'    __.--'
  msgl 0-..__   `--.__   `--. 7 _\|      __     |/_0  .--'   __.--'   __..-
  msgl 0__   `--..__  `--._  7_-  \_   _/"->   _/  -0_  _.--'  __..--'   __
  msgl 0  ``--..__  `--..__  7-_    `-'7   F`-'    _-0  __..--'  __..--''
  msgl 0__        ``--..__ `- 7`=.__.=-(  8,7)-=.__.='0 -' __..--''        __
  msgl 0  ```---...___    ``--..    8')7) (8)(7)'0    ..--''    ___...---'''
  msgl 0----....._____```---...    7'( 8(' 8)) 7)'0    ...---'''_____.....----
  msgl 0                 """""""""7` . 8_    _ 7.`0"""""""""
  msgl
  msgdiv
  msgt 8Você recuperou todo o seu HP
  msgt 0Adicionalmente, se você estava 15morto 0você 15reviveu 14;)
  msgbase
}


;; Sobrecarga dos aliases para aumentar o tamanho da janela
alias -l msgt xmsg -s65 $nick $1-
alias -l msgl xmsg -ls65 $nick $1-
alias -l msgdiv xmsgtb -s65 $nick div
alias -l msgtopo xmsgtb -s65 $nick topo
alias -l msgbase xmsgtb -s65 $nick base
