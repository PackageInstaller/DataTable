-- chunkname: @modules/logic/rouge2/map/view/skilldrop/Rouge2_ActiveSkillLevelUpView.lua

module("modules.logic.rouge2.map.view.skilldrop.Rouge2_ActiveSkillLevelUpView", package.seeall)

local Rouge2_ActiveSkillLevelUpView = class("Rouge2_ActiveSkillLevelUpView", BaseView)

function Rouge2_ActiveSkillLevelUpView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goToolbar = gohelper.findChild(self.viewGO, "#go_Toolbar")
	self._goTopLeft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goMode = gohelper.findChild(self.viewGO, "#go_Mode")
	self._goPreSkill = gohelper.findChild(self.viewGO, "#go_PreSkill")
	self._goCurSkill = gohelper.findChild(self.viewGO, "#go_CurSkill")
	self._goTeamTips = gohelper.findChild(self.viewGO, "#go_TeamTips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ActiveSkillLevelUpView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_ActiveSkillLevelUpView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_ActiveSkillLevelUpView:_btnCloseOnClick()
	self:playSwitchAnim()
end

function Rouge2_ActiveSkillLevelUpView:_editableInitView()
	local goPreSkill = self:getResInst(Rouge2_Enum.ResPath.CommonSkillItem, self._goPreSkill)
	local goCurSkill = self:getResInst(Rouge2_Enum.ResPath.CommonSkillItem, self._goCurSkill)

	self._preSkillItem = MonoHelper.addNoUpdateLuaComOnceToGo(goPreSkill, Rouge2_CommonSkillItem)
	self._curSkillItem = MonoHelper.addNoUpdateLuaComOnceToGo(goCurSkill, Rouge2_CommonSkillItem)

	self._preSkillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.SkillDrop)
	self._curSkillItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.SkillDrop)
	Rouge2_TeamRecommendTipsLoader.LoadWithParams(self._goTeamTips, Rouge2_Enum.TeamRecommendTipType.Single)
	Rouge2_CommonItemDescModeSwitcher.Load(self._goMode, Rouge2_Enum.ItemDescModeDataKey.SkillDrop)
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function Rouge2_ActiveSkillLevelUpView:onOpen()
	self:initViewParam()
	self:moveNext()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.LevelUpActiveSkill)
end

function Rouge2_ActiveSkillLevelUpView:onUpdateParam()
	self:initViewParam()
	self:moveNext()
end

function Rouge2_ActiveSkillLevelUpView:initViewParam()
	self._skillList = self.viewParam and self.viewParam.skillList

	if self._skillList then
		self._skillNum = #self._skillList or 0
	end

	self._curShowIndex = 0
end

function Rouge2_ActiveSkillLevelUpView:moveNext()
	local nextShowIndex = self._curShowIndex + 1

	if nextShowIndex > self._skillNum then
		self:closeThis()

		return
	end

	self:stopSwichAnim()
	self:moveNextParam()
	self:refreshUI()
end

function Rouge2_ActiveSkillLevelUpView:moveNextParam()
	self._curShowIndex = self._curShowIndex + 1

	if self._skillList then
		self._preDataType = self._skillList and self._skillList.preDataType
		self._preDataId = self._skillList and self._skillList.preDataId
		self._resultDataType = self._skillList and self._skillList.resultDataType
		self._resultDataId = self._skillList and self._skillList.resultDataId
	end
end

function Rouge2_ActiveSkillLevelUpView:refreshUI()
	self._preSkillItem:onUpdateMO(1, Rouge2_MapEnum.ItemDropViewEnum.Tips, self._preDataType, self._preDataId)
	self._curSkillItem:onUpdateMO(2, Rouge2_MapEnum.ItemDropViewEnum.LevelUp, self._resultDataType, self._resultDataId)
end

function Rouge2_ActiveSkillLevelUpView:playSwitchAnim()
	GameUtil.setActiveUIBlock(self.viewName, true, false)
	TaskDispatcher.cancelTask(self.moveNext, self)
	TaskDispatcher.runDelay(self.moveNext, self, 0.16)
	self._animator:Play("switch", 0, 0)
end

function Rouge2_ActiveSkillLevelUpView:onClose()
	self:stopSwichAnim()
end

function Rouge2_ActiveSkillLevelUpView:stopSwichAnim()
	TaskDispatcher.cancelTask(self.moveNext, self)
	GameUtil.setActiveUIBlock(self.viewName, false, true)
end

return Rouge2_ActiveSkillLevelUpView
