-- chunkname: @modules/logic/login/work/AutoOpenNoticeWork.lua

module("modules.logic.login.work.AutoOpenNoticeWork", package.seeall)

local AutoOpenNoticeWork = class("AutoOpenNoticeWork", BaseWork)

function AutoOpenNoticeWork:onStart(context)
	if VersionValidator.instance:isInReviewing() then
		self:onDone(true)

		return
	end

	if GameFacade.isExternalTest() then
		self:onDone(true)

		return
	end

	if SDKMgr.getShowNotice and not SDKMgr.instance:getShowNotice() then
		self:onDone(true)

		return
	end

	NoticeController.instance:startRequest(self.onReceiveNotice, self)
end

function AutoOpenNoticeWork:onReceiveNotice(isSuccess, msg)
	if not isSuccess then
		return self:onDone(true)
	end

	if not NoticeModel.instance:canAutoOpen() then
		return self:onDone(true)
	end

	NoticeController.instance:getNoticeConfig(self.autoOpenNoticeView, self)
end

function AutoOpenNoticeWork:autoOpenNoticeView()
	self:saveCurrentTime()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	NoticeController.instance:setAutoOpenNoticeView(true)
	ViewMgr.instance:openView(ViewName.NoticeView)
end

function AutoOpenNoticeWork:saveCurrentTime()
	local key = PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.NoticePatKey)
	local preStr = PlayerPrefsHelper.getString(key, "")
	local timeStamp = ServerTime.nowInLocal() - TimeDispatcher.DailyRefreshTime * TimeUtil.OneHourSecond
	local dt = os.date("*t", timeStamp)
	local year = dt.year
	local month = dt.month
	local day = dt.day
	local hour = dt.hour
	local saveStr = string.format("%s%s%s%s%s%s%s", year, NoticeEnum.FirstSplitChar, month, NoticeEnum.FirstSplitChar, day, NoticeEnum.FirstSplitChar, hour)

	if not string.nilorempty(preStr) then
		saveStr = preStr .. NoticeEnum.SecondSplitChar .. saveStr
	end

	PlayerPrefsHelper.setString(key, saveStr)
end

function AutoOpenNoticeWork:onCloseViewFinish(viewName)
	if viewName == ViewName.NoticeView then
		self:onDone(true)
	end
end

function AutoOpenNoticeWork:clearWork()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	NoticeController.instance:stopRequest()
	NoticeController.instance:stopGetConfigRequest()
end

return AutoOpenNoticeWork
