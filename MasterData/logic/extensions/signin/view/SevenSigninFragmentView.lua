-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/signin/view/SevenSigninFragmentView.lua

module("logic.extensions.signin.view.SevenSigninFragmentView", package.seeall)

local M = class("SevenSigninFragmentView", DynamicFragmentView)
local kDayCount = 7
local kRemainMaxDay = 99

function M:buildUI()
	self._txtTime = self._registry:getText("seven_signin_panel1_-578507284")
	self._rectContent = self._registry:getRectTransform("seven_signin_panel1_2065227596")

	local gridLayoutGroup = self._registry:getUIComponent("seven_signin_panel1_-284405984", UIComponentType.GridLayoutGroup)

	self._cellWidth = gridLayoutGroup.cellSize.x + gridLayoutGroup.spacing.x

	local rectItemRoot = self._registry:getRectTransform("seven_signin_panel1_-284405984")

	self._signGroup = {}

	for i = 0, rectItemRoot.childCount - 1 do
		local tmpGo = rectItemRoot:GetChild(i).gameObject
		local shower = Astral.LuaComponentContainer.Add(tmpGo, WelfareSignInItemCell)

		self._signGroup[i + 1] = shower
	end

	self._signLineItems = {}

	local tranfLineGroup = self._registry:getTransform("seven_signin_panel1_-2084906846")

	for i = 0, tranfLineGroup.childCount - 1 do
		local goLine = tranfLineGroup:GetChild(i).gameObject

		self._signLineItems[i + 1] = {
			point1 = goutil.findChild(goLine, "point1"),
			point2 = goutil.findChild(goLine, "point2"),
			canvas = goLine:GetComponent(ComponentType.CanvasGroup)
		}
	end
end

function M:destroyUI()
	self._txtTime = nil
	self._signGroup = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._isEnter = true

	self:_setEvent(true)

	local tabId = self.params[1]
	local activityList = WelfareUtil.getActivityListByTabId(tabId)
	local activeData = activityList and activityList[1]

	if activeData then
		local actId = activeData:getId()

		self:setActivityId(actId)
		self:updateShow()
		self:_updateContentPos()
		self:checkOpen()
	end
end

function M:onExit()
	self:_setEvent(false)

	self._isEnter = nil

	SigninController.instance:tryPopUpCacheSignInReward()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.SIGN_IN_RECEIVE_REWARD, self._onReceiveReward, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_INFO_CHANGE, self._handleSignInInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.SIGN_IN_RECEIVE_REWARD, self._onReceiveReward, self)
	end
end

function M:_handleSignInInfoChange(e)
	if WelfareSigninUtil.getSignInActIsOpen(self:getActivityId()) then
		self:updateShow()
	else
		FloatWordMgr.instance:show(lang("tip_activity_over"))
	end
end

function M:_onReceiveReward(e, actvityId, day)
	if self._activityId == actvityId then
		self:dealSignInAni(day)
	end
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

function M:dealSignInAni(day)
	local theItem = self._signGroup[day]

	if not theItem:getIsSign() then
		local theItem = self._signGroup[day]

		if theItem then
			theItem:playSignAni(self._playSignInAniCallBack, self)
		else
			self:_playSignInAniCallBack()
		end
	end
end

function M:_playSignInAniCallBack()
	self:updateShow()
	settimer(0.2, function()
		SigninController.instance:tryPopUpCacheSignInReward()
	end, self, false)
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
	local actId = self:getActivityId()
	local formula = WelfareSigninUtil.getSignInActFormula(actId)

	for day, shower in pairs(self._signGroup or {}) do
		local isReceived = WelfareSigninModel.instance:isReceived(actId, day)
		local rewardTable = WelfareSigninConfig.instance:getHistoryReward(formula, day)
		local itemId = rewardTable and rewardTable.code or 0
		local itemCount = rewardTable and rewardTable.num or 0
		local canReceive = self:_isCanReceive(day)
		local rewardType = WelfareSigninConfig.instance:getSevenSignInRewardTye(formula, day)
		local data = {
			day = day,
			rewardType = rewardType,
			itemId = itemId,
			itemCount = itemCount,
			isReceived = isReceived,
			canReceive = canReceive,
			activityId = actId
		}

		shower:setData(data)
	end

	self:updateEndTime(WelfareSigninUtil.getSignInActRemainTime(actId))
	self:_updateLineGroup()
end

function M:_updateContentPos()
	local receivedCount = 0

	for day = 1, kDayCount - 4 do
		local isReceived = WelfareSigninModel.instance:isReceived(self._activityId, day)

		if not isReceived then
			break
		end

		receivedCount = isReceived and receivedCount + 1 or receivedCount
	end

	local offsetX = self._cellWidth * receivedCount

	RectTransformUtils.SetAnchoredPosition(self._rectContent, -offsetX, 0)
end

function M:_updateLineGroup()
	for day = 1, kDayCount do
		local canReceive = self:_isCanReceive(day)
		local isReceived = WelfareSigninModel.instance:isReceived(self._activityId, day)
		local item = self._signLineItems[day]

		goutil.setActive(item.point1, not canReceive)
		goutil.setActive(item.point2, canReceive)

		item.canvas.alpha = (canReceive or isReceived) and 0.8 or 0.2
	end
end

function M:_isCanReceive(day)
	return WelfareSigninModel.instance:isCanReceive(self._activityId, day)
end

function M:updateEndTime(day, hour, minute, second)
	local timeStr

	if day == 0 then
		if hour > 0 then
			hour = (minute > 0 or second > 0) and hour + 1 or hour
			timeStr = string.format(lang("tip_left_xx_hour"), hour)
		else
			minute = minute <= 1 and 1 or second > 0 and minute + 1 or minute
			timeStr = string.format(lang("tip_left_xx_min"), minute)
		end
	else
		day = (hour > 0 or minute > 0) and day + 1 or day
		timeStr = string.format(lang("tip_left_xx_day"), day)
	end

	if day > kRemainMaxDay then
		timeStr = lang("tip_daily_refresh_hint")
	end

	self._txtTime.text = timeStr

	local timeRoot = self._txtTime.transform.parent.gameObject

	goutil.setActive(timeRoot, true)
end

function M:_fakeOnClickSign()
	if WelfareSigninModel.instance:getSignInMo(self:getActivityId()) then
		WelfareSigninUtil.fakeSignIn(self:getActivityId())
	end
end

return M
