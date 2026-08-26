-- chunkname: @modules/logic/turnback/model/TurnbackBeginnerCategoryListModel.lua

module("modules.logic.turnback.model.TurnbackBeginnerCategoryListModel", package.seeall)

local TurnbackBeginnerCategoryListModel = class("TurnbackBeginnerCategoryListModel", ListScrollModel)

function TurnbackBeginnerCategoryListModel:setCategoryList(Infos)
	self._moList = Infos and Infos or {}

	table.sort(self._moList, function(a, b)
		return a.order < b.order
	end)
	self:setList(self._moList)
end

function TurnbackBeginnerCategoryListModel:setOpenViewTime()
	self.openViewTime = Time.realtimeSinceStartup
end

TurnbackBeginnerCategoryListModel.instance = TurnbackBeginnerCategoryListModel.New()

return TurnbackBeginnerCategoryListModel
