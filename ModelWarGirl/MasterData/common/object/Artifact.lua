-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Artifact.lua

local ResArtifact = require("ClientData/ResArtifact")
local BaseObject = require("Common/Object/BaseObject")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResArtifactXP = require("ClientData/ResArtifactXP")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local HeroSkill = require("Common/Object/HeroSkill")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local strClassName = "Artifact"
local Artifact = Class(strClassName, BaseObject)

function Artifact:ctor(data)
	return
end

function Artifact:_initData()
	Artifact.super._initData(self)

	self.gid = self._serverData.gid or 0
	self.id = self._serverData.resid
	self.isLock = self._serverData.lock or Const.EQUIP_STATE_UNLOCK
	self.resData = ResArtifact[self.id]

	if self.resData then
		self.name = self.resData.name
		self.career = self.resData.career
		self.heroId = self.resData.hero_id
		self.quality = self.resData.quality or 1
		self.showQuality = self.resData.show_quality or self.quality
		self.mechanismType = self.resData.mechanism_type
		self.enhanceLevel = math.min(self._serverData.level or 0, self:getMaxEnhanceLv())
		self.enhanceExp = self._serverData.exp or 0
		self.breakLevel = math.min(self._serverData.break_level or 0, self:getMaxBreakLv())
		self.skillLevel = self:getSkillLevel()
		self.skill = HeroSkill(self.resData.passive_id, self.skillLevel, Const.HERO_SKILL_FIELD.ENTER_PASSIVE)
		self.rankScore = self.resData.base_rank + self.breakLevel + self.enhanceLevel
	else
		self.name = ""
		self.career = 1
		self.quality = 1
		self.showQuality = 1
		self.mechanismType = 1
		self.enhanceLevel = 0
		self.enhanceExp = 0
		self.breakLevel = 0
		self.skillLevel = 1
		self.rankScore = 0
	end

	self.itemType = Const.ITEM_TYPE_ARTIFACT
end

function Artifact:isArtifact()
	return true
end

function Artifact:getIconPath()
	if self.resData and self.resData.iconPath and self.resData.icon then
		return {
			UIConst.EQUIP_ICON_PATH .. self.resData.iconPath,
			self.resData.icon
		}
	end
end

function Artifact:getSkillLevel()
	if self.resData and ResArtifactXP[self.resData.templete_id] and ResArtifactXP[self.resData.templete_id][self.enhanceLevel] then
		return ResArtifactXP[self.resData.templete_id][self.enhanceLevel].skill_level
	else
		return 1
	end
end

function Artifact:getCareerIconPath()
	return UIConst.getHeroCareerIconPath(self.career)
end

function Artifact:getNewCareerIconPath()
	return UIConst.getNewHeroCareerIconPath(self.career)
end

function Artifact:getCareerBgIconPath()
	if self.resData.frame_path then
		return {
			"Atlas/" .. self.resData.frame_path,
			self.resData.frame_name
		}
	elseif self.showQuality <= 2 then
		return UIConst.ARTIFACT_CAREER_BG[Const.CAREER_TYPE.ALL][self.showQuality]
	else
		return UIConst.ARTIFACT_CAREER_BG[self.career][self.showQuality]
	end
end

function Artifact:getQualityPath()
	return UIConst.ARTIFACT_QUALITY_PATH[self.quality]
end

function Artifact:getStarPath()
	if self.breakLevel > 0 then
		return UIConst.ARTIFACT_STAR_PATH[self:getMaxBreakLv()][self.breakLevel]
	end
end

function Artifact:getStarBgPath()
	return UIConst.ARTIFACT_STAR_BG_PATH[self:getMaxBreakLv()]
end

function Artifact:getStarTxtPath()
	return {
		"Atlas/CommonAtlas/GridAtlas/GridBadgeAtlas",
		"BgLvNumbers" .. self.breakLevel
	}
end

function Artifact:getArtifactAttrs()
	local props = {}

	for propName, _ in pairs(BattleConst.ROLE_ATTRNAME_CONFIG) do
		if self.resData and self.resData[propName] then
			props[propName] = utils.getArtifactMainPropValue(self, propName)
		end
	end

	return props
end

function Artifact:getMaxBreakLv()
	local breakLv = 0
	local totalMaxBreak = Const.ARTIFACT_MAX_BREAK_LEVEL
	local maxEnhanceLv = self:getMaxEnhanceLv()

	for i = 0, totalMaxBreak do
		if maxEnhanceLv > ResArtifactLevelUp[i].limit_level then
			breakLv = i + 1
		end
	end

	return breakLv
end

function Artifact:getMaxEnhanceLv()
	if self.resData then
		return #ResArtifactXP[self.resData.templete_id]
	else
		return 1
	end
end

function Artifact:getMaxSkillLv()
	if self.resData then
		local maxEnhanceLv = self:getMaxEnhanceLv()
		local maxSkillUpLv = ResArtifactXP[self.resData.templete_id][maxEnhanceLv].skill_level
		local maxPassiveLv = #ResPassiveSkill[self.skill.id]

		return math.min(maxSkillUpLv, maxPassiveLv)
	else
		return 1
	end
end

function Artifact:canBeWear(hero)
	if self.resData then
		if self.heroId then
			return hero.id == self.heroId
		elseif self.career == Const.CAREER_TYPE.ALL then
			return true
		else
			return self.career == hero.career
		end
	end
end

function Artifact:getCurLimitLv()
	if ResArtifactLevelUp[self.breakLevel] then
		return ResArtifactLevelUp[self.breakLevel].limit_level
	else
		return 1
	end
end

return Artifact
