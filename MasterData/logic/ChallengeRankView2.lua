-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/ChallengeRankView2.lua

module(..., package.seeall)

local ChallengeRankView2 = class("ChallengeRankView2", ViewComponent)
local TabTypeRecently = 2

function ChallengeRankView2:buildUI()
	self._closeButton = self:getBtn("Close")
	self.btn_home = self:getBtn("btn_home")
	self._rankCell = self:getGo("rankCell")
	self._levelName = self:getGo("LevelName"):GetComponent("Text")

	self._rankCell:SetActive(false)
	self:_initTitle()
	self:_initDescriptions()
	self:_buildRecentlys()
end

function ChallengeRankView2:_initTitle()
	local titleTetx = self:getGo("Text"):GetComponent("Text")

	titleTetx.text = lang("text_tiaozhanluxiang")
end

function ChallengeRankView2:_initDescriptions()
	self._descNode = self:getGo("Description")

	local txtName = self:getGo("Description/txtName"):GetComponent("Text")

	self._txtAttribute = self:getGo("Description/txtAttribute"):GetComponent("Text")

	local txtFmt = self:getGo("Description/txtFmt"):GetComponent("Text")
	local txtRecord = self:getGo("Description/txtRecord"):GetComponent("Text")
	local txtPower = self:getGo("Description/txtPower"):GetComponent("Text")

	txtName.text = lang("text_aoqiming")
	self._txtAttribute.text = lang("text_tongguanshijian")
	txtFmt.text = lang("text_zhenxing")
	txtRecord.text = lang("text_luxiang")
	txtPower.text = lang("总战斗力")

	self:getBtn("Description/txtPower"):AddClickListener(self._onClickPowerSort, self)
	self:getBtn("Description/txtAttribute"):AddClickListener(self._onClickTimeSort, self)
	self:getBtn("Description/txtRecord"):AddClickListener(self._onClickRecordSort, self)

	self._txtRecord = txtRecord
end

function ChallengeRankView2:_onClickPowerSort()
	self._curPowerSort = self._curPowerSort == 0 and 1 or self._curPowerSort == 1 and -1 or 1

	if self._recordsDataList then
		print("_recordsDataList len:" .. #self._recordsDataList)
		table.sort(self._recordsDataList, function(a, b)
			print("a power:" .. a.enemyPlayer.zdl)
			print("b power:" .. b.enemyPlayer.zdl)

			if self._curPowerSort == 1 then
				return a.myPlayer.zdl > b.myPlayer.zdl
			else
				return a.myPlayer.zdl < b.myPlayer.zdl
			end
		end)
		self._recordsTableview:SetOffsetWithoutRefresh(0)
		self._recordsTableview:ReloadData()
	else
		print("no self._recordsDataList")
	end
end

function ChallengeRankView2:_onClickTimeSort()
	self._curTimeSort = self._curTimeSort == 0 and 1 or self._curTimeSort == 1 and -1 or 1

	if self._recordsDataList then
		table.sort(self._recordsDataList, function(a, b)
			if self._curTimeSort == 1 then
				return a.fightTime > b.fightTime
			else
				return a.fightTime < b.fightTime
			end
		end)
		self._recordsTableview:SetOffsetWithoutRefresh(0)
		self._recordsTableview:ReloadData()
	end
end

function ChallengeRankView2:_onClickRecordSort()
	self._curPlaytimesSort = self._curPlaytimesSort == 0 and 1 or self._curPlaytimesSort == 1 and -1 or 1

	if self._recordsDataList then
		table.sort(self._recordsDataList, function(a, b)
			if self._curPlaytimesSort == 1 then
				return (b.videoWatchTimes or 0) < (a.videoWatchTimes or 0)
			else
				return (a.videoWatchTimes or 0) < (b.videoWatchTimes or 0)
			end
		end)
		self._recordsTableview:SetOffsetWithoutRefresh(0)
		self._recordsTableview:ReloadData()
	end
end

function ChallengeRankView2:_buildRecentlys()
	self._recently = self:getGo("Recently")
	self._recordsTableview = goutil.findChildComponent(self.mainGO, "Recently/rankListView", "UITableview")
	self._goRecentlyEmpty = self:getGo("Recently/goEmpty")

	local emptyText = self:getGo("Recently/goEmpty/text"):GetComponent("Text")

	emptyText.text = lang("text_wurenshangbang")
end

function ChallengeRankView2:onEnter()
	self:_registerEvents()

	local openParams = self:getOpenParam() or {}

	self._recordKey = self._recordKey or openParams[1]
	self._tabType = TabTypeRecently
	self._txtAttribute.text = lang("text_tongguanshijian")

	self:_loadLevelsData()

	self._curTimeSort = 0
	self._curPowerSort = 0
	self._curPlaytimesSort = 0

	self:_selectTabRecentlys()

	self._txtRecord.text = self._isEndlessBattle and "" or lang("text_luxiang")
end

function ChallengeRankView2:_registerEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self.btn_home:AddClickListener(function()
		UIStateManager.instance:clear(true)
	end)
	self._recordsTableview:RegisterCallback(self._recordNumInView, self._recordCellSize, self._recordCellAtIndex, self)
	self._recordsTableview:RegisterUpdateCellCallback(self._updateRecordCell)
	GlobalDispatcher:addListener(GlobalNotify.ChallengeLatestRecords, self._onRecordDataChange, self)
end

function ChallengeRankView2:_unregisterEvents()
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeLatestRecords, self._onRecordDataChange, self)
	self._closeButton:RemoveClickListener()
	self.btn_home:RemoveClickListener()
	self._recordsTableview:UnRegisterAllCallbacks()
	self._recordsTableview:Travel(self._clearTableview, self)
end

function ChallengeRankView2:_clearBtnListeners(go)
	local btnPlay = Framework.ButtonAdapter.GetFrom(go, "btnPlay")
	local btnFormat = Framework.ButtonAdapter.GetFrom(go, "btnFormat")

	if btnPlay then
		btnPlay:RemoveClickListener()
	end

	if btnFormat then
		btnFormat:RemoveClickListener()
	end
end

function ChallengeRankView2:_clearTableview(cell)
	self:_clearBtnListeners(cell.gameObject)
end

function ChallengeRankView2:onExit()
	if not self._saveState then
		self._tabType = nil
		self._recordKey = nil
		self._rankKey = nil
		self._lastTaps = nil
	end

	self._levelsData = nil
	self._tabBtnsCfg = nil
	self._saveState = nil
	self._ranksData = nil
	self._ranksDataList = nil
	self._recordsData = nil
	self._recordsDataList = nil

	self:_unregisterEvents()
end

function ChallengeRankView2:_selectTabRecentlys()
	self:_updateTabRecentlys(true)
	self:_updateLevelName(self._recordKey, self._levelName)
end

function ChallengeRankView2:_updateTabRecentlys(resetPosition)
	self._recordsData = BattleRecordRankModel.instance:getBattleLatestRecords(self._recordKey)
	self._recordsDataList = nil

	if self._recordsData then
		self._recordsDataList = self._recordsData.recordList
	end

	BattleRecordRankController.instance:requestBattleLatestRecords(self._recordKey)

	if resetPosition then
		self._recordsTableview:SetOffsetWithoutRefresh(0)
	end

	if not self._recordsDataList or #self._recordsDataList == 0 then
		self._descNode:SetActive(false)
		self._goRecentlyEmpty:SetActive(true)
	else
		self._goRecentlyEmpty:SetActive(false)
		self._descNode:SetActive(true)
	end

	self._recordsTableview:ReloadData()
end

function ChallengeRankView2:_updateLevelName(key, text)
	local data

	for i = 1, #self._levelsData do
		if self._levelsData[i].key == key then
			data = self._levelsData[i]

			break
		end
	end

	local nameTxt

	if not data.rType then
		if data.rType == 0 then
			local cfg = ChallengeConfig.instance:getChallengeCfg(data.id)

			nameTxt = string.format(lang("text_tiaozhangqming"), cfg.name, data.chapter, data.levelIdx)
		elseif data.rType == 1 then
			nameTxt = string.format(lang("ui_rank_wtower_level"), data.name, data.levelIdx)
		elseif data.rType == 2 then
			nameTxt = string.format("王者之路第%s关", data.stageId)
		elseif data.rType == 3 then
			nameTxt = langPara("破阵天下 第<color=#0068b7ff>%d</color>阵", data.monsterId)
		elseif data.rType == 4 then
			local chapterId = data.chapter
			local stageId = data.stage
			local cfg = CopyConfig.instance:getStageById(chapterId, stageId)

			nameTxt = cfg.stageName
		elseif data.rType == 5 then
			local cfg = WuShenConfig.instance:getMasterCoById(data.id)

			nameTxt = cfg.name
		elseif data.rType == 6 then
			local cfg = LegendConfig.instance:getLegendChallengeStageCfg(data.challengeId, data.stageId)

			nameTxt = cfg and cfg.stageName or ""
		else
			nameTxt = data.rType == 7 and "无尽试炼--难度" .. data.stageId or data.rType == 8 and data.name or data.rType == 9 and data.name or data.name
		end

		text.text = nameTxt
	end
end

function ChallengeRankView2:_getCellHeight(data)
	local petNum = #data.myPlayer.petInfos

	return petNum > 5 and 200 or 118
end

function ChallengeRankView2:_fillCell(go, data, key, rank)
	local imgLeft = goutil.findChildComponent(go, "imgLeft", "UIImageSpriteChange")
	local imgLeftRectTrans = imgLeft:GetComponent(typeof(UnityEngine.RectTransform))

	go = imgLeft.gameObject

	local imgIcon = goutil.findChild(imgLeft.gameObject, "imgIcon")
	local txtName = goutil.findChildComponent(go, "txtName", "Text")
	local passTime = goutil.findChild(go, "passTime")
	local txtPassTime = goutil.findChildComponent(passTime, "txtPassTime", "Text")
	local txtDefPower = goutil.findChildComponent(go, "txtPower", "Text")
	local sizeDelta = imgLeftRectTrans.sizeDelta

	imgLeftRectTrans.sizeDelta = Vector2.New(sizeDelta.x, self:_getCellHeight(data))

	local teamNode = goutil.findChild(go, "content/team")
	local txtPlayTimes = goutil.findChildComponent(go, "btnPlay/txtNum", "Text")

	if imgLeft then
		imgLeft:SetState(rank % 2 == 0 and 1 or 0)
	end

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	txtName.text = data.headInfo.userName
	txtDefPower.text = checknumber(data.myPlayer.zdl)
	txtPlayTimes.text = checknumber(data.videoWatchTimes)

	if data.score then
		local score = checknumber(data.score)

		goutil.setActive(txtPassTime.gameObject, score > 0)

		txtPassTime.text = score
	else
		local passTime = checknumber(data.fightTime)

		goutil.setActive(txtPassTime.gameObject, passTime > 0)

		if passTime > 0 then
			local time = GameUtil.time2date(passTime / 1000)

			txtPassTime.text = string.format(lang("text_timeinfo"), time.month, time.day, time.hour, time.min, time.sec)
		end
	end

	local list = {}
	local petZdlList = data.myPlayer.petZdlList
	local petInfos = data.myPlayer.petInfos

	for i, petInfo in ipairs(petInfos) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(petInfo)

		for i, _petZdl in ipairs(petZdlList or {}) do
			if _petZdl.petId == petInfo.petId then
				petMo._zdl = _petZdl.zdl

				break
			end
		end

		table.insert(list, petMo)
	end

	GameUtil.updateCellsWithCreate(teamNode, list, function(go, petData)
		local proxy = MaterialMgr.setCellByData(MatType.Pet, petData, go)

		if proxy then
			proxy.binder:setCallBack(function()
				CommonTipsMgr.instance:showPetTips(petData)
			end)
		end
	end)
end

function ChallengeRankView2:_onClickIcon(userId, btnIcon)
	FriendController.instance:showInfoView(userId, btnIcon)
end

function ChallengeRankView2:_fillRecordCell(go, data, key, idx)
	if not data then
		go:SetActive(false)

		return
	end

	local rank = idx + 1

	self:_fillCell(go, data, key, rank)

	local btnPlay = Framework.ButtonAdapter.GetFrom(go, "imgLeft/btnPlay")

	btnPlay:AddClickListener(function()
		BattleRecordRankController.instance:sendPM_BattleRecordGetBattleVideoReq2(key, data.battleId, true)
	end)

	local btnFormat = Framework.ButtonAdapter.GetFrom(go, "imgLeft/btnFormat")

	btnFormat:AddClickListener(function()
		self._saveState = true
		hideBtns = string.find(key, BattleRecordRankController.ChuangkongUnion) ~= nil

		local playFlag = string.find(key, BattleRecordRankController.ChuangkongUnion) ~= nil

		BattleRecordFmtModel.instance:setRecordInfo(data)
		UIStateManager.instance:push(ViewName.RecordMissionView, data, key, hideBtns, playFlag)
	end)
	goutil.setActive(btnPlay.gameObject, not self._isEndlessBattle)
end

function ChallengeRankView2:_recordNumInView()
	if not self._recordsDataList then
		return 0
	end

	return #self._recordsDataList
end

function ChallengeRankView2:_recordCellSize(view, idx)
	local data = self._recordsDataList[idx + 1]

	return 1027, self:_getCellHeight(data)
end

function ChallengeRankView2:_recordCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankCell)
	cell.index = index

	self:_updateRecordCell(view, cell)

	return cell
end

function ChallengeRankView2:_updateRecordCell(view, cell)
	local idx = cell.index
	local data = self._recordsDataList[idx + 1]

	self:_fillRecordCell(cell.gameObject, data, self._recordKey, idx)
end

function ChallengeRankView2:_onClickClose()
	UIStateManager.instance:pop()
end

function ChallengeRankView2:_onRecordDataChange(recordKey)
	printInfo("self._tabType :" .. self._tabType)

	if self._tabType ~= TabTypeRecently then
		return
	end

	local resetPosition = self._recordKey ~= recordKey

	self._recordKey = recordKey

	self:_updateTabRecentlys(resetPosition)
end

function ChallengeRankView2:_loadLevelsData()
	if self._levelsData then
		return
	end

	if string.find(self._recordKey, BattleRecordRankController.ChllengePrefix) then
		self:_loadChallengesLevelsData()
	elseif string.find(self._recordKey, BattleRecordRankController.WTowerPrefix) then
		self:_loadWTowerLevelsData()
	elseif string.find(self._recordKey, BattleRecordRankController.PetTrainningPrefix) then
		self:_loadPetTrainningLevelsData()
	elseif string.find(self._recordKey, BattleRecordRankController.BFPrefix) then
		self:_loadBfRecord()
	elseif string.find(self._recordKey, BattleRecordRankController.StoryPrefix) then
		self:_loadStoryLevelsData()
	elseif string.find(self._recordKey, BattleRecordRankController.PvePrefix) then
		self:_loadPveLevelsData()
	elseif string.find(self._recordKey, BattleRecordRankController.LegendPrefix) then
		self:_loadLegendData()
	elseif string.find(self._recordKey, BattleRecordRankController.EndlessPrefix) then
		self._isEndlessBattle = true

		self:_loadEndlessData()
	elseif string.find(self._recordKey, BattleRecordRankController.ChuangkongUnion) then
		self:_loadChuangkongUnionData()
	elseif string.find(self._recordKey, BattleRecordRankController.TeachPrefix) then
		self:_loadTeachData()
	elseif string.find(self._recordKey, BattleRecordRankController.HonourTowerPrefix) then
		self:_loadHonourTowerData()
	end
end

function ChallengeRankView2:_loadChallengesLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.ChllengePrefix, "")
	local ids = string.split(key, "_")
	local cId = tonumber(ids[1])
	local levels = ChallengeConfig.instance:getChallengemission(cId)
	local challengeDatas = {}

	self._levelsData = {}

	for k, v in pairs(levels) do
		for k2, v2 in pairs(v) do
			table.insert(challengeDatas, v2)
		end
	end

	table.sort(challengeDatas, function(x, y)
		if x == y then
			return false
		end

		if x.phaseId < y.phaseId then
			return true
		end

		if x.phaseId > y.phaseId then
			return false
		end

		if x.branchId < y.branchId then
			return true
		end

		if x.branchId > y.branchId then
			return false
		end

		return false
	end)

	for i = 1, #challengeDatas do
		local data = challengeDatas[i]

		for j = 1, #challengeDatas[i].subMission do
			if not data.videos or j > #data.videos or data.videos[j] ~= 0 then
				local key = BattleRecordRankController.instance:getChallengeRankKey(data.id, data.phaseId, data.branchId, j)

				table.insert(self._levelsData, {
					levelIdx = 1,
					chapter = 1,
					id = data.id,
					phaseId = data.phaseId,
					branchId = data.branchId,
					data = data,
					key = key
				})
			end
		end
	end

	table.sort(self._levelsData, function(x, y)
		if x == y then
			return false
		end

		if x.phaseId < y.phaseId then
			return true
		end

		if x.phaseId > y.phaseId then
			return false
		end

		if x.branchId < y.branchId then
			return true
		end

		if x.branchId > y.branchId then
			return false
		end

		if x.levelIdx < y.levelIdx then
			return true
		end

		if x.levelIdx > y.levelIdx then
			return false
		end

		return false
	end)
end

function ChallengeRankView2:_loadWTowerLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.WTowerPrefix, "")
	local cfgs = WTowerConfig.instance:getCfgs()

	self._levelsData = {}

	for i = 1, #cfgs do
		local data = cfgs[i]

		if data.video then
			local RankKey = BattleRecordRankController.instance:getWTowerRankKey(WTowerModel.instance:getTowerId(), data.creepsMasterId)

			table.insert(self._levelsData, {
				rType = 1,
				id = data.creepsMasterId,
				name = WTowerConfig.instance:getDicCfg(WTowerModel.instance:getTowerId()).desc,
				levelIdx = string.gsub(string.gsub(data.name, "第", ""), "关", ""),
				data = data,
				key = RankKey
			})
		end
	end
end

function ChallengeRankView2:_loadStoryLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.StoryPrefix, "")
	local ids = string.split(key, "_")
	local chapter = tonumber(ids[1])
	local stage = tonumber(ids[2])
	local team = tonumber(ids[3])

	self._levelsData = {}

	table.insert(self._levelsData, {
		rType = 4,
		chapter = chapter,
		stage = stage,
		team = team,
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadPveLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.PvePrefix, "")

	self._levelsData = {}

	table.insert(self._levelsData, {
		rType = 5,
		id = tonumber(key),
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadLegendData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.LegendPrefix, "")
	local ids = string.split(key, "_")
	local challengeId = tonumber(ids[1])
	local stageId = tonumber(ids[2])

	self._levelsData = {}

	table.insert(self._levelsData, {
		rType = 6,
		challengeId = challengeId,
		stageId = stageId,
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadEndlessData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.EndlessPrefix, "")
	local stageId = checknumber(key)
	local cfg = EndlessBattleConfig.instance:getStageCfgById(stageId)

	self._levelsData = {}

	table.insert(self._levelsData, {
		rType = 7,
		stageId = stageId,
		name = cfg.name,
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadBfRecord()
	local key = string.gsub(self._recordKey, BattleRecordRankController.BFPrefix, "")
	local ids = string.split(key, "_")
	local teamId = tonumber(ids[1])
	local monsterId = tonumber(ids[2])

	self._levelsData = {}
	self._txtAttribute.text = BreakFormationModel.instance:getConditionDesc()
	self._refreshTime.text = ""

	table.insert(self._levelsData, {
		rType = 3,
		teamId = teamId,
		monsterId = monsterId,
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadPetTrainningLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.PetTrainningPrefix, "")
	local stageId = checknumber(key)
	local cfg = PetTrialConfig.instance:getStageCfgById(stageId)

	self._levelsData = {}

	table.insert(self._levelsData, {
		rType = 2,
		stageId = stageId,
		name = cfg.name,
		key = self._recordKey
	})
end

function ChallengeRankView2:_loadChuangkongUnionData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.ChuangkongUnion, "")
	local ids = string.split(key, "_")
	local taskId, stageId = tonumber(ids[1]), tonumber(ids[2])

	self._levelsData = {}

	local cfgs = ChuangkongunionConfig.instance:getBreachFormStageById(taskId)

	table.insert(self._levelsData, {
		hideBtns = true,
		rType = 8,
		stageId = stageId,
		key = self._recordKey,
		name = cfgs[stageId].title
	})
end

function ChallengeRankView2:_loadTeachData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.TeachPrefix, "")
	local ids = string.split(key, "_")
	local stageId = tonumber(ids[1])

	self._levelsData = {}

	local cfg = TeachingDungeonConfig.instance:getConfigByStageId(stageId)

	table.insert(self._levelsData, {
		hideBtns = true,
		rType = 9,
		stageId = stageId,
		key = self._recordKey,
		name = cfg.stageName
	})
end

function ChallengeRankView2:_loadHonourTowerData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.HonourTowerPrefix, "")
	local ids = string.split(key, "_")
	local challengeId = tonumber(ids[1])
	local stageId = tonumber(ids[2])

	self._levelsData = {}

	local cfg = HonourTowerConfig.instance:getChallengeCfg(challengeId)
	local name = string.format("%s第%s关", cfg.name, stageId)

	table.insert(self._levelsData, {
		rType = 10,
		key = self._recordKey,
		name = name
	})
end

return ChallengeRankView2
