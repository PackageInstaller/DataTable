-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FigureGuess\\ActivityFigureGuessPondDlg.lua

local ResOpActivityGuessQuestion = require("ClientData/ResOpActivityGuessQuestion")
local ResOpActivityGuessMisc = require("ClientData/ResOpActivityGuessMisc")
local ResOpActivityGuessAward = require("ClientData/ResOpActivityGuessAward")
local ActivityFigureGuessTools = require("UI/OpActivity/FigureGuess/ActivityFigureGuessTools")
local EventConst = require("EventConst")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local CommonBonusDlg = require("UI/Common/CommonBonusDlg")
local PersonNode = Class("PersonNode", UIControls.Child)

function PersonNode:ctor()
	self.notOpenPanel = UIControls.Panel(self, "CoursePanel/NotOpenPanel")
	self.guessingPanel = UIControls.Panel(self, "CoursePanel/GuessingPanel")
	self.guessRightPanel = UIControls.Panel(self, "CoursePanel/GuessRightPanel")
	self.guessWrongPanel = UIControls.Panel(self, "CoursePanel/GuessWrongPanel")
	self.notJoinPanel = UIControls.Panel(self, "CoursePanel/NotHadPanel")
	self.txtQuestion = UIControls.Label(self, "BgTextTopic/TextTopic")
	self.notHadPanel = UIControls.Panel(self, "GuessPanel/NotHadPanel")
	self.careerPanel = UIControls.Panel(self, "GuessPanel/ChooseCareerPanel")
	self.imgCareer = UIControls.Image(self, "GuessPanel/ChooseCareerPanel/ImgCareer")
	self.txtCareer = UIControls.Label(self, "GuessPanel/ChooseCareerPanel/TextCareerName")
	self.groupPanel = UIControls.Panel(self, "GuessPanel/ChooseGroupPanel")
	self.imgGroup = UIControls.Image(self, "GuessPanel/ChooseGroupPanel/ImgGroup")
	self.txtGroup = UIControls.Label(self, "GuessPanel/ChooseGroupPanel/TextGroupName")
	self.teamPanel = UIControls.Panel(self, "GuessPanel/ChooseTeamPanel")
	self.imgTeam = UIControls.Image(self, "GuessPanel/ChooseTeamPanel/ImgTeam")
	self.notOpenStatePanel = UIControls.Panel(self, "StatePanel/NotOpenPanel")
	self.guessingStatePanel = UIControls.Panel(self, "StatePanel/GuessingPanel")
	self.gotStatePanel = UIControls.Panel(self, "StatePanel/HadPanel")
	self.notJoinStatePanel = UIControls.Panel(self, "StatePanel/NotHadPanel")
	self.itemGrid = UIControls.ItemGridChild(self, "AwardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
	self.itemGrid.mDisableWays = true
end

function PersonNode:setData(config, answerConfig, day, actObj)
	self.notOpenPanel:setVisible(false)
	self.guessingPanel:setVisible(false)
	self.guessRightPanel:setVisible(false)
	self.guessWrongPanel:setVisible(false)
	self.notJoinPanel:setVisible(false)
	self.notOpenStatePanel:setVisible(false)
	self.guessingStatePanel:setVisible(false)
	self.gotStatePanel:setVisible(false)
	self.notJoinStatePanel:setVisible(false)

	local actData = actObj.actData
	local actId = actObj.actId
	local guessData = actData:getMyGuessData(config.answer_type)
	local awardNum = "?"

	if day > config.unlock_time then
		if not guessData.checkPersonJoin then
			self.notJoinPanel:setVisible(true)
			self.notJoinStatePanel:setVisible(true)

			awardNum = "0"
		else
			local awardConfig = ResOpActivityGuessAward[1][guessData.award_scheme]

			if guessData.right_id == guessData.choose_id then
				self.guessRightPanel:setVisible(true)

				awardNum = awardConfig.win_award
			else
				self.guessWrongPanel:setVisible(true)

				awardNum = awardConfig.loss_award
			end

			self.gotStatePanel:setVisible(true)
		end
	elseif config.unlock_time == day then
		self.guessingPanel:setVisible(true)

		if guessData.checkPersonJoin then
			self.guessingStatePanel:setVisible(true)
		else
			self.notJoinStatePanel:setVisible(true)
		end
	else
		self.notOpenPanel:setVisible(true)
		self.notOpenStatePanel:setVisible(true)
	end

	local myChoose = guessData and guessData.checkPersonJoin and guessData.choose_id or nil

	self.notHadPanel:setVisible(not myChoose)
	self.groupPanel:setVisible(myChoose and config.answer_type == 1)
	self.careerPanel:setVisible(myChoose and config.answer_type == 2)
	self.teamPanel:setVisible(myChoose and config.answer_type == 3)

	if config.answer_type == 1 then
		self.txtQuestion:setText(Lang.get(76356))

		if myChoose then
			ActivityFigureGuessTools.refreshGroupShow(myChoose, self.imgGroup, self.txtGroup)
		end
	elseif config.answer_type == 2 then
		self.txtQuestion:setText(Lang.get(76357))

		if myChoose then
			ActivityFigureGuessTools.refreshCareerShow(myChoose, self.imgCareer, self.txtCareer)
		end
	elseif config.answer_type == 3 then
		self.txtQuestion:setText(Lang.get(76358))

		if myChoose then
			ActivityFigureGuessTools.refreshTeamShow(myChoose, self.imgTeam)
		end
	end

	local miscConfig = ResOpActivityGuessMisc[actId]
	local itemId = miscConfig.award_id
	local item = BaseObject.GetObject(itemId)

	self.itemGrid:setObj(item)
	self.itemGrid.textNum:setText(awardNum)
end

local CircleNode = Class("CircleNode", UIControls.Child)

function CircleNode:ctor()
	self.notOpenPanel = UIControls.Panel(self, "CoursePanel/NotOpenPanel")
	self.guessingPanel = UIControls.Panel(self, "CoursePanel/GuessingPanel")
	self.guessRightPanel = UIControls.Panel(self, "CoursePanel/GuessWinPanel")
	self.guessWrongPanel = UIControls.Panel(self, "CoursePanel/GuessLosePanel")
	self.guessEqualPanel = UIControls.Panel(self, "CoursePanel/EqualPanel")
	self.txtQuestion = UIControls.Label(self, "BgTextTopic/TextTopic")
	self.notHadPanel = UIControls.Panel(self, "GuessPanel/NotHadPanel")
	self.careerPanel = UIControls.Panel(self, "GuessPanel/ChooseCareerPanel")
	self.imgCareer1 = UIControls.Image(self, "GuessPanel/ChooseCareerPanel/ChoosePanel1/ImgCareer")
	self.txtCareerNum1 = UIControls.Label(self, "GuessPanel/ChooseCareerPanel/ChoosePanel1/TextNum")
	self.careerRightPanel1 = UIControls.Panel(self, "GuessPanel/ChooseCareerPanel/ChoosePanel1/ImgRight")
	self.imgCareer2 = UIControls.Image(self, "GuessPanel/ChooseCareerPanel/ChoosePanel2/ImgCareer")
	self.txtCareerNum2 = UIControls.Label(self, "GuessPanel/ChooseCareerPanel/ChoosePanel2/TextNum")
	self.careerRightPanel2 = UIControls.Panel(self, "GuessPanel/ChooseCareerPanel/ChoosePanel2/ImgRight")
	self.groupPanel = UIControls.Panel(self, "GuessPanel/ChooseGroupPanel")
	self.imgGroup1 = UIControls.Image(self, "GuessPanel/ChooseGroupPanel/ChoosePanel1/ImgGroup")
	self.txtGroupNum1 = UIControls.Label(self, "GuessPanel/ChooseGroupPanel/ChoosePanel1/TextNum")
	self.groupRightPanel1 = UIControls.Panel(self, "GuessPanel/ChooseGroupPanel/ChoosePanel1/ImgRight")
	self.imgGroup2 = UIControls.Image(self, "GuessPanel/ChooseGroupPanel/ChoosePanel2/ImgGroup")
	self.txtGroupNum2 = UIControls.Label(self, "GuessPanel/ChooseGroupPanel/ChoosePanel2/TextNum")
	self.groupRightPanel2 = UIControls.Panel(self, "GuessPanel/ChooseGroupPanel/ChoosePanel2/ImgRight")
	self.teamPanel = UIControls.Panel(self, "GuessPanel/ChooseTeamPanel")
	self.imgTeam1 = UIControls.Image(self, "GuessPanel/ChooseTeamPanel/ChoosePanel1/ImgTeam")
	self.txtTeamNum1 = UIControls.Label(self, "GuessPanel/ChooseTeamPanel/ChoosePanel1/TextNum")
	self.teamRightPanel1 = UIControls.Panel(self, "GuessPanel/ChooseTeamPanel/ChoosePanel1/ImgRight")
	self.imgTeam2 = UIControls.Image(self, "GuessPanel/ChooseTeamPanel/ChoosePanel2/ImgTeam")
	self.txtTeamNum2 = UIControls.Label(self, "GuessPanel/ChooseTeamPanel/ChoosePanel2/TextNum")
	self.teamRightPanel2 = UIControls.Panel(self, "GuessPanel/ChooseTeamPanel/ChoosePanel2/ImgRight")
	self.notOpenStatePanel = UIControls.Panel(self, "StatePanel/NotOpenPanel")
	self.guessingStatePanel = UIControls.Panel(self, "StatePanel/GuessingPanel")
	self.canGetStatePanel = UIControls.Panel(self, "StatePanel/ReceivePanel")
	self.gotStatePanel = UIControls.Panel(self, "StatePanel/HadPanel")
	self.btnGet = UIControls.Button(self, "StatePanel/ReceivePanel/BtnGet")

	self.btnGet:addEventClick(self.onClickGetAward)

	self.itemGrid = UIControls.ItemGridChild(self, "AwardPanel", "System/Common/Grid/GridMaterialItem", 0, 0, true)
	self.itemGrid.mDisableWays = true
end

function CircleNode:setData(config, answerConfig, day, actObj)
	self.notOpenPanel:setVisible(false)
	self.guessingPanel:setVisible(false)
	self.guessRightPanel:setVisible(false)
	self.guessWrongPanel:setVisible(false)
	self.guessEqualPanel:setVisible(false)
	self.notHadPanel:setVisible(false)
	self.careerPanel:setVisible(false)
	self.groupPanel:setVisible(false)
	self.teamPanel:setVisible(false)
	self.notOpenStatePanel:setVisible(false)
	self.guessingStatePanel:setVisible(false)
	self.canGetStatePanel:setVisible(false)
	self.gotStatePanel:setVisible(false)

	self.param = config.param
	self.opId = actObj.opId

	local awardNum = "?"
	local showGuessMode = 0
	local guessData = actObj.actData.guessDataList[config.param]
	local isWin, guessWinNum, guessLoseNum
	local guessState = actObj.actData:getGuessState(config.param)

	if guessState == Const.GUESS_STATE_NOT_OPEN then
		self.notOpenPanel:setVisible(true)
		self.notHadPanel:setVisible(true)
		self.notOpenStatePanel:setVisible(true)
	elseif guessState == Const.GUESS_STATE_OPEN then
		self.guessingPanel:setVisible(true)
		self.notHadPanel:setVisible(true)
		self.notOpenStatePanel:setVisible(true)
	elseif guessState == Const.GUESS_STATE_GUESSED then
		self.guessingPanel:setVisible(true)

		showGuessMode = 1
		isWin, guessWinNum, guessLoseNum = actObj.actData:isCircleGuessWin(config.param)

		self.guessingStatePanel:setVisible(true)
	else
		local awardConfig = ResOpActivityGuessAward[2][1]

		isWin, guessWinNum, guessLoseNum = actObj.actData:isCircleGuessWin(config.param)

		if isWin then
			self.guessRightPanel:setVisible(true)

			awardNum = awardConfig.win_award
		else
			self.guessWrongPanel:setVisible(true)

			awardNum = awardConfig.loss_award
		end

		showGuessMode = 2

		if guessData and guessData.clan_award and guessData.clan_award > 0 then
			self.gotStatePanel:setVisible(true)
		else
			self.canGetStatePanel:setVisible(true)
		end
	end

	local choose1Id, choose2Id, choose1Num, choose2Num, rightIndex

	if guessData then
		local rightId = guessData.right_id

		if rightId < guessData.wrong_id then
			rightIndex = 1
			choose1Id = rightId
			choose2Id = guessData.wrong_id
			choose1Num = guessWinNum or 0
			choose2Num = guessLoseNum or 0
		else
			rightIndex = 2
			choose1Id = guessData.wrong_id
			choose2Id = rightId
			choose1Num = guessLoseNum or 0
			choose2Num = guessWinNum or 0
		end
	end

	if config.answer_type == 1 then
		self.txtQuestion:setText(Lang.get(76356))

		if showGuessMode > 0 then
			self.groupPanel:setVisible(true)
			ActivityFigureGuessTools.refreshGroupShow(choose1Id, self.imgGroup1)
			ActivityFigureGuessTools.refreshGroupShow(choose2Id, self.imgGroup2)
			self.txtGroupNum1:setVisible(choose1Num >= 0)
			self.txtGroupNum1:setText(choose1Num)
			self.txtGroupNum2:setVisible(choose2Num >= 0)
			self.txtGroupNum2:setText(choose2Num)

			if showGuessMode == 2 then
				self["groupRightPanel" .. rightIndex]:setVisible(true)
			end
		end
	elseif config.answer_type == 2 then
		self.txtQuestion:setText(Lang.get(76357))

		if showGuessMode > 0 then
			self.careerPanel:setVisible(true)
			ActivityFigureGuessTools.refreshCareerShow(choose1Id, self.imgCareer1)
			ActivityFigureGuessTools.refreshCareerShow(choose2Id, self.imgCareer2)
			self.txtCareerNum1:setVisible(choose1Num >= 0)
			self.txtCareerNum1:setText(choose1Num)
			self.txtCareerNum2:setVisible(choose2Num >= 0)
			self.txtCareerNum2:setText(choose2Num)

			if showGuessMode == 2 then
				self["careerRightPanel" .. rightIndex]:setVisible(true)
			end
		end
	elseif config.answer_type == 3 then
		self.txtQuestion:setText(Lang.get(76358))

		if showGuessMode > 0 then
			self.teamPanel:setVisible(true)
			ActivityFigureGuessTools.refreshTeamShow(choose1Id, self.imgTeam1)
			ActivityFigureGuessTools.refreshTeamShow(choose2Id, self.imgTeam2)
			self.txtTeamNum1:setVisible(choose1Num >= 0)
			self.txtTeamNum1:setText(choose1Num)
			self.txtTeamNum2:setVisible(choose2Num >= 0)
			self.txtTeamNum2:setText(choose2Num)

			if showGuessMode == 2 then
				self["teamRightPanel" .. rightIndex]:setVisible(true)
			end
		end
	end

	local miscConfig = ResOpActivityGuessMisc[actObj.actId]
	local itemId = miscConfig.award_id
	local item = BaseObject.GetObject(itemId)

	self.itemGrid:setObj(item)
	self.itemGrid.textNum:setText(awardNum)
end

function CircleNode:onClickGetAward()
	RPC.opActGuessAwardInfuse(self.opId, self.param)
end

local ActivityFigureGuessPondDlg = Class("ActivityFigureGuessPondDlg", UIControls.Window)

MixinClass(ActivityFigureGuessPondDlg, ActivityPanelMixin)

function ActivityFigureGuessPondDlg:initUI()
	self.personGuessPanel = UIControls.Panel(self, "BgPanel/PersonGuessPanel")
	self.circleGuessPanel = UIControls.Panel(self, "BgPanel/CircleGuessPanel")
	self.txtPersonRule = UIControls.Label(self, "BgPanel/PersonGuessPanel/TextRule")
	self.txtCircleRule = UIControls.Label(self, "BgPanel/CircleGuessPanel/TextRule")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnPerson = UIControls.Button(self, "BgPanel/TabPerson")

	self.btnPerson:addEventClick(self.onClickPerson)

	self.btnCircle = UIControls.Button(self, "BgPanel/TabCircle")

	self.btnCircle:addEventClick(self.onClickCircle)

	self.newBtnCircle = UIControls.Panel(self, "BgPanel/TabCircle/IconNew")
	self.emptyAwardPanel = UIControls.Panel(self, "BgPanel/GuessPond/IconEmpty")
	self.haveAwardPanel = UIControls.Panel(self, "BgPanel/GuessPond/IconHave")
	self.imgAwardIcon = UIControls.Image(self, "BgPanel/GuessPond/BgTextNum/Image")
	self.txtAwardNum = UIControls.Label(self, "BgPanel/GuessPond/BgTextNum/TextNum")
	self.txtTime = UIControls.Label(self, "BgPanel/TimePanel/TextTime")
	self.personNodeList = {}

	for i = 1, 3 do
		local node = PersonNode(self, "BgPanel/PersonGuessPanel/Content", "System/Activity/ActivityFigureGuess/PersonGuessCell")

		table.insert(self.personNodeList, node)
	end

	self.circleNodeList = {}

	for i = 1, 3 do
		local node = CircleNode(self, "BgPanel/CircleGuessPanel/Content", "System/Activity/ActivityFigureGuess/CircleGuessCell")

		table.insert(self.circleNodeList, node)
	end

	self.txtPersonRule:setText(Lang.get(76054))
	self.txtCircleRule:setText(Lang.get(76055))

	self.slotOnGetCircleAward = Slot(self.onGetCircleAward, self)

	EventCenter.addEventListener(EventConst.FIGURE_GUESS_GET_CIRCLE_AWARD, self.slotOnGetCircleAward)
end

function ActivityFigureGuessPondDlg:destroy()
	EventCenter.removeEventListener(EventConst.FIGURE_GUESS_GET_CIRCLE_AWARD, self.slotOnGetCircleAward)
	ActivityFigureGuessPondDlg.super.destroy(self)
end

function ActivityFigureGuessPondDlg:onGetCircleAward(stageId, award, rightNum, wrongNum)
	CommonBonusDlg.setCustomizeFlyConfig(true, self.imgAwardIcon)
	UIManager.getUI("commonBonusDlg", true):onShow("", {}, {
		{
			id = self.actData.awardId,
			num = award
		}
	}, {}, {}, {}, {}, Lang.get(1815))
	self:refreshAwardPool()
	self:refreshCirclePanel()
end

function ActivityFigureGuessPondDlg:_setData(actobj)
	self.actData = self.actObj.actData
	self.actId = self.actObj.actId
	self.day = self.actData:getCurDay()

	local obj = BaseObject.GetObject(self.actData.awardId)
	local iconPath = obj:getIconPath()

	self.imgAwardIcon:setImage(iconPath[1], iconPath[2])

	if self.actObj:inOpenState() then
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.actObj:getRemainOpenTime(), false, Lang.get(76056), Slot(self._timerOver, self))
	end

	self:refreshAwardPool()
	self:onClickCircle()
end

function ActivityFigureGuessPondDlg:_timerOver()
	if self.txtTime and self.txtTime:isAlive() then
		self.txtTime:setText(Lang.get(32785))
	end
end

function ActivityFigureGuessPondDlg:refreshAwardPool()
	local num = self.actData:getTotalAwardNum()

	self.emptyAwardPanel:setVisible(num == 0)
	self.haveAwardPanel:setVisible(num > 0)
	self.txtAwardNum:setText(num)
	self.newBtnCircle:setVisible(self.actObj.actData:checkClanBonusNew())
end

function ActivityFigureGuessPondDlg:refreshPersonPanel()
	local configList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_QUESTION]
	local answerConfigList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_ANSWER]

	for i = 1, #self.personNodeList do
		local node = self.personNodeList[i]

		node:setVisible(true)
		node:setData(configList[i], answerConfigList[i], self.day, self.actObj)
	end
end

function ActivityFigureGuessPondDlg:refreshCirclePanel()
	local configList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_QUESTION]
	local answerConfigList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_ANSWER]

	for i = 1, #self.circleNodeList do
		local node = self.circleNodeList[i]

		node:setVisible(true)
		node:setData(configList[i], answerConfigList[i], self.day, self.actObj)
	end
end

function ActivityFigureGuessPondDlg:onClickPerson()
	self.btnPerson:setEnable(false)
	self.personGuessPanel:setVisible(true)
	self.btnCircle:setEnable(true)
	self.circleGuessPanel:setVisible(false)
	self:refreshPersonPanel()
end

function ActivityFigureGuessPondDlg:onClickCircle()
	if not CurAvatar:isInCircle() then
		MsgManager.notice(Lang.get(30050))

		return
	end

	self.btnPerson:setEnable(true)
	self.personGuessPanel:setVisible(false)
	self.btnCircle:setEnable(false)
	self.circleGuessPanel:setVisible(true)
	self:refreshCirclePanel()
end

function ActivityFigureGuessPondDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ActivityFigureGuessPondDlg
