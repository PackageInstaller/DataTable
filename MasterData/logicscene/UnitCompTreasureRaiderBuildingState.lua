-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/treasureraider/UnitCompTreasureRaiderBuildingState.lua

module("logicscene.scene.unit.component.treasureraider.UnitCompTreasureRaiderBuildingState", package.seeall)

local UnitCompTreasureRaiderBuildingState = class("UnitCompTreasureRaiderBuildingState", UnitComponentBase)

UnitCompTreasureRaiderBuildingState.FocusResPath = "scene/tiling/treasure_raider/treasure_raider_building_focus.prefab"

function UnitCompTreasureRaiderBuildingState:onInit()
	self._focusResObject = nil
end

function UnitCompTreasureRaiderBuildingState:onDestroy()
	self:_clearFocusResObj()
end

function UnitCompTreasureRaiderBuildingState:onUnitVisible(go)
	self:updateFocusStatus()
end

function UnitCompTreasureRaiderBuildingState:onUnitInVisible(go)
	self:_clearFocusResObj()
end

function UnitCompTreasureRaiderBuildingState:isNeedShowNearEffect()
	local sceneMo = self._unit.scene:getSceneMo()

	return sceneMo:isNeedShowNearEffect(self._unit.row, self._unit.col)
end

function UnitCompTreasureRaiderBuildingState:isNeedShowEditEffect()
	local tool = self._unit.scene:getTool()
	local gridId = tool:grid2Id(self._unit.row, self._unit.col)

	return TREditorController.instance:isInState(TREditorController.EMode_EditorMode) and not tool:isGridDisableToEdit(gridId)
end

function UnitCompTreasureRaiderBuildingState:updateFocusStatus()
	if self._unit:isClipping() then
		self:_clearFocusResObj()

		return
	end

	self._bNeedShowNearEffect = self:isNeedShowNearEffect()
	self._bNeedShowEditEffect = self:isNeedShowEditEffect()

	if not self._bNeedShowNearEffect and not self._bNeedShowEditEffect then
		self:_clearFocusResObj()

		return
	end

	if not self._focusResObject then
		self._focusResObject = self._unit.scene.resCache:newObject(UnitCompTreasureRaiderBuildingState.FocusResPath)

		self._focusResObject:setParent(self._unit.go.transform)
		self._focusResObject:setScale(1)
		self._focusResObject:setLocalPos(0, 0, -0.005)
		self:updateLayer()

		self._focusResObject.loadedHandler = self._onFocusResLoadedFinish
		self._focusResObject.loadedHandlerTarget = self
	else
		self:_onFocusResLoadedFinish()
	end
end

function UnitCompTreasureRaiderBuildingState:updateLayer()
	if self._focusResObject then
		self._focusResObject:setSortingOrder(self._unit:getSortingOrderOffset(SeasonLayerTypes.LAYER_GROUND_DOWN))
	end
end

function UnitCompTreasureRaiderBuildingState:_onFocusResLoadedFinish()
	if not self._focusResObject then
		return
	end

	local go = self._focusResObject.go

	if goutil.isNil(go) then
		return
	end

	local arrow = goutil.findChild(go, "arrow")
	local placed = goutil.findChild(go, "placed")

	GoUtil.SetSortingOrder(arrow, 1)

	if self._bNeedShowEditEffect then
		arrow:SetActive(false)
		placed:SetActive(true)
		self:_stopArrowAnim()
	elseif self._bNeedShowNearEffect then
		arrow:SetActive(true)
		placed:SetActive(true)
		self:_playArrowAnim(arrow, 1)
	else
		arrow:SetActive(false)
		placed:SetActive(false)
		self:_stopArrowAnim()
	end
end

local downPosY = 1.637
local upPosY = 1.8

function UnitCompTreasureRaiderBuildingState:_playArrowAnim(arrow, direction)
	if goutil.isNil(arrow) then
		return
	end

	self:_stopArrowAnim()

	local stepY = upPosY - downPosY
	local beginValue, endValue

	if direction == 1 then
		endValue = 1
		beginValue = 0
	else
		endValue = 0
		beginValue = 1
	end

	local localPos = GameUtil.getLocalPos(arrow)
	local sequence = DG.Tweening.DOTween.Sequence()

	self._arrowTween = sequence

	local function updateTween(num)
		local y = stepY * num + downPosY

		GameUtil.setLocalPos(arrow, localPos.x, y, localPos.z)
	end

	sequence:Append(TweenUtil.DOTweenNum(beginValue, endValue, 1.2, updateTween, {}))
	sequence:OnComplete(function()
		self:_playArrowAnim(arrow, -direction)
	end)
end

function UnitCompTreasureRaiderBuildingState:_stopArrowAnim()
	if self._arrowTween then
		self._arrowTween:Kill(false)

		self._arrowTween = nil
	end
end

function UnitCompTreasureRaiderBuildingState:_clearFocusResObj()
	self:_stopArrowAnim()

	if self._focusResObject then
		self._unit.scene.resCache:recycleObject(self._focusResObject)

		self._focusResObject = nil
	end
end

return UnitCompTreasureRaiderBuildingState
