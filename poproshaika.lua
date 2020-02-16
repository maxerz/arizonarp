script_name("Poproshaika Arizona")
script_authors("Max Erzgate")
script_version(1.0)

require 'lib.moonloader'
require 'lib.sampfuncs'

local lsg, sf               = pcall(require, 'sampfuncs')
local lsampev, sp           = pcall(require, 'lib.samp.events')
local encoding              = require 'encoding'
local dlstatus              = require('moonloader').download_status
encoding.default            = 'CP1251'
u8 = encoding.UTF8

begtimer = false
begg = false

frazes =
{
	'/s Подайте бедному бомжу на пропитание',
	'/s Помогите бездомному и вы получите плюсик в карму',
	'/s Я помираю от голода! Помоги мне - дай пару монет!',
	'/s Большинство людей проходят и не помогают, а ты помоги мне!',
	'/s Ради господя помогите мне парой монеток',
	'/s Ради всего святого, киньте пару монет в кружку!',
	'/s Бедному БОМЖу нужны деньги на пропитание!',
	'/s Помоги мне выбраться с улицы, подай пару копеек на дом!',
	'/s Некоторые живут на Вайн-Вуде, а некоторые на улице! Помоги БОМЖам!',
	'/s Кинь пару копеек в кружку - спаси бездомного от голодной смерти!',
	'/s Помоги мне выбраться с помойки - дай пару монет!'
}
function ftext(text)
    sampAddChatMessage((' Poproshaika | {ffffff}%s'):format(text),0x9966CC)
end
function registerCommands()
    if sampIsChatCommandDefined('beginsbeg') then sampUnregisterChatCommand('beginsbeg') end
    sampRegisterChatCommand('beginsbeg', beginsbeg)
end
function main()
    if not isSampLoaded() or not isSampfuncsLoaded() then return end
    while not isSampAvailable() do wait(100) end
	ftext('Бот-Попрошайка v1.0 загружен!')
    ftext('Команды: beginsbeg')
    registerCommands()
end

function beginsbeg()
	begg = not begg
	ftext('Вы ' .. (begg and 'начали' or 'закончили') .. ' попрошайничать.')
	if begg == false then
        begtimer:terminate()
        begtimer = false
	else
		begtimer = lua_thread.create(function()
			while true do
				sampSendChat(frazes[math.random(#frazes)])
				wait(4100)
				sampSendChat('/do Перед бездомным находилась кружка для пожертвований.')
				wait(15000)
			end
		end)
	end
end