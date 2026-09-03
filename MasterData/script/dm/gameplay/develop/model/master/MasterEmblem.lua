-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/master/MasterEmblem.lua

MasterEmblem = class("MasterEmblem", objectlua.Object, _M)

MasterEmblem:has("_id", {
	is = "r"
})
MasterEmblem:has("_config", {
	is = "r"
})
MasterEmblem:has("_level", {
	is = "r"
})
MasterEmblem:has("_attribute", {
	is = "r"
})
MasterEmblem:has("_islock", {
	is = "r"
})
MasterEmblem:has("_curReforgeId", {
	is = "r"
})
MasterEmblem:has("_curReforgeLevel", {
	is = "r"
})
MasterEmblem:has("_owner", {
	is = "rw"
})

local kQualityName = {
	Strings:get("MasterEmblem_QualityName1"),
	Strings:get("MasterEmblem_QualityName2"),
	Strings:get("MasterEmblem_QualityName3"),
	Strings:get("MasterEmblem_QualityName4"),
	Strings:get("MasterEmblem_QualityName5"),
	(Strings:get("MasterEmblem_QualityName6"))
}
local kQualityImgName = {
	"white.png",
	"green.png",
	"blue.png",
	"purple.png",
	"orange.png",
	"red.png"
}
local kIdImgName = {
	MasterEmblem_6 = "zhujue_img_cs_",
	MasterEmblem_10 = "zhujue_img_hy_",
	MasterEmblem_5 = "zhujue_img_lm_",
	MasterEmblem_8 = "zhujue_img_lh_",
	MasterEmblem_7 = "zhujue_img_gz_",
	MasterEmblem_2 = "zhujue_img_ry_",
	MasterEmblem_9 = "zhujue_img_ww_",
	MasterEmblem_1 = "zhujue_img_qb_",
	MasterEmblem_4 = "zhujue_img_yy_",
	MasterEmblem_3 = "zhujue_img_xs_"
}

function MasterEmblem:initialize(id, devsys)
	super.initialize(self)

	self._developSystem = devsys
	self._id = id
	self._config = ConfigReader:getRecordById("MasterEmblemBase", id)
	self._islock = true
	self._level = 0
	self._name = Strings:get(self._config.Name)
	self._quality = 1
	self._attribute = {}
end

function MasterEmblem:createAttrEffect(player)
	self._owner = player
	self._emblemAttrEffect = SkillAttrEffect:new(AttrSystemName.kMasterEmblem)

	self._emblemAttrEffect:setOwner(player, player)
end

function MasterEmblem:syncData(data)
	if data == nil then
		return
	end

	self._islock = false

	if data.quality then
		self._quality = data.quality
	end

	if data.qualityId then
		self._qualityId = data.qualityId
	end

	if data.id then
		self._id = data.id
	end

	if data.quality then
		self._showQuality = math.floor(data.quality / 10)
	end

	if data.level and self._level ~= data.level then
		self._level = data.level

		self:rCreateEmblemEffect()
	end
end

function MasterEmblem:rCreateEmblemEffect()
	if GameConfigs.closeMasterEmblemAttr then
		return
	end

	self._emblemAttrEffect:setOwner(self:getOwner(), self:getOwner())
end

function MasterEmblem:isCanLevelUp()
	return
end

function MasterEmblem:checkLeveUpCost()
	return self._developSystem:getCrystal() > self:getLevelCurrencyCost()
end

function MasterEmblem:isCanUpQuality()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	if qualityconfig.NextQuality == nil or qualityconfig.NextQuality == "" then
		return false
	end

	if self._owner:getLevel() >= qualityconfig.LevelLimit and self._level == qualityconfig.Level then
		return true
	end

	return false
end

function MasterEmblem:checkLevelMax()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local maxLv = qualityconfig.Level

	return maxLv <= self._level
end

function MasterEmblem:checkQualityFull()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	if qualityconfig.NextQuality == nil or qualityconfig.NextQuality == "" then
		return true
	end

	return false
end

function MasterEmblem:checkPlayerLv()
	local ol = self._owner:getLevel()

	return ol <= self._level
end

function MasterEmblem:checkQualityUpCost()
	local currencyCondition = false
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	for k, v in pairs(qualityconfig.CurrencyCost) do
		local item = self._owner:getBag():getEntryById(v.id)

		if item and item.count >= v.amount then
			currencyCondition = true
		end
	end

	return currencyCondition
end

function MasterEmblem:checkUpQualityNeed()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local qualityCondition = false
	local currencyCondition = false

	for k, v in pairs(qualityconfig.ItemList) do
		local item = self._owner:getBag():getEntryById(v.id)

		if item and item.count >= v.amount then
			qualityCondition = true
		end
	end

	for k, v in pairs(qualityconfig.CurrencyCost) do
		local item = self._owner:getBag():getEntryById(v.id)

		if item and item.count >= v.amount then
			currencyCondition = true
		end
	end

	return currencyCondition and qualityCondition
end

function MasterEmblem:getQualityCurrencyCost()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	if qualityconfig.CurrencyCost and qualityconfig.CurrencyCost[1] then
		return qualityconfig.CurrencyCost[1].amount
	end
end

function MasterEmblem:getLevelCurrencyCost()
	local levelconfig = ConfigReader:getRecordById("MasterEmblemBase", self._id)

	return levelconfig.Cost.amount[self._level]
end

function MasterEmblem:getUpQualityNeed()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	return qualityconfig.ItemList
end

function MasterEmblem:getQuality()
	return
end

function MasterEmblem:getLevelUpCost()
	local costConfig = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Emblem_LevelUpCost", "content")

	if not costConfig[self._level + 1] then
		local costValue = costConfig[#costConfig]

		return costValue * self._config.ConsumeRate
	end
end

function MasterEmblem:getAttName(attrType)
	local attrArr = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")

	return Strings:get(attrArr[attrType])
end

function MasterEmblem:getAttList(level, reforgeId)
	return
end

function MasterEmblem:getUnlockLevel()
	return self._config.UnlockLevel
end

function MasterEmblem:getEmblemQualityGrowUpAttr()
	local curAttr = {}
	local nextAttr = {}
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local curinfo = qualityconfig.EquipAttr

	for k, v in pairs(curinfo) do
		local order = AttOrder[k]
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * (self._level - 1)

		value = self:getShowValue(k, value)
		curAttr[#curAttr + 1] = {
			name = name,
			value = value,
			order = order,
			att = k
		}
	end

	table.sort(curAttr, function(a, b)
		return self:compare(a, b)
	end)

	local nextid = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", self._qualityId, "NextQuality")
	local nextqualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", nextid)

	if nextqualityconfig == nil then
		return curAttr, nextAttr
	end

	local nextinfo = nextqualityconfig.EquipAttr

	for k, v in pairs(nextinfo) do
		local order = AttOrder[k]
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * (self._level - 1)

		value = self:getShowValue(k, value)
		nextAttr[#nextAttr + 1] = {
			name = name,
			value = value,
			order = order,
			att = k
		}
	end

	table.sort(nextAttr, function(a, b)
		return self:compare(a, b)
	end)

	return curAttr, nextAttr
end

function MasterEmblem:getEmblemLevelGrowUpAttr()
	local curAttr = {}
	local nextAttr = {}
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local curinfo = qualityconfig.EquipAttr
	local nextinfo = qualityconfig.EquipAttr

	for k, v in pairs(curinfo) do
		local order = AttOrder[k]
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * (self._level - 1)

		value = self:getShowValue(k, value)
		curAttr[#curAttr + 1] = {
			name = name,
			value = value,
			order = order,
			att = k
		}
	end

	for k, v in pairs(nextinfo) do
		local order = AttOrder[k]
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * self._level

		value = self:getShowValue(k, value)
		nextAttr[#nextAttr + 1] = {
			name = name,
			value = value,
			order = order,
			att = k
		}
	end

	table.sort(curAttr, function(a, b)
		return self:compare(a, b)
	end)
	table.sort(nextAttr, function(a, b)
		return self:compare(a, b)
	end)

	return curAttr, nextAttr
end

function MasterEmblem:getShowValue(k, value)
	if AttributeCategory:getAttNameAttend(k) == "" then
		return math.round(value)
	else
		return value * 100 - 0 .. "%"
	end
end

function MasterEmblem:compare(a, b)
	return a.order < b.order
end

function MasterEmblem:getEmblemQualityGrowUpAttrById(qualityid)
	local curAttr = {}
	local nextAttr = {}
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", qualityid)
	local nextid = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", qualityid, "NextQuality")
	local nextqualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", nextid)
	local curinfo = qualityconfig.EquipAttr
	local nextinfo = nextqualityconfig.EquipAttr

	for k, v in pairs(curinfo) do
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * (self._level - 1)

		curAttr[k] = self:getShowValue(k, value)
	end

	for k, v in pairs(nextinfo) do
		local name = self:getAttrNameZh(k)
		local value = v[1] + v[2] * (self._level - 1)

		nextAttr[k] = self:getShowValue(k, value)
	end

	return curAttr, nextAttr
end

function MasterEmblem:getName(id)
	return kQualityName[id]
end

function MasterEmblem:getImgName(quality)
	quality = quality or self._showQuality

	return kIdImgName[self._id] .. kQualityImgName[quality]
end

function MasterEmblem:getNextQualityImgName()
	local nextid = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", self._qualityId, "NextQuality")
	local nextqualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", nextid)

	return kIdImgName[self._id] .. (kQualityImgName[nextqualityconfig.QualityColor] or kQualityImgName[self._showQuality])
end

function MasterEmblem:getQualityName()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	if qualityconfig.QualityLevel == 0 then
		return kQualityName[self._showQuality]
	else
		return kQualityName[self._showQuality] .. "+" .. qualityconfig.QualityLevel
	end
end

function MasterEmblem:getLastQuailtyName()
	return kQualityName[self._showQuality - 1]
end

function MasterEmblem:getNextQualityName()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local nextid = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", self._qualityId, "NextQuality")
	local nextqualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", nextid)

	if qualityconfig.QualityColor == nextqualityconfig.QualityColor then
		return kQualityName[self._showQuality] .. "+" .. nextqualityconfig.QualityLevel, nextqualityconfig.QualityColor
	else
		return kQualityName[self._showQuality + 1], nextqualityconfig.QualityColor
	end
end

function MasterEmblem:getNextQualityCondition()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	return qualityconfig.QualityLimit
end

function MasterEmblem:getNextQualityDesc()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)

	return qualityconfig.LimitDesc
end

function MasterEmblem:getConfigDesc()
	return ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
end

function MasterEmblem:getNeedColorQuality()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local nextid = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", self._qualityId, "NextQuality")
	local nextqualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", nextid)

	if nextqualityconfig then
		if qualityconfig.QualityColor == nextqualityconfig.QualityColor then
			return false, qualityconfig.QualityLevel, nextqualityconfig.QualityLevel
		else
			return true, qualityconfig.QualityLevel, nextqualityconfig.QualityLevel
		end
	else
		return nil
	end
end

function MasterEmblem:getAttrNameZh(enKey)
	local namekeylist = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")

	return Strings:get(namekeylist[enKey])
end

function MasterEmblem:isEmblemMax()
	return
end

function MasterEmblem:getEmblemLevelQuickup()
	local num = self._developSystem:getCrystal()
	local levelconfig = ConfigReader:getRecordById("MasterEmblemBase", self._id)
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._qualityId)
	local maxLv = qualityconfig.Level
	local level = self._level

	for i = self._level, maxLv do
		local levelcost = levelconfig.Cost.amount[self._level]

		if levelcost <= num then
			level = i + 1
			num = num - levelcost
		else
			break
		end
	end

	if maxLv < level then
		level = maxLv
	end

	return level
end
