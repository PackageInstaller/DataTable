-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\OpActivity\\ActivityDataCircleBattle.lua

local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ActivityDataBase = require("Avatar/AvatarMixins/OpActivity/ActivityDataBase")
local UserData = require("Helper/UserData")
local ActivityDataCircleBattle = Class("ActivityDataCircleBattle", ActivityDataBase)

function ActivityDataCircleBattle:ctor(...)
	return
end

function ActivityDataCircleBattle:updateClientData(actId)
	self.actId = actId
end

function ActivityDataCircleBattle:registerRDEvent()
	ActivityDataCircleBattle.super.registerRDEvent(self)

	if self.actObject.redDotId then
		RedDotManager.setKeyRelation(UIConst.RD_HINT_CIRCLE_BATTLE, self.actObject.redDotId)
	end
end

function ActivityDataCircleBattle:unRegistRDEvent()
	ActivityDataCircleBattle.super.unRegistRDEvent(self)

	if self.actObject.redDotId then
		RedDotManager.delKeyRelation(UIConst.RD_HINT_CIRCLE_BATTLE, self.actObject.redDotId)
	end
end

function ActivityDataCircleBattle:updateSystemData(systemItem)
	return
end

function ActivityDataCircleBattle:updateMgrData(opActivityMgrItem)
	self.mgrData = utils.deepcopy(opActivityMgrItem)
	self.state = self.mgrData.state

	if CurAvatar.circleBattleNeedReconnectFlag then
		CurAvatar:checkCircleBattleState()
	end
end

function ActivityDataCircleBattle:isDataReady(...)
	return self.mgrData ~= nil and self.state ~= nil
end

function ActivityDataCircleBattle:updateRoleData(roleData, isUpdate)
	return
end

function ActivityDataCircleBattle:getCirlceBattleSeason()
	if self.mgrData and self.mgrData.specdata and self.mgrData.specdata.clan_battle and self.mgrData.specdata.clan_battle.season then
		return self.mgrData.specdata.clan_battle.season
	end
end

function ActivityDataCircleBattle:willEnd()
	local leftTime = self:getLeftTimeToFreeze()

	return leftTime >= 0 and leftTime <= self:willEndCountDown()
end

function ActivityDataCircleBattle:willEndCountDown()
	return 64800
end

function ActivityDataCircleBattle:getLeftTimeToFreeze(...)
	if self.state == Const.OPACT_STATE_CLOSE or self.state == Const.OPACT_STATE_FREEZE then
		return -1
	end

	if self.mgrData then
		return self.mgrData.time.freezetime - ClientUtils.getServerTime()
	end

	return -1
end

function ActivityDataCircleBattle:getLeftTimeToEnd(...)
	if self.state == Const.OPACT_STATE_CLOSE then
		return -1
	end

	if self.mgrData then
		return self.mgrData.time.closetime - ClientUtils.getServerTime()
	end

	return -1
end

function ActivityDataCircleBattle:getEndTime(...)
	return self:getLeftTimeToEnd()
end

function ActivityDataCircleBattle:onStateChange(opActState)
	self.state = opActState

	if opActState == Const.OPACT_STATE_OPEN then
		self:_onStateOpen()
	elseif opActState == Const.OPACT_STATE_CLOSE then
		self.onStateClose()
	elseif opActState == Const.OPACT_STATE_FREEZE then
		self:_onStateFreeze()
	end
end

function ActivityDataCircleBattle:_onStateOpen(...)
	CurAvatar:checkCircleBattleActionRedHint()
end

function ActivityDataCircleBattle:_onStateFreeze(...)
	local circleBattleMainDlg = UIManager.getUI("circleBattleMainDlg", nil, false)

	if circleBattleMainDlg then
		circleBattleMainDlg:refreshCirleBattleInfo()
		circleBattleMainDlg:refreshTime()
	end
end

local STATE_UI = {
	"circleBattleMonsterInfo1Dlg",
	"circleBattleMonsterInfo2Dlg",
	"circleBattleMonsterInfo3Dlg",
	"circleBattleRuneTipDlg",
	"circleBattleEndDlg",
	"circleBattleBoxDlg",
	"circleBattleConfirmDlg",
	"circleBattleCircleSkillDlg",
	"circleBattleStratageDlg",
	"circleBattleRuneDlg",
	"circleBattleLoadingDlg",
	"circleBattleWelcomeDlg",
	"circleBattleProgressDlg",
	"circleBattlePointRecordDlg",
	"circleBattlePointAwardDlg",
	"circleBattleHonorDlg",
	"circleBattleActionRecordDlg",
	"circleBattleTalentDlg",
	"circleBattleBossAwardDlg",
	"circleBattleHeroListDlg",
	"circleBattleChangeModelDlg",
	"circleBattleMainDlg"
}

local function _outCircleBattleState(...)
	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		for _, name in ipairs(STATE_UI) do
			local ui = UIManager.tryGetUI(name)

			if ui then
				ui:setVisible(false)
			end
		end

		GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
	end
end

function ActivityDataCircleBattle.onStateClose(...)
	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		local content = Lang.get(37178)

		UIManager.showConfirm(UIConst.CONFIRM_ONEBTN, "", content, _outCircleBattleState)
	end
end

function ActivityDataCircleBattle:getLimitId(...)
	return ResClanBattleMisc[1].condition_id
end

function ActivityDataCircleBattle:registEndEvent(...)
	ActivityDataCircleBattle.super.registEndEvent(self)
end

function ActivityDataCircleBattle:unRegistEndEvent(...)
	ActivityDataCircleBattle.super.unRegistEndEvent(self)
end

local OPEN = {
	[Const.OPACT_STATE_OPEN] = 1
}
local FREEZE_OPEN = {
	[Const.OPACT_STATE_OPEN] = 1,
	[Const.OPACT_STATE_FREEZE] = 1
}
local RPC_CALL_CONFIG = {
	clanBattleEnter = FREEZE_OPEN,
	clanBattleExit = FREEZE_OPEN,
	clanBattleOccupyGrid = OPEN,
	clanBattleCancelGrid = OPEN,
	clanBattleOccupyMonster = OPEN,
	clanBattleCancelMonster = OPEN,
	clanBattleCancelMonster = OPEN,
	clanBattleOpenGrid = OPEN,
	clanBattleNextLayer = OPEN,
	clanBattleBuySkill = OPEN,
	clanBattleUseSkill = OPEN,
	clanBattleSetModel = FREEZE_OPEN,
	clanBattleGiveOrder = OPEN,
	clanBattleSetTarget = OPEN,
	clanBattleScoreInfuse = FREEZE_OPEN,
	clanBattleGetScoreLog = FREEZE_OPEN,
	clanBattleGetLog = FREEZE_OPEN,
	clanBattleGetClanAchieveAward = FREEZE_OPEN,
	clanBattleGetMemberAchieveAward = FREEZE_OPEN
}

function ActivityDataCircleBattle:tryCallRpc(funcName, ...)
	local config = RPC_CALL_CONFIG[funcName]

	if config then
		if config[self.state] then
			RPC[funcName](self.actObject.opId, ...)
		else
			MsgManager.notice(self:getNoticeDesc())
		end
	end
end

function ActivityDataCircleBattle:getNoticeDesc()
	if self.state == Const.OPACT_STATE_CLOSE then
		return Lang.get(32785)
	elseif self.state == Const.OPACT_STATE_FREEZE then
		return Lang.get(32793)
	else
		return Lang.get(37179)
	end
end

function ActivityDataCircleBattle:_getKey(key)
	local uid = CurAvatar.uid or ""

	return "_key" .. uid .. key
end

function ActivityDataCircleBattle:getRunTimeData(key)
	local saveKey = self:_getKey(key)

	return ActivityDataCircleBattle[saveKey]
end

function ActivityDataCircleBattle:setRunTimeData(key, v)
	local saveKey = self:_getKey(key)

	ActivityDataCircleBattle[saveKey] = v
end

function ActivityDataCircleBattle:isTodayRecord(key)
	local time = self:getRunTimeData(key)

	time = time or 0

	return ClientUtils.isTickToday(time)
end

function ActivityDataCircleBattle:setTodayRecord(key)
	local time = ClientUtils.getServerTime()

	self:setRunTimeData(key, time)
end

return ActivityDataCircleBattle
