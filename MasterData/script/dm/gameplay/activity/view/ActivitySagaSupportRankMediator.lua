-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/ActivitySagaSupportRankMediator.lua

ActivitySagaSupportRankMediator = class("ActivitySagaSupportRankMediator", DmPopupViewMediator, _M)

ActivitySagaSupportRankMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	["main.checkRankListBtn.button"] = {
		func = "onCheckRankListBtn"
	}
}
local statusText1 = {
	[ActivitySupportStatus.NotStarted] = Strings:get("Activity_Saga_UI_3_1"),
	[ActivitySupportStatus.Preparing] = Strings:get("Activity_Saga_UI_3"),
	[ActivitySupportStatus.Starting] = "times",
	[ActivitySupportStatus.Ended] = Strings:get("Activity_Saga_UI_4")
}
local cellBgImg = {
	"hd_rank_no1.png",
	"hd_rank_no2.png",
	"hd_rank_no3.png",
	"hd_rank_no4.png"
}

function ActivitySagaSupportRankMediator:initialize()
	super.initialize(self)
end

function ActivitySagaSupportRankMediator:dispose()
	self:disposeView()
	super.dispose(self)
end

function ActivitySagaSupportRankMediator:disposeView()
	self:stopTimer()
end

function ActivitySagaSupportRankMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bgNode", PopupNormalWidget, {
		ignoreTitleNodeBg = true,
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Activity_Saga_UI_47"),
		title1 = Strings:get("Activity_Saga_UI_48"),
		bgSize = {
			width = 1134,
			height = 620
		}
	})

	self._main = self:getView():getChildByFullName("main")

	self:bindWidget("main.checkRankListBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self._main:getChildByFullName("tipTxt1"):setString(Strings:get("Activity_Saga_UI_51"))

	self._contentPanel = self:getView():getChildByFullName("clonePanel")

	self._contentPanel:setVisible(false)
	self._contentPanel:getChildByFullName("rankTxt"):enableOutline(cc.c4b(37, 36, 36, 153), 2)
end

function ActivitySagaSupportRankMediator:enterWithData(data)
	self._periodId = data.periodId
	self._activityId = data.activityId or ActivityId.kActivityBlockZuoHe
	self._activity = self._activitySystem:getActivityById(self._activityId)
	self._data = self._activity:getSupportCurPeriodData(self._periodId)

	if not self._data then
		return
	end

	self:initView()
	self:initContent()
end

function ActivitySagaSupportRankMediator:resumeWithData()
	return
end

function ActivitySagaSupportRankMediator:initView()
	local data = self._data.data

	if not data then
		return
	end

	local timeTxt = statusText1[data.status]

	self._main:getChildByFullName("tipTxt2"):setString(Strings:get("Activity_Saga_UI_50") .. timeTxt)

	if timeTxt == "times" then
		self:setTimer(data.resetTime, Strings:get("Activity_Saga_UI_50"), ActivitySupportStatus.Starting, self._main:getChildByFullName("tipTxt2"))
	end

	self._main:getChildByFullName("tipTxt"):setString(Strings:get("Activity_Saga_UI_49") .. Strings:get(self._data.config.Name))

	if self._activityId == ActivityId.kActivityWxh or self._activity:getUI() == ActivityType_UI.KActivityReZhan then
		self._main:getChildByFullName("TText2"):setString(Strings:get("Activity_Saga_UI_43_wxh"))
		self._main:getChildByFullName("TText4"):setString(Strings:get("Activity_Saga_UI_43_wxh"))
		self._main:getChildByFullName("tipTxt1"):setString(Strings:get("Activity_Saga_UI_51_wxh"))
	end

	if self._activity:getUI() == ActivityType_UI.KActivitySupportHoliday then
		self._main:getChildByFullName("TText1"):setString(Strings:get("SingingCompetition_WinFanRank"))
		self._main:getChildByFullName("TText3"):setString(Strings:get("SingingCompetition_LoseFanRank"))
		self._main:getChildByFullName("TText2"):setString(Strings:get("SingingCompetition_FanRank"))
		self._main:getChildByFullName("TText4"):setString(Strings:get("SingingCompetition_FanRank"))
		self._main:getChildByFullName("tipTxt"):setVisible(false)
		self._main:getChildByFullName("tipTxt2"):setAnchorPoint(0, 0.5)
		self._main:getChildByFullName("tipTxt2"):posite(self._main:getChildByFullName("tipTxt"):getPosition())
		self._main:getChildByFullName("tipTxt1"):setString(Strings:get("SingingCompetition_Rank_BottomTip"))
	end
end

function ActivitySagaSupportRankMediator:initContent()
	self:createContent(self._main:getChildByFullName("listview"), self._data.config.WinnerReward)
	self:createContent(self._main:getChildByFullName("listview1"), self._data.config.LoserReward)
end

function ActivitySagaSupportRankMediator:createContent(view, data)
	table.sort(data, function(a, b)
		return a.rank[1] < b.rank[1]
	end)
	view:setScrollBarEnabled(false)
	view:setSwallowTouches(false)
	view:removeAllChildren(true)

	for i = 1, #data do
		local panel = self._contentPanel:clone()

		panel:setVisible(true)
		view:pushBackCustomItem(panel)
		self:setCellView(panel, data[i], i)
	end
end

function ActivitySagaSupportRankMediator:setCellView(panel, data, index)
	local imgIdx = index < 4 and index or 4

	panel:getChildByFullName("bg"):loadTexture(cellBgImg[imgIdx], 1)

	local b = data.rank[2]
	local e = data.rank[1]
	local rankTxt = panel:getChildByFullName("rankTxt")

	rankTxt:setString(b .. "-" .. e)

	if RankTopImage[b] then
		rankTxt:setString("")

		local image = ccui.ImageView:create(RankTopImage[data.rank[2]], 1)

		image:addTo(rankTxt):posite(60, 35)
	end

	if b > 4 then
		rankTxt:setFontSize(26)
	else
		rankTxt:setFontSize(30)
	end

	local rewardPanel = panel:getChildByFullName("rewardPanel")
	local rewards = RewardSystem:getRewardsById(data.reward)

	if rewards then
		for i, rewardData in pairs(rewards) do
			local icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:setAnchorPoint(cc.p(0, 0))
			icon:setScaleNotCascade(0.55)
			icon:addTo(rewardPanel):posite(10 + (i - 1) * 74, 0)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
				needDelay = true
			})
		end
	end
end

function ActivitySagaSupportRankMediator:onClickBack()
	self:close()
end

function ActivitySagaSupportRankMediator:onCheckRankListBtn()
	if self._data.data.status == ActivitySupportStatus.NotStarted then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Activity_Saga_SupportList_8")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._activitySystem:enterSagaSupportRankRewardView(self._activityId, self._periodId)
end

function ActivitySagaSupportRankMediator:stopTimer()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ActivitySagaSupportRankMediator:setTimer(_times, _text, _status, _node)
	local gameServerAgent = self:getInjector():getInstance("GameServerAgent")
	local remoteTimestamp = gameServerAgent:remoteTimestamp()
	local endMills = _times * 0.001
	local remainTime = endMills - remoteTimestamp
	local fmtStr = "${H}:${M}:${S}"
	local txt = TimeUtil:formatTime(fmtStr, remainTime)

	_node:setString(_text .. txt)

	if remainTime > 0 and not self._timer then
		local function checkTimeFunc()
			remoteTimestamp = gameServerAgent:remoteTimestamp()
			remainTime = endMills - remoteTimestamp

			if remainTime <= 0 then
				self:stopTimer()

				return
			end

			local txt = TimeUtil:formatTime(fmtStr, remainTime)

			_node:setString(_text .. txt)
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end
