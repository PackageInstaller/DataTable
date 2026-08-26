-- chunkname: @modules/logic/gm/view/GMHelpViewBrowseItem.lua

module("modules.logic.gm.view.GMHelpViewBrowseItem", package.seeall)

local GMHelpViewBrowseItem = class("GMHelpViewBrowseItem", ListScrollCell)

function GMHelpViewBrowseItem:init(go)
	self._guideCO = nil
	self._txtPageId = gohelper.findChildText(go, "txtPageID")
	self._txtPageName = gohelper.findChildText(go, "txtPageName")
	self._btnShow = gohelper.findChildButtonWithAudio(go, "btnShow")

	self._btnShow:AddClickListener(self._onClickShow, self)
end

function GMHelpViewBrowseItem:onUpdateMO(config)
	self._pageCO = config
	self._configId = config.id
	self._txtPageId.text = self._configId
	self._txtPageName.text = self._pageCO.icon
end

function GMHelpViewBrowseItem:_onClickShow()
	local currentTabMode = GMHelpViewBrowseModel.instance:getCurrentTabMode()
	local tabModeEnum = GMHelpViewBrowseModel.tabModeEnum

	if currentTabMode == tabModeEnum.helpView then
		ViewMgr.instance:openView(ViewName.HelpView, {
			pageId = self._configId
		})
	elseif currentTabMode == tabModeEnum.fightGuideView then
		ViewMgr.instance:openView(ViewName.FightGuideView, {
			viewParam = {
				self._configId
			}
		})
	elseif currentTabMode == tabModeEnum.fightTechniqueView then
		ViewMgr.instance:openView(ViewName.FightTechniqueView, {
			isGMShowAll = true,
			defaultShowId = self._configId
		})
	elseif currentTabMode == tabModeEnum.fightTechniqueTipView then
		local CO = lua_fight_technique.configDict[self._configId]

		ViewMgr.instance:openView(ViewName.FightTechniqueTipsView, {
			isGMShow = true,
			config = CO
		})
	elseif currentTabMode == tabModeEnum.weekWalkRuleView then
		WeekWalkController.instance:openWeekWalkRuleView({
			issueId = self._configId
		})
	else
		logError("GMHelpViewBrowseItem:_onClickShow错误，tabMode对应处理未定义：" .. currentTabMode)

		return
	end
end

function GMHelpViewBrowseItem:onDestroy()
	self._btnShow:RemoveClickListener()
end

return GMHelpViewBrowseItem
