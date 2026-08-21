-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\FigureGuess\\ActivityFigureGuessMainDlg.lua

local ResStepDes = require("ClientData/ResStepDes")
local ResOpActivityGuessQuestion = require("ClientData/ResOpActivityGuessQuestion")
local ResOpActivityShopMisc = require("ClientData/ResOpActivityShopMisc")
local StepUpDonePanel = require("UI/Hero/ContentPanel/StepUpDonePanel")
local HeroCVNamePanel = require("UI/HandBook/HeroCVNamePanel")
local ActivityFigureGuessTools = require("UI/OpActivity/FigureGuess/ActivityFigureGuessTools")
local ShareAchievePanel = require("UI/Achieve/ShareAchievePanel")
local EventConst = require("EventConst")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResHandBookHero = require("ClientData/ResHandBookHero")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ActivityFigureGuessMainDlg = Class("ActivityFigureGuessMainDlg", UIControls.Window)

MixinClass(ActivityFigureGuessMainDlg, ActivityPanelMixin)

function ActivityFigureGuessMainDlg:initUI()
	self.timePanel = UIControls.Panel(self, "MainInfoPanel/BgTime")
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")
	self.btnPond = UIControls.Button(self, "MainInfoPanel/BtnPond")

	self.btnPond:addEventClick(self.onClickBtnPond)

	self.iconPondNew = UIControls.Panel(self, "MainInfoPanel/BtnPond/IconNew")
	self.emptyAwardPanel = UIControls.Panel(self, "MainInfoPanel/BtnPond/IconEmpty")
	self.haveAwardPanel = UIControls.Panel(self, "MainInfoPanel/BtnPond/IconHave")
	self.imgAwardIcon = UIControls.Image(self, "MainInfoPanel/BtnPond/BgTextNum/Image")
	self.txtAwardNum = UIControls.Label(self, "MainInfoPanel/BtnPond/BgTextNum/TextNum")
	self.btnRank = UIControls.Button(self, "MainInfoPanel/BtnRank")

	self.btnRank:addEventClick(self.onClickBtnRank)

	self.btnZoomIn = UIControls.Button(self, "MainInfoPanel/BtnZoomIn")

	self.btnZoomIn:addEventClick(self.onClickBtnZoomIn)

	self.btnZoomOut = UIControls.Button(self, "MainInfoPanel/BtnZoomOut")

	self.btnZoomOut:addEventClick(self.onClickBtnZoomOut)

	self.panelCareerOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/CareerInfoPanel")
	self.panelCareerLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/BgTextUnLock")
	self.panelCareerGuess = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/GuessingPanel")
	self.panelCareerNormal = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/ImgGuess")
	self.panelCareerRight = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/ImgGuessRight")
	self.panelCareerWrong = UIControls.Panel(self, "MainInfoPanel/InformPanel/CareerPanel/ImgGuessWrong")
	self.animCareer = UIControls.UIAni(self, "MainInfoPanel/InformPanel/CareerPanel")
	self.imgCareer = UIControls.Image(self, "MainInfoPanel/InformPanel/CareerPanel/CareerInfoPanel/ImgCareer")
	self.txtCareer = UIControls.Label(self, "MainInfoPanel/InformPanel/CareerPanel/CareerInfoPanel/TextCareerName")
	self.txtCareerLock = UIControls.Label(self, "MainInfoPanel/InformPanel/CareerPanel/BgTextUnLock/TextUnLock")
	self.panelGroupOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/GroupInfoPanel")
	self.panelGroupLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/BgTextUnLock")
	self.panelGroupGuess = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/GuessingPanel")
	self.panelGroupNormal = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/ImgGuess")
	self.panelGroupRight = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/ImgGuessRight")
	self.panelGroupWrong = UIControls.Panel(self, "MainInfoPanel/InformPanel/GroupPanel/ImgGuessWrong")
	self.animGroup = UIControls.UIAni(self, "MainInfoPanel/InformPanel/GroupPanel")
	self.txtGroupLock = UIControls.Label(self, "MainInfoPanel/InformPanel/GroupPanel/BgTextUnLock/TextUnLock")
	self.imgGroup = UIControls.Image(self, "MainInfoPanel/InformPanel/GroupPanel/GroupInfoPanel/ImgGroup")
	self.txtGroup = UIControls.Label(self, "MainInfoPanel/InformPanel/GroupPanel/GroupInfoPanel/TextGroupName")
	self.panelTeamOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/TeamInfoPanel")
	self.panelTeamLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/BgTextUnLock")
	self.panelTeamGuess = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/GuessingPanel")
	self.panelTeamNormal = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/ImgGuess")
	self.panelTeamRight = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/ImgGuessRight")
	self.panelTeamWrong = UIControls.Panel(self, "MainInfoPanel/InformPanel/TeamPanel/ImgGuessWrong")
	self.animTeam = UIControls.UIAni(self, "MainInfoPanel/InformPanel/TeamPanel")
	self.txtTeamLock = UIControls.Label(self, "MainInfoPanel/InformPanel/TeamPanel/BgTextUnLock/TextUnLock")
	self.imgTeam = UIControls.Image(self, "MainInfoPanel/InformPanel/TeamPanel/TeamInfoPanel/ImgTeam")
	self.txtTeam = UIControls.Label(self, "MainInfoPanel/InformPanel/TeamPanel/TeamInfoPanel/TextTeamName")
	self.panelHeroOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/NewHeroPanel/HeroPanel")
	self.panelHeroLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/NewHeroPanel/HerosketchPanel")
	self.panelHeroNameOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/NewHeroPanel/BgTextName")
	self.panelHeroNameLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/NewHeroPanel/BgTextUnLock")
	self.txtHeroLock = UIControls.Label(self, "MainInfoPanel/InformPanel/NewHeroPanel/BgTextUnLock/TextUnLock")
	self.animHero = UIControls.UIAni(self, "MainInfoPanel/InformPanel/NewHeroPanel")
	self.openHeroRole = UIControls.Role(self, "MainInfoPanel/InformPanel/NewHeroPanel/HeroPanel", 0, 0)
	self.lockHeroRole = UIControls.Role(self, "MainInfoPanel/InformPanel/NewHeroPanel/HerosketchPanel", 0, 0)

	self.lockHeroRole.image:setColorByRGBA(0, 0, 0, 204)

	self.txtHeroName = UIControls.Label(self, "MainInfoPanel/InformPanel/NewHeroPanel/BgTextName/TextName")
	self.panelIdeaOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/IEDAPanel/StageUpPanel")
	self.panelIdeaLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/IEDAPanel/BgTextUnLock")
	self.txtIdeaLock = UIControls.Label(self, "MainInfoPanel/InformPanel/IEDAPanel/BgTextUnLock/TextUnLock")
	self.animIdea = UIControls.UIAni(self, "MainInfoPanel/InformPanel/IEDAPanel")
	self.panelCoatOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/CoatPanel/StageUpPanel")
	self.panelCoatLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/CoatPanel/BgTextUnLock")
	self.txtCoatLock = UIControls.Label(self, "MainInfoPanel/InformPanel/CoatPanel/BgTextUnLock/TextUnLock")
	self.animCoat = UIControls.UIAni(self, "MainInfoPanel/InformPanel/CoatPanel")
	self.panelCharacterOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/CharacterPanel/StageUpPanel")
	self.panelCharacterLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/CharacterPanel/BgTextUnLock")
	self.txtCharacterLock = UIControls.Label(self, "MainInfoPanel/InformPanel/CharacterPanel/BgTextUnLock/TextUnLock")
	self.animCharacter = UIControls.UIAni(self, "MainInfoPanel/InformPanel/CharacterPanel")
	self.panelCVOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/HeroCVPanel/CvPanel")
	self.panelCVLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/HeroCVPanel/BgTextUnLock")
	self.txtCVLock = UIControls.Label(self, "MainInfoPanel/InformPanel/HeroCVPanel/BgTextUnLock/TxtPanel/TextUnLock")
	self.animCV = UIControls.UIAni(self, "MainInfoPanel/InformPanel/HeroCVPanel")
	self.btnCV = UIControls.Button(self, "MainInfoPanel/InformPanel/HeroCVPanel/CvPanel")

	self.btnCV:addEventClick(self.onHeroCvClick)

	self.panelBaseOpen = UIControls.Panel(self, "MainInfoPanel/InformPanel/BedPanel/BgBed/ImgBed")
	self.panelBaseLock = UIControls.Panel(self, "MainInfoPanel/InformPanel/BedPanel/BgTextUnLock")
	self.txtBaseLock = UIControls.Label(self, "MainInfoPanel/InformPanel/BedPanel/BgTextUnLock/TextUnLock")
	self.animBase = UIControls.UIAni(self, "MainInfoPanel/InformPanel/BedPanel")
	self.imgBase = UIControls.Image(self, "MainInfoPanel/InformPanel/BedPanel/BgBed/ImgBed")
	self.guessPanel = UIControls.Panel(self, "MainInfoPanel/GuessPanel")
	self.panelGuessInfo = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel")
	self.txtGuessTime = UIControls.Label(self, "MainInfoPanel/GuessPanel/BgGuessTime/TextTime")
	self.txtQuestion = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BgTextTopic/TextTopic")
	self.panelGuessRes = UIControls.Panel(self, "MainInfoPanel/GuessPanel/BgSumUp")
	self.txtGuessRes = UIControls.Label(self, "MainInfoPanel/GuessPanel/BgSumUp/TextSumUp")
	self.btnChoose1 = UIControls.Button(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1")

	self.btnChoose1:addEventClick(self.onClickBtnChoose1)

	self.panelChoose1Select = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ImgGuess")
	self.panelChoose1Right = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ImgRight")
	self.txtChoose1Num = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/TextNum")
	self.panelChoose1Career = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseCareerPanel")
	self.imgChoose1Career = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseCareerPanel/ImgCareer")
	self.txtChoose1Career = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseCareerPanel/TextCareerName")
	self.panelChoose1Group = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseGroupPanel")
	self.imgChoose1Group = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseGroupPanel/ImgGroup")
	self.txtChoose1Group = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseGroupPanel/TextGroupName")
	self.panelChoose1Team = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseTeamPanel")
	self.imgChoose1Team = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose1/ChooseTeamPanel/ImgTeam")
	self.btnChoose2 = UIControls.Button(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2")

	self.btnChoose2:addEventClick(self.onClickBtnChoose2)

	self.panelChoose2Select = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ImgGuess")
	self.panelChoose2Right = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ImgRight")
	self.txtChoose2Num = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/TextNum")
	self.panelChoose2Career = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseCareerPanel")
	self.imgChoose2Career = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseCareerPanel/ImgCareer")
	self.txtChoose2Career = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseCareerPanel/TextCareerName")
	self.panelChoose2Group = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseGroupPanel")
	self.imgChoose2Group = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseGroupPanel/ImgGroup")
	self.txtChoose2Group = UIControls.Label(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseGroupPanel/TextGroupName")
	self.panelChoose2Team = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseTeamPanel")
	self.imgChoose2Team = UIControls.Image(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BtnChoose2/ChooseTeamPanel/ImgTeam")
	self.panelChooseSlider = UIControls.Panel(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BgSlider")
	self.sliderChoose = UIControls.Slider(self, "MainInfoPanel/GuessPanel/GuessInfoPanel/BgSlider/Slider1")
	self.sharePanel = ShareAchievePanel(self, "MainInfoPanel/SharePanel")

	self.sharePanel:setBeforeAction(self._refreshShareTitle, self, false)
	self.sharePanel:setFinishAction(self._refreshShareTitle, self, true)

	self.panelClan = UIControls.Panel(self, "DesPanel")
	self.slotOnGetCircleAward = Slot(self.onGetCircleAward, self)

	EventCenter.addEventListener(EventConst.FIGURE_GUESS_GET_CIRCLE_AWARD, self.slotOnGetCircleAward)
end

function ActivityFigureGuessMainDlg:destroy()
	EventCenter.removeEventListener(EventConst.FIGURE_GUESS_GET_CIRCLE_AWARD, self.slotOnGetCircleAward)
	ActivityFigureGuessMainDlg.super.destroy(self)
end

function ActivityFigureGuessMainDlg:onGetCircleAward()
	self:refreshAwardPool()
end

function ActivityFigureGuessMainDlg:_refreshShareTitle(isShare)
	self.btnZoomOut:setVisible(isShare)
	self.sharePanel:setVisible(isShare)
	self.btnClose:setVisible(isShare)
	self.btnTips:setVisible(isShare)

	if self.panelFund then
		self.panelFund:setVisible(isShare)
	end
end

function ActivityFigureGuessMainDlg:onOpen()
	ActivityFigureGuessMainDlg.super.onOpen(self)

	local preInCircle = self.showInCircle

	self.showInCircle = CurAvatar:isInCircle()

	if preInCircle == false and self.showInCircle then
		self:_setData()
	end
end

function ActivityFigureGuessMainDlg:_setData()
	self.actData = self.actObj.actData
	self.actId = self.actObj.actId

	self:refreshData()

	if CurAvatar:isInCircle() then
		self.panelClan:setVisible(false)
	else
		self.panelClan:setVisible(true)
	end
end

function ActivityFigureGuessMainDlg:onHeroCvClick()
	local handInfo = ResHandBookHero[self.actData.heroId] or {}
	local voiceList = handInfo.voice_id

	if voiceList then
		self.voiceIdx = self.voiceIdx or 0

		if self.voiceIdx >= #voiceList then
			self.voiceIdx = 1
		else
			self.voiceIdx = self.voiceIdx + 1
		end

		local playVoiceId = voiceList[self.voiceIdx]

		CueManager.playVocal(playVoiceId)
	else
		MsgManager.clientNotice(139)
	end
end

function ActivityFigureGuessMainDlg:refreshData()
	self.day = self.actData:getCurDay()

	local heroId = self.actData.heroId
	local stepData = ResStepDes[heroId] or {}
	local hero = BaseObject.GetObject(heroId)
	local obj = BaseObject.GetObject(self.actData.awardId)
	local iconPath = obj:getIconPath()

	self.imgAwardIcon:setImage(iconPath[1], iconPath[2])

	local needShowResultGuess = self.actData:getShowBonusDay()
	local needShowConfig

	self.animList = {}

	local configList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_QUESTION]

	for i = 1, #configList do
		local config = configList[i]

		if i == needShowResultGuess then
			needShowConfig = config
		end

		local answerType = config.answer_type
		local guessData = self.actData:getMyGuessData(answerType)
		local checkGuess = config.unlock_time == self.day
		local answerDay = self:getQuestionUnlockTime(config.unlock_time)
		local checkOpen = answerDay <= self.day and needShowResultGuess ~= i
		local checkNeedAnim = needShowResultGuess == i
		local checkJoin = guessData.checkPersonJoin
		local checkRight = checkJoin and guessData and guessData.choose_id == guessData.right_id

		checkRight = checkRight and true or false

		if answerType == 2 then
			self.panelCareerOpen:setVisible(checkOpen)
			self.panelCareerGuess:setVisible(checkGuess)
			self.panelCareerLock:setVisible(not checkOpen and not checkGuess)
			self.panelCareerNormal:setVisible(not checkOpen or not checkJoin)
			self.panelCareerRight:setVisible(checkOpen and checkJoin and checkRight)
			self.panelCareerWrong:setVisible(checkOpen and checkJoin and not checkRight)

			if checkOpen or checkNeedAnim then
				ActivityFigureGuessTools.refreshCareerShow(hero.career, self.imgCareer, self.txtCareer)
			end

			if not checkOpen and not checkGuess then
				self.txtCareerLock:setText(ClientUtils.getServerOsDate(Lang.get(76354), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animCareer,
					"UnLockCareer"
				})
			end
		elseif answerType == 1 then
			self.panelGroupOpen:setVisible(checkOpen)
			self.panelGroupGuess:setVisible(checkGuess)
			self.panelGroupLock:setVisible(not checkOpen and not checkGuess)
			self.panelGroupNormal:setVisible(not checkOpen or not checkJoin)
			self.panelGroupRight:setVisible(checkOpen and checkJoin and checkRight)
			self.panelGroupWrong:setVisible(checkOpen and checkJoin and not checkRight)

			if checkOpen or checkNeedAnim then
				ActivityFigureGuessTools.refreshGroupShow(hero.camp, self.imgGroup, self.txtGroup)
			end

			if not checkOpen and not checkGuess then
				self.txtGroupLock:setText(ClientUtils.getServerOsDate(Lang.get(76354), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animGroup,
					"UnLockGroup"
				})
			end
		elseif answerType == 3 then
			self.panelTeamOpen:setVisible(checkOpen)
			self.panelTeamGuess:setVisible(checkGuess)
			self.panelTeamLock:setVisible(not checkOpen and not checkGuess)
			self.panelTeamNormal:setVisible(not checkOpen or not checkJoin)
			self.panelTeamRight:setVisible(checkOpen and checkJoin and checkRight)
			self.panelTeamWrong:setVisible(checkOpen and checkJoin and not checkRight)

			if checkOpen or checkNeedAnim then
				ActivityFigureGuessTools.refreshTeamShow(hero.team, self.imgTeam, self.txtTeam)
			end

			if not checkOpen and not checkGuess then
				self.txtTeamLock:setText(ClientUtils.getServerOsDate(Lang.get(76354), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animTeam,
					"UnLockTeam"
				})
			end
		end
	end

	local messageConfigList = ResOpActivityGuessQuestion[self.actId][Const.GUESS_TYPE_MESSAGE]

	for i = 1, #messageConfigList do
		local config = messageConfigList[i]
		local dayAnim = self.actData:checkTodayAnimed(config.unlock_time)
		local param = config.param
		local checkOpen = config.unlock_time <= self.day and dayAnim
		local checkNeedAnim = config.unlock_time <= self.day and not dayAnim

		if param == 1 then
			self.panelHeroLock:setVisible(checkOpen)

			if checkOpen or checkNeedAnim then
				self.lockHeroRole:showRole(heroId, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animHero,
					"UnLockNewHero1"
				})
			end
		elseif param == 2 then
			self.panelIdeaLock:setVisible(not checkOpen)
			self.panelIdeaOpen:setVisible(checkOpen)

			if (checkOpen or checkNeedAnim) and stepData[2] then
				local stepDesInfo = stepData[2]

				if not self.stepUpDoneChildIdea then
					self.stepUpDoneChildIdea = StepUpDonePanel(self, "MainInfoPanel/InformPanel/IEDAPanel/StageUpPanel", "System/Hero/StageUpDone", 0, 0, true)
				end

				self.stepUpDoneChildIdea:setData(stepDesInfo)
				self.stepUpDoneChildIdea.txtUpDoneDes:setVisible(false)
			end

			if not checkOpen then
				self.txtIdeaLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animIdea,
					"UnLockIEDA"
				})
			end
		elseif param == 3 then
			self.panelCoatLock:setVisible(not checkOpen)
			self.panelCoatOpen:setVisible(checkOpen)

			if (checkOpen or checkNeedAnim) and stepData[5] then
				local stepDesInfo = stepData[5]

				if not self.stepUpDoneChildCoat then
					self.stepUpDoneChildCoat = StepUpDonePanel(self, "MainInfoPanel/InformPanel/CoatPanel/StageUpPanel", "System/Hero/StageUpDone", 0, 0, true)
				end

				self.stepUpDoneChildCoat:setData(stepDesInfo)
				self.stepUpDoneChildCoat.txtUpDoneDes:setVisible(false)
			end

			if not checkOpen then
				self.txtCoatLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animCoat,
					"UnLockCoat"
				})
			end
		elseif param == 4 then
			self.panelCharacterLock:setVisible(not checkOpen)
			self.panelCharacterOpen:setVisible(checkOpen)

			if (checkOpen or checkNeedAnim) and stepData[4] then
				local stepDesInfo = stepData[4]

				if not self.stepUpDoneChildCharacter then
					self.stepUpDoneChildCharacter = StepUpDonePanel(self, "MainInfoPanel/InformPanel/CharacterPanel/StageUpPanel", "System/Hero/StageUpDone", 0, 0, true)
				end

				self.stepUpDoneChildCharacter:setData(stepDesInfo)
				self.stepUpDoneChildCharacter.txtUpDoneDes:setVisible(false)
			end

			if not checkOpen then
				self.txtCharacterLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animCharacter,
					"UnLockCharacter"
				})
			end
		elseif param == 5 then
			self.panelCVLock:setVisible(not checkOpen)
			self.panelCVOpen:setVisible(checkOpen)

			if checkOpen or checkNeedAnim then
				if not self.panelCvName then
					self.panelCvName = HeroCVNamePanel(self, "MainInfoPanel/InformPanel/HeroCVPanel/CvPanel")
				end

				self.panelCvName:setHero(hero)
			end

			if not checkOpen then
				self.txtCVLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animCV,
					"UnLockHeroCV"
				})
			end
		elseif param == 6 then
			self.panelHeroOpen:setVisible(checkOpen)
			self.panelHeroNameOpen:setVisible(checkOpen)
			self.panelHeroNameLock:setVisible(not checkOpen)

			if checkOpen or checkNeedAnim then
				self.openHeroRole:showRole(heroId, UIConst.ROLEIMAGE_SHOWTYPE_DRAW_CARD)
				self.txtHeroName:setText(hero.name)
			end

			if not checkOpen then
				self.txtHeroLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animHero,
					"UnLockNewHero2"
				})
			end
		elseif param == 7 then
			self.panelBaseLock:setVisible(not checkOpen)
			self.panelBaseOpen:setVisible(checkOpen)

			local miscConfig = self.actObj.actData.miscConfig

			if miscConfig.base_pos then
				self.panelBaseOpen:setPosition(miscConfig.base_pos[1], miscConfig.base_pos[2])
			end

			if miscConfig.base_scale then
				self.panelBaseOpen:setScale(miscConfig.base_scale)
			end

			if checkOpen or checkNeedAnim then
				local modelId = hero.resData.model

				self.imgBase:setImage("Atlas/CommonAtlas/IconAtlas/HeroBaseAtlas/Base" .. modelId .. "a", "Base" .. modelId .. "01")
			end

			if not checkOpen then
				self.txtBaseLock:setText(ClientUtils.getServerOsDate(Lang.get(76048), self.actObj.startTime + (config.unlock_time - 1) * 86400))
			end

			if checkNeedAnim then
				table.insert(self.animList, {
					self.animBase,
					"UnLockBed"
				})
			end
		end
	end

	self:refreshGuessPanel()
	self:refreshAwardPool()
	self:refreshSharePanel()

	if needShowResultGuess then
		local answerType = needShowConfig.answer_type
		local guessData = self.actData:getMyGuessData(answerType)
		local myChoose = guessData.choose_id or -1
		local rightId = guessData.right_id
		local awardId = guessData.award_scheme
		local ui

		if myChoose == rightId then
			ui = UIManager.getUI("activityFigureGuessWinResultDlg", true, true)
		else
			ui = UIManager.getUI("activityFigureGuessLoseResultDlg", true, true)
		end

		self.actData:setShowBonusDay(needShowResultGuess)
		ui:setData(self.actObj, answerType, rightId, awardId, Slot(self.onResultOver, self))
	elseif CurAvatar:isInCircle() then
		self:playAnim()
	end
end

function ActivityFigureGuessMainDlg:_guessTimerOver()
	return
end

function ActivityFigureGuessMainDlg:onResultOver(grid)
	local itId = grid.object.id
	local itNum = grid.object.num

	if itId and itNum and itNum > 0 then
		FlyIconUtils.setFlyUItoUI(grid, self.btnPond, itId, itNum, 1.5)
	end

	self:playAnim()
end

function ActivityFigureGuessMainDlg:playAnim()
	if self.animList then
		for i = 1, #self.animList do
			local list = self.animList[i]

			list[1]:startAni(list[2])
		end
	end

	self.actData:setTodayAnimed(self.day)
end

function ActivityFigureGuessMainDlg:refreshGuessPanel()
	local state, questionConfig = self.actData:getQuestionState()

	self.state = state

	self.panelGuessInfo:setVisible(state ~= Const.GUESS_TYPE_END)
	self.panelGuessRes:setVisible(state == Const.GUESS_TYPE_END)

	if state == Const.GUESS_TYPE_END then
		ClientTimerManager.RemoveSecondTickUI(self.txtGuessTime)
		self.txtGuessTime:setText(Lang.get(76049))

		local pNum, cNum = self.actData:getCircleAllWinNum()

		self.txtGuessRes:setText(utils.format(Lang.get(93811), pNum, cNum))
	else
		self.questionStage = questionConfig.param

		local answerType = questionConfig.answer_type
		local circleGuessData = self.actData:getCircleGuessData(answerType)
		local guessData = self.actData:getMyGuessData(answerType)
		local myChoose = guessData.choose_id or -1
		local rightId = guessData.right_id
		local checkGot = guessData.clan_award > 0
		local choose1Num = 0
		local choose2Num = 0
		local checkCanChoose = false

		if rightId < guessData.wrong_id then
			self.choose1Id = rightId
			self.choose2Id = guessData.wrong_id

			if checkGot then
				choose1Num = guessData.right_number or 0
				choose2Num = guessData.wrong_number or 0
			else
				choose1Num = circleGuessData and circleGuessData.right_number or 0
				choose2Num = circleGuessData and circleGuessData.wrong_number or 0
			end
		else
			self.choose1Id = guessData.wrong_id
			self.choose2Id = rightId

			if checkGot then
				choose1Num = guessData.wrong_number or 0
				choose2Num = guessData.right_number or 0
			else
				choose1Num = circleGuessData and circleGuessData.wrong_number or 0
				choose2Num = circleGuessData and circleGuessData.right_number or 0
			end
		end

		self.panelChoose1Group:setVisible(answerType == 1)
		self.panelChoose2Group:setVisible(answerType == 1)
		self.panelChoose1Career:setVisible(answerType == 2)
		self.panelChoose2Career:setVisible(answerType == 2)
		self.panelChoose1Team:setVisible(answerType == 3)
		self.panelChoose2Team:setVisible(answerType == 3)
		self.panelChoose1Select:setVisible(myChoose == self.choose1Id)
		self.panelChoose2Select:setVisible(myChoose == self.choose2Id)
		self.panelChoose1Right:setVisible(state == Const.GUESS_TYPE_ANSWER and rightId == self.choose1Id)
		self.panelChoose2Right:setVisible(state == Const.GUESS_TYPE_ANSWER and rightId == self.choose2Id)

		if answerType == 1 then
			self.txtQuestion:setText(Lang.get(76356))
			ActivityFigureGuessTools.refreshGroupShow(self.choose1Id, self.imgChoose1Group, self.txtChoose1Group)
			ActivityFigureGuessTools.refreshGroupShow(self.choose2Id, self.imgChoose2Group, self.txtChoose2Group)
		elseif answerType == 2 then
			self.txtQuestion:setText(Lang.get(76357))
			ActivityFigureGuessTools.refreshCareerShow(self.choose1Id, self.imgChoose1Career, self.txtChoose1Career)
			ActivityFigureGuessTools.refreshCareerShow(self.choose2Id, self.imgChoose2Career, self.txtChoose2Career)
		elseif answerType == 3 then
			self.txtQuestion:setText(Lang.get(76358))
			ActivityFigureGuessTools.refreshTeamShow(self.choose1Id, self.imgChoose1Team)
			ActivityFigureGuessTools.refreshTeamShow(self.choose2Id, self.imgChoose2Team)
		end

		self.questionTimerEndTime = 0

		local format

		if state == Const.GUESS_TYPE_QUESTION then
			if myChoose > 0 then
				format = Lang.get(76051)
				self.questionTimerEndTime = self.actObj.startTime + (self:getQuestionUnlockTime(self.day) - 1) * 86400
			else
				format = Lang.get(76052)
				self.questionTimerEndTime = self.actObj.startTime + self.day * 86400
				checkCanChoose = true
			end
		elseif state == Const.GUESS_TYPE_ANSWER then
			format = Lang.get(76053)
			self.questionTimerEndTime = self.actObj.startTime + (self:getNextQuestionTime(self.day) - 1) * 86400
		end

		local guessTime = self.questionTimerEndTime - ClientUtils.getServerTime()

		if guessTime > 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtGuessTime, guessTime, false, format, Slot(self._guessTimerOver, self))
		else
			ClientTimerManager.RemoveSecondTickUI(self.txtGuessTime)
			self.txtGuessTime:setText("")
		end

		if checkCanChoose then
			self.btnChoose1:setEnable(true)
			self.btnChoose2:setEnable(true)
			self.panelChooseSlider:setVisible(false)
			self.txtChoose1Num:setVisible(false)
			self.txtChoose2Num:setVisible(false)
		else
			self.btnChoose1:setEnable(false)
			self.btnChoose2:setEnable(false)
			self.panelChooseSlider:setVisible(true)
			self.txtChoose1Num:setVisible(true)
			self.txtChoose2Num:setVisible(true)
			self.txtChoose1Num:setText(choose1Num)
			self.txtChoose2Num:setText(choose2Num)

			if choose1Num + choose2Num > 0 then
				self.sliderChoose:setValue(choose1Num / (choose1Num + choose2Num))
			end
		end
	end
end

function ActivityFigureGuessMainDlg:questionTimerAction(sencond)
	ClientTimerManager.RemoveSecondTickUI(self.txtGuessTime)
end

function ActivityFigureGuessMainDlg:refreshAwardPool()
	local num = self.actData:getTotalAwardNum()

	self.emptyAwardPanel:setVisible(num == 0)
	self.haveAwardPanel:setVisible(num > 0)
	self.txtAwardNum:setText(num)
	self.iconPondNew:setVisible(self.actObj.actData:checkClanBonusNew())
end

function ActivityFigureGuessMainDlg:getQuestionUnlockTime(questionDay)
	local configDic = ResOpActivityGuessQuestion[self.actId]
	local curQuestionConfig
	local configList = configDic[Const.GUESS_TYPE_QUESTION]

	for i = 1, #configList do
		local config = configList[i]

		if config.unlock_time == questionDay then
			curQuestionConfig = config
		end
	end

	if curQuestionConfig then
		configList = configDic[Const.GUESS_TYPE_ANSWER]

		for i = 1, #configList do
			local config = configList[i]

			if config.param == curQuestionConfig.param then
				return config.unlock_time
			end
		end
	end

	return 0
end

function ActivityFigureGuessMainDlg:getNextQuestionTime(answerDay)
	local configDic = ResOpActivityGuessQuestion[self.actId]
	local curAnswerConfig
	local configList = configDic[Const.GUESS_TYPE_ANSWER]

	for i = 1, #configList do
		local config = configList[i]

		if config.unlock_time == answerDay then
			curAnswerConfig = config
		end
	end

	if curAnswerConfig then
		local nextQuestionDay = 0

		configList = configDic[Const.GUESS_TYPE_QUESTION]

		for i = 1, #configList do
			local config = configList[i]
			local unlockTime = config.unlock_time

			if answerDay < unlockTime and (nextQuestionDay == 0 or unlockTime < nextQuestionDay) then
				nextQuestionDay = unlockTime
			end
		end

		return nextQuestionDay
	end

	return 0
end

function ActivityFigureGuessMainDlg:refreshSharePanel()
	self.sharePanel:setNoAwardInfo("activityFigureGuessMainDlg")
	self.sharePanel:setShareVisible(true)
end

function ActivityFigureGuessMainDlg:onClickBtnPond()
	if not ActivityFigureGuessTools.checkActivityOpen(self.actId) then
		return
	end

	local ui = UIManager.getUI("activityFigureGuessPondDlg", true)

	ui:onShowActivity({
		self.actObj.clientTemplateData,
		self.actObj
	})
end

function ActivityFigureGuessMainDlg:onClickBtnRank()
	CurAvatar:tryGetClanGuessRanking()
end

function ActivityFigureGuessMainDlg:onClickBtnZoomIn()
	self.btnPond:setVisible(false)
	self.btnRank:setVisible(false)
	self.guessPanel:setVisible(false)
	self.timePanel:setVisible(false)
	self.btnZoomIn:setVisible(false)
	self.btnZoomOut:setVisible(true)
	self.sharePanel:setVisible(true)
	self:playAni("ChangeInformZoomIn")
end

function ActivityFigureGuessMainDlg:onClickBtnZoomOut()
	self.btnPond:setVisible(true)
	self.btnRank:setVisible(true)
	self.guessPanel:setVisible(true)
	self.timePanel:setVisible(true)
	self.btnZoomIn:setVisible(true)
	self.btnZoomOut:setVisible(false)
	self.sharePanel:setVisible(false)
	self:playAni("ChangeInformZoomOut")
end

function ActivityFigureGuessMainDlg:onClickBtnChoose1()
	if not ActivityFigureGuessTools.checkActivityOpen(self.actId) then
		return
	end

	if self.state ~= Const.GUESS_TYPE_QUESTION or self.myChoose then
		return
	end

	local ui = UIManager.getUI("activityFigureGuessConfirmDlg", true, true)

	ui:setData(self.actObj, self.questionStage, self.choose1Id)
end

function ActivityFigureGuessMainDlg:onClickBtnChoose2()
	if not ActivityFigureGuessTools.checkActivityOpen(self.actId) then
		return
	end

	if self.state ~= Const.GUESS_TYPE_QUESTION or self.myChoose then
		return
	end

	local ui = UIManager.getUI("activityFigureGuessConfirmDlg", true, true)

	ui:setData(self.actObj, self.questionStage, self.choose2Id)
end

function ActivityFigureGuessMainDlg:updateActivityData()
	self:refreshData()
end

function ActivityFigureGuessMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

return ActivityFigureGuessMainDlg
