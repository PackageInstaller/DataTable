-- chunkname: @modules/logic/versionactivity2_7/coopergarland/controller/CooperGarlandGameEntityMgr.lua

module("modules.logic.versionactivity2_7.coopergarland.controller.CooperGarlandGameEntityMgr", package.seeall)

local CooperGarlandGameEntityMgr = class("CooperGarlandGameEntityMgr", BaseController)

function CooperGarlandGameEntityMgr:onInit()
	self:clearAllMap()
end

function CooperGarlandGameEntityMgr:reInit()
	self:clearAllMap()
end

function CooperGarlandGameEntityMgr:clearAllMap()
	self._panelRoot = nil
	self._ballRoot = nil
	self._compRoot = nil
	self._wallRoot = nil
	self._panelGo = nil

	if self._ballEntity then
		self._ballEntity:destroy()
	end

	self._ballEntity = nil

	self:_clearCompAndWall()

	self._initMapCb = nil
	self._initMapCbObj = nil

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._hasLoadedRes = false

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)
end

function CooperGarlandGameEntityMgr:enterMap()
	self:clearAllMap()
	self:_startLoadRes()
end

function CooperGarlandGameEntityMgr:_startLoadRes()
	if self._loader then
		self._loader:dispose()
	end

	self._loader = MultiAbLoader.New()

	UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	local componentResPathList = CooperGarlandConfig.instance:getAllComponentResPath()

	if string.nilorempty(next(CooperGarlandEnum.ResPath)) and string.nilorempty(next(componentResPathList)) then
		self:_loadResFinished()
	else
		for _, path in pairs(CooperGarlandEnum.ResPath) do
			self._loader:addPath(path)
		end

		for _, path in ipairs(componentResPathList) do
			self._loader:addPath(path)
		end

		self._loader:startLoad(self._loadResFinished, self)
	end
end

function CooperGarlandGameEntityMgr:_loadResFinished()
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameRes)

	self._hasLoadedRes = true

	self:tryInitMap(self._panelRoot, self._ballRoot, self._initMapCb, self._initMapCbObj)
end

function CooperGarlandGameEntityMgr:tryInitMap(panelRoot, ballRoot, cb, cbObj)
	self._panelRoot = panelRoot
	self._ballRoot = ballRoot
	self._initMapCb = cb
	self._initMapCbObj = cbObj

	self:_initMap()
end

function CooperGarlandGameEntityMgr:_initMap()
	if not self._hasLoadedRes or gohelper.isNil(self._panelRoot) or gohelper.isNil(self._ballRoot) then
		return
	end

	local panelAssetItem = self._loader:getAssetItem(CooperGarlandEnum.ResPath.UIPanel)

	if panelAssetItem then
		self._panelGo = gohelper.clone(panelAssetItem:GetResource(), self._panelRoot)

		local panelTrans = self._panelGo.transform
		local x, y, _ = transformhelper.getLocalPos(panelTrans)

		transformhelper.setLocalPos(panelTrans, x, y, CooperGarlandEnum.Const.PanelPosZ)

		self._panelScale = transformhelper.getLocalScale(panelTrans)
		self._wallRoot = gohelper.findChild(self._panelGo, "#go_walls")
		self._compRoot = gohelper.findChild(self._panelGo, "#go_comps")

		local floorCollider = gohelper.findChild(self._panelGo, "#go_boundary/floor"):GetComponent(typeof(UnityEngine.BoxCollider))

		self._floorColliderThickness = floorCollider.size.z

		local boundaryCollider = gohelper.findChild(self._panelGo, "#go_boundary/top"):GetComponent(typeof(UnityEngine.BoxCollider))

		self._boundaryColliderHeightZ = boundaryCollider.size.z
	end

	if self._initMapCb then
		self._initMapCb(self._initMapCbObj)
	end

	self._initMapCb = nil
	self._initMapCbObj = nil

	self:_setupMap()
end

function CooperGarlandGameEntityMgr:_setupMap()
	local startWorldPos
	local mapId = CooperGarlandGameModel.instance:getMapId()
	local componentIdList = CooperGarlandConfig.instance:getMapComponentList(mapId)

	for _, componentId in ipairs(componentIdList) do
		local componentType = CooperGarlandConfig.instance:getMapComponentType(mapId, componentId)
		local resPath = CooperGarlandConfig.instance:getComponentTypePath(componentType)
		local assetItem = self._loader:getAssetItem(resPath)
		local isStoryCompFinished = CooperGarlandGameModel.instance:isFinishedStoryComponent(mapId, componentId)

		if assetItem and not isStoryCompFinished then
			local isWall = componentType == CooperGarlandEnum.ComponentType.Wall

			if isWall then
				local go = gohelper.clone(assetItem:GetResource(), self._wallRoot or self._compRoot)
				local entity = MonoHelper.addLuaComOnceToGo(go, CooperGarlandComponentEntity, {
					mapId = mapId,
					componentId = componentId,
					componentType = componentType
				})

				if isWall then
					self._wallDict[componentId] = entity
				else
					self._compDict[componentId] = entity
				end

				if componentType == CooperGarlandEnum.ComponentType.Start then
					startWorldPos = entity:getWorldPos()
				end
			end
		end
	end

	CooperGarlandStatHelper.instance:setupMap()
	self:setBallVisible(startWorldPos)
	CooperGarlandController.instance:setStopGame(false)
	CooperGarlandController.instance:dispatchEvent(CooperGarlandEvent.GuideOnEnterMap, mapId)
end

function CooperGarlandGameEntityMgr:resetMap()
	if self._compDict then
		for _, entity in pairs(self._compDict) do
			entity:reset()
		end
	end

	self:resetBall()
end

function CooperGarlandGameEntityMgr:resetBall()
	if self._ballEntity then
		self._ballEntity:reset()
	end
end

function CooperGarlandGameEntityMgr:changeMap()
	self:_clearCompAndWall()
	self:setBallVisible()
	self:_setupMap()
end

function CooperGarlandGameEntityMgr:_clearCompAndWall()
	if self._wallDict then
		for _, wall in pairs(self._wallDict) do
			wall:destroy()
		end
	end

	self._wallDict = {}

	if self._compDict then
		for _, comps in pairs(self._compDict) do
			comps:destroy()
		end
	end

	self._compDict = {}
end

function CooperGarlandGameEntityMgr:removeComp(componentId)
	if self._compDict[componentId] then
		self._compDict[componentId]:setRemoved()
	end
end

function CooperGarlandGameEntityMgr:setBallVisible(worldPos)
	if worldPos and not self._ballEntity then
		local ballAssetItem = self._loader:getAssetItem(CooperGarlandEnum.ResPath.Ball)

		if ballAssetItem then
			local mapId = CooperGarlandGameModel.instance:getMapId()
			local ballParent = gohelper.clone(ballAssetItem:GetResource(), self._ballRoot)
			local ballGo = gohelper.findChild(ballParent, "#go_ball")
			local renderer = ballGo:GetComponentInChildren(typeof(UnityEngine.Renderer))
			local scale = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.BallScale, true)

			transformhelper.setLocalScale(ballParent.transform, scale, scale, scale)

			self._ballSize = renderer.bounds.size.x * ballParent.transform.localScale.x
			self._ballEntity = MonoHelper.addLuaComOnceToGo(ballGo, CooperGarlandBallEntity, {
				mapId = mapId
			})
		end
	end

	if self._ballEntity then
		self._ballEntity:setVisible(worldPos)
	end
end

function CooperGarlandGameEntityMgr:playBallDieVx()
	if self._ballEntity then
		self._ballEntity:playDieVx()
	end
end

function CooperGarlandGameEntityMgr:checkBallFreeze(isResumeSpeed)
	if self._ballEntity then
		self._ballEntity:checkFreeze(isResumeSpeed)
	end
end

function CooperGarlandGameEntityMgr:isBallCanTriggerComp()
	return (self._ballEntity or nil) and self._ballEntity:isCanTriggerComp()
end

function CooperGarlandGameEntityMgr:getPanelGo()
	return self._panelGo
end

function CooperGarlandGameEntityMgr:getBallPosZ()
	return CooperGarlandEnum.Const.PanelPosZ - self._floorColliderThickness * self._panelScale - self._ballSize / 2 + CooperGarlandEnum.Const.BallPosOffset
end

function CooperGarlandGameEntityMgr:getCompPosZ(isWall)
	return (not isWall or nil) and -self._floorColliderThickness
end

function CooperGarlandGameEntityMgr:getCompColliderSizeZ()
	return self._boundaryColliderHeightZ
end

function CooperGarlandGameEntityMgr:getCompColliderOffsetZ(isWall)
	local halfOffset = self._boundaryColliderHeightZ / 2
	local offsetZ = isWall and halfOffset or halfOffset - self._floorColliderThickness

	return -offsetZ
end

function CooperGarlandGameEntityMgr:getRemoveCompList()
	local result = {}

	if self._compDict then
		for componentId, entity in pairs(self._compDict) do
			if entity:getIsRemoved() then
				result[#result + 1] = componentId
			end
		end
	end

	return result
end

function CooperGarlandGameEntityMgr:getBallVelocity()
	return (self._ballEntity or nil) and self._ballEntity:getVelocity()
end

CooperGarlandGameEntityMgr.instance = CooperGarlandGameEntityMgr.New()

return CooperGarlandGameEntityMgr
