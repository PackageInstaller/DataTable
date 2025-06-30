-- chunkname: @IQIGame\\UI\\GlobalNoticeUI.lua

local RollNoticeElement = require("IQIGame/UI/GlobalNotice/RollNoticeElement")
local GlobalBuffNoticeElement = require("IQIGame/UI/GlobalNotice/GlobalBuffNoticeElement")
local GlobalNoticeUI = {
	__globalBuffNoticeLockCount = 0
}

GlobalNoticeUI = Base:Extend("GlobalNoticeUI", "IQIGame.Onigao.UI.GlobalNoticeUI", GlobalNoticeUI)

function GlobalNoticeUI:OnInit()
	self.rollNotice = RollNoticeElement.New(self.RollNoticeRoot)
	self.__globalBuffNoticeQueue = Queue.New()
	self.globalBuffNotice = GlobalBuffNoticeElement.New(self.GlobalBuffNoticeRoot)
end

function GlobalNoticeUI:GetPreloadAssetPaths()
	return nil
end

function GlobalNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GlobalNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function GlobalNoticeUI:GetBGM(userData)
	return nil
end

function GlobalNoticeUI:OnOpen(userData)
	self.rollNotice:Hide()
	self.globalBuffNotice:Hide()
end

function GlobalNoticeUI:OnClose(userData)
	self.rollNotice:Hide()
	self.globalBuffNotice:Hide()
end

function GlobalNoticeUI:OnAddListeners()
	EventUtil.AddEventListener(self, EventID.ShowRollNotice, self.__OnShowRollNotice)
	EventUtil.AddEventListener(self, EventID.NotifyGlobalBuffChange, self.__OnNotifyGlobalBuffChange)
	EventUtil.AddEventListener(self, EventID.AddGlobalBuffNoticeLock, self.__OnAddGlobalBuffNoticeLock)
	EventUtil.AddEventListener(self, EventID.RemoveGlobalBuffNoticeLock, self.__OnRemoveGlobalBuffNoticeLock)
end

function GlobalNoticeUI:OnRemoveListeners()
	EventUtil.ClearEventListener(self)
end

function GlobalNoticeUI:OnPause()
	return
end

function GlobalNoticeUI:OnResume()
	return
end

function GlobalNoticeUI:OnCover()
	return
end

function GlobalNoticeUI:OnReveal()
	return
end

function GlobalNoticeUI:OnRefocus(userData)
	return
end

function GlobalNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.rollNotice:OnUpdate(elapseSeconds, realElapseSeconds)
	self.globalBuffNotice:OnUpdate(elapseSeconds, realElapseSeconds)
end

function GlobalNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GlobalNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GlobalNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GlobalNoticeUI:OnDestroy()
	self:__StopRollNoticeCountDown()
	self.rollNotice:Dispose()
	self.__globalBuffNoticeQueue:Clear()
	self.globalBuffNotice:Dispose()
end

function GlobalNoticeUI:__OnShowRollNotice(chatPOD)
	self:__StopRollNoticeCountDown()
	self.rollNotice:Show(chatPOD, function()
		log("rollNotice Complete------->>")
	end)
	self:__StarRollNoticeCountDown()
end

function GlobalNoticeUI:__StarRollNoticeCountDown()
	self.__rollNoticeTimer = Timer.New(function()
		self.rollNotice:Replay()
	end, UIGlobalApi.GetRollNoticeReplayTime(), UIGlobalApi.GetRollNoticeReplayCount(), false)

	self.__rollNoticeTimer:Start()
end

function GlobalNoticeUI:__StopRollNoticeCountDown()
	if self.__rollNoticeTimer == nil then
		return
	end

	self.__rollNoticeTimer:Stop()

	self.__rollNoticeTimer = nil
end

function GlobalNoticeUI:__OnNotifyGlobalBuffChange(addBuffList, removeBuffList)
	ForArray(addBuffList, function(_, _buffCid)
		self.__globalBuffNoticeQueue:Enqueue(_buffCid)
	end)
	self:__OnGlobalBuffNoticeComplete()
end

function GlobalNoticeUI:__OnGlobalBuffNoticeComplete()
	if self.__globalBuffNoticeLockCount > 0 then
		return
	end

	if not self.globalBuffNotice.isFree then
		return
	end

	if self.__globalBuffNoticeQueue.Size == 0 then
		return
	end

	local buffCid = self.__globalBuffNoticeQueue:Dequeue()

	self.globalBuffNotice:Show(buffCid, function()
		self:__OnGlobalBuffNoticeComplete()
	end)
end

function GlobalNoticeUI:__OnAddGlobalBuffNoticeLock(num)
	local _num = TryToNumber(num, 1)

	self.__globalBuffNoticeLockCount = self.__globalBuffNoticeLockCount + _num
end

function GlobalNoticeUI:__OnRemoveGlobalBuffNoticeLock(num)
	local _num = TryToNumber(num, 1)

	self.__globalBuffNoticeLockCount = self.__globalBuffNoticeLockCount - _num

	if self.__globalBuffNoticeLockCount <= 0 then
		self.__globalBuffNoticeLockCount = 0

		self:__OnGlobalBuffNoticeComplete()
	end
end

return GlobalNoticeUI
