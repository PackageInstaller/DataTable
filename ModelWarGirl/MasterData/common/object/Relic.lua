-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Relic.lua

local BaseObject = require("Common/Object/BaseObject")
local ResRelic = require("ClientData/ResRelic")
local ResRelicLevelUp = require("ClientData/ResRelicLevelUp")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local strClassName = "Relic"
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResRelicActionConfig = require("ClientData/ResRelicActionConfig")
local ResSeasonRelicOp = require("ClientData/ResSeasonRelicOp")
local ResSeasonRelicShow = require("ClientData/ResSeasonRelicShow")
local Relic = Class(strClassName, BaseObject)

function Relic:ctor(data)
	return
end

function Relic:_initData()
	Relic.super._initData(self)

	self.id = self._serverData.id or 0
	self.resData = ResRelic[self.id]

	if self.resData then
		self.campLimit = self.resData.camp_limit
		self.careerLimit = self.resData.career_limit
		self.qualityLimit = self.resData.quality_limit
		self.heroIdLimit = self.resData.resid_limit
		self.quality = self.resData.quality or 1
		self.maxLevel = self.resData.max_level or 0
		self.enhanceLevel = math.min(self._serverData.level or 0, self.maxLevel)
		self.name = self.resData.name or ""
		self.desc = self.resData.desc or ""
		self.wallPath = self.resData.wall_path or ""

		if self.resData.up_skill_id then
			self.enhanceSkillField = Const.SKILL_ID_FIELD_DIC[self.resData.up_skill_id]
		end

		if ResSeasonRelicOp[self.id] then
			self.isSeasonRelic = true
		end

		self.lvUpMaterialId = self.resData.level_up_material_id
		self.levelUpInfo = ResRelicLevelUp[self.quality]

		if ResRelicActionConfig[self.id] and ResRelicActionConfig[self.id][self.enhanceLevel] then
			self.actionConifg = ResRelicActionConfig[self.id][self.enhanceLevel]
		end
	else
		self.quality = 1
		self.maxLevel = 1
		self.enhanceLevel = 0
		self.name = ""
		self.desc = ""
	end

	self.itemType = Const.ITEM_TYPE_RELIC
end

function Relic:getSkillTypePath()
	if self.enhanceSkillField and UIConst.SKILL_TYPE_PATH[self.enhanceSkillField] then
		return UIConst.SKILL_TYPE_PATH[self.enhanceSkillField]
	end
end

function Relic:isCanBeWear(hero)
	if self.campLimit and self.campLimit ~= hero.camp then
		return false
	end

	if self.careerLimit and self.careerLimit ~= hero.career then
		return false
	end

	if self.qualityLimit and self.qualityLimit ~= hero.quality then
		return false
	end

	if self.heroIdLimit and self.heroIdLimit ~= hero.id then
		return false
	end

	if self.isSeasonRelic then
		return false
	end

	return true
end

function Relic:getRankScore(hero, ignoreLevel)
	local score = self.quality * 100

	if not ignoreLevel then
		score = score + self.enhanceLevel
	end

	if self.careerLimit and self.careerLimit == hero.career or self.heroIdLimit and self.heroIdLimit == hero.id then
		score = score + 10000
	end

	return score
end

function Relic:getIconPath()
	if self.resData and self.resData.icon_path and self.resData.icon_name then
		return {
			"Atlas/CommonAtlas/IconAtlas/" .. self.resData.icon_path,
			self.resData.icon_name
		}
	end
end

function Relic:getLvUpNeed()
	if self:checkIsSeaonRelic() then
		return
	end

	local materialInfo = {}

	if not self:isEnhanceLvMax() and self.levelUpInfo then
		local resLvInfo = self.levelUpInfo[self.enhanceLevel + 1]

		if resLvInfo then
			if resLvInfo.material_cost then
				materialInfo[self.lvUpMaterialId] = resLvInfo.material_cost
			end

			if self.resData.level_up_item_id and resLvInfo.item_cost then
				materialInfo[self.resData.level_up_item_id] = resLvInfo.item_cost
			elseif resLvInfo.cash_cost then
				materialInfo[Const.MONEY_ID_GOLD] = resLvInfo.cash_cost
			end

			return materialInfo
		end
	end
end

function Relic:getSeasonLvUpNeed()
	if ResSeasonRelicOp[self.id] and not self:isEnhanceLvMax() and ResSeasonRelicOp[self.id][Const.SEASON_RELIC_UPLEVEL] then
		local resLvInfo = ResSeasonRelicOp[self.id][Const.SEASON_RELIC_UPLEVEL][self.enhanceLevel + 1]

		if resLvInfo then
			return resLvInfo
		end
	end
end

function Relic:checkItemNeed(useData)
	if useData then
		local canUnLock = true

		for _, data in ipairs(useData.use) do
			if data.id and data.num then
				if data.num > CurAvatar:getItemNumById(data.id) then
					canUnLock = false
				end
			else
				canUnLock = false
			end
		end

		return canUnLock
	end

	return false
end

function Relic:seasonRelicCanLvUp()
	local lvUpResData = self:getSeasonLvUpNeed()

	if lvUpResData and lvUpResData.use then
		return self:checkItemNeed(lvUpResData)
	end

	return false
end

function Relic:seasonRelicCanUnLock()
	local unLockResData = self:getSeasonUnlockResData()

	if unLockResData and unLockResData.use then
		return self:checkItemNeed(unLockResData)
	end

	return false
end

function Relic:getRelicAttrs()
	local props = {}

	for _, info in ipairs(self.resData.props or {}) do
		local propName = BattleConst.PROP_TYPE_CONFIG[info.type]

		if propName and info.value then
			props[propName] = info.value
		end
	end

	return props
end

function Relic:getRelicAttrList()
	if self.resData.props then
		local props = {}

		for _, info in ipairs(self.resData.props or {}) do
			local propName = BattleConst.PROP_TYPE_CONFIG[info.type]
			local propInfo = {}

			propInfo.propName = propName
			propInfo.value = info.value

			table.insert(props, propInfo)
		end

		return props
	end
end

function Relic:getHeroHeadPath()
	if self.heroIdLimit then
		if utils.tableIsContainsElement(Const.ARTIFACT_RELIC_TIPSINFO_CHANGE_LIST, self.heroIdLimit) then
			return nil
		end

		local limitHero = BaseObject.GetObject(self.heroIdLimit)

		return limitHero:getQIconPath()
	end
end

function Relic:getHeroCampPath()
	if self.campLimit then
		return UIConst.getHeroCampIconPath(self.campLimit)
	end
end

function Relic:getHeroCareerPath()
	if self.careerLimit then
		return UIConst.getHeroCareerIconPath(self.careerLimit)
	else
		return UIConst.getHeroCareerIconPath(Const.CAREER_TYPE.ALL)
	end
end

function Relic:isEnhanceLvMax()
	return self.enhanceLevel >= self.maxLevel
end

function Relic:getQualityPath()
	if self.quality then
		return UIConst.RELIC_QUALITY_CONFIG[self.quality]
	end
end

function Relic:getPanelQualityPath()
	if self.quality then
		return UIConst.RELIC_PANEL_QUALITY_CONFIG[self.quality]
	end
end

function Relic:getBgQualityPath()
	if self.quality then
		return UIConst.RELIC_BG_QUALITY_CONFIG[self.quality]
	end
end

function Relic:getBgmIdByType(bgm_type)
	if self.actionConifg then
		if bgm_type == Const.RELIC_BGM_TYPE_HERO_DLG then
			return self.actionConifg.bgm_hero_dlg
		elseif bgm_type == Const.RELIC_BGM_TYPE_BATTLE then
			return self.actionConifg.bgm_battle
		elseif bgm_type == Const.RELIC_BGM_TYPE_VICTORY then
			return self.actionConifg.bgm_victory
		end
	end
end

function Relic:getActionByKey(key)
	if self.actionConifg then
		return self.actionConifg[key]
	end
end

function Relic:getPassiveInfo()
	if self.resData and self.resData.passive_id then
		local passiveLevel = 1

		if self.levelUpInfo and self.levelUpInfo[self.enhanceLevel] then
			passiveLevel = self.levelUpInfo[self.enhanceLevel].skill_level or 1
		end

		return self.resData.passive_id, passiveLevel
	end
end

function Relic:getPassiveResData()
	local passiveId, passiveLevel = self:getPassiveInfo()

	if ResPassiveSkill[passiveId] and ResPassiveSkill[passiveId][passiveLevel] then
		return ResPassiveSkill[passiveId][passiveLevel]
	end
end

function Relic:getSeasonLogoResData()
	if ResSeasonRelicShow and ResSeasonRelicShow[self.id] then
		return {
			ResSeasonRelicShow[self.id].season_logo_path,
			ResSeasonRelicShow[self.id].season_logo_icon
		}
	end
end

function Relic:checkIsSeaonRelic(...)
	if ResSeasonRelicShow and ResSeasonRelicShow[self.id] then
		return true
	end
end

function Relic:getSeasonUnlockResData()
	if ResSeasonRelicOp and ResSeasonRelicOp[self.id] then
		return ResSeasonRelicOp[self.id][Const.SEASON_RELIC_UNLOCK][1]
	end
end

return Relic
