-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossMainDlg.lua

local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local ResWorldBossAchieve = require("ClientData/ResWorldBossAchieve")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local strClassName = "WorldBossMainDlg"
local WorldBossMainDlg = Class(strClassName, UIControls.Window)

MixinClass(WorldBossMainDlg, ActivityPanelMixin)

function WorldBossMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnRank = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnRank")

	self.btnRank:addEventClick(self.onBtnRankClick)

	self.btnAward = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnAward")

	self.btnAward:addEventClick(self.onBtnAwardClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.btnNotice = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnNotice")

	self.btnNotice:addEventClick(self.onBtnNoticeClick)

	self.btnBattle = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.btnReplay = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnReplay")

	self.btnReplay:addEventClick(self.onBtnReplayClick)

	self.btnHelp = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle/BtnHelp")

	self.btnHelp:addEventClick(self.onBtnHelpClick)

	self.redHintBattle = UIControls.RedDot(self, "MainInfoPanel/InfoPanel/BtnBattle/IconNew")

	self.redHintBattle:addHint({
		UIConst.RD_HINT_WORLDBOSS_CHALLENGE
	})

	self.txtDesc = UIControls.Label(self, "MainInfoPanel/InfoPanel/BossInfo/TextDes")
	self.txtPoint = UIControls.Label(self, "MainInfoPanel/InfoPanel/SelfInfo/TextPoint")
	self.txtLeftTimes = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnBattle/TextNum")
	self.txtTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.txtPointTitle = UIControls.Label(self, "MainInfoPanel/InfoPanel/SelfInfo/TextPointTitle")
	self.txtUpInfo = UIControls.Label(self, "MainInfoPanel/InfoPanel/UpInfoPanel/Content/TextUp")
	self.panelUpInfo = UIControls.Panel(self, "MainInfoPanel/InfoPanel/UpInfoPanel")
	self.imgLv = UIControls.Image(self, "MainInfoPanel/InfoPanel/BossInfo/IconLv")
	self.imgName = UIControls.Image(self, "MainInfoPanel/InfoPanel/BossInfo/ImgName")
	self.imgUpBg = UIControls.Image(self, "MainInfoPanel/InfoPanel/UpInfoPanel/Bg")
	self.rawImageBg = UIControls.RawImage(self, "BgImage")
	self.slider = UIControls.Slider(self, "MainInfoPanel/InfoPanel/SelfInfo/Slider")
	self.skillCells = {}

	for i = 1, 4 do
		local skillGrid = UIControls.HeroSkillGridChild(self, "MainInfoPanel/InfoPanel/BossInfo/SkillPanel", "System/Hero/GridHeroSkill", 0, 0, true)

		table.insert(self.skillCells, skillGrid)
	end

	self.rankUIData = {}

	local uiNames = {
		"/IconRankLv",
		"/IconRankLv/BgRankLv",
		"/IconRankLv/BgRankLvS",
		"/IconRankLv/IconRankLvS"
	}
	local path = "MainInfoPanel/InfoPanel/SelfInfo"

	for i, name in ipairs(uiNames) do
		self.rankUIData[i] = UIControls.Image(self, path .. name)
	end

	self.imgPriVilege = UIControls.Image(self, "MainInfoPanel/ImgPrivilege")
	self.panelUpInfo1 = UIControls.Panel(self, "MainInfoPanel/InfoPanel/UpInfoPanel1")
	self.txtUpInfo1 = UIControls.Label(self, "MainInfoPanel/InfoPanel/UpInfoPanel1/Content/TextUp")
	self.panelUpInfo2 = UIControls.Panel(self, "MainInfoPanel/InfoPanel/UpInfoPanel2")
	self.panelUpInfoEmpty1 = UIControls.Panel(self, "MainInfoPanel/InfoPanel/PanelEmpty1")
	self.panelUpInfoEmpty2 = UIControls.Panel(self, "MainInfoPanel/InfoPanel/PanelEmpty2")
	self.txtUpInfo2 = UIControls.Label(self, "MainInfoPanel/InfoPanel/UpInfoPanel2/Content/TextUp")
	self.btnEliteBattle = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle1")

	self.btnEliteBattle:addEventClick(self.onBtnEliteBattleClick)

	self.btnEliteHelp = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle1/BtnHelp")

	self.btnEliteHelp:addEventClick(self.onBtnEliteHelpClick)

	self.redHintEliteBattle = UIControls.RedDot(self, "MainInfoPanel/InfoPanel/BtnBattle1/IconNew")

	self.redHintEliteBattle:addHint({
		UIConst.RD_HINT_ELITE_WORLDBOSS_CHALLENGE
	})

	self.txtLeftTimes1 = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnBattle1/TextNum")
	self.txtEliteLeftTimes = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnBattle1/TextNum1")
end

function WorldBossMainDlg:_setData(...)
	self:show()
	self:checkGetAward()
end

function WorldBossMainDlg:onOpen(...)
	WorldBossMainDlg.super.onOpen(self)
	self:checkRefresh()
	self:checkBossChange()
	self:checkFirstOpenElite()
	CurAvatar:checkGameAssistant(Const.GAME_ASSISTANT_TRIGGER_TYPE.WorldBossChange, {
		arg = self.curShowBossId
	}, true)
end

function WorldBossMainDlg:checkFirstOpenElite()
	if self:isEliteMode() and WorldBossCommon.getworldBossEliteOpen() == 0 then
		UIManager.getUI("WorldBossEliteUnlockDlg", true)
		WorldBossCommon.setworldBossEliteOpen(1)
	end
end

function WorldBossMainDlg:checkRefresh(...)
	if CurAvatar.needRefreshWorldBoss == true then
		local actId = WorldBossCommon.getCurBossActId(...)

		if actId then
			local actObj = CurAvatar:getActivityObj(actId)

			if actObj then
				RPC.opActivityData("kOpActivitySyncMgrData", 0, actObj.opId)
			end
		end
	end
end

function WorldBossMainDlg:checkBossChange(...)
	self.bossInfo = WorldBossCommon.getCurBossInfo()

	if self:isInShow() and (self.curShowBossId == nil or self.curShowBossId ~= self.bossInfo.type) then
		if self.loadLive2D ~= nil then
			self.loadLive2D:destroy()
		end

		self.loadLive2D = UIControls.Child(self, "MainInfoPanel/Live2DPanel", "System/WorldBoss/WorldBossCell" .. self.bossInfo.type, 0, 0, true)
		self.curShowBossId = self.bossInfo.type
	end
end

function WorldBossMainDlg:show(...)
	self:refreshUI()
end

function WorldBossMainDlg:initData(...)
	if self:isShowEliteMode() then
		self.rawImageBg:setImage("NoAlpha/WorldBoss/BgTormentBoss" .. self.bossInfo.type)

		local leftTimes, total = WorldBossCommon.getLeftBattleTimes()

		self.txtLeftTimes1:setText(utils.format(Lang.get(102274), leftTimes, total))

		local eliteLeftTimes = WorldBossCommon.getLeftEliteBattleTimes()

		self.txtEliteLeftTimes:setText(utils.format(Lang.get(102275), eliteLeftTimes))
		self.btnEliteBattle:setVisible(eliteLeftTimes > 0)
		self.btnEliteBattle:setEnable(eliteLeftTimes > 0)
		self.btnBattle:setVisible(false)
		self.btnBattle:setEnable(false)
		self.panelUpInfo:setVisible(false)

		if self.bossInfo.up_desc then
			self.panelUpInfo1:setVisible(true)
			self.panelUpInfoEmpty1:setVisible(true)
			self.txtUpInfo1:setText(self.bossInfo.up_desc)
		else
			self.panelUpInfo1:setVisible(false)
			self.panelUpInfoEmpty1:setVisible(false)
		end

		if self.bossInfo.up_desc2 then
			self.panelUpInfo2:setVisible(true)
			self.panelUpInfoEmpty2:setVisible(true)
			self.txtUpInfo2:setText(self.bossInfo.up_desc2)
		else
			self.panelUpInfo2:setVisible(false)
			self.panelUpInfoEmpty2:setVisible(false)
		end
	else
		self.rawImageBg:setImage("NoAlpha/WorldBoss/BgWorldBoss" .. self.bossInfo.type)

		local leftTimes, total = WorldBossCommon.getLeftBattleTimes()

		self.txtLeftTimes:setText(utils.format(Lang.get(30651), leftTimes, total))
		self.btnBattle:setVisible(true)
		self.btnBattle:setEnable(leftTimes > 0)
		self.btnEliteBattle:setVisible(false)
		self.btnEliteBattle:setEnable(false)
		self.panelUpInfo1:setVisible(false)
		self.panelUpInfo2:setVisible(false)
		self.panelUpInfoEmpty1:setVisible(false)
		self.panelUpInfoEmpty2:setVisible(false)

		if self.bossInfo.up_desc then
			self.panelUpInfo:setVisible(true)

			if WorldBossCommon.isAwardUp(self.bossInfo.type) then
				self.imgUpBg:setImage("Atlas/WorldBossAtlas/WorldBossAtlas", "BgUpBack")
			else
				self.imgUpBg:setImage("Atlas/WorldBossAtlas/WorldBossAtlas", "BgUpBack1")
			end

			self.txtUpInfo:setText(self.bossInfo.up_desc)
		else
			self.panelUpInfo:setVisible(false)
		end
	end

	self:checkBossChange()
	self.imgName:setImage("Atlas/WorldBossAtlas/WorldBossAtlas", "TxtWorldBoss" .. self.bossInfo.type)
	self.txtDesc:setText(self.bossInfo.desc)

	local iconPath = WorldBossCommon.getDifficultIconPath(self.bossInfo.hard)

	self.imgLv:setImage(iconPath[1], iconPath[2])

	local battleInfo = WorldBossCommon.getCurBossBattleInfo()

	for i, cell in ipairs(self.skillCells) do
		if battleInfo[Const.SKILL_FIELD_LIST[i]] then
			cell:setObj(battleInfo[Const.SKILL_FIELD_LIST[i]], battleInfo)

			cell.gridPanel = UIConst.SKILL_PANEL_WORLD_BOSS

			cell:setVisible(true)
		else
			cell:setVisible(false)
		end
	end

	local replayId = "0"
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		replayId = actData:getReplayId()
	end

	if replayId == "0" then
		self.btnReplay:setVisible(false)
	else
		self.btnReplay:setVisible(true)
	end
end

function WorldBossMainDlg:refreshUI(...)
	self:initData()
	self:refreshTime()

	local rankInfo, preRankInfo, isOverMax = WorldBossCommon.getCurRankInfo()

	WorldBossCommon.setRankUI(self.rankUIData, preRankInfo)

	local preScore = preRankInfo.score

	if rankInfo == preRankInfo then
		preScore = 0
	end

	local ratio = (WorldBossCommon.getSumScore() - preScore) / (rankInfo.score - preScore)

	self.slider:setValue(ratio, 0)

	if isOverMax then
		self.txtPointTitle:setText(Lang.get(30806))
		self.txtPoint:setText(ClientUtils.getNumShortStr(WorldBossCommon.getSumScore()))
	else
		self.txtPointTitle:setText(Lang.get(30807))
		self.txtPoint:setText(ClientUtils.getNumShortStr(WorldBossCommon.getSumScore()) .. "/" .. ClientUtils.getNumShortStr(rankInfo.score))
	end

	local state, time = CurAvatar:checkPrivielgeMonthCardEffect()

	if state then
		self.imgPriVilege:setVisible(true)
	else
		self.imgPriVilege:setVisible(false)

		if time then
			CurAvatar:checkPrivilegeMonthCardLapseShow(time, Const.PRIVITY_KEY_WORLD_BOSS)
		end
	end
end

function WorldBossMainDlg:refreshTime(...)
	local leftTime = WorldBossCommon.getCurBossLeftTime()
	local callBack

	if leftTime > 0 then
		callBack = Slot(self.refreshTime, self)
	end

	local afterStr = Lang.get(48657)

	if WorldBossCommon.isInFrozenTime() then
		afterStr = Lang.get(48695)
	else
		leftTime = WorldBossCommon.getFrozenTime()
	end

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, afterStr, callBack, nil)
end

function WorldBossMainDlg:isShowEliteMode(...)
	local flag = false
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		flag = actData:checkShowEliteMode()
	end

	return flag
end

function WorldBossMainDlg:isEliteMode(...)
	local flag = false
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		flag = actData:checkEliteModeOpen()
	end

	return flag
end

function WorldBossMainDlg:checkGetAward(...)
	if ClientUtils.record.cachedWorldBossScore ~= nil then
		local infos = WorldBossCommon.getPartInfosByScoreBlock(ClientUtils.record.cachedWorldBossScore, WorldBossCommon.getSumScore())

		if #infos > 0 and WorldBossCommon.getSumScore() < infos[#infos].info.score then
			table.remove(infos, #infos)
		end

		if #infos > 0 then
			UIManager.getUI("worldBossPointAwardGetDlg", true):show(infos)

			ClientUtils.record.cachedWorldBossScore = nil
		end
	end
end

function WorldBossMainDlg:recoveryFromReplay(replayEnv)
	if replayEnv.isFromRankDlg == true then
		self:onBtnRankClick()
	end
end

function WorldBossMainDlg:onBtnHelpClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(67)
end

function WorldBossMainDlg:onBtnEliteHelpClick(...)
	UIManager.getUI("RuleWorldBossEliteTipsDlg", true):show()
end

function WorldBossMainDlg:onBtnCloseClick(...)
	self:setVisible(false)
	self:recoverManualReject()
end

function WorldBossMainDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(66)
end

function WorldBossMainDlg:onBtnRankClick(...)
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)
	local exArg

	if self:isEliteMode() then
		CurAvatar.rankWorldBossEliteMode = true
		exArg = 2
	end

	rankMainDlg:initByRankType(Const.RANK_TYPE_WORLDBOSS, exArg)
end

function WorldBossMainDlg:onBtnAwardClick(...)
	UIManager.getUI("worldBossAwardDlg", true):show()
end

function WorldBossMainDlg:onBtnStoreClick(...)
	UIManager.getUI("activityMallDlg", true):onShow(51, 210)
end

function WorldBossMainDlg:onBtnNoticeClick(...)
	UIManager.getUI("worldBossAnnounceDlg", true):show()
end

function WorldBossMainDlg:onBtnBattleClick(...)
	local leftTimes, total = WorldBossCommon.getLeftBattleTimes()

	if leftTimes <= 0 then
		MsgManager.notice(Lang.get(30808))

		return
	end

	if WorldBossCommon.isInFrozenTime() == true then
		MsgManager.clientNotice(276)

		return
	end

	local maxScore = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		maxScore = actData:getMaxScore()
	end

	ClientUtils.record.cachedWorldBossScore = WorldBossCommon.getSumScore()
	ClientUtils.record.cachedWorldBossMaxScore = maxScore

	local battleData = {}

	battleData.worldBossData = {}
	battleData.worldBossData.type = self.bossInfo.type
	battleData.worldBossData.layer = self.bossInfo.hard
	battleData.worldBossData.week_index = WorldBossCommon.getWeekIndex()
	battleData.worldBossData.checkQuickFightOpen = actData:checkQuickFightOpen()

	CurAvatar:enterFormation(self.bossInfo.pve_id, BattleConst.BATTLE_TYPE_WORLD_BOSS, battleData)
end

function WorldBossMainDlg:onBtnReplayClick(...)
	local replayId = "0"
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		replayId = actData:getReplayId()
	end

	local replayId2 = "0"

	if actData then
		replayId2 = actData:getReplayId2()
	end

	if replayId2 ~= "0" then
		CurAvatar.cachedReplayEliteMode = 1

		if replayId ~= "0" then
			RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_WORLD_BOSS)
		end

		RPC.pVEBattleReplay(replayId2, BattleConst.BATTLE_TYPE_WORLD_BOSS)
	elseif replayId ~= "0" then
		RPC.pVEBattleReplay(replayId, BattleConst.BATTLE_TYPE_WORLD_BOSS)
	end
end

function WorldBossMainDlg:onBtnEliteBattleClick(...)
	local leftTimes, total = WorldBossCommon.getLeftBattleTimes()

	if leftTimes <= 0 then
		MsgManager.notice(Lang.get(101579))

		return
	end

	local leftTimes1, total1 = WorldBossCommon.getLeftEliteBattleTimes()

	if leftTimes1 <= 0 then
		MsgManager.notice(Lang.get(101580))

		return
	end

	if WorldBossCommon.isInFrozenTime() == true then
		MsgManager.clientNotice(276)

		return
	end

	local maxScore = 0
	local eliteMaxScore = 0
	local actData = CurAvatar:getWorldBossActData()

	if actData then
		maxScore = actData:getMaxScore()
		eliteMaxScore = actData:getEliteMaxScore()
	end

	ClientUtils.record.cachedWorldBossScore = WorldBossCommon.getSumScore()
	ClientUtils.record.cachedWorldBossMaxScore = maxScore
	ClientUtils.record.cachedEliteWorldBossMaxScore = eliteMaxScore

	local battleData = {}

	battleData.worldBossData = {}
	battleData.worldBossData.eliteMode = true
	battleData.worldBossData.multiPveId = {
		self.bossInfo.pve_id,
		self.bossInfo.pve_id2
	}
	battleData.worldBossData.type = self.bossInfo.type
	battleData.worldBossData.layer = self.bossInfo.hard
	battleData.worldBossData.week_index = WorldBossCommon.getWeekIndex()
	battleData.worldBossData.checkQuickFightOpen = actData:checkQuickFightOpen()
	battleData.worldBossData.multiTeamsIndex = {
		Const.FORMATION_WORLD_BOSS[self.bossInfo.type],
		Const.FORMATION_WORLD_BOSS_MODE_TWO[self.bossInfo.type]
	}

	CurAvatar:enterFormation(self.bossInfo.pve_id, BattleConst.BATTLE_TYPE_WORLD_BOSS, battleData)
end

return WorldBossMainDlg
