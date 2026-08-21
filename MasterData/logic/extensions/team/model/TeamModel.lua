-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/model/TeamModel.lua

module("logic.extensions.team.model.TeamModel", package.seeall)

local M = class("TeamModel", BaseModel)

function M:ctor()
	M.super.ctor(self)

	self._tempTeamData = nil
	self._poolTarget = nil
	self._saveState = false
	self._teamData = BaseListModel.New()
end

function M:onInit()
	return
end

function M:onReset()
	self._tempTeamData = nil

	self._teamData:clear()

	self._poolTarget = nil
end

function M:refreshTeamData(msg)
	local molist = self._teamData:getMoList()

	for _, team in ipairs(msg.teams) do
		local exist = false

		for i = 1, #molist do
			local teamMO = molist[i]

			if teamMO.tid == team.tid then
				teamMO.teamName = team.teamName
				teamMO.lastModifyTime = team.lastModifyTime
				exist = true

				break
			end
		end

		if not exist then
			local roles = {}

			for _, v in ipairs(team.roles) do
				roles[v.gid] = v.uuid
			end

			local tempTeam = {
				tid = team.tid,
				teamName = team.teamName,
				lastModifyTime = team.lastModifyTime,
				roles = roles
			}

			table.insert(molist, tempTeam)
		end
	end

	self:_clearMOListId(molist)
	table.sort(molist, self._sortTeamMOFunc)
	self._teamData:setMoList(molist)
end

function M._sortTeamMOFunc(teamA, teamB)
	return teamA.lastModifyTime > teamB.lastModifyTime
end

function M:getTeamData()
	return self._teamData
end

function M:setSaveState(issave)
	self._saveState = issave
end

function M:getSaveState()
	return self._saveState
end

function M:setPoolTran(_poolTarget)
	self._poolTarget = _poolTarget
end

function M:getPoolTran()
	return self._poolTarget
end

function M:setTempTeamData(data)
	self._tempTeamData = data
end

function M:getTempTamData()
	return self._tempTeamData
end

function M:selectOneHero(heroId)
	if self._tempTeamData then
		for _, v in pairs(self._tempTeamData) do
			v:setSelectState(v:getId() == heroId)
		end
	end
end

function M:checkTeamStateByIndex(index)
	for _, v in ipairs(self._teamData:getMoList()) do
		if v.id == index then
			return v.unlock
		end
	end

	return false
end

function M:getTeamNameByID(id)
	for _, v in ipairs(self._teamData:getMoList()) do
		if v.id == id then
			return v.name
		end
	end

	return ""
end

function M:getHerosInfoByID(tid)
	for _, v in ipairs(self._teamData:getMoList()) do
		if v.id == tid then
			return v.roles
		end
	end

	return false
end

function M:removeTeam(tid)
	for _, mo in ipairs(self._teamData:getMoList()) do
		if mo.tid == tid then
			self._teamData:removeMo(mo)

			local moList = self._teamData:getMoList()

			table.sort(moList, self._sortTeamMOFunc)
			self:_clearMOListId(moList)
			self._teamData:setMoList(moList)

			break
		end
	end
end

function M:_clearMOListId(moList)
	for _, mo in ipairs(moList) do
		mo.id = nil
	end
end

M.instance = M.New()

return M
