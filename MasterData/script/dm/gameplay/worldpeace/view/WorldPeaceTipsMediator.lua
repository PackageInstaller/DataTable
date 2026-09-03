-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceTipsMediator.lua

WorldPeaceTipsMediator = class("WorldPeaceTipsMediator", DmPopupViewMediator, _M)

WorldPeaceTipsMediator:has("_worldPeaceSystem", {
	is = "r"
}):injectWith("WorldPeaceSystem")
WorldPeaceTipsMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.btn_rank"] = {
		ignoreClickAudio = true,
		func = "onClickReward"
	}
}
local RoundCloseText = {
	"ClubMapBoss_Result_Pause2",
	"ClubMapBoss_Result_Pause2",
	"ClubMapBoss_Result_Pause2"
}

function WorldPeaceTipsMediator:initialize()
	super.initialize(self)
end

function WorldPeaceTipsMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function WorldPeaceTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByFullName("main")
	self._roundText = self._main:getChildByFullName("Text_desc")
	self._timeText = self._main:getChildByFullName("Text_time")
	self._rankBtn = self._main:getChildByFullName("btn_rank")

	self._rankBtn:setVisible(false)

	self._tipsText = self._main:getChildByFullName("Text_tips")

	self._tipsText:setVisible(false)

	self._touchPanel = self._main:getChildByFullName("touchpanel")

	self._touchPanel:setTouchEnabled(true)
	self._touchPanel:setLocalZOrder(9999)

	local function enterView()
		self:close()
		self._worldPeaceSystem:enterBattleResultTips()
	end

	self._touchPanel:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._main:stopAllActions()
			enterView()
		end
	end)

	local function func()
		enterView()
	end

	self._main:runAction(DelayAction:create(func, 3))
end

function WorldPeaceTipsMediator:enterWithData(data)
	self:setupView()
	self:startTimer()
	self:refreshRedPoint()
end

function WorldPeaceTipsMediator:setupView()
	local status = self._worldPeaceSystem:getStatus()

	if status == WPStatus.kPrepare then
		self._timeText:setVisible(false)
		self._tipsText:setVisible(true)
		self._roundText:setPositionY(325)
		self._roundText:setFontSize(50)
	else
		local index = self._worldPeaceSystem:getTodaySeasonDayIndex()

		self._roundText:setString(Strings:get(RoundCloseText[index]))
	end
end

function WorldPeaceTipsMediator:refreshRedPoint()
	local node = RedPoint:createDefaultNode()
	local redPoint = RedPoint:new(node, self._rankBtn, function()
		return self._worldPeaceSystem:redPointShow()
	end)

	redPoint:posite(260, 40)
end

function WorldPeaceTipsMediator:startTimer()
	local timeList = self._worldPeaceSystem:getTimeList()

	self._oldStatus = self._worldPeaceSystem:getStatus()

	local format = Strings:get("Common_Time_07")

	local function update()
		local curTime = self._gameServerAgent:remoteTimestamp()
		local status = self._worldPeaceSystem:getStatus()

		if self._oldStatus ~= status then
			timeList = self._worldPeaceSystem:getTimeList()
			self._oldStatus = status
		end

		if status == WPStatus.kPrepare then
			local remainTime = math.max(timeList.battleStartTime - curTime, 0)

			self._roundText:setString(Strings:get("ClubMapBoss_State_Open1") .. TimeUtil:formatTime(format, remainTime))
		elseif status == WPStatus.kBattleRest then
			local remainTime = math.max(timeList.battleStartTime - curTime, 0)

			self._timeText:setString(Strings:get("ClubMapBoss_State_CloseDesc1") .. TimeUtil:formatTime(format, remainTime))
		elseif status == WPStatus.kResultShow then
			local remainTime = math.max(timeList.closeTime2 - curTime, 0)

			self._timeText:setString(Strings:get("ClubMapBoss_State_CloseDesc2") .. TimeUtil:formatTime(format, remainTime))
		elseif status == WPStatus.kBattle then
			self:close()
		end
	end

	self._timer = LuaScheduler:getInstance():schedule(update, 1, true)

	update()
end

function WorldPeaceTipsMediator:onClickReward()
	self._worldPeaceSystem:tryEnterRankView(nil, true)
end
