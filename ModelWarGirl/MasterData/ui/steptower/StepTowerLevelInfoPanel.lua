-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerLevelInfoPanel.lua

local strClassName = "GridStepTowerAward"
local GridStepTowerAward = Class(strClassName, UIControls.ItemGridChild)

function GridStepTowerAward:ctor()
	self:_initUI()
end

function GridStepTowerAward:_initUI()
	self.txtCondition = UIControls.Button(self, "TextCondition")
end

local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTowerLayerName = require("ClientData/ResTowerLayerName")
local ResTower = require("ClientData/ResTower")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local strClassName = "StepTowerLevelInfoPanel"
local StepTowerLevelInfoPanel = Class(strClassName, UIControls.Panel)

function StepTowerLevelInfoPanel:ctor()
	self:initUI()
end

function StepTowerLevelInfoPanel:initUI()
	self.panelBtnFunc = UIControls.Panel(self, self.mPath .. "/BtnFunPanel")
	self.txtNeedPower = UIControls.Label(self, self.mPath .. "/BtnFunPanel/BtnClear/TextNum")
	self.txtEnterNum = UIControls.Label(self, self.mPath .. "/BtnFunPanel/TextNum")
	self.starConditionList = {}

	for i = 1, 3 do
		local conditionDes = UIControls.Label(self, self.mPath .. "/LevelConditionPanel/Condition" .. i .. "/TextDes")

		self.starConditionList[i] = conditionDes
	end

	self.btnBattle = UIControls.Button(self, self.mPath .. "/BtnFunPanel/BtnBattle", "Text")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.btnClear = UIControls.Button(self, self.mPath .. "/BtnFunPanel/BtnClear")

	self.btnClear:addEventClick(self.onBtnClearClick)

	self.imgStar = UIControls.Image(self, self.mPath .. "/LevelConditionPanel/BgTextTitle/IconStar")
	self.txtBattlePower = UIControls.Label(self, self.mPath .. "/BtnFunPanel/BtnBattle/TextNum")
	self.imgBattlePower = UIControls.Image(self, self.mPath .. "/BtnFunPanel/BtnBattle/IconEnergy")
	self.panelPower = UIControls.Panel(self, self.mPath .. "/PowerPanel")
	self.panelLock = UIControls.Panel(self, self.mPath .. "/LockPanel")
	self.txtRecommendPower = UIControls.Label(self, self.mPath .. "/PowerPanel/TextPower")
	self.txtMyPower = UIControls.Label(self, self.mPath .. "/PowerPanel/TextMyPower")
	self.awardGridList = {}
end

function StepTowerLevelInfoPanel:setLevelInfo(svrData, resData)
	self.svrData = svrData
	self.resData = resData

	self.txtNeedPower:setText(self.resData.power_cost)

	local passNum = self.svrData and self.svrData.num or 0

	self.remainTimes = self.resData.times - passNum

	if self.svrData and self.svrData.star >= 1 then
		self.imgStar:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "StageStar0" .. self.svrData.star)
		self.txtEnterNum:setText(utils.format(Lang.get(30227), self.remainTimes, self.resData.times))
	else
		self.imgStar:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "StageStar00")
		self.txtEnterNum:setText(Lang.get(997))
	end

	if ResBattleConfig[self.resData.pve_id] and ResBattleConfig[self.resData.pve_id].target_id and ResBattleTarget[ResBattleConfig[self.resData.pve_id].target_id] then
		local targets = ResBattleTarget[ResBattleConfig[self.resData.pve_id].target_id].targets

		if targets then
			for idx = 1, 3 do
				if targets[idx] then
					self.starConditionList[idx]:setText(targets[idx].desc or "")
				end
			end
		end
	end

	self:refreshBtnState()
	self:refreshAwardGrid()
end

function StepTowerLevelInfoPanel:refreshBtnState()
	if self.resData then
		local isDemon = self.resData.is_demon and self.resData.is_demon == 1

		self.panelBtnFunc:setVisible(self.svrData and self.svrData.star >= 1 or (self.mWindow.priestsPerLevel >= self.resData.unlock_level or not isDemon) and CurAvatar:checkStepTowerUnlock(self.resData.layer, self.resData.level))
		self.panelPower:setVisible(not self.panelBtnFunc:getVisible() and isDemon and self.mWindow.priestsPerLevel < self.resData.unlock_level)
		self.panelLock:setVisible(not self.panelBtnFunc:getVisible() and not self.panelPower:getVisible())

		if Const.REVIEW_VERSION then
			self.txtRecommendPower:setText(Lang.get(1203) .. ClientUtils.getNumShortStr(self.resData.unlock_level))
			self.txtMyPower:setText(Lang.get(1203) .. ClientUtils.getNumShortStr(self.mWindow.priestsPerLevel))
		else
			self.txtRecommendPower:setText("LV." .. ClientUtils.getNumShortStr(self.resData.unlock_level))
			self.txtMyPower:setText("LV." .. ClientUtils.getNumShortStr(self.mWindow.priestsPerLevel))
		end

		self.btnClear:setEnable(self.svrData and self.svrData.star >= 1)
	end
end

function StepTowerLevelInfoPanel:refreshForSweep(times)
	self.svrData.num = times

	local passNum = self.svrData and self.svrData.num or 0

	self.remainTimes = self.resData.times - passNum

	self.txtEnterNum:setText(utils.format(Lang.get(30227), self.remainTimes, self.resData.times))
end

function StepTowerLevelInfoPanel:refreshAwardGrid()
	for i, v in ipairs(self.awardGridList) do
		self.awardGridList[i]:destroy()
	end

	local rewardId = self.resData.star_award[1].award
	local randItem = ResRandClient[rewardId]
	local rewardId3 = self.resData.star_award[3].award
	local randItem3 = ResRandClient[rewardId3]

	for i, id in ipairs(randItem.show_ids) do
		local awardGrid = self:getGridStageTowerReward(id, randItem.show_nums and randItem.show_nums[i] and randItem.show_nums[i] or 1)

		awardGrid.imgSelect:setVisible(self.svrData and self.svrData.star >= 1)

		local txtCondition = UIControls.Image(awardGrid, "TextCondition")

		txtCondition:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "IconPass")
		table.insert(self.awardGridList, awardGrid)
	end

	for i, id in ipairs(randItem3.show_ids) do
		local awardGrid = self:getGridStageTowerReward(id, randItem3.show_nums and randItem3.show_nums[i] and randItem3.show_nums[i] or 1)

		awardGrid.imgSelect:setVisible(self.svrData and self.svrData.star >= 3)

		local txtCondition = UIControls.Image(awardGrid, "TextCondition")

		txtCondition:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "IconPassStar")
		table.insert(self.awardGridList, awardGrid)
	end

	local rewardIdSweep = self.resData.award
	local randItemSweep = ResRandClient[rewardIdSweep]

	for i, id in ipairs(randItemSweep.show_ids) do
		local awardGrid = UIControls.ItemGridChild(self, self.mPath .. "/LevelRewardPanel/RewardPanel2", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		local gridItem = BaseObject.GetObject(id)

		gridItem.num = randItemSweep.show_nums and randItemSweep.show_nums[i] and randItemSweep.show_nums[i] or 1

		awardGrid:setObj(gridItem)

		awardGrid.mDisableWays = true

		table.insert(self.awardGridList, awardGrid)
	end
end

function StepTowerLevelInfoPanel:getGridStageTowerReward(id, num)
	local awardGrid = UIControls.ItemGridChild(self, self.mPath .. "/LevelRewardPanel/RewardPanel1", "System/Common/Grid/GridStageTowerReward", 0, 0, true)
	local gridItem = BaseObject.GetObject(id)

	gridItem.num = num

	awardGrid:setObj(gridItem)

	awardGrid.mDisableWays = true

	return awardGrid
end

function StepTowerLevelInfoPanel:checkCanBattleTower()
	if self.remainTimes > 0 then
		if self.resData.power_cost <= CurAvatar.realPowerNum then
			return true
		else
			UIManager.getUI("buyCapacityDlg", true):initBuyType()
		end
	else
		MsgManager.notice(Lang.get(30771))
	end

	return false
end

function StepTowerLevelInfoPanel:onBtnClearClick()
	if self:checkCanBattleTower() then
		utils.openSweepDlg(Const.GAME_PLAY_NOTICE_TOWER, Slot(self.sweepTower, self), Const.MONEY_ID_POWER, self.resData.power_cost, self.remainTimes, self.resData.times)
	end
end

function StepTowerLevelInfoPanel:sweepTower(times)
	local sweepData = {}

	sweepData.layer = self.resData.layer
	sweepData.level = self.resData.level
	sweepData.times = times

	RPC.towerSweep({
		sweepData
	})
end

function StepTowerLevelInfoPanel:onBtnBattleClick()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local battlePreInfo = {}

	battlePreInfo.type = BattleConst.BATTLE_TYPE_STEPTOWER

	local tower = {}

	tower.layer = self.resData.layer
	tower.level = self.resData.level

	local curLayer = CurAvatar.stepTowerData.curPos.layer
	local curLevel = CurAvatar.stepTowerData.curPos.stage

	CurAvatar.isAtkCurStepLevel = tower.layer == curLayer and tower.level == curLevel
	battlePreInfo.data = tower

	battleState:initPreBattleInfo(self.resData.pve_id, battlePreInfo)
	GameFsm.translateState(Const.STATE_BATTLE)
end

return StepTowerLevelInfoPanel
