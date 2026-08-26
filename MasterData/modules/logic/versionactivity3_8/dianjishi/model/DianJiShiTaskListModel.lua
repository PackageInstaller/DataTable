-- chunkname: @modules/logic/versionactivity3_8/dianjishi/model/DianJiShiTaskListModel.lua

module("modules.logic.versionactivity3_8.dianjishi.model.DianJiShiTaskListModel", package.seeall)

local DianJiShiTaskListModel = class("DianJiShiTaskListModel", Activity220TaskListModel)

DianJiShiTaskListModel.instance = DianJiShiTaskListModel.New()

return DianJiShiTaskListModel
