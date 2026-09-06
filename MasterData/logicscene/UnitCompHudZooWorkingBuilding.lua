-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/hud/petzoo/UnitCompHudZooWorkingBuilding.lua

module("logicscene.scene.unit.component.hud.petzoo.UnitCompHudZooWorkingBuilding", package.seeall)

local UnitCompHudZooWorkingBuilding = class("UnitCompHudZooWorkingBuilding", UnitCompHudBase)

function UnitCompHudZooWorkingBuilding:update(deltaTime)
	if not self._hudGameObject then
		return
	end

	self:_updateWorkingBuilding()
end

function UnitCompHudZooWorkingBuilding:_getResPath()
	return "ui/views/zoo/zooworkingbuildinghud.prefab"
end

function UnitCompHudZooWorkingBuilding:_updateHudInfo(hudGo)
	self._btnScoreMax = Framework.ButtonAdapter.GetFrom(hudGo, "scoreMax")

	self._btnScoreMax:AddClickListener(self._onClickMaxScore, self)
	self:_setFullScreenNodeParent()
	self:_updateWorkingBuilding()
end

function UnitCompHudZooWorkingBuilding:_recycleHud()
	UnitCompHudZooPool.super._recycleHud(self)

	if self._btnScoreMax then
		self._btnScoreMax:RemoveClickListener()

		self._btnScoreMax = nil
	end
end

function UnitCompHudZooWorkingBuilding:_updateWorkingBuilding()
	local buildingMo = self._unit:getBuildingMO()

	if buildingMo then
		::label_5_0::

		local var_5_0 = buildingMo.zooMo:isMyZoo()

		if var_5_0 then
			var_5_0 = buildingMo:isScoreMax()

			local isActive = var_5_0

			if self._hudGameObject.activeSelf ~= isActive then
				self._hudGameObject:SetActive(isActive)
			end
		end
	end
end

function UnitCompHudZooWorkingBuilding:_onClickMaxScore()
	local buildingMo = self._unit:getBuildingMO()

	if buildingMo and buildingMo.zooMo:isMyZoo() then
		buildingMo:onBuildingOpType(ZooBuildingOpType.Get)
	end
end

return UnitCompHudZooWorkingBuilding
