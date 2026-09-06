-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/model/XingJiangModel.lua

module("logic.extensions.xingjiang.model.XingJiangModel", package.seeall)

local XingJiangModel = class("XingJiangModel", BaseModel)

function XingJiangModel:ctor()
	return
end

function XingJiangModel:onInit()
	self.curActId = 126001
	self.curActId2 = 128001
	self.curActId3 = 123002
	self.actIdList = {
		self.curActId,
		self.curActId2,
		self.curActId3
	}
	self.curPetId = 16006

	self:onReset()
end

function XingJiangModel:onReset()
	self.curStageId = 1
	self.curStageId2 = 1
	self.curStageInfo = nil
	self.curDailySignId = 0
	self.isSignToday = false
	self.taskInfo = {}
	self.formationMo = FormationMO.New()

	self:onResetInfo()

	self._msgPool = {}
	self._msgExPool = {}
end

function XingJiangModel:getInfos(msg)
	self.curStageId = checknumber(msg.curStageId) + 1
	self.curStageInfo = {}
	self.curDailySignId = checknumber(msg.curDailySignId)
	self.isSignToday = msg.todayHasSign
	self.taskInfo = msg.taskInfo

	local teamids = msg.stageInfo.team

	for i = 1, #teamids do
		self.curStageInfo[i] = teamids[i]
	end

	self._msgPool[msg.activityId] = GameUtil.pbToTable(msg)

	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES, self.curStageId)
end

function XingJiangModel:getStageById(activityId)
	local info = self._msgPool[activityId]

	if info then
		return checknumber(info.curStageId) + 1
	end

	return 1
end

function XingJiangModel:checkIsPassById(activityId)
	local stageCfgs = XingJiangConfig.instance:getStageCfgs(activityId) or {}
	local totalCount = #stageCfgs

	return totalCount < self:getStageById(activityId)
end

function XingJiangModel:isChallengeTeamByActId(activityId, teamId)
	local info = self._msgPool[activityId]

	if info then
		if not info.stageInfo then
			if not info.stageInfo.team then
				local team = {}

				for k, v in pairs(team) do
					if teamId == v.teamId then
						return v.isChallenged
					end
				end
			end
		end
	end

	return false
end

function XingJiangModel:getTeamActiveNumByActId(activityId, teamId)
	local info = self._msgPool[activityId]

	if info then
		if not info.stageInfo then
			if not info.stageInfo.team then
				local team = {}

				for k, v in pairs(team) do
					if teamId == v.teamId then
						return v.activeNum
					end
				end
			end
		end
	end

	return false
end

function XingJiangModel:isChallengeTeam(teamId)
	if not self.curStageInfo[teamId] then
		return false
	end

	return self.curStageInfo[teamId].isChallenged
end

function XingJiangModel:getTeamActiveNum(teamId)
	if not self.curStageInfo[teamId] then
		return 0
	end

	return self.curStageInfo[teamId].activeNum
end

function XingJiangModel:updateStageInfo(nextstage, team)
	if nextstage then
		self.curStageId = self.curStageId + 1
		self.curStageInfo = {}
	elseif team then
		self.curStageInfo[team.teamId] = team
	end

	GlobalDispatcher:dispatch(GlobalNotify.PM_IF_GETINFORES)
end

function XingJiangModel:setCurSignInfo()
	self.curDailySignId = self.curDailySignId + 1
	self.isSignToday = true

	GlobalDispatcher:dispatch(GlobalNotify.PM_ZXL_GETSIGN)
end

function XingJiangModel:GetCurFormation()
	return self.formationMo
end

function XingJiangModel:getTaskInfoList()
	return self.taskInfo
end

function XingJiangModel:getTaskInfo(taskId)
	for _, info in ipairs(self.taskInfo) do
		if taskId == checknumber(info.taskId) then
			return info
		end
	end

	return nil
end

function XingJiangModel:onResetInfo()
	self._allPetList = nil
	self._curPetMap = {}
end

function XingJiangModel:getAllPetList(force)
	if self._allPetList == nil or force then
		self:_initPetList()
	end

	return self._allPetList
end

function XingJiangModel:_initPetList()
	local pets = BagPetsController.instance:getFightBagPet()
	local list = {}

	for k, v in pairs(pets) do
		if v then
			local mo = v:GetClone()

			mo.attrMo:resetPublicAttr()
			mo.attrMo:calcTotalAttrs()
			mo:refreshAllAttr()

			self._curPetMap[v.petId] = mo

			table.insert(list, mo)
		end
	end

	self._allPetList = list
end

function XingJiangModel:getPetMo(petId)
	if self._allPetList == nil then
		self:getAllPetList()
	end

	if self._curPetMap then
		return self._curPetMap[petId]
	end

	return nil
end

function XingJiangModel:getInfos2(msg)
	self.curStageId2 = checknumber(msg.stageId) + 1
	self._msgExPool[msg.activityId] = checknumber(msg.stageId)

	GlobalDispatcher:dispatch(GlobalNotify.PM_SKL_GETINFORES)
end

function XingJiangModel:getExStageById(activityId)
	return checknumber(self._msgExPool[activityId]) + 1
end

function XingJiangModel:checkIsPassExById(activityId)
	local stageCfgs = XingJiangConfig.instance:getStage2Cfgs(activityId) or {}
	local totalCount = #stageCfgs

	return totalCount < self:getStageById(activityId)
end

XingJiangModel.instance = XingJiangModel.New()

return XingJiangModel
