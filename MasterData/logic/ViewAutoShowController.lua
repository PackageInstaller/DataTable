-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/ViewAutoShowController.lua

module("logic.extensions.mainui.controller.ViewAutoShowController", package.seeall)

local ViewAutoShowController = class("ViewAutoShowController", BaseController)
local DATA_KEY = "VIEW_AUTO_SHOW_KEY_"
local notCheckViewArr = {
	ViewName.GMView,
	ViewName.VirtualJoystick,
	ViewName.HorseLanternView,
	ViewName.TaskCompelete,
	ViewName.ItemFly,
	ViewName.playerInfo
}

ViewAutoShowController.ECheckState_Checking = 0
ViewAutoShowController.ECheckState_Showing = 1
ViewAutoShowController.ECheckState_Hiding = 2
ViewAutoShowController.TAPTAP_FUNC_1 = 1
ViewAutoShowController.TAPTAP_FUNC_2 = 2
ViewAutoShowController.TAPTAP_FUNC_3 = 3
ViewAutoShowController.TAPTAP_FUNC_4 = 4
ViewAutoShowController.TAPTAP_FUNC_5 = 5

function ViewAutoShowController:ctor()
	ViewAutoShowController.super.ctor(self)

	self.checkOpPool = {}
end

function ViewAutoShowController:onInit()
	self:onReset(true)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._onSceneLoadedFinish, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self._onViewClose, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpenDone, self._onViewOpenDone, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnter, self._onBattleEnter, self)
	GameUtil.whenLocalDataInited(function()
		self.isLocalDataInited = true

		self:tryShowView()
	end)
end

function ViewAutoShowController:onReset(isInit)
	self.isLocalDataInited = false
	self.curRcdSceneType = nil
	self.currViewName = nil
	self.typePool = {}
	self.hasPopPool = {}
	self.popupList = {}

	self:stopTimer()

	self.isInited = false
	self._checkState = ViewAutoShowController.ECheckState_Checking

	if isInit == nil then
		self.checkOpPool = {}
	end

	self._evaluationCount = 0
end

function ViewAutoShowController:getCheckState()
	return self._checkState
end

function ViewAutoShowController:saveCurModalView()
	local topSaveViewName, modalPool = self:getTopModalAndViews()

	if topSaveViewName and modalPool then
		self:closeAndSaveViews(topSaveViewName, modalPool)
	end
end

function ViewAutoShowController:closeAndSaveViews(topSaveViewName, modalPool)
	self.topSaveViewName = topSaveViewName
	self.modalPool = modalPool

	if topSaveViewName then
		for i, v in ipairs(modalPool) do
			ViewMgr.instance:close(v.viewName)
		end
	end
end

function ViewAutoShowController:getTopModalAndViews()
	local topSaveViewName, modalPool
	local temList = {}
	local firstTop
	local views = GlobalModel.instance:getSortingViews()

	for i = 1, #views do
		local view = views[i]

		if ViewSetting.instance:isModal(view.viewName) then
			if view._status ~= ViewPresentor.kViewStatusClosing then
				local tem = {
					viewName = view.viewName,
					_openParam = view._openParam
				}

				table.insert(temList, tem)
			end
		elseif table.indexof(notCheckViewArr, view.viewName) == false then
			topSaveViewName = view.viewName

			break
		end
	end

	if topSaveViewName then
		modalPool = self:reverseTable(temList)
	end

	return topSaveViewName, modalPool
end

function ViewAutoShowController:reverseTable(tab)
	local tmp = {}

	for i = 1, #tab do
		tmp[i] = table.remove(tab)
	end

	return tmp
end

function ViewAutoShowController:stopTimer()
	removetimer(self.onTimer, self)
end

function ViewAutoShowController:startTimer()
	for i, cfg in ipairs(self.popupList) do
		local isMatch = cfg.popupType == 1 and GameUtil.isInOpenDaysByOpenDay(cfg.fromDay, cfg.duration) or GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime)

		if isMatch and self:checkTypeDone(cfg) == false and checknumber(cfg.isTick) == 1 then
			self:stopTimer()
			settimer(10, self.onTimer, self)

			break
		end
	end
end

function ViewAutoShowController:onTimer()
	self:tryShowView()
end

function ViewAutoShowController:checkTypeDone(cfg)
	if cfg then
		local type = cfg.type
		local key = DATA_KEY .. cfg.id

		if type == "once" then
			local value = GameUtil.getUserData(key)

			return checknumber(value) == 1
		elseif type == "each" then
			return checknumber(self.typePool[key]) == 1
		elseif type == "day" then
			local value = GameUtil.getUserDayData(key)

			return checknumber(value) == 1
		elseif type == "week" then
			local value = GameUtil.getUserWeekData(key)

			return checknumber(value) == 1
		elseif type == "forself" then
			local value = GameUtil.getUserData(key)

			return checknumber(value) == 1
		end
	end

	return false
end

function ViewAutoShowController:saveTypeDone(cfg)
	if cfg then
		local type = cfg.type
		local key = DATA_KEY .. cfg.id

		if type == "once" then
			GameUtil.saveUserData(key, 1)
		elseif type == "each" then
			self.typePool[key] = 1
		elseif type == "day" then
			GameUtil.saveUserDayData(key, 1)
		elseif type == "week" then
			GameUtil.saveUserWeekData(key, 1)
		elseif type == "forself" then
			-- block empty
		end
	end
end

function ViewAutoShowController:saveSelfTypeDone(cfg)
	if cfg then
		local type = cfg.type

		if type == "forself" then
			local key = DATA_KEY .. cfg.id

			GameUtil.saveUserData(key, 1)
		end
	end
end

function ViewAutoShowController:_onViewClose(view)
	if view.viewName == ViewName.ItemFly then
		return
	end

	if GuideController.instance:checkHasGuideView(view.viewName) then
		self:startTimer()

		return
	end

	local temViewName

	if self.currViewName == view.viewName then
		temViewName = view.viewName
		self.currViewName = nil
	end

	self:tryShowView()

	if self.currViewName == nil and temViewName ~= nil then
		GuideController.instance:onViewExitFinish(temViewName)
	end
end

function ViewAutoShowController:_onViewOpenDone(view)
	if self.currViewName == view.viewName and not view.viewWithGuide then
		GuideController.instance:onViewEnterFinish(view.viewName)
	end

	if GuideController.instance:checkHasGuideView(view.viewName) then
		self:stopTimer()

		return
	end

	if self.topSaveViewName and self.topSaveViewName == view.viewName and self.modalPool then
		for i, v in ipairs(self.modalPool) do
			if UIStateManager.instance._openPool and UIStateManager.instance._openPool[v.viewName] then
				UIStateManager.instance:push(v.viewName, GameUtil.unpack10(v._openParam))
			end
		end

		self:clearAllSaveModal()
	end
end

function ViewAutoShowController:clearAllSaveModal()
	self.modalPool = nil
	self.topSaveViewName = nil
end

function ViewAutoShowController:_onBattleEnter()
	self:clearAllSaveModal()
end

function ViewAutoShowController:_updateRedpoint()
	self:tryShowView()
end

function ViewAutoShowController:_onSceneLoadedFinish(sceneType, sceneId)
	self.curRcdSceneType = sceneType

	self:tryShowView()
end

function ViewAutoShowController:tryinitList()
	if self.isInited == false then
		self.isInited = true
		self.popupList = {}

		local list = ActivityPopupConfig.instance:getAutoCfg()

		for i, cfg in ipairs(list) do
			if self:_isMatchCondition(cfg) then
				table.insert(self.popupList, cfg)
			end
		end

		ArraySort.sortOn(self.popupList, "priority")
		GlobalDispatcher:dispatch(GlobalNotify.VIEWAUTOSHOW_DATA_INITED_OK)
	end
end

function ViewAutoShowController:_isMatchCondition(cfg)
	if BootstrapPjaqGameConfigMgr.isReview and checkbool(cfg.hideWithReview) then
		return false
	end

	if not ActivityDefineController.instance:isRelateServerBy(cfg.relatedAreaIds) then
		return false
	end

	if cfg.popupType == 1 then
		if GameUtil.isBeforeEndDaysByOpenDay(cfg.fromDay, cfg.duration) then
			return true
		end
	elseif GameUtil.getTimePeriodType(cfg.openTime, cfg.endTime) ~= GameUtil.afterTimePeriod and self:checkTypeDone(cfg) == false then
		return true
	end

	return false
end

function ViewAutoShowController:tryShowView()
	if self.isLocalDataInited and self.curRcdSceneType == SceneType.City then
		self:tryinitList()

		local v = GlobalModel.instance:getTopView()

		if v ~= nil and v.viewName == ViewName.MainUI and self.topSaveViewName ~= ViewName.MainUI then
			if self.currViewName == nil then
				local cfg = self:getFirstCfg()

				self:saveTypeDone(cfg)

				if cfg then
					self._checkState = ViewAutoShowController.ECheckState_Showing

					self:stopTimer()

					self.currViewName = cfg.viewname

					if GameUtil.isEmptyString(cfg.params) then
						self.currParams = nil
					else
						self.currParams = cfg.params
					end

					self:doSaveBeforeOpen(cfg)

					if cfg.type == "forself" then
						if self.currParams == nil then
							UIStateManager.instance:push(self.currViewName, "", cfg)
						else
							UIStateManager.instance:push(self.currViewName, self.currParams, cfg)
						end
					else
						UIStateManager.instance:push(self.currViewName, self.currParams)
					end
				else
					self:startTimer()
				end
			end
		else
			self._checkState = ViewAutoShowController.ECheckState_Hiding

			self:stopTimer()
		end
	else
		self._checkState = ViewAutoShowController.ECheckState_Hiding

		self:stopTimer()
	end
end

function ViewAutoShowController:doSaveBeforeOpen(cfg)
	self.hasPopPool[checknumber(cfg.id)] = true
end

function ViewAutoShowController:getFirstCfg()
	local res
	local idx = -1

	for i, cfg in ipairs(self.popupList) do
		local isMatch = cfg.popupType == 1 and GameUtil.isInOpenDaysByOpenDay(cfg.fromDay, cfg.duration) or GameUtil.checkIsInTimePeriod(cfg.openTime, cfg.endTime)

		if isMatch and self:checkTypeDone(cfg) == false and self:getFuncOpen(cfg) and self:checkOp(cfg) then
			res = cfg
			idx = i

			break
		end
	end

	if idx > 0 then
		table.remove(self.popupList, idx)
	end

	return res
end

function ViewAutoShowController:getFuncOpen(cfg)
	if cfg.funcId > 0 then
		return FuncOpenModel.instance:getFuncIsOpen(cfg.funcId)
	end

	return true
end

function ViewAutoShowController:setAutoCheckOp(key, isOK)
	self.checkOpPool[key] = checkbool(isOK)
end

function ViewAutoShowController:checkOp(cfg)
	if not string.nilorempty(cfg.check) then
		return GameUtil.expScript(cfg.check, function(str)
			local arr = string.split(str, "$")
			local type = string.upper(arr[1])
			local op = arr[2]

			if type == string.upper("key") then
				if op == "checkBossTime" then
					return WorldBossController.instance:isInBossCanFightTime()
				end

				if op == "checkFirstpay" then
					return FirstChargeModel.instance:getIsShowHub()
				end

				if op == "checkFirstpayPlus" then
					return FirstChargePlusModel.instance:getIsShowHub()
				end

				if op == "checkGoldenDiamond" then
					return GoldenDiamondCardModel.instance:getIsShowRenewView()
				end

				if op == "sharepopup" then
					return ShareTaskModel.instance:IsOpenSharePopupView()
				end

				if op == "checkHasOpen" then
					local params = arr[3]

					params = checknumber(params)

					return self.hasPopPool[params]
				end

				if op == "checkHasAutoMall" then
					return ActivityPopupModel.instance:getHasAutoMall()
				end

				if op == "checkHasRegressActId" then
					return checknumber(RoleModel.instance:getRegressActId()) > 0
				end

				if op == "checkOpSummary" then
					local params = arr[3]

					if params == nil then
						params = cfg.params
					end

					params = checknumber(params)

					return not OpSummaryModel.instance:getHaveGetInvitation(params)
				end

				if op == "checkHasResRecover" then
					return MaterialRecoverController.instance:aotoPopupViewWhileEnterGame()
				end

				if op == "chcekNewHandWelfare" then
					return not NewhandwelfareModel.instance:isNewHandActivePlayer()
				end

				if op == "checkAnniversaryKoiTime" then
					return AnniversaryKoiController.instance:checkAnniversaryKoiLottery()
				end

				if op == "checkNewHandSelectPass" then
					return NewhandwelfareController.instance:isNeedPopNewHandSelectPassView()
				end

				if op == "checkCompanionMall" then
					local hasActiveRedPoint = RedPointModel.instance:isActive(RedPointModel.COMPANIOIN_MALL_MAIN_VIEW) or RedPointModel.instance:isActive(RedPointModel.COMPANIOIN_MALL_ADDRESS_VIEW)

					return CompanionMallModel.instance:canOpenMainView() and hasActiveRedPoint
				end

				if op == "checkMobileNetworkAndVersion" then
					return InnerDownloadController.instance:checkMobileNetworkAndVersion()
				end

				if self.checkOpPool[op] ~= nil then
					return self.checkOpPool[op]
				end
			elseif type == string.upper("redId") then
				return RedPointModel.instance:isActive(op)
			end
		end)
	else
		return true
	end
end

function ViewAutoShowController:trySaveHasEvaluation()
	GameUtil.saveUserData("hasEvaluation", 1)
end

function ViewAutoShowController:trySaveMonthEvaluation()
	GameUtil.saveUserData("monthEvaluationMark", ServerTime.now())

	local count = checknumber(GameUtil.getUserData("monthEvaluationCount"))

	count = count + 1

	GameUtil.saveUserData("monthEvaluationCount", count)

	if count >= 3 then
		self:trySaveHasEvaluation()
	end
end

function ViewAutoShowController:trySetAutoEvaluation(rate, type)
	local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

	if versionCode < 820 then
		return
	end

	if rate == nil then
		rate = 0.25
	end

	local hasMonthEvaluation = false
	local mark = GameUtil.getUserData("monthEvaluationMark")

	if mark ~= nil then
		local t2 = ServerTime.now()
		local t1 = checknumber(mark)
		local difference = t2 - t1
		local day = difference / 86400

		if day < 30 then
			hasMonthEvaluation = true
		end
	end

	local hasEvaluation = checknumber(GameUtil.getUserData("hasEvaluation")) == 1

	if not hasEvaluation and not hasMonthEvaluation then
		local rand = math.random()

		if rand < rate then
			self:setAutoCheckOp("checkHasEvaluation", true)
			SurveyController.instance:reportBehavior(201802, type)
		else
			self._evaluationCount = self._evaluationCount + 1
		end

		if self._evaluationCount >= 4 then
			self:setAutoCheckOp("checkHasEvaluation", true)
			SurveyController.instance:reportBehavior(201802, type)
		end
	end
end

ViewAutoShowController.instance = ViewAutoShowController.New()

return ViewAutoShowController
