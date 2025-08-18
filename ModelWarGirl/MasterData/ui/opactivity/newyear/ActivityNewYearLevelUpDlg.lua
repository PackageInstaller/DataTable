-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearLevelUpDlg.lua

local strClassName = "ActivityNewYearLevelUpDlg"
local ActivityNewYearLevelUpDlg = Class(strClassName, UIControls.Window)

function ActivityNewYearLevelUpDlg:ctor()
	self:initUI()
end

function ActivityNewYearLevelUpDlg:initUI()
	self.textLevel = UIControls.Label(self, "BgPanel/CookLevelPanel/LevelPanel/TxtNum")
	self.textCookerDesc = UIControls.Label(self, "BgPanel/FunPanel/IconCook/TxtDes")
	self.panelCD = UIControls.Panel(self, "BgPanel/FunPanel/IconCd")
	self.textCDDesc = UIControls.Label(self, "BgPanel/FunPanel/IconCd/TxtDes")
	self.panelQueue = UIControls.Panel(self, "BgPanel/FunPanel/IconQueue")
	self.textQueueDesc = UIControls.Label(self, "BgPanel/FunPanel/IconQueue/TxtDes")
	self.panelNoReward = UIControls.Panel(self, "BgPanel/GiftPanel/ImgNothing")
	self.rewardGrids = {}
end

function ActivityNewYearLevelUpDlg:onShow(actData)
	self.actData = actData

	local levelData = actData.levelData
	local nowLevel = actData.level

	self.textLevel:setText(nowLevel)

	levelData = levelData[nowLevel]

	local posNum = actData:getLevelPosNum(nowLevel)
	local miscData = actData.miscData

	self.textCookerDesc:setText(string.format(miscData.unlock_des1, posNum))

	if levelData.time_up and levelData.time_up > 0 then
		self.panelCD:setVisible(true)
		self.textCDDesc:setText(string.format(miscData.unlock_des2, math.floor((levelData.time_up or 0) / 100)))
	else
		self.panelCD:setVisible(false)
	end

	if not actData:isQueueLocked(1) then
		self.panelQueue:setVisible(true)
		self.textQueueDesc:setText(miscData.unlock_des3)
	else
		self.panelQueue:setVisible(false)
	end

	ClientUtils.CreateBonusGrid(self, self.rewardGrids, "BgPanel/GiftPanel/GridPanel", levelData.reward_id, nil, nil, true)
end

function ActivityNewYearLevelUpDlg:destroy()
	ActivityNewYearLevelUpDlg.super.destroy(self)

	local activityNewYearDinnerDlg = UIManager.getUI("activityNewYearDinnerDlg", nil, false)

	if activityNewYearDinnerDlg then
		activityNewYearDinnerDlg:checkUnlockPos()
	end
end

return ActivityNewYearLevelUpDlg
