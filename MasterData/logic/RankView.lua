-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rank/view/RankView.lua

module("logic.extensions.rank.view.RankView", package.seeall)

local RankView = class("RankView", ViewComponent)

function RankView:ctor()
	RankView.super.ctor(self)

	self._txtTips = {}
	self._tableViewDatas = {}
	self._viewParamDics = {}

	self:_setTipTxt(GameEnum.RankType.BreakFormation, "提示：前100名可上榜，赛季重置当日早上8:10通过邮件发放排行奖励")
	self:_setTipTxt(GameEnum.RankType.WTower, "提示：每15分钟更新一次。")
	self:_setTipTxt(GameEnum.RankType.Arena, "在每晚22:00-22:20关闭并更新排名。")
	self:_setTipTxt(GameEnum.RankType.XiaoNuoBian, "提示：每天4:50-5:10关闭并结算排名，在每周四5:10发放排行奖励。")
	self:_setTipTxt(GameEnum.RankType.MaxPower, {
		[1] = "提示：每10分钟更新1次，最高战斗力达1万后才会上榜。",
		[2] = "提示：每10分钟更新1次，最高战斗力达1万后才会上榜。"
	})
	self:_setTipTxt(GameEnum.RankType.RankMatchClass, {
		"仅展示全服传说段位前1000名，依照积分进行排名\n排行榜数据每10分钟刷新",
		"仅展示本服传说段位前1000名，依照积分进行排名\n排行榜数据每10分钟刷新",
		"每周五清空当周精灵数据，胜场数大于100场的精灵方会上榜",
		"每周五清空当周精灵数据，胜场数大于100场的精灵方会上榜"
	})
	self:_setTipTxt(GameEnum.RankType.RankMatchLimit, {
		"仅展示全服传说段位前1000名，依照积分进行排名\n排行榜数据每10分钟刷新",
		"仅展示本服传说段位前1000名，依照积分进行排名\n排行榜数据每10分钟刷新",
		"每周五清空当周精灵数据，胜场数大于100场的精灵方会上榜",
		"每周五清空当周精灵数据，胜场数大于100场的精灵方会上榜"
	})
	self:_setTipTxt(GameEnum.RankType.GloryTowerRank, "提示：前100名可上榜，在活动结束后通过邮件发放排行奖励")
	self:_setTipTxt(GameEnum.RankType.SeniorArena, "1、每10分钟更新1次；\n2、在每晚22:00-22:20关闭并结算奖励；\n3、仅显示前100名玩家")
	self:_setTipTxt(GameEnum.RankType.FamilyTeamPlay, "1、每10分钟更新1次；\n2、仅显示前100名家族")
	self:_setTipTxt(GameEnum.RankType.SendFlower_RANK, "每七天重置排行榜")
	self:_setTipTxt(GameEnum.RankType.Charm_RANK, "1、每七天进行奖励结算\n2、鼎力支持获得随机奖励")
	self:_setTipTxt(GameEnum.RankType.Mirror_Rank, "提示：若通过最高层数相同，则通关时间越快，排名越靠前！")
	self:_setTipTxt(GameEnum.RankType.FamilyHonor, "1、每10分钟更新1次；\n2、仅显示前100名家族")
	self:_setTipTxt(GameEnum.RankType.AchievementRank, "1、仅展示成就点数前100名，依照达成时间进行排名\n2、成就点数大于300才能上榜\n3、排行榜数据每10分钟刷新一次；")
end

function RankView:bindEvents()
	RankView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function RankView:unbindEvents()
	RankView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function RankView:buildUI()
	RankView.super.buildUI(self)

	self._closeButton = self:getBtn("Close")
	self._btnHome = self:getBtn("btn_home")
	self._goDescription = goutil.findChild(self.mainGO, "right/description")
	self._goRightBg = goutil.findChild(self.mainGO, "right/bg")
	self._txtName = goutil.findChildComponent(self.mainGO, "right/description/txtName", "Text")
	self._txtFamily = goutil.findChildComponent(self.mainGO, "right/description/txtFamily", "Text")
	self._txtAttribute = goutil.findChildComponent(self.mainGO, "right/description/txtAttribute", "Text")
	self._txtRecord = goutil.findChildComponent(self.mainGO, "right/description/txtRecord", "Text")
	self._txtWin = goutil.findChildComponent(self.mainGO, "right/description/txtWin", "Text")
	self._txtWinRate = goutil.findChildComponent(self.mainGO, "right/description/txtWinRate", "Text")
	self._childViewEmpty = self:getGo("childViewEmpty")
	self._tableView = goutil.findChildComponent(self.mainGO, "tableview", "UITableview")
	self._tableCell = self:getGo("tablecell")

	goutil.setActive(self._tableCell, false)
	self._tableView:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableView:RegisterUpdateCellCallback(self._updateCell)
	self._tableView:SetOffsetWithoutRefresh(0)
	self._tableView:RegisterReloadFinishCallback(self._onReloadFinish)

	self._right = self:getGo("right")
	self._rankListView = goutil.findChildComponent(self.mainGO, "right/rankListView", "UITableview")
	self._rankCell = self:getGo("right/rankCell")

	goutil.setActive(self._rankCell, false)
	self._rankListView:RegisterCallback(self._rankNumInView, self._rankCellSize, self._rankCellAtIndex, self)
	self._rankListView:RegisterUpdateCellCallback(self._updateRankCell)
	self._rankListView:SetOffsetWithoutRefresh(0)

	self._goMyRank = goutil.findChild(self.mainGO, "right/myRank")
	self._txtMyRank = goutil.findChildComponent(self.mainGO, "right/myRank/txtMyRank", "Text")
	self._txtMyRankTip = goutil.findChildComponent(self.mainGO, "right/myRank/txtTip", "Text")
	self._txtMyRankTitle = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRankTitle")
	self._txtHistory = goutil.findChildComponent(self.mainGO, "right/myRank/txtHistory", "Text")
	self._txtHistoryNum = goutil.findChildComponent(self.mainGO, "right/myRank/txtHistory/txtNum", "Text")
	self._btnHelp = self:getGo("right/myRank/btnHelp")
	self._goEmpty = self:getGo("right/goEmpty")
	self._goZoneTip = self:getGo("right/zoneTip")
	self._txtZoneTip = goutil.findChildTextComponent(self._goZoneTip, "text")
	self._childViewRoot = self:getGo("childViewRoot")
end

function RankView:destroyUI()
	RankView.super.destroyUI(self)
end

function RankView:getRealIndex(root)
	local index

	for k, v in pairs(self._tableViewDatas) do
		if v.id == root then
			index = k

			break
		end
	end

	return index
end

function RankView:onEnter()
	RankView.super.onEnter(self)
	GlobalDispatcher:addListener(ArenaAgent.GetMyZoneInRes, self._getMyZoneInRes, self)

	self._not_open_arean_str = false

	self:_initTxtTab()

	local date = GameUtil.time2date(ServerTime.now())

	if date.hour == 22 and date.min > 0 and date.min < 20 then
		self:onEnterRefresh()
	else
		local zoneId = ArenaModel.instance:getZoneId()

		if (not zoneId or zoneId == 0) and not ArenaModel.instance:getRequireMyZoneInfoTag() then
			ArenaController.instance:sendGetMyZoneInReq()
		else
			self:onEnterRefresh()
		end
	end
end

function RankView:_getMyZoneInRes(status, msg)
	if status == 0 then
		ArenaModel.instance:setSeasonId(msg.seasonId)
		ArenaModel.instance:setZoneId(msg.zoneId)
		ArenaModel.instance:finishRequireMyZoneInfo()
		self:onEnterRefresh()
	else
		self._not_open_arean_str = MsgFlowMgr.instance:getResultCodeStr(status)

		self:onEnterRefresh()
	end
end

function RankView:onEnterRefresh()
	self:initTabData()

	local startRoot = 4
	local startLeaf = 1

	self._initRoot = self._initRoot or startRoot
	self._initLeaf = self._initLeaf or startLeaf

	if self._viewPresentor._openParam ~= nil then
		self._initRoot = checknumber(self._viewPresentor._openParam[1])
		self._initLeaf = checknumber(self._viewPresentor._openParam[2])

		if checknumber(self._viewPresentor._openParam[1]) == 0 then
			self._initRoot = tostring(self._viewPresentor._openParam[1])
		end
	end

	local realIndex = self:getRealIndex(self._initRoot)

	if not realIndex then
		self._initRoot = startRoot
		self._initLeaf = startLeaf
	else
		self._tableViewDatas[realIndex].num = math.abs(self._tableViewDatas[realIndex].num)
	end

	self._selectedRoot = self._initRoot
	self._selectedLeaf = self._initLeaf
	RankModel.selectedRoot = self._selectedRoot
	RankModel.selectedLeaf = self._selectedLeaf

	self._tableView:ReloadData()
	GlobalDispatcher:addListener(GlobalNotify.RankDataGet, self._updateRankList, self)
	self:_checkRankMo(self._initRoot, self._initLeaf)
	GlobalDispatcher:addListener(GlobalNotify.RankPlayRecord, self._onClickPlayRecord, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._reloadInfos, self)
end

function RankView:initTabData()
	self._tableViewDatas = {}
	self._viewParamDics = {}

	table.insert(self._tableViewDatas, {
		num = -2,
		reportBehavior = 200131,
		id = GameEnum.RankType.MaxPower
	})
	table.insert(self._tableViewDatas, {
		num = 0,
		reportBehavior = 0,
		id = GameEnum.RankType.AchievementRank
	})
	table.insert(self._tableViewDatas, {
		num = -5,
		reportBehavior = 0,
		id = GameEnum.RankType.FamilyTeamPlay
	})

	local kingSeasonId = KingArenaController.instance:getSeasonId()

	if kingSeasonId > 0 then
		self:setViewParamDics(GameEnum.RankType.KingArena, "王者竞技场")
		self:addViewParamDics(GameEnum.RankType.KingArena, "战皇榜", ViewName.KingArenaFightRankView)
		self:addViewParamDics(GameEnum.RankType.KingArena, "战皇次数榜", ViewName.KingArenaFightRankTimesView)
		self:addViewParamDics(GameEnum.RankType.KingArena, "精灵上阵榜", ViewName.KingArenaPetUpFmtRankView)
		self:addViewParamDics(GameEnum.RankType.KingArena, "精灵胜率榜", ViewName.KingArenaPetWinRankView)

		local kingArenaNum = self:getViewParamDicsCount(GameEnum.RankType.KingArena)

		table.insert(self._tableViewDatas, {
			reportBehavior = 0,
			id = GameEnum.RankType.KingArena,
			num = -kingArenaNum
		})
	end

	table.insert(self._tableViewDatas, {
		num = 0,
		reportBehavior = 200128,
		id = GameEnum.RankType.BreakFormation
	})

	self._wtCfgs = {}

	local wtowerProess = WTowerController.instance:getMainProgress()
	local unlockLeafLv = WTowerController.instance:getUnlockLeafMainTowerLevel()

	if unlockLeafLv <= wtowerProess then
		self._wtCfgs = WTowerConfig.instance:getDicCfgList()
	end

	printInfo("test 勇者之塔", wtowerProess, unlockLeafLv, unlockLeafLv <= wtowerProess, #self._wtCfgs)
	table.insert(self._tableViewDatas, {
		reportBehavior = 200129,
		id = GameEnum.RankType.WTower,
		num = -#self._wtCfgs
	})
	self:_insertHonourTowerTab()
	table.insert(self._tableViewDatas, {
		num = -4,
		reportBehavior = 200133,
		id = GameEnum.RankType.RankMatchClass
	})
	table.insert(self._tableViewDatas, {
		num = -4,
		reportBehavior = 200134,
		id = GameEnum.RankType.RankMatchLimit
	})
	table.insert(self._tableViewDatas, {
		num = -4,
		reportBehavior = 0,
		id = GameEnum.RankType.SendFlower_RANK
	})

	local firstPassCfgs = UltimateTrialController.instance:getCurActiveRankCfgs()

	if #firstPassCfgs > 0 then
		self:setViewParamDics(GameEnum.RankType.PetChallengeFirstPassRank, "精灵挑战榜")

		for _, cfg in ipairs(firstPassCfgs) do
			self:addViewParamDics(GameEnum.RankType.PetChallengeFirstPassRank, cfg.challengeName, ViewName.PetChallengeFirstPassRankView, {
				cfg.challengeActivityId
			})
		end

		table.insert(self._tableViewDatas, {
			reportBehavior = 0,
			id = GameEnum.RankType.PetChallengeFirstPassRank,
			num = -#firstPassCfgs
		})
	end

	local list = ShowOffRankConfig.instance:getShowOffRankTabList() or {}

	if #list > 0 then
		local tabName = ShowOffRankConfig.instance:getShowOffRankCommon("SHOW_OFF_TAB_NAME")

		self:setViewParamDics(GameEnum.RankType.ShowOffRank, tabName)

		for i, v in ipairs(list) do
			self:addViewParamDics(GameEnum.RankType.ShowOffRank, v.tabName, ViewName.ShowoffrankView, {
				v
			})
		end

		table.insert(self._tableViewDatas, {
			reportBehavior = 0,
			id = GameEnum.RankType.ShowOffRank,
			num = -#list
		})
	end

	self:setViewParamDics(GameEnum.RankType.ArenaCombine, "竞技场")
	self:addViewParamDics(GameEnum.RankType.ArenaCombine, "竞技场", ViewName.ArenarankView)
	self:addViewParamDics(GameEnum.RankType.ArenaCombine, "高级竞技场", ViewName.SeniorarenarankView)
	table.insert(self._tableViewDatas, {
		num = -2,
		reportBehavior = 0,
		id = GameEnum.RankType.ArenaCombine
	})
	table.sort(self._tableViewDatas, function(a, b)
		local sortIdxA = RankConfig.instance:getSortRankIndex(a.id)
		local sortIdxB = RankConfig.instance:getSortRankIndex(b.id)

		return sortIdxA < sortIdxB
	end)
end

function RankView:setViewParamDics(rankType, titleName)
	self._viewParamDics[rankType] = {}

	self:addViewParamDics(rankType, titleName)
end

function RankView:addViewParamDics(rankType, titleName, viewName, viewParamList)
	local param = {}

	param.titleName = titleName
	param.viewName = viewName
	param.viewParamList = viewParamList

	if self._viewParamDics[rankType][0] == nil then
		self._viewParamDics[rankType][0] = param
	else
		table.insert(self._viewParamDics[rankType], param)
	end
end

function RankView:getViewParamDicsCount(rankType)
	return (self._viewParamDics[rankType] or nil) and #self._viewParamDics[rankType]
end

function RankView:_initTxtTab()
	self.txtTab = {
		[GameEnum.RankType.BreakFormation] = "破阵战斗力",
		[GameEnum.RankType.WTower] = "通关时间",
		[GameEnum.RankType.Arena] = "守阵战斗力",
		[GameEnum.RankType.MaxPower] = "最高战斗力",
		[GameEnum.RankType.XiaoNuoBian] = "本周累积萌值",
		[GameEnum.RankType.RankMatchClass] = "",
		[GameEnum.RankType.RankMatchLimit] = "",
		[GameEnum.RankType.SeniorArena] = "",
		[GameEnum.RankType.FamilyTeamPlay] = "2星",
		[GameEnum.RankType.Charm_RANK] = "奖励",
		[GameEnum.RankType.SendFlower_RANK] = "奖励",
		[GameEnum.RankType.Mirror_Rank] = "通关时间",
		[GameEnum.RankType.FamilyHonor] = "2星",
		[GameEnum.RankType.AchievementRank] = "达成成就时间",
		[GameEnum.RankType.GloryTowerRank] = "达成时间"
	}
	self.txtTab2 = {
		[GameEnum.RankType.BreakFormation] = "",
		[GameEnum.RankType.WTower] = "挑战进度",
		[GameEnum.RankType.Arena] = "守阵",
		[GameEnum.RankType.MaxPower] = "",
		[GameEnum.RankType.XiaoNuoBian] = "",
		[GameEnum.RankType.RankMatchClass] = "积分",
		[GameEnum.RankType.RankMatchLimit] = "积分",
		[GameEnum.RankType.SeniorArena] = "守阵",
		[GameEnum.RankType.FamilyTeamPlay] = "1星",
		[GameEnum.RankType.Charm_RANK] = "",
		[GameEnum.RankType.SendFlower_RANK] = "",
		[GameEnum.RankType.FamilyHonor] = "1星",
		[GameEnum.RankType.AchievementRank] = "成就点数",
		[GameEnum.RankType.GloryTowerRank] = "奖励"
	}
	self.txtTabName = {
		[GameEnum.RankType.BreakFormation] = "奥奇名称",
		[GameEnum.RankType.WTower] = "奥奇名称",
		[GameEnum.RankType.Arena] = "奥奇名称",
		[GameEnum.RankType.MaxPower] = "奥奇名称",
		[GameEnum.RankType.XiaoNuoBian] = "奥奇名称",
		[GameEnum.RankType.RankMatchClass] = "奥奇名称",
		[GameEnum.RankType.RankMatchLimit] = "奥奇名称",
		[GameEnum.RankType.SeniorArena] = "奥奇名称",
		[GameEnum.RankType.FamilyTeamPlay] = "家族名称",
		[GameEnum.RankType.Charm_RANK] = "奥奇名称",
		[GameEnum.RankType.SendFlower_RANK] = "奥奇名称",
		[GameEnum.RankType.Mirror_Rank] = "奥奇名称",
		[GameEnum.RankType.FamilyHonor] = "家族",
		[GameEnum.RankType.AchievementRank] = "奥奇名称",
		[GameEnum.RankType.GloryTowerRank] = "奥奇名称"
	}
	self.txtTabFamily = {
		[GameEnum.RankType.BreakFormation] = "家族",
		[GameEnum.RankType.WTower] = "家族",
		[GameEnum.RankType.Arena] = "家族",
		[GameEnum.RankType.MaxPower] = "家族",
		[GameEnum.RankType.XiaoNuoBian] = "家族",
		[GameEnum.RankType.RankMatchClass] = "家族",
		[GameEnum.RankType.RankMatchLimit] = "家族",
		[GameEnum.RankType.SeniorArena] = "积分",
		[GameEnum.RankType.FamilyTeamPlay] = {
			"区服1",
			"区服2",
			"区服3",
			"区服4",
			"3星"
		},
		[GameEnum.RankType.Charm_RANK] = "魅力值",
		[GameEnum.RankType.SendFlower_RANK] = "送花数",
		[GameEnum.RankType.Mirror_Rank] = "层数",
		[GameEnum.RankType.FamilyHonor] = "3星",
		[GameEnum.RankType.AchievementRank] = "家族",
		[GameEnum.RankType.GloryTowerRank] = "所用回合数"
	}
end

function RankView:onEnterFinished()
	RankView.super.onEnterFinished(self)
end

function RankView:onExit()
	RankView.super.onExit(self)
	self:_onClearTabAt()

	for i = 1, #self._tableViewDatas do
		self._tableViewDatas[i].num = -math.abs(self._tableViewDatas[i].num)
	end

	self._selectedLeaf = nil
	self._selectedRoot = nil
	self._initRoot = nil
	self._initLeaf = nil

	RankModel.instance:onReset()
	GlobalDispatcher:removeListener(ArenaAgent.GetMyZoneInRes, self._getMyZoneInRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.RankPlayRecord, self._onClickPlayRecord, self)
	GlobalDispatcher:removeListener(GlobalNotify.RankDataGet, self._updateRankList, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._reloadInfos, self)
end

function RankView:_reloadInfos()
	FloatWordMgr.instance:show("界面数据已经刷新")
	RankModel.instance:clearDataInit()
	self:_checkRankMo(self._selectedRoot, self._selectedLeaf)
end

function RankView:onExitFinished()
	RankView.super.onExitFinished(self)
end

function RankView:getRootAndLeaf(index)
	local root = 1

	while root <= #self._tableViewDatas do
		local leafNums = math.max(0, self._tableViewDatas[root].num)

		if leafNums < index then
			index = index - leafNums - 1
			root = root + 1
		else
			return self._tableViewDatas[root].id, index
		end
	end

	return self._tableViewDatas[root].id, 0
end

function RankView:_rankNumInView()
	return math.max(0, #self._rankViewDatas)
end

function RankView:_rankCellSize()
	return 1027, 110
end

function RankView:_rankCellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._rankCell)
	cell.index = index

	self:_updateRankCell(view, cell)

	return cell
end

function RankView:_updateRankCell(view, cell)
	local idx = cell.index
	local component = RankItem.AddOnce(cell.gameObject)
	local data = self._rankViewDatas[idx + 1]

	if self._selectedRoot == GameEnum.RankType.SeniorArena then
		component:updateSeniorArena(data)
	elseif self._selectedRoot == GameEnum.RankType.FamilyTeamPlay then
		component:updateFamilyTeamPlay(data, self._selectedLeaf)
	elseif self._selectedRoot == GameEnum.RankType.SendFlower_RANK then
		component:updateSendFlower(data, self._selectedLeaf)
	elseif self._selectedRoot == GameEnum.RankType.Charm_RANK then
		component:updateCharm(data)
	elseif self._selectedRoot == GameEnum.RankType.Mirror_Rank then
		component:onSetMo(data, nil, GameEnum.RankType.Mirror_Rank)
	elseif self._selectedRoot == GameEnum.RankType.FamilyHonor then
		component:updateFamilyHonor(data)
	elseif self._selectedRoot == GameEnum.RankType.AchievementRank then
		component:updateAchievementRank(data)
	elseif self._selectedRoot == GameEnum.RankType.GloryTowerRank then
		component:updateGloryTowerRank(data, self._selectedLeaf)
	else
		component:onSetMo(data, nil, self._selectedRoot)
	end

	return cell
end

function RankView:_numInView()
	local num = 0

	for _, v in ipairs(self._tableViewDatas) do
		num = num + 1

		if v.num > 0 then
			num = num + v.num
		end
	end

	return num
end

function RankView:_cellSize(view, index)
	local root, leaf = self:getRootAndLeaf(index)
	local realIndex = self:getRealIndex(root)

	if realIndex > #self._tableViewDatas then
		return 0, 0
	else
		return 212, leaf == 0 and 85 or 63
	end
end

function RankView:_cellAtIndex(view, idx)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)
	cell.index = idx

	self:_updateCell(view, cell)

	return cell
end

function RankView:_updateCell(view, cell)
	local idx = cell.index
	local rootCell = goutil.findChild(cell.gameObject, "rootCell")
	local leafCell = goutil.findChild(cell.gameObject, "leafCell")
	local root, leaf = self:getRootAndLeaf(idx)
	local isRoot = leaf == 0

	goutil.setActive(rootCell, isRoot)
	goutil.setActive(leafCell, not isRoot)

	local go = isRoot and rootCell or leafCell
	local imgSelected = goutil.findChild(go, "imgSelected")
	local txtName = goutil.findChildComponent(go, "txtName", "Text")
	local txtColorChange = txtName:GetComponent("UITextColorChange")

	txtName.text = self:getCellName(root, leaf)

	Framework.ButtonAdapter.Get(go):AddClickListener(function()
		self:_onClickTableCell(root, leaf)
	end)

	local selected = false

	if isRoot then
		selected = self._selectedRoot == root

		local outline = goutil.findChild(go, "txtName"):GetComponent("Outline")

		if outline then
			outline.effectColor = selected and parsecolor("#2e91d0") or parsecolor("#ebeff2")
		end
	else
		selected = self._selectedRoot == root and self._selectedLeaf == leaf
	end

	txtColorChange:SetState(selected and 0 or 1)
	goutil.setActive(imgSelected, selected)
end

function RankView:_onReloadFinish()
	local curShowCellId = 0

	for i, data in ipairs(self._tableViewDatas) do
		if data.id == self._selectedRoot then
			if self._selectedLeaf <= 0 then
				self._tableView:MoveCellInView(curShowCellId, false)

				return
			else
				self._tableView:MoveCellInView(curShowCellId + self._selectedLeaf, false)

				return
			end
		else
			curShowCellId = curShowCellId + 1
		end
	end

	self._tableView:MoveCellInView(0, false)
end

function RankView:_onClickTableCell(root, leaf)
	local realIndex = false

	realIndex = self:getRealIndex(root)

	if self._not_open_arean_str then
		local tabData = self._tableViewDatas[realIndex]

		if tabData and tabData.id == GameEnum.RankType.Arena then
			FloatWordMgr.instance:show(self._not_open_arean_str)

			return
		end
	end

	local preRoot = self._selectedRoot

	self._selectedRoot = root
	self._selectedLeaf = leaf

	if leaf == 0 then
		if preRoot ~= self._selectedRoot then
			local preIdx = self:getRealIndex(preRoot)

			if preIdx then
				self._tableViewDatas[preIdx].num = -math.abs(self._tableViewDatas[preIdx].num)
			end
		end

		self._tableViewDatas[realIndex].num = -self._tableViewDatas[realIndex].num

		if self._tableViewDatas[realIndex].num > 0 then
			self._selectedLeaf = 1
		end
	end

	RankModel.selectedRoot = self._selectedRoot
	RankModel.selectedLeaf = self._selectedLeaf

	self._tableView:ReloadData()

	realIndex = realIndex or self:getRealIndex(root)

	self:_checkRankMo(self._selectedRoot, self._selectedLeaf)
	SurveyController.instance:reportBehavior(self._tableViewDatas[realIndex].reportBehavior)
end

function RankView:getCellName(root, leaf)
	if root == GameEnum.RankType.BreakFormation then
		if leaf == 0 then
			return "破阵天下"
		elseif leaf == 1 then
			return "普通"
		elseif leaf == 2 then
			return "困难"
		elseif leaf == 3 then
			return "噩梦"
		end
	elseif root == GameEnum.RankType.WTower then
		if leaf == 0 then
			return "勇者之塔"
		elseif leaf > 0 then
			local wtCfg = self._wtCfgs[leaf]

			if wtCfg then
				return wtCfg.desc
			end
		end
	elseif root == GameEnum.RankType.Arena then
		if leaf == 0 then
			return "竞技场"
		else
			return ArenaModel.instance:getZoneName(leaf + 1)
		end
	elseif root == GameEnum.RankType.MaxPower then
		if leaf == 0 then
			return "战力排行"
		elseif leaf == 1 then
			return "本服战力"
		elseif leaf == 2 then
			return "世界战力"
		end
	elseif root == GameEnum.RankType.XiaoNuoBian then
		if leaf == 0 then
			return "小诺变变变"
		end
	elseif root == GameEnum.RankType.RankMatchClass then
		if leaf == 0 then
			return "经典排位赛"
		elseif leaf == 1 then
			return "全服传说榜"
		elseif leaf == 2 then
			return "本服传说榜"
		elseif leaf == 3 then
			return "精灵胜率榜"
		elseif leaf == 4 then
			return "精灵出场榜"
		end
	elseif root == GameEnum.RankType.RankMatchLimit then
		if leaf == 0 then
			return "极限排位赛"
		elseif leaf == 1 then
			return "全服传说榜"
		elseif leaf == 2 then
			return "本服传说榜"
		elseif leaf == 3 then
			return "精灵胜率榜"
		elseif leaf == 4 then
			return "精灵出场榜"
		end
	elseif root == GameEnum.RankType.SeniorArena then
		return "高阶竞技场"
	elseif root == GameEnum.RankType.FamilyTeamPlay then
		if leaf == 0 then
			return "家族排行"
		elseif leaf == 1 then
			return "赛季积分"
		elseif leaf == 2 then
			return "战区家族战"
		elseif leaf == 3 then
			return "全服家族战"
		elseif leaf == 4 then
			return "家族围剿"
		elseif leaf == 5 then
			return "家族荣誉榜"
		end
	elseif root == GameEnum.RankType.SendFlower_RANK then
		if leaf == 0 then
			return "魅力花榜"
		elseif leaf == 1 then
			return "男神榜"
		elseif leaf == 2 then
			return "女神榜"
		elseif leaf == 3 then
			return "魅力榜"
		elseif leaf == 4 then
			return "送花榜"
		end
	elseif root == GameEnum.RankType.Mirror_Rank then
		return "镜像英雄榜"
	elseif root == GameEnum.RankType.FamilyHonor then
		return "家族荣誉"
	elseif root == GameEnum.RankType.AchievementRank then
		return "成就排行榜"
	elseif root == GameEnum.RankType.GloryTowerRank then
		if leaf > 0 then
			local challengeId = HonourTowerController.instance:getChallengeIdByRankTabIdx(leaf)
			local cfg = HonourTowerConfig.instance:getChallengeCfg(challengeId)

			return cfg.name
		else
			return "荣耀塔"
		end
	elseif self._viewParamDics[root] then
		local viewParam = self._viewParamDics[root][leaf]

		if viewParam then
			return viewParam.titleName
		end
	end

	return "未知"
end

function RankView:_checkRankMo(root, leaf)
	self:_updateRankList()

	if not RankModel.instance:getIsDataInit(root, leaf) then
		RankModel.instance:sendReqRankData(root, leaf)
	end
end

function RankView:_updateRankList()
	local root = self._selectedRoot
	local leaf = self._selectedLeaf

	if self._viewParamDics[root] then
		local viewParam = self._viewParamDics[root][leaf]
		local isNeedShow = viewParam ~= nil

		GameUtil.SetActive(self._right, not isNeedShow)
		GameUtil.SetActive(self._childViewRoot, isNeedShow)
		GameUtil.SetActive(self._childViewEmpty, false)

		if isNeedShow then
			if not string.nilorempty(viewParam.viewName) then
				self:_showTabAt(root, leaf, viewParam.viewName, viewParam.viewParamList)
			end

			return
		end

		local rankMo = RankModel.instance:getRankMo(self._selectedRoot, self._selectedLeaf)

		if (self._selectedRoot == GameEnum.RankType.RankMatchClass or self._selectedRoot == GameEnum.RankType.RankMatchLimit) and self._selectedLeaf == 0 then
			rankMo = RankModel.instance:getRankMo(self._selectedRoot, 1)
		end

		local rankList = {}

		if rankMo ~= nil then
			rankList = rankMo.rankList or rankMo.rankInfo or rankMo.rankInfos or rankMo.rank or rankMo.infoList or rankMo.rankItems
		end

		rankList = rankList or {}
		rankMo = rankMo or {}

		goutil.setActive(self._goEmpty, #rankList == 0)
		goutil.setActive(self._goDescription, #rankList > 0)
		goutil.setActive(self._goRightBg, #rankList > 0)
		goutil.setActive(self._goZoneTip, self._selectedRoot == GameEnum.RankType.Arena)

		self._rankViewDatas = rankList

		self._rankListView:ReloadData()
		goutil.setActive(self._txtMyRank.gameObject, true)
		goutil.setActive(self._txtMyRankTitle.gameObject, true)
		self:_setMyRank(rankMo)

		if self._selectedRoot == GameEnum.RankType.RankMatchClass or self._selectedRoot == GameEnum.RankType.RankMatchLimit then
			if not self._txtTips[self._selectedRoot][self._selectedLeaf] then
				self._txtMyRankTip.text = ""
			end
		elseif self._selectedRoot == GameEnum.RankType.MaxPower then
			if not self._txtTips[self._selectedRoot][self._selectedLeaf <= 1 and 1 or 2] then
				self._txtMyRankTip.text = ""
			end
		elseif not self._txtTips[self._selectedRoot] then
			self._txtMyRankTip.text = ""
		end

		self._txtAttribute.text = self._selectedRoot == GameEnum.RankType.BreakFormation and lang("              赛季累计评分") or self.txtTab[self._selectedRoot]

		Framework.TransformUtil.SetAnchoredPos(self._txtFamily.transform, 42, 1)
		Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 278, 1)
		Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 466, 1)
		Framework.TransformUtil.SetAnchoredPos(self._txtWin.transform, 220, 1)

		self._txtRecord.text = self.txtTab2[self._selectedRoot]

		Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 466, 1)

		if self._selectedRoot == GameEnum.RankType.FamilyTeamPlay then
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 224, 2)
		elseif self._selectedRoot == GameEnum.RankType.SendFlower_RANK then
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 190, 2)
		elseif self._selectedRoot == GameEnum.RankType.Charm_RANK then
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 190, 2)

			local time, timeTotal = SendFlowerModel.instance:getTimesOfSupport()

			self._txtRecord.text = langPara("鼎力支持%s/%s", checkint(time), checkint(timeTotal))

			Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 455, 1)
		elseif (self._selectedRoot == GameEnum.RankType.RankMatchClass or self._selectedRoot == GameEnum.RankType.RankMatchLimit) and self._selectedLeaf ~= 1 and self._selectedLeaf ~= 2 then
			self._txtRecord.text = ""
		else
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 278, 2)
		end

		self._txtWin.gameObject:SetActive(false)
		self._txtWinRate.gameObject:SetActive(false)

		if self._selectedRoot == GameEnum.RankType.RankMatchClass or self._selectedRoot == GameEnum.RankType.RankMatchLimit then
			self._txtWin.gameObject:SetActive(true)
			self._txtWinRate.gameObject:SetActive(true)

			if self._selectedLeaf == 1 or self._selectedLeaf == 0 then
				self._txtHistory.gameObject:SetActive(true)

				if rankMo then
					self._txtHistoryNum.text = rankMo.legendTimes or ""
				end
			end
		elseif self._selectedRoot == GameEnum.RankType.Arena then
			local zoneId = ArenaModel.instance:getZoneId()

			self._txtZoneTip.text = ArenaModel.instance:getZoneName(zoneId)

			GameUtil.SetActive(self._txtHistory, false)
		else
			self._txtHistory.gameObject:SetActive(false)
		end

		self._txtName.text = self.txtTabName[self._selectedRoot]

		if type(self.txtTabFamily[self._selectedRoot]) == "string" then
			self._txtFamily.text = self.txtTabFamily[self._selectedRoot] or self.txtTabFamily[self._selectedRoot][self._selectedLeaf]
		end

		if self._selectedLeaf > 2 and (self._selectedRoot == 6 or self._selectedRoot == 7) then
			goutil.setActive(self._txtMyRank.gameObject, false)
			goutil.setActive(self._txtMyRankTitle.gameObject, false)

			self._txtFamily.text = "出场数"
		else
			self._txtMyRankTitle.text = self._selectedRoot == GameEnum.RankType.FamilyTeamPlay and "家族排名" or "我的排名"
		end

		if self._selectedRoot == GameEnum.RankType.GloryTowerRank then
			Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 410, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 164, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtFamily.transform, -35, 1)
		end

		if self._selectedRoot == GameEnum.RankType.SendFlower_RANK then
			if self._selectedLeaf == 1 then
				self._txtFamily.text = "收到绝世流星鲜花"
			elseif self._selectedLeaf == 2 then
				self._txtFamily.text = "收到倾世玫瑰鲜花"
			end

			if self._selectedLeaf == 1 or self._selectedLeaf == 2 then
				self._txtAttribute.text = "上榜时间"
			end

			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 360, 1)
		end

		if self._selectedRoot == GameEnum.RankType.FamilyHonor then
			GameUtil.SetActive(self._txtRecord, true)
			GameUtil.SetActive(self._txtWin, true)

			self._txtWin.text = "荣誉值"

			Framework.TransformUtil.SetAnchoredPos(self._txtName.transform, -228, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtFamily.transform, -50, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 110, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 250, 1)
			Framework.TransformUtil.SetAnchoredPos(self._txtWin.transform, 400, 1)
		end

		if self._selectedRoot == GameEnum.RankType.FamilyTeamPlay then
			self:_setMyFamilyRank(rankMo)
			GameUtil.SetActive(self._txtWin, true)
			Framework.TransformUtil.SetAnchoredPos(self._txtWin.transform, 400, 1)

			if self._selectedLeaf == 1 or self._selectedLeaf == 2 or self._selectedLeaf == 3 or self._selectedLeaf == 4 then
				self._txtWin.text = "积分"
				self._txtAttribute.text = ""
				self._txtRecord.text = ""
			elseif self._selectedLeaf == 5 then
				GameUtil.SetActive(self._txtRecord, true)

				self._txtWin.text = "荣誉值"

				Framework.TransformUtil.SetAnchoredPos(self._txtName.transform, -228, 1)
				Framework.TransformUtil.SetAnchoredPos(self._txtFamily.transform, -50, 1)
				Framework.TransformUtil.SetAnchoredPos(self._txtAttribute.transform, 110, 1)
				Framework.TransformUtil.SetAnchoredPos(self._txtRecord.transform, 250, 1)
				Framework.TransformUtil.SetAnchoredPos(self._txtWin.transform, 400, 1)
			end
		end
	end
end

function RankView:_setMyRank(rankMo)
	self._txtMyRank.text = rankMo and checknumber(rankMo.myRank) > 0 and string.format("%d", rankMo.myRank) or "未上榜"
end

function RankView:_setMyFamilyRank(rankMo)
	if rankMo then
		if checknumber(rankMo.myFamilyRank) > 0 then
			self._txtMyRank.text = string.format("%d", rankMo.myFamilyRank)

			return
		elseif checknumber(rankMo.myRank) > 0 then
			self._txtMyRank.text = string.format("%d", rankMo.myRank)

			return
		end
	end

	self._txtMyRank.text = "未上榜"
end

function RankView:_onClickClose()
	self:close()
end

function RankView:_onClickPlayRecord(rank)
	if self._selectedRoot == GameEnum.RankType.BreakFormation then
		-- block empty
	end
end

function RankView:_onClickHome()
	UIStateManager.instance:clear(true)
end

function RankView:_setTipTxt(root, content)
	self._txtTips[root] = content
end

function RankView:_insertHonourTowerTab()
	local periodId = HonourTowerModel.instance:getPeriodId()

	if periodId <= 0 then
		return
	end

	local cfgs = HonourTowerConfig.instance:getChallengeCfgs(periodId)
	local count = #cfgs

	if count <= 0 then
		return
	end
end

function RankView:_showTabAt(root, leaf, viewName, viewParamList)
	if self._oldRoot == root and self._oldLeaf == leaf then
		return
	end

	self:_onClearTabAt()

	self._oldRoot = root
	self._oldLeaf = leaf

	if viewParamList and #viewParamList > 0 then
		self:showTabAt(self._childViewRoot, viewName, unpack(viewParamList))
	else
		self:showTabAt(self._childViewRoot, viewName)
	end
end

function RankView:_onClearTabAt()
	self:showTabAt(self._childViewRoot, "")

	self._oldRoot = nil
	self._oldLeaf = nil
end

return RankView
