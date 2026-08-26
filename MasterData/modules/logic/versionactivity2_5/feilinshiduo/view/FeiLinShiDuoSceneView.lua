-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoSceneView.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoSceneView", package.seeall)

local FeiLinShiDuoSceneView = class("FeiLinShiDuoSceneView", BaseView)

function FeiLinShiDuoSceneView:onInitView()
	self._goscene = gohelper.findChild(self.viewGO, "bg/#go_scene")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeiLinShiDuoSceneView:addEvents()
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, self.refreshSceneBorder, self)
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoSceneView:removeEvents()
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, self.refreshSceneBorder, self)
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoSceneView:_editableInitView()
	self.elementGOMap = self:getUserDataTb_()
	self.boxCompMap = self:getUserDataTb_()
	self.boxCompList = self:getUserDataTb_()
	self.optionCompMap = self:getUserDataTb_()
	self.jumpAnimMap = self:getUserDataTb_()
end

function FeiLinShiDuoSceneView:onOpen()
	self:initMapConfig()
	self:initScene()
	self:initMapElement()
	TaskDispatcher.runRepeat(self.onTick, self, 0)
end

function FeiLinShiDuoSceneView:initMapConfig()
	if not self.viewParam.mapId then
		local gameConfig = self.viewParam.gameConfig

		FeiLinShiDuoGameModel.instance:setGameConfig(gameConfig)
		FeiLinShiDuoGameModel.instance:initConfigData(self.viewParam.mapId)
	end
end

function FeiLinShiDuoSceneView:initScene()
	self.mapConfigData = FeiLinShiDuoGameModel.instance:getMapConfigData()
	self.sceneGO = self:getResInst(self.viewContainer:getSetting().otherRes[1], self._goscene)

	local playerPos = gohelper.findChild(self.sceneGO, "Player")

	self.playerGO = gohelper.create2d(playerPos, "PlayerGO")

	transformhelper.setLocalScale(self.playerGO.transform, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale, FeiLinShiDuoEnum.PlayerScale)

	self.playerGOComp = MonoHelper.addLuaComOnceToGo(self.playerGO, FeiLinShiDuoPlayerComp)
	self.playerAnimComp = MonoHelper.addLuaComOnceToGo(self.playerGO, FeiLinShiDuoPlayerAnimComp)

	self.playerGOComp:setScene(self.sceneGO, self)

	self.sceneScale = self.mapConfigData.gameConfig.sceneScale or FeiLinShiDuoEnum.SceneDefaultScale

	transformhelper.setLocalScale(self._goscene.transform, self.sceneScale, self.sceneScale, self.sceneScale)

	self.screenWidth = gohelper.getUIScreenWidth()
	self.screenHeight = UnityEngine.Screen.height
end

function FeiLinShiDuoSceneView:initMapElement()
	self:createMapElement()
	self:initSceneBorder()
	self:initSceneAndPlayerPos()
end

function FeiLinShiDuoSceneView:resetData()
	TaskDispatcher.cancelTask(self.onTick, self)
	self:destroyAllElement()
	self:initMapConfig()
	self:initMapElement()
	TaskDispatcher.runRepeat(self.onTick, self, 0)
end

function FeiLinShiDuoSceneView:updateCamera()
	return
end

function FeiLinShiDuoSceneView:onTick()
	if FeiLinShiDuoGameModel.instance:getIsPlayerInColorChanging() then
		return
	end

	self.playerGOComp:onTick()

	for index, boxComp in pairs(self.boxCompMap) do
		boxComp:onTick()
	end

	for _, optionComp in pairs(self.optionCompMap) do
		optionComp:onTick()
	end
end

function FeiLinShiDuoSceneView:createMapElement()
	local isBlindnessMode = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local elementList = FeiLinShiDuoGameModel.instance:getElementList()

	for _, mapItem in pairs(elementList) do
		local elementItemGO = UnityEngine.GameObject.New(FeiLinShiDuoEnum.ParentName[mapItem.type] .. "_" .. mapItem.id)
		local elementItemRect = gohelper.onceAddComponent(elementItemGO, gohelper.Type_RectTransform)

		transformhelper.setLocalScale(elementItemRect, 1, 1, 1)

		local groupGO = gohelper.findChild(self.sceneGO, FeiLinShiDuoEnum.GroupName[mapItem.type])

		elementItemGO.transform:SetParent(groupGO.transform)
		transformhelper.setLocalScale(elementItemGO.transform, 1, 1, 1)
		recthelper.setAnchor(elementItemRect, mapItem.pos[1], mapItem.pos[2])

		elementItemRect.pivot = Vector2(0, 0)
		self.elementGOMap[mapItem.id] = {}
		self.elementGOMap[mapItem.id].elementGO = elementItemGO
		self.elementGOMap[mapItem.id].subGOList = {}

		for index, subItemPos in ipairs(mapItem.subGOPosList) do
			local subItemGO = self:getResInst(self.viewContainer:getSetting().otherRes[FeiLinShiDuoEnum.ItemName[mapItem.type]], elementItemGO)

			subItemGO.transform:SetParent(elementItemGO.transform, false)
			recthelper.setAnchor(subItemGO.transform, tonumber(subItemPos[1]), tonumber(subItemPos[2]))

			local subItemScaleTrans = gohelper.findChild(subItemGO, "scale").transform

			transformhelper.setLocalScale(subItemScaleTrans, mapItem.scale[1], mapItem.scale[2], 1)

			for colorType = 0, 4 do
				local subItemColorTypeGO = gohelper.findChild(subItemGO, "scale/type" .. colorType)

				if subItemColorTypeGO then
					if mapItem.color == FeiLinShiDuoEnum.ColorType.Red then
						gohelper.setActive(subItemColorTypeGO, colorType == FeiLinShiDuoEnum.ColorType.Red and not isBlindnessMode or colorType == FeiLinShiDuoEnum.ColorType.Yellow and isBlindnessMode)
					else
						gohelper.setActive(subItemColorTypeGO, mapItem.color == colorType)
					end
				end
			end

			table.insert(self.elementGOMap[mapItem.id].subGOList, subItemGO)
		end

		if mapItem.type == FeiLinShiDuoEnum.ObjectType.Box then
			local boxComp = MonoHelper.addLuaComOnceToGo(elementItemGO, FeiLinShiDuoBoxComp)

			boxComp:initData(mapItem, self)

			self.boxCompMap[mapItem.id] = boxComp

			table.insert(self.boxCompList, mapItem)
		end

		if mapItem.type == FeiLinShiDuoEnum.ObjectType.Option then
			local optionComp = MonoHelper.addLuaComOnceToGo(elementItemGO, FeiLinShiDuoOptionComp)

			optionComp:initData(mapItem, self)

			self.optionCompMap[mapItem.id] = optionComp
		end

		if mapItem.type == FeiLinShiDuoEnum.ObjectType.Jump then
			self.jumpAnimMap[mapItem.id] = self.jumpAnimMap[mapItem.id] or {}

			for _, subItemGO in pairs(self.elementGOMap[mapItem.id].subGOList) do
				for colorType = 0, 4 do
					local subItemColorTypeGO = gohelper.findChild(subItemGO, "scale/type" .. colorType)

					self.jumpAnimMap[mapItem.id][colorType] = subItemColorTypeGO:GetComponent(gohelper.Type_Animator)
				end
			end
		end
	end
end

function FeiLinShiDuoSceneView:initSceneBorder()
	self.leftBorderX = 0
	self.rightBorderX = 0
	self.topBorderY = 0
	self.bottomBorderY = 0

	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	if not elementMap[FeiLinShiDuoEnum.ObjectType.Wall] then
		if not elementMap[FeiLinShiDuoEnum.ObjectType.ColorPlane] then
			local colorPlaneList = {}
			local elementList = {}

			for _, mapItem in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Wall]) do
				table.insert(elementList, mapItem)
			end

			for _, mapItem in pairs(colorPlaneList) do
				table.insert(elementList, mapItem)
			end

			for _, mapItem in pairs(elementList) do
				for index, subItemPos in ipairs(mapItem.subGOPosList) do
					local itemPosX = mapItem.pos[1] + tonumber(subItemPos[1])
					local itemPosY = mapItem.pos[2] + tonumber(subItemPos[2])

					if self.leftBorderX == 0 and self.rightBorderX == 0 and self.topBorderY == 0 and self.bottomBorderY == 0 then
						self.leftBorderX = itemPosX
						self.rightBorderX = itemPosX
						self.topBorderY = itemPosY
						self.bottomBorderY = itemPosY
					end

					if itemPosX <= self.leftBorderX then
						self.leftBorderX = itemPosX
					end

					if itemPosX >= self.rightBorderX then
						self.rightBorderX = itemPosX
					end

					if itemPosY >= self.topBorderY then
						self.topBorderY = itemPosY
					end

					if itemPosY <= self.bottomBorderY then
						self.bottomBorderY = itemPosY
					end
				end
			end

			self.rightBorderX = self.rightBorderX + FeiLinShiDuoEnum.SlotWidth
			self.topBorderY = self.topBorderY + FeiLinShiDuoEnum.SlotWidth

			self:refreshSceneBorder()
		end
	end
end

function FeiLinShiDuoSceneView:refreshSceneBorder()
	self.screenWidth = gohelper.getUIScreenWidth()
	self.halfScreenWidth = self.screenWidth / 2
	self.halfScreenHeight = 540
	self.sceneLeftPosX = -(self.halfScreenWidth + self.leftBorderX * self.sceneScale) / self.sceneScale
	self.sceneRightPosX = (self.halfScreenWidth - self.rightBorderX * self.sceneScale) / self.sceneScale
	self.sceneTopPosY = (self.halfScreenHeight - self.topBorderY * self.sceneScale) / self.sceneScale
	self.sceneBottomPosY = -(self.halfScreenHeight + self.bottomBorderY * self.sceneScale) / self.sceneScale
	self.itemLeftBorderX = self.leftBorderX
	self.itemRightBorderX = self.rightBorderX
end

function FeiLinShiDuoSceneView:fixSceneBorder(scenePosX, scenePosY)
	if Mathf.Abs(self.itemLeftBorderX - self.itemRightBorderX) * self.sceneScale <= self.screenWidth then
		local sceneWidth = Mathf.Abs(self.itemLeftBorderX - self.itemRightBorderX)
		local sceneCenterX = self.itemLeftBorderX + sceneWidth / 2

		return -sceneCenterX, Mathf.Min(scenePosY, self.sceneBottomPosY)
	end

	return Mathf.Clamp(scenePosX, self.sceneRightPosX, self.sceneLeftPosX), Mathf.Min(scenePosY, self.sceneBottomPosY)
end

function FeiLinShiDuoSceneView:initSceneAndPlayerPos()
	local startPos = {}
	local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

	for index, info in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Start]) do
		startPos = info.pos
	end

	local screenPosX, screenPosY = self:fixSceneBorder(-startPos[1], -startPos[2])

	transformhelper.setLocalPosXY(self.sceneGO.transform, screenPosX, screenPosY)
	transformhelper.setLocalPosXY(self.playerGO.transform, startPos[1] + FeiLinShiDuoEnum.HalfSlotWidth, startPos[2])
end

function FeiLinShiDuoSceneView:changeSceneColor()
	local elementMap = FeiLinShiDuoGameModel.instance:getInterElementMap()
	local elementShowStateMap = FeiLinShiDuoGameModel.instance:getElementShowStateMap()

	for _, mapItem in pairs(elementMap) do
		gohelper.setActive(self.elementGOMap[mapItem.id].elementGO, elementShowStateMap[mapItem.id])
	end

	for _, boxComp in pairs(self.boxCompMap) do
		if boxComp:getShowState() and not boxComp:checkBoxInPlane() then
			boxComp:checkBoxFall(true)
		end
	end

	if self.playerGOComp then
		self.playerGOComp:checkPlayerFall(true)
		self.playerGOComp:checkClimbStairs()
	end
end

function FeiLinShiDuoSceneView:refreshBlindnessMode()
	local isBlindnessMode = FeiLinShiDuoGameModel.instance:getBlindnessModeState()
	local elementMap = FeiLinShiDuoGameModel.instance:getInterElementMap()

	for _, mapItem in pairs(elementMap) do
		for _, subItemGO in pairs(self.elementGOMap[mapItem.id].subGOList) do
			if mapItem.color == FeiLinShiDuoEnum.ColorType.Red then
				local normalColorTypeGO = gohelper.findChild(subItemGO, "scale/type" .. 1)
				local blindnessColorTypeGO = gohelper.findChild(subItemGO, "scale/type" .. 4)

				if normalColorTypeGO then
					gohelper.setActive(normalColorTypeGO, not isBlindnessMode)
				end

				if blindnessColorTypeGO then
					gohelper.setActive(blindnessColorTypeGO, isBlindnessMode)
				end
			end
		end
	end
end

function FeiLinShiDuoSceneView:getSceneGO()
	return self.sceneGO
end

function FeiLinShiDuoSceneView:getBoxComp(id)
	return self.boxCompMap[id]
end

function FeiLinShiDuoSceneView:getAllBoxComp()
	return self.boxCompMap
end

function FeiLinShiDuoSceneView:getAllBoxCompList()
	return self.boxCompList
end

function FeiLinShiDuoSceneView:getPlayerAnimComp()
	return self.playerAnimComp
end

function FeiLinShiDuoSceneView:getPlayerGO()
	return self.playerGO
end

function FeiLinShiDuoSceneView:getPlayerComp()
	return self.playerGOComp
end

function FeiLinShiDuoSceneView:getElementGOMap()
	return self.elementGOMap
end

function FeiLinShiDuoSceneView:getGameUIView()
	return self.viewContainer:getGameView()
end

function FeiLinShiDuoSceneView:getJumpAnim(mapItem)
	return self.jumpAnimMap[mapItem.id] and self.jumpAnimMap[mapItem.id][mapItem.color]
end

function FeiLinShiDuoSceneView:getCurGuideCheckData()
	for index, checkData in ipairs(FeiLinShiDuoEnum.GuideDataList) do
		if self.viewParam.mapId == checkData.mapId and not GuideModel.instance:isGuideFinish(checkData.guideId) then
			return checkData
		end
	end
end

function FeiLinShiDuoSceneView:onClose()
	TaskDispatcher.cancelTask(self.onTick, self)
end

function FeiLinShiDuoSceneView:destroyAllElement()
	local elementList = FeiLinShiDuoGameModel.instance:getElementList()

	for _, mapItem in pairs(elementList) do
		gohelper.destroy(self.elementGOMap[mapItem.id].elementGO)
	end

	self.elementGOMap = self:getUserDataTb_()
	self.boxCompMap = self:getUserDataTb_()
	self.boxCompList = self:getUserDataTb_()
	self.optionCompMap = self:getUserDataTb_()
	self.jumpAnimMap = self:getUserDataTb_()
end

function FeiLinShiDuoSceneView:onDestroyView()
	return
end

return FeiLinShiDuoSceneView
