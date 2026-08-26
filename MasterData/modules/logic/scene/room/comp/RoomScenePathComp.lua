-- chunkname: @modules/logic/scene/room/comp/RoomScenePathComp.lua

module("modules.logic.scene.room.comp.RoomScenePathComp", package.seeall)

local RoomScenePathComp = class("RoomScenePathComp", BaseSceneComp)

function RoomScenePathComp:onInit()
	return
end

function RoomScenePathComp:init(sceneId, levelId)
	self._scene = self:getCurScene()

	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		return
	end

	if RoomEnum.UseAStarPath then
		if RoomEnum.MeshUseOptimize then
			local wight, height, offsetX, offsetY = RoomMapBlockModel.instance:getFullMapSizeAndCenter()

			ZProj.AStarPathBridge.ScanAStarMesh(wight, height, offsetX, offsetY)
		else
			ZProj.AStarPathBridge.ScanAStarMesh()
		end
	end

	self._isInited = true
end

function RoomScenePathComp:tryGetPath(charMO, startPos, endPos, callback, callbackObj, param)
	local entity = self._scene.charactermgr:getCharacterEntity(charMO.id)

	if not entity then
		return
	end

	local seeker = entity.charactermove:getSeeker()

	if not seeker then
		return
	end

	seeker:RemoveOnPathCall()
	seeker:AddOnPathCall(callback, callbackObj, param)
	seeker:StartPath(startPos, endPos)
end

function RoomScenePathComp:stopGetPath(charMO)
	local entity = self._scene.charactermgr:getCharacterEntity(charMO.id)

	if not entity then
		return
	end

	local seeker = entity.charactermove:getSeeker()

	if not seeker then
		return
	end

	seeker:RemoveOnPathCall()
end

function RoomScenePathComp:updatePathGraphic(go)
	if not self._isInited then
		return
	end

	ZProj.AStarPathBridge.UpdateColliderGrid(go, GameSceneMgr.instance:isLoading() and 0 or 0.1)
	RoomCharacterModel.instance:clearNodePositionList()
end

function RoomScenePathComp:addPathCollider(go)
	if not RoomController.instance:isObMode() and not RoomController.instance:isVisitMode() then
		self._needPathGOs = self._needPathGOs or {}

		table.insert(self._needPathGOs, go)

		return
	end

	if not gohelper.isNil(go) then
		local list = {}

		ZProj.AStarPathBridge.FindChildrenByName(go, "#collider", list)

		for _, goColliderRoot in ipairs(list) do
			gohelper.setLayer(goColliderRoot, UnityLayer.Scene, true)
			self:updatePathGraphic(goColliderRoot)
		end
	end
end

function RoomScenePathComp:doNeedPathGOs()
	if self._needPathGOs then
		local temp = tabletool.copy(self._needPathGOs)

		for _, go in ipairs(temp) do
			if not gohelper.isNil(go) then
				self:addPathCollider(go)
			end
		end
	end

	self._needPathGOs = nil
end

function RoomScenePathComp:onSceneClose()
	self._isInited = false
	self._needPathGOs = nil

	if RoomEnum.UseAStarPath then
		ZProj.AStarPathBridge.StopScan()
	end

	RoomVectorPool.instance:clean()
	ZProj.AStarPathBridge.CleanCache()
end

function RoomScenePathComp.addEntityCollider(go)
	if not RoomEnum.UseAStarPath then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	if scene.path and not gohelper.isNil(go) then
		scene.path:addPathCollider(go)
	end
end

function RoomScenePathComp:getNearestNodeHeight(position)
	if not RoomEnum.UseAStarPath or not self._isInited then
		return 0
	end

	local success, height = ZProj.AStarPathBridge.GetNearestNodeHeight(position, 0)

	if not success then
		return 0
	end

	return height
end

return RoomScenePathComp
