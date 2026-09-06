-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SeniorFormTabView.lua

module("logic.extensions.mission.view.SeniorFormTabView", package.seeall)

local SeniorFormTabView = class("SeniorFormTabView", ViewComponent)

function SeniorFormTabView:unbindEvents()
	SeniorFormTabView.super.unbindEvents(self)

	local btn

	for k, v in ipairs(self._tabs) do
		Framework.ButtonAdapter.Get(v):RemoveClickListener()
	end

	if self._nextFormBtn then
		self._nextFormBtn:RemoveClickListener()
	end
end

function SeniorFormTabView:bindEvents()
	SeniorFormTabView.super.bindEvents(self)

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

function SeniorFormTabView:buildUI()
	SeniorFormTabView.super.buildUI(self)

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

function SeniorFormTabView:onExit()
	SeniorFormTabView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:removeListener(GlobalNotify.ForceChangeCurFormTab, self._onClickTab, self)
end

function SeniorFormTabView:onEnter()
	SeniorFormTabView.super.onEnter(self)

	local curTab = SeniorArenaController.instance:getCurFormTab()

	self:_onClickTab(curTab, true)
	goutil.setActive(self._goTabs, true)
	GlobalDispatcher:addListener(GlobalNotify.FormationChangeFinish, self._onFormationChanged, self)
	GlobalDispatcher:addListener(GlobalNotify.ForceChangeCurFormTab, self._onClickTab, self)
end

function SeniorFormTabView:_onClickTab(idx, isForce)
	if SeniorArenaController.instance:getCanClickNext() then
		local curTab = SeniorArenaController.instance:getCurFormTab()

		if isForce or curTab ~= idx then
			SeniorArenaController.instance:setCurFormTab(idx)
			self:_updateTabs()
			GlobalDispatcher:dispatch(GlobalNotify.CurFormTabChange)
		end
	else
		TipsFacade.instance:openCommonTips(lang("一键布阵中，请稍等"))
	end
end

function SeniorFormTabView:_updateTabs()
	local curTab = SeniorArenaController.instance:getCurFormTab()

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

function SeniorFormTabView:_onClickNextForm()
	local curTab = SeniorArenaController.instance:getCurFormTab()

	if curTab < 3 then
		self:_onClickTab(curTab + 1)
	end
end

function SeniorFormTabView:_onFormationChanged()
	self:_setCurCacheForm()
	self:_updateRedPoints()
end

function SeniorFormTabView:_updateRedPoints()
	for k, v in ipairs(self._redPoints) do
		goutil.setActive(v, SeniorArenaController.instance:getCacheTabRedPointState(k) > 0)
	end
end

function SeniorFormTabView:_setCurCacheForm()
	local team = FormationNewModel.instance:GetCurTeam()
	local formInfo = team:GetCurFormation()
	local formId = team:GetCurFormationId()

	SeniorArenaController.instance:setCurCacheForm(formInfo, formId)
end

function SeniorFormTabView:_maxPetNum()
	return MissionModel.instance:getMaxPetNum()
end

return SeniorFormTabView
