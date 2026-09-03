-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossInviteMediator.lua

CooperateBossInviteMediator = class("CooperateBossInviteMediator", DmPopupViewMediator)

CooperateBossInviteMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
CooperateBossInviteMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
CooperateBossInviteMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")

local kBtnHandlers = {
	["main.btn_close"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onCloseClicked"
	},
	["main.refuse"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRefuse"
	},
	["main.accept"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAccept"
	}
}

function CooperateBossInviteMediator:initialize()
	super.initialize(self)
end

function CooperateBossInviteMediator:dispose()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	super.dispose(self)
end

function CooperateBossInviteMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossInviteMediator:mapEventListeners()
	return
end

function CooperateBossInviteMediator:enterWithData(data)
	self:initView()
	self:initData(data)
	self:refreashView()
end

function CooperateBossInviteMediator:resumeWithData()
	return
end

function CooperateBossInviteMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._bossPanel = self._main:getChildByFullName("bossPanel")
	self._bossName = self._main:getChildByFullName("BgBottom.name")
	self._bossLevelText = self._main:getChildByFullName("BgBottom.level")
	self._remainTime = self._main:getChildByFullName("TimeDi.time")
	self._des = self._main:getChildByFullName("BgBottom.text1")
	self._friend = self._main:getChildByFullName("infoBg.name")
	self._refuseBtn = self._main:getChildByFullName("refuse")
	self._accpetBtn = self._main:getChildByFullName("accept")
	self._qipaoText = self._main:getChildByFullName("qipao.text")

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(212, 83, 235, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(97, 34, 138, 255)
		}
	}
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(0, 0, 0, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(60, 1, 21, 255)
		}
	}
	local lineGradiantVec3 = {
		{
			ratio = 0.3,
			color = cc.c4b(220, 50, 138, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(149, 14, 55, 255)
		}
	}
	local lineGradiantDir = {
		x = 0,
		y = -1
	}

	self._friend:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, lineGradiantDir))
	self._friend:enableShadow(cc.c4b(91, 86, 48, 107.1), cc.size(-2, 2), 2)
	self._des:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, lineGradiantDir))
	self._bossName:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec3, lineGradiantDir))
end

function CooperateBossInviteMediator:initData(data)
	self._bossConfigId = data.confId
	self._bossCreateTime = data.bossCreateTime
	self._bossLevel = data.bossLevel
	self._friendName = data.name
	self._bossId = data.bossId
	self._bossConfig = ConfigReader:getRecordById("CooperateBossMain", self._bossConfigId)
end

function CooperateBossInviteMediator:refreashView()
	self._bossName:setString(self._cooperateBossSystem:getBossName(self._bossConfigId))

	local text1 = self._main:getChildByFullName("BgBottom.text1")

	self._bossName:setPositionX(text1:getContentSize().width + text1:getPositionX() + 20)
	self._bossLevelText:setPositionX(self._bossName:getContentSize().width + self._bossName:getPositionX() + 20)
	self._friend:setString(self._friendName)

	local model = self:getRoleModelId()
	local img, jsonPath = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = model
	})

	img:addTo(self._bossPanel)
	img:setPosition(cc.p(360, 250))
	img:setScale(0.78)

	local endTime = self._bossCreateTime + self:getBossLiveTime()

	local function checkTimeFunc()
		local remoteTimestamp = self._gameServerAgent:remoteTimestamp()
		local remainTime = endTime - remoteTimestamp

		if remainTime < 0 then
			self._remainTime:setString(Strings:get("CooperateBoss_AfterBattle_UI05"))

			if self._timer then
				self._timer:stop()

				self._timer = nil
			end

			performWithDelay(self:getView(), function()
				self._cooperateBossSystem:enterCooperateBossInviteFriendView(self._bossId)
				self:dispatch(Event:new(EVT_COOPERATE_REFRESH_INVITELIST))
				self:onCloseClicked()
			end, 0.03333333333333333)

			return
		end

		local fmtStr = "${d}:${H}:${M}:${S}"
		local timeStr = TimeUtil:formatTime(fmtStr, remainTime)
		local parts = string.split(timeStr, ":", nil, true)
		local timeTab = {}

		timeTab.hour = tonumber(parts[2])
		timeTab.min = tonumber(parts[3])
		timeTab.sec = tonumber(parts[4])

		self._remainTime:setString(Strings:get("CooperateBoss_Trigger_UI02", {
			countdown = string.format("%02d", timeTab.hour) .. ":" .. string.format("%02d", timeTab.min) .. ":" .. string.format("%02d", timeTab.sec)
		}))
	end

	self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

	checkTimeFunc()

	local bossLevel = self._bossLevel

	self._bossLevelText:setString(Strings:get("CooperateBoss_Invite_UI32", {
		level = bossLevel
	}))

	local inviteBubble = ConfigReader:getDataByNameIdAndKey("ConfigValue", "CooperateBoss_InviteBubble", "content")

	self._qipaoText:setString(Strings:get(inviteBubble[math.random(1, #inviteBubble)]))
end

function CooperateBossInviteMediator:getBossLiveTime()
	local congfigId = self._bossConfigId
	local bossConfig = ConfigReader:getRecordById("CooperateBossMain", congfigId)

	return tonumber(bossConfig.Time)
end

function CooperateBossInviteMediator:getRoleModelId()
	local congfigId = self._bossConfigId

	return (ConfigReader:getDataByNameIdAndKey("CooperateBossMain", congfigId, "RoleModel"))
end

function CooperateBossInviteMediator:onClickRefuse(sender, eventType)
	self:onCloseClicked()
	self._cooperateBossSystem:requestAfuseInvite(self._bossId)
end

function CooperateBossInviteMediator:onClickAccept(sender, eventType)
	local state, buytime = self._cooperateBossSystem:CanJoinCooperateBoss()

	if state == kCooperateBossFightTimeState.kCanFight then
		local function callback()
			self._cooperateBossSystem:enterCooperateBossInviteFriendView(self._bossId)
		end

		self._cooperateBossSystem:requestAcceptInvite(self._bossId, callback)
		self:onCloseClicked()
	elseif state == kCooperateBossFightTimeState.kBuyTime then
		local view = self:getInjector():getInstance("CooperateBossBuyTimeView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, nil))
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("CooperateBoss_UI05")
		}))
	end
end

function CooperateBossInviteMediator:onCloseClicked(sender, eventType)
	self:close()
end
