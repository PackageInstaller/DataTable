-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/MaskModel.lua

module("logic.extensions.playerinfo.model.MaskModel", package.seeall)

local M = class("MaskModel", BaseModel)

function M:ctor()
	self._maskList = {}
end

function M:onInit()
	local allMaskCfgs = BackpackConfig.instance:getConfigList(ConfigName.ItemPortrait)

	for _, cfg in ipairs(allMaskCfgs) do
		table.insert(self._maskList, MaskMO.New(cfg))
	end
end

function M:onReset()
	table.clear(self._maskList)
	self:onInit()
end

function M:getShowMask(index)
	return self._maskList[index]
end

M.instance = M.New()

return M
