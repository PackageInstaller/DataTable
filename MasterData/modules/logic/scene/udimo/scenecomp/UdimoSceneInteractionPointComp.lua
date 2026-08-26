-- chunkname: @modules/logic/scene/udimo/scenecomp/UdimoSceneInteractionPointComp.lua

module("modules.logic.scene.udimo.scenecomp.UdimoSceneInteractionPointComp", package.seeall)

local UdimoSceneInteractionPointComp = class("UdimoSceneInteractionPointComp", BaseSceneComp)

function UdimoSceneInteractionPointComp:onInit()
	return
end

function UdimoSceneInteractionPointComp:onSceneStart(sceneId, levelId)
	return
end

function UdimoSceneInteractionPointComp:init(sceneId, levelId)
	local scene = self:getCurScene()

	self.pointResUrl = ResUrl.getDungeonMapRes(UdimoEnum.Const.InteractPointRes)

	scene.loader:makeSureLoaded({
		self.pointResUrl
	}, self._onLoadedInteractPointRes, self)
end

function UdimoSceneInteractionPointComp:_onLoadedInteractPointRes()
	local scene = self:getCurScene()

	if not scene or not self.pointResUrl then
		return
	end

	local interactPointRoot = scene.go:getInteractPointRoot()

	self.interactPointGO = gohelper.findChild(interactPointRoot, UdimoEnum.SceneGOName.InteractPointGO)

	if gohelper.isNil(self.interactPointGO) then
		local assetRes = scene.loader:getResource(self.pointResUrl)

		self.interactPointGO = gohelper.clone(assetRes, interactPointRoot, UdimoEnum.SceneGOName.InteractPointGO)
	end

	self:initInteractPoints()
	self:refreshInteractPointActive()
	self:addEventListeners()
end

function UdimoSceneInteractionPointComp:initInteractPoints()
	self:clearAllInteractPoints()

	local pointPosDataList = {}
	local scene = self:getCurScene()
	local sceneObj = scene.level:getSceneGo()
	local interactGO = gohelper.findChild(sceneObj, UdimoEnum.SceneGOName.Interact)
	local interactTrans = interactGO.transform
	local childCount = interactTrans.childCount
	local useBg = UdimoItemModel.instance:getUseBg()
	local interactList, interactDict = UdimoConfig.instance:getInteractListAndDict(useBg)
	local needCount = #interactList

	if childCount < needCount then
		logError(string.format("UdimoSceneInteractionPointComp:initInteractPoints error, interact point count not enough, bg:%s hasCount:%s needCount:%s", useBg, childCount, needCount))
	end

	local repeatDict = {}

	for i = 1, childCount do
		local child = interactTrans:GetChild(i - 1)
		local interactId = tonumber(child.name)

		if not repeatDict[interactId] then
			if interactId and interactDict[interactId] then
				local x, y, z = transformhelper.getPos(child)

				pointPosDataList[i] = {
					interactId = interactId,
					worldPos = {
						x = x,
						y = y,
						z = z
					}
				}
				repeatDict[interactId] = true
			end
		else
			logError(string.format("UdimoSceneInteractionPointComp:initInteractPoints error, interact point repeat, bg:%s name:%s", useBg, interactId))
		end
	end

	local interactPointRoot = scene.go:getInteractPointRoot()

	gohelper.CreateObjList(self, self._onCreateInteractPointItem, pointPosDataList, interactPointRoot, self.interactPointGO)
end

function UdimoSceneInteractionPointComp:_onCreateInteractPointItem(obj, data, _)
	local pointItem = {
		go = obj,
		gohighlight = gohelper.findChild(obj, "light"),
		gonormal = gohelper.findChild(obj, "normal"),
		data = data
	}
	local trans = obj.transform
	local worldPos = data.worldPos

	transformhelper.setPos(trans, worldPos.x, worldPos.y, worldPos.z)

	local camera = CameraMgr.instance:getMainCamera()
	local objScreenPos = camera:WorldToScreenPoint(trans.position)
	local sizeArr = UdimoConfig.instance:getUdimoConst(UdimoEnum.ConstId.InteractPointSize, false, "#", true)
	local sizeX = sizeArr[1]
	local sizeY = sizeArr[2]

	pointItem.detectionRect = UnityEngine.Rect.New(objScreenPos.x - sizeX / 2, objScreenPos.y - sizeY / 2, sizeX, sizeY)

	local scene = self:getCurScene()

	if scene and scene.level then
		scene.level:addGameObjectToColorCtrl(pointItem.go, true)
	end

	self._interactPointDict[data.interactId] = pointItem
end

function UdimoSceneInteractionPointComp:addEventListeners()
	UdimoController.instance:registerCallback(UdimoEvent.OnPickUpUdimo, self._onPickUpUdimoUpdate, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnPickUpUdimoOver, self._onPickUpUdimoUpdate, self)
	UdimoController.instance:registerCallback(UdimoEvent.OnDraggingUdimo, self._onDraggingUdimo, self)
end

function UdimoSceneInteractionPointComp:removeEventListeners()
	UdimoController.instance:unregisterCallback(UdimoEvent.OnPickUpUdimo, self._onPickUpUdimoUpdate, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnPickUpUdimoOver, self._onPickUpUdimoUpdate, self)
	UdimoController.instance:unregisterCallback(UdimoEvent.OnDraggingUdimo, self._onDraggingUdimo, self)
end

function UdimoSceneInteractionPointComp:_onPickUpUdimoUpdate()
	self:refreshInteractPointActive()
end

function UdimoSceneInteractionPointComp:_onDraggingUdimo(screenPos)
	self:refreshInteractPointHighlight(screenPos)
end

function UdimoSceneInteractionPointComp:onScenePrepared(sceneId, levelId)
	return
end

function UdimoSceneInteractionPointComp:refreshInteractPointActive()
	if not self._interactPointDict then
		return
	end

	local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

	if pickedUpUdimo then
		::label_12_0::

		local udimoType = UdimoConfig.instance:getUdimoType(pickedUpUdimo)
		local useBg = UdimoItemModel.instance:getUseBg()

		for interactId, pointItem in pairs(self._interactPointDict) do
			local typeDict = UdimoConfig.instance:getInteractTypeDict(useBg, interactId)
			local hasUdimoId = UdimoModel.instance:getInteractPointUdimo(interactId)

			gohelper.setActive(pointItem.gohighlight, false)

			local var_12_0

			if pickedUpUdimo then
				::label_12_1::

				var_12_0 = typeDict[udimoType] and not hasUdimoId
			end

			gohelper.setActive(pointItem.go, var_12_0)
		end
	end
end

function UdimoSceneInteractionPointComp:refreshInteractPointHighlight(screenPos)
	if not self._interactPointDict then
		return
	end

	local placeInteractId = self:getCanPlaceInteractPoint(screenPos)

	for interactId, pointItem in pairs(self._interactPointDict) do
		gohelper.setActive(pointItem.gohighlight, interactId == placeInteractId)
	end
end

function UdimoSceneInteractionPointComp:getCanPlaceInteractPoint(screenPos, udimoId)
	if not self._interactPointDict or not screenPos then
		return
	end

	if not udimoId then
		::label_14_0::

		local pickedUpUdimo = UdimoModel.instance:getPickedUpUdimoId()

		if pickedUpUdimo then
			::label_14_1::

			local udimoType = UdimoConfig.instance:getUdimoType(pickedUpUdimo)
			local useBg = UdimoItemModel.instance:getUseBg()

			for interactId, pointItem in pairs(self._interactPointDict) do
				local hasUdimoId = UdimoModel.instance:getInteractPointUdimo(interactId)

				if not hasUdimoId then
					local typeDict = UdimoConfig.instance:getInteractTypeDict(useBg, interactId)

					if udimoType and typeDict[udimoType] then
						local isCanPlaced = pointItem.detectionRect:Contains(screenPos)

						if isCanPlaced then
							return interactId
						end
					end
				end
			end
		end
	end
end

function UdimoSceneInteractionPointComp:getInteractPointWorldPos(interactId)
	if self._interactPointDict then
		if self._interactPointDict then
			return self._interactPointDict.data.worldPos
		end
	end
end

function UdimoSceneInteractionPointComp:clearAllInteractPoints()
	if self._interactPointDict then
		local scene = self:getCurScene()

		for _, pointItem in pairs(self._interactPointDict) do
			local go = pointItem.go

			if scene and scene.level then
				scene.level:removeGameObjectToColorCtrl(go, true)
			end

			pointItem.go = nil
			pointItem.gohighlight = nil
			pointItem.gonormal = nil
			pointItem.detectionRect = nil

			gohelper.destroy(go)
		end
	end

	self._interactPointDict = {}
end

function UdimoSceneInteractionPointComp:onSceneClose()
	self.pointResUrl = nil

	if not gohelper.isNil(self.interactPointGO) then
		gohelper.destroy(self.interactPointGO)
	end

	self.interactPointGO = nil

	self:removeEventListeners()
	self:clearAllInteractPoints()
end

return UdimoSceneInteractionPointComp
