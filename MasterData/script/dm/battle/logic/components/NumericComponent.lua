-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/components/NumericComponent.lua

local floor = math.floor
local ceil = math.ceil

kAttrAttack = "atk"
kAttrAttackRate = "atkrate"
kAttrDefenseWeaken = "defweaken"
kAttrDefense = "def"
kAttrDefenseRate = "defrate"
kAttrAttackWeaken = "atkweaken"
kAttrCritRate = "critrate"
kAttrUncritRate = "uncritrate"
kAttrCritStrength = "critstrg"
kAttrBlockRate = "blockrate"
kAttrUnblockRate = "unblockrate"
kAttrBlockStrength = "blockstrg"
kAttrHurtRate = "hurtrate"
kAttrUnhurtRate = "unhurtrate"
kAttrCureRate = "curerate"
kAttrBecuredRate = "becuredrate"
kAttrAbsorption = "absorption"
kAttrReflection = "reflection"
kAttrDoubleRate = "doublerate"
kAttrCounterRate = "counterrate"
kAttrSkillRate = "skillrate"
kAttrSpeed = "speed"
kAttrRpRecvRate = "rprecvrate"
kAttrEffectRate = "effectrate"
kAttrUneffectRate = "uneffectrate"
kAttrEffectStrength = "effectstrg"
kAttrAOEDerate = "aoederate"
kAttrAOERate = "aoerate"
kAttrSingleDerate = "singlederate"
kAttrSingleRate = "singlerate"
kAttrHotFactor = "hotfactor"
kAttrUnyieldFactor = "unyieldfactor"
kAttrFatalThreshold = "fatalthreshold"
kAttrFatalFactor = "fatalfactor"
kAttrSlayThreshold = "slaythreshold"
kAttrSlayFactor = "slayfactor"
kAttrDazeProb = "dazeprob"
kAttrDazeRound = "dazeround"
kAttrDelRpProb = "delrpprob"
KAttrDelRp = "delrp"
kAttrCtrlExDmg = "ctrlexdmg"
kAttrExtraSkillRate = "exskillrate"
kAttrSpecialNum1 = "specialnum1"
kAttrSpecialNum2 = "specialnum2"
kAttrSpecialNum3 = "specialnum3"

local ToIntMethod = {
	Floor = function(g)
		return function(self)
			return floor(g(self))
		end
	end,
	Ceil = function(g)
		return function(self)
			return ceil(g(self))
		end
	end,
	Round = function(g)
		return function(self)
			return floor(g(self) + 0.5)
		end
	end
}

local function numericAttribute(toInt)
	local attr = AttributeNumber:new()

	if toInt ~= nil then
		attr.value = toInt(attr.value)
	end

	return attr
end

NumericComponent = class("NumericComponent", BaseComponent, _M)

function NumericComponent:initialize()
	super.initialize(self)

	self._attrs = {
		[kAttrAttack] = numericAttribute(ToIntMethod.Floor),
		[kAttrAttackRate] = numericAttribute(),
		[kAttrDefenseWeaken] = numericAttribute(),
		[kAttrDefense] = numericAttribute(ToIntMethod.Floor),
		[kAttrDefenseRate] = numericAttribute(),
		[kAttrAttackWeaken] = numericAttribute(),
		[kAttrCritRate] = numericAttribute(),
		[kAttrUncritRate] = numericAttribute(),
		[kAttrCritStrength] = numericAttribute(),
		[kAttrBlockRate] = numericAttribute(),
		[kAttrUnblockRate] = numericAttribute(),
		[kAttrBlockStrength] = numericAttribute(),
		[kAttrHurtRate] = numericAttribute(),
		[kAttrUnhurtRate] = numericAttribute(),
		[kAttrCureRate] = numericAttribute(),
		[kAttrBecuredRate] = numericAttribute(),
		[kAttrAbsorption] = numericAttribute(),
		[kAttrReflection] = numericAttribute(),
		[kAttrDoubleRate] = numericAttribute(),
		[kAttrCounterRate] = numericAttribute(),
		[kAttrSkillRate] = numericAttribute(),
		[kAttrSpeed] = numericAttribute(),
		[kAttrEffectRate] = numericAttribute(),
		[kAttrUneffectRate] = numericAttribute(),
		[kAttrEffectStrength] = numericAttribute(),
		[kAttrRpRecvRate] = numericAttribute(),
		[kAttrHotFactor] = numericAttribute(),
		[kAttrUnyieldFactor] = numericAttribute(),
		[kAttrFatalThreshold] = numericAttribute(),
		[kAttrFatalFactor] = numericAttribute(),
		[kAttrSlayThreshold] = numericAttribute(),
		[kAttrSlayFactor] = numericAttribute(),
		[kAttrDazeProb] = numericAttribute(),
		[kAttrDazeRound] = numericAttribute(),
		[kAttrDelRpProb] = numericAttribute(),
		[KAttrDelRp] = numericAttribute(),
		[kAttrCtrlExDmg] = numericAttribute(),
		[kAttrExtraSkillRate] = numericAttribute(),
		[kAttrSpecialNum1] = numericAttribute(),
		[kAttrSpecialNum2] = numericAttribute(),
		[kAttrSpecialNum3] = numericAttribute(),
		[kAttrAOEDerate] = numericAttribute(),
		[kAttrAOERate] = numericAttribute(),
		[kAttrSingleDerate] = numericAttribute(),
		[kAttrSingleRate] = numericAttribute()
	}

	for name, attr in pairs(self._attrs) do
		attr.name = name
	end
end

function NumericComponent:initWithRawData(data)
	super.initWithRawData(self, data)

	if not data.ratio then
		local attrs = self._attrs

		attrs[kAttrAttack]:setBase(data.atk * data.ratio or 0)
		attrs[kAttrAttackRate]:setBase(data.atkrate or 1)
		attrs[kAttrDefenseWeaken]:setBase(data.defweaken or 0)
		attrs[kAttrDefense]:setBase(data.def * data.ratio or 0)
		attrs[kAttrDefenseRate]:setBase(data.defrate or 1)
		attrs[kAttrAttackWeaken]:setBase(data.atkweaken or 0)
		attrs[kAttrCritRate]:setBase(data.critrate or 0)
		attrs[kAttrUncritRate]:setBase(data.uncritrate or 0)
		attrs[kAttrCritStrength]:setBase(data.critstrg or 0)
		attrs[kAttrBlockRate]:setBase(data.blockrate or 0)
		attrs[kAttrUnblockRate]:setBase(data.unblockrate or 0)
		attrs[kAttrBlockStrength]:setBase(data.blockstrg or 0)
		attrs[kAttrHurtRate]:setBase(data.hurtrate or 1)
		attrs[kAttrUnhurtRate]:setBase(data.unhurtrate or 0)
		attrs[kAttrCureRate]:setBase(data.curerate or 0)
		attrs[kAttrBecuredRate]:setBase(data.becuredrate or 0)
		attrs[kAttrAbsorption]:setBase(data.absorption or 0)
		attrs[kAttrReflection]:setBase(data.reflection or 0)
		attrs[kAttrDoubleRate]:setBase(data.doublerate or 0)
		attrs[kAttrCounterRate]:setBase(data.counterrate or 0)
		attrs[kAttrSkillRate]:setBase(data.skillrate or 0)
		attrs[kAttrSpeed]:setBase(data.speed or 0)
		attrs[kAttrEffectRate]:setBase(data.effectrate or 0)
		attrs[kAttrUneffectRate]:setBase(data.uneffectrate or 0)
		attrs[kAttrEffectStrength]:setBase(data.effectstrg or 0)
		attrs[kAttrRpRecvRate]:setBase(data.rprecvrate or 0)
		attrs[kAttrHotFactor]:setBase(data.hotfactor or 0)
		attrs[kAttrUnyieldFactor]:setBase(data.unyieldfactor or 0)
		attrs[kAttrFatalThreshold]:setBase(data.fatalthreshold or 0)
		attrs[kAttrFatalFactor]:setBase(data.fatalfactor or 0)
		attrs[kAttrSlayThreshold]:setBase(data.slaythreshold or 0)
		attrs[kAttrSlayFactor]:setBase(data.slayfactor or 0)
		attrs[kAttrDazeProb]:setBase(0)
		attrs[kAttrDazeRound]:setBase(1)
		attrs[kAttrDelRpProb]:setBase(0)
		attrs[KAttrDelRp]:setBase(0)
		attrs[kAttrCtrlExDmg]:setBase(0)
		attrs[kAttrExtraSkillRate]:setBase(0)
		attrs[kAttrSpecialNum1]:setBase(0)
		attrs[kAttrSpecialNum2]:setBase(0)
		attrs[kAttrSpecialNum3]:setBase(0)
		attrs[kAttrAOEDerate]:setBase(data.aoederate or 0)
		attrs[kAttrAOERate]:setBase(0)
		attrs[kAttrSingleDerate]:setBase(0)
		attrs[kAttrSingleRate]:setBase(0)
	end
end

function NumericComponent:attributes()
	return self._attrs
end

function NumericComponent:getAttribute(name)
	return self._attrs[name]
end

function NumericComponent:getAttrValue(name)
	local attr = self._attrs[name]

	return attr and attr:value()
end

function NumericComponent:getAttrBase(name)
	local attr = self._attrs[name]

	return attr and attr:getBase()
end

function NumericComponent:copyComponent(srcComp, ratio)
	local attrs = self._attrs

	ratio = ratio or 1

	local atkRatio = ratio
	local atkRatio

	if type(ratio) == "table" then
		atkRatio = ratio.atkRatio or 1
	end

	local defRatio = ratio
	local defRatio

	if type(ratio) == "table" then
		defRatio = ratio.defRatio or 1
	end

	if type(ratio) == "table" then
		if not ratio.atkEx then
			local atkEx = 0

			if type(ratio) == "table" then
				if not ratio.defEx then
					local defEx = 0

					if type(ratio) == "table" then
						if not ratio.skillrate then
							local skillrate = srcComp:getAttrBase(kAttrSkillRate)

							attrs[kAttrAttack]:setBase((srcComp:getAttrBase(kAttrAttack) or 0) * atkRatio + atkEx)
							attrs[kAttrAttackRate]:setBase(srcComp:getAttrBase(kAttrAttackRate) or 1)
							attrs[kAttrDefenseWeaken]:setBase(srcComp:getAttrBase(kAttrDefenseWeaken) or 0)
							attrs[kAttrDefense]:setBase((srcComp:getAttrBase(kAttrDefense) or 0) * defRatio + defEx)
							attrs[kAttrDefenseRate]:setBase(srcComp:getAttrBase(kAttrDefenseRate) or 1)
							attrs[kAttrAttackWeaken]:setBase(srcComp:getAttrBase(kAttrAttackWeaken) or 0)
							attrs[kAttrCritRate]:setBase(srcComp:getAttrBase(kAttrCritRate) or 0)
							attrs[kAttrUncritRate]:setBase(srcComp:getAttrBase(kAttrUncritRate) or 0)
							attrs[kAttrCritStrength]:setBase(srcComp:getAttrBase(kAttrCritStrength) or 0)
							attrs[kAttrBlockRate]:setBase(srcComp:getAttrBase(kAttrBlockRate) or 0)
							attrs[kAttrUnblockRate]:setBase(srcComp:getAttrBase(kAttrUnblockRate) or 0)
							attrs[kAttrBlockStrength]:setBase(srcComp:getAttrBase(kAttrBlockStrength) or 0)
							attrs[kAttrHurtRate]:setBase(srcComp:getAttrBase(kAttrHurtRate) or 1)
							attrs[kAttrUnhurtRate]:setBase(srcComp:getAttrBase(kAttrUnhurtRate) or 0)
							attrs[kAttrCureRate]:setBase(srcComp:getAttrBase(kAttrCureRate) or 0)
							attrs[kAttrBecuredRate]:setBase(srcComp:getAttrBase(kAttrBecuredRate) or 0)
							attrs[kAttrAbsorption]:setBase(srcComp:getAttrBase(kAttrAbsorption) or 0)
							attrs[kAttrReflection]:setBase(srcComp:getAttrBase(kAttrReflection) or 0)
							attrs[kAttrDoubleRate]:setBase(srcComp:getAttrBase(kAttrDoubleRate) or 0)
							attrs[kAttrCounterRate]:setBase(srcComp:getAttrBase(kAttrCounterRate) or 0)
							attrs[kAttrSkillRate]:setBase(skillrate or 0)
							attrs[kAttrSpeed]:setBase(srcComp:getAttrBase(kAttrSpeed) or 0)
							attrs[kAttrEffectRate]:setBase(srcComp:getAttrBase(kAttrEffectRate) or 0)
							attrs[kAttrUneffectRate]:setBase(srcComp:getAttrBase(kAttrUneffectRate) or 0)
							attrs[kAttrEffectStrength]:setBase(srcComp:getAttrBase(kAttrEffectStrength) or 0)
							attrs[kAttrRpRecvRate]:setBase(srcComp:getAttrBase(kAttrRpRecvRate) or 0)
							attrs[kAttrHotFactor]:setBase(srcComp:getAttrBase(kAttrHotFactor) or 0)
							attrs[kAttrUnyieldFactor]:setBase(srcComp:getAttrBase(kAttrUnyieldFactor) or 0)
							attrs[kAttrFatalThreshold]:setBase(srcComp:getAttrBase(kAttrFatalThreshold) or 0)
							attrs[kAttrFatalFactor]:setBase(srcComp:getAttrBase(kAttrFatalFactor) or 0)
							attrs[kAttrSlayThreshold]:setBase(srcComp:getAttrBase(kAttrSlayThreshold) or 0)
							attrs[kAttrSlayFactor]:setBase(srcComp:getAttrBase(kAttrSlayFactor) or 0)
							attrs[kAttrExtraSkillRate]:setBase(srcComp:getAttrBase(kAttrExtraSkillRate) or 0)
							attrs[kAttrSpecialNum1]:setBase(srcComp:getAttrBase(kAttrSpecialNum1) or 0)
							attrs[kAttrSpecialNum2]:setBase(srcComp:getAttrBase(kAttrSpecialNum2) or 0)
							attrs[kAttrSpecialNum3]:setBase(srcComp:getAttrBase(kAttrSpecialNum3) or 0)
							attrs[kAttrAOEDerate]:setBase(srcComp:getAttrBase(kAttrAOEDerate) or 0)
						end
					end
				end
			end
		end
	end
end
