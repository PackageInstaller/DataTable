-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonMedalGridShowView.lua

module("logic.extensions.season.view.SeasonMedalGridShowView", package.seeall)

local SeasonMedalGridShowView = class("SeasonMedalGridShowView", SeasonBaseGridShowView)

function SeasonMedalGridShowView:ctor()
	SeasonMedalGridShowView.super.ctor(self)
end

function SeasonMedalGridShowView:unbindEvents()
	SeasonMedalGridShowView.super.unbindEvents(self)
end

function SeasonMedalGridShowView:bindEvents()
	SeasonMedalGridShowView.super.bindEvents(self)
end

function SeasonMedalGridShowView:buildUI()
	SeasonMedalGridShowView.super.buildUI(self)

	self._txtNumber = self:getTxt("txtNumber")
	self._txtProgress = self:getTxt("txtProgress")
	self._medalIconChange = self:getGo("badge/icon"):GetComponent(typeof(UIImageSpriteChange))
	self._txtMedalName = self:getTxt("badge/txtName")
end

function SeasonMedalGridShowView:onExit()
	SeasonMedalGridShowView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonBadgeInfoUpdated, self._updateAll, self)
end

function SeasonMedalGridShowView:onEnter()
	SeasonMedalGridShowView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonBadgeInfoUpdated, self._updateAll, self)

	local params = self:getFirstParam()

	self._evtDetailConfig = params.evtDetailConfig

	self:_initInfo()

	self._txtProgress.text = ""

	SeasonMainCampController.instance:sendGetBudgeInfo()
end

function SeasonMedalGridShowView:_initInfo()
	local seasonId = SeasonModel.instance:getSeasonId()
	local res = SeasonMainCampConfig.instance:getBadgeAllAttributes(seasonId, self._evtDetailConfig.medalId)
	local medalConf = SeasonMainCampConfig.instance:getBadgeConfig(seasonId, self._evtDetailConfig.medalId)
	local strArray = SeasonMainCampController.instance:toAttrList(res)
	local str = ""

	for i, v in ipairs(strArray) do
		str = string.format("%s%s%s", str, i == 1 and "" or i % 2 == 1 and "\t" or "\n", v)
	end

	self._txtDesc.text = str
	self._txtNumber.text = string.format("%02d", self._evtDetailConfig.medalId)
	self._txtMedalName.text = medalConf.name

	self._medalIconChange:ChangeSprite(medalConf.icon)
end

function SeasonMedalGridShowView:_updateAll()
	local seasonId = SeasonModel.instance:getSeasonId()
	local configs = SeasonMainCampConfig.instance:getBadgeConfigs(seasonId) or {}

	self._txtProgress.text = langPara("收集进度：%d/%d", SeasonBadgeModel.instance:getActiveBadgeNum(), table.nums(configs))
end

return SeasonMedalGridShowView
