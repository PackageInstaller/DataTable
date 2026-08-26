-- chunkname: @modules/logic/season/model/Activity104ProgressListModel.lua

module("modules.logic.season.model.Activity104ProgressListModel", package.seeall)

local Activity104ProgressListModel = class("Activity104ProgressListModel", ListScrollModel)

function Activity104ProgressListModel:setProgressList(infos)
	self:setList(infos)
end

Activity104ProgressListModel.instance = Activity104ProgressListModel.New()

return Activity104ProgressListModel
