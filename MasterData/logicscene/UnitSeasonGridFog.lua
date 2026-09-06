-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonGridFog.lua

module("logicscene.scene.unit.impl.season.UnitSeasonGridFog", package.seeall)

local UnitSeasonGridFog = class("UnitSeasonGridFog", UnitSeasonGridElem)

function UnitSeasonGridFog:disappear()
	self._disappear = true
	self._disappearFinished = false
end

function UnitSeasonGridFog:onUnitVisible(go)
	UnitSeasonGridFog.super.onUnitVisible(self, go)
	self:updateOccupiedStatus()
end

function UnitSeasonGridFog:forceDisappear()
	self._disappear = true
	self._disappearFinished = true

	if self._gameObject then
		self._gameObject:SetActive(false)
	end
end

function UnitSeasonGridFog:updateOccupiedStatus()
	if self._gameObject then
		self._spRenderer = self._gameObject:GetComponentInChildren(ComponentType.SpriteRenderer, true)

		local color = self._spRenderer.color

		color.a = 1
		self._spRenderer.color = color

		local seasonId = SeasonModel.instance:getSeasonId()
		local curGridId = SeasonPathFindingDataModel.instance:grid2Id(self.row, self.col)
		local gridId = SeasonConfig.instance:getFogRelateToGridElementId(seasonId, self.id)
		local isActive = true

		self._disappearFinished = false

		local evtConfig = SeasonConfig.instance:getMapEvtTypeAndId(seasonId, gridId) or {}

		if evtConfig then
			if evtConfig.eventType == SeasonGridEvtTypes.EVT_DANCE_LION then
				local mapMo = SeasonModel.instance:getMapInfoById(gridId)

				if mapMo and mapMo:isLionUnlock(curGridId) then
					isActive = false
					self._disappearFinished = true
					self._disappear = true
				end
			elseif evtConfig.eventType == SeasonGridEvtTypes.EVT_MAP_LOCK and SeasonModel.instance:isOccupied(gridId) and SeasonController.instance:getRecentlyUnlockedFogsGrid() ~= gridId then
				isActive = false
				self._disappearFinished = true
				self._disappear = true
			end
		end

		self._gameObject:SetActive(isActive)
		GoUtil.SetSortingOrder(self._gameObject, self:getSortingOrderOffset(4))
	end
end

function UnitSeasonGridFog:update(deltaTime)
	if not self._disappear or not self._spRenderer or self._disappearFinished then
		return
	end

	self._currTime = (self._currTime or 0) + deltaTime

	local alpha = self._currTime / SceneCompSeasonAnimation.fogDisappearAnimTime

	alpha = math.min(1, math.max(0, 1 - alpha))

	self:_setAlpha(alpha)

	if alpha <= 0 then
		self._disappearFinished = true

		self._gameObject:SetActive(false)
	end
end

function UnitSeasonGridFog:onUnitInVisible(go)
	self:_setAlpha(1)

	self._spRenderer = nil

	UnitSeasonGridFog.super.onUnitInVisible(self, go)
end

function UnitSeasonGridFog:_setAlpha(alpha)
	if not self._spRenderer then
		return
	end

	local color = self._spRenderer.color

	color.a = alpha
	self._spRenderer.color = color
end

return UnitSeasonGridFog
