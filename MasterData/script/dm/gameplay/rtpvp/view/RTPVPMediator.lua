-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/view/RTPVPMediator.lua

require("dm.gameplay.rtpvp.view.RTPVPDelegate")

kRTBattleType = {
	FriendPvp = 1,
	UnKnown = 0,
	DateBattle = 3,
	LadderPvp = 2
}
RTPVPMediator = class("RTPVPMediator", DmAreaViewMediator, _M)

RTPVPMediator:has("_controller", {
	is = "r"
}):injectWith("RTPVPController")

function RTPVPMediator:initialize()
	super.initialize(self)

	self._battleType = kRTBattleType.UnKnown
end

function RTPVPMediator:dispose()
	super.dispose(self)
end

function RTPVPMediator:onRegister()
	super.onRegister(self)
end

function RTPVPMediator:enterWithData(data)
	super.enterWithData(self, data)
	self:mapEventListeners()
end

function RTPVPMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_REQ_ERROR, self, self.reqError)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_LOGIC_ERROR, self, self.reqLogicError)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_SCENE, self, self._battleMatch)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_MATCH, self, self._enterBattleScene)
end

function RTPVPMediator:_enterBattleScene(evt)
	local var_6_0 = {
		battleType = self._battleType
	}

	var_6_0.seasonRule = self:getInjector():getInstance("LadderMatchSystem"):getLadderSeason():getSeasonRule()

	local extra = var_6_0
	local battleData = self._controller:fetchBattleData(evt:getData(), extra)

	self:_battleMatch(battleData)
end

function RTPVPMediator:_battleShowResult(result)
	local view = self:getInjector():getInstance("rtpvpResult")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		isPass = result
	}))
end

function RTPVPMediator:_battleMatch(data, extra)
	local battleDelegate = RTPVPDelegate:new(self._controller:getRtpvpService():fetchRid(), data.battleData, data.simulator, bind1(self._battleShowResult, self))

	if extra then
		if not extra.bgId then
			local bgId = "RealTimeFight_Background"
			local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", bgId, "content")
			local logicInfo = {
				director = self._controller:getDirector(),
				interpreter = data.interpreter,
				players = battleDelegate:getPlayers(),
				mainPlayerId = battleDelegate:getMainPlayerId()
			}
			local settingSystem = self:getInjector():getInstance(SettingSystem)
			local roleBarMode = settingSystem:getSettingModel():getBattleLifeIndex()
			local battleConfig = data.battleSession:getBattleConfig()
			local systemKeeper = self:getInjector():getInstance(SystemKeeper)
			local loadingList = LoadingTask:getRealBattleLoadingList(nil, nil, systemKeeper:isUnlock("Hero_Soul"))

			function battleDelegate:showMaster(friend, enemy, pauseFunc, resumeCallback)
				local popupDelegate = {}

				function popupDelegate:willClose(sender, data)
					if resumeCallback then
						resumeCallback()
					end
				end

				local bossView = outSelf:getInjector():getInstance("MasterCutInView")

				outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, bossView, nil, {
					friend = friend,
					enemy = enemy
				}, popupDelegate))

				if pauseFunc then
					pauseFunc()
				end
			end

			self:dispatch(SceneEvent:new(EVT_SWITCH_SCENE, "battleScene", nil, {
				soulLoadingType = "6v6",
				mainView = "rtpvpBattle",
				isAuto = false,
				isReplay = false,
				skipLoading = false,
				battleData = battleDelegate:getPlayersData(),
				loadingList = loadingList,
				roleBarMode = roleBarMode,
				delegate = battleDelegate,
				background = bgRes,
				director = self._controller:getDirector(),
				logicInfo = logicInfo,
				displayOptions = {
					showOtherTarget = true,
					initSpeed = "S1",
					btnsShow = {}
				},
				enemyEnergyVisible = battleConfig:isRivalEnergyVisible()
			}))
		end
	end
end

function RTPVPMediator:reqLogicError(resp)
	local tipstr = Strings:get(resp.resCode)

	if tipstr == nil or tipstr == "" then
		tipstr = resp.resCode
	end

	self:dispatch(ShowTipEvent({
		duration = 0.35,
		tip = tipstr
	}))
end

function RTPVPMediator:reqError(data)
	self:dispatch(ShowTipEvent({
		tip = Strings:get("REQ_FAIL", data)
	}))
end
