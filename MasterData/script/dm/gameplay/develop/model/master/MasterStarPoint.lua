-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterStarPoint.lua

MasterStarPoint = class("MasterStarPoint", objectlua.Object, _M)

MasterStarPoint:has("_config", {
	is = "r"
})
MasterStarPoint:has("_state", {
	is = "rw"
})

local AttrIcon = {
	ATK = {
		"zhujue_bg_shuxing_1.png",
		"zhujue_bg_shuxing_1.png"
	},
	DEF = {
		"zhujue_bg_shuxing_2.png",
		"zhujue_bg_shuxing_2.png"
	},
	HP = {
		"zhujue_bg_shuxing_3.png",
		"zhujue_bg_shuxing_3.png"
	}
}

function MasterStarPoint:initialize(id)
	super.initialize(self)

	self._state = 1
	self._config = ConfigReader:getRecordById("MasterStarPoint", id)
end

function MasterStarPoint:getId()
	return self._config.Id
end

function MasterStarPoint:getCoordinates()
	return self._config.Coordinates
end

function MasterStarPoint:getItemPay()
	return self._config.ItemPay
end

function MasterStarPoint:getCrystalPay()
	return self._config.CrystalPay
end

function MasterStarPoint:getAttrEffect()
	return self._config.AttrEffect
end

function MasterStarPoint:getAttrIcon()
	local config = ConfigReader:requireRecordById("SkillAttrEffect", tostring(self:getAttrEffect()))

	if self._state == 2 then
		if not AttrIcon[config.AttrType[1]][2] then
			local iconName = AttrIcon[config.AttrType[1]][1]

			return iconName or "zhujue_bg_tuan_2.png"
		end
	end
end

function MasterStarPoint:getAttrNum(index)
	index = index or 1

	local config = ConfigReader:requireRecordById("SkillAttrEffect", tostring(self:getAttrEffect()))

	return config.Value[index] or 0
end

function MasterStarPoint:getAttrType()
	local config = ConfigReader:requireRecordById("SkillAttrEffect", tostring(self:getAttrEffect()))

	return config.AttrType[1] or ""
end

function MasterStarPoint:getShowValue()
	local num = self:getAttrNum()
	local attrType = self:getAttrType()

	if AttributeCategory:getAttNameAttend(attrType) == "" then
		return math.round(num)
	else
		return string.format("%.1f%%", num * 100)
	end
end

function MasterStarPoint:getAttrTypeArray()
	local config = ConfigReader:requireRecordById("SkillAttrEffect", tostring(self:getAttrEffect()))

	return config.AttrType
end

function MasterStarPoint:getShowValueByType(index)
	index = index or 1

	local num = self:getAttrNum(index)
	local attrTypeArr = self:getAttrTypeArray()
	local attrType = attrTypeArr[index]

	if AttributeCategory:getAttNameAttend(attrType) == "" then
		return math.round(num)
	else
		return string.format("%.1f%%", num * 100)
	end
end

function MasterStarPoint:getAttrNumArray()
	local config = ConfigReader:requireRecordById("SkillAttrEffect", tostring(self:getAttrEffect()))

	return config.Value
end
