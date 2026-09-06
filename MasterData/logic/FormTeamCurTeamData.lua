-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formteam/model/FormTeamCurTeamData.lua

module("logic.extensions.formteam.model.FormTeamCurTeamData", package.seeall)

local FormTeamCurTeamData = class("FormTeamCurTeamData")

function FormTeamCurTeamData:ctor()
	self.id = 0
	self.code = ""
	self.zdlLimit = 0
	self.groupId = 0
	self.isOnlyInvite = false
	self.teammateUserIdList = {}
	self.teammateUserDataHash = {}
	self.timeAutoStart = -1
	self.hasInvitedUserIds = {}
end

function FormTeamCurTeamData:setData(data)
	self.id = checkint(data.teamId)
	self.code = data.teamCode

	self:setSettingData(data.settings)

	self.teammateUserIdList = {}
	self.teammateUserDataHash = {}

	self:setTeammateListData(data.teamView)

	self.timeAutoStart = checkint(data.autoBeginMillis)
end

function FormTeamCurTeamData:setSettingData(settingData)
	self.groupId = checkint(settingData.groupId)
	self.zdlLimit = checkint(settingData.zdl)
	self.isOnlyInvite = settingData.onlyInvite
end

function FormTeamCurTeamData:getTeamCfgAndTypeCfg()
	local teamCfg, typeCfg

	teamCfg = FormTeamConfig.instance:getTeamCfgByGroupId(self.groupId)

	return teamCfg, teamCfg and FormTeamConfig.instance:getTabCfgByTabId(teamCfg.typeId)
end

function FormTeamCurTeamData:setTeammateListData(info)
	self.teammateUserIdList = info.playerIds

	for k, v in pairs(self.teammateUserDataHash) do
		local isRemove = true

		for k1, v1 in pairs(self.teammateUserIdList) do
			if tostring(v1) == k then
				isRemove = false
			end
		end

		if isRemove then
			self.teammateUserDataHash[k] = nil
		end
	end

	for k, v in ipairs(info.newAddPlayers) do
		local userInfo = {}

		userInfo.headInfo = v.headInfo

		local skeId = DressConfig.instance:getGirlSkeId()

		skeId = v.gender == GameEnum.Gender.Female and DressConfig.instance:getGirlSkeId() or DressConfig.instance:getBoySkeId()

		local isDress = false

		if v.dresses and #v.dresses > 0 then
			for i, id in ipairs(v.dresses) do
				local cfg = AvatarConfig.instance:getPartCfgById(id)

				if cfg then
					local partType = cfg.partType

					if partType ~= AvatarDataType.UIBG and partType ~= AvatarDataType.UISpine then
						isDress = true
					end
				end
			end
		end

		userInfo.dressMo = isDress == true and AvatarConfig.instance:getAvatarMoByCfgId(skeId) or DressModel.instance:getAvatarPlayerMo(skeId, {}, 0)

		userInfo.dressMo:dressSuit(v.dresses)

		userInfo.isHelp = v.help
		userInfo.isReady = false
		userInfo.curFetter = 0
		userInfo.isBuddy = false
		userInfo.zdl = v.zdl
		self.teammateUserDataHash[tostring(v.headInfo.userId)] = userInfo
	end

	for k, v in ipairs(info.readyPlayerIds) do
		self.teammateUserDataHash[tostring(v)].isReady = true
	end
end

function FormTeamCurTeamData:getTeamLeaderId()
	return tostring(self.teammateUserIdList[1])
end

function FormTeamCurTeamData:checkUserIsTeamLeader()
	return self:getTeamLeaderId() == tostring(RoleModel.instance:getUserId())
end

function FormTeamCurTeamData:checkUserIsPosId(id)
	return tostring(RoleModel.instance:getUserId()) == tostring(self.teammateUserIdList[id])
end

function FormTeamCurTeamData:checkUserIsHelp()
	local data = self.teammateUserDataHash[tostring(RoleModel.instance:getUserId())]

	if data then
		return data.isHelp
	end

	return false
end

function FormTeamCurTeamData:checkUserIsReady()
	local data = self.teammateUserDataHash[tostring(RoleModel.instance:getUserId())]

	if data then
		return data.isReady
	end

	return false
end

function FormTeamCurTeamData:getTeammateInfoById(id)
	local userId = self.teammateUserIdList[id]

	if userId then
		return self.teammateUserDataHash[tostring(userId)]
	end
end

function FormTeamCurTeamData:setTeammateReady(userId)
	local data = self.teammateUserDataHash[tostring(userId)]

	if data then
		data.isReady = true
	end
end

function FormTeamCurTeamData:getTeammateInfoByUserId(userId)
	return self.teammateUserDataHash[tostring(userId)]
end

function FormTeamCurTeamData:getCurTeammateUserIds()
	local dataList = {}

	for _, id in ipairs(self.teammateUserIdList) do
		local userId = tostring(id)

		if userId ~= tostring(RoleModel.instance:getUserId()) then
			table.insert(dataList, userId)
		end
	end

	return dataList
end

function FormTeamCurTeamData:setCurTeammateCurFetterInfo(info)
	local userId = tostring(info.userId)
	local data = self.teammateUserDataHash[userId]

	if data then
		data.isBuddy = checkbool(info.isBuddy)
		data.curFetter = checkint(info.fetter)
	end
end

function FormTeamCurTeamData:getCurFetterInfoList()
	local dataList = {}

	for userId, data in pairs(self.teammateUserDataHash) do
		if data.isBuddy then
			table.insert(dataList, data)
		end
	end

	return dataList
end

return FormTeamCurTeamData
