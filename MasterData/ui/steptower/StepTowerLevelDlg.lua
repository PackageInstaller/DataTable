-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerLevelDlg.lua

local StepTowerRewardPanel = require("UI/StepTower/StepTowerRewardPanel")
local BtnStepTowerSecBig = require("UI/StepTower/BtnStepTowerSecBig")
local BtnStepTowerSecSmall = require("UI/StepTower/BtnStepTowerSecSmall")
local ResRandClient = require("ClientData/ResRandClient")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTowerLayerName = require("ClientData/ResTowerLayerName")
local ResTower = require("ClientData/ResTower")
local strClassName = "StepTowerLevelDlg"
local StepTowerLevelDlg = Class(strClassName, UIControls.Window)

function StepTowerLevelDlg:ctor()
	self:initUI()
end

function StepTowerLevelDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnBattle = UIControls.Button(self, "BtnFunPanel/BtnBattle")

	self.btnBattle:addEventClick(self.onBtnBattleClick)

	self.btnClear = UIControls.Button(self, "BtnFunPanel/BtnClear")

	self.btnClear:addEventClick(self.onBtnClearClick)

	self.txtEnterNum = UIControls.Label(self, "BtnFunPanel/TextNum")
	self.txtEnterNumTitle = UIControls.Label(self, "BtnFunPanel/TextTitle")
	self.txtGetedStarNum = UIControls.Label(self, "AreaRewardPanel/TextTitle/TextNum")
	self.sliStarAward = UIControls.Slider(self, "AreaRewardPanel/Slider")
	self.txtNeedPower = UIControls.Label(self, "BtnFunPanel/BtnBattle/TextNum")
	self.txtNeedPower2 = UIControls.Label(self, "BtnFunPanel/BtnClear/TextNum")
	self.txtRewardTextTitle = UIControls.Label(self, "LevelRewardPanel/TextTitle")
	self.txtLayerName = UIControls.Label(self, "BtnClose/Text")
	self.rewardPanelList = {}
	self.awardGridList = {}

	for i = 1, 3 do
		local rewardPanel = StepTowerRewardPanel(self, "AreaRewardPanel/Reward" .. i)

		self.rewardPanelList[i] = rewardPanel
	end

	self.stageChildList = {}
	self.starConditionList = {}

	for i = 1, 3 do
		local conditionDes = UIControls.Label(self, "LevelConditionPanel/Condition" .. i .. "/TextDes")

		self.starConditionList[i] = conditionDes
	end

	self.stageLevelContainerList = {}

	for i = 1, 21 do
		local levelContainer = UIControls.Panel(self, "LevelList/Level" .. i)

		self.stageLevelContainerList[i] = levelContainer
	end
end

function StepTowerLevelDlg:setStepTowerLayerData(layerData, grid)
	self.layerData = layerData
	self.srcGrid = grid

	for i, v in ipairs(self.layerData.resData) do
		if not self.stageChildList[i] then
			local btnStage = {}

			if v.need_record == 1 then
				btnStage = BtnStepTowerSecBig(self, "LevelList/Level" .. i, "System/OtherBattle/BtnLevelSecBig", 0, 0, true)
			else
				btnStage = BtnStepTowerSecSmall(self, "LevelList/Level" .. i, "System/OtherBattle/BtnLevelSecSmall", 0, 0, true)
			end

			self.stageChildList[i] = btnStage
		end

		self.stageChildList[i]:setStageData(self.layerData.svrData.stage[i], self.layerData.resData[i])
		self.stageChildList[i]:setSelectCallback(Slot(self.setSelectStage, self))
	end

	self.txtLayerName:setText(ResTowerLayerName[self.layerData.resData[1].layer].layer_name)

	for i = #self.layerData.resData + 1, 21 do
		self.stageLevelContainerList[i]:setVisible(false)
	end

	self.txtGetedStarNum:setText(self.layerData.svrData.star_count)
	self.sliStarAward:setValue(self.layerData.svrData.star_count / self.layerData.svrData.maxStar)

	for i, v in ipairs(self.rewardPanelList) do
		self.rewardPanelList[i]:setLayerData(self.layerData, i)
	end
end

function StepTowerLevelDlg:jumpStage(jumpArg, grid)
	local args = utils.splitString(jumpArg, ",")

	self.layerData = CurAvatar:getStepTowerLayerData(tonumber(args[1]))

	self:setStepTowerLayerData(self.layerData, grid)

	self.jumpStageIdx = tonumber(args[2])

	self:setSelectStageByIdx(self.jumpStageIdx)
end

function StepTowerLevelDlg:jumpToCurStage()
	self.layerData = CurAvatar:getStepTowerLayerData(CurAvatar.stepTowerData.curPos.layer)

	self:setStepTowerLayerData(self.layerData)

	self.jumpStageIdx = CurAvatar.stepTowerData.curPos.stage

	self:setSelectStageByIdx(self.jumpStageIdx)
end

function StepTowerLevelDlg:setSelectStageByIdx(stageIdx)
	if self.stageChildList[stageIdx] then
		self.stageChildList[stageIdx]:onBtnSelectClick()
	end
end

function StepTowerLevelDlg:onBtnBattleClick()
	if self:checkCanBattleTower() then
		local battleState = GameFsm.getState(Const.STATE_BATTLE)
		local battlePreInfo = {}

		battlePreInfo.type = BattleConst.BATTLE_TYPE_STEPTOWER

		local tower = {}

		tower.layer = self.selStageData.resData.layer
		tower.level = self.selStageData.resData.level

		local curLayer = CurAvatar.stepTowerData.curPos.layer
		local curLevel = CurAvatar.stepTowerData.curPos.stage

		CurAvatar.isAtkCurStepLevel = tower.layer == curLayer and tower.level == curLevel
		battlePreInfo.data = tower

		battleState:initPreBattleInfo(self.selStageData.resData.pve_id, battlePreInfo)
		GameFsm.translateState(Const.STATE_BATTLE)
	end
end

function StepTowerLevelDlg:checkCanBattleTower()
	if self.selStageData.remainTimes > 0 then
		if self.selStageData.resData.power_cost <= CurAvatar.realPowerNum then
			return true
		else
			MsgManager.notice(Lang.get(30770))
		end
	else
		MsgManager.notice(Lang.get(30771))
	end

	return false
end

function StepTowerLevelDlg:onBtnClearClick()
	if self:checkCanBattleTower() then
		local sweepData = {}

		sweepData.layer = self.selStageData.resData.layer
		sweepData.level = self.selStageData.resData.level
		sweepData.times = 1

		RPC.towerSweep({
			sweepData
		})
	end
end

function StepTowerLevelDlg:setSelectStage(sender)
	for i, v in ipairs(self.stageChildList) do
		self.stageChildList[i].imgSel:setVisible(sender == v)
	end

	self.selStageData = sender.stageData

	if self.jumpStageIdx and self.jumpStageIdx ~= self.selStageData.resData.level then
		self.jumpStageIdx = -1
	end

	self:refreshStageInfo(self.selStageData.svrData, self.selStageData.resData)
end

function StepTowerLevelDlg:refreshStageInfo(svrData, resData)
	self.txtNeedPower:setText(self.selStageData.resData.power_cost)
	self.txtNeedPower2:setText(self.selStageData.resData.power_cost)

	local isBoss = self.selStageData.resData.need_record == 1
	local passNum = self.selStageData.svrData and self.selStageData.svrData.num or 0

	if isBoss then
		self.selStageData.remainTimes = self.selStageData.resData.times - passNum

		self.txtEnterNum:setText(self.selStageData.remainTimes .. "/" .. self.selStageData.resData.times)
		self.txtRewardTextTitle:setText(Lang.get(30772))
		self.starConditionList[1]:setText(Lang.get(30144))
		self.starConditionList[2]:setText(string.format(Lang.get(30142), self.selStageData.resData.time))
		self.starConditionList[3]:setText(string.format(Lang.get(30769), self.selStageData.resData.alive_num))
	else
		self.selStageData.remainTimes = CurAvatar:getIdByLayerStage(self.selStageData.resData.layer, self.selStageData.resData.level) <= CurAvatar.stepTowerRecord and 0 or 1

		self.txtRewardTextTitle:setText(Lang.get(995))
	end

	for i = 1, 3 do
		self.starConditionList[i]:setVisible(isBoss)

		local starImg = UIControls.Image(self, "LevelConditionPanel/Condition" .. i .. "/IconStar")

		starImg:setVisible(isBoss)
	end

	self.txtEnterNumTitle:setVisible(isBoss)
	self.txtEnterNum:setVisible(isBoss)
	self.btnClear:setVisible(isBoss and self.selStageData.svrData and self.selStageData.svrData.star == 3)
	self.btnBattle:setVisible(isBoss or not isBoss and self.selStageData.remainTimes > 0)
	self:refreshAwardGrid()
end

function StepTowerLevelDlg:refreshAwardGrid()
	for i, v in ipairs(self.awardGridList) do
		self.awardGridList[i]:destroy()
	end

	local rewardId = self.selStageData.resData.award
	local randItem = ResRandClient[rewardId]

	for i, v in ipairs(randItem.show_ids) do
		local awardGrid = UIControls.ItemGridChild(self, "LevelRewardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
		local gridItem = BaseObject.GetObject(v)

		if randItem.show_nums and randItem.show_nums[i] then
			gridItem.num = randItem.show_nums[i]
		else
			gridItem.num = 1
		end

		awardGrid:setObj(gridItem)
		table.insert(self.awardGridList, awardGrid)
	end
end

function StepTowerLevelDlg:onCloseClick()
	self:setVisible(false)
end

return StepTowerLevelDlg
