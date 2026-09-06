-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/model/MississiModel.lua

module("logic.extensions.timelimitedchallenge.model.MississiModel", package.seeall)

local MississiModel = class("MississiModel", BaseModel)

function MississiModel:onInit()
	self:onReset()
end

function MississiModel:onReset()
	self._actId = nil
	self._isGotBuff = false
	self._buffLevel = 0
	self._curPassStageId = 0
	self._curStageInfo = nil
	self._curStageId = -1
	self._curTeamInfo = nil
	self._isPassCurStage = false
	self._isCurStageWin = false
	self._customFmtMo = nil
	self._curChallengeView = nil
	self._msgMap = {}
	self._lastActiveNum = 0
end

function MississiModel:setActId(actId)
	if checknumber(self._actId) ~= actId then
		self:onReset()

		self._actId = actId
	end
end

function MississiModel:getActId()
	return self._actId
end

function MississiModel:onGetInfo(msg)
	self._isGotBuff = checkbool(msg.gotBuff)
	self._buffLevel = checkint(msg.buffLevel)
	self._curPassStageId = checkint(msg.curStageId)

	if msg.stageInfo then
		self._curStageId = checkint(msg.stageInfo.challengeStageId)
		self._curStageInfo = {}

		for i, v in ipairs(msg.stageInfo.team) do
			self._curStageInfo[v.teamId] = v
		end
	end

	local activityId = msg.activityId

	self._msgMap[activityId] = GameUtil.pbToTable(msg)
end

function MississiModel:onGainBuff(msg)
	self._isGotBuff = true
	self._buffLevel = self._buffLevel + 1

	local activityId = msg.activityId
	local tb = self._msgMap[activityId]

	if tb then
		tb.buffLevel = checknumber(tb.buffLevel) + 1
		tb.gotBuff = true
	end
end

function MississiModel:getLastActiveNum()
	return self._lastActiveNum
end

function MississiModel:onChallengeEnd(msg)
	self._isCurStageWin = checkbool(msg.isWin)
	self._isPassCurStage = checkbool(msg.nextStage)
	self._curTeamInfo = msg.team

	if self._curTeamInfo then
		self._curStageInfo[msg.team.teamId] = self._curTeamInfo
	end

	self._lastActiveNum = 0

	local activityId = msg.activityId

	if self._isCurStageWin then
		local teamTb = GameUtil.pbToTable(msg.team)
		local tb = self._msgMap[activityId]

		if tb then
			if self._isPassCurStage then
				tb.curStageId = checknumber(tb.curStageId) + 1
			end

			if not tb.stageInfo then
				local stageInfo = {}

				if not stageInfo.team then
					local team = {}
					local hasTeam = false

					for i, v in ipairs(team) do
						if v.teamId == teamTb.teamId then
							team[i] = teamTb
							hasTeam = true
						end

						self._lastActiveNum = self._lastActiveNum + team[i].activeNum
					end

					if not hasTeam then
						table.insert(team, teamTb)

						self._lastActiveNum = self._lastActiveNum + teamTb.activeNum
					end

					stageInfo.team = team
					tb.stageInfo = stageInfo
					self._msgMap[activityId] = tb
				end
			end
		end
	end

	local ci = msg.changeSetId
	local items = MaterialController.instance:saveChangeSetToTemp(ci)

	self.ciMatStr = ""

	if items ~= nil and #items > 0 then
		local tem = {}

		for i, v in ipairs(items) do
			local type, id, num = v:getMatType(), v:getId(), v:GetCount()
			local matStr = MaterialMgr.createSerName(type, id, num)
			local c = MaterialMgr.getContentMatStr(matStr, 100, -10, MaterialMgr.ICON_TYPE_MATID)

			table.insert(tem, c)
		end

		self.ciMatStr = table.concat(tem, " ")
	end

	if ci then
		self.ciList = ci
	end
end

function MississiModel:showCI()
	MaterialController.instance:showChangeSetInTemp(self.ciList)

	self.ciList = {}
end

function MississiModel:resetBattleInfo()
	if self._isPassCurStage then
		self._curPassStageId = self._curPassStageId + 1
		self._curStageInfo = {}
	end

	self._isCurStageWin = false
	self._isPassCurStage = false
end

function MississiModel:getIsPassCurStage()
	return self._isPassCurStage
end

function MississiModel:getActIdByCfg()
	local actCfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.MississiChallenge)
	local actId = actCfg and actCfg.activityId

	return checkint(actId)
end

function MississiModel:getIsGotBuff(activityId)
	local tb = self._msgMap[activityId]

	if tb then
		return checkbool(tb.gotBuff)
	end

	return false
end

function MississiModel:getShowBuffLevel(activityId)
	local isBuffMax = false
	local buffMaxLevel = #MississiConfig.instance:getBuffCfgs(activityId)
	local buffLevel = 0
	local isGotBuff = false
	local tb = self._msgMap[activityId]

	if tb then
		buffLevel = checkint(tb.buffLevel)
		isGotBuff = checkbool(tb.gotBuff)
	end

	isBuffMax = buffMaxLevel <= buffLevel

	local curShowBuffLevel = buffLevel

	if not isBuffMax and not isGotBuff then
		curShowBuffLevel = curShowBuffLevel + 1
	end

	curShowBuffLevel = math.min(buffMaxLevel, curShowBuffLevel)

	return curShowBuffLevel, isBuffMax
end

function MississiModel:getCurPassStage(activityId)
	local tb = self._msgMap[activityId]

	if tb then
		return checknumber(tb.curStageId)
	end

	return 0
end

function MississiModel:getCurStateTeamsInfoByTeamId(activityId, stageId, teamId)
	local tb = self._msgMap[activityId]

	if tb then
		if not tb.stageInfo then
			if not tb.stageInfo.team then
				local team = {}

				for i, v in ipairs(team) do
					if v.challengeStageId == stageId and v.teamId == teamId then
						return v
					end
				end
			end
		end
	end

	return nil
end

function MississiModel:getCustomFmtMo()
	if self._customFmtMo == nil then
		self._customFmtMo = MississiCustomFmtMo.New()
	end

	return self._customFmtMo
end

function MississiModel:setCurChallengeView(curChallengeView)
	self._curChallengeView = curChallengeView
end

function MississiModel:getCurChallengeView()
	return self._curChallengeView
end

MississiModel.instance = MississiModel.New()

return MississiModel
