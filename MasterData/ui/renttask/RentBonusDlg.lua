-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RentTask\\RentBonusDlg.lua

local CommonBonusDlg = require("UI/Common/CommonBonusDlg")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local strClassName = "RentBonusDlg"
local RentBonusDlg = Class(strClassName, CommonBonusDlg)

function RentBonusDlg:onShow(notifyType, attrs, items, heros, equip, artifact, relic, taskId)
	RentBonusDlg.super.onShow(self, notifyType, attrs, items, heros, equip, artifact, relic)
	self:_initRentUI()

	local taskInfo = RentTaskUtils.getTaskData(taskId)

	if not taskInfo then
		return
	end

	local taskType = taskInfo.type

	if taskType == Const.RENT_TASK_TYPE.Normal then
		self.rootPanel:playStateAnimator("EasyShowAwardDifficultyPanel")
	elseif taskType == Const.RENT_TASK_TYPE.Advanced then
		self.rootPanel:playStateAnimator("NormalShowAwardDifficultyPanel")
	elseif taskType == Const.RENT_TASK_TYPE.Rare or taskType == Const.RENT_TASK_TYPE.ExtraRare then
		self.rootPanel:playStateAnimator("HardShowAwardDifficultyPanel")
	end

	self.rareBtn:setVisible(taskType == Const.RENT_TASK_TYPE.ExtraRare)

	local portList = taskInfo.port_list

	if taskType == Const.RENT_TASK_TYPE.Normal then
		self.singleBossPanel:setVisible(true)
		self.multiBossPanel:setVisible(false)

		if portList[1] then
			self.singleBossRole:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
		end
	else
		self.singleBossPanel:setVisible(false)
		self.multiBossPanel:setVisible(true)

		if #portList == 2 then
			self.multiBossRole1:showRole(portList[1], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
			self.multiBossRole2:showRole(portList[2], UIConst.ROLEIMAGE_SHOWTYPE_RENT_TASK)
		end
	end
end

function RentBonusDlg:_initRentUI()
	if self.rentUIInited then
		return
	end

	self.rootPanel = UIControls.Panel(self, "Bg/DifficultyPanel")
	self.singleBossPanel = UIControls.Panel(self, "Bg/DifficultyPanel/BossPanelOne")
	self.singleBossRole = UIControls.Role(self, "Bg/DifficultyPanel/BossPanelOne/GridHeroPortraitPanel/HeroPanel", 0, 0)
	self.multiBossPanel = UIControls.Panel(self, "Bg/DifficultyPanel/BossPanelTwo")
	self.multiBossRole1 = UIControls.Role(self, "Bg/DifficultyPanel/BossPanelTwo/GridHeroPortraitPanel1/HeroPanel")
	self.multiBossRole2 = UIControls.Role(self, "Bg/DifficultyPanel/BossPanelTwo/GridHeroPortraitPanel2/HeroPanel")
	self.rareBtn = UIControls.Button(self, "Bg/BtnRare")
	self.rentUIInited = true
end

return RentBonusDlg
