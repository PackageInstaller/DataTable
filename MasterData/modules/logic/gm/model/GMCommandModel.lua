-- chunkname: @modules/logic/gm/model/GMCommandModel.lua

module("modules.logic.gm.model.GMCommandModel", package.seeall)

local GMCommandModel = class("GMCommandModel", ListScrollModel)

function GMCommandModel:reInit()
	self._hasInit = nil
end

function GMCommandModel:checkInitList()
	if self._hasInit then
		return
	end

	self._hasInit = true

	self:setList(lua_gm_command.configList)
end

GMCommandModel.instance = GMCommandModel.New()

return GMCommandModel
