-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\BtnStepTowerSecSmall.lua

local strClassName = "BtnStepTowerSecSmall"
local BtnStepTowerSecSmall = Class(strClassName, UIControls.Child)

function BtnStepTowerSecSmall:ctor()
	self:initUI()
end

function BtnStepTowerSecSmall:initUI()
	self.btnSelect = UIControls.Button(self, "")

	self.btnSelect:addEventClick(self.onBtnSelectClick)

	self.imgSelf = UIControls.Image(self, "Bg")
	self.imgSel = UIControls.Image(self, "IconLevelSel")

	self.imgSel:setVisible(false)
end

function BtnStepTowerSecSmall:setStageData(svrData, resData)
	self.stageData = {}
	self.stageData.svrData = svrData
	self.stageData.resData = resData

	local myLayer = self.stageData.resData.layer
	local myStage = self.stageData.resData.level

	self.unLock = myLayer < CurAvatar.stepTowerData.curPos.layer or myLayer == CurAvatar.stepTowerData.curPos.layer and myStage <= CurAvatar.stepTowerData.curPos.stage

	self.btnSelect:setEnable(self.unLock)

	if not self.unLock then
		self.imgSelf:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "BtnTower02Dis")
	elseif CurAvatar:getIdByLayerStage(resData.layer, resData.level) <= CurAvatar.stepTowerRecord then
		self.imgSelf:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "BtnTower02Dis01")
	else
		self.imgSelf:setImage("Atlas/OtherBattleAtlas/StageTowerAtlas", "BtnTower02Nml")
	end
end

function BtnStepTowerSecSmall:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnStepTowerSecSmall:onBtnSelectClick(sender)
	if self.stageData and self.selectCallback then
		if CurAvatar:getIdByLayerStage(self.stageData.resData.layer, self.stageData.resData.level) > CurAvatar.stepTowerRecord then
			self.selectCallback(self)
		else
			MsgManager.notice(Lang.get(30767))
		end
	end
end

return BtnStepTowerSecSmall
