-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPResultCleanDlg.lua

local strClassName = "PVPResultCleanDlg"
local PVPResultCleanDlg = Class(strClassName, UIControls.Window)
local ResultSidePanel = require("UI/PVPMode/ResultSidePanel")
local CapacityHelper = require("Common/FrameBattle/BattleObject/CapacityHelper")

function PVPResultCleanDlg:ctor()
	self:initUI()
end

function PVPResultCleanDlg:initUI()
	self.imgResult = UIControls.Image(self, "BgPanel/ImgResult")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.myInfo = ResultSidePanel(self, "BgPanel/SelfInfoPanel/")

	self.myInfo:exraUI()

	self.enemyInfo = ResultSidePanel(self, "BgPanel/EnemyInfoPanel/")
end

function PVPResultCleanDlg:show(myData, enemyData, add_items)
	self.attrs = CurAvatar.pvpSweepAward

	self:setEnemyInfo()

	self.win = true
	myData.name = CurAvatar:getPlayerName()
	myData.level = CurAvatar:getLevel()
	myData.head = CurAvatar.head
	myData.headFrameId = CurAvatar.headFrameId
	enemyData.name = self.enemyName
	enemyData.level = self.enemyLevel
	enemyData.head = self.enemyHead
	enemyData.headFrameId = self.enemyHeadFrameId
	self.myData = myData
	self.enemyData = enemyData
end

function PVPResultCleanDlg:showData(attack, defend)
	if self.reminded then
		return
	end

	self.reminded = true
	self.myData.changeScore = attack.score - attack.old_score
	self.myData.rank = attack.rank
	self.myData.score = attack.score
	self.myData.uid = CurAvatar.uid
	self.enemyData.score = defend.score
	self.enemyData.rank = defend.rank
	self.enemyData.uid = defend.uid

	self:initData(self.myData, self.enemyData)
end

function PVPResultCleanDlg:setEnemyInfo()
	self.enemyName = CurAvatar.cachedSweepData.name

	if CurAvatar.cachedSweepData.formation ~= nil then
		self.enemyPower = CapacityHelper.getFormationCapacity(CurAvatar.cachedSweepData.formation)
	else
		self.enemyPower = CurAvatar.cachedSweepData.power or 0
	end

	self.myPower = CurAvatar:getNowFormationCapacity()
	self.enemyLevel = CurAvatar.cachedSweepData.level
	self.enemyHead = CurAvatar.cachedSweepData.head
	self.enemyHeadFrameId = CurAvatar.cachedSweepData.headFrameId
end

function PVPResultCleanDlg:initData(myData, enemyData)
	self.myInfo:initData(myData, self.myPower)
	self.enemyInfo:initData(enemyData, self.enemyPower)
end

function PVPResultCleanDlg:onBtnConfirmClick()
	self:setVisible(false)
	UIManager.getUI("cleanResultDlg", true):onShow({}, self.attrs, {}, {}, {}, {})

	local ui = UIManager.getUI("pvpEnemyDlg", nil, false)

	if ui then
		ui:refreshList()
		ui:refreshTicketNum()
	end
end

return PVPResultCleanDlg
