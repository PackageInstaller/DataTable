-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemjump/model/SystemJumpModel.lua

module("logic.extensions.systemjump.model.SystemJumpModel", package.seeall)

local SystemOpenState = CommEnum.SystemOpenState
local M = class("SystemJumpModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._jumpModelListData = false
end

function M:onInit()
	self._jumpModelListData = BaseListModel.New()
end

function M:getJumpItemData(data)
	local temp = string.split(data, "#")
	local jumpItemData = {}

	jumpItemData.jumpId = checknumber(temp[1])
	jumpItemData.getTips = checknumber(temp[2])
	jumpItemData.state = SystemOpenState.OpenState

	local jumpInfo = SystemJumpConfig.instance:getJumpInfo(jumpItemData.jumpId)

	if jumpInfo then
		jumpItemData.jumpInfo = jumpInfo
		jumpItemData.state = SystemOpenModel.instance:getSystemMulState(jumpInfo.systemId, jumpInfo.viewName, jumpInfo.param)

		local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(jumpInfo.systemId)

		if systemOpenCO and systemOpenCO:isDefaultOpen() then
			jumpItemData.state = SystemOpenState.OpenState
		end
	end

	return jumpItemData
end

function M:getJumpModelListData()
	return self._jumpModelListData
end

function M:updateJumpModelListData(jumpIds)
	self._jumpModelListData:clear()

	for k, v in ipairs(jumpIds or {}) do
		self._jumpModelListData:addMo(self:getJumpItemData(v))
	end

	if #jumpIds == 0 then
		self._jumpModelListData:addMo({})
	end
end

function M:setCurrSelectJumpIds(jumpIds)
	self._jumpIds = jumpIds
end

function M:getCurrSelectJumpIds()
	return self._jumpIds or {}
end

function M:getJumpData(getWays)
	local lenght = string.len(getWays)

	if lenght < 3 then
		return {}
	end

	local waysTemp = string.sub(getWays, 2, lenght - 1)
	local ways = string.split(waysTemp, ",")
	local dataInfo = {}

	for k, v in ipairs(ways or {}) do
		if v ~= "" then
			table.insert(dataInfo, self:getJumpItemData(v))
		end
	end

	return dataInfo
end

M.instance = M.New()

return M
