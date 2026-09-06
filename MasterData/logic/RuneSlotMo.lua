-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/model/RuneSlotMo.lua

module("logic.extensions.rune.model.RuneSlotMo", package.seeall)

local RuneSlotMo = class("RuneSlotMo")

function RuneSlotMo:ctor()
	self.posId = -1
	self.runeId = -1
end

function RuneSlotMo:initData(msg)
	self.posId = msg.posId
	self.runeId = msg.runeId
end

function RuneSlotMo:initByFake(data)
	local mo = RuneItemMo.New()

	mo.runeId = -1
	mo.runeDefineId = data.defineId
	mo.level = data.level
	self.fakeRuneItemMo = mo
end

function RuneSlotMo:getRuneMo()
	if self.fakeRuneItemMo then
		return self.fakeRuneItemMo
	else
		return RuneModel.instance:getItemData(self.runeId)
	end
end

return RuneSlotMo
