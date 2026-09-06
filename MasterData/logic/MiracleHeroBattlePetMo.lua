-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/model/battleMo/MiracleHeroBattlePetMo.lua

module("logic.extensions.miraclehero.model.battleMo.MiracleHeroBattlePetMo", package.seeall)

local MiracleHeroBattlePetMo = class("MiracleHeroBattlePetMo")

function MiracleHeroBattlePetMo:ctor()
	self.battleId = 0
	self.id = 0
	self.configId = 0
	self.level = 0
	self.buffList = {}
	self.teamId = 0
	self.hp = 0
	self.attack = 0
	self.speed = 0
	self.criticalRate = 0
	self.curHp = 0
end

function MiracleHeroBattlePetMo:initData(info)
	self.id = info.id
	self.configId = info.configId
	self.teamId = info.teamId
	self.hp = info.hp
	self.level = info.level
	self.curHp = self.hp
	self.attack = info.attack
	self.speed = info.speed
	self.criticalRate = info.criticalRate
	self.criticaDamage = 1.5
end

function MiracleHeroBattlePetMo:getMaxHp()
	local fixAddHp = 0
	local addRate = 0

	for i, v in ipairs(self.buffList) do
		local buffMo = MiracleHeroBuffMgr.instance:getBuff(v)

		if buffMo.buffType == MiracleHeroBuffType.PropertyChange then
			if buffMo.proertyType == GameEnum.AttrType.HpRate then
				addRate = addRate + buffMo.changeValue
			elseif buffMo.proertyType == GameEnum.AttrType.Hp then
				fixAddHp = fixAddHp + buffMo.changeValue
			end
		end
	end

	return math.floor(self.hp * (1 + addRate) + fixAddHp)
end

function MiracleHeroBattlePetMo:reduceHp(damage)
	self.curHp = math.max(self.curHp - damage, 0)
end

return MiracleHeroBattlePetMo
