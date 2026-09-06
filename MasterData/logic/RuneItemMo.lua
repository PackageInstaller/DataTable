-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rune/model/RuneItemMo.lua

module("logic.extensions.rune.model.RuneItemMo", package.seeall)

local RuneItemMo = class("RuneItemMo")

RuneItemMo.STATE_FREE = 0
RuneItemMo.STATE_EQUIPED = 1
RuneItemMo.STATE_DELETED = 2

function RuneItemMo:ctor()
	self.runeId = -1
	self.runeDefineId = -1
	self.level = -1
	self.curExp = -1
	self.getDate = nil
	self.state = -1
	self.isLocked = false
	self.suitId = -1
end

function RuneItemMo:initData(msg)
	self.runeId = msg.runeId
	self.runeDefineId = msg.runeDefineId
	self.level = msg.level
	self.curExp = msg.curExp
	self.getDate = msg.getDate
	self.state = msg.state
	self.isLocked = msg.isLocked
	self.suitId = msg.equipSuitId
	self.cfg = RuneConfig.instance:getRuneCfg(self.runeDefineId)
	self.name = ""

	if self.cfg then
		self.lvlCfg = RuneConfig.instance:getRuneLvlCfg(self.runeDefineId, self.level)
		self._prop = self.lvlCfg.propertyApp
		self._type = checknumber(self.cfg.runeType)
		self._quality = checknumber(self.cfg.quality)
		self.defineExp = checknumber(self.cfg.defineExp)
		self.decomposeCrystal = checknumber(self.cfg.decomposeCrystal)
		self.name = self.cfg.name
	end
end

function RuneItemMo:getId()
	return self.runeId
end

function RuneItemMo:getMatType()
	return MatType.Rune
end

function RuneItemMo:getDefineId()
	return self.runeDefineId
end

function RuneItemMo:getType()
	return self._type or 0
end

function RuneItemMo:getProp()
	return self._prop or ""
end

function RuneItemMo:getName()
	return self.name or ""
end

function RuneItemMo:getQuality()
	return checknumber(self._quality)
end

function RuneItemMo:getDepartItemCount()
	return checknumber(self.decomposeCrystal)
end

function RuneItemMo:getTypeName()
	return RuneConfig.instance:getTypeName(self._type)
end

function RuneItemMo:getTotalExp()
	return self.curExp + checknumber(self.defineExp)
end

function RuneItemMo:getZDL()
	return RuneConfig.instance:getRuneZDL(self.runeDefineId, self.level)
end

return RuneItemMo
