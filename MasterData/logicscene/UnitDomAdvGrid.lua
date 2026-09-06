-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/domainadventure/UnitDomAdvGrid.lua

module("logicscene.scene.unit.impl.domainadventure.UnitDomAdvGrid", package.seeall)

local UnitDomAdvGrid = class("UnitDomAdvGrid", SceneUnitBase)
local SortGroupSpacingZ = 50

function UnitDomAdvGrid:ctor(componetContainer)
	UnitDomAdvGrid.super.ctor(self, componetContainer)

	self._originPos = Vector3.New(0, 0, 0)
	self._sortGroupRoots = {}
	self._resObjPool = {}
	self._resShowChamber = {}
	self._resShowRecords = {}
	self._shadowObjects = {}
end

function UnitDomAdvGrid:Awake()
	self._gridId = DomAdvPathFindingDataModel.instance:grid2Id(self.row, self.col)
	self._activityId = self.scene:getActivityIdInScene()
	self._buffId = DomainAdventureConfig.instance:getBuffIdInGrid(self._activityId, self._gridId)
	self._eventType = DomainAdventureConfig.instance:getEventType(self._activityId, self._gridId)
	self._eventId = DomainAdventureConfig.instance:getEventId(self._activityId, self._gridId)
	self._rows, self._cols = DomAdvPathFindingDataModel.instance:getSceneGridsDimension()
	self._totalCount = DomAdvPathFindingDataModel.instance:getGridCount()

	UnitDomAdvGrid.super.Awake(self)
end

function UnitDomAdvGrid:_initComponents()
	self:_addComponent("transform", UnitCompTransform)

	if self._eventType == DomAdvEnum.EventType_SolveForm then
		self:_addComponent("solveFormTips", UnitCompHudDomAdvSolveFormTips)
	elseif self._eventType == DomAdvEnum.EventType_EliteFight then
		self:_addComponent("eliteFightTips", UnitCompHudDomAdvEliteFightTips)
		self:_addComponent("eliteFightLockTips", UnitCompHudDomAdvEliteFightLockTips)
	elseif self._eventType == DomAdvEnum.EventType_Boss then
		self:_addComponent("bossClickMask", UnitCompHudDomAdvBossClickMask)
	end

	local initBlockId = DomainAdventureConfig.instance:getInitBlockId(self._activityId)

	if self._gridId == initBlockId then
		self:_addComponent("orginTips", UnitCompHudDomAdvsOrginTips)
	end

	if enableDebug then
		self:_addComponent("gmTestTips", UnitCompHudDomAdvGmTesstTips)
	end
end

function UnitDomAdvGrid:onUnitVisible(go)
	UnitDomAdvGrid.super.onUnitVisible(self, go)

	if goutil.isNil(self._gameObject) then
		return
	end

	local sortGroup = DomAdvEnum.SortGroupsInLayer[self:getLayerNum()]

	self:addObjToSortGroupRoot(self._gameObject, sortGroup)
	self:onUpdateGridUI()
end

function UnitDomAdvGrid:onUnitInVisible(go)
	self:_clearAllObj()

	if self.eliteFightLockTips then
		self.eliteFightLockTips:hide()
	end

	if self.eliteFightTips then
		self.eliteFightTips:hide()
	end

	if self.solveFormTips then
		self.solveFormTips:hide()
	end

	if self.gmTestTips then
		self.gmTestTips:hide()
	end

	UnitDomAdvGrid.super.onUnitInVisible(self, go)
end

function UnitDomAdvGrid:onUnitDestroyed()
	self:_endSelectedAnimation()
	self:_endFocusFlashAnimation()
	self:_clearAllObj()
	self:OnDestroy()
end

function UnitDomAdvGrid:update(deltaTime)
	return
end

function UnitDomAdvGrid:onUnitCreated(params)
	local posZ = self:getPosZToSort(self.row, self.col)

	self._originPos:Set(params.posX, params.posY, posZ)
	self.transform:setPos(params.posX, params.posY, posZ)
	self.transform:setMoveSpeed(0)

	local root = self.go

	for index, v in ipairs(DomAdvEnum.SortGroupList) do
		local go = goutil.findChild(root, v)

		if goutil.isNil(go) then
			go = goutil.create(v, false)

			goutil.addChildToParent(go, root)
			GameUtil.setLocalPos(go, 0, 0, -index * SortGroupSpacingZ)

			self._sortGroupRoots[v] = go
		end
	end
end

function UnitDomAdvGrid:getTag()
	return UnitTag.SceneElement
end

function UnitDomAdvGrid:getLayer()
	return SceneLayer.Unit_Value
end

function UnitDomAdvGrid:getLayerNum()
	return DomAdvEnum.Layer_GroundDown
end

function UnitDomAdvGrid:getIconSprite()
	return
end

function UnitDomAdvGrid:getSortingGroupRoot(sortGroup)
	return self._sortGroupRoots[sortGroup]
end

function UnitDomAdvGrid:getSortingOrderInGroup(sortGroup)
	return 0
end

function UnitDomAdvGrid:getPosZToSort(x, y)
	local exZ = (self._cols - y) * (#DomAdvEnum.SortGroupList * SortGroupSpacingZ)

	return -(self._totalCount - y * self._rows) + x % 2 - exZ
end

function UnitDomAdvGrid:playSelectedAnimation(finishCallBack)
	self:_endSelectedAnimation()

	local startPos = self._originPos
	local toPos = Vector3.New(startPos.x, startPos.y - 0.1, startPos.z)

	self.transform:setPos(self._originPos.x, self._originPos.y, self._originPos.z)

	local tweenerMove = self.go.transform:DOMove(toPos, 0.2)

	tweenerMove:SetLoops(2, DG.Tweening.LoopType.Yoyo)
	tweenerMove:SetEase(DG.Tweening.Ease.Linear)
	tweenerMove:OnComplete(finishCallBack)

	self._tweenerMove = tweenerMove
end

function UnitDomAdvGrid:_endSelectedAnimation()
	if self._tweenerMove then
		self._tweenerMove:Kill(false)

		self._tweenerMove = nil
	end
end

function UnitDomAdvGrid:playFocusFlashAnimation()
	self:_endFocusFlashAnimation()

	local path = "scene/domainadventure/domadv_fire_mask.prefab"

	self:_showObj(path, function()
		local resObject = self._resObjPool[path]
		local mainGo = resObject and resObject.go

		if goutil.isNil(mainGo) then
			return
		end

		self:addObjToSortGroupRoot(mainGo, DomAdvEnum.SortGroups_ChunkMaskTwo)

		local sequence = DG.Tweening.DOTween.Sequence()

		for i = 1, 3 do
			sequence:AppendCallback(function()
				GameUtil.SetActive(mainGo, false)
			end)
			sequence:AppendInterval(0.1)
			sequence:AppendCallback(function()
				GameUtil.SetActive(mainGo, true)
			end)
			sequence:AppendInterval(0.1)
		end

		sequence:AppendCallback(function()
			self:_clearObj(path)
		end)

		self._flashSequence = sequence
	end)
end

function UnitDomAdvGrid:_endFocusFlashAnimation()
	if self._flashSequence then
		self._flashSequence:Kill(true)
	end
end

function UnitDomAdvGrid:onUpdateGridUI()
	if self:isClipping() or not self:isVisible() then
		return
	end

	self:_clearChamber()
	self:_onUpdateGridStateUI()
	self:_updateChamber()

	local gridState = self.scene:getGridState(self._gridId)

	if self.eliteFightLockTips then
		if gridState:isAdjacentUnlock() or gridState:isOccupied() then
			self.eliteFightLockTips:hide()
		else
			self.eliteFightLockTips:show()
		end
	end

	if self.eliteFightTips then
		if gridState:isAdjacentUnlock() and not gridState:isOccupied() then
			self.eliteFightTips:show()
		else
			self.eliteFightTips:hide()
		end
	end

	if self.solveFormTips then
		if gridState:isOccupied() then
			self.solveFormTips:hide()
		else
			self.solveFormTips:show()
		end
	end

	if enableDebug and self.gmTestTips then
		local isShow = self.scene._IsAdvTestMode_Detail

		if isShow then
			self.gmTestTips:show()
		else
			self.gmTestTips:hide()
		end
	end
end

function UnitDomAdvGrid:_onUpdateGridStateUI()
	local gridState = self.scene:getGridState(self._gridId)
	local fields = gridState:getFields()
	local showType = self.scene:getShowType()
	local dic = {}

	for sortIndex, sortGroup in ipairs(DomAdvEnum.SortGroupList) do
		local data = DomainAdventureConfig.instance:getStateShowData(self._eventType, showType, sortGroup)

		if data then
			for index, field in ipairs(DomAdvEnum.StateFieldsList) do
				local boolValue = gridState[field](gridState)
				local numberValue = 0

				if boolValue == true then
					numberValue = 2
				elseif boolValue == false then
					numberValue = 1
				end

				if data[field] then
					local key = data[field][numberValue]

					if key == DomAdvEnum.ResKey_Empty then
						-- block empty
					elseif key == DomAdvEnum.ResKey_Over then
						dic[sortGroup] = nil
					elseif not string.nilorempty(key) then
						dic[sortGroup] = key
					end
				end
			end
		end
	end

	for sortGroup, key in pairs(dic) do
		self:_addObjToChamber(key, sortGroup)
	end
end

function UnitDomAdvGrid:getPrefabPathByResourceKey(gridId, key)
	local path

	if string.nilorempty(key) then
		return path
	end

	if key == DomAdvEnum.ResKey_BuffIcon then
		local buffData = DomainAdventureConfig.instance:getBuffData(self._activityId, self._buffId)
		local prefabPath = buffData and buffData.prefabPath

		if not string.nilorempty(prefabPath) then
			path = prefabPath .. ".prefab"
		end
	elseif key == DomAdvEnum.ResKey_Skin then
		local skinId = self:_getSkinId()
		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		if modelCo then
			path = GameUrl.getSpineUrl(modelCo.resName)
		end
	else
		path = DomainAdventureConfig.instance:getResourcePath(key)
	end

	return path
end

function UnitDomAdvGrid:showTag(isShow)
	local path = "scene/domainadventure/domadv_eyetest_mask.prefab"

	if isShow then
		local loadedHandler = GameUtil.handler(self._onObjResLoadedFinish, self, path, DomAdvEnum.SortGroups_ChunkMaskTwo)

		self:_showObj(path, loadedHandler)
	else
		self:_clearObj(path)
	end
end

function UnitDomAdvGrid:_addObjToChamber(key, sortGroup)
	self._resShowChamber[key] = sortGroup
end

function UnitDomAdvGrid:_clearChamber()
	table.clear(self._resShowChamber)
end

function UnitDomAdvGrid:_updateChamber()
	for key, path in pairs(self._resShowRecords) do
		if self._resShowChamber[key] == nil then
			self._resShowRecords[key] = nil

			self:_clearObj(path)
		end
	end

	for key, sortGroup in pairs(self._resShowChamber) do
		local path = self:getPrefabPathByResourceKey(self._gridId, key)

		self._resShowRecords[key] = path

		local loadedHandler

		self:_showObj(path, key == DomAdvEnum.ResKey_Skin and GameUtil.handler(self._onObjResLoadedFinishInPet, self, path, sortGroup) or key == DomAdvEnum.ResKey_BuffIcon and GameUtil.handler(self._onObjResLoadedFinishInBuff, self, path, sortGroup) or GameUtil.handler(self._onObjResLoadedFinish, self, path, sortGroup))
	end
end

function UnitDomAdvGrid:_showObj(path, loadedHandler)
	if string.nilorempty(path) then
		return
	end

	local resObj = self._resObjPool[path]

	if not resObj then
		resObj = self.scene.resCache:newObject(path)
		resObj.loadedHandler = loadedHandler
		self._resObjPool[path] = resObj
	end
end

function UnitDomAdvGrid:_clearAllObj()
	self:_clearChamber()

	for path, resObj in pairs(self._resObjPool) do
		self:_clearObj(path)
	end
end

function UnitDomAdvGrid:_clearObj(path)
	local resObj = self._resObjPool[path]

	if resObj then
		self.scene.resCache:recycleObject(resObj)

		self._resObjPool[path] = nil
	end

	local shadowObject = self._shadowObjects[path]

	if shadowObject then
		CommonObjectMgr.instance.shadowPool:returnObject(shadowObject)

		self._shadowObjects[path] = nil
	end
end

function UnitDomAdvGrid:_onObjResLoadedFinish(path, sortGroup)
	local resObject = self._resObjPool[path]
	local mainGo = resObject and resObject.go

	if goutil.isNil(mainGo) then
		return
	end

	self:addObjToSortGroupRoot(mainGo, sortGroup)
end

function UnitDomAdvGrid:_onObjResLoadedFinishInPet(path, sortGroup)
	local resObject = self._resObjPool[path]
	local mainGo = resObject and resObject.go

	if goutil.isNil(mainGo) then
		return
	end

	local boxCollider = mainGo:GetComponent(ComponentType.BoxCollider)

	if boxCollider then
		boxCollider.enabled = false
	end

	if mainGo.activeInHierarchy then
		GoUtil.PlaySpineAnim(mainGo, "idle", true, true)
	else
		mainGo.transform:SetParent(nil)
		GoUtil.PlaySpineAnim(mainGo, "idle", true, true)
	end

	local shadowObject = self._shadowObjects[path]

	if goutil.isNil(shadowObject) then
		shadowObject = CommonObjectMgr.instance.shadowPool:fetchObject()
		self._shadowObjects[path] = shadowObject
	end

	GoUtil.SetVisible(shadowObject, true)
	goutil.addChildToParent(shadowObject, mainGo.transform)
	Framework.GameObjectUtil.SetLayerRecursively(shadowObject, self:getLayer())
	Framework.TransformUtil.SetLocalPos(shadowObject.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalRotation(shadowObject.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(shadowObject.transform, 10, 10, 20)
	goutil.setActive(shadowObject, true)
	GoUtil.SetVisible(mainGo, true)
	self:addObjToSortGroupRoot(mainGo, sortGroup)

	local scale = self:_getSkinScale() or {}

	if not scale[2] then
		local scaleX, scaleY = scale[1] or 0.2, 0.2

		GameUtil.setLocalScale(mainGo, scaleX, scaleY, scaleY)

		local pos = self:_getSkinPos() or {}
		local posX, posY, posZ = checknumber(pos[1]), checknumber(pos[2]), checknumber(pos[3])

		GameUtil.setLocalPos(mainGo, posX, posY, posZ)
	end
end

function UnitDomAdvGrid:_onObjResLoadedFinishInBuff(path, sortGroup)
	local resObject = self._resObjPool[path]
	local mainGo = resObject and resObject.go

	if goutil.isNil(mainGo) then
		return
	end

	self:addObjToSortGroupRoot(mainGo, sortGroup)
end

function UnitDomAdvGrid:addObjToSortGroupRoot(mainGo, sortGroup)
	local root = self:getSortingGroupRoot(sortGroup)

	goutil.addChildToParent(mainGo, root)
	GameUtil.setLocalScale(mainGo, 1)
	GameUtil.setLocalPos(mainGo, 0, 0, 0)

	local sortingOrder = self:getSortingOrderInGroup(sortGroup)

	GoUtil.SetSortingOrder(mainGo, sortingOrder)

	local renders = self:_findChildCompWithComponent(mainGo, ComponentType.MeshRenderer)

	for i, v in ipairs(renders) do
		v.sortingOrder = sortingOrder
	end
end

function UnitDomAdvGrid:_findChildCompWithComponent(gameObject, componentType)
	local result = {}
	local stack = {
		gameObject.transform
	}
	local rootComp = gameObject:GetComponent(componentType)

	if rootComp then
		table.insert(result, rootComp)
	end

	while #stack > 0 do
		local current = table.remove(stack)

		for i = 0, current.childCount - 1 do
			local child = current:GetChild(i)
			local comp = child:GetComponent(componentType)

			if comp then
				table.insert(result, comp)
			end

			table.insert(stack, child)
		end
	end

	return result
end

function UnitDomAdvGrid:_getSkinId()
	local data = self:_getEventData()

	return (data or nil) and (data.skinId or 0)
end

function UnitDomAdvGrid:_getSkinPos()
	local data = self:_getEventData()

	return data and data.pos
end

function UnitDomAdvGrid:_getSkinScale()
	local data = self:_getEventData()

	return data and data.scale
end

function UnitDomAdvGrid:_getEventData()
	return DomainAdventureController.instance:getEventData(self._activityId, self._eventType, self._eventId)
end

return UnitDomAdvGrid
