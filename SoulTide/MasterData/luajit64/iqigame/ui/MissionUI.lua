-- chunkname: @IQIGame\\UI\\MissionUI.lua

local MissionUI = Base:Extend("MissionUI", "IQIGame.Onigao.UI.MissionUI", {
	views = {},
	toggles = {}
})
local DailyActiveTaskView = require("IQIGame.UI.Mission.DailyActiveTask.DailyActiveTaskView")
local WeekActiveTaskView = require("IQIGame.UI.Mission.WeekActiveTask.WeekActiveTaskView")
local NormalTaskView = require("IQIGame.UI.Mission.NormalTask.NormalTaskView")

function MissionUI:OnInit()
	self:Initialize()
end

function MissionUI:GetPreloadAssetPaths()
	return nil
end

function MissionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MissionUI:OnOpen(userData)
	self:Refresh(userData)
end

function MissionUI:OnClose(userData)
	self:OnHide()
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseMissionUI")
end

function MissionUI:OnPause()
	return
end

function MissionUI:OnResume()
	return
end

function MissionUI:OnCover()
	return
end

function MissionUI:OnReveal()
	return
end

function MissionUI:OnRefocus(userData)
	return
end

function MissionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MissionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MissionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MissionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MissionUI:Initialize()
	self.views = {
		DailyActiveTaskView.New(self.goDailyActiveTaskView),
		WeekActiveTaskView.New(self.goWeekActiveTaskView),
		NormalTaskView.New(self.goNormalTaskView)
	}
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onTaskUpdateDelegate(id)
		self:OnTaskUpdate(id)
	end

	function self.onUnlockNotifyDelegate()
		self:OnOpenFunction()
	end

	function self.onJumpToOpenedUIDelegate(userData)
		self:OnJumpToOpenedUI(userData)
	end

	function self.onTaskCommitResponseDelegate(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	for i = 1, 3 do
		self.toggles[i] = self.goToggleParent.transform:Find("Toggle_" .. i):GetComponent("Toggle")
		self.toggles[i].transform:Find("goDown/Sort/Text_01"):GetComponent("Text").text = MissionUIApi:GetString("goToggleName", i)
		self.toggles[i].transform:Find("goUp/Sort/Text_01"):GetComponent("Text").text = MissionUIApi:GetString("goToggleName", i)
		self.toggles[i].transform:Find("goDown/Sort/Text_02"):GetComponent("Text").text = MissionUIApi:GetString("goToggleEngName", i)
		self.toggles[i].transform:Find("goUp/Sort/Text_02"):GetComponent("Text").text = MissionUIApi:GetString("goToggleEngName", i)
	end

	function self.onToggleDelegate(isOn)
		self:OnClickToggle(isOn)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = MissionUIApi:GetString("goBtnCloseTxt")
end

function MissionUI:Refresh(userData)
	self.curTabIndex = nil

	local tabIndex = userData

	self:RefreshDefaultToggle(tabIndex)
	self:RefreshRedPoint()
end

function MissionUI:OnHide()
	for i, v in pairs(self.views) do
		v:OnHide()
	end
end

function MissionUI:OnDestroy()
	for i, v in pairs(self.views) do
		v:OnDestroy()
	end
end

function MissionUI:OnAddListeners()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:AddListener(self.onToggleDelegate)
	end

	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.AddEventListener(EventID.UnlockFunction, self.onUnlockNotifyDelegate)
	EventDispatcher.AddEventListener(EventID.JumpToOpenedFunc, self.onJumpToOpenedUIDelegate)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function MissionUI:OnRemoveListeners()
	for i, v in pairs(self.toggles) do
		v.onValueChanged:RemoveListener(self.onToggleDelegate)
	end

	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.onTaskUpdateDelegate)
	EventDispatcher.RemoveEventListener(EventID.UnlockFunction, self.onUnlockNotifyDelegate)
	EventDispatcher.RemoveEventListener(EventID.JumpToOpenedFunc, self.onJumpToOpenedUIDelegate)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.onTaskCommitResponseDelegate)
end

function MissionUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.MissionUI)
end

function MissionUI:OnClickToggle(isOn)
	if isOn then
		for i, v in ipairs(self.toggles) do
			if v.isOn then
				self:ShowTab(i)

				return
			end
		end
	end
end

function MissionUI:OnOpenFunction()
	self.toggles[1].gameObject:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.DAILY_ACTIVE))
	self.toggles[2].gameObject:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.WEEK_ACTIVE))
	self.toggles[3].gameObject:SetActive(UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAIN_TASK))
end

function MissionUI:OnTaskUpdate(id)
	self.views[self.curTabIndex]:OnUpdateTask()
	self:RefreshRedPoint()
end

function MissionUI:OnJumpToOpenedUI(userData)
	if userData[1] == Constant.UIControllerName.MissionUI then
		self:Refresh(userData[2])
	end
end

function MissionUI:OnTaskCommitResponse(cids, rewards)
	if #rewards > 0 then
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, rewards)
	end
end

function MissionUI:RefreshDefaultToggle(tabIndex)
	self:OnOpenFunction()

	local isOnIndex

	if UnlockFunctionModule.IsUnlock(Constant.UnlockType.DAILY_ACTIVE) then
		isOnIndex = 1
	elseif UnlockFunctionModule.IsUnlock(Constant.UnlockType.WEEK_ACTIVE) then
		isOnIndex = 2
	elseif UnlockFunctionModule.IsUnlock(Constant.UnlockType.MAIN_TASK) then
		isOnIndex = 3
	end

	if tabIndex ~= nil then
		isOnIndex = tabIndex
	end

	for i, v in ipairs(self.toggles) do
		v.isOn = false

		if i == isOnIndex then
			v.isOn = true
		end
	end
end

function MissionUI:RefreshRedPoint()
	self.toggles[1].transform:Find("Tag").gameObject:SetActive(MissionModule.CheckRedPointOnActive())
	self.toggles[2].transform:Find("Tag").gameObject:SetActive(MissionModule.CheckRedPointOnWeekActive())
	self.toggles[3].transform:Find("Tag").gameObject:SetActive(MissionModule.CheckRedPointOnNormalTask())
end

function MissionUI:ShowTab(index)
	if self.curTabIndex == index then
		return
	end

	self.curTabIndex = index

	for i, v in ipairs(self.views) do
		if i == self.curTabIndex then
			v:Open()
		else
			v:Close()
		end
	end
end

return MissionUI
