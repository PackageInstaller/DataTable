-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialContestMainView.lua

module("logic.extensions.martialcontest.view.MartialContestMainView", package.seeall)

local MartialContestMainView = class("MartialContestMainView", ViewComponent)

function MartialContestMainView:ctor()
	MartialContestMainView.super.ctor(self)
end

function MartialContestMainView:unbindEvents()
	MartialContestMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnEquips)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnFinals)
	GameUtil.rmClickHandler(self._btnScore)
	GameUtil.rmClickHandler(self._btnQualifier)
	GameUtil.rmClickHandler(self._btnFunny)
	GameUtil.rmClickHandler(self._btnFunny2)

	for i, v in ipairs(self._photoEffs) do
		v:clear()
	end

	for i, v in ipairs(self._roleBtns) do
		GameUtil.rmClickHandler(v)
	end
end

function MartialContestMainView:bindEvents()
	MartialContestMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClilckTip, self)
	GameUtil.addClickHandler(self._btnEquips, self._onClilckEquip, self)
	GameUtil.addClickHandler(self._btnRank, self._onClilckRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClilckShop, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClilckPrize, self)
	GameUtil.addClickHandler(self._btnFinals, self._onClilckFinals, self)
	GameUtil.addClickHandler(self._btnScore, self._onClilckScore, self)
	GameUtil.addClickHandler(self._btnQualifier, self._onClilckQualifier, self)
	GameUtil.addClickHandler(self._btnFunny, self._onClilckFunny, self)
	GameUtil.addClickHandler(self._btnFunny2, self._onClilckFunny, self)

	for i = 1, 3 do
		self._photoEffs[i]:setFirstAddParent(self._roleLoadHandler, self)
	end

	for i, v in ipairs(self._roleBtns) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClilckRole, self, i))
	end
end

function MartialContestMainView:buildUI()
	MartialContestMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnEquips = self:getGo("btnEquips")
	self._redPointEquip = self:getGo("btnEquips/redPoint")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnPrize = self:getGo("btnPrize")
	self._btnFinals = self:getGo("normalnode/btnFinals")
	self._btnScore = self:getGo("normalnode/btnScore")
	self._btnQualifier = self:getGo("normalnode/btnQualifier")
	self._btnFunny = self:getGo("normalnode/btnFunny")
	self._btnFunny2 = self:getGo("displaynode/btnFunny")
	self._tagQualifierPass = self:getGo("normalnode/btnQualifier/tagPass")
	self._tagQualifierOpen = self:getGo("normalnode/btnQualifier/tagOpen")
	self._tagQualifierOut = self:getGo("normalnode/btnQualifier/tagOut")
	self._tagQualifierRacing = self:getGo("normalnode/btnQualifier/tagRacing")
	self._tagQualifierEnd = self:getGo("normalnode/btnQualifier/tagEnd")
	self._txtQualifierFightTime = self:getTxt("normalnode/btnQualifier/txtFightTime")
	self._txtQualifierTime = self:getTxt("normalnode/btnQualifier/txtTime")
	self._redpointQualifier = self:getGo("normalnode/btnQualifier/redpoint")
	self._qualifierContentGray = self:getGo("normalnode/btnQualifier/contentGray")
	self._txtQualifierTimeGray = self:getTxt("normalnode/btnQualifier/contentGray/txtTime")
	self._tagScoreOut = self:getGo("normalnode/btnScore/tagOut")
	self._tagScoreOpen = self:getGo("normalnode/btnScore/tagOpen")
	self._tagScorePass = self:getGo("normalnode/btnScore/tagPass")
	self._tagScoreRacing = self:getGo("normalnode/btnScore/tagRacing")
	self._tagScoreEnd = self:getGo("normalnode/btnScore/tagEnd")
	self._txtScoreFightTime = self:getTxt("normalnode/btnScore/txtFightTime")
	self._txtScoreTime = self:getTxt("normalnode/btnScore/txtTime")
	self._redpointScore = self:getGo("normalnode/btnScore/redpoint")
	self._scoreContentGray = self:getGo("normalnode/btnScore/contentGray")
	self._txtScoreTimeGray = self:getTxt("normalnode/btnScore/contentGray/txtTime")
	self._tagFinalsRacing = self:getGo("normalnode/btnFinals/tagRacing")
	self._tagFinalsOpen = self:getGo("normalnode/btnFinals/tagOpen")
	self._tagFinalsOut = self:getGo("normalnode/btnFinals/tagOut")
	self._tagFinalsPass = self:getGo("normalnode/btnFinals/tagPass")
	self._tagFinalsEnd = self:getGo("normalnode/btnFinals/tagEnd")
	self._txtFinalsTime = self:getTxt("normalnode/btnFinals/txtTime")
	self._finalContentGray = self:getGo("normalnode/btnFinals/contentGray")
	self._txtFinalTimeGray = self:getTxt("normalnode/btnFinals/contentGray/txtTime")
	self._tagFunnyOut = self:getGo("normalnode/btnFunny/tagOut")
	self._tagFunnyRacing = self:getGo("normalnode/btnFunny/tagRacing")
	self._tagFunnyEnd = self:getGo("normalnode/btnFunny/tagEnd")
	self._tagFunnyPass = self:getGo("normalnode/btnFunny/tagPass")
	self._tagFunnyOpen = self:getGo("normalnode/btnFunny/tagOpen")
	self._txtFunnyFightTime = self:getTxt("normalnode/btnFunny/txtFightTime")
	self._txtFunnyTime = self:getTxt("normalnode/btnFunny/txtTime")
	self._redpointFunny = self:getGo("normalnode/btnFunny/redpoint")
	self._funnyContentGray = self:getGo("normalnode/btnFunny/contentGray")
	self._txtFunnyTimeGray = self:getTxt("normalnode/btnFunny/contentGray/txtTime")
	self._tagFunnyOut2 = self:getGo("displaynode/btnFunny/tagOut")
	self._tagFunnyRacing2 = self:getGo("displaynode/btnFunny/tagRacing")
	self._tagFunnyEnd2 = self:getGo("displaynode/btnFunny/tagEnd")
	self._tagFunnyPass2 = self:getGo("displaynode/btnFunny/tagPass")
	self._tagFunnyOpen2 = self:getGo("displaynode/btnFunny/tagOpen")
	self._txtFunnyFightTime2 = self:getTxt("displaynode/btnFunny/txtFightTime")
	self._txtFunnyTime2 = self:getTxt("displaynode/btnFunny/txtTime")
	self._redpointFunny2 = self:getGo("displaynode/btnFunny/redpoint")
	self._displaynodeGo = self:getGo("displaynode")
	self._normalnodeGo = self:getGo("normalnode")
	self._roleGos = {}
	self._photoEffs = {}
	self._avatars = {}
	self._txtNameShows = {}
	self._txtPowers = {}
	self._roleBtns = {}

	for i = 1, 3 do
		self._roleGos[i] = self:getGo("displaynode/role" .. i)
		self._txtNameShows[i] = self:getTxt("displaynode/role" .. i .. "/infoCom/txtNameShow")
		self._txtPowers[i] = self:getTxt("displaynode/role" .. i .. "/infoCom/txtPower")
		self._roleBtns[i] = goutil.findChild(self._roleGos[i], "btn")

		local roleRtGo = goutil.findChild(self._roleGos[i], "role")

		self._photoEffs[i] = AvatarPhotoShow.Get(roleRtGo)

		self._photoEffs[i]:setRawWidthAndHeight(1280, 720)
		self._photoEffs[i]:setCameraPosition(0, 1, -2)
		self._photoEffs[i]:setCamSize(2.2)
	end
end

function MartialContestMainView:onExit()
	MartialContestMainView.super.onExit(self)

	for i = 1, 3 do
		self._avatars[i] = nil
	end
end

function MartialContestMainView:onEnter()
	MartialContestMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MCGetInfoRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.MCGetDisplayInfoRes, self._onMCGetDisplayInfoRes, self)
	self.addGEvent(self, GlobalNotify.MCFinalsInfoRes, self._onMCFinalsInfoRes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 583001
	end

	MartialContestAgent.instance:sendPM_MCGetInfoReq(self._activityId)
	MartialContestAgent.instance:sendPM_MCGetFinalsEquipInfoReq(self._activityId)
	MartialContestAgent.instance:sendPM_MCGetDefenseForamtionReq(self._activityId)
	MartialContestAgent.instance:sendPM_MCFinalsGetFormationReq(self._activityId)

	local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)

	if MartialContestController.instance:_isInFinalStep(self._activityId, stepId) then
		MartialContestAgent.instance:sendPM_MCFinalsInfoReq(self._activityId)
	end

	self:_initView()
end

function MartialContestMainView:_initView()
	local qualifierStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Qualify_Step_Id)
	local scoreStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Score_Match_Step_Id)
	local finalsStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Finals_Start_Step_Id)
	local displayStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Display_Step_Id)
	local qualifierStartTime = GameUtil.string2time(qualifierStepCfg.startTime)
	local qualifierStartDate = GameUtil.string2date(qualifierStepCfg.startTime)
	local scoreStartTime = GameUtil.string2time(scoreStepCfg.startTime)
	local scoreStartDate = GameUtil.string2date(scoreStepCfg.startTime)
	local finalsStartTime = GameUtil.string2time(finalsStepCfg.startTime)
	local finalsStartDate = GameUtil.string2date(finalsStepCfg.startTime)
	local displayStartTime = GameUtil.string2time(displayStepCfg.startTime)
	local displayStartData = GameUtil.string2date(displayStepCfg.startTime)
	local actDefineCfg = ActivityDefineConfig.instance:getCfgByActivitYId(self._activityId)
	local activityEndTime = GameUtil.string2time(actDefineCfg.endTime)
	local activityEndDate = GameUtil.string2date(actDefineCfg.endTime)

	self._txtQualifierTime.text = langPara("%d.%d-%d:%d", qualifierStartDate.month, qualifierStartDate.day, scoreStartDate.month, scoreStartDate.day)
	self._txtQualifierTimeGray.text = self._txtQualifierTime.text
	self._txtScoreTime.text = langPara("%d.%d-%d:%d", scoreStartDate.month, scoreStartDate.day, finalsStartDate.month, finalsStartDate.day)
	self._txtScoreTimeGray.text = self._txtScoreTime.text
	self._txtFinalsTime.text = langPara("%d.%d-%d:%d", finalsStartDate.month, finalsStartDate.day, displayStartData.month, displayStartData.day)
	self._txtFinalTimeGray.text = self._txtFinalsTime.text
	self._txtFunnyTime.text = langPara("%d.%d-%d:%d", scoreStartDate.month, scoreStartDate.day, activityEndDate.month, activityEndDate.day)
	self._txtFunnyTime2.text = langPara("%d.%d-%d:%d", scoreStartDate.month, scoreStartDate.day, activityEndDate.month, activityEndDate.day)
	self._txtFunnyTimeGray.text = self._txtFunnyTime.text

	local nowTime = ServerTime.now()

	GameUtil.SetActive(self._tagQualifierOpen, nowTime < qualifierStartTime)
	GameUtil.SetActive(self._tagQualifierRacing, qualifierStartTime <= nowTime and nowTime < scoreStartTime)
	GameUtil.SetActive(self._tagQualifierEnd, scoreStartTime <= nowTime)
	GameUtil.SetActive(self._qualifierContentGray, scoreStartTime <= nowTime)
	GameUtil.SetActive(self._tagScoreOpen, nowTime < scoreStartTime)
	GameUtil.SetActive(self._tagScoreRacing, scoreStartTime <= nowTime and nowTime < finalsStartTime)
	GameUtil.SetActive(self._tagScoreEnd, finalsStartTime <= nowTime)
	GameUtil.SetActive(self._scoreContentGray, finalsStartTime <= nowTime or nowTime < scoreStartTime)
	GameUtil.SetActive(self._tagFinalsOpen, nowTime < finalsStartTime)
	GameUtil.SetActive(self._tagFinalsRacing, finalsStartTime <= nowTime and nowTime < displayStartTime)
	GameUtil.SetActive(self._tagFinalsEnd, displayStartTime <= nowTime)
	GameUtil.SetActive(self._finalContentGray, nowTime <= finalsStartTime or displayStartTime < nowTime)
	GameUtil.SetActive(self._tagFunnyOpen, nowTime < scoreStartTime)
	GameUtil.SetActive(self._tagFunnyRacing, scoreStartTime <= nowTime and nowTime < activityEndTime)
	GameUtil.SetActive(self._tagFunnyEnd, activityEndTime <= nowTime)
end

function MartialContestMainView:_refreshView()
	local qualifyTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, MartialContestEnum.Qualify_Step_Id)

	self._txtQualifierFightTime.text = langPara("今日剩余奖励次数:%d", qualifyTimes)

	local scoreTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, MartialContestEnum.Score_Match_Step_Id)

	self._txtScoreFightTime.text = langPara("今日剩余奖励次数:%d", scoreTimes)

	local funnyTimes = MartialContestController.instance:getCurLeftQualifierChanllegeTimes(self._activityId, MartialContestEnum.Entertainment_Step_Id)

	self._txtFunnyFightTime.text = langPara("今日剩余奖励次数:%d", funnyTimes)
	self._txtFunnyFightTime2.text = langPara("今日剩余奖励次数:%d", funnyTimes)

	local qualifierStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Qualify_Step_Id)
	local scoreStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, MartialContestEnum.Score_Match_Step_Id)
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)
	local playerRoundId = activityInfo.playerRoundId
	local curStepId = activityInfo.curStepId
	local curStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, curStepId)
	local qualifierOpen = curStepId == MartialContestEnum.Qualify_Step_Id and playerRoundId == MartialContestEnum.Qualify_Round_Id

	GameUtil.SetActive(self._txtQualifierFightTime, qualifierOpen)
	GameUtil.SetActive(self._tagQualifierPass, curStepId > MartialContestEnum.Qualify_Step_Id and playerRoundId > qualifierStepCfg.roundId)
	GameUtil.SetActive(self._tagQualifierOut, curStepId > MartialContestEnum.Qualify_Step_Id and playerRoundId <= qualifierStepCfg.roundId)
	GameUtil.SetActive(self._redpointQualifier, qualifyTimes > 0 and qualifierOpen == true)

	local scoreOpen = curStepId == MartialContestEnum.Score_Match_Step_Id and playerRoundId == MartialContestEnum.Score_Match_Round_Id

	GameUtil.SetActive(self._txtScoreFightTime, scoreOpen)
	GameUtil.SetActive(self._tagScorePass, curStepId > MartialContestEnum.Score_Match_Step_Id and playerRoundId > scoreStepCfg.roundId)
	GameUtil.SetActive(self._tagScoreOut, curStepId > MartialContestEnum.Score_Match_Step_Id and playerRoundId <= scoreStepCfg.roundId)
	GameUtil.SetActive(self._redpointScore, scoreTimes > 0 and scoreOpen)

	local isEnterFinal = playerRoundId >= MartialContestEnum.Finals_Day_One_Round_Id
	local isPassFinal = self:_calIsPassFinal()

	GameUtil.SetActive(self._tagFinalsPass, curStepId >= MartialContestEnum.Finals_Start_Step_Id and isPassFinal)
	GameUtil.SetActive(self._tagFinalsOut, curStepId >= MartialContestEnum.Finals_Start_Step_Id and not isPassFinal)
	GameUtil.SetActive(self._txtFunnyFightTime, curStepId > MartialContestEnum.Qualify_Step_Id and playerRoundId ~= curStepCfg.roundId)
	GameUtil.SetActive(self._funnyContentGray, curStepId < MartialContestEnum.Score_Match_Step_Id or playerRoundId == scoreStepCfg.roundId or isEnterFinal == true)
	GameUtil.SetActive(self._tagFunnyPass, playerRoundId ~= curStepCfg.roundId and not isEnterFinal)
	GameUtil.SetActive(self._redpointFunny, funnyTimes > 0 and playerRoundId ~= curStepCfg.roundId and not isEnterFinal)
	GameUtil.SetActive(self._redpointFunny2, funnyTimes > 0)

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, curStepId)
	local isDisplay = stepCfg.processorTarget == "DISPLAY"

	GameUtil.SetActive(self._displaynodeGo, isDisplay)
	GameUtil.SetActive(self._normalnodeGo, not isDisplay)

	if isDisplay then
		MartialContestAgent.instance:sendPM_MCGetDisplayInfoReq(self._activityId)
	end

	GameUtil.SetActive(self._redPointEquip, MartialContestController.instance:isCanUpgradeEquip(self._activityId))
end

function MartialContestMainView:_getQualifierFightTimeDesc(stepId)
	local fightTimes = MartialContestModel.instance:getFightTime(self._activityId, stepId)
	local qualifierCfg = MartialContestConfig.instance:getQualifierCfg(self._activityId, stepId)
end

function MartialContestMainView:_onClilckTip()
	TipsFacade.instance:openRulesView("martial_contest_clg_rule")
end

function MartialContestMainView:_onClilckEquip()
	UIStateManager.instance:push(ViewName.MartialContestEquipView, self._activityId)
end

function MartialContestMainView:_onClilckRank()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)

	if activityInfo.curStepId == MartialContestEnum.Qualify_Step_Id then
		UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 2)
	elseif activityInfo.curStepId == MartialContestEnum.Score_Match_Step_Id then
		UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 6)
	else
		UIStateManager.instance:push(ViewName.MartialcontestfinalrankView, self._activityId, 9)
	end
end

function MartialContestMainView:_onClilckShop()
	local activityCfg = MartialContestConfig.instance:getActivityCfg(self._activityId)

	if not string.nilorempty(activityCfg.jumpToShop) then
		GotoMgr.gotoByString(activityCfg.jumpToShop)
	end
end

function MartialContestMainView:_onClilckPrize()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)

	if activityInfo.curStepId == MartialContestEnum.Qualify_Step_Id then
		UIStateManager.instance:push(ViewName.MartialContestRewardView, self._activityId, MartialContestEnum.Qualify_Step_Id)
	elseif activityInfo.curStepId == MartialContestEnum.Score_Match_Step_Id then
		UIStateManager.instance:push(ViewName.MartialContestRewardView, self._activityId, MartialContestEnum.Score_Match_Step_Id)
	else
		UIStateManager.instance:push(ViewName.MartialContestRewardView, self._activityId, 3)
	end
end

function MartialContestMainView:_onClilckFinals()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)
	local curStepId = activityInfo.curStepId

	if MartialContestController.instance:isFinalBattleStep(self._activityId, curStepId) then
		UIStateManager.instance:push(ViewName.MartialcontestfinalView, self._activityId)
	else
		FloatWordMgr.instance:show(lang("未在阶段开启时间内"))
	end
end

function MartialContestMainView:_onClilckScore()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)
	local playerRoundId = activityInfo.playerRoundId
	local curStepId = activityInfo.curStepId
	local curStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, curStepId)

	if curStepId ~= MartialContestEnum.Score_Match_Step_Id then
		FloatWordMgr.instance:show(lang("未在阶段开启时间内"))
	elseif playerRoundId ~= curStepCfg.roundId then
		FloatWordMgr.instance:show(lang("未晋级"))
	else
		UIStateManager.instance:push(ViewName.MartialContestQualifierView, self._activityId, MartialContestEnum.Score_Match_Step_Id)
	end
end

function MartialContestMainView:_onClilckQualifier()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)
	local curStepId = activityInfo.curStepId

	if curStepId ~= MartialContestEnum.Qualify_Step_Id then
		FloatWordMgr.instance:show(lang("阶段已结束"))
	else
		UIStateManager.instance:push(ViewName.MartialContestQualifierView, self._activityId, MartialContestEnum.Qualify_Step_Id)
	end
end

function MartialContestMainView:_onClilckFunny()
	local activityInfo = MartialContestModel.instance:getInfo(self._activityId)
	local curStepId = activityInfo.curStepId
	local curStepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, curStepId)
	local isEnterFinal = self:_calIsEnterFinal()

	if curStepId <= MartialContestEnum.Qualify_Step_Id then
		FloatWordMgr.instance:show(lang("未在阶段开启时间内"))
	elseif isEnterFinal then
		FloatWordMgr.instance:show(lang("未晋级的选手或比赛结束后方可进入"))
	else
		UIStateManager.instance:push(ViewName.MartialContestQualifierView, self._activityId, MartialContestEnum.Entertainment_Step_Id)
	end
end

function MartialContestMainView:_displayTop3Role(msg)
	self._playerList = msg.playerList

	for i = 1, 3 do
		local player = self._playerList[i]
		local playerHeadInfo = player.headInfo

		self._txtNameShows[i].text = string.format("区服:%s-%s", player.areaId, playerHeadInfo.userName)
		self._txtPowers[i].text = player.zdl

		local skId = DressModel.instance:getSkeIdByGender(player.gender)
		local mo = DressModel.instance:getAvatarPlayerMo(skId, (not player.clothes or nil) and {}, 0)

		if self._avatars[i] then
			self._avatars[i]:updateByMo(mo)
		else
			self._avatars[i] = AvatarsMgrNew.instance:getAvatarByMo(mo)
			self._avatars[i].useType = AvatarUseType.Scene

			GameUtil.SetActive(self._roleGos[i], false)
			self._photoEffs[i]:addShowAvatarEffect(self._avatars[i])
		end
	end
end

function MartialContestMainView:_onMCGetDisplayInfoRes(msg)
	self:_displayTop3Role(msg)
end

function MartialContestMainView:_roleLoadHandler()
	for i = 1, 3 do
		if self._roleGos[i] then
			GameUtil.SetActive(self._roleGos[i], true)
		end
	end
end

function MartialContestMainView:_onClilckRole(idx)
	if self._playerList and self._playerList[idx] then
		local player = self._playerList[idx]

		FriendController.instance:showInfoView(player.headInfo.userId, self._roleBtns[idx])
	end
end

function MartialContestMainView:_onMCFinalsInfoRes()
	self:_refreshView()
end

function MartialContestMainView:_calIsPassFinal()
	local finalsInfo = MartialContestModel.instance:getFinalsInfo()

	if not finalsInfo then
		return false
	end

	if not finalsInfo.allPlayers or #finalsInfo.allPlayers <= 0 then
		return false
	end

	local uid = tostring(RoleModel.instance:getUserId())

	for i, v in ipairs(finalsInfo.allPlayers) do
		if v.headInfo.headInfo.userId == uid then
			return true
		end
	end

	return false
end

function MartialContestMainView:_calIsEnterFinal()
	local stepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)

	if stepId <= 0 or stepId >= MartialContestEnum.Display_Step_Id then
		return false
	end

	local finalsInfo = MartialContestModel.instance:getFinalsInfo()

	if not finalsInfo then
		return false
	end

	if not finalsInfo.allPlayers or #finalsInfo.allPlayers <= 0 then
		return false
	end

	local uid = tostring(RoleModel.instance:getUserId())

	for i, v in ipairs(finalsInfo.allPlayers) do
		if v.headInfo.headInfo.userId == uid then
			return true
		end
	end

	return false
end

return MartialContestMainView
