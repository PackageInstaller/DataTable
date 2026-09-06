-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/controller/MirrorTrialController.lua

module("logic.extensions.mirrortrial.controller.MirrorTrialController", package.seeall)

local MirrorTrialController = class("MirrorTrialController", BaseController)

function MirrorTrialController:ctor()
	return
end

MirrorTrialController.HandleGetInfo = "MirrorTrialController.PM_GetMirrorTrialInfoRes"
MirrorTrialController.HandleStartFight = "MirrorTrialController.PM_MirrorTrialFightRes"
MirrorTrialController.HandleGainPrize = "MirrorTrialController.PM_MirrorTrialGainPrizeRes"
MirrorTrialController.HandleBuyScore = "MirrorTrialController.PM_MirrorTrialBuyScoreRes"
MirrorTrialController.NotifyFightResult = "MirrorTrialController.PM_MirrorTrialNotifyFightResult"
MirrorTrialController.DailyReset = "MirrorTrialController.DailyReset"
MirrorTrialController.NotifyPaySuc = "MirrorTrialController.PM_MirrorTrialNotifyPaySucRes"
MirrorTrialController.EnterFightFailed = "MirrorTrialController.EnterFightFailed"

function MirrorTrialController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	self.registerNotify(self, GlobalNotify.OnViewClose, self._onViewClosed, self)
	self:onReset()
end

function MirrorTrialController:onReset()
	self:clearPlotChapterviewCachesExcept()
end

function MirrorTrialController:handleGetInfo(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updateGetInfo(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.HandleGetInfo)
	else
		self:_dailyReset()
	end
end

function MirrorTrialController:handleStartFight(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updateStartFight(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.HandleStartFight)
	else
		GlobalDispatcher:dispatch(MirrorTrialController.EnterFightFailed)
	end
end

function MirrorTrialController:handleGainPrize(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updateGainPrize(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.HandleGainPrize)
	else
		self:_dailyReset()
	end
end

function MirrorTrialController:handleBuyScore(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updateBuyScore(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.HandleBuyScore)
	else
		self:_dailyReset()
	end
end

function MirrorTrialController:notifyFightResult(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updateNotifyFight(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.NotifyFightResult)
	end
end

function MirrorTrialController:notifyPaySuc(status, msg)
	if status == 0 then
		MirrorTrialModel.instance:updatePaySuc(msg)
		GlobalDispatcher:dispatch(MirrorTrialController.NotifyPaySuc)
	end
end

function MirrorTrialController:_dailyReset()
	MirrorTrialModel.instance:updateDaily()
	GlobalDispatcher:dispatch(MirrorTrialController.DailyReset)
end

function MirrorTrialController:_onViewClosed(view)
	if not self._plotChapterviewCaches or table.nums(self._plotChapterviewCaches) == 0 then
		return
	end

	local viewName = view.viewName

	if viewName ~= ViewName.PlotChapterView then
		return
	end

	if UIStateManager.instance:isInStack(ViewName.MirrortrialchapterView) or UIJumper.instance:isInStack(ViewName.MirrortrialchapterView) then
		return
	end

	removetimer(self._autoClearPlotCaches, self)
	settimer(5, self._autoClearPlotCaches, self, false)
end

function MirrorTrialController:_autoClearPlotCaches()
	self:clearPlotChapterviewCachesExcept()
end

function MirrorTrialController:clearPlotChapterviewCachesExcept(chapterId)
	removetimer(self._autoClearPlotCaches, self)

	if not self._plotChapterviewCaches then
		return
	end

	local needClear
	local temp = table.keys(self._plotChapterviewCaches)

	for k, v in pairs(temp) do
		if v ~= chapterId then
			local caches = self._plotChapterviewCaches[v]

			for k1, v1 in pairs(caches.resourcesList) do
				v1:Release()

				needClear = true
			end

			self._plotChapterviewCaches[v] = nil
		end
	end

	if needClear then
		Framework.DynImageCache.Instance:ReleaseAllUnused()
		rescache:DestroyUnusedResources()
	end
end

function MirrorTrialController:cachePlotChapterviewRes(chapterId, resPath)
	self._plotChapterviewCaches = self._plotChapterviewCaches or {}
	self._plotChapterviewCaches[chapterId] = self._plotChapterviewCaches[chapterId] or {}

	local caches = self._plotChapterviewCaches[chapterId]

	caches.resourcesList = caches.resourcesList or {}

	if caches.resourcesList[resPath] then
		return
	end

	local res = rescache:GetResourceNoLoadIfNotExists(resPath)

	if res then
		caches.resourcesList[resPath] = res

		res:Retain()
	end
end

MirrorTrialController.instance = MirrorTrialController.New()

return MirrorTrialController
