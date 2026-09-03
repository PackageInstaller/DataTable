-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/controller/RTPVPController.lua

require("dm.battle.logic.all")
require("dm.battle.interactor.all")
require("dm.battle.builder.all")
require("dm.battle.view.BattleSceneMediator")
require("dm.gameplay.rtpvp.service.RTPVPService")
require("dm.base.all")

RTPVPController = class("RTPVPController", Facade)

RTPVPController:has("_rtpvpService", {
	is = "r"
}):injectWith("RTPVPService")
RTPVPController:has("_director", {
	is = "r"
})
RTPVPController:has("_battleData", {
	is = "r"
})
RTPVPController:has("_battleFinishData", {
	is = "rw"
})

EVT_RTPVP_LOGIC_ERROR = "EVT_RTPVP_LOGIC_ERROR"
EVT_RTPVP_BATTLE_FINISH = "EVT_RTPVP_BATTLE_FINISH"
EVT_RTPVP_BATTLE_SKIP = "EVT_RTPVP_BATTLE_SKIP"
EVT_RTPVP_BATTLE_MATCH = "EVT_RTPVP_BATTLE_MATCH"
EVT_RTPVP_BATTLE_FRAME = "EVT_RTPVP_BATTLE_FRAME"
EVT_RTPVP_BATTLE_SPEEDUP = "EVT_RTPVP_BATTLE_SPEEDUP"
EVT_RTPVP_BATTLE_STOPTICK = "EVT_RTPVP_BATTLE_STOPTICK"
EVT_RTPVP_BATTLE_REPLAY = "EVT_RTPVP_BATTLE_REPLAY"
EVT_RTPVP_BATTLE_SCENE = "EVT_RTPVP_BATTLE_SCENE"
EVT_RTPVP_BATTLE_RESULT = "EVT_RTPVP_BATTLE_RESULT"
EVT_RTPVP_BATTLE_EMOJI = "EVT_RTPVP_BATTLE_EMOJI"

function RTPVPController:initialize()
	super.initialize(self)
end

function RTPVPController:userInject(injector)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_FRAME, self, self._battleFrame)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RTPVP_BATTLE_RESULT, self, self._battleFinish)
end

function RTPVPController:_sendEvent(evt, data)
	self:dispatch(Event:new(evt, data))
end

function RTPVPController:enterRTPVP(battleServerIP, battleServerPort, roomId, battleData, type, seasonId)
	self._roomId = roomId
	self._battleData = battleData
	self._type = type
	self._seasonId = seasonId

	self._rtpvpService:connect(battleServerIP, battleServerPort)
end

function RTPVPController:ready()
	self._rtpvpService:ready()
end

function RTPVPController:errorLeave()
	self._rtpvpService:disconnect()
end

function RTPVPController:leave()
	self._rtpvpService:leave()
end

function RTPVPController:battleFinish(resultData)
	self._rtpvpService:finish(resultData)
end

function RTPVPController:displayToTheEnd()
	self._director:displayToTheEnd()
end

function RTPVPController:sendEmoji(data)
	self._rtpvpService:emoji(data)
end

function RTPVPController:connectSucc()
	self._rtpvpService:join(self._battleData, self._roomId, self._type, self._seasonId)
end

function RTPVPController:fetchBattleData(data, extra)
	extra = extra or {}

	local battleSession = RTPVPBattleSession:new({
		playerData = data.playerA,
		enemyData = data.playerB,
		logicSeed = data.logicSeed,
		battleType = extra.battleType,
		seasonId = extra.seasonId
	})

	battleSession:buildAll()

	local simulator = battleSession:getBattleSimulator()
	local interpreter = BattleInterpreter:new()

	interpreter:setRecordsProvider(battleSession:getBattleRecordsProvider())

	self._director = RTPVPBattleDirector:new(simulator, self._rtpvpService)

	self._director:setBattleInterpreter(interpreter)

	return {
		battleSession = battleSession,
		simulator = simulator,
		interpreter = interpreter,
		battleData = battleSession:getPlayersData()
	}
end

function RTPVPController:_battleFrame(evt)
	local data = evt:getData()

	self._director:syncFrameEvent(data)
end

function RTPVPController:_battleFinish(evt)
	local data = evt:getData()

	Bdump("_battleFinish", data)

	self._battleFinishData = data
end

function RTPVPController:clearBattleFinishData()
	Bcallstack("clearBattleFinishData")

	self._battleFinishData = nil
end
