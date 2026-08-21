-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/model/def/AirWorkMapModel.lua

module("logic.extensions.airworkshop.model.def.AirWorkMapModel", package.seeall)

local M = class("AirWorkMapModel", BaseModel)
local kMaxCacheOtherImage = 30

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._cover2ImgList = {}

	self:initLevelLimitCO()
	self:onReset()

	self._templateMapList = {}
	self._templateId2CoverDic = {}
	self._testBattleFromManagerView = false
	self._selfImageDic = {}
	self._imageIdCache = {}
end

function M:getNextMaxIndex()
	local idx = 0

	for i, v in ipairs(self._levelMOList) do
		idx = math.max(v:getIndex(), idx)
	end

	return idx + 1
end

function M:initLevelLimitCO()
	self._planNum2CO = {}

	local coList = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioPlanLimit)

	for k, v in pairs(coList) do
		self._planNum2CO[v.planLimit] = v
	end
end

function M:onReset()
	self._levelMOList = {}

	for key, v in pairs(self._cover2ImgList) do
		self:_clearLevelImage(key)
	end

	table.clear(self._cover2ImgList)
	table.clear(self._selfImageDic)
	table.clear(self._imageIdCache)
	AirWorkShopDefAgent.instance:_onReset()

	self._testResult = false
	self._testBattleFromManagerView = false
end

function M:initAirMapList(mapList)
	for i, v in ipairs(mapList) do
		local levelMO = AirWorkLevelMO.New()

		levelMO:initByAgent(v)

		self._levelMOList[levelMO:getId()] = levelMO
	end
end

function M:createAirMap(id, index, mapMO, cover)
	local levelMO = AirWorkLevelMO.New()
	local statMO = AirWorkStatMO.New()

	levelMO:setId(id)
	levelMO:setIndex(index)
	levelMO:setMapMO(mapMO:deepCopy())
	levelMO:setStatMO(statMO)
	levelMO:setPassTest(false)
	levelMO:setCover(cover)

	self._levelMOList[levelMO:getId()] = levelMO

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		local model = AirWorkShopDefMgr.instance:getModel()

		model:setLevelId(id)
	end

	self:_updateRefreshHero(levelMO, mapMO)
end

function M:modifyAirMap(oldId, newId, mapMO, cover)
	local levelMO = self:getLevelMOById(oldId)

	self:_updateRefreshHero(levelMO, mapMO)
	levelMO:setId(newId)
	levelMO:setMapMO(mapMO:deepCopy())
	levelMO:setPassTest(false)
	levelMO:setCover(cover)

	self._levelMOList[oldId] = nil
	self._levelMOList[newId] = levelMO

	if AirWorkShopDefMgr.instance:isInDefFlow() then
		local model = AirWorkShopDefMgr.instance:getModel()

		model:setLevelId(newId)
	end
end

function M:_updateRefreshHero(levelMO, mapMO)
	mapMO:transHeroDatCreateType2Agent()
end

function M:_clearLevelImage(cover)
	if not cover then
		return
	end

	local sp = self._cover2ImgList[cover]

	table.removebyvalue(self._imageIdCache, cover)

	if sp then
		goutil.destroy(sp.texture)
		goutil.destroy(sp)
	end

	self._cover2ImgList[cover] = nil
end

function M:deleteAirMap(id)
	if self._cover2ImgList[id] then
		QiNiuUtil.DeleteFile(string.format("airworkshop/%s", id))
	end

	self:_clearLevelImage(id)

	self._levelMOList[id] = nil
end

function M:hasLevel()
	for k, v in pairs(self._levelMOList) do
		return true
	end

	return false
end

function M:testResult(result)
	self._testResult = result or false

	local levelMo = self:getLevelMOById(result.id)

	levelMo:setPassTest(result.win)
end

function M:getTestResult()
	return self._testResult
end

function M:resetTestResult()
	self._testResult = false
end

function M:updateOnlineStatus(id, isOnline)
	local levelMo = self:getLevelMOById(id)

	levelMo:setOnlineStatus(isOnline)
end

function M:getLevelMOById(levelId)
	if levelId then
		return self._levelMOList[levelId]
	end
end

function M:getAllLevelMO()
	return self._levelMOList
end

function M:getCurUnlockPlanCount()
	local maxUnlock = 0

	for _, v in pairs(self._planNum2CO) do
		local isUnlock = AirWorkShopModel.instance:getIsUnlockByTypeAndId(GameEnum.UnlockTypeEnum.PlanLimit, v.id)

		if isUnlock then
			maxUnlock = maxUnlock > v.planLimit and maxUnlock or v.planLimit
		end
	end

	return maxUnlock
end

function M:getPlanUnlockCOByCount(planCount)
	return self._planNum2CO[planCount]
end

function M:getPlanCount()
	local maxCount = 0

	for _, v in pairs(self._planNum2CO) do
		maxCount = maxCount > v.planLimit and maxCount or v.planLimit
	end

	return maxCount
end

function M:getPlanUnlockCoByCount(itemIndex)
	local minUnlock = 50

	for _, v in pairs(self._planNum2CO) do
		local isUnlock = AirWorkShopModel.instance:getIsUnlockByTypeAndId(GameEnum.UnlockTypeEnum.PlanLimit, v.id)

		if not isUnlock and itemIndex <= v.planLimit then
			minUnlock = minUnlock < v.planLimit and minUnlock or v.planLimit
		end
	end

	local co = self._planNum2CO[minUnlock]

	return co
end

function M:getFirstLevel()
	for i, v in pairs(self._levelMOList) do
		return i
	end
end

function M:setCellKillData(celllKillData)
	self._cellKillMOList = {}

	for i, v in ipairs(celllKillData) do
		local killMO = AirWorkKillMO.New()

		killMO:initByAgent(v)
		table.insert(self._cellKillMOList, killMO)
	end
end

function M:getCellKillData()
	return self._cellKillMOList or {}
end

function M:setEnterBattleLevelId(levelId)
	self._enterLevelId = levelId
end

function M:getEnterBattleLevelId()
	return self._enterLevelId
end

function M:_initTask()
	self._taskMoList = {}

	local taskCoList = AirWorkShopConfig.instance:getConfigList(ConfigName.AirStudioTask)

	for i, v in ipairs(taskCoList) do
		local taskMo = AirWorkTaskMo.New()

		taskMo:initData(v.id, 0, false)
		table.insert(self._taskMoList, taskMo)
	end
end

function M:_getTaskMo(id)
	for i, v in ipairs(self._taskMoList) do
		if v:getTaskId() == id then
			return v
		end
	end

	printError("===can not find taskMo id-->", id)

	return false
end

function M:updateTask(tasks)
	if not self._taskMoList then
		self:_initTask()
	end

	for i, v in ipairs(tasks) do
		local taskMo = self:_getTaskMo(v.id)

		if taskMo then
			taskMo:initData(v.id, v.count, v.finish)
		end
	end
end

function M:updateTaskStatus(taskIds)
	for i, v in ipairs(taskIds) do
		local taskMo = self:_getTaskMo(v)

		if taskMo then
			taskMo:updateData(taskMo:getCurCount(), true)
		end
	end
end

function M:getTaskMoList(taskType)
	if not self._taskMoList then
		self:_initTask()
		AirWorkShopDefAgent.instance:sendGetAirTaskListRequest()
	end

	local moList = {}

	for i, v in ipairs(self._taskMoList) do
		if v:getType() == taskType then
			table.insert(moList, v)
		end
	end

	table.sort(moList, self._taskSort)

	return moList
end

function M:getCanGainFromServerTaskIds(taskType)
	local moList = self:getTaskMoList(taskType)
	local ids = {}

	for _, mo in ipairs(moList or {}) do
		if mo:canGetReward() and not mo:getIsFinish() then
			table.insert(ids, mo:getTaskId())
		end
	end

	return ids
end

function M._taskSort(moA, moB)
	local isFinishA = moA:getIsFinish() and 1 or 0
	local isFinishB = moB:getIsFinish() and 1 or 0

	if isFinishA ~= isFinishB then
		return isFinishA < isFinishB
	end

	local canGetA = moA:canGetReward() and 1 or 0
	local canGetB = moB:canGetReward() and 1 or 0

	if canGetA ~= canGetB then
		return canGetB < canGetA
	end

	local sortIndexA = moA:getSortIndex() or 0
	local sortIndexB = moB:getSortIndex() or 0

	if sortIndexA ~= sortIndexB then
		return sortIndexB < sortIndexA
	end

	return moA:getTaskId() < moB:getTaskId()
end

function M:requestSelfLevelImages()
	for i, levelMO in pairs(self._levelMOList) do
		local cover = levelMO:getCover()

		if self._cover2ImgList[cover] == nil then
			self._selfImageDic[cover] = true

			self:requestLevelImage(cover)
		end
	end
end

function M:requestLevelImage(cover)
	local url = string.format("%s/airworkshop/%s", BootstrapGameConfigMgr.getFileServerUrl(), cover)

	QiNiuUtil.DownloadImageFile(url, AirWorkShopConst.CaptureWdith, AirWorkShopConst.CaptureHeight, self._onGetLevelImage, self, cover)
end

function M:_onGetLevelImage(sp, cover)
	self:_clearLevelImage(cover)

	if sp then
		self._cover2ImgList[cover] = sp
	else
		self._cover2ImgList[cover] = false
	end

	GlobalDispatcher:dispatchEvent(AirWorkShopEventType.ON_SCENE_IMAGE_DOWNLOADED, cover)

	if not self._selfImageDic[cover] then
		table.insert(self._imageIdCache, cover)

		if #self._imageIdCache > kMaxCacheOtherImage then
			local cover = table.remove(self._imageIdCache, 1)

			self:_clearLevelImage(cover)
		end
	end
end

function M:getSpriteByCover(cover, request)
	if request and self._cover2ImgList[cover] == nil then
		self:requestLevelImage(cover)
	end

	return self._cover2ImgList[cover]
end

function M:addImage2NewSavedLevel(newCover, oldCover)
	if oldCover and self._cover2ImgList[oldCover] then
		QiNiuUtil.DeleteFile(string.format("airworkshop/%s", oldCover))
	end

	QiNiuUtil.UploadFile(self._capturedData, string.format("airworkshop/%s", newCover))
	self:_clearLevelImage(oldCover)

	self._cover2ImgList[newCover] = QiNiuUtil.Bytes2Spirit(self._capturedData, AirWorkShopConst.CaptureWdith, AirWorkShopConst.CaptureHeight)
	self._capturedData = nil
end

function M:setCapturedData(data)
	self._capturedData = data
end

function M:addTemplateScene(templateNO)
	local mapMO = AirWorkMapMO.New()

	mapMO:initByAgent(templateNO.info)

	self._templateMapList[templateNO.id] = mapMO
	self._templateId2CoverDic[templateNO.id] = templateNO.cover
end

function M:getTemplateScene(templateId)
	return self._templateMapList[templateId]
end

function M:getTemplateCover(templateId)
	return self._templateId2CoverDic[templateId]
end

M.instance = M.New()

return M
