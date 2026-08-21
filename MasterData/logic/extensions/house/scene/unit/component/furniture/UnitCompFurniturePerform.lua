-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/scene/unit/component/furniture/UnitCompFurniturePerform.lua

module("logic.extensions.house.scene.unit.component.furniture.UnitCompFurniturePerform", package.seeall)

local M = class("UnitCompFurniturePerform", UnitComponentBase)
local FurnitureOperaType = HouseEnum.FurnitureOperaType
local SIGN_URL = "scene/common-elems/common-myhome/room-prafeb/room_chamber/furniture_trigger_p.prefab"
local kTriggerSignName = "trigger_sign_sphere"
local kMainColorID = UnityEngine.Shader.PropertyToID("_BaseColor")
local kTriggerColorMap = {
	"#FF0000",
	"#00FF00",
	"#0000FF",
	"#FFFFFF",
	"#000000"
}

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._resLoader = nil
end

function M:onInit()
	self._arrayTriggerGO = {}
	self._arrayUsedTrigger = {}
	self._resLoader = SingleResLoader.New()

	self:_resetData()
end

function M:_resetData()
	table.clear(self._arrayTriggerGO)
	table.clear(self._arrayUsedTrigger)

	self._hasPathToTrigger = false
	self._isPathTriggerDirty = true
	self._triggerCoordX = 0
	self._triggerCoordY = 0
end

function M:onReuse()
	return
end

function M:onReset()
	self._resLoader:clear()
	self:_resetData()
end

function M:onDestroy()
	self:onReset()

	self._resLoader = nil
end

function M:initTrigger()
	self:clearTrigger()

	local go = self._unit.resLoader:getGO()

	if go then
		local root = goutil.findChild(go, "trigger")

		if root then
			local count = root.transform.childCount

			for i = 1, count do
				local triggerGO = goutil.findChild(root, string.format("pos_%s", i))

				if triggerGO then
					table.insert(self._arrayTriggerGO, triggerGO)
					table.insert(self._arrayUsedTrigger, false)
				end
			end
		end
	end
end

function M:clearTrigger()
	table.clear(self._arrayTriggerGO)
	table.clear(self._arrayUsedTrigger)
end

function M:setTriggerUsed(idx, used)
	self._arrayUsedTrigger[idx] = used
end

function M:isTriggerFree(idx)
	if self._arrayUsedTrigger[idx] == false then
		return true
	end

	return false
end

function M:getFreeTriggers()
	local triggerIdxs = {}

	for i, triggerGO in ipairs(self._arrayTriggerGO) do
		if not self._arrayUsedTrigger[i] then
			table.insert(triggerIdxs, i)
		end
	end

	return triggerIdxs
end

function M:getTriggerPos(idx)
	local triggerGO = self._arrayTriggerGO[idx]

	if triggerGO then
		return Astral.TransformUtil.GetPos(triggerGO.transform, 0, 0, 0)
	end
end

function M:getTriggerRotation(idx)
	local triggerGO = self._arrayTriggerGO[idx]

	if triggerGO then
		local rota = triggerGO.transform.rotation

		return rota.x, rota.y, rota.z, rota.w
	end
end

function M:setPathTriggerDirty()
	self._isPathTriggerDirty = true
end

function M:hasPathToTrigger()
	if self._isPathTriggerDirty then
		self:_setPathTrigger()

		self._isPathTriggerDirty = false
	end

	return self._hasPathToTrigger
end

function M:_setPathTrigger()
	self._hasPathToTrigger = false
	self._triggerCoordX = 0
	self._triggerCoordY = 0

	local roomUnit = self._unit.model:getBelongRoom()

	if roomUnit then
		local grids = {}
		local operaType = self._unit.model:getOperaType()

		if operaType == FurnitureOperaType.Floor then
			grids = roomUnit.furnitureMap:getAroundGridsByUnit(self._unit, true)
		elseif operaType == FurnitureOperaType.Wall then
			grids = roomUnit.furnitureMap:getWallFurnGridsInFloorByUnit(self._unit, true)
		end

		for _, grid in ipairs(grids) do
			local isPath = roomUnit.furnitureMap:hasPathToCoord(grid.x, grid.y)

			if isPath then
				self._hasPathToTrigger = true
				self._triggerCoordX = grid.x
				self._triggerCoordY = grid.y

				break
			end
		end
	end
end

function M:getPathTriggerPos()
	local roomUnit = self._unit.model:getBelongRoom()

	if roomUnit then
		return roomUnit.furnitureMap:getWorldPosByCoord(FurnitureOperaType.Floor, self._triggerCoordX, self._triggerCoordY, 1, 1)
	end
end

function M:showSignGOs()
	if self._resLoader:getResource() then
		self:_showSignGOs()
	else
		self._resLoader:load(SIGN_URL, self._showSignGOs, self)
	end
end

function M:hideSignGOs()
	self:_setSignGOsVisible(false)
end

function M:_showSignGOs()
	self:_setSignGOsVisible(true)
end

function M:_setSignGOsVisible(visible)
	for i, triggerGO in ipairs(self._arrayTriggerGO) do
		local signGO = goutil.findChild(triggerGO, kTriggerSignName)

		if signGO then
			goutil.setActive(signGO, visible)
		elseif visible then
			signGO = self._resLoader:getResInstance()

			goutil.addChildToParent(signGO, triggerGO)

			signGO.name = kTriggerSignName
		end

		if signGO then
			local matSetter = MaterialSetter.Get(signGO)

			matSetter:SetGameObject(signGO)
			matSetter:SetColor(kMainColorID, kTriggerColorMap[i])
		end
	end
end

return M
