-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleBattleHonor.lua

local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local strClassName = "BtnCircleBattleHonor"
local BtnCircleBattleHonor = Class(strClassName, UIControls.Child)

function BtnCircleBattleHonor:ctor()
	self:initUI()
end

function BtnCircleBattleHonor:initUI()
	self.btnCircleBattleHonor = UIControls.Button(self, "BtnFun")

	self.btnCircleBattleHonor:addEventClick(self.onBtnCircleBattleHonorClick)
end

function BtnCircleBattleHonor:onBtnCircleBattleHonorClick()
	local isLocked = ConditionLimitManager.inLimitState(ResClanBattleMisc[1].condition_id)

	if isLocked then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(ResClanBattleMisc[1].condition_id))

		return
	end

	if not CurAvatar:opActivityIsOpened(Const.ACT_TYPE_CIRCLE_BATTLE) then
		MsgManager.clientNotice(499)

		return
	end

	local circleBattleHonorDlg = UIManager.getUI("circleBattleHonorDlg", true)
	local honorData = CurAvatar:tryGetClanBattleHonor()

	if honorData then
		circleBattleHonorDlg:setHonorInfoData(honorData)
	end
end

return BtnCircleBattleHonor
