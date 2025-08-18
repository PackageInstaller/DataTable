-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\BtnStepTowerFir.lua

local ResTower = require("ClientData/ResTower")
local BtnStepTowerSecBig = require("UI/StepTower/BtnStepTowerSecBig")
local strClassName = "BtnStepTowerFir"
local BtnStepTowerFir = Class(strClassName, UIControls.Child)

function BtnStepTowerFir:ctor()
	self:initUI()
end

function BtnStepTowerFir:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgBg = UIControls.Image(self, "Bg")
	self.txtLayerNum = UIControls.Label(self, "TextFloor")
	self.txtLayerProgress = UIControls.Label(self, "TextNum")
	self.imgIconStar = UIControls.Image(self, "IconStar")
	self.imgArrowState = UIControls.Image(self, "ArrowState")
	self.levelPanel = UIControls.Panel(self, "SmalLevellListPanel")
	self.btnLevelList = {}
end

function BtnStepTowerFir:onBtnSelfClick()
	if self.unLock then
		local selLayer = self.isExpension and 0 or self.resData[1].layer

		self.mWindow:foldLevelCallBack(selLayer)
	else
		MsgManager.notice(Lang.get(30766))
	end
end

function BtnStepTowerFir:foldLevelPanel(isExpension)
	if self.isExpension ~= isExpension then
		self.isExpension = isExpension

		local sprite = self.isExpension and "ArrowStageTowerDwn" or "ArrowStageTowerUp"
		local bgSprite = self.isExpension and "BgLevelBigSel" or "BgLevelBigNml"

		if not self.unLock then
			bgSprite = "BgLevelBigDis"
		end

		self.imgBg:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", bgSprite)
		self.imgArrowState:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", sprite)
		self.levelPanel:setVisible(self.isExpension)

		if self.isExpension and #self.btnLevelList == 0 then
			for level, levelData in ipairs(self.resData) do
				local btnStage = BtnStepTowerSecBig(self, "SmalLevellListPanel", "System/OtherBattle/BtnStageTowerLevelSec", 0, 0, true)

				btnStage:setStageData(self.svrData.stage[level], levelData)
				table.insert(self.btnLevelList, btnStage)
			end
		end
	elseif self.isExpension and #self.btnLevelList ~= 0 then
		for level, levelData in ipairs(self.resData) do
			self.btnLevelList[level]:setStageData(self.svrData.stage[level], levelData)
		end
	end
end

function BtnStepTowerFir:getPassTopLayerStage()
	local btnLayer = self.resData[1].layer

	if self.svrData.stage[#ResTower[btnLayer]] then
		local topStageData = self.svrData.stage[#ResTower[btnLayer]]

		if topStageData.star and topStageData.star ~= 0 and btnLayer == #ResTower and CurAvatar.stepTowerData.curPos.stage == #ResTower[btnLayer] then
			return true
		end

		return false
	else
		return false
	end
end

function BtnStepTowerFir:setLayerResData(resData)
	self.resData = resData

	local myLayer = self.resData[1].layer

	self.txtLayerNum:setText(myLayer)

	self.unLock = myLayer <= CurAvatar.stepTowerData.curPos.layer

	self.txtLayerProgress:setVisible(self.unLock)
	self.imgIconStar:setVisible(self.unLock)

	local maxStar = 0

	for i, v in ipairs(ResTower[myLayer]) do
		if v.need_record == 1 then
			maxStar = maxStar + 3
		end
	end

	self.svrData = CurAvatar.stepTowerLayerData[myLayer]
	self.svrData.maxStar = maxStar

	self.txtLayerProgress:setText(self.svrData.star_count .. "/" .. self.svrData.maxStar)

	local bgSprite = self.unLock and "BgLevelBigNml" or "BgLevelBigDis"

	self.imgBg:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", bgSprite)
end

function BtnStepTowerFir:selectLevelCallBack(levelInfo)
	for level, btnLevel in ipairs(self.btnLevelList) do
		if level == levelInfo.resData.level then
			btnLevel.imgSelf:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "BgLevelSmallSec")
			btnLevel.btnSelect:setEnable(false)

			self.selectLevelBtn = btnLevel
		else
			btnLevel:refreshSelfImg()
		end
	end

	self.mWindow:selectLayerCallBack(self)
	self.mWindow.panelLevelInfo:setLevelInfo(levelInfo.svrData, levelInfo.resData)
end

function BtnStepTowerFir:clearSelect()
	self.selectLevelBtn = nil

	for level, btnLevel in ipairs(self.btnLevelList) do
		btnLevel:refreshSelfImg()
	end
end

return BtnStepTowerFir
