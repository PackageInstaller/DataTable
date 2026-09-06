-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/config/UnlockConfig.lua

module("logic.extensions.unlock.config.UnlockConfig", package.seeall)

local UnlockConfig = class("UnlockConfig", BaseConfig)

function UnlockConfig:onInit()
	self._sceneUnLock = nil
	self._sceneUnLockMofangDic = nil
	self._functionState = nil
	self._kingroadmsnMaxCfg = nil
	self._kingroadmsnMinCfg = nil
	self._npcFuncDict = nil
end

function UnlockConfig:getNames()
	return {
		"scene_unlock",
		"function_state",
		"npc_chat",
		"npc_icons"
	}
end

function UnlockConfig:handleConfig(name, content)
	if name == "scene_unlock" then
		self:_handleSceneUnlock(content)
	elseif name == "function_state" then
		self:_handleFunctionState(content)
	elseif name == "npc_chat" then
		self._npcChats = content
	elseif name == "npc_icons" then
		self._npcIcons = content
		self._npcIconfig = {}
		self._npcIconfigWithId = {}

		for i = 1, #content.dataList do
			if content.dataList[i].func then
				for j = 1, #content.dataList[i].func do
					self._npcIconfig[content.dataList[i].func[j]] = content.dataList[i]
				end
			end

			if content.dataList[i].funcIds then
				for j = 1, #content.dataList[i].funcIds do
					self._npcIconfigWithId[content.dataList[i].funcIds[j]] = content.dataList[i]
				end
			end
		end
	end
end

function UnlockConfig:_handleSceneUnlock(content)
	self._sceneUnLock = {}
	self._sceneUnLockMofangDic = {}

	for k, v in pairs(content) do
		if type(k) == "number" then
			self._sceneUnLock[v.sceneId] = v
		end

		if v.triggerType == "MofangLevel" then
			local lv = checknumber(v.triggerParams)

			self._sceneUnLockMofangDic[lv] = self._sceneUnLockMofangDic[lv] or {}

			table.insert(self._sceneUnLockMofangDic[lv], v.sceneId)
		end
	end
end

function UnlockConfig:_handleFunctionState(content)
	self._functionState = content
	self._npcFuncDict = {}
	self._challengeNpcIds = {}

	for k, v in pairs(self._functionState) do
		if v.npcId and v.npcId > 0 then
			local funcs = self._npcFuncDict[v.npcId]

			if not funcs then
				funcs = {}
				self._npcFuncDict[v.npcId] = funcs
			end

			table.insert(funcs, v)

			if v.funcType == NpcFuncType.Challenge then
				local cId = tonumber(v.funcParams[1])
				local npcs = self._challengeNpcIds[cId]

				if not npcs then
					npcs = {}
					self._challengeNpcIds[cId] = npcs
				end

				table.insert(npcs, v.npcId)
			end
		end
	end
end

function UnlockConfig:getSceneIdListByMofangLv(lv)
	printInfo("getSceneIdListByMofangLv")

	if self._sceneUnLockMofangDic then
		return self._sceneUnLockMofangDic[lv]
	end
end

function UnlockConfig:getNpcFuncTypes(npcId)
	local funcCos = self._npcFuncDict[npcId]

	if funcCos then
		return funcCos
	end
end

function UnlockConfig:getNpcIconsCoByFuncType(funcType)
	return self._npcIconfig[funcType]
end

function UnlockConfig:getNpcIconsCoByFuncId(funcId)
	return self._npcIconfigWithId[funcId]
end

function UnlockConfig:getFuncIconCo(funcId)
	return self._npcIcons[funcId]
end

function UnlockConfig:getNpcChatCo(npcId)
	return self._npcChats[npcId]
end

function UnlockConfig:getChallengeNpcs(challengeId)
	if self._challengeNpcIds then
		return self._challengeNpcIds[challengeId]
	end
end

function UnlockConfig:getNpcChallenge(npcId)
	if self._functionState then
		for k, v in pairs(self._functionState) do
			if v.funcType == NpcFuncType.Challenge and tonumber(v.npcId) == npcId then
				return checknumber(v.funcParams[1])
			end
		end
	end
end

function UnlockConfig:getNpcChallengeIds(npcId)
	local funcCos = self:getNpcFuncTypes(npcId)

	if funcCos then
		local cIds

		for i = 1, #funcCos do
			local funcCo = funcCos[i]
			local funcType, funcParams = funcCo.funcType, funcCo.funcParams

			if funcType == NpcFuncType.Challenge then
				cIds = cIds or {}

				table.insert(cIds, funcParams[1])
			end
		end

		return cIds
	end
end

function UnlockConfig:getAllKingRoadIds()
	local kindRoadIds = {}

	for k, v in pairs(self._sceneUnLock) do
		if v.triggerType == "PassChallenge" then
			local challengesInfo = string.split(v.triggerParams, ",")
			local cId = tonumber(challengesInfo[1])

			kindRoadIds[cId] = kindRoadIds[cId] or true
		end
	end

	for k, v in pairs(self._npcFuncDict) do
		local funcs = v

		for i = 1, #funcs do
			if funcs[i].triggerType then
				for j = 1, #funcs[i].triggerType do
					if funcs[i].triggerType[j] == "PassChallenge" then
						local challengesInfo = string.split(funcs[i].triggerParams[j], ",")
						local cId = tonumber(challengesInfo[1])

						kindRoadIds[cId] = kindRoadIds[cId] or true
					end
				end
			end

			if funcs[i].funcType == NpcFuncType.Challenge then
				local cId = tonumber(funcs[i].funcParams[1])

				kindRoadIds[cId] = kindRoadIds[cId] or true
			end
		end
	end

	local ids = {}

	for k, v in pairs(kindRoadIds) do
		table.insert(ids, k)
	end

	return ids
end

function UnlockConfig:getKingRoadFinishParseAndBranch(id)
	if not self._kingroadmsnMaxCfg then
		self:_initKingRoadFinishParseAndBranch()
	end

	if not self._kingroadmsnMaxCfg[id] then
		return
	end

	local maxId = self:_getMaxParseId(id, self._kingroadmsnMaxCfg)
	local finishInfos = self._kingroadmsnMaxCfg[id][maxId]

	if finishInfos then
		return finishInfos.phaseId, finishInfos.branchId
	end
end

function UnlockConfig:hasChllenge(id)
	if not self._kingroadmsnMaxCfg then
		self:_initKingRoadFinishParseAndBranch()
	end

	return self._kingroadmsnMaxCfg[id]
end

function UnlockConfig:_getMaxParseId(id, cfgs)
	local finishInfos = cfgs[id]
	local maxId = 0

	if finishInfos then
		for k, v in pairs(finishInfos) do
			if maxId < k then
				maxId = k
			end
		end
	end

	return maxId
end

function UnlockConfig:_initKingRoadFinishParseAndBranch()
	if not self._kingroadmsnMaxCfg or not self._kingroadmsnMinCfg then
		local cfgs = ChallengeConfig.instance:getAllKingRoadSubMissionCfgs()

		cfgs = cfgs.dataList
		self._kingroadmsnMaxCfg = {}
		self._kingroadmsnMinCfg = {}

		local cnt = #cfgs

		for i = 1, cnt do
			local v = cfgs[i]
			local k = v.id

			self._kingroadmsnMaxCfg[k] = self._kingroadmsnMaxCfg[k] or {}
			self._kingroadmsnMinCfg[k] = self._kingroadmsnMinCfg[k] or {}

			local maxCfg = self._kingroadmsnMaxCfg[k][v.phaseId]
			local minCfg = self._kingroadmsnMinCfg[k][v.phaseId]

			if not maxCfg then
				self._kingroadmsnMaxCfg[k][v.phaseId] = v
			elseif v.branchId > maxCfg.branchId then
				self._kingroadmsnMaxCfg[k][v.phaseId] = v
			end

			if not minCfg then
				self._kingroadmsnMinCfg[k][v.phaseId] = v
			elseif v.branchId < minCfg.branchId then
				self._kingroadmsnMinCfg[k][v.phaseId] = v
			end
		end
	end
end

function UnlockConfig:getFuncNpc(funcType)
	if self._functionState then
		for k, v in pairs(self._functionState) do
			if v.func == funcType then
				return v.npcId
			end
		end
	end
end

function UnlockConfig:getNpcByFuncParams(funcType, funcParams)
	if self._functionState then
		for k, v in pairs(self._functionState) do
			if v.funcType == funcType and v.funcParams and v.funcParams[1] == funcParams then
				return v.npcId
			end
		end
	end
end

function UnlockConfig:getUnLockSceneCo(sceneId)
	return self._sceneUnLock[sceneId]
end

function UnlockConfig:getFunctionStateCo(functionIdx)
	return self._functionState[functionIdx]
end

function UnlockConfig:getUnLockSceneId(index)
	for k, v in pairs(self._sceneUnLock) do
		if v.index == index then
			return k
		end
	end
end

function UnlockConfig:getUnLockSceneCos()
	return self._sceneUnLock
end

function UnlockConfig:getAllUnLockSceneIds()
	local sceneIds = {}
	local sceneCfg = SceneConfig.instance:getSceneCfg()

	for k, v in pairs(sceneCfg) do
		if type(k) == "number" and not self:getUnLockSceneCo(v.id) then
			table.insert(sceneIds, v.id)
		end
	end

	return sceneIds
end

UnlockConfig.instance = UnlockConfig.New()

return UnlockConfig
