
   
local function run(msg, matches)
  local text = matches[1]
  local b = 1

  while b ~= 0 do
    text = text:trim()
    text,b = text:gsub('^!+','')
  end
  return 'مادر قهوه ننه کیر پرست پول ننتو ندادم پورو شدی به ننت یه تراول صدی دادم داره هر روز به هم می ده برو ننتو جمع کن' ..text
end

return {
  description = "fohsh",
  usage = {
  "فحش[who]: فحش به دیگران",
  "fosh [who]: tpa به یگران",
  },
  patterns = {
    "^فحش +(.+)$",
	"^[/!#]fosh +(.+)$",
	"^fosh +(.+)$"
  }, 
  run = run 
}
