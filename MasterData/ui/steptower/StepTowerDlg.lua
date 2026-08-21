-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerDlg.lua

local BtnStepTowerFir = require("UI/StepTower/BtnStepTowerFir")
local StepTowerLevelInfoPanel = require("UI/StepTower/StepTowerLevelInfoPanel")
local ResTower = require("ClientData/ResTower")
local strClassName = "StepTowerDlg"
local StepTowerDlg = Class(strClassName, UIControls.Window)

function StepTowerDlg:ctor()
	self:initUI()
end

function StepTowerDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.layerList = {}

	for i, v in ipairs(ResTower) do
		local btnStepTowerFir = BtnStepTowerFir(self, "LevelList/Viewport/Content", "System/OtherBattle/BtnStageTowerLevelFir", 0, 0, true)

		btnStepTowerFir:setLayerResData(ResTower[i])
		table.insert(self.layerList, btnStepTowerFir)
	end

	self.panelLevelInfo = StepTowerLevelInfoPanel(self, "MainInfoPanel/LevelInfoPanel")
	self.panelLevelInfoAni = UIControls.UIAni(self, "MainInfoPanel")
	self.scrollLayer = UIControls.ScrollView(self, "LevelList")
	self.jumpLevelIdx = 0
	self.jumpLayerIdx = 0
end

function StepTowerDlg:onOpen()
	StepTowerDlg.super.onOpen(self)

	self.priestsPerLevel = CurAvatar:getPriestsAverageLv()

	self:refreshPanelBtnState()
	self:refreshBtnLockPanelShow()
end

function StepTowerDlg:selectLayer(layerIdx, stageIdx, grid)
	if grid then
		self.srcGrid = grid
	end

	if self.layerList[layerIdx] then
		self.layerList[layerIdx]:setLayerResData(ResTower[layerIdx])
		self.layerList[layerIdx]:foldLevelPanel(true)
		self.layerList[layerIdx].btnLevelList[stageIdx]:onBtnSelectClick()
	end
end

function StepTowerDlg:refreshBtnLockPanelShow()
	for layerIdx, btnFir in pairs(self.layerList) do
		if btnFir.isExpension and btnFir.btnLevelList and #btnFir.btnLevelList > 0 then
			for _, btnLevel in pairs(btnFir.btnLevelList) do
				btnLevel:refreshLockPanelShow()
			end
		end
	end
end

function StepTowerDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_STEPTOWER)
end

function StepTowerDlg:refreshPanelBtnState()
	self.panelLevelInfo:refreshBtnState()
end

function StepTowerDlg:refreshForSweep(times)
	self.panelLevelInfo:refreshForSweep(times)
end

function StepTowerDlg:selectLayerCallBack(btnLayer)
	for layer, btnFir in ipairs(self.layerList) do
		if layer == btnLayer.resData[1].layer then
			self.selectLayerBtn = btnFir

			btnFir:foldLevelPanel(true)
		else
			btnFir:clearSelect()
			btnFir:foldLevelPanel(false)
		end
	end

	self:playShowLevelInfoPanel(true)
end

function StepTowerDlg:foldLevelCallBack(exLayer)
	for layer, btnFir in ipairs(self.layerList) do
		btnFir:foldLevelPanel(layer == exLayer)

		if layer ~= exLayer then
			btnFir:clearSelect()
		end
	end

	self:setContentAlign(exLayer)
	self:playShowLevelInfoPanel(false)
end

function StepTowerDlg:playShowLevelInfoPanel(isShow)
	if not isShow and self.isShowPanelLevelInfo then
		self.panelLevelInfoAni:startAni("HideStageTowerDetailWindow")
	end

	if isShow and not self.isShowPanelLevelInfo then
		self.panelLevelInfoAni:startAni("ShowStageTowerDetailWindow")
	end

	self.isShowPanelLevelInfo = isShow
end

function StepTowerDlg:jumpStage(jumpArg, grid)
	local args = utils.splitString(jumpArg, ",")
	local layer = tonumber(args[1])
	local level = tonumber(args[2])

	self.jumpLayerIdx = layer
	self.jumpLevelIdx = level

	self:selectLayer(layer, level, grid)
	self:setContentAlign(layer, level)
end

function StepTowerDlg:jumpToCurStage(notOnlyLayer)
	local layer = CurAvatar.stepTowerData.curPos.layer

	if not notOnlyLayer then
		self.layerList[layer]:onBtnSelfClick()

		return
	end

	self.jumpLevelIdx = CurAvatar.stepTowerData.curPos.stage

	self:selectLayer(layer, self.jumpLevelIdx)
	self:setContentAlign(layer, self.jumpLevelIdx)
end

function StepTowerDlg:playUnLockEffect(layerIdx)
	return
end

local CONTENT_ORI_Y = 7
local BIG_BTN_HEIGHT = 130
local SMALL_BTN_HEIGHT = 92
local VIEWPORT_HEIGHT = 812
local MAX_SMALL_BTN_SHOW = math.floor((VIEWPORT_HEIGHT - BIG_BTN_HEIGHT) / SMALL_BTN_HEIGHT)

function StepTowerDlg:setContentAlign(layer, stage)
	if layer ~= 0 then
		if self.corAlign then
			coroutine.stop(self.corAlign)

			self.corAlign = nil
		end

		self.corAlign = coroutine.start(self.yieldSetContentAlign, self, layer, stage)
	end
end

function StepTowerDlg:yieldSetContentAlign(layer, stage)
	coroutine.step()
	coroutine.step()
	self.scrollLayer:stopMovement()

	local bigHeight = (#ResTower - layer + 1) * BIG_BTN_HEIGHT
	local smallHeight = 0

	if ResTower[layer] then
		smallHeight = #ResTower[layer] * SMALL_BTN_HEIGHT
	end

	if bigHeight + smallHeight > VIEWPORT_HEIGHT then
		local moveDis = (layer - 1) * BIG_BTN_HEIGHT + CONTENT_ORI_Y

		if stage and stage > MAX_SMALL_BTN_SHOW then
			moveDis = (stage - MAX_SMALL_BTN_SHOW) * SMALL_BTN_HEIGHT + moveDis
		end

		self.scrollLayer:setContentY(moveDis)
	else
		self.scrollLayer:gotoVerticalEnd()
	end
end

function StepTowerDlg:onClose()
	StepTowerDlg.super.onClose(self)

	if self.corAlign then
		coroutine.stop(self.corAlign)

		self.corAlign = nil
	end
end

function StepTowerDlg:onCloseClick()
	self:setVisible(false)
end

return StepTowerDlg
