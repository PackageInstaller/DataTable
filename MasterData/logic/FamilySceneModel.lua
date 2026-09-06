-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyscene/model/FamilySceneModel.lua

module("logic.extensions.familyscene.model.FamilySceneModel", package.seeall)

local FamilySceneModel = class("FamilySceneModel", BaseModel)

function FamilySceneModel:ctor()
	return
end

function FamilySceneModel:onInit()
	self:onReset()
end

function FamilySceneModel:onReset()
	self._cubeType = FamilySceneCubeType.Family
	self._extParams = ""
	self._cubeId = 0
	self._channelId = 0
	self._entities = {}
	self._playerDict = {}
	self._pos = nil
	self._myVariabls = nil
	self._functionInfo = nil
	self._familyCubeInfo = nil
	self._channels = {}
	self._enterId = 0
	self._enterName = ""
	self._enterUserVariabls = nil
	self._enterPos = nil
	self._leaveId = 0
	self._leaveCubeId = 0
	self._leaveChannelId = 0
	self._leaveReason = nil
	self._exitCubeId = 0
end

function FamilySceneModel:onFamilySceneJoinRes(msg)
	return
end

function FamilySceneModel:onFamilySceneNotifyJoinResultRes(msg)
	self._cubeType = msg.type
	self._extParams = msg.extParams
	self._cubeId = checknumber(msg.cubeId)
	self._channelId = checknumber(msg.channelId)

	if not self._entities then
		local old_entities = {}

		self._entities = GameUtil.pbToTable(msg.entities) or {}
		self._pos = GameUtil.pbToTable(msg.pos)
		self._myVariabls = GameUtil.pbToTable(msg.myVariabls)
		self._functionInfo = GameUtil.pbToTable(msg.functionInfo)
		self._familyCubeInfo = msg.functionInfo:HasField("familyCubeInfo") and GameUtil.pbToTable(msg.functionInfo.familyCubeInfo) or nil

		FamilyPartyModel.instance:setFamilyCubeInfo(self._familyCubeInfo)

		for i = #old_entities, 1, -1 do
			self:onPlayerLeaveScene(old_entities[i].id)
		end

		for i = 1, #self._entities do
			local user = self._entities[i]
			local mo = FamilyPlayerMO.New()

			mo:initData(user)
			self:onPlayerEnterScene(mo)
		end

		FamilySceneMainPlayer.instance:updateVariables(msg.myVariabls)
	end
end

function FamilySceneModel:onFamilySceneSwitchChannelRes(msg)
	return
end

function FamilySceneModel:onFamilySceneGetAllChannelInfosRes(msg)
	self._channels = GameUtil.pbToTable(msg.channels) or {}
end

function FamilySceneModel:onFamilySceneNotifyOtherEnterRes(msg)
	self._enterId = checknumber(msg.id)
	self._enterName = msg.name
	self._enterUserVariabls = GameUtil.pbToTable(msg.userVariabls)
	self._enterPos = GameUtil.pbToTable(msg.pos)

	for i, v in ipairs(self._channels) do
		if checknumber(v.channelId) == self._channelId then
			v.curEntityCount = v.curEntityCount + 1

			break
		end
	end

	local mo = FamilyPlayerMO.New()
	local data = {}

	data.id = self._enterId
	data.name = self._enterName
	data.variabls = self._enterUserVariabls
	data.pos = self._enterPos

	mo:initData(data)
	self:onPlayerEnterScene(mo)
end

function FamilySceneModel:onFamilySceneNotifyLeaveRes(msg)
	local selfUserId = RoleModel.instance:getUserId()

	self._leaveId = checknumber(msg.id)
	self._leaveCubeId = checknumber(msg.cubeId)
	self._leaveChannelId = checknumber(msg.channelId)
	self._leaveReason = msg:HasField("reason") and msg.reason or nil

	if selfUserId == self._leaveId then
		self:onReset()
	else
		for i, v in ipairs(self._channels) do
			if checknumber(v.channelId) == self._leaveChannelId then
				v.curEntityCount = v.curEntityCount - 1

				if v.curEntityCount > 0 then
					v.curEntityCount = v.curEntityCount or 0
				end

				break
			end
		end

		self:onPlayerLeaveScene(self._leaveId)
	end
end

function FamilySceneModel:onFamilySceneSetVariablesRes(msg)
	return
end

function FamilySceneModel:onFamilySceneNotifyVariablesUpdateRes(msg)
	self:onUserVariable(msg.userId, msg.variables)
end

function FamilySceneModel:onFamilySceneMoveRes(msg)
	return
end

function FamilySceneModel:onFamilySceneExitRes(msg)
	self:onReset()
end

function FamilySceneModel:onFamilySceneNotifyMoveRes(msg)
	local movements = msg.movements

	for i, v in ipairs(movements) do
		local userId = v.id
		local x = v.pos.x
		local y = v.pos.z
		local underBridge = false
		local isteleport = v.isTeleport

		self:onPlayerMove(userId, x, y, underBridge, isteleport)
	end
end

function FamilySceneModel:onFamilySceneNotifyExitRes(msg)
	return
end

function FamilySceneModel:onPlayerEnterScene(mo)
	self:addPlayerMo(mo)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyScenePlayerEnterScene, mo)
end

function FamilySceneModel:onPlayerLeaveScene(userId)
	self:removePlayerMo(userId)
	GlobalDispatcher:dispatch(GlobalNotify.FamilyScenePlayerLeaveScene, userId)
end

function FamilySceneModel:onUserVariable(userId, variables)
	local mo = self:getPlayerMo(userId)

	if mo then
		mo:updateVariables(variables)
	end

	if checknumber(userId) == LoginModel.instance.userId then
		FamilySceneMainPlayer.instance:updateVariables(variables)

		self._myVariabls = msg.variables
	end
end

function FamilySceneModel:onPlayerMove(userId, x, y, underBridge, isteleport)
	local mo = self:getPlayerMo(userId)

	if mo then
		mo.x = x
		mo.y = y
		mo.underBridge = underBridge
	end

	GlobalDispatcher:dispatch(GlobalNotify.FamilyScenePlayerMove, userId, x, y, underBridge, isteleport)
end

function FamilySceneModel:addPlayerMo(mo)
	self._playerDict[checknumber(mo.id)] = mo
end

function FamilySceneModel:removePlayerMo(id)
	self._playerDict[checknumber(id)] = nil
end

function FamilySceneModel:removeAllPlayers()
	table.clear(self._playerDict)
end

function FamilySceneModel:getPlayerMo(id)
	return self._playerDict[checknumber(id)]
end

function FamilySceneModel:getPlayerMoDict()
	return self._playerDict
end

function FamilySceneModel:getMyPlayerPos()
	return self._pos.x, self._pos.z
end

function FamilySceneModel:isInSceneChannel()
	return self._cubeId > 0 and self._channelId > 0
end

function FamilySceneModel:getCurChannelId()
	return self._channelId
end

function FamilySceneModel:getCurChannelInfo(channelId)
	for i, v in ipairs(self._channels) do
		if checknumber(v.channelId) == checknumber(channelId) then
			return v
		end
	end
end

function FamilySceneModel:getCurChannelName(channelId)
	local info = self:getCurChannelInfo(channelId)

	return (info or nil) and (info.name or "名称不存在")
end

function FamilySceneModel:getCurChannelEntityCount(channelId)
	local info = self:getCurChannelInfo(channelId)

	if info then
		return info.curEntityCount, info.maxEntityCount
	else
		return 0, 0
	end
end

function FamilySceneModel:getCurChannels()
	return self._channels
end

FamilySceneModel.instance = FamilySceneModel.New()

return FamilySceneModel
