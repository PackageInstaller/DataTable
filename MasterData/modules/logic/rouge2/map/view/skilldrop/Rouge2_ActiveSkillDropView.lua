-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillDropView.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillDropView", package.seeall)

local Rouge2_ActiveSkillDropView = class("Rouge2_ActiveSkillDropView", BaseView)

function Rouge2_ActiveSkillDropView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goSelectBG = gohelper.findChild(self.viewGO, "#go_SelectBG")
	self._goDropBG = gohelper.findChild(self.viewGO, "#go_DropBG")
	self._goLossBG = gohelper.findChild(self.viewGO, "#go_LossBG")
	self._goSelect = gohelper.findChild(self.viewGO, "Title/#go_Select")
	self._goDrop = gohelper.findChild(self.viewGO, "Title/#go_Drop")
	self._goLoss = gohelper.findChild(self.viewGO, "Title/#go_Loss")
	self._scrollSkill = gohelper.findChildScrollRect(self.viewGO, "#scroll_Skill")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/#go_Content")
	self._goSkillItem = gohelper.findChild(self.viewGO, "#scroll_Skill/Viewport/#go_Content/#go_SkillItem")
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Toolbar")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")
	self._goRefresh = gohelper.findChild(self.viewGO, "#go_Refresh")
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_TeamTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActiveSkillDropView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_ActiveSkillDropView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_ActiveSkillDropView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_ActiveSkillDropView:_editableInitView()
	self._goScrollSkill = self._scrollSkill.gameObject
	self._refreshLoader = Rouge2_ItemRefreshCompLoader.Get(self._goRefresh)

	self._refreshLoader:initRefreshCallback(self._onRefreshItemCallback, self)

	self._attrToolBar = Rouge2_AttributeToolBar.Load(self._goToolbar, Rouge2_Enum.AttributeToolType.Enter_Skill_Detail)

	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.SkillDrop)
	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Single)
end

function Rouge2_ActiveSkillDropView:onOpen()
	self:initViewParam()
	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.DropActiveSkill)
end

function Rouge2_ActiveSkillDropView:onUpdateParam()
	self:initViewParam()
	self:refreshUI()
end

function Rouge2_ActiveSkillDropView:onOpenFinish()
	self:tryTriggerActiveSkillGuide()
end

function Rouge2_ActiveSkillDropView:tryTriggerActiveSkillGuide()
	if self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		return
	end

	local isGuideFinish = GuideModel.instance:isGuideFinish(Rouge2_MapEnum.GuideId.ActiveSkill)

	if isGuideFinish then
		return
	end

	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.OnGuideGetActiveSkill)
end

function Rouge2_ActiveSkillDropView:initViewParam()
	self._viewEnum = self.viewParam and self.viewParam.viewEnum
	self._dataType = self.viewParam and self.viewParam.dataType

	if self.viewParam then
		self._skillList = self.viewParam.itemList or {}
	end

	if self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select then
		local selectSkillIndex = self:getFirstUnuseSkillIndex()

		self._attrToolBar:setParam(Rouge2_Enum.AttrToolParam.IsShowEmptySkill, true)
		self._attrToolBar:setParam(Rouge2_Enum.AttrToolParam.SelectSkillIndex, selectSkillIndex)
		NavigateMgr.instance:addEscape(self.viewName, Rouge2_MapHelper.blockEsc)
	end

	gohelper.setActive(self._goToolbar, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	self._refreshLoader:show(self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_ActiveSkillDropView:getFirstUnuseSkillIndex()
	local skillList = Rouge2_BackpackModel.instance:getItemList(Rouge2_Enum.BagType.ActiveSkill)

	if skillList then
		if not #skillList then
			local skillCount = 0

			return skillCount + 1
		end
	end
end

function Rouge2_ActiveSkillDropView:refreshUI()
	self:refreshTitle()
	self:refreshButton()
	self:refreshActiveSkillList()
end

function Rouge2_ActiveSkillDropView:refreshTitle()
	gohelper.setActive(self._goSelect, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDrop, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLoss, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
	gohelper.setActive(self._goSelectBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._goDropBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Drop)
	gohelper.setActive(self._goLossBG, self._viewEnum == Rouge2_MapEnum.ItemDropViewEnum.Loss)
end

function Rouge2_ActiveSkillDropView:refreshButton()
	gohelper.setActive(self._goTopLeft, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
	gohelper.setActive(self._btnClose.gameObject, self._viewEnum ~= Rouge2_MapEnum.ItemDropViewEnum.Select)
end

function Rouge2_ActiveSkillDropView:refreshActiveSkillList()
	gohelper.CreateObjList(self, self._refreshActiveSkill, self._skillList, self._goContent, self._goSkillItem, Rouge2_ActiveSkillDropItem)
end

function Rouge2_ActiveSkillDropView:_refreshActiveSkill(skillItem, skillId, index)
	skillItem:setParentView(self, self._goScrollSkill)
	skillItem:onUpdateMO(index, self._viewEnum, self._dataType, skillId)
end

function Rouge2_ActiveSkillDropView:_onRefreshItemCallback(dropList)
	self._skillList = dropList or {}

	self:refreshActiveSkillList()
end

function Rouge2_ActiveSkillDropView:onClose()
	if self._callback then
		Rouge2_Rpc.instance:removeCallbackById(self._callback)

		self._callback = nil
	end
end

return Rouge2_ActiveSkillDropView
