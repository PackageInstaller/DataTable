-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemopen/model/SystemOpenModel.lua

module("logic.extensions.systemopen.model.SystemOpenModel", package.seeall)

local SystemOpenState = CommEnum.SystemOpenState
local M = class("SystemOpenModel", BaseModel)

function getSplitInter(num)
	local tb = {}

	while num ~= 0 do
		table.insert(tb, num % 10)

		num = math.floor(num / 10)
	end

	return tb
end

function byte2bin(n)
	local t = {}

	for i = 7, 0, -1 do
		t[#t + 1] = math.floor(n / 2^i)
		n = n % 2^i
	end

	return table.concat(t)
end

function M:ctor()
	self._openSystemIds = {}
	self._openSystemConditions = {}
	self._openSystemHandlers = {}
	self._specialFunMap = {}
	self._offlinesIdsMap = {}

	self:clearSystemOpenHint()
	self:clearMainSysHint()
end

function M:onInit()
	self._specialFunMap[ViewName.StableAreaChapterView] = self._stableAreaDungeonJudge
	self._specialFunMap[ViewName.DungeonChapterMainView] = self._mainlineDungeonJudge
	self._specialFunMap[ViewName.RedMistChapterView] = self._specialEquipExploreDungeonJudge
	self._specialFunMap[ViewName.FacilityHoldingInformationTipsView] = self._specialHoldRoomProtomerJudge
	self._specialFunMap[ViewName.StoreMainViewViewPresentor] = self._specialStore
	self._specialFunMap[ViewName.MainlineDungeonView] = self._mainlineDungeonJudge
end

function M:onReset()
	self._openSystemIds = {}
	self._openSystemConditions = {}
	self._offlinesIdsMap = {}

	self:clearSystemOpenHint()
	self:clearMainSysHint()
	SystemOpenConfig.instance:reset()
end

function M:addOpenSystem(systemId)
	local isNeedAdd = false

	if not self._openSystemIds[systemId] then
		isNeedAdd = true
		self._openSystemIds[systemId] = true
	end

	if enableLog then
		print("添加开启的系统:", systemId, isNeedAdd)
	end

	return isNeedAdd
end

function M:removeOpenSystem(codes)
	for k, v in ipairs(codes) do
		self._openSystemIds[v] = false

		self:addOfflinesId(v)

		local conditions = self._openSystemConditions[v]

		if conditions ~= nil and conditions ~= false then
			local idx = getSplitInter(conditions)
			local temp = ""

			for i = 1, #idx do
				temp = temp .. (i == 1 and 0 or idx[i])
			end

			temp = tonumber(temp)
			self._openSystemConditions[v] = temp
		end

		if enableLog then
			print("关闭开启的系统:", v)
		end
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN)
end

function M:updateOpenSystemCondition(systemId, bits)
	bits = tonumber(byte2bin(bits))
	self._openSystemConditions[systemId] = bits

	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemId)

	if systemOpenCO then
		local index = systemOpenCO:getNeedUnlockIndex()
		local idx1 = getSplitInter(index)
		local idx2 = getSplitInter(bits)
		local len = #idx1 > #idx2 and #idx1 or #idx2
		local temp = ""

		for i = len, 1, -1 do
			temp = temp .. ((idx1[i] and idx1[i] == 1 or idx2[i] and idx2[i] == 1) and 1 or 0)
		end

		temp = tonumber(temp)
		self._openSystemConditions[systemId] = temp

		if temp >= systemOpenCO:getFullIndex() then
			return self:addOpenSystem(systemId)
		elseif self._openSystemIds[systemId] then
			self._openSystemIds[systemId] = false

			GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN)
		end
	else
		printWarn("没有功能开启配置", systemId)
	end

	return false
end

function M:updateOpenSystemByBitIndex(systemId, bitIndex)
	local conditions = self._openSystemConditions[systemId]
	local bits = ""

	for i = 3, 0, -1 do
		bits = bits .. ((i == bitIndex or bitIndex < 3 and i == 3) and "1" or "0")
	end

	if conditions ~= nil and conditions ~= false then
		local idx1 = getSplitInter(conditions)
		local idx2 = getSplitInter(bits)
		local len = #idx1 > #idx2 and #idx1 or #idx2
		local temp = ""

		for i = 1, len do
			temp = temp .. ((idx1[i] and idx1[i] == 1 or idx2[i] and idx2[i] == 1) and 1 or 0)
		end

		bits = temp
	end

	local systemOpenCO = SystemOpenConfig.instance:getSystemOpenCOById(systemId)

	if systemOpenCO then
		local index = systemOpenCO:getNeedUnlockIndex()
		local idx1 = getSplitInter(index)
		local idx2 = getSplitInter(bits)
		local len = #idx1 > #idx2 and #idx1 or #idx2
		local temp = ""

		for i = 1, len do
			temp = temp .. ((idx1[i] and idx1[i] == 1 or idx2[i] and idx2[i] == 1) and 1 or 0)
		end

		temp = tonumber(temp)
		self._openSystemConditions[systemId] = temp

		if temp >= systemOpenCO:getFullIndex() then
			self:removeOfflinesId(systemId)

			return self:addOpenSystem(systemId)
		elseif self._openSystemIds[systemId] then
			self._openSystemIds[systemId] = false

			GlobalDispatcher:dispatchEvent(EventType.ON_SYSTEM_OPEN)
		end
	else
		printWarn("没有功能开启配置", systemId)
	end
end

function M:getSystemOpenState(systemId)
	local isOpen = self:isOpen(systemId)

	return isOpen and SystemOpenState.OpenState or SystemOpenState.NotOpenState
end

function M:getSystemIsOnline(systemId, existCheck)
	if self._openSystemConditions[systemId] ~= nil then
		return self._openSystemConditions[systemId] >= 1000
	end

	if existCheck then
		return not self:isInOfflineLst(systemId)
	end

	return true
end

function M:isOpen(systemId)
	local handler = self._openSystemHandlers[systemId]

	if handler then
		return handler:call(systemId)
	end

	if not self._openSystemIds[systemId] and self._openSystemConditions[systemId] ~= nil then
		if not self:getSystemIsOnline(systemId) then
			return false, 4
		end

		local index = 0

		for k, v in ipairs(getSplitInter(self._openSystemConditions[systemId])) do
			if v == 0 and index == 0 then
				index = k
			end
		end

		return false, index
	end

	return self._openSystemIds[systemId] == true
end

function M:isOpenJudgeFromServer(systemId)
	return self._openSystemIds[systemId] == true
end

function M:addOpenSystemHandler(systemId, callback, handler)
	self._openSystemHandlers[systemId] = Handler.New(callback, handler)
end

function M:_stableAreaDungeonJudge(param)
	if param == "" then
		return SystemOpenState.NotOpenState
	end

	local chapterMo = DungeonMaterialChapterModel.instance:getChapterMoByChapterId(tonumber(param))

	return chapterMo:getIsChapterUnlock() and SystemOpenState.OpenState or SystemOpenState.NotOpenState
end

function M:_specialEquipExploreDungeonJudge(param)
	if param == "" then
		return SystemOpenState.NotOpenState
	end

	local isUnlock = DungeonEquipExploreChapterModel.instance:getIsChapterUnlock(tonumber(param))

	return isUnlock and SystemOpenState.OpenState or SystemOpenState.NotOpenState
end

function M:_mainlineDungeonJudge(param)
	if param == "" then
		return SystemOpenState.OpenState
	end

	local strList = string.split(param, "-")

	if strList[1] == "difficulty" then
		local difficulty = tonumber(strList[3])
		local chapterId = tonumber(strList[2])
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(chapterId, difficulty)

		return chapterMo:getIsChapterUnlock() and SystemOpenState.OpenState or SystemOpenState.NotOpenState
	elseif strList[1] == "level" then
		local difficulty = tonumber(strList[2])
		local chapterId = tonumber(strList[3])
		local chapterMo = DungeonMainLineChapterModel.instance:getChapterMoByIdAndDifficulty(chapterId, difficulty)
		local dungeonId = chapterMo:getDungeonIds()[tonumber(strList[4])]
		local dungeonMo = DungeonMainLineChapterModel.instance:getDungeonMoById(dungeonId)

		if not dungeonMo then
			if enableLog then
				printError(string.format("无法找到[%s] dungeonMo, param:%s", dungeonId, param))
			end

			return SystemOpenState.NotOpenState
		end

		return dungeonMo:getIsUnlock() and SystemOpenState.OpenState or SystemOpenState.NotOpenState
	end
end

function M:_specialHoldRoomProtomerJudge(param)
	if param == "" then
		return SystemOpenState.NotOpenState
	end

	local protomerId = tonumber(param)
	local protomerInfoMo = ProtomerModel.instance:getProtomerInfo(protomerId)

	if protomerInfoMo == nil then
		return SystemOpenState.NotOpenState
	else
		return SystemOpenState.OpenState
	end
end

function M:_specialStore(param)
	if param == "" then
		return SystemOpenState.OpenState
	end

	local storeId = tonumber(param)
	local storeMo = StoreModel.instance:getStoreMoByID(storeId)
	local isOpen = storeMo and true or false

	if not isOpen then
		return SystemOpenState.NotOpenState
	else
		return SystemOpenState.OpenState
	end
end

function M:getSpecialOpenState(viewName, param)
	local openState = SystemOpenState.OpenState
	local func = self._specialFunMap[viewName]

	openState = func and func(self, param) or openState

	return openState
end

function M:getSystemMulState(systemId, viewName, param)
	if systemId == 0 then
		return SystemOpenState.OpenState
	end

	local openState = self:getSystemOpenState(systemId)

	if SystemOpenState.OpenState == openState then
		openState = self:getSpecialOpenState(viewName, param)
	end

	return openState
end

function M:addSystemOpenHint(code)
	table.insert(self._openSystemHintIds, code)
end

function M:getSystemOpenHintLst()
	return self._openSystemHintIds or {}
end

function M:clearSystemOpenHint()
	self._openSystemHintIds = {}
end

function M:addMainViewSysHint(code)
	if not table.indexof(self._mainViewSysHintIds, code) then
		table.insert(self._mainViewSysHintIds, code)
	end
end

function M:getMainViewSysHints()
	return self._mainViewSysHintIds or {}
end

function M:clearMainSysHint()
	self._mainViewSysHintIds = {}
end

function M:initOfflinesIds(offlinesIds)
	self._offlinesIdsMap = {}

	for _, systemId in ipairs(offlinesIds or {}) do
		self:addOfflinesId(systemId)
	end
end

function M:addOfflinesId(systemId)
	self._offlinesIdsMap[systemId] = 1

	print(string.format("功能[%s]未上线", systemId))
end

function M:removeOfflinesId(systemId)
	if self._offlinesIdsMap[systemId] then
		self._offlinesIdsMap[systemId] = nil

		print(string.format("功能[%s]从未上线列表中移除", systemId))
	end
end

function M:isInOfflineLst(systemId)
	if self._offlinesIdsMap[systemId] then
		return true
	end

	return false
end

M.instance = M.New()

return M
