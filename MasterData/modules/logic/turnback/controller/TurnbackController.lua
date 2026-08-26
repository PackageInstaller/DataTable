-- chunkname: @modules/logic/turnback/controller/TurnbackController.lua

module("modules.logic.turnback.controller.TurnbackController", package.seeall)

local TurnbackController = class("TurnbackController", BaseController)

function TurnbackController:onInit()
	return
end

function TurnbackController:onInitFinish()
	return
end

function TurnbackController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	self.registerCallback(self, TurnbackEvent.AdditionCountChange, self._onAdditionCountChange, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._dailyRefresh, self)
end

function TurnbackController:reInit()
	return
end

function TurnbackController:sendGetTurnbackInfoRequest()
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Turnback
	})
end

function TurnbackController:_dailyRefresh()
	if TurnbackModel.instance:isInOpenTime() then
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	else
		ViewMgr.instance:closeView(ViewName.Turnback3BeginnerView)
		ViewMgr.instance:closeView(ViewName.TurnbackNewBeginnerView)
		ViewMgr.instance:closeView(ViewName.TurnbackBeginnerView)
	end
end

function TurnbackController:hasPlayedStoryVideo(turnbackId)
	local config = TurnbackConfig.instance:getTurnbackCo(turnbackId)

	if not config then
		return true
	end

	if config.startStory == 0 then
		return true
	end

	return StoryModel.instance:isStoryFinished(config.startStory)
end

function TurnbackController:checkFirstOpenLatter(day)
	local key = string.format("%s#%s#%s", PlayerPrefsKey.TurnbackSigninLatterFirstOpen, day, PlayerModel.instance:getPlayinfo().userId)
	local data = PlayerPrefsHelper.getString(key, "")
	local canOpen = string.nilorempty(data)

	if canOpen then
		ViewMgr.instance:openView(ViewName.TurnbackNewLatterView, {
			isNormal = true,
			day = day
		})
		PlayerPrefsHelper.setString(key, "opened")
	end
end

function TurnbackController:openTurnbackBeginnerView(param)
	local turnbackId = param.turnbackId

	local function callback()
		if GameUtil.getTabLen(TurnbackConfig.instance:getAllTurnbackSubModules(turnbackId)) > 0 then
			if turnbackId == 1 then
				ViewMgr.instance:openView(ViewName.TurnbackBeginnerView, param)
			end

			if turnbackId == 2 then
				ViewMgr.instance:openView(ViewName.TurnbackNewBeginnerView, param)
			else
				local viewName = string.format("Turnback%sBeginnerView", turnbackId)

				if ViewMgr.instance:isOpen(viewName) then
					if param and param.subModuleId then
						TurnbackModel.instance:setTargetCategoryId(param.subModuleId)
						self:dispatchEvent(TurnbackEvent.RefreshBeginner)
					end

					return
				end

				ViewMgr.instance:openView(viewName, param)
			end
		else
			GameFacade.showToast(ToastEnum.ActivityNormalView)
		end
	end

	TurnbackRpc.instance:sendGetTurnbackInfoRequest(callback, self)
end

function TurnbackController:_onUpdateTaskList(msg)
	if not TurnbackModel.instance:getCurTurnbackMo() then
		return
	end

	local isChange = TurnbackTaskModel.instance:updateInfo(msg.taskInfo)

	if isChange then
		TurnbackTaskModel.instance:refreshListNewTaskList()
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshTaskRedDot)
	end
end

function TurnbackController:setSignInList()
	TurnbackSignInModel.instance:setSignInList()
end

function TurnbackController:_onAdditionCountChange()
	local remainCount, totalCount = TurnbackModel.instance:getAdditionCountInfo()
	local strCount = string.format("%s/%s", remainCount, totalCount)

	GameFacade.showToast(ToastEnum.TurnBackAdditionTimesChange, strCount)
end

function TurnbackController:_checkCustomShowRedDotData(redDotIcon, subModuleId)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local reddotId = TurnbackConfig.instance:getTurnbackSubModuleCo(subModuleId).reddotId
		local reddotCo = RedDotConfig.instance:getRedDotCO(reddotId)

		if not reddotCo then
			return
		end

		redDotIcon.show = self:checkIsShowCustomRedDot(subModuleId)

		if reddotId ~= 0 then
			if not reddotCo.style then
				local type = RedDotEnum.Style.Normal

				redDotIcon:showRedDot(type)
			end
		end
	end
end

function TurnbackController:checkIsShowCustomRedDot(subModuleId)
	local reddotId = TurnbackConfig.instance:getTurnbackSubModuleCo(subModuleId).reddotId
	local reddotCo = RedDotConfig.instance:getRedDotCO(reddotId)

	if not reddotCo then
		return
	end

	local curTurnbackId = TurnbackModel.instance:getCurTurnbackId()

	if reddotCo.canLoad == 0 then
		local signStr = curTurnbackId .. "_" .. subModuleId

		return TimeUtil.getDayFirstLoginRed(signStr)
	end

	return false
end

function TurnbackController:refreshRemainTime(endTime)
	local day, hour, minute = TurnbackModel.instance:getRemainTime(endTime)
	local dayStr = string.format("%02d", day)
	local hourStr = string.format("%02d", hour)
	local minuteStr = string.format("%02d", minute)
	local timeStr = ""

	if day >= 1 then
		timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_day_hour"), {
			dayStr,
			hourStr
		})
	elseif day == 0 and hour >= 1 then
		timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_hour_minute"), {
			hourStr,
			minuteStr
		})
	elseif day == 0 and hour < 1 and minute >= 1 then
		timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("remaintime_minute"), {
			minuteStr
		})
	elseif day == 0 and hour < 1 and minute < 1 then
		timeStr = luaLang("lessOneMinute")
	elseif day < 0 or not TurnbackModel.instance:isInOpenTime() then
		timeStr = luaLang("turnback_end")
	end

	return timeStr
end

function TurnbackController:showPopupView(MaterialData)
	if MaterialData ~= nil then
		local mo = {
			dataList = MaterialData
		}
		local co = MaterialRpc.receiveMaterial(mo)

		if co and #co > 0 then
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
		end
	end
end

local keyHead = PlayerPrefsKey.PlayerPrefsKey.TurnbackOnlineTaskUnlock .. "#"

function TurnbackController:isPlayFirstUnlockToday(id)
	local key = keyHead .. tostring(PlayerModel.instance:getPlayinfo().userId) .. id
	local curDate = ServerTime.nowInLocal()
	local dateObj = os.date("*t", curDate)

	if PlayerPrefsHelper.hasKey(key) then
		local lastEnterTime = tonumber(PlayerPrefsHelper.getString(key, curDate))

		dateObj.hour = 5
		dateObj.min = 0
		dateObj.sec = 0

		local today5H = os.time(dateObj)

		if lastEnterTime and TimeUtil.getDiffDay(curDate, lastEnterTime) < 1 and (curDate - today5H) * (lastEnterTime - today5H) > 0 then
			return false
		end
	end

	return true
end

function TurnbackController:savePlayUnlockAnim(id)
	local key = keyHead .. tostring(PlayerModel.instance:getPlayinfo().userId) .. id
	local stamp = ServerTime.nowInLocal()

	PlayerPrefsHelper.setString(key, tostring(stamp))
end

function TurnbackController:openTurnback3BpBuyView()
	local config = TurnbackConfig.instance:getTurnbackCo(TurnbackModel.instance:getCurTurnbackId())
	local havenum = CurrencyModel.instance:getDiamond()
	local temp = not string.nilorempty(config.buyDoubleBonusPrice) and string.splitToNumber(config.buyDoubleBonusPrice, "#")
	local price = temp and temp[3]

	if price <= havenum then
		if TurnbackModel.instance:checkHasGetAllTaskReward() then
			ViewMgr.instance:openView(ViewName.Turnback3BuyBpTipView)
		else
			ViewMgr.instance:openView(ViewName.Turnback3BuyBpView)
		end
	else
		ViewMgr.instance:openView(ViewName.Turnback3BuyMonthCardView)
	end
end

function TurnbackController:getProgressTaskId()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	return TurnbackEnum.Version2ProgressId[turnbackId]
end

TurnbackController.instance = TurnbackController.New()

return TurnbackController
