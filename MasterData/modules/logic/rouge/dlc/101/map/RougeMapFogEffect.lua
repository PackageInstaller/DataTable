-- chunkname: @modules/logic/rouge/dlc/101/map/RougeMapFogEffect.lua

module("modules.logic.rouge.dlc.101.map.RougeMapFogEffect", package.seeall)

local RougeMapFogEffect = class("RougeMapFogEffect", LuaCompBase)

function RougeMapFogEffect:init(effectGO)
	self.effectGO = effectGO
	self.fogMeshRenderer = gohelper.findChildComponent(self.effectGO, "mask_smoke", typeof(UnityEngine.MeshRenderer))
	self.fogMat = self.fogMeshRenderer.sharedMaterial
	self.tempVector4 = Vector4.zero
	self.shaderParamList = self:getUserDataTb_()

	for i = 1, RougeMapEnum.MaxHoleNum do
		table.insert(self.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. i))
	end

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMapPosChange, self.onMapPosChanged, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onCameraSizeChange, self.onCameraSizeChanged, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self:initAndRefreshFog()
end

function RougeMapFogEffect:onUpdateMapInfo()
	if not RougeMapHelper.checkMapViewOnTop() then
		self.waitUpdate = true

		return
	end

	self.waitUpdate = nil

	self:initNodeInfo()
	self:refreshFog(true)
end

function RougeMapFogEffect:onCloseViewFinish(viewName)
	if self.waitUpdate then
		self:onUpdateMapInfo()
	end
end

function RougeMapFogEffect:initAndRefreshFog()
	self:initNodeInfo()
	self:refreshFog()
end

function RougeMapFogEffect:onMapPosChanged()
	self:refreshFog()
end

function RougeMapFogEffect:onCameraSizeChanged()
	self:refreshFog()
end

function RougeMapFogEffect:refreshFog(isTweening)
	if self._fogNodeList then
		local hasFog = #self._fogNodeList > 0

		gohelper.setActive(self.effectGO, hasFog)

		if not hasFog then
			return
		end

		self:updateFogPosition(isTweening)
		self:updateHolesPosition()
	end
end

function RougeMapFogEffect:initNodeInfo()
	self._fogNodeList = RougeMapModel.instance:getFogNodeList()
	self._holeNodeList = RougeMapModel.instance:getHoleNodeList()
end

function RougeMapFogEffect:updateFogPosition(isTweening)
	self:_cancelFogTween()
	self:_endFogUIBlock()

	local fogNextPosX = self:getFogNextPositionX()
	local _, fogNextPosY = transformhelper.getPos(self.effectGO.transform)

	if isTweening then
		self:_startFogUIBlock()

		local preFogPosX, preFogPosY = RougeDLCModel101.instance:getFogPrePos()

		transformhelper.setPosXY(self.effectGO.transform, preFogPosX, preFogPosY)
		RougeDLCModel101.instance:setFogPrePos(fogNextPosX, fogNextPosY)

		self._fogTweenId = ZProj.TweenHelper.DOMoveX(self.effectGO.transform, fogNextPosX, RougeMapEnum.FogDuration, self._onFogTweenDone, self)
	else
		transformhelper.setPosXY(self.effectGO.transform, fogNextPosX, fogNextPosY)
	end
end

function RougeMapFogEffect:getFogNextPositionX()
	if self._fogNodeList then
		local firstFogNode = self._fogNodeList[1]
		local mapComp = RougeMapController.instance:getMapComp()
		local nodeItemGO = mapComp and mapComp:getMapItem(firstFogNode.nodeId)

		if not nodeItemGO then
			return 0
		end

		local nodePos = nodeItemGO:getScenePos()

		return nodePos.x + RougeMapEnum.FogOffset[1]
	end
end

function RougeMapFogEffect:_onFogTweenDone()
	self:_endFogUIBlock()
end

function RougeMapFogEffect:_startFogUIBlock()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeMapFogEffect")
end

function RougeMapFogEffect:_endFogUIBlock()
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeMapFogEffect")
end

function RougeMapFogEffect:_cancelFogTween()
	if self._fogTweenId then
		ZProj.TweenHelper.KillById(self._fogTweenId)

		self._fogTweenId = nil
	end
end

function RougeMapFogEffect:updateHolesPosition()
	local mapComp = RougeMapController.instance:getMapComp()

	if gohelper.isNil(self.fogMat) or not mapComp then
		return
	end

	for index = 1, RougeMapEnum.MaxHoleNum do
		if self._holeNodeList then
			local holeNode = self._holeNodeList[index]

			if holeNode then
				local nodeMapItem = mapComp:getMapItem(holeNode.nodeId)
				local pos = nodeMapItem and nodeMapItem:getScenePos()
				local posX = pos.x + RougeMapEnum.HolePosOffset[1]
				local posY = pos.y + RougeMapEnum.HolePosOffset[2]

				self.tempVector4:Set(posX, posY, RougeMapEnum.HoleSize)
			else
				self.tempVector4:Set(RougeMapEnum.OutSideAreaPos.X, RougeMapEnum.OutSideAreaPos.Y)
			end

			self.fogMat:SetVector(self.shaderParamList[index], self.tempVector4)
		end
	end
end

function RougeMapFogEffect:onDestroy()
	self:_cancelFogTween()
	self:_endFogUIBlock()
end

return RougeMapFogEffect
