-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/evolve/view/EvolveMo.lua

module("logic.extensions.evolve.view.EvolveMo", package.seeall)

local EvolveMo = class("EvolveMo")

function EvolveMo:ctor()
	self.isItem = false
	self.petIdBefore = 0
	self.raceIdBefore = 0
	self.raceIdAfter = 0
	self.itemStr = ""
	self.callback = nil
end

function EvolveMo:setParamById(raceIdBefore, raceIdAfter, petIdBefore)
	self.isItem = false
	self.petIdBefore = petIdBefore
	self.raceIdBefore = raceIdBefore
	self.raceIdAfter = raceIdAfter
end

function EvolveMo:setParamByItemStr(itemStr)
	self.isItem = true
	self.itemStr = itemStr
end

function EvolveMo:setCallback(callback)
	self.callback = callback
end

function EvolveMo:isItemType()
	return self.isItem
end

return EvolveMo
