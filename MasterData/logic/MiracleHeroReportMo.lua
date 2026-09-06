-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroReportMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroReportMo", package.seeall)

local MiracleHeroReportMo = class("MiracleHeroReportMo")

function MiracleHeroReportMo:ctor()
	self.petId = 0
	self.isCritical = false
	self.createDamage = false
	self.attackHps = 0
	self.afterRoundHp = 0
	self.buffIds = {}
	self.effectHpBuffIds = {}
end

function MiracleHeroReportMo:reset()
	self.petId = 0
	self.isCritical = false
	self.createDamage = false
	self.attackHps = 0
	self.afterRoundHp = 0

	table.clear(self.buffIds)
	table.clear(self.effectHpBuffIds)
end

return MiracleHeroReportMo
