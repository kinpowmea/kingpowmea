       do
          function run(msg, matches)
       local bye_name = msg.action.user.first_name
       return '\nمادر قهوه ننه کیر پرست پول ننتو ندادم پورو شدی به ننت یه تراول صدی دادم داره هر روز به هم می ده برو ننتو جمع کن' ..bye_name 
       end
return {
   description = "Welcoming Message",
   usage = "send message to new member",
   patterns = {
      "^[!/#]fosh (.*)$",
      "^فحش (.*)$"
   },
   run = run
}
