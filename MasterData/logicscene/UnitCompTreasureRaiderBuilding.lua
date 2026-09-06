-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/treasureraider/UnitCompTreasureRaiderBuilding.lua

module("logicscene.scene.unit.component.treasureraider.UnitCompTreasureRaiderBuilding", package.seeall)

local UnitCompTreasureRaiderBuilding = class("UnitCompTreasureRaiderBuilding", UnitComponentBase)

UnitCompTreasureRaiderBuilding.StopProduceResPath = "effect/prefabs/ui/20221223/duobaoqibing/fx_xiaoyan_duobaoqibing.prefab"
UnitCompTreasureRaiderBuilding.BuildingPathFormat = "scene/tiling/treasure_raider/buildings/%s.prefab"
UnitCompTreasureRaiderBuilding.UpgradeResPath = "effect/prefabs/ui/20221223/duobaoqibing/fx_shengji_duobaoqibing.prefab"

function UnitCompTreasureRaiderBuilding:onInit()
	self._buildingResObject = nil
	self._stopProduceResObject = nil
	self._bHasResource = false
end

function UnitCompTreasureRaiderBuilding:onDestroy()
	self:_clearGo()
end

function UnitCompTreasureRaiderBuilding:onUnitVisible(go)
	self:invalidate()
end

function UnitCompTreasureRaiderBuilding:onUnitInVisible(go)
	self:_clearGo()
end

function UnitCompTreasureRaiderBuilding:invalidate(bForce)
	if not bForce and self._unit:isClipping() then
		return
	end

	self:_createBuilding(bForce)
end

function UnitCompTreasureRaiderBuilding:_getCurStatus()
	return 0
end

function UnitCompTreasureRaiderBuilding:_createStopProduceEffect()
	if self._unit:isClipping() then
		self:_clearStopProduceEffect()

		return
	end

	if not self._buildingResObject then
		self:_clearStopProduceEffect()

		return
	end

	if goutil.isNil(self._buildingResObject.go) then
		self:_clearStopProduceEffect()

		return
	end

	local buildingId = self._unit.gridUnit:getBuildingId()

	if buildingId <= 0 then
		self:_clearStopProduceEffect()

		return
	end

	local buildingMo = self._unit.gridUnit:getBuildingMo()

	if buildingMo.resourceConfig == nil or not buildingMo:isStopProduce() then
		self:_clearStopProduceEffect()

		return
	end

	if not self._stopProduceResObject then
		self._stopProduceResObject = self._unit.scene.resCache:newObject(UnitCompTreasureRaiderBuilding.StopProduceResPath)

		self._stopProduceResObject:setParent(self._buildingResObject.go.transform)
		self._stopProduceResObject:setScale(1)
		self._stopProduceResObject:setLocalPos(-0.05, -0.2, -0.025)
	end
end

function UnitCompTreasureRaiderBuilding:_clearStopProduceEffect()
	if self._stopProduceResObject then
		self._unit.scene.resCache:recycleObject(self._stopProduceResObject)

		self._stopProduceResObject = nil
	end
end

function UnitCompTreasureRaiderBuilding:_createBuilding(bForce)
	self:_clearBuildingResObj()

	if not bForce and self._unit:isClipping() then
		return
	end

	local buildingId = self._unit.gridUnit:getBuildingId()

	if buildingId <= 0 then
		return
	end

	local buildingMo = self._unit.gridUnit:getBuildingMo()
	local path = string.format(UnitCompTreasureRaiderBuilding.BuildingPathFormat, buildingMo:getBuildingScenePrefabPath())

	if not self._buildingResObject then
		self._buildingResObject = self._unit.scene.resCache:newObject(path)

		self._buildingResObject:setParent(self._unit.go.transform)
		self._buildingResObject:setScale(1)
		self._buildingResObject:setLocalPos(-0.05, -0.2, -0.015)

		if self._unit.id < 0 then
			self._buildingResObject:setSortingOrder(2)
		else
			self._buildingResObject:setSortingOrder(0)
		end

		self._buildingResObject.loadedHandler = self._updateBuildingStatus
		self._buildingResObject.loadedHandlerTarget = self
	else
		self:_updateBuildingStatus()
	end
end

function UnitCompTreasureRaiderBuilding:_clearBuildingResObj()
	if self._buildingResObject then
		self._unit.scene.resCache:recycleObject(self._buildingResObject)

		self._buildingResObject = nil
	end

	self:_clearStopProduceEffect()
end

function UnitCompTreasureRaiderBuilding:_updateBuildingStatus()
	if not self._buildingResObject then
		return
	end

	local go = self._buildingResObject.go

	if goutil.isNil(go) then
		return
	end

	self._sceneUnit = SceneUnit.Get(go, self._unit.scene.stage.wholeScene)

	local stateNode = self._buildingResObject.go.transform:Find("state")

	if not stateNode then
		return
	end

	local transform = stateNode
	local childCount = transform.childCount
	local currStatusGo
	local curStatus = self:_getCurStatus()

	curStatus = tostring(curStatus)

	for i = 0, childCount - 1 do
		local statusGo = transform:GetChild(i).gameObject
		local isActive = not not string.find(statusGo.name, curStatus)

		statusGo:SetActive(isActive or false)

		if isActive then
			currStatusGo = statusGo
		end
	end

	if not currStatusGo then
		for i = 0, childCount - 1 do
			local statusGo = transform:GetChild(i).gameObject
			local isActive = not not string.find(statusGo.name, "0")

			statusGo:SetActive(isActive or false)
		end
	end

	local levelbg = goutil.findChild(go, "levelbg")
	local buildingMo = self._unit.gridUnit:getBuildingMo() or {}
	local bNeedShowLevel = buildingMo:isNeedShowLevel()

	if not buildingMo.buildingLevel then
		local showLevel = 0

		if bNeedShowLevel and showLevel > 0 then
			GameUtil.SetActive(levelbg, true)

			for i = 1, 15 do
				local img = goutil.findChild(levelbg, "level_" .. i)

				GameUtil.SetActive(img, i == checknumber(showLevel))
			end
		else
			GameUtil.SetActive(levelbg, false)
		end

		local behit = goutil.findChild(go, "behit")

		GameUtil.SetActive(behit, buildingMo.resourceConfig ~= nil and buildingMo:isStopProduce())
		self:_createStopProduceEffect()
	end
end

function UnitCompTreasureRaiderBuilding:_clearGo()
	self:_clearBuildingResObj()
	self:_clearUpgradeEffect()
end

function UnitCompTreasureRaiderBuilding:playUpgradeEffect()
	local eff

	eff = GameEffectManager.instance:playEffect(UnitCompTreasureRaiderBuilding.UpgradeResPath, false, nil, 0, 0, 0, function()
		GameEffectManager.instance:stopEffect(eff)

		self._upgradeEffect = nil
	end)

	eff:setParent(self._unit.go.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)
	eff:setSortingOrder(1)
end

function UnitCompTreasureRaiderBuilding:_clearUpgradeEffect()
	if self._upgradeEffect then
		GameEffectManager.instance:stopEffect(self._upgradeEffect)

		self._upgradeEffect = nil
	end
end

return UnitCompTreasureRaiderBuilding
