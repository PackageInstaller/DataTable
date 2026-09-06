-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTowerFormTabView.lua

module("logic.extensions.mangtower.view.MangTowerFormTabView", package.seeall)

local MangTowerFormTabView = class("MangTowerFormTabView", ViewComponent)

function MangTowerFormTabView:unbindEvents()
	MangTowerFormTabView.super.unbindEvents(self)

	local btn

	for k, v in ipairs(self._tabs) do
		Framework.ButtonAdapter.Get(v):RemoveClickListener()
	end

	if self._nextFormBtn then
		self._nextFormBtn:RemoveClickListener()
	end
end

function MangTowerFormTabView:bindEvents()
	MangTowerFormTabView.super.bindEvents(self)

	local btn

	for k, v in ipairs(self._tabs) do
		Framework.ButtonAdapter.Get(v):AddClickListener(function()
			self:_onClickTab(k)
		end)
	end

	if self._nextFormBtn then
		self._nextFormBtn:AddClickListener(self._onClickNextForm, self)
	end
end

function MangTowerFormTabView:buildUI()
	MangTowerFormTabView.super.buildUI(self)

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

function MangTowerFormTabView:onExit()
	MangTowerFormTabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onClickTab, self)
end

function MangTowerFormTabView:onEnter()
	MangTowerFormTabView.super.onEnter(self)

	local curTab = MangTowerModel.instance:getSelectFmtTab()

	self:_onClickTab(curTab, true)
	goutil.setActive(self._goTabs, true)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onClickTab, self)
end

function MangTowerFormTabView:_onClickTab(idx, isForce)
	if MangTowerController.instance:getCanClickNext() then
		local curTab = MangTowerModel.instance:getSelectFmtTab()

		if isForce or curTab ~= idx then
			MangTowerModel.instance:setSelectFmtTab(idx)
			self:_updateTabs()
			GlobalDispatcher:dispatch(GlobalNotify.CurFormTabChange)
		end
	else
		TipsFacade.instance:openCommonTips(lang("一键布阵中，请稍等"))
	end
end

function MangTowerFormTabView:_updateTabs()
	local curTab = MangTowerModel.instance:getSelectFmtTab()

	print("update curTab = " .. curTab)

	if self._nextFormBtn then
		goutil.setActive(self._nextFormBtn.gameObject, curTab ~= 3)
	end

	for k, v in ipairs(self._tabs) do
		local uiChangeGroup = v:GetComponent(typeof(UIChangeGroup))

		uiChangeGroup:SetState(k == curTab and 1 or 0)
	end

	self:_updateRedPoints()
end

function MangTowerFormTabView:_onClickNextForm()
	local curTab = MangTowerModel.instance:getSelectFmtTab()

	if curTab < 3 then
		self:_onClickTab(curTab + 1)
	end
end

function MangTowerFormTabView:_onFormationChanged()
	self:_updateRedPoints()
end

function MangTowerFormTabView:_updateRedPoints()
	for k, v in ipairs(self._redPoints) do
		local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, k)

		goutil.setActive(v, MangTowerController.instance:checkEmptyFmt(fmt) ~= 2)
	end
end

function MangTowerFormTabView:_maxPetNum()
	return MissionModel.instance:getMaxPetNum()
end

return MangTowerFormTabView
