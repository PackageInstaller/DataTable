-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/model/JumpItemMO.lua

module("logic.extensions.jumpgame.model.JumpItemMO", package.seeall)

local JumpItemMO = class("JumpItemMO")

function JumpItemMO:ctor()
	self._itemType = 1
end

function JumpItemMO:onReset()
	return
end

function JumpItemMO:initType(itemTypes)
	self._itemType = itemTypes[math.floor(UnityEngine.Random.Range(1, #itemTypes + 1))]
end

return JumpItemMO
