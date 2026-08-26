-- chunkname: @modules/logic/activity/model/chessmap/Activity109ChessGameTaskListModel.lua

module("modules.logic.activity.model.chessmap.Activity109ChessGameTaskListModel", package.seeall)

local Activity109ChessGameTaskListModel = class("Activity109ChessGameTaskListModel", ListScrollModel)

function Activity109ChessGameTaskListModel:init(actId)
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity109)
	local taskCfgs = Activity106Config.instance:getTaskByActId(actId)
	local data = {}

	if taskDict ~= nil then
		for _, taskCO in ipairs(taskCfgs) do
			local mo = Activity109ChessGameTaskMO.New()
			local taskMO = taskDict[taskCO.id]

			mo:init(taskMO)
			table.insert(data, mo)
		end

		table.sort(data, Activity109ChessGameTaskListModel.sortMO)
	end

	self:setList(data)
end

function Activity109ChessGameTaskListModel.sortMO(objA, objB)
	local alreadyGotA = objA:alreadyGotReward()
	local alreadyGotB = objB:alreadyGotReward()

	if alreadyGotA ~= alreadyGotB then
		return alreadyGotB
	else
		return objA.id < objB.id
	end
end

function Activity109ChessGameTaskListModel:createMO(co, taskMO)
	local mo = {}

	mo.config = taskMO.config
	mo.originTaskMO = taskMO

	return mo
end

Activity109ChessGameTaskListModel.instance = Activity109ChessGameTaskListModel.New()

return Activity109ChessGameTaskListModel
