-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/petzoo/UnitCompZooEggMachineState.lua

module("logicscene.scene.unit.component.petzoo.UnitCompZooEggMachineState", package.seeall)

local UnitCompZooEggMachineState = class("UnitCompZooEggMachineState", UnitComponentBase)

function UnitCompZooEggMachineState:onInit()
	self._eggs = nil
	self._pets = nil
end

function UnitCompZooEggMachineState:onDestroy()
	self._eggs = nil
	self._pets = nil
end

function UnitCompZooEggMachineState:onUnitVisible(go)
	self._eggs = {}
	self._pets = {}

	for i = 1, 3 do
		self._eggs[i] = goutil.findChild(go, "egg" .. i)
		self._pets[i] = goutil.findChild(go, "pet" .. i)
	end
end

function UnitCompZooEggMachineState:onUnitInVisible(go)
	self._eggs = nil
	self._pets = nil
end

function UnitCompZooEggMachineState:update(deltaTime)
	if self._eggs and self._pets then
		local hatchInfo
		local buildingMo = self._unit:getBuildingMO()

		if buildingMo then
			hatchInfo = buildingMo:getHatchInfos()
		end

		if not hatchInfo then
			for i = 1, 3 do
				if self._eggs[i].activeSelf then
					self._eggs[i]:SetActive(false)
				end

				if self._pets[i].activeSelf then
					self._pets[i]:SetActive(false)
				end
			end
		else
			for i = 1, 3 do
				if hatchInfo[i].animalRace > 0 then
					if not self._eggs[i].activeSelf then
						self._eggs[i]:SetActive(true)
					end
				elseif self._eggs[i].activeSelf then
					self._eggs[i]:SetActive(false)
				end

				if checknumber(hatchInfo[i].absorbBuddyId) > 0 then
					if not self._pets[i].activeSelf then
						self._pets[i]:SetActive(true)
					end
				elseif self._pets[i].activeSelf then
					self._pets[i]:SetActive(false)
				end
			end
		end
	end
end

return UnitCompZooEggMachineState
