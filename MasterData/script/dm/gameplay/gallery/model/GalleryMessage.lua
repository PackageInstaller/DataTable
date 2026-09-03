-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/gallery/model/GalleryMessage.lua

GalleryMessage = class("GalleryMessage", objectlua.Object, _M)

GalleryMessage:has("_id", {
	is = "rw"
})
GalleryMessage:has("_levelConfigId", {
	is = "rw"
})
GalleryMessage:has("_level", {
	is = "rw"
})
GalleryMessage:has("_curSPSkillId", {
	is = "rw"
})
GalleryMessage:has("_itemId", {
	is = "rw"
})
GalleryLegend:has("_effects", {
	is = "rw"
})

function GalleryMessage:initialize(id, owner)
	super.initialize(self)

	self._id = id
	self._config = ConfigReader:requireRecordById("InfoBase", id)
	self._levelConfigId = ""
	self._level = 0
	self._curSPSkillId = ""
	self._itemId = self._config.Item
	self._effects = {}
end

function GalleryMessage:sync(data)
	if data.levelConfigId then
		self._levelConfigId = data.levelConfigId
	end

	if data.level then
		self._level = data.level
	end

	if data.curSPSkillId then
		self._curSPSkillId = data.curSPSkillId
	end
end

function GalleryMessage:getName()
	return Strings:get(self._config.Name)
end

function GalleryMessage:getIcon()
	return self._config.Icon
end

function GalleryMessage:getBigPic()
	return "asset/scene/galleryMessage/" .. self._config.BigPic .. ".jpg"
end

function GalleryMessage:getSmallPic()
	return "asset/scene/galleryMessage/" .. self._config.SmallPic .. ".jpg"
end

function GalleryMessage:getSort()
	return self._config.Sort
end

function GalleryMessage:getItemId()
	return self._itemId
end

function GalleryMessage:getComposeNum()
	local Info_Compose = ConfigReader:requireRecordById("ConfigValue", "Info_Compose").content
	local Rareity = self._config.Rareity

	return Info_Compose[tostring(Rareity)]
end

function GalleryMessage:getMaxLevel()
	local LevelMax = ConfigReader:requireRecordById("ConfigValue", "Info_LevelMax").content
	local Rareity = self._config.Rareity

	return LevelMax[tostring(Rareity)]
end

function GalleryMessage:getSkillAttrList()
	local maxLevel = self:getMaxLevel()
	local Rareity = self._config.Rareity
	local info_SpecialLevel = ConfigReader:requireRecordById("ConfigValue", "Info_SpecialLevel").content[tostring(Rareity)]
	local skillAttrList = {}
	local normalSkill = self._config.Skill2
	local specialSkill = self._config.Skill3

	for level = 5, maxLevel, 5 do
		skillAttrList[level] = info_SpecialLevel[tostring(level)] and specialSkill[info_SpecialLevel[tostring(level)]] or normalSkill
	end

	return skillAttrList
end

function GalleryMessage:getNormalSkill()
	return self._config.Skill1
end

function GalleryMessage:getCosmetic()
	return self._config.Cosmetic
end

function GalleryMessage:getCurSkillIds()
	if self:getCosmetic() == 2 then
		local curSPSkillIds = {}

		if self._curSPSkillId ~= "" then
			local specialSkill = self:getSpecialSkill()

			for _, skillId in pairs(specialSkill) do
				table.insert(curSPSkillIds, skillId)

				if self._curSPSkillId == skillId then
					break
				end
			end
		end

		return curSPSkillIds
	else
		return self._curSPSkillId
	end
end

function GalleryMessage:getSpecialSkill()
	return self._config.Skill3
end

function GalleryMessage:getBaseQualityAttr()
	return self._config.BaseQualityAttr
end

function GalleryMessage:isMaxLevel()
	return self:getMaxLevel() == self._level
end

function GalleryMessage:getCost()
	local cost = {}
	local costIds = {}

	if self._levelConfigId ~= "" then
		if not self._levelConfigId then
			local levelConfigId = self._config.BaseQualityAttr
			local levelUpconfig = ConfigReader:requireRecordById("InfoBaseExp", levelConfigId)
			local cost2Id = ConfigReader:requireRecordById("ConfigValue", "Info_Mat").content
			local cost1Id = self._config.Item

			cost[cost1Id] = levelUpconfig.Info
			cost[cost2Id] = levelUpconfig.Info_M

			table.insert(costIds, cost1Id)
			table.insert(costIds, cost2Id)

			return cost, costIds
		end
	end
end
