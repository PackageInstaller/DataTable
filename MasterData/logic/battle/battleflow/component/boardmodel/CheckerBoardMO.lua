-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/boardmodel/CheckerBoardMO.lua

module("logic.battle.battleflow.component.boardmodel.CheckerBoardMO", package.seeall)

local CheckerBoardMO = class("CheckerBoardMO", AbstractGlobalReusable)

function CheckerBoardMO:ctor(checkerBoardCode)
	self._config = false
	self._checkBoardCode = false
	self._initPosition = false
	self._cellArray = Array2D.New()

	self:reuse(checkerBoardCode)

	self._programScenePos = Vector3.New(-15, 0.01, -15)
end

function CheckerBoardMO:reuse(checkerBoardCode)
	self._checkBoardCode = checkerBoardCode
	self._config = BattleConfig.instance:getCheckerBoardCO(checkerBoardCode)

	local cellArray = self._cellArray
	local width, height = self:getWidth(), self:getHeight()

	cellArray:setWidthAndHeight(width, height)

	for x = 0, width - 1 do
		for z = 0, height - 1 do
			local cellCO = self:_findOriginalCO(x, z)
			local cellMO = CheckerBoardCellMO:createInstance(cellCO)

			cellArray:setElement(x, z, cellMO)
		end
	end
end

function CheckerBoardMO:reset()
	self:_clearAllCell()

	self._config = false
	self._initPosition = false
end

function CheckerBoardMO:destroy()
	self:reset()

	self._programScenePos = false
end

function CheckerBoardMO:internal_ClearData()
	for _, cellMO in self:ipairs() do
		cellMO:internal_ClearData()
	end
end

function CheckerBoardMO:getOriginalConfig()
	return self._config
end

function CheckerBoardMO:getCheckerBoardCode()
	return self._checkBoardCode
end

function CheckerBoardMO:getWidth()
	return self._config.width
end

function CheckerBoardMO:getHeight()
	return self._config.height
end

function CheckerBoardMO:ipairs()
	return self._cellArray:ipairs()
end

function CheckerBoardMO:getCellMO(x, z)
	if isInEditorMode and not self:isValideCoordinates(x, z) then
		if BattleLog.enableError then
			BattleLog.error(string.format("CheckerBoardMO::invalide cell coordinates[%s,%s]", x, z))
		end

		return
	end

	return self._cellArray:getElement(x, z)
end

function CheckerBoardMO:getInitPosition()
	if BattleTestUtil.isUseProgramScene() or self._config.isProgramScene then
		return self._programScenePos
	end

	if not self._initPosition then
		local position = self._config.initPosition

		self._initPosition = Vector3.New(position.x, position.y, position.z)
	end

	return self._initPosition
end

function CheckerBoardMO:isValideCoordinates(x, z)
	local width = self:getWidth()
	local height = self:getHeight()

	return x >= 0 and x < width and z >= 0 and z < height
end

function CheckerBoardMO:isActiveCoordinates(x, z)
	if not self:isValideCoordinates(x, z) then
		return false
	end

	local cellMO = self._cellArray:getElement(x, z)

	return cellMO and cellMO:isEnable()
end

function CheckerBoardMO:getNearestActiveXZ(x, z)
	local width = self:getWidth()
	local height = self:getHeight()

	if x < 0 then
		x = 0
	end

	if width <= x then
		x = width - 1
	end

	if z < 0 then
		z = 0
	end

	if height <= z then
		z = height - 1
	end

	return x, z
end

function CheckerBoardMO:_findOriginalCO(x, z)
	local cellConfigs = self._config.cellConfigs

	for _, cellConfig in pairs(cellConfigs) do
		local coordinates = cellConfig.coordinates

		if coordinates[1] == x and coordinates[2] == z then
			return cellConfig
		end
	end

	return false
end

function CheckerBoardMO:_clearAllCell()
	for _, cellMO in self._cellArray:ipairs() do
		cellMO:returnSelf()
	end

	self._cellArray:clear()
end

return CheckerBoardMO
