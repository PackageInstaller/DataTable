-- chunkname: @modules/logic/partygamelobby/view/PartyGameLobbyJoystickComp.lua

module("modules.logic.partygamelobby.view.PartyGameLobbyJoystickComp", package.seeall)

local PartyGameLobbyJoystickComp = class("PartyGameLobbyJoystickComp", JoystickComp)

function PartyGameLobbyJoystickComp:onInitView()
	return
end

function PartyGameLobbyJoystickComp:onValueChange(x, y, index)
	local lengthIndex = index == -1 and 0 or 1

	index = index == -1 and 0 or index

	if self._lastIndex == nil or self._lastIndex ~= index or self._lastLengthIndex == nil or self._lastLengthIndex ~= lengthIndex then
		PartyGameLobbyController.instance:dispatchEvent(PartyGameLobbyEvent.MoveJoystick, index, lengthIndex)

		self._lastIndex = index
		self._lastLengthIndex = lengthIndex
	end
end

return PartyGameLobbyJoystickComp
