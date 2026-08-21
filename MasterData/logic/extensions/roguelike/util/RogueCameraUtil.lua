-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RogueCameraUtil.lua

module("logic.extensions.roguelike.util.RogueCameraUtil", package.seeall)

local kMapCameraPlayed = "kMapCameraPlayed"
local M = class("RogueCameraUtil")

function M:playEnterSceneCamera(ignorePlayed, aniCallback)
	self._enterAniCallback = aniCallback

	local originUnit, endUnit
	local allRoomMos = RoguelikeModel.instance:getRoomMOs(true)

	if not allRoomMos then
		self:execEnterAniCallback()

		return
	end

	local isOriginPos = false
	local mapMgr = RogueMgr.instance:getMapMgr()

	if not mapMgr then
		self:execEnterAniCallback()

		return
	end

	for i = 1, #allRoomMos do
		local mo = allRoomMos[i]

		if mo:getRoomType() == RoguelikeExtension_pb.RoomType.INIT then
			originUnit = mapMgr:getUnit(i)

			if i == RoguelikeModel.instance:getCurRoomIndex() then
				isOriginPos = true
			end
		elseif mo:getRoomType() == RoguelikeExtension_pb.RoomType.BOSS then
			endUnit = mapMgr:getUnit(i)
		end
	end

	if not isOriginPos and not ignorePlayed then
		self:execEnterAniCallback()

		return
	end

	if originUnit == nil or endUnit == nil then
		self:execEnterAniCallback()

		return
	end

	local polygon = VirtualCameraMgr.instance:getPolygonColliderPolygon()

	if polygon then
		polygon:ChangePointPos(0, -100, -100)
		polygon:ChangePointPos(1, 100, -100)
		polygon:ChangePointPos(2, 100, 100)
		polygon:ChangePointPos(3, -100, 100)
	end

	self._originUnit = originUnit
	self._endUnit = endUnit

	ViewBlockMgr.instance:blockClick(true, ViewName.RogueMap)

	local pos = VectorUtil.getBetweenPoint(originUnit.go.transform.position, endUnit.go.transform.position, 0.9)

	VirtualCameraMgr.instance:setDampingX(1)
	VirtualCameraMgr.instance:setDampingZ(1)

	local minX = pos.x
	local time = 0.6

	VirtualCameraMgr.instance:doFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, time)
	settimer(time, self._finishMove1, self, false)
end

function M:execEnterAniCallback()
	if self._enterAniCallback ~= nil then
		self._enterAniCallback()

		self._enterAniCallback = nil
	end
end

function M:_finishMove1()
	if not RogueMgr.instance:isInRogue() then
		ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

		return
	end

	local pos = self._endUnit.go.transform.position

	VirtualCameraMgr.instance:setDampingX(1)
	VirtualCameraMgr.instance:setDampingZ(1)

	local minX = pos.x
	local time = 0.9

	VirtualCameraMgr.instance:doFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, time)
	settimer(time, self._waitForShow, self, false)
end

function M:_waitForShow()
	if not RogueMgr.instance:isInRogue() then
		ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

		return
	end

	settimer(1, self._finishMove2, self, false)
end

function M:_finishMove2()
	if not RogueMgr.instance:isInRogue() then
		ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

		return
	end

	local pos = self._originUnit.go.transform.position

	VirtualCameraMgr.instance:setDampingX(1)
	VirtualCameraMgr.instance:setDampingZ(1)

	local left = -1000
	local minX = left > pos.x and left or pos.x
	local time = 1.2

	VirtualCameraMgr.instance:doFollowPosition(minX, RoguelikeConst.MAP_ROLE_OFFSET_Y2, pos.z - RoguelikeConst.MAP_ROLE_OFFSET_Z, time)
	settimer(time, self._finishMove3, self, false)
end

function M:_finishMove3()
	if not RogueMgr.instance:isInRogue() then
		ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

		return
	end

	ViewBlockMgr.instance:blockClick(false, ViewName.RogueMap)

	local mapId = RoguelikeModel.instance:getCurMapId()
	local key = mapId .. kMapCameraPlayed .. PlayerModel.instance:getId()

	Astral.LocalStorage.Instance:SetInt(key, 1)
	RoguelikeModel.instance:updateCameraFollowConfiner()
	self:execEnterAniCallback()
end

function M:playThrowDiceCamera(callback)
	if callback then
		callback()

		return
	end

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local originRotate = virtualCamera:getRotation()

	if not goutil.isNil(virtualCamera:getMainGO()) then
		settimer(0.2, function()
			settimer(0.2, function()
				if callback then
					callback()
				end

				self:playDiceFollowCamera()
			end, self, false)
		end, self, false)
	end

	local followPosition = VirtualCameraMgr.instance:getFollowPosition()

	self._originFollowPosition = TableUtil.deepCopy(followPosition)

	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local time1 = 0.5
	local offset1 = RoguelikeConst.tempX or 0
	local offset2 = RoguelikeConst.tempY or 4
end

function M:playDiceFollowCamera()
	local time = 0.4
	local followPosition = self._originFollowPosition
	local kMapItemSize = RoguelikeConst.MAP_ITEM_SIZE
	local time1 = 0.2
	local offset1 = RoguelikeConst.tempX or 0
	local offset2 = RoguelikeConst.tempY or 5

	settimer(time1, function()
		return
	end, self, false)
	settimer(0.3, function()
		self:showCameraShake()
	end, self, false)
	settimer(1.5, function()
		return
	end, self, false)
end

function M:showCameraShake()
	local lifeTime = 0.1
	local magnitude = 1
	local shakeModeValue = 4

	VirtualCameraMgr.instance:shake(lifeTime, magnitude, shakeModeValue, 0.1, 0.1)

	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local originRotate = virtualCamera:getRotation()

	virtualCamera:doRotation(originRotate.x, -0.4, 0, 0.3)
	settimer(0.1, function()
		virtualCamera:doRotation(originRotate.x, 0.4, 0, 0.3)
		settimer(0.1, function()
			virtualCamera:doRotation(originRotate.x, 0, 0, 0.3)
		end, self, false)
	end, self, false)
end

M.instance = M.New()

return M
