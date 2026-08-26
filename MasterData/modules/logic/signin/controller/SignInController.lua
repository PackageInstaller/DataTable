-- chunkname: @modules/logic/signin/controller/SignInController.lua

module("modules.logic.signin.controller.SignInController", package.seeall)

local SignInController = class("SignInController", BaseController)

function SignInController:onInit()
	self._curMonth = 0
end

function SignInController:reInit()
	self:stopCheckEnterMainView()
end

function SignInController:addConstEvents()
	MainController.instance:registerCallback(MainEvent.OnFuncUnlockRefresh, self._onFuncUnlock, self)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, self._onCheckSignIn, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, self._onCheckSignIn, self)
end

function SignInController:_onFuncUnlock()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	self:_onCheckSignIn()
end

function SignInController:_onCheckSignIn(guideId)
	if GuideController.instance:isGuiding() and guideId ~= GuideModel.instance:lastForceGuideId() then
		self:stopCheckEnterMainView()

		return
	end

	self:stopCheckEnterMainView()

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	local date = SignInModel.instance:getCurDate()

	if ViewMgr.instance:isOpen(ViewName.SignInView) or ViewMgr.instance:isOpen(ViewName.SignInDetailView) then
		local targetDate = SignInModel.instance:getSignTargetDate()

		if targetDate[1] ~= tonumber(date.year) or targetDate[2] ~= tonumber(date.month) or targetDate[3] ~= tonumber(date.day) then
			SignInModel.instance:setTargetDate(tonumber(date.year), tonumber(date.month), tonumber(date.day), date.wday)

			self._curMonth = date.month

			self:sendGetSignInInfoRequestIfUnlock()
		end
	else
		TaskDispatcher.runRepeat(self._onCheckEnterMainView, self, 0.5)
	end
end

function SignInController:_onCheckEnterMainView()
	local mainViewguideBlock = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.MainViewGuideBlock)

	if mainViewguideBlock then
		return
	end

	local isInMainView = MainController.instance:isInMainView()

	if not isInMainView then
		return
	end

	local date = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(date.day) then
		self:stopCheckEnterMainView()

		return
	end

	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return
	end

	if GuideController.instance:isGuiding() then
		return
	end

	if not ViewMgr.instance:hasOpenFullView() and ViewMgr.instance:isOpen(ViewName.MainView) then
		SignInModel.instance:setAutoSign(true)
		self:sendGetSignInInfoRequestIfUnlock()

		local data = {}

		data.isBirthday = false

		self:openSignInDetailView(data)
		self:stopCheckEnterMainView()

		self._curMonth = date.month
	end
end

function SignInController:stopCheckEnterMainView()
	TaskDispatcher.cancelTask(self._onCheckEnterMainView, self)
end

function SignInController:openSignInView(param)
	local date = SignInModel.instance:getCurDate()

	SignInModel.instance:setTargetDate(tonumber(date.year), tonumber(date.month), tonumber(date.day), date.wday)
	ViewMgr.instance:openView(ViewName.SignInView, param)
end

function SignInController:openSignInDetailView(param)
	local date = SignInModel.instance:getCurDate()

	if SignInModel.instance:isSignDayRewardGet(date.day) then
		self:openSignInView(param)

		return
	end

	local data = {}

	data.isBirthday = param.isBirthday
	data.callback = param.callback
	data.callbackObj = param.callbackObj

	SignInModel.instance:setTargetDate(tonumber(date.year), tonumber(date.month), tonumber(date.day), date.wday)
	ViewMgr.instance:openView(ViewName.SignInDetailView, data)
end

function SignInController:setSigninReward(co)
	if self:checkIsBirthdayBlock(co) then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
	elseif SignInModel.instance:checkDailyAllowanceIsOpen() then
		if not SignInModel.instance:checkIsFirstGoldDay() then
			local o = SigninRewardMo.New()
			local goldco = SignInModel.instance:getDailyAllowanceBonus()

			if goldco then
				local reward = string.splitToNumber(goldco, "#")

				o:initValue(reward[1], reward[2], reward[3], nil, true)
				table.insert(co, o)
			end

			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
		else
			PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
		end
	else
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
	end
end

function SignInController:getMonthCardSigninReward(co)
	if self:checkIsBirthdayBlock(co) then
		return co
	elseif SignInModel.instance:checkDailyAllowanceIsOpen() and not SignInModel.instance:checkIsFirstGoldDay() then
		local o = SigninRewardMo.New()
		local goldco = SignInModel.instance:getDailyAllowanceBonus()

		if goldco then
			local reward = string.splitToNumber(goldco, "#")

			o:initValue(reward[1], reward[2], reward[3], nil, true)
			table.insert(co, o)
		end

		return co
	end

	return co
end

function SignInController:checkIsBirthdayBlock(rewards)
	for _, co in pairs(rewards) do
		if co and co.materilType == MaterialEnum.MaterialType.SpecialBlock then
			return true
		end
	end

	return false
end

function SignInController:sendGetSignInInfoRequestIfUnlock()
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		return
	end

	SignInRpc.instance:sendGetSignInInfoRequest()
end

function SignInController:checkShowSigninReward(msg)
	local signInReward = msg and msg.signInReward
	local monthReward = msg and msg.monthReward
	local moList = {}

	if monthReward and #monthReward > 0 then
		moList = self:getMaterialMoList(moList, monthReward, true)

		if signInReward and #signInReward > 0 then
			moList = self:getMaterialMoList(moList, signInReward, false)
		end

		moList = self:getMonthCardSigninReward(moList)

		PopupController.instance:addPopupView(PopupEnum.PriorityType.SigninPropView, ViewName.SigninPropView, moList)
	elseif signInReward and #signInReward > 0 then
		moList = self:getMaterialMoList(moList, signInReward, false)

		self:setSigninReward(moList)
	end
end

function SignInController:openSigninPropView(moList)
	for index, mo in ipairs(moList) do
		mo.getApproach = MaterialEnum.GetApproach.MonthCard
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.SigninPropView, ViewName.SigninPropView, moList)
end

function SignInController:getMaterialMoList(list, rewards, isMonthCard)
	for _, v in ipairs(rewards) do
		local uid
		local o = MaterialDataMO.New()

		if v.materilType == MaterialEnum.MaterialType.PowerPotion then
			do
				local latestPowerCo = ItemPowerModel.instance:getLatestPowerChange()

				for _, power in pairs(latestPowerCo) do
					if tonumber(power.itemid) == tonumber(v.materilId) then
						uid = power.uid
					end
				end
			end
		elseif v.materilType == MaterialEnum.MaterialType.NewInsight then
			local latestInsightCo = ItemInsightModel.instance:getLatestInsightChange()

			for _, insight in pairs(latestInsightCo) do
				if tonumber(insight.itemid) == tonumber(v.materilId) then
					uid = insight.uid
				end
			end
		end

		o:initValue(v.materilType, v.materilId, v.quantity, uid, v.roomBuildingLevel, (isMonthCard or nil) and (MaterialEnum.GetApproach.MonthCard or nil))
		table.insert(list, o)
	end

	return list
end

function SignInController:showPatchpropUseView(messageBoxId, msgBoxType, currencyParam, yesCallback, noCallback, openCallback, yesCallbackObj, noCallbackObj, openCallbackObj, ...)
	if not ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		self._isShowSystemMsgBox = false
	end

	if not self._isShowSystemMsgBox then
		local extra = {
			...
		}
		local config = MessageBoxConfig.instance:getMessageBoxCO(messageBoxId)
		local param = {
			messageBoxId = messageBoxId,
			msg = config.content,
			title = config.title,
			currencyParam = currencyParam,
			msgBoxType = msgBoxType,
			yesCallback = yesCallback,
			noCallback = noCallback,
			openCallback = openCallback,
			yesCallbackObj = yesCallbackObj,
			noCallbackObj = noCallbackObj,
			openCallbackObj = openCallbackObj,
			extra = extra
		}

		ViewMgr.instance:openView(ViewName.StoreSupplementMonthCardUseView, param)
	end
end

SignInController.instance = SignInController.New()

return SignInController
