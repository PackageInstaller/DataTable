-- chunkname: @modules/logic/rouge/controller/RougeTesting.lua

module("modules.logic.rouge.controller.RougeTesting", package.seeall)

local TestingBase = _G.class("TestingBase")

function TestingBase:build_test()
	return
end

function TestingBase:link(obj)
	self._obj = obj
end

local SRougeTesting = _G.class("SRougeTesting", TestingBase)

function SRougeTesting:ctor()
	self._season2RougeInfo = {}
	self._season2RougeOutsideInfo = {}
end

function SRougeTesting:_make_RougeBattleHero(index)
	return {
		supportHeroSkill = 0,
		index = index or math.random(1, 4),
		heroId = math.random(3003, 3020),
		equipUid = math.random(1501, 1510),
		supportHeroId = math.random(3022, 3060)
	}
end

function SRougeTesting:_make_RougeHeroLife(heroId)
	return {
		heroId = heroId or math.random(3003, 3020),
		life = math.random(1, 100) * 1000
	}
end

function SRougeTesting:_make_RougeTeamInfo()
	local res = {
		battleHeroList = {},
		heroLifeList = {}
	}

	function res.HasField(_, fieldName)
		return res[fieldName] ~= nil
	end

	local N = 4

	for index = 1, N do
		local item = self:_make_RougeBattleHero(index)

		if math.random(1, 1000) % 2 == 0 then
			item.supportHeroId = item.supportHeroId or 0
		end

		table.insert(res.battleHeroList, item)
	end

	for index = 1, N do
		local heroId = res.battleHeroList[index].heroId
		local item = self:_make_RougeHeroLife(heroId)

		table.insert(res.heroLifeList, item)
	end

	return res
end

function SRougeTesting:_make_RougeBagPos(row, col)
	return {
		row = row or 0,
		col = col or 0
	}
end

local s_make_RougeItem_uid = 1

function SRougeTesting:_make_RougeItem(id, itemId)
	local itemList = lua_item.configList
	local itemListIndex = math.random(1, #itemList)
	local res = {
		id = id or s_make_RougeItem_uid,
		itemId = itemId or itemList[itemListIndex].id,
		holdItems = {},
		holdIds = {}
	}

	s_make_RougeItem_uid = s_make_RougeItem_uid + 1

	local NholdItems = 0
	local rougeSynthesisList = {}

	for i = 1, NholdItems do
		local index = math.random(1, #rougeSynthesisList)

		res.holdItems[i] = rougeSynthesisList[index]
	end

	local NholdIds = 0

	for i = 1, NholdIds do
		res.holdItems[i] = NholdIds
	end

	return res
end

function SRougeTesting:_make_RougeItemLayout()
	local maxRow = 1
	local maxCol = 1

	if RougeEnum.MaxCollectionSlotSize then
		maxRow = RougeEnum.MaxCollectionSlotSize.x
		maxCol = RougeEnum.MaxCollectionSlotSize.y
	end

	local row = math.random(1, maxRow)
	local col = math.random(1, maxCol)
	local res = {
		pos = self:_make_RougeBagPos(row, col),
		rotation = math.random(0, 3),
		item = self:_make_RougeItem(),
		baseEffects = {},
		extraEffects = {}
	}
	local NbaseEffects = 0

	for i = 1, NbaseEffects do
		res.baseEffects[i] = 1
	end

	local NextraEffects = 0

	for i = 1, NextraEffects do
		res.extraEffects[i] = 1
	end

	return res
end

function SRougeTesting:_make_RougeBag()
	local res = {
		layouts = {}
	}
	local Nlayouts = 0

	for i = 1, Nlayouts do
		res.layouts[i] = self:_make_RougeItemLayout()
	end

	return res
end

function SRougeTesting:_make_RougeTalent(id, isActive)
	return {
		id = id,
		isActive = isActive or false
	}
end

function SRougeTesting:_make_RougeTalentTree()
	local res = {
		rougeTalent = {}
	}
	local list = lua_rouge_talent.configList

	for i, CO in ipairs(list or {}) do
		local id = CO.id
		local isActive = math.random(0, 9999) % 2 == 0

		res.rougeTalent[i] = self:_make_RougeTalent(id, isActive)
	end

	return res
end

function SRougeTesting:_make_RougeWarehouse()
	local res = {
		items = {}
	}
	local Nitems = 0

	for i = 1, Nitems do
		res.items[i] = self:_make_RougeItem()
	end

	return res
end

function SRougeTesting:_make_NodeInfo(layer, stage)
	return {
		nodeId = 0,
		status = 0,
		eventId = 0,
		eventData = "",
		layer = layer or 0,
		stage = stage or 0,
		lastNodeList = {},
		nextNodeList = {}
	}
end

function SRougeTesting:_make_RougeMapInfo()
	local res = {
		curNode = 0,
		middleLayerId = 0,
		curStage = 0,
		layerId = 0,
		mapType = RougeMapEnum.MapType.Normal,
		nodeInfo = {}
	}
	local layer = res.layerId
	local stage = res.curStage

	for i = 1, 5 do
		local item = self:_make_NodeInfo(layer, stage)

		table.insert(res.nodeInfo, item)
	end

	return res
end

function SRougeTesting:_make_RougeLastReward(season, id)
	local lua_rouge_collection_editor = addGlobalModule("modules.configs.rouge.lua_rouge_collection_editor", "lua_rouge_collection_editor")
	local maxCollectionN = #lua_rouge_collection_editor
	local res = {
		param = "",
		id = id or 0
	}

	if not lua_rouge_last_reward.configDict then
		local dict = {}
		local cfgs = dict[season]

		if cfgs then
			if not cfgs[id] then
				local cfg

				if cfg then
					local type = cfg.type

					if type == "drop" then
						res.param = ""
					elseif type == "dropGroup" then
						local CO = lua_rouge_collection_editor[math.random(1, maxCollectionN)]

						res.param = tostring(CO.id)
					end
				end

				return res
			end
		end
	end
end

function SRougeTesting:_make_RougeLastReward_lastReward(refList)
	if lua_rouge_last_reward then
		if not lua_rouge_last_reward.configList then
			local list = {}
			local N = 4

			for i = 1, N do
				local index = math.random(1, N)
				local cfg = list[index]
				local id = cfg.id
				local season = cfg.season

				table.insert(refList, self:_make_RougeLastReward(season, id))
			end
		end
	end
end

function SRougeTesting:_make_RougeInfo(season, version, difficulty, style)
	local res = {
		selectRewardNum = 0,
		state = 0,
		endId = 0,
		season = season,
		version = version or {},
		difficulty = difficulty or 1,
		lastReward = {},
		style = style or 0,
		teamLevel = math.random(1, 100),
		teamExp = math.random(1, 100),
		teamSize = math.random(1, 4),
		coin = math.random(0, 100),
		talentPoint = math.random(1, 100),
		teamInfo = self:_make_RougeTeamInfo(),
		bag = self:_make_RougeBag(),
		warehouse = self:_make_RougeWarehouse(),
		talentTree = self:_make_RougeTalentTree(),
		effectInfo = {}
	}

	self:_make_RougeLastReward_lastReward(res.lastReward)

	function res.HasField(_, fieldName)
		return res[fieldName] ~= nil
	end

	if #res.lastReward > 0 then
		res.selectRewardNum = math.random(1, #res.lastReward)
	end

	return res
end

function SRougeTesting:_make_RougeOutsideBonusStageNO(stage, ...)
	return {
		stage = stage or 1,
		bonusIds = {
			...
		}
	}
end

function SRougeTesting:_make_RougeOutsideBonusNO()
	return {
		bonusStages = {}
	}
end

function SRougeTesting:_make_RougeReviewInfo(season, difficulty, style)
	return {
		portrait = 0,
		playerName = "123456",
		season = season or 1,
		playerLevel = math.random(1, 999),
		finishTime = os.time(),
		difficulty = difficulty or math.random(1, 5),
		style = style or math.random(1, 5),
		teamLevel = math.random(1, 10),
		collectionNum = math.random(1, 10)
	}
end

function SRougeTesting:_make_RougeOutsideInfo(season)
	local difficultyList = RougeConfig1.instance:getDifficultyCOListByVersions({
		101
	})

	return {
		isGeniusNewStage = false,
		season = season,
		geniusPoint = math.random(0, 100),
		geniusIds = {
			1,
			2,
			3
		},
		point = math.random(0, 100),
		bonus = self:_make_RougeOutsideBonusNO(),
		review = {},
		gameRecordInfo = {
			lastGameTime = 0,
			maxDifficulty = math.random(0, #difficultyList),
			passLayerId = {},
			passEventId = {},
			passEndId = {},
			passEntrustId = {}
		}
	}
end

function SRougeTesting:handleGetRougeOutsideInfo(req, reply)
	local season = req.season

	if not self:_getRougeOutsideInfo(season) then
		self._season2RougeOutsideInfo[season] = self:_make_RougeOutsideInfo(season)
	end

	rawset(reply, "rougeInfo", self:_getRougeOutsideInfo(season))
end

function SRougeTesting:handleGetRougeInfo(req, reply)
	local season = req.season

	if not self:_getRougeInfo(season) then
		self._season2RougeInfo[season] = self:_make_RougeInfo(season)
	end

	rawset(reply, "rougeInfo", self:_getRougeInfo(season))
end

function SRougeTesting:handleEnterRougeSelectDifficulty(req, reply)
	local season = req.season
	local rougeInfo = self:_getRougeInfo(season)

	assert(rougeInfo, "handleEnterRougeSelectDifficulty rougeInfo == nil")

	rougeInfo.season = req.season
	rougeInfo.version = req.version
	rougeInfo.difficulty = req.difficulty
	rougeInfo.state = RougeEnum.State.Difficulty

	rawset(reply, "season", season)
	rawset(reply, "rougeInfo", self:_getRougeInfo(season))
end

function SRougeTesting:handleEnterRougeSelectReward(req, reply)
	local season = req.season
	local rougeInfo = self:_getRougeInfo(season)

	assert(rougeInfo, "handleEnterRougeSelectReward rougeInfo == nil")

	rougeInfo.selectRewardId = req.rewardId
	rougeInfo.state = RougeEnum.State.LastReward

	rawset(reply, "season", season)
	rawset(reply, "rougeInfo", self:_getRougeInfo(season))
end

function SRougeTesting:handleEnterRougeSelectStyle(req, reply)
	local season = req.season
	local rougeInfo = self:_getRougeInfo(season)

	assert(rougeInfo, "handleEnterRougeSelectStyle rougeInfo == nil")

	rougeInfo.style = req.style

	rawset(reply, "season", season)
	rawset(reply, "rougeInfo", self:_getRougeInfo(season))
end

function SRougeTesting:_getRougeInfo(season)
	return self._season2RougeInfo[season]
end

function SRougeTesting:_getRougeOutsideInfo(season)
	return self._season2RougeOutsideInfo[season]
end

local CRougeTesting = _G.class("CRougeTesting", TestingBase)

function CRougeTesting:ctor()
	self._cCfg = RougeConfig1
	self._cRpc = RougeRpc
	self._cCtrl = RougeController
	self._cModel = RougeModel
	self._cOutsideRpc = RougeOutsideRpc
	self._cOutsideCtrl = RougeOutsideController
	self._cOutsideModel = RougeOutsideModel
	self._cOpenModel = OpenModel
end

function CRougeTesting:build_test()
	local resultCode = 0
	local rpcObj = self._cRpc.instance
	local outsideRpcObj = self._cOutsideRpc.instance

	function self._cOutsideRpc.sendGetRougeOutsideInfoRequest(thisObj, season, cb, cbObj)
		local req = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

		req.season = season

		local reply = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		self._obj:handleGetRougeOutsideInfo(req, reply)
		outsideRpcObj:onReceiveGetRougeOutsideInfoReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	self._cOutsideRpc.sendGetRougeOutSideInfoRequest = self._cOutsideRpc.sendGetRougeOutsideInfoRequest

	function self._cRpc.sendGetRougeInfoRequest(thisObj, season, cb, cbObj)
		local req = RougeModule_pb.GetRougeInfoRequest()

		req.season = season

		local reply = RougeModule_pb.GetRougeInfoReply()

		self._obj:handleGetRougeInfo(req, reply)
		rpcObj:onReceiveGetRougeInfoReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	function self._cRpc.sendEnterRougeSelectDifficultyRequest(thisObj, season, version, difficulty, limiterNO, cb, cbObj)
		local req = RougeModule_pb.EnterRougeSelectDifficultyRequest()

		req.season = season

		for _, v in ipairs(version) do
			req.version:append(v)
		end

		req.difficulty = difficulty

		local reply = RougeModule_pb.EnterRougeSelectDifficultyReply()

		self._obj:handleEnterRougeSelectDifficulty(req, reply)
		rpcObj:onReceiveEnterRougeSelectDifficultyReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	function self._cRpc.sendEnterRougeSelectRewardRequest(thisObj, season, rewardId, cb, cbObj)
		local req = RougeModule_pb.EnterRougeSelectRewardRequest()

		req.season = season

		for i, v in ipairs(rewardId) do
			req.rewardId:append(v)
		end

		local reply = RougeModule_pb.EnterRougeSelectRewardReply()

		self._obj:handleEnterRougeSelectReward(req, reply)
		rpcObj:onReceiveEnterRougeSelectRewardReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	function self._cRpc.sendEnterRougeSelectStyleRequest(thisObj, season, style, cb, cbObj)
		local req = RougeModule_pb.EnterRougeSelectStyleRequest()

		req.season = season
		req.style = style

		local reply = RougeModule_pb.EnterRougeSelectStyleReply()

		self._obj:handleEnterRougeSelectStyle(req, reply)
		rpcObj:onReceiveEnterRougeSelectStyleReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	function self._cOpenModel.isFunctionUnlock()
		return true
	end

	function self._cOutsideModel.isUnlock()
		return true
	end

	function self._cOutsideCtrl.isOpen()
		return true
	end

	local isTestDifficulty = false
	local isTestLastReward = false
	local isTestFaction = false

	function self._cModel.isContinueLast()
		return isTestFaction or isTestLastReward or false
	end

	if isTestDifficulty then
		function self._cModel.isContinueLast()
			return false
		end

		function self._cOutsideModel.isOpenedDifficulty()
			return true
		end

		function self._cOutsideModel.isPassedDifficulty()
			return true
		end

		function self._cModel.getDifficulty(thisObj)
			return (thisObj._rougeInfo or nil) and (thisObj._rougeInfo.difficulty or nil)
		end
	end

	if isTestFaction then
		function self._cModel.isFinishedLastReward()
			return true
		end

		function self._cModel.getDifficulty()
			return 1
		end

		function self._cOutsideModel.isOpenedStyle(thisObj, style)
			return math.random(1, 99999) % 2 == 0
		end
	end

	if isTestLastReward then
		function self._cModel.isCanSelectRewards()
			return true
		end

		function self._cModel.isFinishedLastReward()
			return false
		end

		function self._cModel.isFinishedDifficulty()
			return true
		end
	end
end

function CRougeTesting:build_test_outside()
	local resultCode = 0
	local outsideRpcObj = self._cOutsideRpc.instance

	function self._cOutsideRpc.sendGetRougeOutsideInfoRequest(thisObj, season, cb, cbObj)
		local req = RougeOutsideModule_pb.GetRougeOutsideInfoRequest()

		req.season = season

		local reply = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		self._obj:handleGetRougeOutsideInfo(req, reply)
		outsideRpcObj:onReceiveGetRougeOutsideInfoReply(resultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, resultCode)
			else
				cb(cmd, resultCode)
			end
		end
	end

	self._cOutsideRpc.sendGetRougeOutSideInfoRequest = self._cOutsideRpc.sendGetRougeOutsideInfoRequest

	local isTestUnlockAnim = true

	if isTestUnlockAnim then
		local difficultyIsNotNewDict = {}

		function self._cOutsideModel.getIsNewUnlockDifficulty(thisObj, difficulty)
			return not difficultyIsNotNewDict[difficulty]
		end

		function self._cOutsideModel.setIsNewUnlockDifficulty(thisObj, difficulty, isNew)
			difficultyIsNotNewDict[difficulty] = not isNew
		end

		local styleIsNotNewDict = {}

		function self._cOutsideModel.getIsNewUnlockStyle(thisObj, style)
			return not styleIsNotNewDict[style]
		end

		function self._cOutsideModel.setIsNewUnlockStyle(thisObj, style, isNew)
			styleIsNotNewDict[style] = not isNew
		end
	end
end

local RougeTesting = _G.class("RougeTesting")

function RougeTesting:ctor()
	self._client = CRougeTesting.New()
	self._sever = SRougeTesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function RougeTesting:_test()
	self._client:build_test()
	self._sever:build_test()
	self._client:build_test_outside()
end

RougeTesting.instance = RougeTesting.New()

return RougeTesting
