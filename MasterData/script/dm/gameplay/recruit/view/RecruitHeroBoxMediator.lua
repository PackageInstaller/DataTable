-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitHeroBoxMediator.lua

RecruitHeroBoxMediator = class("RecruitHeroBoxMediator", DmPopupViewMediator, _M)

RecruitHeroBoxMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")

local kBtnHandlers = {}

function RecruitHeroBoxMediator:initialize()
	super.initialize(self)
end

function RecruitHeroBoxMediator:dispose()
	if self._ruleWidget then
		self._ruleWidget:dispose()

		self._ruleWidget = nil
	end

	if self._resetTimer then
		self._resetTimer:stop()

		self._resetTimer = nil
	end

	super.dispose(self)
end

function RecruitHeroBoxMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:glueFieldAndUi()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUIT_BOX_GET_SUCC, self, self.onRecruitBoxGetSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onResetRefresh)
end

function RecruitHeroBoxMediator:glueFieldAndUi()
	local view = self:getView()

	self._main = view:getChildByFullName("main")
	self._loadingBar = self._main:getChildByFullName("loadingBar")

	self._loadingBar:setScale9Enabled(true)
	self._loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	local bgNode = self._main:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		ignoreBtnBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Recruit_box"),
		title1 = Strings:get("UITitle_EN_Zhouchangjiajiang")
	})

	local resetText = self._main:getChildByFullName("reset_text")
	local Text_31 = self._main:getChildByFullName("Text_31")

	resetText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	Text_31:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)

	for i = 1, 5 do
		local Text_num = self._main:getChildByFullName("box_" .. i .. ".Text_num")

		Text_num:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	end
end

function RecruitHeroBoxMediator:enterWithData(data)
	local recruitManager = self._recruitSystem:getManager()
	local recruitTimes = recruitManager:getBoxRewardRecruitTimes()
	local boxesData = recruitManager:getBoxesData()
	local recruitTimesText = self._main:getChildByFullName("recruit_num")

	recruitTimesText:setString("")
	recruitTimesText:removeAllChildren()

	local content = Strings:get("Recruit_Desc2", {
		recruitCount = recruitTimes,
		fontName = TTF_FONT_FZYH_R
	})
	local descText = ccui.RichText:createWithXML(content, {})

	descText:setAnchorPoint(cc.p(0.5, 0))
	descText:addTo(recruitTimesText)

	for index = 1, #boxesData do
		local boxData = boxesData[index]
		local box = self._main:getChildByFullName("box_" .. index)

		box:ignoreContentAdaptWithSize(true)

		local targetText = box:getChildByFullName("Text_num")

		targetText:setString(boxData.times .. Strings:get("Recruit_UI7"))

		local normal = box:getChildByName("normal")
		local canReceive = box:getChildByName("canReceive")
		local hasReceive = box:getChildByName("hasReceive")

		box:addClickEventListener(function()
			self:onClickBox(boxData)
		end)

		local state = boxData.state

		if state == RecruitBoxState.kCannotReceive then
			normal:setVisible(true)
			canReceive:setVisible(false)
			hasReceive:setVisible(false)
		elseif state == RecruitBoxState.kCanReceive then
			normal:setVisible(false)
			canReceive:setVisible(true)
			hasReceive:setVisible(false)
		elseif state == RecruitBoxState.kHasReceived then
			normal:setVisible(false)
			canReceive:setVisible(false)
			hasReceive:setVisible(true)
		end
	end

	self:refreshBoxes()
	self:setupResetTimer()
end

function RecruitHeroBoxMediator:setupResetTimer()
	local resetText = self._main:getChildByFullName("reset_text")
	local deltaTime = self:calcResetTimeDifference()
	local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local starTime = deltaTime + remoteTimestamp

	local function update()
		local timeStr = TimeUtil:formatTime("${d}天${HH}:${MM}:${SS}", deltaTime)

		resetText:setString(timeStr .. " " .. Strings:get("Recruit_UI5"))

		local remoteTimestamp1 = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()

		deltaTime = starTime - remoteTimestamp1

		if deltaTime < 0 and self._resetTimer then
			self._resetTimer:stop()

			self._resetTimer = nil
		end
	end

	if self._resetTimer then
		self._resetTimer:stop()

		self._resetTimer = nil
	end

	self._resetTimer = LuaScheduler:getInstance():schedule(update, 1, true)
end

function RecruitHeroBoxMediator:refreshBoxes()
	local recruitManager = self._recruitSystem:getManager()
	local boxesData = recruitManager:getBoxesData()
	local recruitTimes = recruitManager:getBoxRewardRecruitTimes()

	for index = 1, #boxesData do
		local boxData = boxesData[index]
		local box = self._main:getChildByFullName("box_" .. index)
		local normal = box:getChildByName("normal")
		local canReceive = box:getChildByName("canReceive")
		local hasReceive = box:getChildByName("hasReceive")
		local state = boxData.state

		if state == RecruitBoxState.kCannotReceive then
			normal:setVisible(true)
			canReceive:setVisible(false)
			hasReceive:setVisible(false)
		elseif state == RecruitBoxState.kCanReceive then
			normal:setVisible(false)
			canReceive:setVisible(true)
			hasReceive:setVisible(false)
		elseif state == RecruitBoxState.kHasReceived then
			normal:setVisible(false)
			canReceive:setVisible(false)
			hasReceive:setVisible(true)
		end
	end

	local PercentMap = {
		[20] = 29.5,
		[10] = 8,
		[69] = 90,
		[70] = 100,
		[50] = 71.5,
		[35] = 50
	}

	local function getPercent(recruitTimes)
		if PercentMap[recruitTimes] then
			return PercentMap[recruitTimes]
		end

		local percent = 0

		if recruitTimes < 10 then
			percent = PercentMap[10] * recruitTimes / 10
		elseif recruitTimes > 10 and recruitTimes < 20 then
			percent = (PercentMap[20] - PercentMap[10]) * (recruitTimes - 10) / 10 + PercentMap[10]
		elseif recruitTimes > 20 and recruitTimes < 35 then
			percent = (PercentMap[35] - PercentMap[20]) * (recruitTimes - 20) / 15 + PercentMap[20]
		elseif recruitTimes > 35 and recruitTimes < 50 then
			percent = (PercentMap[50] - PercentMap[35]) * (recruitTimes - 35) / 15 + PercentMap[35]
		elseif recruitTimes > 50 and recruitTimes < 69 then
			percent = (PercentMap[69] - PercentMap[50]) * (recruitTimes - 50) / 19 + PercentMap[50]
		elseif recruitTimes > 70 then
			percent = 100
		end

		return percent
	end

	local percent = getPercent(recruitTimes)

	self._loadingBar:setPercent(percent)
end

function RecruitHeroBoxMediator:onResetRefresh(event)
	local data = event:getData()

	if data and data[ResetId.kRecruitDiamondTimes] then
		self:refreshView()
	end
end

function RecruitHeroBoxMediator:calcResetTimeDifference()
	local currentTime = self:getInjector():getInstance("GameServerAgent"):remoteTimestamp()
	local currentDate = os.date("*t", currentTime)
	local targetWday = 2
	local targetHour = 5
	local targetMin = 0
	local targetSec = 0
	local deltaWday = targetWday - currentDate.wday
	local deltaHour = targetHour - currentDate.hour
	local deltaMin = targetMin - currentDate.min
	local deltaSec = targetSec - currentDate.sec
	local deltaTime = deltaWday * 24 * 60 * 60 + deltaHour * 60 * 60 + deltaMin * 60 + deltaSec

	if deltaTime < 0 then
		deltaTime = 604800 + deltaTime
	end

	return deltaTime
end

function RecruitHeroBoxMediator:onClickClose(sender, eventType)
	self:close()
end

function RecruitHeroBoxMediator:onClickBox(boxData)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local boxState = boxData.state

	if boxState == RecruitBoxState.kCanReceive then
		-- block empty
	else
		local recruitManager = self._recruitSystem:getManager()
		local recruitTimes = recruitManager:getBoxRewardRecruitTimes()
		local view = self:getInjector():getInstance("recruitHeroBoxDetailView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			boxData = boxData,
			recruitTimes = recruitTimes
		}))
	end
end

function RecruitHeroBoxMediator:refreshView()
	local recruitManager = self._recruitSystem:getManager()
	local recruitTimes = recruitManager:getBoxRewardRecruitTimes()
	local text2 = self._main:getChildByFullName("desc_text1")
	local recruitTimesText = self._main:getChildByFullName("recruit_num")

	recruitTimesText:setString(recruitTimes)
	text2:setPositionX(recruitTimesText:getPositionX() + recruitTimesText:getContentSize().width + 5)
	self:refreshBoxes()
	self:setupResetTimer()
end

function RecruitHeroBoxMediator:onRecruitBoxGetSucc(event)
	self:refreshBoxes()

	local data = event:getData()
	local rewards = data.data.rewards
	local view = self:getInjector():getInstance("getRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		rewards = rewards
	}))
end
