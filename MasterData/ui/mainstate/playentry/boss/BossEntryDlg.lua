-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossEntryDlg.lua

local strClassName = "BossEntryDlg"
local BossEntryDlg = Class(strClassName, UIControls.Window)

function BossEntryDlg:ctor(...)
	self:initUI()
end

function BossEntryDlg:initUI(...)
	self.btnBoss1 = UIControls.Button(self, "MainInfoPanel/BtnBossTower1")

	self.btnBoss1:addEventClick(self.onBtnBoss1Click)

	self.btnBoss2 = UIControls.Button(self, "MainInfoPanel/BtnBossTower2")

	self.btnBoss2:addEventClick(self.onBtnBoss2Click)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.redHint1 = UIControls.RedDot(self, "MainInfoPanel/BtnBossTower1/IconNew")

	self.redHint1:addHint({
		UIConst.RD_HINT_CHALLENGE_BOSS
	})

	self.redHint2 = UIControls.RedDot(self, "MainInfoPanel/BtnBossTower2/IconNew")

	self.redHint2:addHint({
		UIConst.RD_HINT_CHALLENGE_BOSS_EXPAND
	})

	self.boss2ExtraSweepPanel = UIControls.Panel(self, "UpPanel")

	local extraSweepNum = CurAvatar:getActPrivilege(Const.ACT_PRIVILEGE_TYPE_NEW_BOSS_SWEEP, 0)

	self.boss2ExtraSweepPanel:setVisible(extraSweepNum > 0)
end

function BossEntryDlg:backToOldBoss(...)
	local ui = UIManager.getUI("bossChooseDlg", true)

	ui:jumpPage(1)
	ui:entryBoss(...)
end

function BossEntryDlg:backToBossExpand(...)
	local ui = UIManager.getUI("bossChooseDlg", true)

	ui:jumpPage(2)
	ui:entryExpandBoss(...)
end

function BossEntryDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function BossEntryDlg:onBtnBoss2Click(...)
	UIManager.getUI("bossChooseDlg", true):jumpPage(2)
end

function BossEntryDlg:onBtnBoss1Click(...)
	UIManager.getUI("bossChooseDlg", true):jumpPage(1)
end

return BossEntryDlg
