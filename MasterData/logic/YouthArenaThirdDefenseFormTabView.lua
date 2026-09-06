-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/view/YouthArenaThirdDefenseFormTabView.lua

module("logic.extensions.youtharenathird.view.YouthArenaThirdDefenseFormTabView", package.seeall)

local YouthArenaThirdDefenseFormTabView = class("YouthArenaThirdDefenseFormTabView", ViewComponent)

function YouthArenaThirdDefenseFormTabView:ctor()
	YouthArenaThirdDefenseFormTabView.super.ctor(self)
end

function YouthArenaThirdDefenseFormTabView:buildUI()
	YouthArenaThirdDefenseFormTabView.super.buildUI(self)

	self._startBtn = self:getBtn("BtnStart")
	self._nextFormBtn = self:getBtn("BtnNextForm")
	self._goTabs = self:getGo("tabs")
	self._tabs = {}

	for i = 1, 3 do
		table.insert(self._tabs, self:getGo("tabs/tab_" .. i))
	end

	self._redPoints = {}

	for _, v in ipairs(self._tabs) do
		table.insert(self._redPoints, goutil.findChild(v, "redPoint"))
	end
end

function YouthArenaThirdDefenseFormTabView:bindEvents()
	YouthArenaThirdDefenseFormTabView.super.bindEvents(self)

	for i, v in ipairs(self._tabs) do
		local btn = Framework.ButtonAdapter.Get(v)

		btn:AddClickListener(function()
			self:_onClickJumpOtherTab(i)
		end)
	end

	if self._nextFormBtn then
		self._nextFormBtn:AddClickListener(self._onClickNextForm, self)
	end
end

function YouthArenaThirdDefenseFormTabView:unbindEvents()
	YouthArenaThirdDefenseFormTabView.super.unbindEvents(self)

	for _, v in ipairs(self._tabs) do
		local btn = Framework.ButtonAdapter.Get(v)

		btn:RemoveClickListener()
	end

	if self._nextFormBtn then
		self._nextFormBtn:RemoveClickListener()
	end
end

function YouthArenaThirdDefenseFormTabView:onEnter()
	self.curTabIdx = -1
	self.customFmtMo = self:getFirstParam()

	YouthArenaThirdDefenseFormTabView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
	GlobalDispatcher:addListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)
	self:_refreshTabs()
	GameUtil.setAnchoredPos(self._goTabs, 0, -180)

	if self.customFmtMo and self.customFmtMo.tabPos then
		local pos = self.customFmtMo.tabPos

		GameUtil.setAnchoredPos(self._goTabs, pos.x, pos.y)
	end
end

function YouthArenaThirdDefenseFormTabView:onExit()
	YouthArenaThirdDefenseFormTabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onTabChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.ValidateCustomFormationUI, self._onValidateUI, self)

	self.customFmtMo = nil
end

function YouthArenaThirdDefenseFormTabView:_onTabChange()
	MissionModel.instance:setForceResetOneKey(true)
	self:_refreshTabs()
end

function YouthArenaThirdDefenseFormTabView:_refreshTabs()
	if self.customFmtMo == nil then
		return
	end

	local isShowTab = checkbool(self.customFmtMo.isShowTab)

	goutil.setActive(self._goTabs, isShowTab)

	if not isShowTab then
		self.curTabIdx = -1

		self:_refreshActionButtons()

		return
	end

	local curTab = self.customFmtMo:getCurFormTab()

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

function YouthArenaThirdDefenseFormTabView:_onValidateUI()
	self:_refreshActionButtons()
end

function YouthArenaThirdDefenseFormTabView:_refreshActionButtons()
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

function YouthArenaThirdDefenseFormTabView:_onClickJumpOtherTab(idx)
	if FastFormation.instance.isLocking then
		return
	end

	self.customFmtMo:jumpToTabIndex(idx)
end

function YouthArenaThirdDefenseFormTabView:_onClickNextForm()
	if FastFormation.instance.isLocking then
		return
	end

	self.customFmtMo:getNextTabIndex()
end

function YouthArenaThirdDefenseFormTabView:_onFormationChanged()
	self:_setCurCacheForm()
	self:_updateRedPoints()
end

function YouthArenaThirdDefenseFormTabView:_updateRedPoints()
	for _, v in ipairs(self._redPoints) do
		goutil.setActive(v, false)
	end
end

function YouthArenaThirdDefenseFormTabView:_setCurCacheForm()
	return
end

return YouthArenaThirdDefenseFormTabView
