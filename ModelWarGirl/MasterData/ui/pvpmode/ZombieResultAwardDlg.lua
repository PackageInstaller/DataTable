-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ZombieResultAwardDlg.lua

local ResBossTower = require("ClientData/ResBossTower")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local ResRoleImageData = require("ClientData/ResRoleImageData")
local WorldBossCommon = require("Logic/WorldBoss/WorldBossCommon")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local BattleConst = require("Common/FrameBattle/BattleConst")
local strClassName = "ZombieResultAwardDlg"
local ZombieResultAwardDlg = Class(strClassName, UIControls.Window)
local ICON_PATH = "Atlas/BattleAtlas/BattleBossBoxAtlas"

MixinClass(ZombieResultAwardDlg, BattleAwardMixin, true)

function ZombieResultAwardDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function ZombieResultAwardDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
	self.txtNoneDesc = UIControls.Label(self, "BgPanel/NonePanel/TextDes")
	self.awardBox = {}

	local path = "BgPanel/AwardPanel/IconAward"

	for i = 1, 10 do
		local cell = UIControls.Panel(self, path .. i)

		cell:setVisible(false)

		cell.imgBg = UIControls.Image(self, path .. i)
		cell.imgTop = UIControls.Image(self, path .. i .. "/ImgTop")

		table.insert(self.awardBox, cell)
	end
end

function ZombieResultAwardDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		ZombieResultAwardDlg.super.bgmOn(self)
	end
end

function ZombieResultAwardDlg:show(itemBonus, fromMaze, bonusData)
	self.bonusData = bonusData
	self.fromMaze = fromMaze

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType

	if self.battleType == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		self:setWorldBossData(itemBonus)
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		self:setNewMazeData(itemBonus)
	else
		self:setBossTowerData(itemBonus, bonusData)
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local mvp = battleState:getMVPActor()

	if mvp then
		local portId = mvp.hero:getShowPortId()

		self.imgRole:showRole(portId)
	end

	self:playCustomBgm(self.battleType, "result_award")
end

function ZombieResultAwardDlg:setBossTowerData(itemBonus, bonusData)
	local count = bonusData.award - bonusData.award_pre
	local cell

	for i = 1, count do
		cell = self.awardBox[i]

		cell:setVisible(true)
		cell.imgBg:setImage(ICON_PATH .. bonusData.type, "BgSurpriseB")
		cell.imgTop:setImage(ICON_PATH .. bonusData.type, "BgSurpriseT")
	end

	self:initData(itemBonus)

	if count <= 0 then
		local layer = math.floor(self.bonusData.settle / 100000)
		local desc = ResBossTower[self.bonusData.type][layer].no_award_desc or ""

		self.txtNoneDesc:setText(desc)
		self:playAni("ShowBattleResultChallengeBossAwardNone", nil)
	else
		self:playAni("ShowBattleResultChallengeBossAward", nil)
	end
end

function ZombieResultAwardDlg:setWorldBossData(itemBonus)
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo and battleState.battlePreInfo.worldBossData then
		local info = ResWorldBoss[battleState.battlePreInfo.worldBossData.type or 1][battleState.battlePreInfo.worldBossData.layer or 1]

		itemBonus = ClientUtils.getObjectByRandId(info.awardid)
	end

	self:setAward(itemBonus or {})
	self:playAni("ShowBattleResultChallengeBossAwardWorld", nil)
end

function ZombieResultAwardDlg:setNewMazeData(itemBonus)
	local normalAwards = itemBonus[Const.BOSS_AWARD_TYPE_NORMAL]

	if normalAwards == nil then
		normalAwards = itemBonus[0] or {}
	end

	local passedAwards = itemBonus[Const.BOSS_AWARD_TYPE_PASSED] or {}
	local special_config = 16
	local actObj = CurAvatar:getNewMazeActivity()

	if actObj then
		special_config = actObj.actData.miscData.grid_special_config
	end

	self:setAward(passedAwards, 3, special_config)
	self:setAward(normalAwards)
end

function ZombieResultAwardDlg:initData(itemBonus)
	local normalAwards = itemBonus[Const.BOSS_AWARD_TYPE_NORMAL] or {}
	local passedAwards = itemBonus[Const.BOSS_AWARD_TYPE_PASSED] or {}

	self:setAward(passedAwards, 2)
	self:setAward(normalAwards)
end

function ZombieResultAwardDlg:setAward(awards, speType, speConfigId)
	local data = {
		path = "BgPanel/GridList/Content",
		items = awards,
		speType = speType,
		speConfigId = speConfigId
	}

	self:setAwardDataCommon(data)
end

function ZombieResultAwardDlg:onBtnConfirmClick()
	self:setVisible(false)

	if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		local actObj = CurAvatar:getNewMazeActivity()

		if actObj and CurAvatar.newMazeBattleMultiAward == nil then
			RPC.newMazeLayerNextReq(actObj.opId)
		end
	end

	if CurAvatar.needResetMaze and self.fromMaze then
		CurAvatar:resetMazeTip(true)
	else
		if not GameFsm.isInState(Const.STATE_BATTLE) then
			return
		end

		self:checkExitBattle(true)
	end
end

return ZombieResultAwardDlg
