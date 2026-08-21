-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/view/DailySigninFragmentView.lua

module("logic.extensions.signin.view.DailySigninFragmentView", package.seeall)

local M = class("DailySigninFragmentView", DynamicFragmentView)

function M:buildUI()
	self._btnFullScreenSignIn = self:getBtn("daily_signin_panel1_2053098851")
	self._rawRole = self._registry:findUIElement("daily_signin_panel1_-103555691", UIComponentType.RawImage)
	self._photoUnit = PhotoUnit.Get(self._rawRole.gameObject)

	self._photoUnit:clear()

	self._photoCenterPointGo = self._registry:findUIElement("daily_signin_panel1_-1827430968")
	self._btnPhotoUnit = UIComponentType.ButtonAdapter(self._registry:findUIElement("daily_signin_panel1_1646361326"))
	self._talkGo = self._registry:findUIElement("daily_signin_panel1_1380538860")
	self._txtTalk = self._registry:findUIElement("daily_signin_panel1_1892558706", UIComponentType.Text)
	self._rectTabRoot = self._registry:findUIElement("daily_signin_panel1_-1219047403", UIComponentType.RectTransform)
	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(function(tabIndex)
		self:_sendBuryPoint(tabIndex)

		return self:_tabCheckFunc(tabIndex)
	end)

	for i = 0, self._rectTabRoot.childCount - 1 do
		local tmpGo = self._rectTabRoot:GetChild(i).gameObject

		self._toggleTabControl:addToggleTab(goutil.addComponentOnce(tmpGo, UIComponentType.SpaceXToggle))
	end

	local rectItemRoot = self._registry:findUIElement("daily_signin_panel1_-911616826", UIComponentType.RectTransform)

	self._signGroup = {}

	for i = 0, rectItemRoot.childCount - 1 do
		local tmpGo = rectItemRoot:GetChild(i).gameObject
		local day = i + 1
		local shower = Astral.LuaComponentContainer.Add(tmpGo, WelfareSignInItemCell)

		shower:setMainGo(tmpGo)
		shower:setUIIndex(day)

		self._signGroup[day] = shower
	end
end

function M:destroyUI()
	self._btnFullScreenSignIn = nil
	self._activityId = nil
	self._btnPhotoUnit = nil
	self._talkGo = nil
	self._txtTalk = nil
	self._rawRole = nil
	self._photoUnit = nil
	self._photoCenterPointGo = nil
	self._rectTabRoot = nil

	self._toggleTabControl:destroy()

	self._toggleTabControl = nil
	self._signGroup = nil
end

function M:bindEvents()
	self._btnPhotoUnit:AddClickListener(self._onClickModel, self)
	self._btnFullScreenSignIn:AddClickListener(self._onClickFullScreenSignIn, self)
end

function M:unbindEvents()
	self._btnFullScreenSignIn:RemoveClickListener()
	self._btnPhotoUnit:RemoveClickListener()
end

function M:onEnter()
	self._isEnter = true

	self:_setEvent(true)

	self._waitForSign = false

	self:showFullScreenSignInBtn(false)

	local tabId = self.params[1]
	local activityList = WelfareUtil.getActivityListByTabId(tabId)
	local activeData = activityList and activityList[1]

	if activeData then
		local actId = activeData:getId()

		self:setActivityId(actId)
		printWarn("actId", self:getActivityId())
		self:checkOpen()
		self:refreshData()
		self:showHero(self._heroId)
		self:updateShow()
		self:showDialogue()
	end
end

function M:onExit()
	self:_setEvent(false)

	self._isEnter = nil

	if self._photoUnit then
		self._photoUnit:clear()
	end

	removetimer(self._updateTimer, self)
	goutil.setActive(self._talkGo, false)

	if not string.nilorempty(self._voice) then
		WelfareSigninModel.instance:stopVoice(self._voice, self._activityId)
	end

	self._voice = nil

	self:_stopCounter()

	self._lastClickTime = nil

	SigninController.instance:tryPopUpCacheSignInReward()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
	end
end

function M:_handleSignInInfoChange(e)
	self:refreshData()
	self:dealSignInAni()
end

function M:getIsEnter()
	return self._isEnter
end

function M:getMainGo()
	return self.mainGO
end

function M:getActivityId()
	return self._activityId
end

function M:setActivityId(activityId)
	self._activityId = activityId
end

function M:dealSignInAni()
	local actId = self:getActivityId()
	local newData = WelfareSigninModel.instance:getSignInMo(actId)

	if newData then
		local totalSigned = newData:getTotalSigned()
		local uiIndex = 1
		local timeStamp = 0

		if actId == WelfareSigninEnum.DailySignActId then
			uiIndex = totalSigned % 7
			uiIndex = uiIndex == 0 and 7 or uiIndex
			timeStamp = newData:getDayTimeStamp(totalSigned)
		else
			uiIndex = totalSigned
		end

		self:playSignInAni(uiIndex, timeStamp, function()
			self:_refreshNewSignInfo()
			settimer(0.2, function()
				SigninController.instance:tryPopUpCacheSignInReward()

				self._waitForSign = false
			end, self, false)
		end, self)
	else
		self:_refreshNewSignInfo()

		self._waitForSign = false
	end
end

function M:_refreshNewSignInfo()
	local actId = self:getActivityId()

	self:refreshData()
	self:updateShow()

	local todaySigned = false

	self:showFullScreenSignInBtn(not todaySigned)
end

function M:showFullScreenSignInBtn(show, autoSign)
	goutil.setActive(self._btnFullScreenSignIn.gameObject, show)

	if show and autoSign then
		settimer(0.2, function()
			self:_onClickFullScreenSignIn()
		end, self, false)
	end
end

function M:_onClickFullScreenSignIn()
	local actId = self:getActivityId()

	print(actId)

	local actData = WelfareSigninModel.instance:getSignInMo(actId)

	if actData == nil then
		FloatWordMgr.instance:show(lang("tip_activity_over"))

		return
	end

	if not WelfareSigninUtil.getSignInActIsOpen(actId) then
		FloatWordMgr.instance:show(lang("tip_activity_over"))

		return
	end

	self:showFullScreenSignInBtn(false)
end

function M:playSignInAni(uiIndex, timeStamp, callBackFunc, callBackHandler)
	local theItem = self._signGroup[uiIndex]

	if theItem then
		local actTyp = WelfareSigninEnum.ActTyp.DailySignIn

		theItem:playSignAni(actTyp, timeStamp, callBackFunc, callBackHandler)
	else
		callBackHandler:callBackFunc()
	end
end

function M:refreshData()
	local actId = self:getActivityId()
	local signInMo = WelfareSigninModel.instance:getSignInMo(actId)

	if signInMo == nil then
		printError("本地签到数据Mo异常", actId)
		WelfareSigninModel.instance:printAllSignInAct()

		return
	end

	self._typ = signInMo:getActTyp()
	self._landladyFormula = WelfareSigninUtil.getSignInActFormula(actId)
	self._heroId = nil

	local cfgLandLady = WelfareSigninConfig.instance:getLandLady(self._landladyFormula)

	if cfgLandLady then
		self._heroId = cfgLandLady.landlady

		self:_duelDialogue(cfgLandLady.dialogues)
	else
		printError(string.format("无法找到[%s],formula[%d]的配置", ConfigName.SignInLandlady, self._landladyFormula))
	end

	self:checkOpen()

	self._totalSigned = signInMo:getTotalSigned()
end

function M:checkOpen()
	local actMo = ActivityModel.instance:getActivityById(self:getActivityId())

	if actMo then
		if not actMo:getIsOpen() then
			self:_showExpirePopUpContent(lang("tip_activity_over"))

			return false
		end
	else
		self:_showExpirePopUpContent(lang("tip_activity_over"))

		return false
	end

	return true
end

function M:_showExpirePopUpContent(str)
	if self:getIsEnter() then
		FloatWordMgr.instance:show(str)
	end
end

function M:updateShow()
	self._activeIndex = -1

	local oldPage = self._nowDayPage

	self._nowDayPage = math.ceil(self._totalSigned / 7)

	if self._nowDayPage < self._rectTabRoot.childCount and self._totalSigned % 7 == 0 then
		self._nowDayPage = self._nowDayPage + 1
	end

	self._toggleTabControl:selectTab(self._nowDayPage)

	if oldPage and oldPage ~= self._nowDayPage then
		self:showDialogue()
	end
end

function M:setPage(tabIndex)
	local orgIndex = self._activeIndex or -1
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		local actId = self._activityId
		local actTyp = WelfareSigninEnum.ActTyp.DailySignIn
		local todaySigned = false

		printWarn("今天签到:", todaySigned)

		for day, shower in pairs(self._signGroup or {}) do
			local uiIndex = shower:getUIIndex()
			local day = uiIndex + (tabIndex - 1) * 7
			local isSigned = WelfareSigninModel.instance:isItemSigned(actId, actTyp, day)
			local timeStamp = WelfareSigninModel.instance:getItemSignedTimeStamp(actTyp, day)
			local itemId, itemCount = WelfareSigninConfig.instance:getDailyReward(day)

			shower:onEnter()
			shower:setReward(itemId, itemCount)
			shower:setIsSign(isSigned, actTyp, timeStamp)

			local canReceive = not isSigned

			if todaySigned then
				canReceive = false
			end

			canReceive = canReceive and WelfareSigninModel.instance:isItemSigned(actId, actTyp, day - 1)

			shower:setCanReceiveVisible(canReceive)
		end
	end
end

function M:_tabCheckFunc(tabIndex)
	return true
end

function M:showHero(heroId)
	local cfgCharacterLst = BackpackConfig.instance:getCharacterConfig()
	local modelId

	for key, value in pairs(cfgCharacterLst or {}) do
		if value.id == heroId then
			modelId = value.modelId

			break
		end
	end

	local transform = self._photoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {
		isShowEgg = true,
		isShowEnter = true,
		photo = self._photoUnit,
		modelId = modelId,
		cutCenterPos = cutCenterPos,
		iconType = IconType.CharaterBust
	}

	SpineCutShowLoader.showSpineLihuiPhoto(paramTable)
	RawImageUtil.SetColor(self._rawRole, "#FFFFFF00")
	self._rawRole:DOFade(1, 0.6)
	self._photoUnit:playOnce("idle")
	goutil.setActive(self._talkGo, false)

	self._bubbleInterval = 5
	self._canShowBubble = true
	self._min = 1
	self._max = 5
	self._rate = 1
	self._noClickCount = 0

	self:_startCounter()
end

function M:_duelDialogue(dialogueIds)
	self._dialogueLst = {}

	for _, formula in ipairs(dialogueIds or {}) do
		local cfgDialogue = WelfareSigninConfig.instance:getLandLadyDialogue(formula)

		if cfgDialogue then
			table.insert(self._dialogueLst, cfgDialogue)
		else
			printError(string.format("无法找到[%s],formula[%d]的配置", ConfigName.SignInLandladyDialogue, formula))
		end
	end
end

function M:_startCounter()
	self:_stopCounter()
	Scheduler.addListener(1, self._onSecond, self, true)
end

function M:_stopCounter()
	Scheduler.removeListener(self._onSecond, self)
end

function M:_onSecond()
	self._noClickCount = self._noClickCount + 1

	if self._noClickCount >= 30 then
		self._noClickCount = 0

		self:showDialogue()
	end
end

function M:showDialogue()
	self._voice = nil

	if not self._poolDialogue then
		self._poolDialogue = {}
	end

	local len = #self._poolDialogue

	if len == 0 then
		local totalWeight = 0

		for key, value in pairs(self._dialogueLst or {}) do
			local weight = value.weight or 0

			if weight > 0 then
				totalWeight = totalWeight + weight

				table.insert(self._poolDialogue, value)
			end
		end

		if totalWeight <= 0 then
			printWarn(string.format("总权重为0，别说话了,actId[%d],landladyFormula[%d]", self._activityId, self._landladyFormula))

			return
		end

		len = #self._poolDialogue

		if len >= 2 then
			for i = 1, len do
				local rIndex = math.random(1, len)
				local a = self._poolDialogue[i]
				local b = self._poolDialogue[rIndex]

				self._poolDialogue[i] = b
				self._poolDialogue[rIndex] = a
			end
		end
	end

	len = #self._poolDialogue

	if len > 0 then
		local weightDialogue = {}
		local totalWeight = 0

		for index, cfgDialogue in ipairs(self._poolDialogue) do
			local weight = cfgDialogue and cfgDialogue.weight or 0

			if weight > 0 then
				totalWeight = totalWeight + weight
				weightDialogue[index] = {
					theIndex = index,
					formula = cfgDialogue.formula,
					threshold = totalWeight,
					cfg = cfgDialogue
				}
			end
		end

		if totalWeight <= 0 then
			self._poolDialogue = {}

			self:showDialogue()

			return
		end

		local theValForSelect = math.random(1, totalWeight)
		local finalIndex = 1

		for index, value in ipairs(weightDialogue) do
			if theValForSelect <= value.threshold then
				finalIndex = value.theIndex

				break
			end
		end

		local cfgDialogue = weightDialogue[finalIndex].cfg

		self._voice = cfgDialogue.voice
		self._dialogueContent = cfgDialogue.dialogue
		self._poolDialogue[finalIndex] = nil

		local lstAfterUse = {}

		for key, value in pairs(self._poolDialogue or {}) do
			table.insert(lstAfterUse, value)
		end

		self._poolDialogue = lstAfterUse
	end

	self._beginTime = Time.time

	local dialog = self._dialogueContent or ""

	self._txtTalk.text = dialog

	goutil.setActive(self._talkGo, true)

	self._duration = Mathf.Clamp(self._rate * (string.utf8len(dialog) / 10), self._min, self._max)
	self._canShowBubble = false

	if not string.nilorempty(self._voice) then
		self._duration = -1

		WelfareSigninModel.instance:playVoice(self._voice, self._activityId, self.playVoiceFinish, self)
	end

	settimer(0, self._updateTimer, self)
end

function M:_onClickModel()
	if not self._lastClickTime then
		self._lastClickTime = 0
	end

	local nowTime = Time.time

	if nowTime - self._lastClickTime >= 1 then
		self._lastClickTime = nowTime

		self:showDialogue()

		self._noClickCount = 0
	end
end

function M:hideDialogue()
	goutil.setActive(self._talkGo, false)
	settimer(0, self._updateTimer, self)
end

function M:_updateTimer()
	if not self._beginTime then
		return
	end

	local time = Time.time - self._beginTime

	if self._bubbleInterval and self._bubbleInterval ~= 0 and time >= self._bubbleInterval then
		removetimer(self._updateTimer, self)

		self._canShowBubble = true
	elseif time >= self._duration and self._duration > 0 then
		self:hideDialogue()
	end
end

function M:playVoiceFinish(actId)
	if self._activityId == actId then
		self:hideDialogue()
	end

	if Time.time - self._beginTime < 1 then
		self:showDialogue()
	end
end

function M:_fakeOnClickSign()
	local actId = self:getActivityId()

	if WelfareSigninModel.instance:getSignInMo(self:getActivityId()) then
		WelfareSigninUtil.fakeSignIn(self:getActivityId())
	end
end

function M:_sendBuryPoint(tabIndex)
	local toggle = self._toggleTabControl:getTab(tabIndex)

	if not toggle then
		return
	end

	local txtTitle = goutil.findChildTextComponent(toggle.gameObject, "normal/Text")

	if not txtTitle then
		return
	end

	UserUtil.uploadActivityTabBuryPoint(UserUtil.activityFirstTabName, UserUtil.activitySecondTabName, txtTitle.text)
end

return M
