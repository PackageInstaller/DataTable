-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\WorldBoss\\WorldBossEliteResultAwardDlg.lua

local ResWorldBoss = require("ClientData/ResWorldBoss")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local BattleConst = require("Common/FrameBattle/BattleConst")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local strClassName = "WorldBossEliteResultAwardDlg"
local WorldBossEliteResultAwardDlg = Class(strClassName, UIControls.Window)

MixinClass(WorldBossEliteResultAwardDlg, BattleAwardMixin, true)

function WorldBossEliteResultAwardDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function WorldBossEliteResultAwardDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
end

function WorldBossEliteResultAwardDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		WorldBossEliteResultAwardDlg.super.bgmOn(self)
	end
end

function WorldBossEliteResultAwardDlg:show(eliteSore)
	self.eliteSore = eliteSore or 0

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		self:setWorldBossData()
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local mvp = battleState:getMVPActor()

	if mvp then
		local portId = mvp.hero:getShowPortId()

		self.imgRole:showRole(portId)
	end

	self:playCustomBgm(self.battleType, "result_award")
end

function WorldBossEliteResultAwardDlg:setWorldBossData(itemBonus)
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo and battleState.battlePreInfo.worldBossData and battleState.battlePreInfo.worldBossData.eliteMode then
		local info = ResWorldBoss[battleState.battlePreInfo.worldBossData.type or 1][battleState.battlePreInfo.worldBossData.layer or 1]
		local awardid2 = self:getEliteAwardId()

		itemBonus = {
			ClientUtils.getObjectByRandId(info.awardid),
			ClientUtils.getObjectByRandId(awardid2)
		}
	end

	self:initData(itemBonus or {})
	self:playAni("ShowBattleResultChallengeBossAwardWorld", nil)
end

function WorldBossEliteResultAwardDlg:getEliteAwardId()
	local infos = WorldBossCommon.getEliteAwardInfos()
	local score = self.eliteSore

	if score >= infos[1].score then
		return infos[1].awardid
	end

	for i = #infos, 1, -1 do
		if score < infos[i].score then
			local index = math.min(#infos, i + 1)

			return infos[index].awardid or 1
		end
	end

	return 1
end

function WorldBossEliteResultAwardDlg:initData(itemBonus)
	for i = 1, #itemBonus do
		local normalAwards = itemBonus[i] or {}

		self:setAward(i, normalAwards)
	end
end

function WorldBossEliteResultAwardDlg:setAward(index, awards, speType, speConfigId)
	local listName = "BgPanel/GridList/Content"

	if index ~= 1 then
		listName = "BgPanel/GridEliteList/Content"
	end

	local data = {
		items = awards,
		speType = speType,
		path = listName,
		speConfigId = speConfigId
	}

	self:setAwardDataCommon(data)
end

function WorldBossEliteResultAwardDlg:onBtnConfirmClick()
	self:setVisible(false)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	self:checkExitBattle(true)
end

return WorldBossEliteResultAwardDlg
