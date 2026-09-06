-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/domainadventure/UnitCompDomAdvEvent.lua

module("logicscene.scene.unit.component.season.UnitCompDomAdvEvent", package.seeall)

local UnitCompDomAdvEvent = class("UnitCompDomAdvEvent", UnitComponentBase)

function UnitCompDomAdvEvent:onInit()
	self._evtGo = nil
	self._eventHandler = nil
	self._isVisible = true
	self._gridId = self._unit.scene:getGridIdByElementId(self._unit.id)
end

function UnitCompDomAdvEvent:onDestroy()
	self:_clearEvtGo()

	self._eventHandler = nil
	self._unit = nil
end

function UnitCompDomAdvEvent:setVisible(visible)
	if self._isVisible == visible then
		return
	end

	self._isVisible = visible
end

function UnitCompDomAdvEvent:onUnitVisible(go)
	self._evtGo = go

	self:updateEvent()
	self:updateFogState()
	self:updateOccupiedState()
end

function UnitCompDomAdvEvent:updateFogState()
	if goutil.isNil(self._evtGo) or self._unit:isClipping() then
		return
	end

	if self._evtGo then
		local seasonModel = SeasonModel.instance
		local mapMo = seasonModel:getMapInfoById(self._gridId)

		if mapMo then
			local gridX, gridY = mapMo:getGridPos()

			if mapMo._fogState == SeasonMapDataMO.Fog_Within then
				self._evtGo:SetActive(false)
			elseif SeasonModel.instance:isOccupied(self._gridId) then
				local gridId = self._gridId
				local seasonId = SeasonModel.instance:getSeasonId()
				local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId) or {}
				local eventType = checknumber(evtConfig.eventType)
				local needShow = SeasonGridEvtTypes.IsOccupiedNeedShow[eventType]

				if not needShow then
					self._evtGo:SetActive(false)
				else
					self._evtGo:SetActive(self._isVisible)
				end
			else
				self._evtGo:SetActive(self._isVisible)
			end
		end
	end
end

function UnitCompDomAdvEvent:updateOccupiedState()
	if goutil.isNil(self._evtGo) or self._unit:isClipping() then
		return
	end

	if self._evtGo then
		local gridId = self._gridId
		local seasonId = SeasonModel.instance:getSeasonId()
		local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId) or {}
		local eventType = checknumber(evtConfig.eventType)
		local needShow = SeasonGridEvtTypes.IsOccupiedNeedShow[eventType]

		if not needShow then
			if SeasonModel.instance:isOccupied(gridId) then
				self._evtGo:SetActive(false)

				if self._eventHandler then
					self._eventHandler:onDeactive()
				end
			end
		else
			self:updateEvent()
		end
	end
end

function UnitCompDomAdvEvent:onUnitInVisible(go)
	self:_clearEvtGo()
end

function UnitCompDomAdvEvent:getDependentResources()
	self:_createEventHandler()

	if self._eventHandler then
		return self._eventHandler:getDependentResources()
	end
end

function UnitCompDomAdvEvent:handleBossPhaseChange(prePhaseId, curPhaseId)
	self:_createEventHandler()

	if self._eventHandler then
		self._eventHandler:handleBossPhaseChange(prePhaseId, curPhaseId)
	end
end

function UnitCompDomAdvEvent:setPrepareTranspointAnim(prepared)
	self:_createEventHandler()

	if self._eventHandler then
		self._eventHandler:setPrepareTranspointAnim(prepared)
	end
end

function UnitCompDomAdvEvent:setPlayedBossAppear()
	self:_createEventHandler()

	if self._eventHandler then
		self._eventHandler:setPlayedBossAppear()
	end
end

function UnitCompDomAdvEvent:setPlayedDoppelgangerAppear()
	self:_createEventHandler()

	if self._eventHandler then
		self._eventHandler:setPlayedDoppelgangerAppear()
	end
end

function UnitCompDomAdvEvent:updateEvent()
	if goutil.isNil(self._evtGo) or self._unit:isClipping() then
		return
	end

	self:_createEventHandler()

	if self._eventHandler then
		self._eventHandler:onActive(self._evtGo)
	end
end

function UnitCompDomAdvEvent:getIconSprite()
	self:_createEventHandler()

	if self._eventHandler then
		return self._eventHandler:getIconSprite()
	end
end

function UnitCompDomAdvEvent:_createEventHandler()
	local gridId = SeasonPathFindingDataModel.instance:grid2Id(self._unit.row, self._unit.col)
	local seasonId = SeasonModel.instance:getSeasonId()
	local evtCfg = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId)

	if not evtCfg then
		printError(">>>>>>>>>>>>> 检查 格子为什么读取不到配置：", seasonId, gridId)

		return
	end

	self._eventHandler = self._eventHandler or SeasonSceneEventImplBase.createEvtHandler(self._unit, evtCfg)
end

function UnitCompDomAdvEvent:_clearEvtGo()
	self._evtGo = nil

	if self._eventHandler then
		self._eventHandler:onDeactive()
	end
end

return UnitCompDomAdvEvent
