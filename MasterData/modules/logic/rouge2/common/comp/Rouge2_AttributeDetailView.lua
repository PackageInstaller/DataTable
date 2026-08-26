-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttributeDetailView.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttributeDetailView", package.seeall)

local Rouge2_AttributeDetailView = class("Rouge2_AttributeDetailView", BaseView)

Rouge2_AttributeDetailView.PassiveSkillType = {
	Rouge2_Enum.PassiveSkillDescType.Career,
	Rouge2_Enum.PassiveSkillDescType.Fight,
	Rouge2_Enum.PassiveSkillDescType.Explore
}
Rouge2_AttributeDetailView.PercentColor = "#F3A055"
Rouge2_AttributeDetailView.BracketColor = "#5E7DD9"
Rouge2_AttributeDetailView.DelaySwtichTab = 0.16
Rouge2_AttributeDetailView.DefaultTabTypeList = {
	Rouge2_Enum.AttrDetailTabGroupType.SkillList,
	Rouge2_Enum.AttrDetailTabGroupType.Overview,
	Rouge2_Enum.AttrDetailTabGroupType.AttrList
}

function Rouge2_AttributeDetailView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._goTabCotent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content")
	self._goAttrTabItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_AttrTabItem")
	self._goGroupTabItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_GroupTabItem")
	self._goSkillTabItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_SkillTabItem")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._btnClose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close2")
	self._scrollAttrContent = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Content/#go_AttrContent")
	self._scrollBuffContent = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Content/#go_BuffContent")
	self._scrollSkillContent = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#go_Content/#go_SkillContent/#go_SkillScroll")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_AttributeDetailView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnClose2:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttributeDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function Rouge2_AttributeDetailView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_AttributeDetailView:_editableInitView()
	gohelper.setActive(self._goAttrTabItem, false)
	gohelper.setActive(self._goGroupTabItem, false)
	gohelper.setActive(self._goSkillTabItem, false)

	self._tabItemTab = self:getUserDataTb_()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function Rouge2_AttributeDetailView:onOpen()
	self._careerId = self.viewParam and self.viewParam.careerId
	self._careerCo = Rouge2_CareerConfig.instance:getCareerConfig(self._careerId)
	self._selectTabType = self.viewParam and self.viewParam.selectTabType

	self:initTabList()
	self:refreshTabItemList()
end

function Rouge2_AttributeDetailView:refreshTabItemList()
	self._attrInfoList = self.viewContainer:getAttrInfoList()

	for i, tabItem in ipairs(self._tabItemTab) do
		local groupType = self._showTabList[i]

		tabItem:onUpdateMO(self._careerId, self._attrInfoList, groupType, self)
	end

	self._selectTabType = self._selectTabType or self._showTabList[1]

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectAttrTab, self._selectTabType, 1)
end

function Rouge2_AttributeDetailView:initTabList()
	self._showTabList = self.viewParam and self.viewParam.showTabList
	self._showTabList = self._showTabList or Rouge2_AttributeDetailView.DefaultTabTypeList

	for _, tabType in ipairs(self._showTabList) do
		local goItem = gohelper.cloneInPlace(self._goGroupTabItem, "tab_" .. tabType)
		local tabItem = Rouge2_AttrDetailTabGroupBaseItem.Get(goItem, tabType)

		table.insert(self._tabItemTab, tabItem)
	end
end

function Rouge2_AttributeDetailView:_onSelectAttrTab()
	self._scrollAttrContent.verticalNormalizedPosition = 1
	self._scrollBuffContent.verticalNormalizedPosition = 1
	self._scrollSkillContent.verticalNormalizedPosition = 1
end

function Rouge2_AttributeDetailView:playSwitchAnim(callback, callbackObj)
	GameUtil.setActiveUIBlock(self.viewName, true, false)

	self._switchAnimCallback = callback
	self._switchAnimCallbackObj = callbackObj

	self._animator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self._delay2SwitchTab, self)
	TaskDispatcher.runDelay(self._delay2SwitchTab, self, Rouge2_AttributeDetailView.DelaySwtichTab)
end

function Rouge2_AttributeDetailView:_delay2SwitchTab()
	GameUtil.setActiveUIBlock(self.viewName, false, true)

	if self._switchAnimCallback then
		self._switchAnimCallback(self._switchAnimCallbackObj)
	end
end

function Rouge2_AttributeDetailView:onClose()
	self._switchAnimCallback = nil
	self._switchAnimCallbackObj = nil

	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

function Rouge2_AttributeDetailView:onDestroyView()
	return
end

return Rouge2_AttributeDetailView
