-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/colorfullantern/config/ColorfulLanternConfig.lua

module("logic.extensions.colorfullantern.config.ColorfulLanternConfig", package.seeall)

local ColorfulLanternConfig = class("ColorfulLanternConfig", BaseConfig)

function ColorfulLanternConfig:onInit()
	ColorfulLanternConfig.super.onInit(self)

	self._flipTouchActivityCfg = nil
	self._flipTouchOutPrizeCfg = nil
	self._flipTouchInteractionCfg = nil
	self._flipTouchGlobalPrizeCfg = nil
end

function ColorfulLanternConfig:getNames()
	return {
		"colorful_lantern",
		"colorful_lantern_fragment",
		"colorful_lantern_score",
		"colorful_lantern_unlock",
		"colorful_lantern_intro",
		"colorful_lantern_master",
		"colorful_lantern_work"
	}
end

function ColorfulLanternConfig:handleConfig(name, content)
	if name == "colorful_lantern" then
		self._colorful_lantern = content
	elseif name == "colorful_lantern_fragment" then
		self._colorful_lantern_fragment = content
	elseif name == "colorful_lantern_score" then
		self._colorful_lantern_score = content
	elseif name == "colorful_lantern_unlock" then
		self._colorful_lantern_unlock = content
	elseif name == "colorful_lantern_intro" then
		self._colorful_lantern_intro = content
	elseif name == "colorful_lantern_master" then
		self._colorful_lantern_master = content
	elseif name == "colorful_lantern_work" then
		self._colorful_lantern_work = content
	end
end

function ColorfulLanternConfig:getActivityId()
	return self._colorful_lantern.dataList[1].activityId
end

function ColorfulLanternConfig:getFragmentPlanId()
	return self._colorful_lantern[self:getActivityId()].fragmentPlanId
end

function ColorfulLanternConfig:getScoreTipCfg()
	local fragmentCfg = self._colorful_lantern_fragment[self:getFragmentPlanId()]
	local scoreCfg = self._colorful_lantern_score[self:getFragmentPlanId()]

	return scoreCfg[1].dailyActivity, scoreCfg[1].score, fragmentCfg[1].costScore
end

function ColorfulLanternConfig:getFragmentCost(id)
	return self._colorful_lantern_fragment[self:getFragmentPlanId()][id].costScore
end

function ColorfulLanternConfig:getUnlockCfg()
	return self._colorful_lantern_unlock
end

function ColorfulLanternConfig:getIntroCfg()
	return self._colorful_lantern_intro
end

function ColorfulLanternConfig:getMasterWork()
	return self._colorful_lantern_master
end

function ColorfulLanternConfig:getDoneWork()
	return self._colorful_lantern_work
end

function ColorfulLanternConfig:getIntroPageCfg(pageId)
	return self._colorful_lantern_intro[pageId]
end

function ColorfulLanternConfig:getMaxIntroPage()
	return #self._colorful_lantern_intro
end

function ColorfulLanternConfig:getMaxWorkCount()
	return #self._colorful_lantern_work
end

function ColorfulLanternConfig:getWorkResName(idx)
	return self._colorful_lantern_work[idx].resName
end

ColorfulLanternConfig.instance = ColorfulLanternConfig.New()

return ColorfulLanternConfig
