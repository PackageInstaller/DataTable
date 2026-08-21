-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleLoseDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local ResColor = require("ClientData/ResColor")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local strClassName = "BattleLoseDlg"
local BattleLoseDlg = Class(strClassName, UIControls.Window)
local ICON_PATH = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew"
local ICON_PATH1 = "Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew1"
local ICON_CONFIRM = "Atlas/CommonAtlas/BtnAtlas2"

MixinClass(BattleLoseDlg, BattleAwardMixin, true)

function BattleLoseDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function BattleLoseDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.imgResult = UIControls.Image(self, "BgPanel/InfoPanel/ImgVictory")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnPanel/BtnBattleData")
	self.imgBgVictory = UIControls.Image(self, "BgPanel/InfoPanel/BgVictory")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnPanel/BtnConfirm", "Text")

	self.btnNext:addEventClick(self.onBtnNext)

	self.btnAgain = UIControls.Button(self, "BgPanel/BtnPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgain)

	if UIControls.checkControlFunc(self, "BgPanel/BtnPanel/BtnAgain/TipsPanel") then
		self.textAgainTips = UIControls.Label(self, "BgPanel/BtnPanel/BtnAgain/TipsPanel/TextNum")
		self.textConfirmTips = UIControls.Label(self, "BgPanel/BtnPanel/BtnConfirm/TipsPanel/TextNum")
		self.panelAgainTips = UIControls.Panel(self, "BgPanel/BtnPanel/BtnAgain/TipsPanel")
		self.panelConfirmTips = UIControls.Panel(self, "BgPanel/BtnPanel/BtnConfirm/TipsPanel")
	end

	self.panelPower = UIControls.Panel(self, "BgPanel/PowerUpPanel")
	self.btnPower1 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay1")

	self.btnPower1:addEventClick(self.onBtnPower1)

	self.redHintHero = UIControls.RedDot(self, "BgPanel/PowerUpPanel/BtnWay1/IconNew")

	self.redHintHero:addHint({
		UIConst.RD_HINT_HERO
	})

	self.btnPower2 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay2")

	self.btnPower2:addEventClick(self.onBtnPower2)

	self.btnPower3 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay3")

	self.btnPower3:addEventClick(self.onBtnPower3)

	self.btnPower4 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay4")

	self.btnPower4:addEventClick(self.onBtnPower4)

	self.drawCardRD = UIControls.Image(self, "BgPanel/PowerUpPanel/BtnWay4/IconNew")
	self.btnPower5 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay5")

	self.btnPower5:addEventClick(self.onBtnPower3)

	self.btnPower6 = UIControls.Button(self, "BgPanel/PowerUpPanel/BtnWay6")

	self.btnPower6:addEventClick(self.onBtnPower6)

	self.r = {}
	self.r.imgResult = UIControls.Image(self, "ResultPanel/ImgResult")
	self.r.imgBg = UIControls.Image(self, "ResultPanel/BgText")
	self.r.txt = UIControls.Label(self, "ResultPanel/Text")
	self.r.imgLineM = UIControls.Image(self, "ResultPanel/ImgLineM")
	self.r.imgLineL = UIControls.Image(self, "ResultPanel/ImgLineL")
	self.r.imgLineR = UIControls.Image(self, "ResultPanel/ImgLineR")
	self.r.imgLineLS = UIControls.Image(self, "ResultPanel/ImgLineLS")
	self.r.imgLineRS = UIControls.Image(self, "ResultPanel/ImgLineRS")
	self.panelStageEnergy = UIControls.Panel(self, "ResultPanel/DurabilityPanel")
	self.textEnergyPre = UIControls.Label(self, "ResultPanel/DurabilityPanel/TextNumPre")
	self.textEnergyNext = UIControls.Label(self, "ResultPanel/DurabilityPanel/TextNumNext")
	self.panelCost = UIControls.Panel(self, "BgPanel/BtnPanel/BtnAgain/CostPanel")
	self.textCost = UIControls.Label(self, "BgPanel/BtnPanel/BtnAgain/CostPanel/TextNum")
	self.panelTips = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.textTips = UIControls.Label(self, "BgPanel/TipsPanel/Text")
	self.btnRequestMaster = UIControls.Button(self, "BgPanel/BtnRequest")

	self.btnRequestMaster:addEventClick(self.onClickBtnRequestMaster)
end

function BattleLoseDlg:onShow(battleType, bonus, result, itemBonus)
	local battleState = GameFsm.getCurState()

	self.battleType = battleState.battleType

	self:_startStageBattle(battleState:getBattleObjMgr())

	if result == BattleConst.BATTLE_RESULT_SURRENDER or result == BattleConst.BATTLE_RESULT_LOSE or battleType == BattleConst.BATTLE_TYPE_BOSSTOWER or battleType == BattleConst.BATTLE_TYPE_THREE_TEAM_PVP then
		self.r.txt:setFontColor(ResColor.QUALITYBLUE)
		self.imgResult:setImage(ICON_PATH, "BgDefeated")
		self.r.imgResult:setImage(ICON_PATH, "BgDefeated")
		self.imgBgVictory:setImage(ICON_PATH, "BgDefeated1")
		self.r.imgBg:setImage(ICON_PATH1, "BgDefeatBigB")
		self.r.imgLineM:setImage(ICON_PATH1, "BgBlueBottom1")
		self.r.imgLineL:setImage(ICON_PATH1, "BgBlueBottom2")
		self.r.imgLineR:setImage(ICON_PATH1, "BgBlueBottom2")
		self.r.imgLineLS:setImage(ICON_PATH1, "BgBlueBottom3")
		self.r.imgLineRS:setImage(ICON_PATH1, "BgBlueBottom3")
		self:playAni("BattleResultFail", nil, true)
	else
		self.r.txt:setFontColor(ResColor.GREYMIDDLE)
		self.r.imgResult:setImage(ICON_PATH, "BgOvertime")
		self.imgResult:setImage(ICON_PATH, "BgOvertime")
		self.imgBgVictory:setImage(ICON_PATH, "BgOvertime1")
		self.r.imgBg:setImage(ICON_PATH1, "BgDefeatBigG")
		self.r.imgLineM:setImage(ICON_PATH1, "BgGreyBottom1")
		self.r.imgLineL:setImage(ICON_PATH1, "BgGreyBottom2")
		self.r.imgLineR:setImage(ICON_PATH1, "BgGreyBottom2")
		self.r.imgLineLS:setImage(ICON_PATH1, "BgGreyBottom3")
		self.r.imgLineRS:setImage(ICON_PATH1, "BgGreyBottom3")
		self:playAni("BattleResultFailTimeOut", nil, true)
	end

	if battleState.stateName ~= Const.STATE_BATTLE_REPLAY and (self.battleType == BattleConst.BATTLE_TYPE_STAGE or self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER or self.battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER or self.battleType == BattleConst.BATTLE_TYPE_ONCETOWER or self.battleType == BattleConst.BATTLE_TYPE_ACTIVITY or self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND or self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE) then
		if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			self.panelCost:setVisible(true)
			self.textCost:setText(CurAvatar.realEnergyNum)
			self.panelStageEnergy:setVisible(true)
			self.textEnergyPre:setText(CurAvatar.realEnergyNum + 1)
			self.textEnergyNext:setText(CurAvatar.realEnergyNum)

			if CurAvatar.realEnergyNum > 0 then
				self.btnAgain:setVisible(true)
			else
				self.btnAgain:setVisible(false)
			end
		else
			self.panelCost:setVisible(false)
			self.panelStageEnergy:setVisible(false)
			self.btnAgain:setVisible(true)
		end
	else
		self.panelCost:setVisible(false)
		self.btnAgain:setVisible(false)
	end

	if battleState.stateName == Const.STATE_BATTLE_REPLAY then
		self.btnPower1:setVisible(false)
		self.btnPower2:setVisible(false)
		self.btnPower3:setVisible(false)
		self.btnPower4:setVisible(false)
		self.btnPower5:setVisible(false)
		self.btnPower6:setVisible(false)
	else
		local tips

		if self.battleType == BattleConst.BATTLE_TYPE_STAGE then
			tips = CurAvatar:getNoticeTips(3)
		elseif self.battleType == BattleConst.BATTLE_TYPE_ONCETOWER then
			tips = CurAvatar:getNoticeTips(8)
		elseif self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
			tips = CurAvatar:getNoticeTips(5)
		end

		if tips then
			self.panelTips:setVisible(true)
			self.textTips:setText(tips.tips_desc or "")
		else
			self.panelTips:setVisible(false)
		end

		local isRentedBattle = false

		if self.battleType == BattleConst.BATTLE_TYPE_RENT then
			local rentData = battleState.battlePreInfo.rentData

			if rentData then
				isRentedBattle = rentData.teamId ~= nil
			end
		end

		if isRentedBattle then
			self.btnPower1:setVisible(false)
			self.btnPower2:setVisible(false)
			self.btnPower3:setVisible(true)
			self.btnPower4:setVisible(false)
			self.btnPower5:setVisible(false)
			self.btnPower6:setVisible(false)
		elseif self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
			self.btnPower1:setVisible(false)
			self.btnPower2:setVisible(false)
			self.btnPower3:setVisible(false)
			self.btnPower4:setVisible(false)
			self.btnPower5:setVisible(false)
			self.btnPower6:setVisible(false)
		else
			local isHide = false

			isHide = ConditionLimitManager.inLimitState(16)

			if isHide then
				self.btnPower1:setVisible(false)
				self.btnPower6:setVisible(false)
			else
				local isRecmmend = not ConditionLimitManager.inLimitState(84) and ConditionLimitManager.inLimitState(86)

				isRecmmend = isRecmmend and battleState.battleType == BattleConst.BATTLE_TYPE_STAGE

				self.btnPower6:setVisible(isRecmmend)
				self.btnPower1:setVisible(not isRecmmend)
			end

			isHide = ConditionLimitManager.inLimitState(20)
			isHide = isHide or ConditionLimitManager.inLimitState(27)

			self.btnPower2:setVisible(not isHide)

			isHide = ConditionLimitManager.inLimitState(15)
			isHide = isHide or not ConditionLimitManager.inLimitState(27)

			self.btnPower4:setVisible(not isHide)

			if not isHide then
				self:_checkDrawCardRD()
			end

			local canRecommendFormation = ConditionLimitManager.inLimitState(183)

			if canRecommendFormation and battleState.battleType == BattleConst.BATTLE_TYPE_STAGE and battleState.speData and battleState.speData.suppres and battleState.battleConfig and battleState.battleConfig.monster_level and battleState.speData.suppres >= battleState.battleConfig.monster_level then
				self.btnPower5:setVisible(true)
				self.btnPower3:setVisible(false)
			else
				self.btnPower5:setVisible(false)
			end
		end

		if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE and self.textConfirmTips then
			self.textConfirmTips:setText(ResNewMazeDisplay[13060024].desc)
			self.panelConfirmTips:setVisible(true)
		end
	end

	self:checkReplayRound()
	self:refreshBtnRequestMaster()
end

function BattleLoseDlg:hideLoseTips()
	self.panelTips:setVisible(false)
end

function BattleLoseDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleLoseDlg:checkReplayRound(...)
	if GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		local state = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		if state:hasNextRound() then
			self.btnNext:setText(Lang.get(30127))

			self.nextReplayRound = true
		else
			self.btnNext:setText(Lang.get(104))
		end
	end
end

function BattleLoseDlg:onBtnRecord()
	local isBattleBoss = self.battleType == BattleConst.BATTLE_TYPE_BOSSTOWER

	UIManager.getUI("battleRecordDlg", true):onShow(isBattleBoss)
end

function BattleLoseDlg:onBtnNext()
	if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		local isSettle = false
		local curState = GameFsm.getCurState()

		if curState.speData and curState.speData.newMazeData then
			local eventData = ResNewMazeBattle[curState.speData.newMazeData.eventId] or {}

			isSettle = eventData.need_settle == 1
		end

		if isSettle then
			self.enterMain = true

			self:setVisible(false)
		else
			local actObj = CurAvatar:getNewMazeActivity()

			if actObj and actObj:isValid() then
				if actObj.actData.redheart == 1 then
					local function yesFunc()
						self.enterMain = true

						self:setVisible(false)

						if actObj.actData.seasonCache and actObj.actData.seasonCache.cur_cycle == -1 and actObj.actData.hasGotFirstPassAward[1] then
							-- block empty
						else
							MsgManager.notice(ResNewMazeDisplay[13060024].desc)
						end

						RPC.newMazeBattleLoseExit(actObj.opId)
					end

					local str = ResNewMazeDisplay[13060048].desc

					UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), str, yesFunc, nil, -1)
				else
					self.enterMain = true

					self:setVisible(false)

					if actObj.actData.seasonCache and actObj.actData.seasonCache.cur_cycle == -1 and actObj.actData.hasGotFirstPassAward[1] then
						-- block empty
					else
						MsgManager.notice(ResNewMazeDisplay[13060024].desc)
					end

					RPC.newMazeBattleLoseExit(actObj.opId)
				end
			end
		end
	else
		self.enterMain = true

		self:setVisible(false)
	end
end

function BattleLoseDlg:playNextAni()
	self:playAni("ChangeBattleResultFail", nil)
end

function BattleLoseDlg:destroy()
	BattleLoseDlg.super.destroy(self)

	if self.nextReplayRound == true and GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		local state = GameFsm.getState(Const.STATE_BATTLE_REPLAY)

		state:playNextRound()

		return
	end

	if (GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY)) and self.enterMain then
		self:checkExitBattle()
	end
end

function BattleLoseDlg:onBtnAgain()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if self.battleType == BattleConst.BATTLE_TYPE_STAGE and CurAvatar.realEnergyNum <= 0 then
		MsgManager.notice(Lang.get(30128))

		return
	end

	if battleState.battlePreInfo then
		if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
			battleState.battlePreInfo.newMazeData.isRetry = 1
		end

		CurAvatar:enterFormation(battleState.battleNo, self.battleType, battleState.battlePreInfo, 1)
		self:setVisible(false)
	end
end

function BattleLoseDlg:onBtnPower1()
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 1
	end

	self:setVisible(false)
end

function BattleLoseDlg:onBtnPower2()
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 2
	end

	self:setVisible(false)
end

function BattleLoseDlg:onBtnPower3()
	self:onBtnAgain()
end

function BattleLoseDlg:onBtnPower4(...)
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 3
	end

	self:setVisible(false)
end

function BattleLoseDlg:onBtnPower6(...)
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 6
	end

	self:setVisible(false)
end

function BattleLoseDlg:hidePowerPanel(...)
	self.panelPower:setVisible(false)
end

function BattleLoseDlg:_checkDrawCardRD(...)
	local drawHint = RedDotManager.getKeyState(UIConst.RD_HINT_DRAWCARD)
	local standardCanDraw = CurAvatar:checkDrawItem(1, 10, true)

	self.drawCardRD:setVisible(drawHint or standardCanDraw ~= false)
end

function BattleLoseDlg:refreshBtnRequestMaster()
	local check = CurAvatar:checkShowApplyMasterBattleGuide(self.battleType)

	self.btnRequestMaster:setVisible(check)
end

function BattleLoseDlg:onClickBtnRequestMaster()
	self.btnRequestMaster:setEnable(false)

	local stageInfo = CurAvatar:getNextMainStageInfo()
	local stage = stageInfo.season * 10000 + stageInfo.chapter * 100 + stageInfo.level

	RPC.apprenticeRequestBattleGuide(CurAvatar.master.uid, stage)
end

return BattleLoseDlg
