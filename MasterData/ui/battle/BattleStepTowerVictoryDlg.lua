-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleStepTowerVictoryDlg.lua

local ResHero = require("ClientData/ResHero")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResTower = require("ClientData/ResTower")
local ResColor = require("ClientData/ResColor")
local ResNewMazeBattle = require("ClientData/ResNewMazeBattle")
local strClassName = "BattleStepTowerVictoryDlg"
local BattleStepTowerVictoryDlg = Class(strClassName, UIControls.Window)

function BattleStepTowerVictoryDlg:ctor()
	self:initUI()
end

local STAR_NUM = 3

function BattleStepTowerVictoryDlg:initUI()
	self.textTime = UIControls.Label(self, "BgPanel/InfoPanel/TextBattleTime")
	self.btnRecord = UIControls.Button(self, "BgPanel/BtnBattleData")

	self.btnRecord:addEventClick(self.onBtnRecord)

	self.btnNext = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnNext:addEventClick(self.onBtnNext)

	self.btnAgain = UIControls.Button(self, "BgPanel/BtnAgain")

	self.btnAgain:addEventClick(self.onBtnAgain)

	self.starUIs = {}

	for index = 1, STAR_NUM do
		local txtNone = UIControls.Label(self, "BgPanel/ConditionPanel/Condition" .. index .. "/TextNone")
		local txtCondition = UIControls.Label(self, "BgPanel/ConditionPanel/Condition" .. index .. "/TextCondition")
		local imgStar = UIControls.Image(self, "BgPanel/ConditionPanel/Condition" .. index .. "/Icon")
		local imgStarResult = UIControls.Image(self, "ResultPanel/IconStar" .. index)
		local condition = UIControls.Image(self, "BgPanel/ConditionPanel/Condition" .. index)

		table.insert(self.starUIs, {
			txtNone,
			txtCondition,
			imgStar,
			imgStarResult,
			condition
		})
	end

	self.panelTips = UIControls.Panel(self, "BgPanel/TipsPanel")
	self.panelCondition = UIControls.Panel(self, "BgPanel/ConditionPanel")
	self.textTips = UIControls.Label(self, "BgPanel/TipsPanel/Text")

	if UIControls.checkControlFunc(self, "BgPanel/WorldBossPointPanel") then
		self.panelPoint = UIControls.Panel(self, "BgPanel/WorldBossPointPanel")
		self.textPoint = UIControls.Label(self, "BgPanel/WorldBossPointPanel/TextPoint")
	end

	if UIControls.checkControlFunc(self, "BgPanel/NoticePanel") then
		self.noticePanel = UIControls.Panel(self, "BgPanel/NoticePanel")

		self.noticePanel:setVisible(false)

		self.textDesc = UIControls.Label(self, "BgPanel/NoticePanel/TextDesc")
		self.btnMore = UIControls.Button(self, "BgPanel/NoticePanel/BtnMore")

		self.btnMore:addEventClick(self.onBtnMoreClick)
		self:checkShowNoticePanel()
	end
end

function BattleStepTowerVictoryDlg:checkShowNoticePanel()
	if self.noticePanel and #CurAvatar.pushAssistNoticeCache >= 1 then
		local pushData = CurAvatar.pushAssistNoticeCache[#CurAvatar.pushAssistNoticeCache]

		if pushData.condition == Const.GAME_ASSISTANT_TRIGGER_TYPE.BattleFail then
			self.noticePanel:setVisible(true)
			self.textDesc:setText(pushData.push_text)
			table.remove(CurAvatar.pushAssistNoticeCache, #CurAvatar.pushAssistNoticeCache)
		end
	end
end

function BattleStepTowerVictoryDlg:onBtnMoreClick()
	self.enterMain = true

	if GameFsm.isInState(Const.STATE_BATTLE) or GameFsm.isInState(Const.STATE_BATTLE_REPLAY) then
		GameFsm.getCurState().failEnhanceExit = 7
	end

	self:setVisible(false)
end

function BattleStepTowerVictoryDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		BattleStepTowerVictoryDlg.super.bgmOn(self)
	end
end

function BattleStepTowerVictoryDlg:onShow(battleType, bonus, itemBonus)
	if self.panelPoint then
		self.panelPoint:setVisible(false)
	end

	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType
	self.commonBonus = bonus.common
	self.itemBonus = itemBonus

	self:_startStageBattle(battleState:getBattleObjMgr())

	local battleConfig, tipsId

	if self.battleType == BattleConst.BATTLE_TYPE_STEPTOWER then
		self.bonus = bonus.spec.tower

		local layer = self.bonus.layer
		local level = self.bonus.level

		if not ResTower[layer] then
			return
		end

		local resData = ResTower[layer][level]

		battleConfig = ResBattleConfig[resData.pve_id or 1]
		tipsId = 4
	elseif self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		self.bonus = bonus.spec.new_maze

		local eventId = self.bonus.event_id
		local eventType = self.bonus.event_type
		local battleData = ResNewMazeBattle[eventId]

		battleConfig = ResBattleConfig[battleData.battle_id]

		if battleConfig.target_id then
			tipsId = 11
		end

		local actObj = CurAvatar:getNewMazeActivity()

		if battleData.need_settle == 1 and actObj and actObj.actData.curScore then
			if self.panelPoint then
				self.panelPoint:setVisible(true)
			end

			local score = actObj.actData.curScore
			local redheartNum = actObj.actData.redheart

			if redheartNum > 0 then
				score = score - redheartNum * actObj.actData.miscData.redheart_convert_score * 1000000
			end

			if score > 0 and self.textPoint then
				self.textPoint:setText(score)
			end
		end
	end

	if battleConfig and battleConfig.target_id then
		local targetInfo = ResBattleTarget[battleConfig.target_id]

		if targetInfo then
			self.panelCondition:setVisible(true)

			local bitList = ClientUtils.getBitsDictFromByteString(self.commonBonus.cond_bit)

			if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
				for index, uis in ipairs(self.starUIs) do
					if index == 1 then
						uis[5]:setVisible(true)

						local desc = targetInfo.targets[index].desc or ""

						if bitList[index] then
							uis[2]:setFontColor(ResColor.WHITE)
							uis[2]:setText(desc)
							uis[1]:setVisible(false)
							uis[3]:setVisible(true)

							self.isConditionComplete = true
						else
							uis[2]:setFontColor(ResColor.GREYLIGHT)
							uis[2]:setText(desc)
							uis[1]:setVisible(true)
							uis[3]:setVisible(false)
						end
					else
						uis[5]:setVisible(false)
					end
				end
			else
				for index, uis in ipairs(self.starUIs) do
					if index <= self.bonus.star then
						uis[4]:setVisible(true)
					else
						uis[4]:setVisible(false)
					end

					local desc = targetInfo.targets[index].desc or ""

					if bitList[index] then
						uis[2]:setFontColor(ResColor.WHITE)
						uis[2]:setText(desc)
						uis[1]:setVisible(false)
						uis[3]:setVisible(true)
					else
						uis[2]:setFontColor(ResColor.GREYLIGHT)
						uis[2]:setText(desc)
						uis[1]:setVisible(true)
						uis[3]:setVisible(false)
					end
				end
			end
		end
	else
		self.panelCondition:setVisible(false)
	end

	local tips = CurAvatar:getNoticeTips(tipsId)

	if tipsId and tips then
		if self.isConditionComplete then
			self.panelTips:setVisible(false)
		else
			self.panelTips:setVisible(true)
			self.textTips:setText(tips.tips_desc or "")
		end
	else
		self.panelTips:setVisible(false)
	end
end

function BattleStepTowerVictoryDlg:hideBtnAgain()
	self.btnAgain:setVisible(false)
end

function BattleStepTowerVictoryDlg:_startStageBattle(battleInfo)
	local time = 0

	if battleInfo then
		time = battleInfo:getBattleTime()
	end

	local timeSec = math.floor(time)

	self.textTime:setText(utils.calcTimeTxt(timeSec))
end

function BattleStepTowerVictoryDlg:onBtnRecord()
	UIManager.getUI("battleRecordDlg", true):onShow()
end

function BattleStepTowerVictoryDlg:playNextAni()
	self:playAni("ChangeBattleResultStageTower", nil)
end

function BattleStepTowerVictoryDlg:onBtnAgain()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	if battleState.battlePreInfo then
		CurAvatar:enterFormation(battleState.battleNo, self.battleType, battleState.battlePreInfo, 1)
		self:setVisible(false)
	end
end

function BattleStepTowerVictoryDlg:onBtnNext()
	if self.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
		UIManager.getUI("zombieResultAwardDlg", true):show(self.itemBonus, nil, self.bonus)
	else
		UIManager.getUI("stepTowerBattleAwardDlg", true):show(self.itemBonus, self.bonus)
	end

	self:setVisible(false)
end

function BattleStepTowerVictoryDlg:destroy()
	BattleStepTowerVictoryDlg.super.destroy(self)

	if not GameFsm.isInState(Const.STATE_BATTLE) then
		return
	end

	if self.enterMain then
		GameFsm.getCurState():exitBattle(true)
	end
end

return BattleStepTowerVictoryDlg
