-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonTowerInfoDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActTowerBuff = require("ClientData/ResOpActTowerBuff")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResOpActTowerBossAward = require("ClientData/ResOpActTowerBossAward")
local strClassName = "ActivitySeasonTowerBuffViewPanel"
local ActivitySeasonTowerBuffViewPanel = Class(strClassName, UIControls.Panel)

function ActivitySeasonTowerBuffViewPanel:ctor()
	self.btnCloseBuff = UIControls.Button(self, self.mPath .. "/BtnClose")

	self.btnCloseBuff:addEventClick(self.onCloseBuffClick)

	self.buffCells = {}
	self.txtRule = UIControls.Label(self, self.mPath .. "/TxtRule")
end

function ActivitySeasonTowerBuffViewPanel:onCloseBuffClick()
	self:setVisible(false)
end

function ActivitySeasonTowerBuffViewPanel:setData(levelData, master, chooseBuff)
	local buffs = levelData.buff

	for index = #self.buffCells, #buffs - 1 do
		local newCell = UIControls.BuffGridChild(self, self.mPath .. "/GridBuffPanel", "System/Common/Grid/GridBuff")

		table.insert(self.buffCells, newCell)
	end

	for index, cell in ipairs(self.buffCells) do
		if buffs[index] then
			cell:setVisible(true)
			cell:setBuff(ResOpActTowerBuff[buffs[index].id])

			if chooseBuff and chooseBuff > 0 and buffs[index].id ~= chooseBuff then
				cell.btnSensor:setObjGray(true)
			else
				cell.btnSensor:setObjGray(false)
			end
		else
			cell:setVisible(false)
		end
	end

	if levelData.buff_transe == 1 then
		self.txtRule:setText(ResClientNotice[338].notice)
	else
		self.txtRule:setText(ResClientNotice[335].notice)
	end

	self:setVisible(true)
end

local strClassName = "ActivitySeasonTowerLevelCell"
local ActivitySeasonTowerLevelCell = Class(strClassName, UIControls.Child)

function ActivitySeasonTowerLevelCell:ctor()
	self.textLevel = UIControls.Label(self, "StatePanel/LvPanel/BgLv/TxtLv")
	self.panelFinish = UIControls.Panel(self, "StatePanel/LvPanel/ImgFinish")
	self.imgGame = UIControls.RawImage(self, "StatePanel/LvPanel/ImgGame")
	self.panelLock = UIControls.Panel(self, "StatePanel/LockPanel")
	self.btnFirstName = UIControls.Button(self, "StatePanel/LvPanel/BtnFirstPlayer")

	self.btnFirstName:addEventClick(self.onFirstNameClick)

	self.masterHeadGrid = UIControls.PlayerHeadGridChild(self, "StatePanel/LvPanel/BtnFirstPlayer/InfoPanel/BgPlayer/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.textFirstName = UIControls.Label(self, "StatePanel/LvPanel/BtnFirstPlayer/InfoPanel/TextName")
	self.textFirstServer = UIControls.Label(self, "StatePanel/LvPanel/BtnFirstPlayer/InfoPanel/ImgServe")
	self.textFirstTime = UIControls.Label(self, "StatePanel/LvPanel/BtnFirstPlayer/InfoPanel/TextTime")
	self.btnNoneName = UIControls.Button(self, "StatePanel/LvPanel/BtnNonePlayer")

	self.btnNoneName:addEventClick(self.onNoneNameClick)

	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onSensorClick)

	self.stateAni = UIControls.Panel(self, "StatePanel")
	self.textTeam = UIControls.Label(self, "StatePanel/LvPanel/RulePanel/TxtRule")
	self.btnAward = UIControls.Button(self, "StatePanel/LvPanel/ImgSpecialAward")

	self.btnAward:addEventClick(self.onAwardClick)

	if UIControls.checkControlFunc(self, "StatePanel/LvPanel/CodePanel") then
		self.panelNmlScore = UIControls.Panel(self, "StatePanel/LvPanel/CodePanel")
		self.textAddScore = UIControls.Label(self, "StatePanel/LvPanel/CodePanel/TxtCodeNum")
		self.panelBossScore = UIControls.Panel(self, "StatePanel/LvPanel/CodeBossPanel")
		self.textBossScore = UIControls.Label(self, "StatePanel/LvPanel/CodeBossPanel/TxtCodeNum")
		self.textBossMaxScore = UIControls.Label(self, "StatePanel/LvPanel/CodeBossPanel/TxtCodeLimit")
		self.textBossLevel = UIControls.Label(self, "StatePanel/LvPanel/BgLv/TxtBoss")
	end
end

function ActivitySeasonTowerLevelCell:setData(pageIndex, levelData, passedLayer)
	self.pageIndex = pageIndex
	self.levelData = levelData
	self.passedLayer = passedLayer

	self.textLevel:setText(self.levelData.name or "")

	self.isLocked = levelData.layer > passedLayer + 1

	self.imgGame:setObjGray(self.isLocked)
	self.panelLock:setVisible(self.isLocked)
	self.panelFinish:setVisible(passedLayer >= levelData.layer)

	if levelData.bg_icon then
		self.imgGame:setImage("NoAlpha/SeasonTower/ImgLv/" .. levelData.bg_icon)
	end

	local keyStr = "0" .. levelData.tower_id

	if levelData.tower_id <= 6 then
		if self.levelData.mulity_pvp == 1 then
			self.textTeam:setText(Lang.get(30640))
		else
			self.textTeam:setText("")
		end
	else
		self.textTeam:setText("")

		keyStr = levelData.boss_id and "Boss" or "Mix"
	end

	if self.isLocked then
		self.stateAni:playStateAnimator("BtnTeam" .. keyStr .. "Dis")
	elseif passedLayer >= self.levelData.layer then
		self.stateAni:playStateAnimator("BtnTeam" .. keyStr .. "Nml")
	else
		self.stateAni:playStateAnimator("BtnTeam" .. keyStr .. "Sel")
	end

	if self.levelData.buff then
		self.master, self.chooseBuff = self.mParent.actObj.actData:getTowerBuffMaster(self.levelData.tower_id, self.levelData.layer)

		if self.master then
			self.masterHeadGrid:setVisible(true)
			self.masterHeadGrid:setPlayer(self.master, true, self)
			self.textFirstServer:setText(self.master.serverName)
			self.textFirstName:setText(self.master.name)
			self.btnNoneName:setVisible(false)
			self.btnFirstName:setVisible(true)

			if self.master.updateTick and self.master.updateTick > 0 then
				self.textFirstTime:setText(utils.getDeadlineStr(self.master.updateTick, nil, true))
			else
				self.textFirstTime:setText("")
			end
		else
			self.btnNoneName:setVisible(true)
			self.btnFirstName:setVisible(false)
		end
	else
		self.btnNoneName:setVisible(false)
		self.btnFirstName:setVisible(false)
	end

	self:setSelected(false)

	if passedLayer >= levelData.layer then
		if levelData.is_key == 1 then
			self.btnAward:setImage("Atlas/SeasonTowerAtlas/SeasonTowerCommonAtlas", "IconAwardHighOpen")
		else
			self.btnAward:setImage("Atlas/SeasonTowerAtlas/SeasonTowerCommonAtlas", "IconAwardNmlOpen")
		end
	elseif levelData.is_key == 1 then
		self.btnAward:setImage("Atlas/SeasonTowerAtlas/SeasonTowerCommonAtlas", "IconAwardHigh")
	else
		self.btnAward:setImage("Atlas/SeasonTowerAtlas/SeasonTowerCommonAtlas", "IconAwardNml")
	end

	if self.panelNmlScore then
		if levelData.boss_id then
			self.textBossLevel:setVisible(true)
			self.textBossLevel:setText(self.levelData.name or "")
			self.textLevel:setVisible(false)
			self.panelNmlScore:setVisible(false)
			self.panelBossScore:setVisible(true)

			local bossScoreData = ResOpActTowerBossAward[levelData.boss_id] or {}

			self.textBossScore:setText(self.mParent.actObj.actData:getBossMaxHp(levelData.tower_id, levelData.layer))
			self.textBossMaxScore:setText(bossScoreData.max_score or 0)
		else
			self.textBossLevel:setVisible(false)
			self.textLevel:setVisible(true)
			self.panelNmlScore:setVisible(true)
			self.panelBossScore:setVisible(false)
			self.textAddScore:setText(levelData.score or 0)
		end
	end
end

function ActivitySeasonTowerLevelCell:onAwardClick()
	self.mParent:onAwardClick(self.levelData)
end

function ActivitySeasonTowerLevelCell:onSensorClick()
	self.mParent:onCellClick(self)
end

function ActivitySeasonTowerLevelCell:onFirstNameClick()
	self.mParent:onShowOneLayerBuff(self.levelData, self.master, self.chooseBuff)
end

function ActivitySeasonTowerLevelCell:onNoneNameClick()
	self.mParent:onShowOneLayerBuff(self.levelData)
end

function ActivitySeasonTowerLevelCell:setSelected(isSelected)
	if isSelected then
		self.btnSensor:setEnable(false)
	else
		self.btnSensor:setEnable(true)
	end
end

local strClassName = "ActivitySeasonTowerInfoDlg"
local ActivitySeasonTowerInfoDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivitySeasonTowerInfoDlg, ActivityPanelMixin)

function ActivitySeasonTowerInfoDlg:initUI()
	self.textTowerTime = UIControls.Label(self, "MainInfoPanel/TxtTime")
	self.btnClose = UIControls.Button(self, "BtnClose", "IconArrow/Text")

	self.btnClose:addEventClick(self.onClickClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onTipsClick)

	self.btnRank = UIControls.Button(self, "MainInfoPanel/BtnRank")

	self.btnRank:addEventClick(self.onRankClick)

	self.btnBuff = UIControls.Button(self, "MainInfoPanel/BtnBuff")

	self.btnBuff:addEventClick(self.onBuffClick)

	self.panelBuffNew = UIControls.Panel(self, "MainInfoPanel/BtnBuff/IconNew")
	self.btnBuffMain = UIControls.Button(self, "MainInfoPanel/BtnBuffMain")

	self.btnBuffMain:addEventClick(self.onBuffMainClick)

	self.levelCells = {}
	self.bonusGrids = {}
	self.scrollPage = UIControls.ScrollView(self, "MainInfoPanel/LvPanel/LvMaskPanel/LvList")

	self.scrollPage:addScrollCorrectOnChanged(self.onCorrectEvent)

	self.btnBattle = UIControls.Button(self, "MainInfoPanel/FunPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onBattleClick)

	self.textEnergy = UIControls.Label(self, "MainInfoPanel/FunPanel/BtnBattle/DurabilityPanel/TextNum")
	self.btnEnergyTips = UIControls.Button(self, "MainInfoPanel/FunPanel/BtnBattle/BtnHelp")

	self.btnEnergyTips:addEventClick(self.onEnergyTipsClick)

	self.panelUnOpen = UIControls.Panel(self, "MainInfoPanel/FunPanel/ImgUnOpen")
	self.panelFinish = UIControls.Panel(self, "MainInfoPanel/FunPanel/ImgFinish")
	self.btnReplay = UIControls.Button(self, "MainInfoPanel/FunPanel/BtnReplay")

	self.btnReplay:addEventClick(self.onReplayClick)
	self.btnReplay:setVisible(true)

	self.textRuleTeam = UIControls.Label(self, "MainInfoPanel/RulePanel/TxtTeam")
	self.panelBuffChoose = ActivitySeasonTowerBuffViewPanel(self, "MainInfoPanel/BuffPanel")

	if UIControls.checkControlFunc(self, "MainInfoPanel/FunPanel/BtnRule") then
		self.btnShowRule = UIControls.Button(self, "MainInfoPanel/FunPanel/BtnRule")

		self.btnShowRule:addEventClick(self.onRuleClick)

		self.btnHideRule = UIControls.Button(self, "MainInfoPanel/RulePanel/Block")

		self.btnHideRule:addEventClick(self.onHideRuleClick)

		self.panelRule = UIControls.Panel(self, "MainInfoPanel/RulePanel")
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/CodeSlider") then
		self.sliderScore = UIControls.Slider(self, "MainInfoPanel/CodeSlider")
		self.panelScore = UIControls.Panel(self, "MainInfoPanel/CodeSlider/CodePanel")
		self.textNowScore = UIControls.Label(self, "MainInfoPanel/CodeSlider/CodePanel/TxtNumPlayer")
		self.textNextScore = UIControls.Label(self, "MainInfoPanel/CodeSlider/CodePanel/TxtNumTap")
		self.panelScoreMax = UIControls.Panel(self, "MainInfoPanel/CodeSlider/TxtHighest")
		self.imgNewScore = UIControls.Panel(self, "MainInfoPanel/CodeSlider/IconCode/IconNew")
		self.btnNewScore = UIControls.Button(self, "MainInfoPanel/CodeSlider/IconCode")

		self.btnNewScore:addEventClick(self.onNewScoreClick)
	end
end

function ActivitySeasonTowerInfoDlg:onNewScoreClick()
	UIManager.getUI("activityNoLimitScoreAwardDlg", true):onShowActivity({
		self.actObj.clientTemplateData,
		self.actObj
	})
end

function ActivitySeasonTowerInfoDlg:onRuleClick()
	self.panelRule:setVisible(true)
end

function ActivitySeasonTowerInfoDlg:onHideRuleClick()
	self.panelRule:setVisible(false)
end

function ActivitySeasonTowerInfoDlg:onOpen()
	ActivitySeasonTowerInfoDlg.super.onOpen(self)
	CurAvatar:checkPushGiftTrigger(self.mUIName, Const.ON_WINDOW_OPEN)
end

function ActivitySeasonTowerInfoDlg:onShowTower(actObj, towerId)
	self.towerId = towerId

	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
end

function ActivitySeasonTowerInfoDlg:_setData()
	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.lvCellPath = "System/SeasonTower/" .. self.replaceableCellPath[1]
	else
		self.lvCellPath = "System/Common/Grid/GridSeasonTowerLv"
	end

	self:_refreshData()
end

local MAX_SHOW_NUM = 9

function ActivitySeasonTowerInfoDlg:_refreshData()
	local actData = self.actObj.actData
	local isLock, lockTime, isLast = actData:isTowerLocked(self.towerId)

	self.textTowerTime:setFontColor(ResColor.WHITE)

	if isLock then
		if lockTime and lockTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.textTowerTime, lockTime, false, Lang.get(45383))
		else
			ClientTimerManager.RemoveSecondTickUI(self.textTowerTime)
			self.textTowerTime:setText(Lang.get(30622))
		end
	elseif lockTime and lockTime > 0 then
		if isLast then
			self.textTowerTime:setFontColor(ResColor.RED)
			ClientTimerManager.AddSecondFormatTickUI(self.textTowerTime, lockTime, false, Lang.get(48685))
		else
			ClientTimerManager.AddSecondFormatTickUI(self.textTowerTime, lockTime, false, Lang.get(48655))
		end
	else
		ClientTimerManager.RemoveSecondTickUI(self.textTowerTime)
		self.textTowerTime:setText("")
	end

	self.showTowerData = actData:getOneTowerData(self.towerId)
	self.name = self.showTowerData.towerConfig.name

	if self.showTowerData.weekConfig then
		self.name = self.showTowerData.weekConfig.name
	end

	self.btnClose:setText(self.name or "")

	self.towerConfig = self.showTowerData.towerConfig
	self.passedLayer = self.showTowerData.passedLayer

	local stageData = self.showTowerData.stageData

	self.maxLayer = #stageData
	self.stageData = {}

	local startIdx = math.max(1, self.passedLayer - 3)

	if self.passedLayer >= self.maxLayer - 4 then
		startIdx = self.maxLayer - MAX_SHOW_NUM + 1
	end

	self.startEnable = startIdx == 1
	self.endEnable = startIdx == self.maxLayer - MAX_SHOW_NUM + 1

	for index = 0, MAX_SHOW_NUM - 1 do
		table.insert(self.stageData, stageData[startIdx + index])
	end

	for index = #self.levelCells, #self.stageData - 1 do
		local childStr = index + 1

		if index + startIdx == self.passedLayer + 1 then
			childStr = 0
		end

		local newCell = ActivitySeasonTowerLevelCell(self, "MainInfoPanel/LvPanel/LvMaskPanel/LvList/Content", self.lvCellPath, 0, 0, nil, nil, nil, childStr)

		table.insert(self.levelCells, newCell)
	end

	local showPage = MAX_SHOW_NUM

	for index, cell in ipairs(self.levelCells) do
		local levelData = self.stageData[index]

		if levelData then
			cell:setVisible(true)
			cell:setData(index, levelData, self.passedLayer)

			if levelData.layer == self.passedLayer + 1 then
				showPage = index
			end
		else
			cell:setVisible(false)
		end
	end

	self.towerRoleData = self.showTowerData.towerRoleData

	if self.towerRoleData and self.towerRoleData.needSetBuff == 1 then
		self.btnBuffMain:setVisible(true)
		self:onBuffMainClick()
	else
		self.btnBuffMain:setVisible(false)
	end

	self.textEnergy:setText(actData:getEnergy())
	self.scrollPage:scrollToCorrectPage(showPage)

	local desc = ""

	if self.showTowerData.towerType == Const.SEASON_TOWER_TYPE_GROUP then
		desc = self.showTowerData.weekConfig.desc or ""
	else
		desc = self.towerConfig.desc or ""
	end

	self.textRuleTeam:setText(desc)

	if actData:getCachedTowerRule(self.towerId) then
		UIManager.getUI("activitySeasonTowerRuleDlg", true):onShow(desc, self.towerId, actData, Slot(self._checkNewBuffs, self))
	else
		self:_checkNewBuffs()
	end

	local newGetBuffs = self.actObj.actData:getTowerBuffNewGet(self.towerId)

	if newGetBuffs then
		self.panelBuffNew:setVisible(true)
	else
		self.panelBuffNew:setVisible(false)
	end

	if self.currentPageIndex and self.levelCells[self.currentPageIndex] then
		self.levelCells[self.currentPageIndex]:setSelected(true)
	end

	if self.sliderScore then
		if actData:checkScoreAchieveNew() then
			self.imgNewScore:setVisible(true)
		else
			self.imgNewScore:setVisible(false)
		end

		self.textNowScore:setText(actData.score or 0)

		local nextScore, nowProgress = actData:getScoreNextProgress()

		if nextScore == nil then
			self.panelScoreMax:setVisible(true)
			self.panelScore:setVisible(false)
		else
			self.panelScoreMax:setVisible(false)
			self.panelScore:setVisible(true)
			self.textNextScore:setText(nextScore)
		end

		self.sliderScore:setValue(nowProgress)
	end
end

function ActivitySeasonTowerInfoDlg:_checkNewBuffs()
	local newBuffs = self.actObj.actData:getTowerBuffNewFly(self.towerId)

	if newBuffs then
		UIManager.getUI("activitySeasonTowerBuffNewDlg", true):onShow(newBuffs, self.actObj.actData, self.towerId)
	end
end

function ActivitySeasonTowerInfoDlg:onCorrectEvent(sender, currentPageIndex)
	if self.currentPageIndex and self.levelCells[self.currentPageIndex] then
		self.levelCells[self.currentPageIndex]:setSelected(false)
	end

	self.levelCells[currentPageIndex]:setSelected(true)

	self.curLevelData = self.levelCells[currentPageIndex].levelData
	self.currentPageIndex = currentPageIndex
	self.checkCanEnter = false

	if self.curLevelData.layer <= self.passedLayer then
		self.btnBattle:setVisible(false)
		self.panelFinish:setVisible(true)
		self.panelUnOpen:setVisible(false)
	elseif self.curLevelData.layer == self.passedLayer + 1 then
		self.checkCanEnter = true

		self.btnBattle:setVisible(true)
		self.panelFinish:setVisible(false)
		self.panelUnOpen:setVisible(false)
	else
		self.btnBattle:setVisible(false)
		self.panelFinish:setVisible(false)
		self.panelUnOpen:setVisible(true)
	end
end

function ActivitySeasonTowerInfoDlg:onReplayClick()
	if self.recordData and self.recordData[self.towerId] and self.recordData[self.towerId][self.curLevelData.layer] then
		self:onOpActTowerReplayRecordResp(self.towerId, self.curLevelData.layer, self.recordData[self.towerId][self.curLevelData.layer])
	else
		RPC.opActTowerReplayRecord(self.towerId, self.curLevelData.layer)
	end
end

function ActivitySeasonTowerInfoDlg:onCellClick(sender)
	if sender.pageIndex <= 2 and not self.startEnable then
		MsgManager.clientNotice(349)

		return
	elseif sender.pageIndex >= MAX_SHOW_NUM - 1 and not self.endEnable then
		MsgManager.clientNotice(350)

		return
	end

	self.scrollPage:scrollToCorrectPage(sender.pageIndex)
end

function ActivitySeasonTowerInfoDlg:onBattleClick()
	local remTime = self.actObj:getRemainOpenTime()

	if remTime < 0 then
		MsgManager.clientNotice(344)

		return
	end

	if self.actObj.actData:isTowerLocked(self.towerId) then
		MsgManager.clientNotice(348)

		return
	end

	if self.towerRoleData and self.towerRoleData.needSetBuff == 1 then
		self:onBuffMainClick()
		MsgManager.notice(ResClientNotice[339].notice)

		return
	end

	if self.actObj.actData:getEnergy() <= 0 then
		MsgManager.clientNotice(346)

		return
	end

	if self.curLevelData and self.curLevelData.battle_id and self.curLevelData.layer == self.passedLayer + 1 then
		local battleData = {}

		battleData.seasonTowerData = {}
		battleData.seasonTowerData.opId = self.actObj.opId
		battleData.seasonTowerData.actId = self.actObj.actId
		battleData.seasonTowerData.layer = self.curLevelData.layer
		battleData.seasonTowerData.towerId = self.curLevelData.tower_id
		battleData.seasonTowerData.showTowerData = self.showTowerData
		battleData.seasonTowerData.buffs = self.actObj.actData:getTowerBuffs(self.curLevelData.tower_id)
		battleData.seasonTowerData.buffArgs = {
			self.name
		}

		if self.curLevelData.mulity_pvp == 1 then
			local form1 = Const.SEASON_TOWER_FORMATION_CONFIG[self.curLevelData.tower_id]
			local form2 = Const.SEASON_TOWER_SECOND_FORMATION[self.curLevelData.tower_id]

			battleData.seasonTowerData.multiTeamsIndex = {
				form1,
				form2
			}
		end

		if self.showTowerData.towerType == Const.SEASON_TOWER_TYPE_GROUP then
			battleData.seasonTowerData.teamLimit = self.showTowerData.teamLimit
		else
			battleData.seasonTowerData.teamNumLimit = {}
			battleData.seasonTowerData.teamNumLimit.noTeamNumber = self.towerConfig.mini_count
			battleData.seasonTowerData.teamNumLimit.limit_desc = self.towerConfig.desc or ""
			battleData.seasonTowerData.teamNumLimit.limitTeam = {
				self.towerConfig.group_limit
			}
		end

		battleData.seasonTowerData.score_need = self.curLevelData.score_need or 1
		battleData.seasonTowerData.sweepMaxLayer = self.actObj.actData:getCanSweepMaxLayer(self.curLevelData.tower_id)

		CurAvatar:enterFormation(self.curLevelData.battle_id, BattleConst.BATTLE_TYPE_SEASON_TOWER, battleData)
	end
end

function ActivitySeasonTowerInfoDlg:getLimitTeamDic()
	local limitTeamDic = {}

	if self.showTowerData.towerType == Const.SEASON_TOWER_TYPE_GROUP then
		for i, team in ipairs(self.showTowerData.teamLimit) do
			limitTeamDic[team] = true
		end
	else
		limitTeamDic[self.towerConfig.group_limit] = true
	end

	return limitTeamDic
end

function ActivitySeasonTowerInfoDlg:onTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(self.actObj.actData.miscData.rule_tips_id)
end

function ActivitySeasonTowerInfoDlg:onEnergyTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_SEASON_TOWER_ENERGY)
end

function ActivitySeasonTowerInfoDlg:onAwardClick(levelData)
	local layer = levelData.layer

	UIManager.getUI("activitySeasonTowerBuffDlg", true):onShow(levelData, self.showTowerData.stageData[layer - 1], self.passedLayer)
end

function ActivitySeasonTowerInfoDlg:onRankClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)

	rankMainDlg:initByRankType(Const.RANK_TYPE_SEASON_TOWER_LAYER, self.curLevelData.tower_id)
end

function ActivitySeasonTowerInfoDlg:onBuffClick()
	local buffs = self.actObj.actData:getTowerBuffs(self.towerId)
	local newBuffs = self.actObj.actData:getTowerBuffNewGet(self.towerId)

	if #buffs == 0 then
		MsgManager.notice(Lang.get(30641))
	else
		UIManager.getUI("activitySeasonTowerBuffAllDlg", true):onShow(buffs, self.name, newBuffs)

		if newBuffs then
			self.actObj.actData:saveTowerBuffNewGet(self.towerId)
		end
	end
end

function ActivitySeasonTowerInfoDlg:onBuffMainClick()
	if self.towerRoleData.needSetBuff == 1 then
		local stageData = self.showTowerData.stageData[self.passedLayer]

		if stageData.buff then
			UIManager.getUI("activitySeasonTowerBuffChooseDlg", true):onShow(stageData, self.actObj.opId)
		end
	end
end

function ActivitySeasonTowerInfoDlg:onNewRefresh()
	self:_refreshData()
end

function ActivitySeasonTowerInfoDlg:onShowOneLayerBuff(levelData, master, chooseBuff)
	self.panelBuffChoose:setData(levelData, master, chooseBuff)
end

function ActivitySeasonTowerInfoDlg:onClickClose()
	self:setVisible(false)
end

function ActivitySeasonTowerInfoDlg:updateActivityData()
	self:_refreshData()
end

function ActivitySeasonTowerInfoDlg:onOpActTowerUpdateBuffNotify(towerId, layer)
	self:_refreshData()
end

function ActivitySeasonTowerInfoDlg:onOpActTowerReplayRecordResp(tower_id, layer, data)
	if not self.recordData then
		self.recordData = {}
	end

	if not self.recordData[tower_id] then
		self.recordData[tower_id] = {}
	end

	self.recordData[tower_id][layer] = data

	if self.checkCanEnter and self.actObj.actData.clientStageData then
		local resOpActTowerStageConfig = self.actObj.actData.clientStageData[tower_id][layer]

		if resOpActTowerStageConfig and resOpActTowerStageConfig.mulity_pvp and resOpActTowerStageConfig.mulity_pvp > 0 then
			self.checkCanEnter = false
		end
	end

	local extra = {
		battleType = BattleConst.BATTLE_TYPE_SEASON_TOWER,
		checkCanEnter = self.checkCanEnter,
		onBattleClick = Slot(self.onBattleClick, self),
		towerId = self.curLevelData and self.curLevelData.tower_id
	}

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_SEASON_TOWER, data, {
		self.actObj.actId,
		tower_id,
		layer
	}, extra)
end

return ActivitySeasonTowerInfoDlg
