-- chunkname: @modules/logic/college/model/rpcmo/CollegeTaskMo.lua

module("modules.logic.college.model.rpcmo.CollegeTaskMo", package.seeall)

local CollegeTaskMo = pureTable("CollegeTaskMo")

function CollegeTaskMo:init(data)
	self.id = data.id
	self.progress = data.progress
	self.state = data.state

	self:initCo()
end

function CollegeTaskMo:update(data)
	self.progress = data.progress
	self.state = data.state
end

function CollegeTaskMo:initCo()
	self.co = lua_college_task.configDict[self.id]
	self.reward = self.co and not string.nilorempty(self.co.reward) and GameUtil.splitString2(self.co.reward, true, "&", ":") or {}
end

function CollegeTaskMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeTaskMo" then
		return false
	end

	local isSame = true

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeTaskMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.progress ~= otherMo.progress then
		isSame = false

		logError(string.format("CollegeTaskMo compareWith progress not same: %s >> %s", self.progress, otherMo.progress))
	end

	if self.state ~= otherMo.state then
		isSame = false

		logError(string.format("CollegeTaskMo compareWith state not same: %s >> %s", self.state, otherMo.state))
	end

	return isSame
end

return CollegeTaskMo
