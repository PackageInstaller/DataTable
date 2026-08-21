-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPlotBattleDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResClientNotice = require("ClientData/ResClientNotice")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local PlotBattleSelectCell = Class("PlotBattleSelectCell", UIControls.Child)

function PlotBattleSelectCell:ctor()
	self.img = UIControls.Image(self, "")
end

function PlotBattleSelectCell:setSelected(isSelected)
	if isSelected then
		self.img:setImage("Atlas/ActivityAtlas/ActivityFlotAtlas/ActivityFlotAtlas2", "BgNextDotBlue")
	else
		self.img:setImage("Atlas/ActivityAtlas/ActivityFlotAtlas/ActivityFlotAtlas2", "BgNextDotBlack")
	end
end

local ActivityPlotBattleLevelCell = Class("ActivityPlotBattleLevelCell", UIControls.Button)

function ActivityPlotBattleLevelCell:ctor()
	self.imgBg = UIControls.Image(self, self.mPath .. "/ImgBtn")
	self.imgComplete = UIControls.Panel(self, self.mPath .. "/ImgComplete")
	self.panelSelect = UIControls.Panel(self, self.mPath .. "/EfxSel")
end

function ActivityPlotBattleLevelCell:setData(levelDetailData, levelState, levelStar)
	self.levelData = levelDetailData
	self.levelStar = levelStar
	self.levelState = levelState

	if levelDetailData.name_icon then
		if self.levelState == Const.COMMON_STATE_LOCK or self.levelState == Const.COMMON_STATE_NML then
			self.imgComplete:setVisible(false)
			self.imgBg:setImage("Atlas/ActivityAtlas/" .. levelDetailData.name_icon_path, levelDetailData.name_icon .. "Dis")
		else
			if self.levelState == Const.COMMON_STATE_COMPLETE then
				self.imgComplete:setVisible(true)
			else
				self.imgComplete:setVisible(false)
			end

			self.imgBg:setImage("Atlas/ActivityAtlas/" .. levelDetailData.name_icon_path, levelDetailData.name_icon .. "Nml")
		end
	end
end

function ActivityPlotBattleLevelCell:setSelected(selected)
	if selected then
		self.panelSelect:setVisible(true)
		self:setEnable(false)

		if self.levelData and self.levelData.name_icon_path then
			self.imgBg:setImage("Atlas/ActivityAtlas/" .. self.levelData.name_icon_path, self.levelData.name_icon .. "Sel")
		end
	else
		self.panelSelect:setVisible(false)
		self:setEnable(true)

		if self.levelState ~= Const.COMMON_STATE_LOCK and self.levelState ~= Const.COMMON_STATE_NML and self.levelData and self.levelData.name_icon_path then
			self.imgBg:setImage("Atlas/ActivityAtlas/" .. self.levelData.name_icon_path, self.levelData.name_icon .. "Nml")
		end
	end
end

local strClassName = "ActivityPlotBattleDlg"
local ActivityPlotBattleDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPlotBattleDlg, ActivityPanelMixin)

local MAX_DIFFICULT_NUM = 4
local MAX_BOSS_NUM = 4
local TARGET_NUM = 3

function ActivityPlotBattleDlg:initUI()
	self.selImgs = {}
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnBattle = UIControls.Button(self, "MainInfoPanel/BtnBegan")

	self.btnBattle:addEventClick(self.onBtnBattle)

	self.btnSweep = UIControls.Button(self, "MainInfoPanel/BtnClean")
	self.imgSweepNew = UIControls.Image(self, "MainInfoPanel/BtnClean/IconNew")

	self.btnSweep:addEventClick(self.onBtnClean)

	self.sweepCostImg = UIControls.Image(self, "MainInfoPanel/BtnClean/IconEnergy")
	self.sweepCostNumTxt = UIControls.Label(self, "MainInfoPanel/BtnClean/TextNum")
	self.sweepTipsTxt = UIControls.Label(self, "MainInfoPanel/BtnClean/TextTips")
	self.sweepAwardPanel = UIControls.Panel(self, "MainInfoPanel/CleanAwardPanel")
	self.sweepAwardGridPanel = UIControls.Panel(self, "MainInfoPanel/CleanAwardPanel/GridPanel")
	self.sweepAwardPath = "MainInfoPanel/CleanAwardPanel/GridPanel"
	self.sweepAwardGrids = {}
	self.btnSweepNotice = UIControls.Button(self, "MainInfoPanel/BtnCleanAward")

	self.btnSweepNotice:addEventClick(self.onBtnCleanNotice)

	self.btnRankList = UIControls.Button(self, "MainInfoPanel/BtnRankList")

	self.btnRankList:addEventClick(self.onBtnRankListClick)

	self.btnPre = UIControls.Button(self, "MainInfoPanel/BtnBossChangeL")

	self.btnPre:addEventClick(self.onBtnPre)

	self.btnNext = UIControls.Button(self, "MainInfoPanel/BtnBossChangeR")

	self.btnNext:addEventClick(self.onBtnNext)

	self.panelBoss = UIControls.Panel(self, "MainInfoPanel/BossPanel")
	self.imgBoss = UIControls.Image(self, "MainInfoPanel/ImgBoss")
	self.imgName = UIControls.Image(self, "MainInfoPanel/BossName")

	if UIControls.checkControlFunc(self, "MainInfoPanel/TextBossName") then
		self.txtBossName = UIControls.Label(self, "MainInfoPanel/TextBossName")
		self.txtBossName2 = UIControls.Label(self, "MainInfoPanel/TextBossName/TextBossName02")

		self.txtBossName:setVisible(false)
	end

	self.panelLock = UIControls.Panel(self, "MainInfoPanel/LockPanel")
	self.textLock = UIControls.Label(self, "MainInfoPanel/LockPanel/Text")
	self.imgLockBoss = UIControls.Image(self, "MainInfoPanel/LockPanel/ImgName")

	if UIControls.checkControlFunc(self, "MainInfoPanel/LockPanel/TextBossName") then
		self.txtLockBossName = UIControls.Label(self, "MainInfoPanel/LockPanel/TextBossName")
		self.txtLockBossName2 = UIControls.Label(self, "MainInfoPanel/LockPanel/TextBossName/TextBossName02")

		self.txtLockBossName:setVisible(false)
	end

	self.levelBtns = {}

	for index = 1, MAX_DIFFICULT_NUM do
		local newBtn = ActivityPlotBattleLevelCell(self, "MainInfoPanel/BossLevelPanel/BtnLevel" .. index .. "/BtnLevel" .. index)

		newBtn:addEventClick(self.onLevelClick)
		table.insert(self.levelBtns, newBtn)
	end

	self.panelBtns = UIControls.Panel(self, "MainInfoPanel/BossLevelPanel")
	self.panelTarget = UIControls.Panel(self, "MainInfoPanel/TargetPanel")
	self.stars = {}

	for index = 1, 3 do
		local newPanel = UIControls.Panel(self, "MainInfoPanel/TargetPanel/StarPanel/ImgStar" .. index)

		table.insert(self.stars, newPanel)
	end

	self.imgTargetComplete = UIControls.Panel(self, "MainInfoPanel/TargetPanel/ImgStar1")
	self.textTargets = {}

	for index = 1, TARGET_NUM do
		local newLabel = UIControls.Label(self, "MainInfoPanel/TargetPanel/TxtDesPanel/TxtDes" .. index)

		table.insert(self.textTargets, newLabel)
	end

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
end

function ActivityPlotBattleDlg:onShowBattleInfo(pageData, stageId, oldLevelId)
	self.stageId = stageId
	self.oldLevelId = oldLevelId

	self:onShowActivity(pageData)
end

function ActivityPlotBattleDlg:_setData()
	if not self.modelStage then
		if self.replaceableCellPath and self.replaceableCellPath[1] then
			self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/" .. self.replaceableCellPath[1])
		else
			self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/ActivityFlotFightModelStage")
		end
	end

	self.selectNextLevel, self.selectNextStage = self.actObj.actData:getNextSelectNode(nil, Const.ACT_TYPE_PLOT_MODE_BATTLE)
	self.gotoNextLv = self.stageId == nil or self.oldLevelId and self.selectNextLevel == self.oldLevelId + 1

	if self.gotoNextLv then
		self.stageId = self.selectNextStage
	end

	self.miscData = self.actObj.actData.miscData

	local moneyList = {
		100001,
		100002
	}

	if self.miscData and self.miscData.cost_item_id then
		table.insert(moneyList, 1, self.miscData.cost_item_id)
	end

	self.panelFund:settingFund(moneyList)

	local actId = self.actObj.actId

	self.levelData = {}
	self.plotBattleData = {}

	for stageId, info in ipairs(ResOpActivityPlotStage[actId] or {}) do
		if info.stage_type == Const.ACT_TYPE_PLOT_MODE_BATTLE then
			table.insert(self.plotBattleData, info)

			self.levelData[stageId] = {}
		end
	end

	for detailId, detailInfo in ipairs(self.actObj.actData.clientData or {}) do
		if self.levelData[detailInfo.stage] then
			table.insert(self.levelData[detailInfo.stage], detailInfo)
		end
	end

	self.maxStageNum = #self.plotBattleData

	for index = 1, self.maxStageNum do
		if not self.selImgs[index] then
			local newCell = PlotBattleSelectCell(self, "MainInfoPanel/ChangePanel", "System/Activity/ActivityPlotCommon/DotCell")

			newCell:setVisible(true)
			table.insert(self.selImgs, newCell)
		end
	end
end

function ActivityPlotBattleDlg:_onShow()
	self.modelStage:connectImage(self.modelViewport)

	for index, stageInfo in ipairs(self.plotBattleData) do
		if stageInfo.stage == self.stageId then
			self:_onChooseStage(index)

			break
		end
	end
end

function ActivityPlotBattleDlg:_onChooseStage(chooseIndex)
	self.chooseIndex = chooseIndex

	self.btnNext:setVisible(chooseIndex < #self.plotBattleData)
	self.btnPre:setVisible(chooseIndex > 1)

	self.stageData = self.plotBattleData[chooseIndex]
	self.stageId = self.stageData.stage

	for index, cell in ipairs(self.selImgs) do
		cell:setSelected(index == chooseIndex)
	end

	local stage = self.stageData.stage
	local allLevelData = self.levelData[stage]

	ClientTimerManager.RemoveSecondTickUI(self.textLock)

	local stageState = self.actObj.actData:getStageState(stage)

	if stageState == Const.COMMON_STATE_LOCK then
		self.btnBattle:setVisible(false)
		self.btnSweep:setVisible(false)
		self.btnRankList:setVisible(false)
		self.panelBtns:setVisible(false)
		self.sweepAwardPanel:setVisible(false)
		self.panelTarget:setVisible(false)
		self.panelLock:setVisible(true)
		self.panelBoss:setVisible(false)
		self.imgBoss:setVisible(false)
		self.imgName:setVisible(false)

		if self.txtLockBossName then
			self.txtBossName:setVisible(false)
		end

		if self.txtLockBossName and self.stageData.boss_name then
			self.imgLockBoss:setVisible(false)
			self.txtLockBossName:setVisible(true)
			self.txtLockBossName:setText(self.stageData.boss_name)
			self.txtLockBossName2:setText(self.stageData.boss_name)
		else
			self.imgLockBoss:setVisible(true)

			if self.stageData.name_icon_path then
				self.imgLockBoss:setImage("Atlas/ActivityAtlas/" .. self.stageData.name_icon_path, self.stageData.name_icon)
			end
		end

		if allLevelData[1] and allLevelData[1].show_model_id then
			if self.curModelInsId then
				self.modelStage:delModel(self.curModelInsId)
			end

			self.curModelInsId = self.modelStage:showModelById(allLevelData[1].show_model_id, Const.MODEL_TYPE.ShowMain)
		end

		local remineTime = self.actObj.actData:getStageUnlockedTime(stage) - ClientUtils.getServerTime()

		ClientTimerManager.AddSecondFormatTickUI(self.textLock, remineTime, nil, self.stageData.unlock_desc_pre)
	elseif self.stageData.stage > self.selectNextStage then
		self.btnBattle:setVisible(false)
		self.btnSweep:setVisible(false)
		self.btnRankList:setVisible(false)
		self.panelBtns:setVisible(false)
		self.sweepAwardPanel:setVisible(false)
		self.panelTarget:setVisible(false)
		self.panelLock:setVisible(true)
		self.textLock:setText(ResClientNotice[263].notice)
		self.panelBoss:setVisible(false)
		self.imgBoss:setVisible(false)
		self.imgName:setVisible(false)

		if self.txtLockBossName then
			self.txtBossName:setVisible(false)
		end

		if self.txtLockBossName and self.stageData.boss_name then
			self.imgLockBoss:setVisible(false)
			self.txtLockBossName:setVisible(true)
			self.txtLockBossName:setText(self.stageData.boss_name)
			self.txtLockBossName2:setText(self.stageData.boss_name)
		else
			self.imgLockBoss:setVisible(true)

			if self.stageData.name_icon_path then
				self.imgLockBoss:setImage("Atlas/ActivityAtlas/" .. self.stageData.name_icon_path, self.stageData.name_icon)
			end
		end

		if allLevelData[1] and allLevelData[1].show_model_id then
			if self.curModelInsId then
				self.modelStage:delModel(self.curModelInsId)
			end

			self.curModelInsId = self.modelStage:showModelById(allLevelData[1].show_model_id, Const.MODEL_TYPE.ShowMain)
		end
	else
		self.panelBoss:setVisible(true)
		self.imgBoss:setVisible(true)

		if self.txtBossName and self.stageData.boss_name then
			self.imgName:setVisible(false)
			self.txtBossName:setVisible(true)
			self.txtBossName:setText(self.stageData.boss_name)
			self.txtBossName2:setText(self.stageData.boss_name)
		else
			self.imgName:setVisible(true)

			if self.stageData.name_icon_path then
				self.imgName:setImage("Atlas/ActivityAtlas/" .. self.stageData.name_icon_path, self.stageData.name_icon)
			end
		end

		self.panelLock:setVisible(false)
		self.btnBattle:setVisible(true)
		self.btnSweep:setVisible(true)
		self.btnRankList:setVisible(true)
		self.panelBtns:setVisible(true)
		self.sweepAwardPanel:setVisible(true)
		self.panelTarget:setVisible(true)

		local stageLevelData = self.levelData[stage] or {}

		for index, levelBtn in ipairs(self.levelBtns) do
			local levelData = stageLevelData[index]

			if levelData then
				local levelState = self.actObj.actData:getLevelState(levelData.index)

				levelBtn:setData(levelData, levelState, self.actObj.actData:getLevelTargetStar(levelData.index))
				levelBtn:setVisible(true)
			else
				levelBtn:setVisible(false)
			end
		end

		local targetLevel

		if self.gotoNextLv then
			targetLevel = self.selectNextLevel
		else
			targetLevel = self.curLevelIndex or self.oldLevelId
		end

		self.gotoNextLv = nil
		self.oldLevelId = nil

		for order, levelData in ipairs(stageLevelData) do
			if not targetLevel then
				self:onLevelClick(self.levelBtns[order])

				break
			elseif levelData.index == targetLevel then
				self:onLevelClick(self.levelBtns[order])

				break
			end
		end
	end
end

function ActivityPlotBattleDlg:onBtnRankListClick()
	local rankMainDlg = UIManager.getUI("rankMainDlg", true)
	local actInfo = {}

	actInfo[1] = self.actObj
	actInfo[2] = self.curLevelIndex

	rankMainDlg:initByRankType(Const.RANK_TYPE_ACTIVITY_PLOT, actInfo)
end

function ActivityPlotBattleDlg:onLevelClick(sender)
	local levelData = sender.levelData
	local levelIndex = levelData.index
	local levelState = self.actObj.actData:getLevelState(levelIndex)

	if levelState == Const.COMMON_STATE_LOCK or levelState == Const.COMMON_STATE_NML then
		MsgManager.clientNotice(263)
	else
		self.activeLevelDetailData = levelData

		for order, levelBtn in ipairs(self.levelBtns) do
			levelBtn:setSelected(levelBtn == sender)
		end

		self.targets = {}

		if levelData and levelData.battle_id then
			local battleConfig = ResBattleConfig[levelData.battle_id]

			if battleConfig and battleConfig.target_id then
				local targetData = ResBattleTarget[battleConfig.target_id] or {}

				self.targets = targetData.targets or {}
			end
		end

		for index, textTarget in ipairs(self.textTargets) do
			local target = self.targets[index]

			if target then
				textTarget:setText(target.desc or "")
			else
				textTarget:setText("")
			end
		end

		for index, star in ipairs(self.stars) do
			star:setVisible(index <= sender.levelStar)
		end

		if not self.curLevelIndex or self.curLevelIndex ~= levelIndex then
			self.curLevelIndex = levelIndex

			if levelData.show_model_id then
				if self.curModelInsId then
					self.modelStage:delModel(self.curModelInsId)
				end

				self.curModelInsId = self.modelStage:showModelById(levelData.show_model_id, Const.MODEL_TYPE.ShowMain)
			end

			if self.txtBossName and self.stageData.boss_name then
				self.imgName:setVisible(false)
				self.txtBossName:setVisible(true)
				self.txtBossName:setText(self.stageData.boss_name)
				self.txtBossName2:setText(self.stageData.boss_name)
			else
				self.imgName:setVisible(true)

				if levelData.boss_name_icon_path then
					self.imgName:setImage("Atlas/ActivityAtlas/" .. levelData.boss_name_icon_path, levelData.boss_name_icon)
				end
			end

			local sweepAward = levelData.sweep_bonus

			for i = #self.sweepAwardGrids, 1, -1 do
				self.sweepAwardGrids[i]:destroy()

				self.sweepAwardGrids[i] = nil
			end

			ClientUtils.CreateBonusGrid(self, self.sweepAwardGrids, self.sweepAwardPath, sweepAward, nil, nil, true)
		end

		self:_refreshSweepInfo(levelData, levelState)
	end
end

function ActivityPlotBattleDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityPlotBattleDlg:onBtnBattle()
	if self.activeLevelDetailData then
		self.activeAVG = {
			self.activeLevelDetailData.plot_avg1,
			self.activeLevelDetailData.plot_avg2,
			self.activeLevelDetailData.plot_avg3
		}

		self:playAVG()
	end
end

function ActivityPlotBattleDlg:onBtnClean()
	if CurAvatar and self.curLevelIndex and self.canSweep and self.leftSweepCount > 0 then
		if self:_sweepItemEnough() then
			CurAvatar:activityRPC(Functor(RPC.opActPlotSweep, self.actObj.opId, self.curLevelIndex), self.actObj.opId)
		else
			MsgManager.notice(Lang.get(200))
		end
	end
end

function ActivityPlotBattleDlg:onBtnCleanNotice()
	if self.levelData then
		local sweepInfoDlg = UIManager.getUI("activitySweepInfoDlg", true)

		sweepInfoDlg:setSweepInfo(self.levelData, self.actObj.actData)
	else
		return
	end
end

function ActivityPlotBattleDlg:playAVG()
	local avgId = table.remove(self.activeAVG, 1)

	if avgId then
		UIManager.playAVG(avgId, nil, Slot(self.playAVG, self))
	elseif self.activeLevelDetailData.battle_id then
		local battleData = {}

		battleData.actData = {}
		battleData.actData.opId = self.actObj.opId
		battleData.actData.actId = self.actObj.actId
		battleData.actData.nodeIndex = self.activeLevelDetailData.index

		CurAvatar:activityRPC(Functor(CurAvatar.enterFormation, CurAvatar, self.activeLevelDetailData.battle_id, BattleConst.BATTLE_TYPE_ACTIVITY, battleData), self.actObj.opId)
	end
end

function ActivityPlotBattleDlg:onBtnPre()
	if self.chooseIndex > 1 then
		self.curLevelIndex = nil

		self:_onChooseStage(self.chooseIndex - 1)
	end
end

function ActivityPlotBattleDlg:onBtnNext()
	if self.chooseIndex < #self.plotBattleData then
		self.curLevelIndex = nil

		self:_onChooseStage(self.chooseIndex + 1)
	end
end

function ActivityPlotBattleDlg:updateActivityData()
	self:_onShow()
end

function ActivityPlotBattleDlg:_refreshSweepInfo(levelData, levelState)
	local costItemId = self.miscData.cost_item_id

	if not self.sweepCostItem or self.sweepCostItem ~= costItemId then
		self.sweepCostItem = costItemId

		local itemPath = BaseObject.getItemIconPath(costItemId)

		if itemPath then
			self.sweepCostImg:setImage(itemPath[1], itemPath[2])
		end
	end

	self.sweepCost = levelData.sweep_cost or 0

	if self:_sweepItemEnough() then
		self.sweepCostNumTxt:setText(self.sweepCost)
	else
		self.sweepCostNumTxt:setTextWithColor(self.sweepCost, "RED")
	end

	self.canSweep = levelState == Const.COMMON_STATE_PASSED or levelState == Const.COMMON_STATE_COMPLETE

	local sweepBtnNeedLock = false

	if self.canSweep then
		local maxSweepCount = levelData.sweep_max_num
		local nowSweepCount = self.actObj.actData:getNowSweepCount(self.curLevelIndex)

		self.leftSweepCount = math.max(0, maxSweepCount - nowSweepCount)

		self.sweepTipsTxt:setText(utils.format(Lang.get(30624), self.leftSweepCount, maxSweepCount))

		if self.leftSweepCount > 0 then
			-- block empty
		else
			sweepBtnNeedLock = true
		end

		self.sweepAwardGridPanel:setObjGray(false)
	else
		self.sweepTipsTxt:setText(ClientUtils.getClientNotice(301) or "")
		self.sweepAwardGridPanel:setObjGray(true)

		sweepBtnNeedLock = true
	end

	self.btnSweep:setEnable(not sweepBtnNeedLock)
	self.imgSweepNew:setVisible(not sweepBtnNeedLock and self.actObj.actData:hasSweepItem())
end

function ActivityPlotBattleDlg:_sweepItemEnough()
	if not self.sweepCostItem or not self.sweepCost then
		return false
	end

	local sweepItemCount = CurAvatar:getItemNumById(self.sweepCostItem)

	return sweepItemCount >= self.sweepCost
end

return ActivityPlotBattleDlg
