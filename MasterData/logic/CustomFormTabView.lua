-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/customfmt/view/CustomFormTabView.lua

module("logic.extensions.customfmt.view.CustomFormTabView", package.seeall)

local CustomFormTabView = class("CustomFormTabView", ViewComponent)

function CustomFormTabView:unbindEvents()
	CustomFormTabView.super.unbindEvents(self)

	local btn

	for k, v in ipairs(self._tabs) do
		Framework.ButtonAdapter.Get(v):RemoveClickListener()
	end

	if self._nextFormBtn then
		self._nextFormBtn:RemoveClickListener()
	end
end

function CustomFormTabView:bindEvents()
	CustomFormTabView.super.bindEvents(self)

	local btn

	for i, v in ipairs(self._tabs) do
		Framework.ButtonAdapter.Get(v):AddClickListener(function()
			self:_onClickJumpOtherTab(i)
		end)
	end

	if self._nextFormBtn then
		self._nextFormBtn:AddClickListener(self._onClickNextForm, self)
	end
end

function CustomFormTabView:buildUI()
	CustomFormTabView.super.buildUI(self)

	self._startBtn = self:getBtn("BtnStart")
	self._nextFormBtn = self:getBtn("BtnNextForm")
	self._goTabs = self:getGo("tabs")
	self._tabs = {}

	for i = 1, 3 do
		local tab = self:getGo("tabs/tab_" .. i)

		table.insert(self._tabs, tab)
	end

	self._redPoints = {}

	for _, v in ipairs(self._tabs) do
		table.insert(self._redPoints, goutil.findChild(v, "redPoint"))
	end
end

function CustomFormTabView:onExit()
	CustomFormTabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)
end

function CustomFormTabView:onEnter()
	self.curTabIdx = -1
	self.customFmtMo = self:getFirstParam()

	CustomFormTabView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)
	goutil.setActive(self._goTabs, self.customFmtMo.isShowTab)

	if self.customFmtMo.isShowTab then
		local curTab = self.customFmtMo:getCurFormTab()

		self:_updateTabs(curTab)
		GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
		GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
	else
		self:_refreshActionButtons()
	end

	GameUtil.setAnchoredPos(self._goTabs, 0, -180)

	if self.customFmtMo.tabPos then
		local pos = self.customFmtMo.tabPos

		GameUtil.setAnchoredPos(self._goTabs, pos.x, pos.y)
	end
end

function CustomFormTabView:_onValidateUI()
	self:_refreshActionButtons()
end

function CustomFormTabView:_refreshActionButtons()
	if not self.customFmtMo then
		return
	end

	local isShowTab = checkbool(self.customFmtMo.isShowTab)

	if self._startBtn then
		goutil.setActive(self._startBtn.gameObject, self.customFmtMo:shouldShowStartButton())
	end

	if self._nextFormBtn then
		goutil.setActive(self._nextFormBtn.gameObject, isShowTab and not self.customFmtMo:checkIsLastTab())
	end
end

function CustomFormTabView:_onTabChange()
	MissionModel.instance:setForceResetOneKey(true)

	local curTab = self.customFmtMo:getCurFormTab()

	self:_updateTabs(curTab)
end

function CustomFormTabView:_onClickJumpOtherTab(idx)
	if FastFormation.instance.isLocking then
		return
	end

	self.customFmtMo:jumpToTabIndex(idx)
end

function CustomFormTabView:_updateTabs(curTab)
	if self.curTabIdx == curTab then
		return
	end

	self.curTabIdx = curTab

	self:_refreshActionButtons()

	for k, v in ipairs(self._tabs) do
		local uiChangeGroup = v:GetComponent(typeof(UIChangeGroup))

		uiChangeGroup:SetState(k == curTab and 1 or 0)
		GameUtil.SetActive(v, k <= self.customFmtMo.maxTabCount)
	end

	self:_updateRedPoints()
end

function CustomFormTabView:_onClickNextForm()
	if FastFormation.instance.isLocking then
		return
	end

	local curTab = self.customFmtMo:getNextTabIndex()
end

function CustomFormTabView:_onFormationChanged()
	self:_setCurCacheForm()
	self:_updateRedPoints()
end

function CustomFormTabView:_updateRedPoints()
	for k, v in ipairs(self._redPoints) do
		goutil.setActive(v, false)
	end
end

function CustomFormTabView:_setCurCacheForm()
	return
end

return CustomFormTabView
