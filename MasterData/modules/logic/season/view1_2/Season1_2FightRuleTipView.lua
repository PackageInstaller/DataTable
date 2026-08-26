-- chunkname: @modules/logic/season/view1_2/Season1_2FightRuleTipView.lua

module("modules.logic.season.view1_2.Season1_2FightRuleTipView", package.seeall)

local Season1_2FightRuleTipView = class("Season1_2FightRuleTipView", BaseView)

function Season1_2FightRuleTipView:onInitView()
	self._btnClose1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close1")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close2")
	self._goLabel = gohelper.findChild(self.viewGO, "root/top/#btn_label")
	self._goCard = gohelper.findChild(self.viewGO, "root/top/#btn_card")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_rightbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_2FightRuleTipView:addEvents()
	self._btnClose1:AddClickListener(self._btncloseOnClick, self)
	self._btnClose2:AddClickListener(self._btncloseOnClick, self)
end

function Season1_2FightRuleTipView:removeEvents()
	self._btnClose1:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function Season1_2FightRuleTipView:_editableInitView()
	self.labelTab = self:createTab(self._goLabel, Activity104Enum.RuleTab.Rule)
	self.cardTab = self:createTab(self._goCard, Activity104Enum.RuleTab.Card)

	self._simageleftbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light2.png"))
	self._simagerightbg:LoadImage(ResUrl.getSeasonIcon("img_bg_light1.png"))
end

function Season1_2FightRuleTipView:_btncloseOnClick()
	self:_closeView()
end

function Season1_2FightRuleTipView:_closeView()
	self:closeThis()
end

function Season1_2FightRuleTipView:onOpen()
	self._ruleList = Season1_2FightRuleView.getRuleList()
	self._cardList = Activity104Model.instance:getFightCardDataList()

	if #self._ruleList > 0 then
		self:switchTab(Activity104Enum.RuleTab.Rule)
	else
		self:switchTab(Activity104Enum.RuleTab.Card)
	end
end

function Season1_2FightRuleTipView:createTab(go, tabType)
	local item = self:getUserDataTb_()

	item.go = go
	item.tabType = tabType
	item.goUnSelect = gohelper.findChild(go, "unselect")
	item.goSelect = gohelper.findChild(go, "selected")
	item.btn = gohelper.findButtonWithAudio(go)

	item.btn:AddClickListener(self.onClickTab, self, item)

	return item
end

function Season1_2FightRuleTipView:updateTab(tab, active, tabNum)
	if active then
		local select = self.tabType == tab.tabType

		gohelper.setActive(tab.go, true)
		gohelper.setActive(tab.goSelect, select)
		gohelper.setActive(tab.goUnSelect, not select)
	else
		gohelper.setActive(tab.go, false)
	end
end

function Season1_2FightRuleTipView:destroyTab(item)
	if item then
		item.btn:RemoveClickListener()
	end
end

function Season1_2FightRuleTipView:onClickTab(item)
	if not item then
		return
	end

	self:switchTab(item.tabType)
end

function Season1_2FightRuleTipView:switchTab(type)
	if self.tabType == type then
		return
	end

	self.tabType = type

	local labelActive = self:getTabActive(self.labelTab.tabType)
	local cardActive = self:getTabActive(self.cardTab.tabType)
	local tabNum = 0

	if labelActive then
		tabNum = tabNum + 1
	end

	if cardActive then
		tabNum = tabNum + 1
	end

	self:updateTab(self.labelTab, labelActive, tabNum)
	self:updateTab(self.cardTab, cardActive, tabNum)
	self.viewContainer:switchTab(type)
end

function Season1_2FightRuleTipView:getTabActive(tabType)
	if tabType == Activity104Enum.RuleTab.Card then
		return self._cardList and #self._cardList > 0
	end

	return self._ruleList and #self._ruleList > 0
end

function Season1_2FightRuleTipView:onClose()
	return
end

function Season1_2FightRuleTipView:onDestroyView()
	self:destroyTab(self.labelTab)
	self:destroyTab(self.cardTab)
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return Season1_2FightRuleTipView
