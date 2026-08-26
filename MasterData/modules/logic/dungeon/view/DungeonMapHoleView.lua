-- chunkname: @modules/logic/dungeon/view/DungeonMapHoleView.lua

module("modules.logic.dungeon.view.DungeonMapHoleView", package.seeall)

local DungeonMapHoleView = class("DungeonMapHoleView", BaseView)

function DungeonMapHoleView:onInitView()
	return
end

function DungeonMapHoleView:addEvents()
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnElementAdd, self._onAddElement, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnElementRemove, self._onRemoveElement, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
end

function DungeonMapHoleView:removeEvents()
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self.loadSceneFinish, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnMapPosChanged, self.onMapPosChanged, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnElementAdd, self._onAddElement, self)
	self.removeEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnElementRemove, self._onRemoveElement, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self.initCameraParam, self)
end

function DungeonMapHoleView:onOpen()
	self.tempVector4 = Vector4()
	self.shaderParamList = {}
	self._tweens = {}

	for i = 1, 5 do
		table.insert(self.shaderParamList, UnityEngine.Shader.PropertyToID("_TransPos_" .. i))
	end
end

function DungeonMapHoleView:onClose()
	TaskDispatcher.cancelTask(self.setHoleByTween, self)
	self:clearTween()
end

function DungeonMapHoleView:clearTween()
	for _, id in pairs(self._tweens) do
		ZProj.TweenHelper.KillById(id)
	end
end

function DungeonMapHoleView:_onAddElement(id)
	if self._elementIndex[id] then
		local index = self._elementIndex[id]

		if self._tweens[index] then
			ZProj.TweenHelper.KillById(self._tweens[index], true)

			self._tweens[index] = nil
		end
	end

	if not self._elementIndex or self._elementIndex[id] or not self.defaultSceneWorldPosX then
		return
	end

	local elementCo = lua_chapter_map_element.configDict[id]

	if not elementCo then
		return
	end

	if string.nilorempty(elementCo.holeSize) then
		return
	end

	local index = 1

	while true do
		if not self.holdCoList[index] then
			self._elementIndex[id] = index

			local pos = string.splitToNumber(elementCo.pos, "#")

			if not pos[1] then
				if not pos[2] then
					local posY = 0
					local mainTrans = CameraMgr.instance:getMainCameraTrs().parent
					local x, y, z = transformhelper.getLocalPos(mainTrans)
					local arr = string.splitToNumber(elementCo.holeSize, "#")
					local var_7_1 = {
						nil,
						nil,
						0
					}

					var_7_1[1] = pos[1] + self.defaultSceneWorldPosX + (arr[1] or 0)
					var_7_1[2] = posY + self.defaultSceneWorldPosY + y + (arr[2] or 0)
					self.holdCoList[index] = var_7_1
					self.holdCoList[index][4] = id
					self._tweens[index] = ZProj.TweenHelper.DOTweenFloat(0, arr[3] or 0, 0.2, self.onTweenOpen, self.onTweenOpenEnd, self, index, EaseType.Linear)

					return
				end
			end
		end

		index = index + 1
	end
end

function DungeonMapHoleView:onTweenOpen(value, index)
	if not self.holdCoList[index] then
		return
	end

	self.holdCoList[index][3] = value

	self:refreshHoles()
end

function DungeonMapHoleView:onTweenOpenEnd(index)
	self._tweens[index] = nil
end

function DungeonMapHoleView:_onRemoveElement(id)
	if not self._elementIndex then
		return
	end

	if not self._elementIndex or not self._elementIndex[id] then
		return
	end

	local index = self._elementIndex[id]
	local holeCo = self.holdCoList[index]

	self._tweens[index] = ZProj.TweenHelper.DOTweenFloat(holeCo[3], 0, 0.2, self.onTweenClose, self.onTweenCloseEnd, self, index, EaseType.Linear)
end

function DungeonMapHoleView:onTweenClose(value, index)
	if not self.holdCoList[index] then
		return
	end

	self.holdCoList[index][3] = value

	self:refreshHoles()
end

function DungeonMapHoleView:onTweenCloseEnd(index)
	self._tweens[index] = nil
	self.holdCoList[index] = nil

	for id, value in pairs(self._elementIndex) do
		if value == index then
			self._elementIndex[id] = nil

			self:refreshHoles()

			break
		end
	end
end

function DungeonMapHoleView:loadSceneFinish(param)
	self.mapCfg = param[1]
	self.sceneGo = param[2]
	self.mapScene = param[3]

	TaskDispatcher.cancelTask(self.setHoleByTween, self)

	if gohelper.isNil(self.sceneGo) then
		self.loadSceneDone = false

		return
	end

	self:clearTween()

	if not lua_chapter_map_hole.configDict[self.mapCfg.id] then
		self.holdCoList = {}
		self._elementIndex = {}

		for i = 1, #lua_chapter_map_hole.configDict[self.mapCfg.id] do
			table.insert(self.holdCoList, string.splitToNumber(lua_chapter_map_hole.configDict[self.mapCfg.id][i].param, "#"))
		end

		self.loadSceneDone = true
		self.sceneTrans = self.sceneGo.transform

		local shaderGo = gohelper.findChild(self.sceneGo, "Obj-Plant/FogOfWar/mask")

		self._maskGo = shaderGo

		if not shaderGo then
			return
		end

		gohelper.setLayer(shaderGo, UnityLayer.Scene, true)

		self.sceneWorldPosX, self.sceneWorldPosY = transformhelper.getLocalPos(self.sceneTrans)

		local pos = self.mapCfg.initPos
		local posParam = string.splitToNumber(pos, "#")

		self.defaultSceneWorldPosY = posParam[2] or 0
		self.defaultSceneWorldPosX = posParam[1] or 0

		local meshRender = shaderGo:GetComponent(typeof(UnityEngine.MeshRenderer))

		self.mat = meshRender.material

		self:initCameraParam()
		self:refreshHoles()
	end
end

function DungeonMapHoleView:onMapPosChanged(targetPos, isTween)
	if not self.loadSceneDone then
		return
	end

	if isTween then
		self.targetPosX, self.targetPosY = targetPos.x, targetPos.y

		self:setHoleByTween()
		TaskDispatcher.runRepeat(self.setHoleByTween, self, 0, -1)
	else
		TaskDispatcher.cancelTask(self.setHoleByTween, self)

		self.sceneWorldPosX, self.sceneWorldPosY = targetPos.x, targetPos.y

		self:refreshHoles()
	end
end

function DungeonMapHoleView:setHoleByTween()
	if not self.sceneTrans or tolua.isnull(self.sceneTrans) then
		TaskDispatcher.cancelTask(self.setHoleByTween, self)

		return
	end

	self.sceneWorldPosX, self.sceneWorldPosY = transformhelper.getLocalPos(self.sceneTrans)

	if math.abs(self.sceneWorldPosX - self.targetPosX) < 0.01 and math.abs(self.sceneWorldPosY - self.targetPosY) < 0.01 then
		self.sceneWorldPosX, self.sceneWorldPosY = self.targetPosX, self.targetPosY

		TaskDispatcher.cancelTask(self.setHoleByTween, self)
	end

	self:refreshHoles()
end

function DungeonMapHoleView:initCameraParam()
	if not self.loadSceneDone then
		return
	end

	local canvasGo = ViewMgr.instance:getUILayer(UILayerName.Hud)
	local scale = GameUtil.getAdapterScale()
	local worldcorners = canvasGo.transform:GetWorldCorners()

	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.mainCameraPosX, self.mainCameraPosY = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	local uiCameraSize = self.mainCamera.orthographicSize
	local cameraSizeRate = 5 / uiCameraSize
	local posTL = worldcorners[1] * scale * cameraSizeRate
	local posBR = worldcorners[3] * scale * cameraSizeRate

	self._mapHalfWidth = math.abs(posBR.x - posTL.x) / 2
	self._mapHalfHeight = math.abs(posBR.y - posTL.y) / 2

	self:refreshHoles()
end

function DungeonMapHoleView:refreshHoles()
	if not self.loadSceneDone or gohelper.isNil(self.mat) then
		return
	end

	local index = 1

	for _, pos in pairs(self.holdCoList) do
		local x = pos[1] + self.sceneWorldPosX - self.defaultSceneWorldPosX
		local y = pos[2] + self.sceneWorldPosY - self.defaultSceneWorldPosY
		local size = math.abs(pos[3])
		local xDistance = math.sqrt((self.mainCameraPosX - x)^2)
		local yDistance = math.sqrt((self.mainCameraPosY - y)^2)

		if xDistance <= self._mapHalfWidth + size and yDistance <= self._mapHalfHeight + size then
			if index > 5 then
				logError("元件太多无法挖孔")

				return
			end

			self.tempVector4:Set(x, y, pos[3])
			self.mat:SetVector(self.shaderParamList[index], self.tempVector4)

			index = index + 1
		end
	end

	for i = index, 5 do
		self.tempVector4:Set(100, 100, 100)
		self.mat:SetVector(self.shaderParamList[i], self.tempVector4)
	end
end

function DungeonMapHoleView:setMaskVisible(value)
	gohelper.setActive(self._maskGo, value)
end

return DungeonMapHoleView
