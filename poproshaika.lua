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
	'/s ������� ������� ����� �� ����������',
	'/s �������� ���������� � �� �������� ������ � �����',
	'/s � ������� �� ������! ������ ��� - ��� ���� �����!',
	'/s ����������� ����� �������� � �� ��������, � �� ������ ���!',
	'/s ���� ������� �������� ��� ����� �������',
	'/s ���� ����� �������, ������ ���� ����� � ������!',
	'/s ������� ����� ����� ������ �� ����������!',
	'/s ������ ��� ��������� � �����, ����� ���� ������ �� ���!',
	'/s ��������� ����� �� ����-����, � ��������� �� �����! ������ ������!',
	'/s ���� ���� ������ � ������ - ����� ���������� �� �������� ������!',
	'/s ������ ��� ��������� � ������� - ��� ���� �����!'
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
	ftext('���-���������� v1.0 ��������!')
    ftext('�������: beginsbeg')
    registerCommands()
end

function beginsbeg()
	begg = not begg
	ftext('�� ' .. (begg and '������' or '���������') .. ' ��������������.')
	if begg == false then
        begtimer:terminate()
        begtimer = false
	else
		begtimer = lua_thread.create(function()
			while true do
				sampSendChat(frazes[math.random(#frazes)])
				wait(4100)
				sampSendChat('/do ����� ��������� ���������� ������ ��� �������������.')
				wait(15000)
			end
		end)
	end
end