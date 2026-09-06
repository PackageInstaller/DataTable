-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/controller/TabFrameWorkController.lua

module("logic.extensions.tabframework.controller.TabFrameWorkController", package.seeall)

local TabFrameWorkController = class("TabFrameWorkController", BaseController)

TabFrameWorkController.NotifyOpentabframeworkview = "opentabframeworkview"
TabFrameWorkController.NotifyTabframeworkviewJump = "notifytabframeworkviewjump"
TabFrameWorkController.NotifyTabframeworkviewJumpByName = "notifytabframeworkviewjumpbyname"

function TabFrameWorkController:ctor()
	self._enterContextMap = {}
end

function TabFrameWorkController:onInit()
	self:onReset()
end

function TabFrameWorkController:onReset()
	self._enterContextMap = {}

	GlobalDispatcher:addListener(TabFrameWorkController.NotifyOpentabframeworkview, self.gotoTabFrameWorkView, self)
end

function TabFrameWorkController:loadTabFrameWork()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self.dailyRefresh, self)
	self:updateTabFrameWorkTotalRed()
end

function TabFrameWorkController:dailyRefresh()
	self:updateTabFrameWorkTotalRed()
end

function TabFrameWorkController:gotoTabFrameWorkView(params)
	self:openTabFrameWorkView(unpack(params))
end

function TabFrameWorkController:openTabFrameWorkView(frameId, ...)
	local exParams = {
		...
	}
	local frameId = checknumber(frameId)
	local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	if baseData == nil then
		printError(string.format("不存在对应配置,请检查配置表( yk-运营-页签框架 | 基础配置页 | frameId = %s )", frameId))

		return
	end

	local tabCfg = TabFrameWorkConfig.instance:getFwTabCfg(frameId)

	if tabCfg == nil then
		printError(string.format("不存在对应配置,请检查配置表( yk-运营-页签框架 | 页签配置 | frameId = %s, tabPlanId = %s )", baseData.tabPlanId))

		return
	end

	if string.nilorempty(baseData.viewName) then
		printError("配置中缺失viewName字段数据,请务必填写,否则无法打开对应界面( yk-运营-页签框架 | 基础配置页 )")

		return
	end

	self:setEnterContext(frameId, exParams[1], exParams[2])
	UIStateManager.instance:push(baseData.viewName, frameId, unpack(exParams))
end

function TabFrameWorkController:setEnterContext(frameId, headTabId, secTabId)
	frameId = checknumber(frameId)

	if frameId <= 0 then
		return
	end

	local baseData = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	if baseData == nil or string.nilorempty(baseData.viewName) then
		return
	end

	self._enterContextMap[baseData.viewName] = {
		frameId = frameId,
		headTabId = checknumber(headTabId),
		secTabId = checknumber(secTabId)
	}
end

function TabFrameWorkController:consumeEnterContext(viewName)
	if string.nilorempty(viewName) then
		return nil
	end

	self._enterContextMap[viewName] = nil

	return self._enterContextMap[viewName]
end

function TabFrameWorkController:updateTabFrameWorkTotalRed()
	local baseDataList = TabFrameWorkConfig.instance:getFwBaseDataList()

	for _, data in ipairs(baseDataList) do
		self:_updateTotalRedAsFrame(data.frameId)
	end
end

function TabFrameWorkController:_updateTotalRedAsFrame(frameId)
	local isUnlock = self:isUnlockFrame(frameId)
	local totalRedId = TabFrameWorkConfig.instance:getFwTotalRedId(frameId)

	if totalRedId ~= 0 then
		RedPointController.instance:setRedPointInfo(totalRedId, false)
	end

	if not isUnlock or totalRedId == 0 then
		return
	end

	for _, data in ipairs(TabFrameWorkConfig.instance:getFwTabCfg(frameId)) do
		if RedPointModel.instance:isActive(totalRedId) then
			break
		end

		local data = TabFrameWorkConfig.instance:getFwTabData(frameId, data.headTabId)

		if data == nil then
			printError(string.format("不存在对应配置,请检查配置表( yk-运营-页签框架 | 页签配置 | frameId = %s, tabPlanId = %s, headTabId = %s )", frameId, data.tabPlanId, data.headTabId))
		else
			self:_updateTotalRedAsTab(frameId, data.headTabId)
		end
	end
end

function TabFrameWorkController:_updateTotalRedAsTab(frameId, headTabId)
	local totalRedId = TabFrameWorkConfig.instance:getFwTotalRedId(frameId)

	if totalRedId == 0 then
		return
	end

	RedPointController.instance:setRedPointInfo(totalRedId, false)

	local isCanTryRed = self:isCanTryRedAsHeadTab(frameId, headTabId)

	if isCanTryRed == false then
		return
	end

	local function handle(value)
		if not value and not RedPointModel.instance:isActive(totalRedId) then
			RedPointController.instance:setRedPointInfo(totalRedId, true)
		end
	end

	self:isNeedRedAsHeadTab(frameId, headTabId, handle)
end

function TabFrameWorkController:isNeedRedAsHeadTab(frameId, headTabId, handle)
	if not self:isCanTryRedAsHeadTab(frameId, headTabId) then
		return false
	end

	if self:isNeedWeekRedAsHeadTab(frameId, headTabId, handle) then
		return true
	end

	if self:isNeedDayRedAsHeadTab(frameId, headTabId, handle) then
		return true
	end

	if self:isNeedOnceRedAsHeadTab(frameId, headTabId, handle) then
		return true
	end

	local secCfg = TabFrameWorkConfig.instance:getFwSecTabCfg(frameId, headTabId)

	if secCfg then
		for _, data in ipairs(secCfg) do
			if self:isNeedRedAsSecTab(frameId, headTabId, data.secTabId, handle) then
				return true
			end
		end
	end

	return false
end

function TabFrameWorkController:isCanTryRedAsHeadTab(frameId, headTabId)
	return self:isUnlockAsHeadTab(frameId, headTabId)
end

function TabFrameWorkController:trySetRedAsHeadTab(frameId, headTabId)
	self:setWeekRedAsHeadTab(frameId, headTabId)
	self:setDayRedAsHeadTab(frameId, headTabId)
	self:setOnceRedAsHeadTab(frameId, headTabId)
	self:_updateTotalRedAsFrame(frameId)
end

function TabFrameWorkController:isNeedWeekRedAsHeadTab(frameId, headTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedWeekRed == false then
		return false
	end

	local key = self:getWeekRedKeyAsHeadTab(frameId, headTabId)

	return GameUtil.getUserWeekData(key, handle) ~= true
end

function TabFrameWorkController:setWeekRedAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedWeekRed == false then
		return
	end

	local key = self:getWeekRedKeyAsHeadTab(frameId, headTabId)

	GameUtil.saveUserWeekData(key, true)
end

function TabFrameWorkController:getWeekRedKeyAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return string.format("%s_%s_%s_%s_%s", "TabFrameWork", "WeekRed", frameId, data.tabPlanId, headTabId)
end

function TabFrameWorkController:isNeedDayRedAsHeadTab(frameId, headTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedDayRed == false then
		return false
	end

	local key = self:getDayRedKeyAsHeadTab(frameId, headTabId)

	return GameUtil.getUserDayData(key, handle) ~= true
end

function TabFrameWorkController:setDayRedAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedDayRed == false then
		return
	end

	local key = self:getDayRedKeyAsHeadTab(frameId, headTabId)

	GameUtil.saveUserDayData(key, true)
end

function TabFrameWorkController:getDayRedKeyAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return string.format("%s_%s_%s_%s_%s", "TabFrameWork", "DayRed", frameId, data.tabPlanId, headTabId)
end

function TabFrameWorkController:isNeedOnceRedAsHeadTab(frameId, headTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedOnceRed == false then
		return false
	end

	local key = self:getOnceRedKeyAsHeadTab(frameId, headTabId)

	return GameUtil.getUserData(key, handle) ~= true
end

function TabFrameWorkController:setOnceRedAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.isNeedOnceRed == false then
		return
	end

	local key = self:getOnceRedKeyAsHeadTab(frameId, headTabId)

	GameUtil.saveUserData(key, true)
end

function TabFrameWorkController:getOnceRedKeyAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return string.format("%s_%s_%s_%s_%s", "TabFrameWork", "OnceRed", frameId, data.tabPlanId, headTabId)
end

function TabFrameWorkController:isNeedRedAsSecTab(frameId, headTabId, secTabId, handle)
	if not self:isCanTryRedAsSecTab(frameId, headTabId, secTabId) then
		return false
	end

	if self:isNeedWeekRedAsSecTab(frameId, headTabId, secTabId, handle) then
		return true
	end

	if self:isNeedDayRedAsSecTab(frameId, headTabId, secTabId, handle) then
		return true
	end

	if self:isNeedOnceRedAsSecTab(frameId, headTabId, secTabId, handle) then
		return true
	end

	return false
end

function TabFrameWorkController:isCanTryRedAsSecTab(frameId, headTabId, secTabId)
	return self:isUnlockAsSecTab(frameId, headTabId, secTabId)
end

function TabFrameWorkController:trySetRedAsSecTab(frameId, headTabId, secTabId)
	self:setWeekRedAsSecTab(frameId, headTabId, secTabId)
	self:setDayRedAsSecTab(frameId, headTabId, secTabId)
	self:setOnceRedAsSecTab(frameId, headTabId, secTabId)
	self:_updateTotalRedAsFrame(frameId)
end

function TabFrameWorkController:isNeedWeekRedAsSecTab(frameId, headTabId, secTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedWeekRed == false then
		return false
	end

	local key = self:getWeekRedKeyAsSecTab(frameId, headTabId, secTabId)

	return GameUtil.getUserWeekData(key, handle) ~= true
end

function TabFrameWorkController:setWeekRedAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedWeekRed == false then
		return
	end

	local key = self:getWeekRedKeyAsSecTab(frameId, headTabId, secTabId)

	GameUtil.saveUserWeekData(key, true)
end

function TabFrameWorkController:getWeekRedKeyAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return string.format("%s_%s_%s_%s_%s_%s", "TabFrameWork", "WeekRed", frameId, data.tabPlanId, headTabId, secTabId)
end

function TabFrameWorkController:isNeedDayRedAsSecTab(frameId, headTabId, secTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedDayRed == false then
		return false
	end

	local key = self:getDayRedKeyAsSecTab(frameId, headTabId, secTabId)

	return GameUtil.getUserDayData(key, handle) ~= true
end

function TabFrameWorkController:setDayRedAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedDayRed == false then
		return
	end

	local key = self:getDayRedKeyAsSecTab(frameId, headTabId, secTabId)

	GameUtil.saveUserDayData(key, true)
end

function TabFrameWorkController:getDayRedKeyAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return string.format("%s_%s_%s_%s_%s_%s", "TabFrameWork", "DayRed", frameId, data.tabPlanId, headTabId, secTabId)
end

function TabFrameWorkController:isNeedOnceRedAsSecTab(frameId, headTabId, secTabId, handle)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedOnceRed == false then
		return false
	end

	local key = self:getOnceRedKeyAsSecTab(frameId, headTabId, secTabId)

	return GameUtil.getUserData(key, handle) ~= true
end

function TabFrameWorkController:setOnceRedAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.isNeedOnceRed == false then
		return
	end

	local key = self:getOnceRedKeyAsSecTab(frameId, headTabId, secTabId)

	GameUtil.saveUserData(key, true)
end

function TabFrameWorkController:getOnceRedKeyAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return string.format("%s_%s_%s_%s_%s_%s", "TabFrameWork", "OnceRed", frameId, data.tabPlanId, headTabId, secTabId)
end

function TabFrameWorkController:isLockAsFrame(frameId)
	local data = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	return data.isLock
end

function TabFrameWorkController:getUnlockTimePeriodAsFrame(frameId)
	local data = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	return GameUtil.getTimePeriod(data.startUnlockTime, data.endUnlockTime)
end

function TabFrameWorkController:isUnlockFrame(frameId)
	return not self:isLockAsFrame(frameId) and self:isUnlockByTimeAsFrame(frameId) and self:isUnlockByFuncIdAsFrame(frameId)
end

function TabFrameWorkController:isUnlockByTimeAsFrame(frameId)
	return self:getUnlockTimePeriodAsFrame(frameId) == GameUtil.inTimePeriod
end

function TabFrameWorkController:isUnlockByFuncIdAsFrame(frameId)
	local data = TabFrameWorkConfig.instance:getFwBaseData(frameId)

	if data.funcId == 0 then
		return true
	end

	return FuncOpenModel.instance:getFuncIsOpen(data.funcId)
end

function TabFrameWorkController:getUnlockTimePeriodAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return GameUtil.getTimePeriod(data.startUnlockTime, data.endUnlockTime)
end

function TabFrameWorkController:getShowTimePeriodAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return GameUtil.getTimePeriod(data.startShowTime, data.endShowTime)
end

function TabFrameWorkController:isUnlockAsHeadTab(frameId, headTabId)
	return not self:isHideAsHeadTab(frameId, headTabId) and self:isUnlockByTimeAsHeadTab(frameId, headTabId) and self:isUnlockByFuncIdAsHeadTab(frameId, headTabId)
end

function TabFrameWorkController:isHideAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	return data.isHide
end

function TabFrameWorkController:isUnlockByTimeAsHeadTab(frameId, headTabId)
	return self:getUnlockTimePeriodAsHeadTab(frameId, headTabId) == GameUtil.inTimePeriod
end

function TabFrameWorkController:isUnlockByFuncIdAsHeadTab(frameId, headTabId)
	local data = TabFrameWorkConfig.instance:getFwTabData(frameId, headTabId)

	if data.funcId == 0 then
		return true
	end

	return FuncOpenModel.instance:getFuncIsOpen(data.funcId)
end

function TabFrameWorkController:isShowAsHeadTab(frameId, headTabId)
	return not self:isHideAsHeadTab(frameId, headTabId) and self:isShowByTimeAsHeadTab(frameId, headTabId)
end

function TabFrameWorkController:isShowByTimeAsHeadTab(frameId, headTabId)
	return self:getShowTimePeriodAsHeadTab(frameId, headTabId) == GameUtil.inTimePeriod
end

function TabFrameWorkController:getUnlockTimePeriodAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return GameUtil.getTimePeriod(data.startUnlockTime, data.endUnlockTime)
end

function TabFrameWorkController:getShowTimePeriodAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return GameUtil.getTimePeriod(data.startShowTime, data.endShowTime)
end

function TabFrameWorkController:isUnlockAsSecTab(frameId, headTabId, secTabId)
	return not self:isHideAsSecTab(frameId, headTabId, secTabId) and self:isUnlockByTimeAsSecTab(frameId, headTabId, secTabId) and self:isUnlockByFuncIdAsSecTab(frameId, headTabId, secTabId)
end

function TabFrameWorkController:isHideAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	return data.isHide
end

function TabFrameWorkController:isUnlockByTimeAsSecTab(frameId, headTabId, secTabId)
	return self:getUnlockTimePeriodAsSecTab(frameId, headTabId, secTabId) == GameUtil.inTimePeriod
end

function TabFrameWorkController:isUnlockByFuncIdAsSecTab(frameId, headTabId, secTabId)
	local data = TabFrameWorkConfig.instance:getFwSecTabData(frameId, headTabId, secTabId)

	if data.funcId == 0 then
		return true
	end

	return FuncOpenModel.instance:getFuncIsOpen(data.funcId)
end

function TabFrameWorkController:isShowAsSecTab(frameId, headTabId, secTabId)
	return not self:isHideAsSecTab(frameId, headTabId, secTabId) and self:isShowByTimeAsSecTab(frameId, headTabId, secTabId)
end

function TabFrameWorkController:isShowByTimeAsSecTab(frameId, headTabId, secTabId)
	return self:getShowTimePeriodAsSecTab(frameId, headTabId, secTabId) == GameUtil.inTimePeriod
end

TabFrameWorkController.instance = TabFrameWorkController.New()

return TabFrameWorkController
