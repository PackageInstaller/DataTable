-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\StageInfoDlg.lua

local ResStage = require("ClientData/ResStage")
local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResStageMisc = require("ClientData/ResStageMisc")
local GridHookContainerChild = require("UI/Common/Grid/GridHookContainerChild")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local StageInfoDlg = Class("StageInfoDlg", UIControls.Window)

function StageInfoDlg:ctor()
	self:initUI()
end

function StageInfoDlg:initUI()
	self.bgImg = UIControls.RawImage(self, "MaskBg/BgImage")
	self.bgLine = UIControls.Image(self, "MaskBg/BgLine")
	self.bgScale = UIControls.Image(self, "MaskBg/BgScale")
	self.bgTitle = UIControls.Image(self, "MaskBg/BgTitle")
	self.textTitle = UIControls.Label(self, "MaskBg/BgTitle/Text")
	self.txtStageName = UIControls.Label(self, "MainInfoPanel/InfoPanel/TextLvName")
	self.txtStageDesc = UIControls.Label(self, "MainInfoPanel/InfoPanel/TextLvDes")
	self.txtStageNum = UIControls.Label(self, "MainInfoPanel/InfoPanel/TextLvNum")
	self.gridsItemAward = {}
	self.btnBattle = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle")
	self.btnVideo = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnVideo")

	self.btnVideo:addEventClick(self.onVideoClick)
	self.btnBattle:addEventClick(self.onBattleClick)

	self.btnBattleHelp = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnBattle/BtnHelp")

	self.btnBattleHelp:addEventClick(self.onBattleHelp)

	self.textStageEnergt = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnBattle/DurabilityPanel/TextNum")
	self.btnLeave = UIControls.Button(self, "BtnLeave")

	self.btnLeave:addEventClick(self.onLeaveClick)

	self.txtRecommendPower = UIControls.Label(self, "MainInfoPanel/InfoPanel/PowerPanel/TextPower/Text")
	self.txtMyPower = UIControls.Label(self, "MainInfoPanel/InfoPanel/PowerPanel/TextMyPower/Text")
	self.imgMyPowerIsEnough = UIControls.Image(self, "MainInfoPanel/InfoPanel/PowerPanel/TextMyPower/Icon")
	self.imgExtraDesc1 = UIControls.Image(self, "MainInfoPanel/InfoPanel/ImgDes1")
	self.textExtraDesc1 = UIControls.Label(self, "MainInfoPanel/InfoPanel/ImgDes1/Text")
	self.imgExtraDesc2 = UIControls.Image(self, "MainInfoPanel/InfoPanel/ImgDes2")
	self.textExtraDesc2 = UIControls.Label(self, "MainInfoPanel/InfoPanel/ImgDes2/Text")
	self.panelBoss = UIControls.Panel(self, "MainInfoPanel/ImgBoss")
	self.imgRole = UIControls.Role(self, "MainInfoPanel/MaskBoss/GridHeroPortrait", 0, 0)
	self.btnSkip = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnSkip")

	self.btnSkip:addEventClick(self.onBtnSkipClick)

	self.txtStageSkip = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnSkip/Text")
end

function StageInfoDlg:onOpen()
	StageInfoDlg.super.onOpen(self)
	self:showOneLevel(CurAvatar:getNextMainStageInfo())

	local showReplay = self.curLevelInfo.levelBoss == 1

	showReplay = showReplay and not ConditionLimitManager.inLimitState(Const.CONDITION_BATTLE_PASS_REPLAY)

	self.btnVideo:setVisible(showReplay and not Const.STAGE_RECOMMED_OPEN)
	self:refreshBattleSkip()
end

function StageInfoDlg:refreshBattleSkip(...)
	if CurAvatar:checkCanSkipStage() then
		self.btnSkip:setVisible(true)

		local showStageData = CurAvatar:getShowNextStagesData()

		if showStageData then
			self.txtStageSkip:setText(utils.format(Lang.get(103604), showStageData.chapter, showStageData.level))
		end
	else
		self.btnSkip:setVisible(false)
	end
end

function StageInfoDlg:showOneLevel(stageInfo)
	self.curLevelInfo = stageInfo

	local levelText = ClientUtils.getMainStageLevelStr(stageInfo.season, stageInfo.chapter, stageInfo.level)

	self.txtStageNum:setText(levelText)
	self.txtStageName:setText(self.curLevelInfo.name)
	self.txtStageDesc:setText(ClientUtils.ConvertContent(self.curLevelInfo.desc))

	for i, grid in ipairs(self.gridsItemAward) do
		grid:destroy()
	end

	self.gridsItemAward = {}

	local itemAwards = ResRandClient[self.curLevelInfo.award] or {}
	local itemAwardIDs = itemAwards.show_ids or {}
	local itemAwardNums = itemAwards.show_nums or {}

	for i, itemAwardID in ipairs(itemAwardIDs) do
		local clientItem = BaseObject.GetObject(itemAwardID, itemAwardNums[i] or 1)
		local grid = UIControls.getGridAwardContainer(self, "MainInfoPanel/AwardPanel/GridPanel")

		grid:setObj(clientItem)
		grid:setVisible(true)

		grid.mDisableWays = true

		table.insert(self.gridsItemAward, grid)
	end

	local actBonus = CurAvatar:getActivityStageAward(stageInfo)

	for _, awardInfo in ipairs(actBonus) do
		local awardId = awardInfo[1]
		local activityAwards = ResRandClient[awardId] or {}
		local activityAwardIDs = activityAwards.show_ids or {}
		local activityAwardNums = activityAwards.show_nums or {}

		for i, activityAwardID in ipairs(activityAwardIDs) do
			local clientItem = BaseObject.GetObject(activityAwardID, activityAwardNums[i] or 1)
			local grid = UIControls.getGridAwardContainer(self, "MainInfoPanel/AwardPanel/GridPanel")

			grid:setObj(clientItem)
			grid:setVisible(true)

			grid.mDisableWays = true

			grid:setActivitySpecialImage(awardInfo[2])
			table.insert(self.gridsItemAward, grid)
		end
	end

	if self.curLevelInfo.extra_desc1 then
		self.imgExtraDesc1:setVisible(true)
		self.textExtraDesc1:setText(self.curLevelInfo.extra_desc1)
	else
		self.imgExtraDesc1:setVisible(false)
	end

	if self.curLevelInfo.extra_desc1 then
		self.imgExtraDesc2:setVisible(true)
		self.textExtraDesc2:setText(self.curLevelInfo.extra_desc2)
	else
		self.imgExtraDesc2:setVisible(false)
	end

	if self.curLevelInfo.show_role_id then
		self.imgRole:showRole(self.curLevelInfo.show_role_id)
	end

	if self.curLevelInfo.levelBoss == 1 then
		self.bgImg:setImage("NoAlpha/MainBattle/BgWarningRed")
		self.bgLine:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLineRed")
		self.bgScale:setObjColor(ResColor.RED01)
		self.bgTitle:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgDullRed")
		self.textTitle:setFontColor(ResColor.RED02)
		self.txtStageDesc:setFontColor(ResColor.RED04)
		self.imgExtraDesc1:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLocationRed")
		self.imgExtraDesc2:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLocationRed")
		self.textExtraDesc1:setFontColor(ResColor.RED03)
		self.textExtraDesc2:setFontColor(ResColor.RED03)
		self.panelBoss:setVisible(true)
	else
		self.bgImg:setImage("NoAlpha/MainBattle/BgWarningGrey")
		self.bgLine:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLineGray")
		self.bgScale:setObjColor(ResColor.GREYLIGHT)
		self.bgTitle:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgDullGray")
		self.textTitle:setFontColor(ResColor.BLACKMAIN)
		self.txtStageDesc:setFontColor(ResColor.GREYWHITE)
		self.imgExtraDesc1:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLocationGray")
		self.imgExtraDesc2:setImage("Atlas/MainBattleAtlas/MainBattleAtlasNew", "BgLocationGray")
		self.textExtraDesc1:setFontColor(ResColor.GREYMIDDLE)
		self.textExtraDesc2:setFontColor(ResColor.GREYMIDDLE)
		self.panelBoss:setVisible(false)
	end

	local energy = CurAvatar.realEnergyNum or 0

	self.textStageEnergt:setText(energy)

	if energy == 0 then
		self.textStageEnergt:setFontColor(ResColor.RED)
	else
		self.textStageEnergt:setFontColor(ResColor.WHITE)
	end

	if self.curLevelInfo.pve_id and ResBattleConfig[self.curLevelInfo.pve_id] then
		local recommendLv = ResBattleConfig[self.curLevelInfo.pve_id].monster_level or 1
		local averageLv = CurAvatar:getFormationAverageLv()

		if Const.REVIEW_VERSION then
			self.txtRecommendPower:setText(Lang.get(1203) .. recommendLv)
			self.txtMyPower:setText(Lang.get(1203) .. averageLv)
		else
			self.txtRecommendPower:setText("LV." .. recommendLv)
			self.txtMyPower:setText("LV." .. averageLv)
		end

		local spriteMyPowerEnough = recommendLv <= averageLv and "IconAttr13" or "IconAttr12"

		self.imgMyPowerIsEnough:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", spriteMyPowerEnough)
	end

	if Const.STAGE_RECOMMED_OPEN then
		self.btnStageRecommend = UIControls.Button(self, "MainInfoPanel/InfoPanel/BtnRecommend")
		self.txtStageNextBoss = UIControls.Label(self, "MainInfoPanel/InfoPanel/BtnRecommend/TextNum")

		self.btnStageRecommend:addEventClick(self.onRecommendClick)

		if self.curLevelInfo.not_show_level_formation then
			self.btnStageRecommend:setVisible(false)

			return
		end

		self.btnStageRecommend:setVisible(true)

		if self.curLevelInfo.levelBoss == 1 then
			self.txtStageNextBoss:setVisible(false)
		else
			self.txtStageNextBoss:setVisible(true)

			self.nextBossLevelInfo = CurAvatar:getNextRecStageInfo()

			local levelText = ClientUtils.getMainStageLevelStr(self.nextBossLevelInfo.season, self.nextBossLevelInfo.chapter, self.nextBossLevelInfo.level)

			self.txtStageNextBoss:setText(levelText)
		end
	end
end

function StageInfoDlg:onLeaveClick(sender)
	self:getController():SetCloseAnimName("HideMainBattleLvInfo")
	self:setVisible(false)
end

function StageInfoDlg:onBattleHelp()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_STAGE_ENERGY)
end

local function EnterBuy()
	UIManager.getUI("buyCapacityDlg", true):initBuyType(2)
end

function StageInfoDlg:onBattleClick(sender)
	if CurAvatar == nil or self.curLevelInfo == nil or self.curLevelInfo.idx ~= CurAvatar.mainStageAtkedIdx + 1 then
		return
	end

	if CurAvatar.realEnergyNum == 0 then
		local hasItem = false
		local items = ResStageMisc[1].recover_item_ids

		for _, itemId in ipairs(items) do
			if CurAvatar:getItemNumById(itemId) > 0 then
				hasItem = true

				break
			end
		end

		if hasItem then
			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), ResClientNotice[192].notice, EnterBuy)
		else
			MsgManager.notice(ResClientNotice[193].notice)
		end

		return
	end

	self:playAni("HideMainBattleLvInfoToBattle", Slot(self.realEnterBattle, self), true)
end

function StageInfoDlg:onBtnSkipClick()
	UIManager.getUI("mainBattleSkipDlg", true)
	self:setVisible(false)
end

function StageInfoDlg:realEnterBattle()
	local stageInfo = {}

	stageInfo.stageData = {
		self.curLevelInfo.season,
		self.curLevelInfo.chapter,
		self.curLevelInfo.level,
		self.curLevelInfo
	}

	CurAvatar:enterFormation(self.curLevelInfo.pve_id, BattleConst.BATTLE_TYPE_STAGE, stageInfo)

	self.battleWaitCutOver = true

	self:setVisible(false)
end

function StageInfoDlg:destroy()
	if self.battleWaitCutOver and GameFsm.isInState(Const.STATE_BATTLE) then
		GameFsm.getCurState():onCutOver()
	end

	StageInfoDlg.super.destroy(self)
end

function StageInfoDlg:onVideoClick()
	local stageInfo = self.curLevelInfo

	if stageInfo then
		local season = stageInfo.season
		local chapter = stageInfo.chapter
		local level = stageInfo.level

		if not season or not chapter or not level then
			return
		end

		local progress = self.recordData and self.recordData.progress

		if progress and progress.season == season and progress.chapter == chapter and progress.level == level then
			self:onStageRecordResp(season, chapter, level, self.recordData.data)

			return
		end

		RPC.stageRecord(season, chapter, level)
	end
end

function StageInfoDlg:onRecommendClick()
	local ui = UIManager.getUI("battleRecommendDlg", true)
	local stageInfo = self.nextBossLevelInfo or self.curLevelInfo

	if stageInfo then
		local season = stageInfo.season
		local chapter = stageInfo.chapter
		local level = stageInfo.level

		if not season or not chapter or not level then
			return
		end

		local levelNum = ClientUtils.getMainStageLevelNum(stageInfo.season, stageInfo.chapter, stageInfo.level)

		if CurAvatar.formationRecData and CurAvatar.formationRecData[levelNum] and CurAvatar.formationRecData[levelNum].flag then
			ui:onRefreshUI(levelNum, CurAvatar.formationRecData[levelNum])
		else
			RPC.formationRecommendRankGet(1, levelNum)
		end
	end
end

function StageInfoDlg:onStageRecordResp(season, chapter, level, data)
	if not self.recordData then
		self.recordData = {}
	end

	local progress = {}

	progress.season = season
	progress.chapter = chapter
	progress.level = level

	local extra = {
		checkCanEnter = true,
		battleType = BattleConst.BATTLE_TYPE_STAGE,
		onBattleClick = Slot(self.onBattleClick, self)
	}

	self.recordData.progress = progress
	self.recordData.data = data

	UIManager.getUI("onceTowerRecordDlg", true):setData(Const.BATTLE_REPLAY_PASS, data, progress, extra)
end

function StageInfoDlg:recoveryFromReplay(replayEnv)
	local progress = replayEnv and replayEnv.battlePassProgress
	local data = replayEnv and replayEnv.replayData

	if Const.STAGE_RECOMMED_OPEN then
		local ui = UIManager.getUI("battleRecommendDlg", true)
		local levelNum = ClientUtils.getMainStageLevelNum(progress.season, progress.chapter, progress.level)

		if CurAvatar.formationRecData and CurAvatar.formationRecData[levelNum] and CurAvatar.formationRecData[levelNum].flag then
			ui:onRefreshUI(levelNum, CurAvatar.formationRecData[levelNum], Const.Battle_Recommend_TYPE.LEVEL_RECORD)
		end
	elseif progress and data then
		self:onStageRecordResp(progress.season, progress.chapter, progress.level, data)
	end
end

return StageInfoDlg
