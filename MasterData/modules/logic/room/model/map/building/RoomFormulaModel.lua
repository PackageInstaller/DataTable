-- chunkname: @modules/logic/room/model/map/building/RoomFormulaModel.lua

module("modules.logic.room.model.map.building.RoomFormulaModel", package.seeall)

local RoomFormulaModel = class("RoomFormulaModel", BaseModel)

RoomFormulaModel.DEFAULT_TREE_LEVEL = 1
RoomFormulaModel.MAX_FORMULA_TREE_LEVEL = 4

function RoomFormulaModel:onInit()
	self:_clearData()
end

function RoomFormulaModel:reInit()
	self:_clearData()
end

function RoomFormulaModel:clear()
	RoomFormulaModel.super.clear(self)
	self:_clearData()
end

function RoomFormulaModel:_clearData()
	return
end

function RoomFormulaModel:initFormula()
	self:clear()

	local formulaInfoList = {}

	for _, config in ipairs(lua_formula.configList) do
		local strUID = RoomProductionHelper.getFormulaStrUID(config.id, RoomFormulaModel.DEFAULT_TREE_LEVEL)

		table.insert(formulaInfoList, {
			id = strUID
		})
	end

	self:addFormulaList(formulaInfoList)
end

function RoomFormulaModel:addFormulaList(infoList)
	if not infoList or #infoList <= 0 then
		return
	end

	for _, info in ipairs(infoList) do
		self:addFormula(info)
	end
end

function RoomFormulaModel:addFormula(info)
	if not info then
		return
	end

	local formulaMO = RoomFormulaMO.New()

	formulaMO:init(info)

	local config = formulaMO:getConfig()

	if not config then
		return
	end

	self:addAtLast(formulaMO)

	return formulaMO
end

function RoomFormulaModel:getAllTopTreeLevelFormulaMoList()
	local result = {}
	local list = self:getList()

	for _, mo in ipairs(list) do
		local treeLevel = mo:getFormulaTreeLevel()

		if treeLevel == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			table.insert(result, mo)
		end
	end

	return result
end

function RoomFormulaModel:getAllTopTreeLevelCount()
	local allTopTreeLevelFormulaMOList = self:getAllTopTreeLevelFormulaMoList()

	return #allTopTreeLevelFormulaMOList
end

function RoomFormulaModel:getTopTreeLevelFormulaMoList(formulaShowType)
	local formulaMOList = {}
	local allTopTreeLevelFormulaMOList = self:getAllTopTreeLevelFormulaMoList()

	for _, formulaMO in ipairs(allTopTreeLevelFormulaMOList) do
		if formulaMO.config.showType == formulaShowType then
			table.insert(formulaMOList, formulaMO)
		end
	end

	return formulaMOList
end

function RoomFormulaModel:getTopTreeLevelFormulaCount(formulaShowType)
	local topTreeLevelFormulaMOList = self:getTopTreeLevelFormulaMoList(formulaShowType)

	return #topTreeLevelFormulaMOList
end

function RoomFormulaModel:getFormulaMo(formulaStrId, notError)
	local formulaMo = self:getById(formulaStrId)

	if not formulaMo and not notError then
		logError("RoomFormulaModel:getFormulaMo error, can't find RoomFormulaMo:" .. (formulaStrId or "nil"))
	end

	return formulaMo
end

function RoomFormulaModel:getFormulaMoWithInfo(formulaStrId, info)
	if string.nilorempty(formulaStrId) then
		return
	end

	local formulaMo = self:getById(formulaStrId)

	if formulaMo then
		formulaMo:init(info)
		formulaMo:resetFormulaCombineCount()
	else
		formulaMo = self:addFormula(info)
	end

	return formulaMo
end

function RoomFormulaModel:getFormulaIsLast(formulaStrId)
	local formulaMo = self:getFormulaMo(formulaStrId)

	return (formulaMo or nil) and formulaMo:getIsLast()
end

function RoomFormulaModel:getFormulaParentStrId(formulaStrId)
	local parentStrId
	local formulaMO = RoomFormulaModel.instance:getFormulaMo(formulaStrId)

	return (formulaMO or nil) and formulaMO:getParentStrId()
end

RoomFormulaModel.instance = RoomFormulaModel.New()

return RoomFormulaModel
