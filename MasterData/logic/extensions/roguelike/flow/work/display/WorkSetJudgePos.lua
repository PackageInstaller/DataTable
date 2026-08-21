-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/work/display/WorkSetJudgePos.lua

module("logic.extensions.roguelike.flow.work.display.WorkSetJudgePos", package.seeall)

local M = class("WorkSetJudgePos", WorkBase)
local RoleAnimState = {
	Arise = "arise",
	Fall = "fall"
}

function M:onEnter(context)
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()
	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getMapRolePos()
	local realPos = mapMgr:getRealMapRolePos()

	self._rolePos = pos
	self._isDown = context.isDown

	local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()

	if not polygon then
		self:onDone(WorkResult.Succeed)

		return
	end

	polygon:ChangePointPos(0, -100, -100)
	polygon:ChangePointPos(1, 200, -100)
	polygon:ChangePointPos(2, 200, 100)
	polygon:ChangePointPos(3, -100, 100)

	if context.isDown then
		local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()
		local eventInfo = RogueMgr.instance:getModel():getCurEventInfo()

		if eventInfo then
			eventType = eventInfo[2].type + 1
		end

		local index = RogueMgr.instance:getModel():getCurRoleIndex()
		local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

		for k, v in pairs(roleMos) do
			local posZ = pos.z + (k - 1) * kMapItemSize

			v.transform:setPositionXYZ(pos.x, 0, posZ)
			v.transform:setActive(eventType ~= RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT and not v.roleProp:getIsDeath())

			if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
				v.transform:setActive(index == k and not v.roleProp:getIsDeath())
			elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
				v.transform:setActive(false)
			end

			v.meshModel:play(RoleAnimState.Fall, false, true)
		end

		settimer(RoguelikeConst.MAP_CHANGE_CAMERA_TIME, self._onAniFinish, self, false)
	else
		VirtualCameraMgr.instance:doFollowPosition(realPos.x, RoguelikeConst.MAP_ROLE_OFFSET_Y, realPos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)

		for k, v in pairs(roleMos) do
			v.transform:setActive(false)
		end

		self:onDone(WorkResult.Succeed)
	end
end

function M:_showRoleFallAni()
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

	if self._isDown then
		for k, v in pairs(roleMos) do
			v.meshModel:play(RoleAnimState.Fall, false, true)
		end
	else
		for k, v in pairs(roleMos) do
			v.transform:setActive(false)
		end

		self:onDone(WorkResult.Succeed)
	end
end

function M:_onAniFinish()
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE

	VirtualCameraMgr.instance:doFollowPosition(self._rolePos.x + 2.5 * kMapItemSize, RoguelikeConst.MAP_ROLE_OFFSET_Y, self._rolePos.z + 1.5 * kMapItemSize - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)

	local mapMgr = RogueMgr.instance:getMapMgr()
	local pos = mapMgr:getRealMapRolePos()

	if self._isDown then
		self._originFov = VirtualCameraMgr.instance:getFieldOfView()

		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				VirtualCameraMgr.instance:doFollowPosition(self._rolePos.x + 2.5 * kMapItemSize, RoguelikeConst.MAP_ROLE_OFFSET_Y, self._rolePos.z + 1.5 * kMapItemSize - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)
				self:onDone(WorkResult.Succeed)
			end
		end, self, self._originFov, 26, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	else
		TweenUtil.tweenNumber(function(handle, value, isFinish)
			if isFinish then
				VirtualCameraMgr.instance:doFollowPosition(pos.x, RoguelikeConst.MAP_ROLE_OFFSET_Y, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, 0.5)
				self:onDone(WorkResult.Succeed)
			end
		end, self, VirtualCameraMgr.instance:getFieldOfView(), 48, RoguelikeConst.MAP_CHANGE_CAMERA_TIME)
	end
end

function M:onExit(isInterrupt)
	removetimer(self._showRoleFallAni, self)
	removetimer(self._onAniFinish, self)
end

return M
