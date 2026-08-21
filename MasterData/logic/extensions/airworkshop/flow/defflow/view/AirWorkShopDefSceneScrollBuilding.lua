-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollBuilding.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollBuilding", package.seeall)

local M = class("AirWorkShopDefSceneScrollBuilding", AirWorkShopDefSceneScrollBuildingBase)

function M:buildUI()
	self._btnSwitch = Astral.ButtonAdapter.GetFrom(self.mainGO, "btnSwitch")

	self._btnSwitch:AddClickListener(self._onClickSwitch, self)

	self._groundBtnGo = goutil.findChild(self.mainGO, "btnSwitch/state1")
	self._upgroundBtnGo = goutil.findChild(self.mainGO, "btnSwitch/state2")

	M.super.buildUI(self)
end

function M:destroy()
	M.super.destroy(self)
	self._btnSwitch:RemoveClickListener()
end

function M:_initData()
	self._onGround = false

	M.super._initData(self)
end

function M:_onClickSwitch()
	self._onGround = not self._onGround

	self:_updateCurBuildings()
	self:_updateScrollView()
end

function M:_updateCurBuildings()
	goutil.setActive(self._groundBtnGo, self._onGround)
	goutil.setActive(self._upgroundBtnGo, not self._onGround)
	BattleTableUtil.clearTable(self._curBuildingCOList)

	for i, buildCO in ipairs(self._buildingCOList) do
		if buildCO.terrainId > 0 then
			local terrainCO = TerrainConfig.instance:getAdditionalTerrainCO(buildCO.terrainId)

			if not terrainCO and enableErrorLog then
				printError("该地形配置不存在,建筑id,地形id", buildCO.id, buildCO.terrainId)
			end

			if terrainCO.effect == AirWorkShopEnum.BuildingType.DoubleD and self._onGround then
				table.insert(self._curBuildingCOList, buildCO)
			end

			if terrainCO.effect == AirWorkShopEnum.BuildingType.TripleD and not self._onGround then
				table.insert(self._curBuildingCOList, buildCO)
			end
		end
	end
end

function M:_getAllBuildingList()
	return AirWorkShopDefSceneModel.instance:getAvailableBuildingCOList()
end

function M:onBeginDragHeadItem(headItem, screenX, screenY)
	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	if not AirWorkShopDefSceneModel.instance:isEnableAdjustment() then
		return
	end

	if self._isDraging then
		return
	end

	if AirWorkShopDefSceneModel.instance:isDragging() then
		return
	end

	if AirWorkShopDefOperateUtil.isUnitReachLimit(self:_getUnitTagType()) then
		FloatWordMgr.instance:show(lang("tip_airwork_reach_limit"))

		return
	end

	self._isDraging = true
	self._selectedAnimation = true

	self:_setSceneDragEnable(false)

	self._dragUnit = self:_createDragUnit(headItem:getBuildingId())

	AirWorkShopDefSceneModel.instance:setDragging(true)
	self:setSelectedId(headItem:getBuildingId(), true)
	self:onDragHeadItem(headItem, screenX, screenY)
end

function M:_afterEndDrag(dragUnit, unionIndex)
	AirWorkShopDefSceneUtil.playPlaceEffect(dragUnit)
end

function M:_getUnitTagType()
	return AirWorkShopEnum.TabEnum.Building
end

function M:_onSelectItem()
	local terrainId = false

	if self._selectBuildingId and self._selectBuildingId > 0 then
		local buildCO = AirWorkShopConfig.instance:getBuildingCO(self._selectBuildingId)

		if buildCO and buildCO.terrainId then
			terrainId = buildCO.terrainId
		end
	end

	AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.OnTerrainInfoVisibleUpdate, terrainId)
end

return M
