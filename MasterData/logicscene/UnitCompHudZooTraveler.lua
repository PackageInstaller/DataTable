-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooTraveler.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooTraveler", package.seeall)

local UnitCompHudZooTraveler = class("UnitCompHudZooTraveler", UnitCompHudBase)

UnitCompHudZooTraveler.travelingStateResPath = "scene/tiling/elements/elem_exped_chuansongmen_p.prefab"

function UnitCompHudZooTraveler:update(deltaTime)
	self:_updateState()
	self:_updateTravelMan()
end

function UnitCompHudZooTraveler:_getResPath()
	return "ui/views/zoo/zootravelingview.prefab"
end

function UnitCompHudZooTraveler:_updateHudInfo(hudGo)
	self._birdTraveling = goutil.findChild(hudGo, "traveling")
	self._birdTravelingTime = goutil.findChildTextComponent(hudGo, "traveling/time")
	self._birdDrawable = goutil.findChild(hudGo, "drawable")

	self:setHudOffset(0, 1.5, 0)
	self:update(0)
end

function UnitCompHudZooTraveler:onUnitVisible(go)
	UnitCompHudZooTraveler.super.onUnitVisible(self, go)

	self._travelingStateObj = self._unit.scene.resCache:newObject(UnitCompHudZooTraveler.travelingStateResPath)

	local sx, sy, sz = Framework.TransformUtil.GetLocalScale(go.transform, 1, 1, 1)

	self._travelingStateObj:setParent(go.transform)
	self._travelingStateObj:setLocalPos(0, 0, 0)
	self._travelingStateObj:setScale(1 / sx)
	self._travelingStateObj:setLayer(self._unit:getLayer())
	self:_updateState()
end

function UnitCompHudZooTraveler:onUnitInVisible(go)
	if self._travelingStateObj then
		self._unit.scene.resCache:recycleObject(self._travelingStateObj)

		self._travelingStateObj = nil
	end

	UnitCompHudZooTraveler.super.onUnitInVisible(self, go)
end

function UnitCompHudZooTraveler:_updateState()
	local unitGameObj = self._unit:getGameObject()
	local buildingMO = self._unit:getBuildingMO()

	if buildingMO and not goutil.isNil(unitGameObj) then
		local time = buildingMO:getTravelEndTime()

		unitGameObj.layer = time and time <= 0 and buildingMO and buildingMO:isTravelerUnlocked() and self._unit:getLayer() or SceneLayer.Invisible_Value
	end

	if self._travelingStateObj then
		local time

		if buildingMO then
			time = buildingMO:getTravelEndTime()
		end

		self._travelingStateObj:setActive(time and time > 0)
	end
end

function UnitCompHudZooTraveler:_updateTravelMan()
	if not self._hudGameObject then
		return
	end

	local buildingMO = self._unit:getBuildingMO()

	if not buildingMO or not buildingMO:isTravelerUnlocked() then
		self._hudGameObject:SetActive(false)

		return
	end

	self._hudGameObject:SetActive(true)

	local time = buildingMO:getTravelEndTime()

	if not time then
		self._birdTraveling:SetActive(false)
		self._birdDrawable:SetActive(false)
	elseif time == 0 then
		self._birdTraveling:SetActive(false)
		self._birdDrawable:SetActive(true)
	else
		self._birdTraveling:SetActive(true)
		self._birdDrawable:SetActive(false)

		self._birdTravelingTime.text = string.format(lang("petzoo_traveler_timer"), GameUtil.FormatTimeSymbol(time))
	end
end

return UnitCompHudZooTraveler
