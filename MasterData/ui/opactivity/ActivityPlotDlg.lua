-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityPlotDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityPlotStage = require("ClientData/ResOpActivityPlotStage")
local ResTigerBandit = require("ClientData/ResTigerBandit")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local PlotMainStageCell = Class("PlotMainStageCell", UIControls.Child)

function PlotMainStageCell:ctor()
	self.buttonNormal = UIControls.Button(self, "FlotCellNml")

	self.buttonNormal:addEventClick(self.onNormalClick)

	self.textNormal = UIControls.Label(self, "FlotCellNml/Text")
	self.imgNmlState = UIControls.Panel(self, "FlotCellNml/ImgNml")
	self.imgNowState = UIControls.Panel(self, "FlotCellNml/ImgHigh")
	self.buttonDis = UIControls.Button(self, "FlotCellDis")

	self.buttonDis:addEventClick(self.onDisClick)

	self.textDis = UIControls.Label(self, "FlotCellDis/Text")
	self.textDisCondition = UIControls.Label(self, "FlotCellDis/Text1")
end

function PlotMainStageCell:setData(stageData, state)
	self.stageData = stageData

	if state == Const.COMMON_STATE_LOCK then
		self.buttonDis:setVisible(true)
		self.textDis:setText(stageData.stage_title or "")
		self.buttonNormal:setVisible(false)
	else
		self.buttonDis:setVisible(false)
		self.buttonNormal:setVisible(true)
		self.textNormal:setText(stageData.stage_title or "")
		self.imgNmlState:setVisible(state ~= Const.COMMON_STATE_NEXT)
		self.imgNowState:setVisible(state == Const.COMMON_STATE_NEXT)
	end
end

function PlotMainStageCell:onNormalClick()
	local pageData = {
		self.mParent.clientTemplateData,
		self.mParent.actObj
	}

	UIManager.getUI("activityPlotInfoDlg", true):onShowPlotInfo(pageData, self.stageData.stage)
end

function PlotMainStageCell:onDisClick()
	local unlockTime = self.mParent.actObj.actData:getStageUnlockedTime(self.stageData.stage)
	local openTime = unlockTime - ClientUtils.getServerTime()

	if openTime > 0 then
		local notice = string.format(self.stageData.unlock_desc_pre, utils.calcTimeTxt(openTime))

		MsgManager.notice(notice)
	else
		self:onNormalClick()
	end
end

local strClassName = "ActivityPlotDlg"
local ActivityPlotDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityPlotDlg, ActivityPanelMixin)

function ActivityPlotDlg:initUI()
	self.miscData = self.actObj.actData.miscData
	self.aniPanel = UIControls.UIAni(self, "MainInfoPanel")
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnPlotAchieve = UIControls.Button(self, "MainInfoPanel/BtnTargetInfo")

	self.btnPlotAchieve:addEventClick(self.onBtnPlotAchieve)

	self.achieveRD = UIControls.RedDot(self, "MainInfoPanel/BtnTargetInfo/IconNew")
	self.btnPlotShop = UIControls.Button(self, "MainInfoPanel/BtnActStore")

	self.btnPlotShop:addEventClick(self.onBtnPlotShop)

	self.shopRD = UIControls.RedDot(self, "MainInfoPanel/BtnActStore/IconNew")
	self.btnBingo = UIControls.Button(self, "MainInfoPanel/BtnBingo")

	self.btnBingo:addEventClick(self.onBtnBingo)

	self.bingoRD = UIControls.RedDot(self, "MainInfoPanel/BtnBingo/IconNew")

	if self.miscData and self.miscData.jump_bingo_activity and CurAvatar:isActivityValid(self.miscData.jump_bingo_activity) then
		local bingoActObj = CurAvatar:getActivityObj(self.miscData.jump_bingo_activity)

		if bingoActObj.redDotId then
			self.bingoRD:addHint({
				bingoActObj.redDotId
			})
		end
	end

	self.btnBattleMode = UIControls.Button(self, "MainInfoPanel/BtnFight")
	self.imgNewBattle = UIControls.Panel(self, "MainInfoPanel/BtnFight/IconNew")

	self.btnBattleMode:addEventClick(self.onBtnBattleMode)

	self.btnPlotMode = UIControls.Button(self, "MainInfoPanel/BtnFlot")
	self.imgNewPlot = UIControls.Panel(self, "MainInfoPanel/BtnFlot/IconNew")

	self.btnPlotMode:addEventClick(self.onBtnPlotMode)

	self.btnSkipFirstAnim = UIControls.Button(self, "BtnSkipAni")

	self.btnSkipFirstAnim:addEventClick(self.onSkipFirstAnimClick)
end

function ActivityPlotDlg:_setData()
	local actId = self.actObj.actId

	self.storyData = {}
	self.battleData = {}
	self.hotData = {}

	local detailData = self.actObj.actData.clientData

	for index, stageData in ipairs(ResOpActivityPlotStage[actId] or {}) do
		if stageData.stage_type == Const.ACT_TYPE_PLOT_MODE_STORY then
			table.insert(self.storyData, stageData)
		elseif stageData.stage_type == Const.ACT_TYPE_PLOT_MODE_HOT then
			table.insert(self.hotData, stageData)
		else
			table.insert(self.battleData, stageData)
		end
	end

	if #self.hotData > 0 then
		self.btnHotAvg = UIControls.Button(self, "BtnAvg")

		self.btnHotAvg:addEventClick(self.onHotAvgClick)
	end

	if self.miscData and self.miscData.jump_shop_activity then
		self.btnPlotShop:setVisible(true)
	else
		self.btnPlotShop:setVisible(false)
	end

	local moneyList = {
		100001,
		100002
	}

	if self.miscData and self.miscData.cost_item_id then
		table.insert(moneyList, 1, self.miscData.cost_item_id)
	end

	self.panelFund:settingFund(moneyList)
	self:checkStartState()
end

local PLAY_AVG

function ActivityPlotDlg:checkStartState()
	CurAvatar:checkActEnterAVG(self.actObj)

	if RegionUtils.isTW() then
		local selectNextLevel, selectNextStage = self.actObj.actData:getNextSelectNode(nil, Const.ACT_TYPE_PLOT_MODE_HOT)
		local stageData = ResOpActivityPlotStage[self.actObj.actId]

		stageData = stageData[selectNextStage]

		if not self.actObj.actData:isLevelPassed(selectNextLevel) and stageData and stageData.stage_type == Const.ACT_TYPE_PLOT_MODE_HOT then
			local levelDetailData = self.actObj.actData.clientData[selectNextLevel] or {}

			self.avgDetailId = levelDetailData.index
			self.activeAVG = {
				levelDetailData.plot_avg1,
				levelDetailData.plot_avg2,
				levelDetailData.plot_avg3,
				levelDetailData.plot_avg4,
				levelDetailData.plot_avg5
			}

			self:playAVG(true)
		else
			self:playActivityOpenAnim()
		end
	else
		self:playActivityOpenAnim()
	end
end

function ActivityPlotDlg:playAVG(fromInit)
	local avgId = table.remove(self.activeAVG, 1)

	if avgId then
		UIManager.playAVG(avgId, nil, Functor(self.playAVG, self, fromInit))
	elseif fromInit then
		CurAvatar:activityRPC(Functor(RPC.opActPlotPassCurStage, self.actObj.opId, self.avgDetailId), self.actObj.opId)
		self:playActivityOpenAnim(true)
	end
end

function ActivityPlotDlg:onHotAvgClick()
	if #self.hotData > 0 then
		local hotStage = self.hotData[1]

		hotStage = hotStage.stage

		for _, levelDetailData in ipairs(self.actObj.actData.clientData) do
			if levelDetailData.stage == hotStage then
				self.activeAVG = {
					levelDetailData.plot_avg1,
					levelDetailData.plot_avg2,
					levelDetailData.plot_avg3,
					levelDetailData.plot_avg4,
					levelDetailData.plot_avg5
				}

				self:playAVG()

				return
			end
		end
	end
end

function ActivityPlotDlg:playActivityOpenAnim(fromAvg)
	local firstStageData = self.storyData[1]
	local state = self.actObj.actData:getStageState(firstStageData.stage)

	if state == Const.COMMON_STATE_LOCK then
		if not self.textPrepareTime then
			self.textPrepareTime = UIControls.Label(self, "ActPreviewPanel/TxtDes/TextTime")
		end

		if self.textPrepareTime then
			local remineTime = self.actObj.actData:getStageUnlockedTime(firstStageData.stage) - ClientUtils.getServerTime()

			if remineTime > 0 then
				ClientTimerManager.AddSecondFormatTickUI(self.textPrepareTime, remineTime, nil, Lang.get(48678))
			end
		end

		self:playAni("ShowPreview")
	elseif fromAvg and state == Const.COMMON_STATE_NEXT then
		self:playAni("EndPreview", Slot(self.onSecShowAnim, self), true)
	else
		self:playAni("ShowActivityFlotCanvas", Slot(self.onSecShowAnim, self), true)
	end
end

function ActivityPlotDlg:onSkipFirstAnimClick()
	self:onSecShowAnim()
end

function ActivityPlotDlg:onSecShowAnim()
	self:playAni("EntryActivityPlotCanvas", Slot(self.onShowAnimOver, self), true)
end

function ActivityPlotDlg:onShowAnimOver()
	self.onOpenAniOver = true
end

function ActivityPlotDlg:_onShow()
	local actId = self.actObj.actId
	local storyHasNew = self.actObj.actData:needSeenToday()

	self.imgNewPlot:setVisible(storyHasNew)

	local battleHasNew = self.actObj.actData:hasBattleToFight()

	self.imgNewBattle:setVisible(battleHasNew)

	local shopHasNew = self.actObj.actData:hasMoney()

	self.shopRD:setVisible(shopHasNew)

	local achieveHasNew = self.actObj.actData:hasAchieveToGet()

	self.achieveRD:setVisible(achieveHasNew)
end

function ActivityPlotDlg:onBtnClose()
	self:setVisible(false)
	self:recoverManualReject()
end

function ActivityPlotDlg:onBtnPlotAchieve()
	UIManager.getUI("activityPlotAchieveDlg", true):onShowActivity({
		self.clientTemplateData,
		self.actObj
	})
end

function ActivityPlotDlg:onBtnPlotShop()
	if self.miscData and self.miscData.jump_shop_activity then
		CurAvatar:jumpToShowActivity(self.miscData.jump_shop_activity)
	end
end

function ActivityPlotDlg:onBtnBingo()
	if self.miscData and self.miscData.jump_bingo_activity then
		CurAvatar:jumpToShowActivity(self.miscData.jump_bingo_activity)
	end
end

function ActivityPlotDlg:onBtnBattleMode()
	self:_jumpToBattleMode()
end

function ActivityPlotDlg:_jumpToBattleMode(levelId)
	local stageId, stageData

	if levelId then
		local levelData = self.actObj.actData.clientData[levelId]

		if levelData then
			stageId = levelData.stage
		end
	else
		local battleStageData = self.battleData[1]

		if battleStageData then
			stageId = battleStageData.stage
			stageData = battleStageData
		end
	end

	if stageId then
		local state = self.actObj.actData:getStageState(stageId)

		if state == Const.COMMON_STATE_LOCK then
			local unlockTime = self.actObj.actData:getStageUnlockedTime(stageId)
			local openTime = unlockTime - ClientUtils.getServerTime()

			if openTime > 0 and stageData then
				local notice = string.format(stageData.unlock_desc_pre, utils.calcTimeTxt(openTime))

				MsgManager.notice(notice)

				return
			end
		elseif state == Const.COMMON_STATE_NML then
			MsgManager.clientNotice(262)
		elseif levelId then
			UIManager.getUI("activityPlotBattleDlg", true):onShowBattleInfo({
				self.clientTemplateData,
				self.actObj
			}, stageId, levelId)
		else
			UIManager.getUI("activityPlotBattleDlg", true):onShowBattleInfo({
				self.clientTemplateData,
				self.actObj
			})
		end
	end
end

function ActivityPlotDlg:onBtnPlotMode()
	self:_jumpToPlotMode()
end

function ActivityPlotDlg:_jumpToPlotMode(levelId)
	if levelId then
		local stageId
		local levelData = self.actObj.actData.clientData[levelId]

		if levelData then
			stageId = levelData.stage
		end

		UIManager.getUI("activityPlotInfoDlg", true):onShowPlotInfo({
			self.clientTemplateData,
			self.actObj
		}, stageId)
	else
		UIManager.getUI("activityPlotInfoDlg", true):onShowActivity({
			self.clientTemplateData,
			self.actObj
		})
	end
end

function ActivityPlotDlg:updateActivityData(actObj)
	local activityPlotInfoDlg = UIManager.tryGetUI("activityPlotInfoDlg")

	if activityPlotInfoDlg then
		activityPlotInfoDlg:updateActivityData()
	end

	local activityPlotBattleDlg = UIManager.tryGetUI("activityPlotBattleDlg")

	if activityPlotBattleDlg then
		activityPlotBattleDlg:updateActivityData()
	end

	local activityPlotAchieveDlg = UIManager.tryGetUI("activityPlotAchieveDlg")

	if activityPlotAchieveDlg then
		activityPlotAchieveDlg:updateActivityData()
	end

	self:_onShow()
end

function ActivityPlotDlg:activityStateShow(actObj, extraStateArgs)
	local levelId = extraStateArgs

	if levelId and actObj.actData.clientData[levelId] then
		local actId = actObj.actId
		local stage = actObj.actData.clientData[levelId].stage
		local actStageData = ResOpActivityPlotStage[actId] or {}
		local stageData = actStageData[stage]

		if stageData and stageData.stage_type == Const.ACT_TYPE_PLOT_MODE_BATTLE then
			self:_jumpToBattleMode(levelId)
		else
			self:_jumpToPlotMode(levelId)
		end

		if not self.onOpenAniOver then
			self:onSecShowAnim()
		end
	end
end

return ActivityPlotDlg
