-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battlerecord/view/ChllengeRankView.lua

module("logic.extensions.battlerecord.view.RankView", package.seeall)

local ChllengeRankView = class("ChllengeRankView", ViewComponent)
local TabTypeRanks = 1
local TabTypeRecently = 2

function ChllengeRankView:buildUI()
	self._closeButton = self:getBtn("Close")
	self._rankCell = self:getGo("rankCell")
	self._levelName = self:getGo("LevelName"):GetComponent("Text")

	self._rankCell:SetActive(false)
	self:_initTitle()
	self:_initDescriptions()
	self:_buildTaskButtons()
	self:_buildRanks()
	self:_buildRecentlys()

	self._btnHome = self:getBtn("btn_home")
end

function ChllengeRankView:_initTitle()
	self._tipsBtn = self:getBtn("Nego_Title/ButtonTips")

	local titleTetx = self:getGo("Nego_Title/TxtC_Title"):GetComponent("Text")

	titleTetx.text = lang("text_tiaozhanluxiang")
end

function ChllengeRankView:_initDescriptions()
	self._descNode = self:getGo("Description")

	local txtRank = self:getGo("Description/txtRank"):GetComponent("Text")
	local txtName = self:getGo("Description/txtName"):GetComponent("Text")

	self._txtFamily = self:getGo("Description/txtFamily"):GetComponent("Text")
	self._txtAttribute = self:getGo("Description/txtAttribute"):GetComponent("Text")

	local txtFmt = self:getGo("Description/txtFmt"):GetComponent("Text")
	local txtRecord = self:getGo("Description/txtRecord"):GetComponent("Text")

	self._refreshTime = self:getGo("RefreshTime"):GetComponent("Text")
	txtRank.text = lang("text_paiming")
	txtName.text = lang("text_aoqiming")
	self._txtFamily.text = lang("text_jiazu")
	self._txtAttribute.text = lang("text_tongguanshijian")
	txtFmt.text = lang("text_zhenxing")
	txtRecord.text = lang("text_luxiang")
	self._refreshTime.text = lang("ui_rank_refreshtime")
end

function ChllengeRankView:_buildTaskButtons()
	self._btnImgChg = self:getGo("Btns/BtnSelected")
	self._btnImgChgTxt = self:getGo("Btns/BtnSelected/Text"):GetComponent("Text")
	self._btnsLayout = self:getGo("Btns/Tabs"):GetComponent("UILayoutSingleLine")

	local btnRank = self:getBtn("Btns/Tabs/Rank")
	local btnRectly = self:getBtn("Btns/Tabs/Rectly")
	local btnRankTxt = self:getGo("Btns/Tabs/Rank/Text"):GetComponent("Text")
	local btnRectlyTxt = self:getGo("Btns/Tabs/Rectly/Text"):GetComponent("Text")
	local txtRank = lang("text_tongguanpaihang")
	local txtRectly = lang("text_zuijintiaozhan")

	btnRankTxt.text = txtRank
	btnRectlyTxt.text = txtRectly
	self._btnsCfg = {}
	self._btnsCfg[TabTypeRanks] = {
		btn = btnRank,
		text = txtRank
	}
	self._btnsCfg[TabTypeRecently] = {
		btn = btnRectly,
		text = txtRectly
	}
	self._btnsHandlers = {}
	self._btnsHandlers[TabTypeRanks] = self._selectTabRanks
	self._btnsHandlers[TabTypeRecently] = self._selectTabRecentlys
end

function ChllengeRankView:_buildRanks()
	self._ranks = self:getGo("Ranks")
	self._myRankNode = self:getGo("Ranks/myRank")
	self._txtMyRank = goutil.findChildComponent(self.mainGO, "Ranks/myRank/txtMyRank", "Text")
	self._top3Cells = {}

	for i = 1, 3 do
		local go = self:getGo("Ranks/rank" .. i)

		table.insert(self._top3Cells, go)
	end

	self._goEmpty = self:getGo("Ranks/goEmpty")
	self._rankTableview = goutil.findChildComponent(self.mainGO, "Ranks/rankListView", "UITableview")

	local emptyText = self:getGo("Ranks/goEmpty/text"):GetComponent("Text")

	emptyText.text = lang("text_wurenshangbang")
end

function ChllengeRankView:_buildRecentlys()
	self._recently = self:getGo("Recently")
	self._recordsTableview = goutil.findChildComponent(self.mainGO, "Recently/rankListView", "UITableview")
	self._goRecentlyEmpty = self:getGo("Recently/goEmpty")
	self._recentlyEmptyText = self:getGo("Recently/goEmpty/text"):GetComponent("Text")
	self._recentlyEmptyText.text = lang("text_wurenshangbang")
end

function ChllengeRankView:onEnter()
	self:_registerEvents()

	local openParams = self:getOpenParam() or {}

	self._rankKey = self._rankKey or openParams[1]
	self._recordKey = self._recordKey or openParams[1]

	if not self._lastTaps then
		local tabType = openParams[2]

		self._txtAttribute.text = lang("text_tongguanshijian")
		self._refreshTime.text = lang("ui_rank_refreshtime")

		self:_loadLevelsData()
		self:_onTabTypes(tabType)
	end
end

function ChllengeRankView:_registerEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._rankTableview:RegisterCallback(self._rankNumInView, self._rankCellSize, self._rankCellAtIndex, self)
	self._rankTableview:RegisterUpdateCellCallback(self._updateRankCell)
	self._recordsTableview:RegisterCallback(self._recordNumInView, self._recordCellSize, self._recordCellAtIndex, self)
	self._recordsTableview:RegisterUpdateCellCallback(self._updateRecordCell)

	for i = 1, #self._btnsCfg do
		local btn = self._btnsCfg[i].btn

		btn:AddClickListener(function()
			self:_selectTab(i)
		end, self)
	end

	GlobalDispatcher:addListener(GlobalNotify.ChallengeRanks, self._onRankDataChange, self)
	GlobalDispatcher:addListener(GlobalNotify.ChallengeLatestRecords, self._onRecordDataChange, self)
end

function ChllengeRankView:_unregisterEvents()
	self._btnHome:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeRanks, self._onRankDataChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeLatestRecords, self._onRecordDataChange, self)
	self._closeButton:RemoveClickListener()

	for i = 1, #self._btnsCfg do
		local btn = self._btnsCfg[i].btn

		btn:RemoveClickListener()
	end

	self._rankTableview:UnRegisterAllCallbacks()
	self._recordsTableview:UnRegisterAllCallbacks()

	for i = 1, 3 do
		local go = self._top3Cells[i]

		self:_clearBtnListeners(go)
	end

	self._rankTableview:Travel(self._clearTableview, self)
	self._recordsTableview:Travel(self._clearTableview, self)
end

function ChllengeRankView:_clearBtnListeners(go)
	local btnPlay = Framework.ButtonAdapter.GetFrom(go, "btnPlay")
	local btnFormat = Framework.ButtonAdapter.GetFrom(go, "btnFormat")

	if btnPlay then
		btnPlay:RemoveClickListener()
	end

	if btnFormat then
		btnFormat:RemoveClickListener()
	end
end

function ChllengeRankView:_clearTableview(cell)
	self:_clearBtnListeners(cell.gameObject)
end

function ChllengeRankView:onExit()
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

function ChllengeRankView:_onTabTypes(tabType)
	if not tabType or tabType == 0 then
		for i = 1, #self._btnsCfg do
			self._btnsCfg[i].btn.gameObject:SetActive(true)
		end

		self._tabBtnsCfg = self._btnsCfg

		self:_selectTab(self._tabType or 1)
	else
		self._tabBtnsCfg = {}

		for i = 1, #self._btnsCfg do
			self._btnsCfg[i].btn.gameObject:SetActive(i == tabType)
		end

		self._tabBtnsCfg[tabType] = self._btnsCfg[tabType]

		self:_selectTab(tabType)
	end
end

function ChllengeRankView:_selectTab(tabType)
	self._tabType = tabType

	for k, v in pairs(self._tabBtnsCfg) do
		if v then
			v.btn.gameObject:SetActive(k ~= tabType)
		end
	end

	self._btnImgChgTxt.text = self._tabBtnsCfg[tabType].text

	local px, py, pz = Framework.TransformUtil.GetPos(self._tabBtnsCfg[tabType].btn.transform, nil, nil, nil)
	local px0, py0, pz0 = Framework.TransformUtil.GetPos(self._btnImgChg.transform, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._btnImgChg.transform, px0, py, pz0)
	self._btnsHandlers[tabType](self)
end

function ChllengeRankView:_selectTabRanks()
	self._ranks:SetActive(true)
	self._recently:SetActive(false)
	self:_updateTabRanks(true)
	self:_updateLevelName(self._rankKey, self._levelName)
end

function ChllengeRankView:_updateTabRanks(resetPosition)
	self._ranksData = BattleRecordRankModel.instance:getBattleRecordRanks(self._rankKey)
	self._ranksDataList = nil

	if self._ranksData then
		self._ranksDataList = self._ranksData.rankList
	end

	BattleRecordRankController.instance:requestBattleRanks(self._rankKey)
	self:_updateRankTop3()

	if resetPosition then
		self._rankTableview:SetOffsetWithoutRefresh(0)
	end

	if not self._ranksDataList or #self._ranksDataList == 0 then
		self._myRankNode:SetActive(false)
		self._descNode:SetActive(false)
		self._goEmpty:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._goEmpty.transform, 104, -150, 0)
	else
		self._myRankNode:SetActive(true)
		self._descNode:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._descNode.transform, 104, -31, 0)
		self._goEmpty:SetActive(false)

		self._txtMyRank.text = (not self._ranksData.myRank or self._ranksData.myRank <= 0) and lang("text_wodepaiming_wu") or string.format(lang("text_wodepaiming"), self._ranksData.myRank)
	end

	self._rankTableview:ReloadData()
end

function ChllengeRankView:_checkTeachRankState()
	self._isTeachType = string.find(self._recordKey, BattleRecordRankController.TechingPrefix)

	goutil.setActive(self._txtFamily.gameObject, not self._isTeachType)
end

function ChllengeRankView:_updateRankTop3()
	local cnt = 0

	if self._ranksDataList then
		cnt = #self._ranksDataList
	end

	for i = 1, 3 do
		local go = self._top3Cells[i]
		local data

		self:_fillRankCell(go, (self._ranksDataList or nil) and self._ranksDataList[i], self._rankKey)
	end
end

function ChllengeRankView:_selectTabRecentlys()
	self._ranks:SetActive(false)
	self._recently:SetActive(true)
	self:_updateTabRecentlys(true)
	self:_updateLevelName(self._recordKey, self._levelName)
end

function ChllengeRankView:_updateTabRecentlys(resetPosition)
	self:_checkTeachRankState()

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
		Framework.TransformUtil.SetLocalPos(self._descNode.transform, 104, 243, 0)
	end

	self._recordsTableview:ReloadData()
end

function ChllengeRankView:_updateLevelName(key, text)
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
			nameTxt = string.format(lang("ui_rank_wtower_level"), data.levelIdx)
		elseif data.rType == 2 then
			nameTxt = string.format(lang("ui_rank_pettrain_level"), data.data.stageId, data.data.teamId)
		elseif data.rType == 3 then
			nameTxt = langPara("破阵天下 第%d阵", data.monsterId)
		elseif data.rType == 4 then
			nameTxt = langPara("战术教室 %s", TeachingDungeonConfig.instance:getStageName(data.stageId))
		end

		text.text = nameTxt
	end
end

function ChllengeRankView:_fillCell(go, data, key, rank)
	local txtRank = goutil.findChildComponent(go, "txtRank", "Text")
	local imgIcon = goutil.findChild(go, "imgIcon")
	local txtFamily = goutil.findChildComponent(go, "txtFamily", "Text")
	local txtName = goutil.findChildComponent(go, "txtName", "Text")
	local imgLeft = goutil.findChildComponent(go, "imgLeft", "UIImageSpriteChange")
	local imgRight = goutil.findChildComponent(go, "imgRight", "UIImageSpriteChange")
	local passTime = goutil.findChild(go, "passTime")
	local txtPassTime = goutil.findChildComponent(passTime, "txtPassTime", "Text")
	local txtDefPower = goutil.findChildComponent(go, "txtFightPower", "Text")

	if txtRank then
		txtRank.text = tostring(rank)
	end

	txtFamily.text = self._isTeachType and "" or string.nilorempty(data.familyName) and lang("text_nofamily") or data.familyName

	if imgLeft then
		imgLeft:SetState(rank % 2 == 0 and 1 or 0)
	end

	if imgRight then
		imgRight:SetState(rank % 2 == 0 and 1 or 0)
	end

	txtName.text = data.headInfo.userName

	HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if data.score then
		local score = checknumber(data.score)

		goutil.setActive(txtPassTime.gameObject, score > 0)

		txtPassTime.text = score
	elseif data.passTime or data.fightTime then
		local passTime = checknumber((not data.passTime or nil) and data.fightTime)

		goutil.setActive(txtPassTime.gameObject, passTime > 0)

		if passTime > 0 then
			local time = GameUtil.time2date(passTime / 1000)

			txtPassTime.text = string.format(lang("text_timeinfo"), time.month, time.day, time.hour, time.min, time.sec)
		end
	end

	if string.find(self._recordKey, BattleRecordRankController.BFPrefix) then
		txtPassTime.text = ""
	end
end

function ChllengeRankView:_fillRankCell(go, data, key)
	print("==========lgj?????", "想输出啥key", key)

	if not data then
		go:SetActive(false)

		return
	end

	go:SetActive(true)

	local rank = checknumber(data.rank)

	self:_fillCell(go, data, key, rank)

	local btnPlay = Framework.ButtonAdapter.GetFrom(go, "btnPlay")
	local btnFormat = Framework.ButtonAdapter.GetFrom(go, "btnFormat")
	local btnIcon = Framework.ButtonAdapter.GetFrom(go, "imgIcon")

	btnFormat.gameObject:SetActive(true)
	btnPlay:AddClickListener(function()
		self._saveState = true

		BattleRecordRankController.instance:requestBattleRecordVideo(key, rank)
	end)
	btnFormat:AddClickListener(function()
		self._saveState = true

		print("==========lgj?????", "想输出啥key", key)
		BattleRecordRankController.instance:requestBattleRecordDetails(key, rank)
	end)
	btnIcon:RemoveClickListener()
	btnIcon:AddClickListener(function()
		self:_onClickIcon(data.headInfo.userId, btnIcon)
	end)
end

function ChllengeRankView:_onClickIcon(userId, btnIcon)
	print("click icon")
	FriendController.instance:showInfoView(userId, btnIcon)
end

function ChllengeRankView:_fillRecordCell(go, data, key, idx)
	if not data then
		go:SetActive(false)

		return
	end

	local rank = idx + 1

	self:_fillCell(go, data, key, rank)

	local btnPlay = Framework.ButtonAdapter.GetFrom(go, "btnPlay")
	local btnFormat = Framework.ButtonAdapter.GetFrom(go, "btnFormat")

	btnFormat:AddClickListener(function()
		local mo = {}

		mo.userName = data.headInfo.userName
		mo.myPlayer = data.myView or data.myPlayer
		mo.enemyPlayer = data.rivalView or data.enemyPlayer
		mo.recordKey = self._recordKey
		mo.battleId = data.battleId

		BattleRecordFmtModel.instance:setRecordInfo(mo)
		UIStateManager.instance:push(ViewName.RecordMissionView, mo, key, true)
	end)
	btnPlay:AddClickListener(function()
		UIJumper.instance:saveCurStack()

		if string.find(self._recordKey, BattleRecordRankController.BFPrefix) then
			local ids = string.split(self._recordKey, "_")
			local teamId = checknumber(ids[2])
			local monsterId = checknumber(ids[3])

			print("teamId = " .. teamId .. "monsterId = " .. monsterId)
			BreachFormationAgent.instance:sendPM_BreachFormationWatchBattleVideoReq(teamId, monsterId, data.battleId, self._onWatchRes, self)
		else
			BattleRecordRankAgent.instance:sendPM_BattleRecordGetBattleVideoReq2(self._recordKey, data.battleId)
		end
	end)
end

function ChllengeRankView:_onWatchRes(msg)
	BattleFacade.instance:onViewUserFightMonsterBtlResult(msg.btlResult)
end

function ChllengeRankView:_rankNumInView()
	if not self._ranksDataList or #self._ranksDataList <= 3 then
		return 0
	end

	return #self._ranksDataList - 3
end

function ChllengeRankView:_rankCellSize(view, idx)
	if idx + 1 == #self._ranksDataList then
		return 1027, 106
	end

	return 1027, 66
end

function ChllengeRankView:_rankCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankCell)
	cell.index = index

	self:_updateRankCell(view, cell)

	return cell
end

function ChllengeRankView:_updateRankCell(view, cell)
	local idx = cell.index
	local data = self._ranksDataList[idx + 4]

	self:_fillRankCell(cell.gameObject, data, self._rankKey)
end

function ChllengeRankView:_recordNumInView()
	if not self._recordsDataList then
		return 0
	end

	return #self._recordsDataList
end

function ChllengeRankView:_recordCellSize(view, idx)
	if idx + 1 == #self._recordsDataList then
		return 1027, 106
	end

	return 1027, 66
end

function ChllengeRankView:_recordCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankCell)
	cell.index = index

	self:_updateRecordCell(view, cell)

	return cell
end

function ChllengeRankView:_updateRecordCell(view, cell)
	local idx = cell.index
	local data = self._recordsDataList[idx + 1]

	self:_fillRecordCell(cell.gameObject, data, self._recordKey, idx)
end

function ChllengeRankView:_onClickClose()
	UIStateManager.instance:pop()
end

function ChllengeRankView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function ChllengeRankView:_onRankDataChange(rankKey)
	if self._tabType ~= TabTypeRanks then
		return
	end

	local resetPosition = self._rankKey ~= rankKey

	self._rankKey = rankKey

	self:_updateTabRanks(resetPosition)
end

function ChllengeRankView:_onRecordDataChange(recordKey)
	if self._tabType ~= TabTypeRecently then
		return
	end

	local resetPosition = self._recordKey ~= recordKey

	self._recordKey = recordKey

	self:_updateTabRecentlys(resetPosition)
end

function ChllengeRankView:_loadLevelsData()
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
	elseif string.find(self._recordKey, BattleRecordRankController.TechingPrefix) then
		self:_loadTechRecord()
	end
end

function ChllengeRankView:_loadChallengesLevelsData()
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
					id = data.id,
					phaseId = data.phaseId,
					branchId = data.branchId,
					levelIdx = j,
					data = data,
					chapter = i,
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

function ChllengeRankView:_loadWTowerLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.WTowerPrefix, "")
	local ids = string.split(key, "_")
	local seasonId = tonumber(ids[1])
	local cfgs = WTowerConfig.instance:getCfgs()

	self._levelsData = {}

	for i = 1, #cfgs do
		local data = cfgs[i]

		if data.video then
			local key = BattleRecordRankController.instance:getWTowerRankKey(seasonId, data.creepsMasterId)

			table.insert(self._levelsData, {
				rType = 1,
				id = data.creepsMasterId,
				levelIdx = i,
				data = data,
				key = key
			})
		end
	end
end

function ChllengeRankView:_loadBfRecord()
	local key = string.gsub(self._recordKey, BattleRecordRankController.BFPrefix, "")
	local ids = string.split(key, "_")
	local teamId = tonumber(ids[1])
	local monsterId = tonumber(ids[2])

	self._levelsData = {}
	self._txtAttribute.text = ""
	self._refreshTime.text = ""

	table.insert(self._levelsData, {
		rType = 3,
		teamId = teamId,
		monsterId = monsterId,
		key = self._recordKey
	})
end

function ChllengeRankView:_loadTechRecord()
	local key = string.gsub(self._recordKey, BattleRecordRankController.TechingPrefix, "")
	local stageId = tonumber(key)

	self._levelsData = {}
	self._refreshTime.text = ""
	self._recentlyEmptyText.text = "暂无记录"

	table.insert(self._levelsData, {
		rType = 4,
		stageId = stageId,
		key = self._recordKey
	})
end

function ChllengeRankView:_loadPetTrainningLevelsData()
	local key = string.gsub(self._recordKey, BattleRecordRankController.PetTrainningPrefix, "")
	local ids = string.split(key, "_")
	local petTId = tonumber(ids[1])
	local teamIds = PetTrialConfig.instance:getTeamCfgs(petTId)

	self._levelsData = {}

	for k, v in pairs(teamIds) do
		local data = v
		local cfg = PetTrialConfig.instance:getStageCfgById(v.stageId)

		if cfg.video then
			local key = BattleRecordRankController.instance:getPetTrainningRankKey(petTId, data.teamId)

			table.insert(self._levelsData, {
				rType = 2,
				id = data.teamId,
				levelIdx = k,
				cfg = cfg,
				data = data,
				key = key
			})
		end
	end

	table.sort(self._levelsData, function(x, y)
		if x == y then
			return false
		end

		if x.id < y.id then
			return true
		end

		if x.id > y.id then
			return false
		end

		return false
	end)
end

return ChllengeRankView
