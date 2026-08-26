-- chunkname: @modules/logic/weekwalk/model/WeekWalkTarotListModel.lua

module("modules.logic.weekwalk.model.WeekWalkTarotListModel", package.seeall)

local WeekWalkTarotListModel = class("WeekWalkTarotListModel", ListScrollModel)

function WeekWalkTarotListModel:setTarotList(list)
	self:clear()
	self:setList(list)
end

WeekWalkTarotListModel.instance = WeekWalkTarotListModel.New()

return WeekWalkTarotListModel
