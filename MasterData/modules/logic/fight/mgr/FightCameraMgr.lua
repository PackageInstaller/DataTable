-- chunkname: @modules/logic/fight/mgr/FightCameraMgr.lua

module("modules.logic.fight.mgr.FightCameraMgr", package.seeall)

local FightCameraMgr = class("FightCameraMgr", FightBaseClass)

function FightCameraMgr:onConstructor()
	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)

	self.virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()
	self.cirsualCamerasTransform = self.virsualCamerasGO.transform

	self:newClass(FightUnitCameraMgr)
end

function FightCameraMgr:onLevelLoaded(levelId)
	local useMyTurnCamera = FightMsgMgr.sendMsg(FightMsgId.CheckUseMyTurnCamera)

	if self.classMgr then
		self.classMgr:disposeSelf()
	end

	self.classMgr = self:newClass(FightBaseClass)

	local config = lua_fight_camera_rorate_when_idle.configDict[levelId]

	if config then
		self.classMgr:newClass(FightCameraRorateWhenIdle, config)
	end

	config = lua_fight_camera_player_turn_offset.configDict[levelId]

	if lua_fight_camera_player_turn_offset.configDict[levelId] then
		local obj = self.classMgr:newClass(FightCameraPlayerTurnOffset, config)

		obj.isMyTurn = useMyTurnCamera and true
	end
end

function FightCameraMgr:onDestructor()
	return
end

return FightCameraMgr
