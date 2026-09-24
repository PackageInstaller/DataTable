-- chunkname: @modules/logic/college/model/rpcmo/CollegeStatusMo.lua

module("modules.logic.college.model.rpcmo.CollegeStatusMo", package.seeall)

local CollegeStatusMo = pureTable("CollegeStatusMo")

function CollegeStatusMo:init(data)
	self.uid = data.uid
	self.id = data.id
	self.endRound = data.endRound
	self.co = lua_college_skill.configDict[self.id]
end

function CollegeStatusMo:getRoundStr()
	if self.endRound == -1 then
		return luaLang("lengZhou6_skill_round_end")
	else
		local round = self.endRound - CollegeModel.instance:getSceneMo().prop.round

		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("lengZhou6_skill_round"), round)
	end
end

function CollegeStatusMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeStatusMo" then
		return false
	end

	local isSame = true

	if self.uid ~= otherMo.uid then
		isSame = false

		logError(string.format("CollegeStatusMo compareWith uid not same: %s >> %s", self.uid, otherMo.uid))
	end

	if self.id ~= otherMo.id then
		isSame = false

		logError(string.format("CollegeStatusMo compareWith id not same: %s >> %s", self.id, otherMo.id))
	end

	if self.endRound ~= otherMo.endRound then
		isSame = false

		logError(string.format("CollegeStatusMo compareWith endRound not same: %s >> %s", self.endRound, otherMo.endRound))
	end

	return isSame
end

return CollegeStatusMo
