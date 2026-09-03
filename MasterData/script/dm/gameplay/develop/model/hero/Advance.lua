-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/Advance.lua

require("dm.gameplay.develop.model.effect.SingleAttrAddEffect")
require("dm.gameplay.develop.model.effect.RangeAttrAddEffect")
require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

Advance = class("Advance", objectlua.Object, _M)

Advance:has("_owner", {
	is = "rw"
})
Advance:has("_config", {
	is = "rw"
})
Advance:has("_id", {
	is = "rw"
})
Advance:has("_showList", {
	is = "rw"
})

function Advance:initialize(id, innerLevelIndex, owner)
	super.initialize(self)

	self._id = id
	self._innerLevelIndex = innerLevelIndex
	self._config = ConfigReader:getRecordById("HeroInnerAttrBase", tostring(id))
	self._showList = {}
	self._innerLevel = 0
	self._innerList = {}
	self._innerIndex = 0
end

function Advance:createAttrEffect(owner, player)
	self._effect = SkillAttrEffect:new(AttrSystemName.kHeroAdvance)

	self._effect:setOwner(owner, player)
end

function Advance:refreshEffect()
	self._effect:removeEffect()
	self:rCreateEffect()
end

function Advance:rCreateEffect()
	if GameConfigs.closeHeroRelationAttr then
		return
	end

	local effects = self:getCurAttrEffects()

	self._effect:refreshEffects(effects, self._level)
	self._effect:rCreateEffect()
end

function Advance:synchronize(innerJigsawIndex, innerLevel, baseInnerList)
	self._showList = {}

	local list = self:getAttr()

	for i = 1, #list do
		self._showList[#self._showList + 1] = {
			desc = self:getAttrDesc(list[i])[1],
			attrNum = self:getAttrDesc(list[i])[2],
			unlockStatus = i <= innerJigsawIndex
		}
	end

	self._innerLevel = innerLevel
	self._innerList = baseInnerList
	self._innerIndex = innerJigsawIndex

	self:refreshEffect()
end

function Advance:getMaxLevel()
	return #self._config.InnerAttrBaseLevel
end

function Advance:getCost()
	local cost = {}

	cost[1] = self._config.CostGold
	cost[2] = self._config.CostItem

	return cost
end

function Advance:getAttr()
	return self._config.InnerAttrBaseLevel
end

function Advance:getAttrEffects()
	local effectId = {}

	for i = 1, #self._innerList do
		if self._innerLevel ~= 0 and i <= self._innerLevel then
			local config = ConfigReader:getRecordById("HeroInnerAttrBase", self._innerList[i])

			for index = 1, #config.InnerAttrBaseLevel do
				effectId[#effectId + 1] = config.InnerAttrBaseLevel[index]
			end
		elseif self._innerLevel + 1 == i then
			local config = ConfigReader:getRecordById("HeroInnerAttrBase", self._innerList[i])

			if config then
				for index = 1, self._innerIndex do
					effectId[#effectId + 1] = config.InnerAttrBaseLevel[index]
				end
			end
		end
	end

	return effectId
end

function Advance:getCurAttrEffects()
	local effectId = {}

	if self._innerLevelIndex <= self._innerLevel then
		local config = ConfigReader:getRecordById("HeroInnerAttrBase", self._innerList[self._innerLevelIndex])

		if config then
			for index = 1, #config.InnerAttrBaseLevel do
				effectId[#effectId + 1] = config.InnerAttrBaseLevel[index]
			end
		end
	elseif self._innerLevelIndex == self._innerLevel + 1 then
		local config = ConfigReader:getRecordById("HeroInnerAttrBase", self._innerList[self._innerLevelIndex])

		if config then
			for index = 1, self._innerIndex do
				effectId[#effectId + 1] = config.InnerAttrBaseLevel[index]
			end
		end
	end

	return effectId
end

function Advance:getAttrDesc(effectId)
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local desc = AttributeCategory:getAttName(effectConfig.AttrType[1])
	local attrNum = SkillAttribute:getAddNumByConfig(effectConfig, 1, 0)

	if AttributeCategory:getAttNameAttend(effectConfig.AttrType[1]) ~= "" then
		attrNum = attrNum * 100 .. "%"
	end

	return {
		desc,
		attrNum
	}
end

function Advance:getShowAttrList()
	local attr = {}
	local effects = self:getAttrEffects()

	for i = 1, #effects do
		local descs = self:getAttrDesc(effects[i])
		local attrType = ConfigReader:getRecordById("SkillAttrEffect", effects[i]).AttrType[1]

		if not attr[attrType] then
			attr[attrType] = descs
		elseif type(descs[2]) == "number" then
			attr[attrType][2] = attr[attrType][2] + descs[2]
		end
	end

	return attr
end
