-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/base/prototype/MasterPrototype.lua

MasterPrototype = class("MasterPrototype", objectlua.Object, _M)

MasterPrototype:has("_id", {
	is = "r"
})
MasterPrototype:has("_config", {
	is = "r"
})

function MasterPrototype:initialize(masterId)
	super.initialize(self)

	self._config = ConfigReader:getRecordById("MasterBase", tostring(masterId))

	self:createBaseAttrNum()
end

function MasterPrototype:createBaseAttrNum()
	self._baseNumMap = {
		ATK = self._config.BaseAttack,
		DEF = self._config.BaseDefence,
		HP = self._config.BaseHp
	}
	self._baseRatioMap = {
		ATK = self._config.AttackFactor,
		DEF = self._config.DefenceFactor,
		HP = self._config.HpFactor
	}
	self._basicAttrNumMap = {
		ATK = self._config.DefaultAttack,
		DEF = self._config.DefaultDefence,
		HP = self._config.DefaultHp,
		CRITRATE = self._config.CritRate,
		UNCRITRATE = self._config.UncritRate,
		CRITSTRG = self._config.CritStrg,
		BLOCKRATE = self._config.BlockRate,
		UNBLOCKRATE = self._config.UnblockRate,
		BLOCKSTRG = self._config.BlockStrg,
		HURTRATE = self._config.HurtRate,
		UNHURTRATE = self._config.UnhurtRate,
		ABSORPTION = self._config.Absorption,
		REFLECTION = self._config.Reflection
	}
end

function MasterPrototype:getBasicAttrNumByType(attrType)
	return self._basicAttrNumMap[attrType] or 0
end

function MasterPrototype:getBaseNumByType(attrType)
	return self._baseNumMap[attrType]
end

function MasterPrototype:getBaseRatioByType(attrType)
	return self._baseRatioMap[attrType]
end
