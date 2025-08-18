-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleActivityResultWinDlg.lua

local ResOpActivityPlotDetail = require("ClientData/ResOpActivityPlotDetail")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local strClassName = "BattleActivityResultWinDlg"
local BattleActivityResultWinDlg = Class(strClassName, UIControls.Window)

MixinClass(BattleActivityResultWinDlg, BattleAwardMixin, true)

function BattleActivityResultWinDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
end

function BattleActivityResultWinDlg:initUI(...)
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnBattleData")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnNext:addEventClick(self.onBtnNext)

	self.btnAgain = UIControls.Button(self, "BgPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgain)

	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.conditionUI = {}

	for i = 1, 3 do
		local info = {}
		local path = "BgPanel/ConditionPanel/FightTarget" .. i

		info.panelCon = UIControls.Panel(self, path)
		info.txtCondition = UIControls.Label(self, path .. "/TextCondition")
		info.txtGet = UIControls.Label(self, path .. "/TextGet")
		info.txtNone = UIControls.Label(self, path .. "/TextNone")

		table.insert(self.conditionUI, info)
	end
end

function BattleActivityResultWinDlg:onShow(battleType, finish, result, itemBonus)
	self.bonus = finish.spec.plot
	self.battleType = battleType

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self:_startStageBattle(battleState:getBattleObjMgr())

	local bitList = ClientUtils.getBitsDictFromByteString(self.bonus.cond_bit)
	local battleConfig = battleState.battleConfig or {}
	local targetId = battleConfig.target_id
	local targetData = ResBattleTarget[targetId] or {}
	local targetConfig = targetData.targets

	if targetConfig then
		for i, conUI in ipairs(self.conditionUI) do
			if targetConfig[i] then
				conUI.txtCondition:setText(targetConfig[i].desc or "")
			else
				conUI.panelCon:setVisible(false)
			end

			conUI.txtGet:setVisible(bitList[i] == true)
			conUI.txtNone:setVisible(bitList[i] ~= true)
		end
	end
end

function BattleActivityResultWinDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleActivityResultWinDlg:onBtnAgain()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo then
		CurAvatar:enterFormation(battleState.battleNo, self.battleType, battleState.battlePreInfo, 1)
		self:setVisible(false)
	end
end

function BattleActivityResultWinDlg:onBtnRecord()
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function BattleActivityResultWinDlg:playNextAni()
	self:playAni("ChangeBattleActivityFlotTower", nil)
end

function BattleActivityResultWinDlg:onBtnNext()
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	self:checkExitBattle(true)
end

return BattleActivityResultWinDlg
