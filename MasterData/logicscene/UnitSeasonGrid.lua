-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonGrid.lua

module("logicscene.scene.unit.impl.season.UnitSeasonGrid", package.seeall)

local UnitSeasonGrid = class("UnitSeasonGrid", UnitSeasonGridElem)

function UnitSeasonGrid:getTag()
	return UnitTag.SceneElement
end

function UnitSeasonGrid:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("elements", UnitCompSeasonGridElems)
	self:_addComponent("gridStatus", UnitCompSeasonState)
	self:_addComponent("occupiedStatus", UnitCompSeasonOccupied)
end

function UnitSeasonGrid:onUnitCreated(params)
	UnitSeasonGrid.super.onUnitCreated(self, params)

	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self.row, self.col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

	if evtCfg then
		self._eventObjId = evtCfg.eventObjId
	end
end

function UnitSeasonGrid:onSeasonMinimapOpenedOrClosed(opened)
	self.occupiedStatus:onSeasonMinimapOpenedOrClosed(opened)
end

function UnitSeasonGrid:prepareMiniMapReady()
	local elements = self.elements:getElements()
	local curScene = SceneMgr.instance:getCurScene()

	for k, v in pairs(elements) do
		if curScene.miniMap and curScene.miniMap:isUnitInCurRegionMinimapRange(v) and v:isClipping() then
			return false
		end
	end

	return self.occupiedStatus:prepareMiniMapReady()
end

function UnitSeasonGrid:playSelectedAnimation()
	local startx, starty, startz = self.transform:getPos()
	local offsetY = -0.1
	local startPos = Vector3.New(startx, starty, startz)
	local destPos = Vector3.New(startx, starty + offsetY, startz)

	if not self._selectSinkAnim then
		self._selectSinkAnim = UnityTweens.TweenPosition.Create(self.go, startPos, destPos, 0.1)

		self._selectSinkAnim:AddListener(self._onSelectSinkFinished, self)
	end

	self._selectFloatAnim = self._selectFloatAnim or UnityTweens.TweenPosition.Create(self.go, destPos, startPos, 0.2)

	self._selectSinkAnim:Stop()
	self._selectFloatAnim:Stop()

	self._selectSinkAnim.from = startPos
	self._selectSinkAnim.to = destPos
	self._selectFloatAnim.from = destPos
	self._selectFloatAnim.to = startPos

	self._selectSinkAnim:Begin()
end

function UnitSeasonGrid:getEventObjectId()
	return self._eventObjId or 0
end

function UnitSeasonGrid:getPositionOffsetY()
	local x, y = self.transform:getPos()
	local gridX, gridY = SeasonPathFindingDataModel.instance:grid2Pos(self.row, self.col)

	return y - gridY
end

function UnitSeasonGrid:onUnitDestroyed()
	if self._selectSinkAnim then
		self._selectSinkAnim:RemoveListener()
	end

	self._selectFloatAnim = nil
	self._selectSinkAnim = nil

	UnitSeasonGrid.super.onUnitDestroyed(self)
end

function UnitSeasonGrid:_onSelectSinkFinished()
	self._selectFloatAnim:Begin()
end

return UnitSeasonGrid
