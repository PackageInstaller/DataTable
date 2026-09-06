-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/buffMo/MiracleHeroPropertyBuffMo.lua

module("logic.extensions.miraclehero.model.buffMo.MiracleHeroPropertyBuffMo", package.seeall)

local MiracleHeroPropertyBuffMo = class("MiracleHeroPropertyBuffMo", MiracleHeroBuffMo)

function MiracleHeroPropertyBuffMo:ctor()
	MiracleHeroPropertyBuffMo.super.ctor(self)

	self.buffType = MiracleHeroBuffType.PropertyChange
	self.proertyType = 0
	self.changeValue = 0
end

function MiracleHeroPropertyBuffMo:initData(buffId, params, effectTime)
	self.configId = buffId
	self.tier = effectTime

	local attrName, value = FightingPowerFormula.instance:getAttrNameValue(params)

	self.proertyType = FightingPowerFormula.instance:getAttrTypeByName(attrName)
	self.changeValue = value
end

function MiracleHeroPropertyBuffMo:onAddBuffBefore()
	if self.proertyType == GameEnum.AttrType.Hp or self.proertyType == GameEnum.AttrType.HpRate then
		local petMo = MiracleHeroUnitMgr.instance:getPet(self.targetId)

		self._tempHpRate = petMo.curHp / petMo:getMaxHp()
	end
end

function MiracleHeroPropertyBuffMo:onAddBuff()
	if self.proertyType == GameEnum.AttrType.Hp or self.proertyType == GameEnum.AttrType.HpRate then
		local petMo = MiracleHeroUnitMgr.instance:getPet(self.targetId)

		petMo.curHp = math.floor(petMo:getMaxHp() * self._tempHpRate)
		self._tempHpRate = nil
	end
end

function MiracleHeroPropertyBuffMo:onRemoveBefore()
	if self.proertyType == GameEnum.AttrType.Hp or self.proertyType == GameEnum.AttrType.HpRate then
		local petMo = MiracleHeroUnitMgr.instance:getPet(self.targetId)

		self._tempHpRate = petMo.curHp / petMo:getMaxHp()
	end
end

function MiracleHeroPropertyBuffMo:onRemoveBuff()
	if self.proertyType == GameEnum.AttrType.Hp or self.proertyType == GameEnum.AttrType.HpRate then
		local petMo = MiracleHeroUnitMgr.instance:getPet(self.targetId)

		petMo.curHp = math.ceil(petMo:getMaxHp() * self._tempHpRate)
		self._tempHpRate = nil
	end
end

return MiracleHeroPropertyBuffMo
