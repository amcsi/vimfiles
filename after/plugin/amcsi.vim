if !exists("g:AutoPairsLoaded")
    inoremap ( ()<left>
    inoremap (( (
    inoremap () ()
    inoremap [ []<left>
    inoremap [[ [
    inoremap [] []
    inoremap {      {}<Left>
    inoremap {<CR>  {<CR>}<C-c>O
    inoremap {{     {
    inoremap {}     {}
endif
