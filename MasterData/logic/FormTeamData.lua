-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/model/FormTeamData.lua

module("logic.extensions.formteam.model.FormTeamData", package.seeall)

local FormTeamData = class("FormTeamData")

function FormTeamData:ctor()
	self.id = 0
	self.zdlLimit = 0
	self.teamMateList = {}
	self.groupId = 0
end

function FormTeamData:setData(data)
	self.id = checkint(data.teamId)
	self.zdlLimit = checkint(data.zdl)
	self.teamMateList = data.users
	self.groupId = checkint(data.groupId)
end

function FormTeamData:getTeamLeader()
	return self.teamMateList[1]
end

function FormTeamData:getTeamCfgAndTypeCfg()
	local teamCfg, typeCfg

	teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(self.groupId)

	return teamCfg, teamCfg and FormTeamConfig.instance:getTabCfgByTabId(teamCfg.typeId)
end

function FormTeamData:getCurTeamMateList()
	return self.teamMateList
end

return FormTeamData
