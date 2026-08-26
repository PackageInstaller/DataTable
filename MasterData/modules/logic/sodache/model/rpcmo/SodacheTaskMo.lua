-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheTaskMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheTaskMo", package.seeall)

local SodacheTaskMo = pureTable("SodacheTaskMo")

function SodacheTaskMo:init(data)
	self.id = data.id
	self.progress = data.progress
	self.state = data.state
	self.config = lua_sodache_task.configDict[self.id]

	if not self.config then
		logError(string.format("搜打撤任务表不存在任务ID：%s 的配置", self.id))
	end
end

function SodacheTaskMo:update(data)
	self.progress = data.progress
	self.state = data.state
end

function SodacheTaskMo:isShowInside()
	if not self.config then
		return false
	end

	if self.state ~= SodacheEnum.TaskState.Finished and self.state ~= SodacheEnum.TaskState.Processing then
		return false
	end

	return self.config.insideShow == 1
end

return SodacheTaskMo
