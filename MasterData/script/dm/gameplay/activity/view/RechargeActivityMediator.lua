-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/RechargeActivityMediator.lua

RechargeActivityMediator = class("RechargeActivityMediator", DmAreaViewMediator, _M)

RechargeActivityMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
RechargeActivityMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
RechargeActivityMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["main.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTip"
	},
	["main.startbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onStartbtnClick"
	},
	["main.resetbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onResetbtnClick"
	}
}
local rewardListConfig = {
	{
		x = 190,
		y = 411
	},
	{
		x = 115,
		y = 307
	},
	{
		x = 115,
		y = 179
	},
	{
		x = 190,
		y = 78
	},
	{
		x = 325,
		y = 112
	},
	{
		x = 271,
		y = 189
	},
	{
		x = 271,
		y = 298
	},
	{
		x = 325,
		y = 374
	},
	{
		x = 587,
		y = 374
	},
	{
		x = 642,
		y = 298
	},
	{
		x = 642,
		y = 189
	},
	{
		x = 587,
		y = 112
	},
	{
		x = 721,
		y = 78
	},
	{
		x = 795,
		y = 179
	},
	{
		x = 795,
		y = 307
	},
	{
		x = 721,
		y = 411
	},
	{
		x = 457,
		y = 248
	}
}
local bgInfo = {
	Activity_Gashapon_20211016 = {
		bg1 = "znqd_btn_zy_rukou",
		bg2 = "hd_bg_znqd"
	}
}

function RechargeActivityMediator:initialize()
	super.initialize(self)
end

function RechargeActivityMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._countDowntimer then
		self._countDowntimer:stop()

		self._countDowntimer = nil
	end

	if self._cdTimer then
		self._cdTimer:stop()

		self._cdTimer = nil
	end

	super.dispose(self)
end

function RechargeActivityMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.doReset)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_DIAMOND_RECHARGE_SUCC, self, self.onRechargeSuccCallback)

	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")
	self._leftTimeNode = self._main:getChildByName("TimeNode")
	self._startbtn = self._main:getChildByName("startbtn")
	self._tipText = self._startbtn:getChildByName("tip")
	self._resetbtn = self._main:getChildByName("resetbtn")
	self._rewardList = self._main:getChildByName("rewardList")
	self._cellClone = self:getView():getChildByName("cellClone")
	self._drawTimeText = self._main:getChildByFullName("CountNode.text")
	self._state = 0
	self._resetState = 0

	local anim = cc.MovieClip:create("shiciguang_choukarenwu")

	anim:addTo(self._resetbtn)
	anim:setPosition(cc.p(130, 42))
end

function RechargeActivityMediator:doReset()
	local activity = self._activitySystem:getActivityById(self._activity:getId())

	if not activity then
		self:dismiss()
	end
end

function RechargeActivityMediator:enterWithData(data)
	self._activityId = data.activity:getId()
	self._parentMediator = data.parentMediator

	self:initView()
	self:updateData(true)
	self:refreshLeftTime()
end

function RechargeActivityMediator:initView()
	self._leftTimeNode:setVisible(false)
	self._cellClone:setVisible(false)

	local startbtnText1 = self._startbtn:getChildByFullName("text1")
	local startbtnText2 = self._startbtn:getChildByFullName("text2")
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 218, 68, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 250, 227, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	startbtnText1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	startbtnText2:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))

	local node = self._main:getChildByFullName("startbtnAnim.anim")
	local anim = cc.MovieClip:create("xunmidianzhuan_menghuanzhenbao")

	anim:addTo(node):center(node:getContentSize())

	anim = cc.MovieClip:create("quanquanku_menghuanzhenbao")

	anim:addTo(node):center(node:getContentSize())

	local image2 = self._main:getChildByName("image2")

	anim = cc.MovieClip:create("dabeij_menghuanzhenbao")

	anim:addTo(image2):center(image2:getContentSize()):offset(0, -17)

	local image1 = self._main:getChildByName("image1")

	if bgInfo[self._activityId] then
		image2:loadTexture("asset/lang_ui/activity/" .. bgInfo[self._activityId].bg1 .. ".png", ccui.TextureResType.localType)
		image1:loadTexture("asset/scene/" .. bgInfo[self._activityId].bg2 .. ".jpg", ccui.TextureResType.localType)
	end
end

function RechargeActivityMediator:updateData(isInit)
	self._rewardList:removeAllChildren()

	self._remainingRewards = {}

	if isInit then
		self._activity = self._activitySystem:getActivityById(self._activityId)

		if self._activity then
			self._rewards = self._activity:getRewardList()
		end
	end

	if not self._activity then
		self:normalData()

		return
	end

	self._bigRewardOpen = false

	self._resetbtn:setVisible(false)
	self._drawTimeText:setString(self._activity:getDrawTime())

	local num = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Gashapon_DailyTimes", "content")

	if self._activity:isDailyRecharge() then
		self:startTime(num)
	else
		self._tipText:setString(Strings:get("Recharge_StartBtn_Tips", {
			num = num
		}))
	end

	self:createRewardNode()
end

function RechargeActivityMediator:normalData()
	self:dispatch(ShowTipEvent({
		tip = Strings:get("Recharge_ERROR_Tip2")
	}))
	self._tipText:setVisible(false)
	self._startbtn:setVisible(true)
	self._resetbtn:setVisible(true)

	if not self._activity then
		self._main:getChildByName("tipBtn"):setVisible(false)
		self._startbtn:setVisible(false)
		self._main:getChildByName("startbtnAnim"):setVisible(false)
		self._resetbtn:setVisible(false)
	end
end

function RechargeActivityMediator:startTime(num)
	if self._countDowntimer then
		self._countDowntimer:stop()

		self._countDowntimer = nil
	end

	local nextGetRewardTime = self._activity:getNextGetRewardTime(self._gameServerAgent)

	local function fun()
		local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
		local difference = nextGetRewardTime - remoteTimestamp

		if difference >= 0 then
			local fmtStr = "${H}:${M}:${S}"
			local date = TimeUtil:formatTime(fmtStr, difference)
			local getActivitySurplus = self._activity:getActivitySurplus(self._gameServerAgent)

			if getActivitySurplus <= 86400 then
				self._tipText:setString(Strings:get("Recharge_StartBtn_Tip3", {
					date = date,
					num = num
				}))
			else
				self._tipText:setString(Strings:get("Recharge_StartBtn_Tip2", {
					date = date,
					num = num
				}))
			end
		else
			self._countDowntimer:stop()

			self._countDowntimer = nil

			self._tipText:setString(Strings:get("Recharge_StartBtn_Tips", {
				num = num
			}))
		end
	end

	self._countDowntimer = LuaScheduler:getInstance():schedule(fun, 1, true)
end

function RechargeActivityMediator:createRewardNode()
	local length = #self._rewards

	for i = 1, length do
		local node = self._cellClone:clone()
		local reward = self._rewards[i].data
		local parent = node:getChildByName("ItemIcon")
		local bg4Node = node:getChildByName("bg4")
		local anim = cc.MovieClip:create("tyuityu_menghuanzhenbao")

		node:setName("Reward_" .. self._rewards[i].id)
		node:setVisible(true)
		bg4Node:setVisible(false)
		node:getChildByName("bg5"):setVisible(false)
		node:getChildByName("anim"):setVisible(false)
		anim:addTo(bg4Node):center(bg4Node:getContentSize())
		node:setTag(i)

		if self._rewards[i].state == 0 then
			node:getChildByName("checkde"):setVisible(false)
			node:getChildByName("mask"):setVisible(false)

			self._remainingRewards[#self._remainingRewards + 1] = self._rewards[i]
		else
			node:getChildByName("checkde"):setVisible(true)
			node:getChildByName("mask"):setVisible(true)
		end

		if i == length then
			node:getChildByName("bg5"):setVisible(true)
		end

		local icon

		if i == length then
			icon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				notShowQulity = false,
				isWidget = true
			})

			self:setBigReward(i, node, icon)
		else
			icon = IconFactory:createRewardIcon(reward, {
				showAmount = true,
				notShowQulity = true,
				isWidget = true
			})

			self:setNormalReward(i, node, icon)
		end

		icon:setPosition(parent:getContentSize().width / 2, parent:getContentSize().height / 2)
		icon:setAnchorPoint(0.5, 0.5)
		icon:addTo(parent)
		IconFactory:bindClickHander(icon, IconTouchHandler:new(self._parentMediator), reward, {
			touchDisappear = true,
			swallowTouches = true
		})
		node:addTo(self._rewardList)
	end
end

function RechargeActivityMediator:setNormalReward(index, node, icon)
	local position = rewardListConfig[index]

	node:setPosition(cc.p(position.x, position.y))
	node:getChildByName("bg2"):setVisible(false)
	node:getChildByName("bg3"):setVisible(false)
	icon:setScaleNotCascade(0.49)

	if index > 4 and index < 13 then
		node:getChildByName("bg2"):setVisible(true)
	end
end

function RechargeActivityMediator:setBigReward(index, node, icon)
	local position = rewardListConfig[index]
	local mask = node:getChildByName("mask")

	node:setPosition(cc.p(position.x, position.y))
	node:getChildByName("bg1"):setVisible(false)
	node:getChildByName("checkde"):setScale(1.6)
	node:getChildByName("bg4"):setScale(2)
	node:getChildByName("bg4"):setPosition(cc.p(49, 62))
	node:getChildByName("ItemIcon"):setPosition(cc.p(53, 58))
	node:getChildByName("bg2"):setVisible(false)

	if node:getChildByName("bg5"):isVisible() then
		node:getChildByName("bg5"):setContentSize(icon:getContentSize())
		node:getChildByName("bg5"):setPosition(cc.p(53, 58))
		mask:setRotation(0)
		mask:setContentSize(node:getContentSize())
		mask:setPosition(cc.p(53, 58))
	else
		mask:setScale(2)
	end

	if node:getChildByName("checkde"):isVisible() then
		self._bigRewardOpen = true

		self._resetbtn:setVisible(true)
	else
		local bg3 = node:getChildByName("bg3")
		local anim = cc.MovieClip:create("zhongjiandilizi_menghuanzhenbao")

		anim:setPosition(cc.p(35, 65))
		anim:setName("lizi")
		anim:addTo(bg3)
	end
end

function RechargeActivityMediator:onClickTip()
	local view = self:getInjector():getInstance("RechargeTipView")
	local ruleDesc = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Gashapon_Rule", "content").RuleDesc

	self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		info = ruleDesc
	}))
end

function RechargeActivityMediator:refreshLeftTime()
	self._leftTimeNode:setVisible(true)
	self:setTimer()
end

function RechargeActivityMediator:onStartbtnClick()
	if self._resetState == 1 or self._state == 1 then
		return
	end

	self._state = 1

	AudioEngine:getInstance():playEffect("Se_Click_Story_Dream", false)

	if self._activity:getDrawTime() == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Recharge_ERROR_Tip1")
		}))

		self._state = 0

		return
	end

	if self:isActivityOver() then
		self:normalData()

		self._state = 0

		return
	end

	local param = {
		doActivityType = 101
	}

	self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
		if checkDependInstance(self) then
			self:onLuckdrawSucc(response.data)
		end
	end)
end

function RechargeActivityMediator:onLuckdrawSucc(data)
	local rewardCount = #self._remainingRewards

	if rewardCount > 1 then
		self:luckdrawAnim(data, rewardCount)
	else
		self:choujiangAnim(data)
	end
end

function RechargeActivityMediator:luckdrawAnim(data, rewardCount)
	local twinkleCount = rewardCount / 2 + 1
	local lastIndex = 0

	twinkleCount = math.floor(math.abs(twinkleCount + 0.5))

	local function checkTimeFunc()
		if lastIndex > 0 then
			self._rewardList:getChildByName("Reward_" .. self._remainingRewards[lastIndex].id):getChildByName("bg4"):setVisible(false)
		end

		if twinkleCount == 0 then
			self:choujiangAnim(data)
			self._timer:stop()

			self._timer = nil

			return
		end

		local index = self:getRandomReward(lastIndex)

		self._rewardList:getChildByName("Reward_" .. self._remainingRewards[index].id):getChildByName("bg4"):setVisible(true)

		lastIndex = index
		twinkleCount = twinkleCount - 1
	end

	if not self._timer then
		AudioEngine:getInstance():playEffect("Se_Effect_Combo", false)

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 0.08, false)

		checkTimeFunc()
	end
end

function RechargeActivityMediator:choujiangAnim(data)
	local node = self._rewardList:getChildByName("Reward_" .. data.rewardId)
	local animNode = node:getChildByName("anim")

	local function fun(type)
		local view = self:getInjector():getInstance("getRewardView")

		AudioEngine:getInstance():playEffect(type, false)
		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			rewards = data.reward[1]
		}))
		self:luckdrawCall(data)
	end

	AudioEngine:getInstance():playEffect("Se_Effect_Single", false)
	self:createCjAnim(node, fun)
end

function RechargeActivityMediator:createCjAnim(node, callback)
	local animNode = node:getChildByName("anim")

	local function fun1(type)
		callback(type)
	end

	local function fun2()
		animNode:setVisible(false)
		animNode:removeAllChildren()
	end

	animNode:setVisible(true)

	if node:getChildByName("bg3"):isVisible() then
		local anim = cc.MovieClip:create("chen_menghuanzhenbao")

		anim:setPosition(cc.p(53, 53))
		anim:addCallbackAtFrame(20, function()
			fun1("Se_Effect_Orange")
		end)
		anim:addEndCallback(fun2)
		anim:addTo(animNode)
	else
		local anim = cc.MovieClip:create("zi_menghuanzhenbao")

		anim:setPosition(cc.p(53, 53))
		anim:setScale(0.4)
		anim:addCallbackAtFrame(15, function()
			fun1("Se_Effect_Purple")
		end)
		anim:addEndCallback(fun2)
		anim:addTo(animNode)
	end
end

function RechargeActivityMediator:luckdrawCall(data)
	self._state = 0

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	for i = 1, #self._rewards do
		if self._rewards[i].id == data.rewardId then
			self._rewards[i].state = 1

			break
		end
	end

	self:updateData()

	if data.isRefresh then
		self:resetReward(true)
	end
end

function RechargeActivityMediator:getRandomReward(excludeIndex)
	local result

	while true do
		local random = math.random(#self._remainingRewards)

		if random ~= excludeIndex then
			result = random

			break
		end
	end

	return result
end

function RechargeActivityMediator:onResetbtnClick()
	if self._resetState == 1 or self._state == 1 then
		return
	end

	self._resetState = 1

	if not self._bigRewardOpen then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Recharge_ResetTip_Not")
		}))

		self._resetState = 0
	elseif self:isActivityOver() then
		self._resetState = 0

		self:normalData()
	else
		local view = self:getInjector():getInstance("AlertView")
		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = Strings:get("Recharge_ResetTip_Content"),
			sureBtn = {},
			cancelBtn = {}
		}
		local delegate = {}
		local this = self

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				this:resetReward()
			else
				this._resetState = 0
			end
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
	end
end

function RechargeActivityMediator:resetReward(isRefresh)
	self._resetState = 1

	local param = {
		doActivityType = 102
	}

	if not isRefresh then
		self._activitySystem:requestDoActivity(self._activity:getId(), param, function(response)
			if checkDependInstance(self) then
				self:resetRewardSuccess()
			end
		end)
	else
		self:resetRewardSuccess()
	end
end

function RechargeActivityMediator:resetRewardSuccess()
	self._resetState = 1

	local callback1 = cc.CallFunc:create(function()
		self:updateData(true)
	end)
	local callback2 = cc.CallFunc:create(function()
		self._resetState = 0
	end)
	local fadeTo1 = cc.FadeTo:create(0.5, 0)
	local fadeTo2 = cc.FadeTo:create(0.5, 10)
	local fadeTo3 = cc.FadeTo:create(1, 255)
	local sequence = cc.Sequence:create(fadeTo1, fadeTo2, callback1, fadeTo3, callback2)

	self._rewardList:runAction(sequence)
end

function RechargeActivityMediator:createResetAnim(node)
	local animNode = node:getChildByName("anim")
	local anim

	if node:getChildByName("bg3"):isVisible() then
		anim = cc.MovieClip:create("chen_menghuanzhenbao")

		anim:setPosition(cc.p(53, 53))
		anim:setName("reset")
		anim:addTo(animNode)
		anim:stop()
	else
		anim = cc.MovieClip:create("zi_menghuanzhenbao")

		anim:setPosition(cc.p(53, 53))
		anim:setName("reset")
		anim:addTo(animNode)
		anim:stop()
	end

	return anim
end

function RechargeActivityMediator:isActivityOver()
	local curTime = self._gameServerAgent:remoteTimeMillis()

	return curTime >= self._activity:getEndTime()
end

function RechargeActivityMediator:stopTimer()
	if self._cdTimer then
		self._cdTimer:stop()

		self._cdTimer = nil
	end
end

function RechargeActivityMediator:setTimer()
	self:stopTimer()

	if not self._activity then
		return
	end

	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = self._activity:getEndTime() / 1000

	if remoteTimestamp < endMills and not self._cdTimer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()

			local endMills = self._activity:getEndTime() / 1000
			local remainTime = endMills - remoteTimestamp

			if math.floor(remainTime) <= 0 then
				self:stopTimer()

				return
			end

			local str = ""
			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

			local text = self._leftTimeNode:getChildByFullName("text")

			text:setString(str .. Strings:get("Activity_Collect_Finish"))
		end

		checkTimeFunc()

		self._cdTimer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)
	elseif remainTime <= 0 then
		self:normalData()
	end
end

function RechargeActivityMediator:onRechargeSuccCallback(event)
	self:updateData(true)
end
