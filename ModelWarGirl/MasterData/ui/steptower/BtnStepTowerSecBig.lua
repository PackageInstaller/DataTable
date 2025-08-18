-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\BtnStepTowerSecBig.lua

local strClassName = "BtnStepTowerSecBig"
local BtnStepTowerSecBig = Class(strClassName, UIControls.Child)

function BtnStepTowerSecBig:ctor()
	self:initUI()
end

function BtnStepTowerSecBig:initUI()
	self.btnSelect = UIControls.Button(self, "")

	self.btnSelect:addEventClick(self.onBtnSelectClick)

	self.imgSelf = UIControls.Image(self, "")
	self.txtName = UIControls.Label(self, "Text")
	self.imgStar = UIControls.Image(self, "IconStar")
	self.imgLock = UIControls.Image(self, "IconLock")
	self.panelLimitLock = UIControls.Image(self, "LockPanel")
end

function BtnStepTowerSecBig:setStageData(svrData, resData)
	self.svrData = svrData
	self.resData = resData

	self.txtName:setText(self.resData.name)

	local myLayer = self.resData.layer
	local myStage = self.resData.level

	self.unLock = myLayer < CurAvatar.stepTowerData.curPos.layer or myLayer == CurAvatar.stepTowerData.curPos.layer and myStage <= CurAvatar.stepTowerData.curPos.stage

	self.imgLock:setVisible(not self.unLock)
	self.imgStar:setVisible(self.unLock)
	self.imgLock:setVisible(not self.unLock)
	self:refreshSelfImg()
	self:refreshLockPanelShow()
end

function BtnStepTowerSecBig:refreshLockPanelShow()
	local isDemon = self.resData.is_demon and self.resData.is_demon == 1
	local isShowLockPanel = isDemon and self.mWindow.priestsPerLevel < self.resData.unlock_level and not CurAvatar:checkStepTowerCanSweep(self.resData.layer, self.resData.level)

	self.panelLimitLock:setVisible(isShowLockPanel)
end

function BtnStepTowerSecBig:refreshSelfImg()
	self.btnSelect:setEnable(true)

	local selfSprite = ""
	local selectedLevel = self.mParent.selectLevelBtn and self.mParent.selectLevelBtn.resData.level or 0

	selfSprite = self.unLock and "BgLevelSmallNml" or "BgLevelSmallDis"

	if self.resData.level == selectedLevel then
		selfSprite = "BgLevelSmallSec"
	end

	self.imgSelf:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", selfSprite)

	local starSprite = ""

	if self.unLock and self.svrData ~= nil then
		if self.resData.level ~= selectedLevel then
			starSprite = self.svrData.star == 0 and "StageStar00" or "StageStarSel0" .. self.svrData.star
		else
			starSprite = "StageStar0" .. self.svrData.star
		end
	elseif self.unLock then
		starSprite = "StageStar00"
	end

	self.imgStar:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", starSprite)
end

function BtnStepTowerSecBig:onBtnSelectClick()
	self.mParent:selectLevelCallBack(self)
end

return BtnStepTowerSecBig
