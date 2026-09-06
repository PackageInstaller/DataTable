-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/view/NsopPlayMusicMainView.lua

module("logic.extensions.newsummonpetobtain.view.NsopPlayMusicMainView", package.seeall)

local NsopPlayMusicMainView = class("NsopPlayMusicMainView", ViewComponent)

function NsopPlayMusicMainView:buildUI()
	NsopPlayMusicMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._btnMusic = goutil.findChild(self.mainGO, "btnMusic")
	self._redBtnMusic = goutil.findChild(self.mainGO, "btnMusic/redPoint")
	self._taskScrollerview = goutil.findChild(self.mainGO, "taskCol/taskScrollerview")
	self._taskScrollercell = goutil.findChild(self.mainGO, "taskCol/taskScrollercell")
	self._con = goutil.findChild(self.mainGO, "con")
	self._taskScrollList = ScrollerList.create(self._taskScrollerview, self._taskScrollercell, GameUtil.handler(self._updateTaskCell, self), GameUtil.handler(self._clearTaskCell, self))
	self._bgEff = nil
end

function NsopPlayMusicMainView:bindEvents()
	NsopPlayMusicMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnMusic, self._onClickBtnMusic, self)
end

function NsopPlayMusicMainView:unbindEvents()
	NsopPlayMusicMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnMusic)
end

function NsopPlayMusicMainView:_getActivityId()
	return NewSummonPetObtainController.instance:getBeiduoActivityId()
end

function NsopPlayMusicMainView:onEnter()
	NsopPlayMusicMainView.super.onEnter(self)

	self._activityId = self:_getActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	local audioId = NewSummonPetObtainController.instance:getNsopMusicPlayAudioId()

	if audioId > 0 then
		NewSummonPetObtainController.instance:playNsopBgMusic(audioId)
	end

	self:_onSetUI()
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGetPlayerInfoRes, self._onUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGainTaskScoreRes, self._handleGainTaskScoreRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NewSummonPetObtainGameEndRes, self._sendInfoReq, self)
	self:_sendInfoReq()
end

function NsopPlayMusicMainView:onExit()
	NsopPlayMusicMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGetPlayerInfoRes, self._onUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGainTaskScoreRes, self._handleGainTaskScoreRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NewSummonPetObtainGameEndRes, self._sendInfoReq, self)
	RedPointController.instance:unregRedPoint(self._redBtnMusic)

	if self._bgEff then
		UIEffectManager.instance:stopEffect(self._bgEff)

		self._bgEff = nil
	end

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._taskScrollList:dispose()
end

function NsopPlayMusicMainView:_handleGainTaskScoreRes(msg)
	if msg and msg.taskId ~= 0 then
		local data = NewSummonPetObtainConfig.instance:getNspoTaskDataById(self._activityId, msg.taskId)

		if data then
			FloatWordMgr.instance:show(string.format("演奏完成,+%s积分", data.score))
		end
	end

	self:_sendInfoReq()
end

function NsopPlayMusicMainView:_sendInfoReq()
	NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGetPlayerInfoReq(self._activityId)
end

function NsopPlayMusicMainView:_onSetUI()
	local redIdAsMusicPlay = NewSummonPetObtainConfig.instance:getNspoMusicCanPlayRedId(self._activityId)

	if not string.nilorempty(redIdAsMusicPlay) then
		RedPointController.instance:regRedPoint(self._redBtnMusic, redIdAsMusicPlay)
	end

	local effParent = self.mainGO
	local pathName = "20221104/beiduo_jm/fx_ui_beiduo_jm2"

	UIEffectManager.instance:stopEffect(self._bgEff)

	if effParent and not string.nilorempty(pathName) then
		local path = pathName .. ".prefab"

		local function finishHandler(handlerTarget, eff)
			return
		end

		local function loadedHandler(handlerTarget, eff)
			eff:setParent(effParent.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)

			eff.hideEffWhileNotOnTop = true
		end

		local handlerTarget

		self._bgEff = UIEffectManager.instance:playEffect(self, path, effParent, 0, 0, true, false, finishHandler, loadedHandler, handlerTarget)
	end

	local skinId = NewSummonPetObtainConfig.instance:getNspoPetSkinId(self._activityId)

	self._role = RoleObjectPool.instance:removeRole(self._role)
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function NsopPlayMusicMainView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function NsopPlayMusicMainView:_onUpdateData()
	return
end

function NsopPlayMusicMainView:_onUpdateUI()
	self:_onUpdatePlaneUI()
	self:_updateTaskScrollerList()
end

function NsopPlayMusicMainView:_onUpdatePlaneUI()
	return
end

function NsopPlayMusicMainView:_updateTaskScrollerList()
	local list = {}
	local cfg = NewSummonPetObtainConfig.instance:getNspoTaskCfgById(self._activityId)

	for _, data in ipairs(cfg) do
		local t = {
			data = data,
			state = self:_calcPrizeState(data.taskId)
		}

		table.insert(list, t)
	end

	self._taskScrollList:reloadData(list)
end

function NsopPlayMusicMainView:_calcPrizeState(taskId)
	if NewSummonPetObtainController.instance:isHasGainTaskPrizeAsMusicTask(taskId) then
		return GameEnum.PrizeState.IsHasGain
	end

	if not NewSummonPetObtainController.instance:isEnoughPrizeAsMusicTask(taskId) then
		return GameEnum.PrizeState.IsNotEnough
	end

	return GameEnum.PrizeState.IsCanGet
end

function NsopPlayMusicMainView:_updateTaskCell(view, cell, cfg, tag)
	local data = cfg.data
	local state = cfg.state
	local mainGo = cell.gameObject
	local btnReceive = goutil.findChild(mainGo, "btnReceive")
	local btnGoto = goutil.findChild(mainGo, "btnGoto")
	local receivedGo = goutil.findChild(mainGo, "receivedGo")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local txtScore = goutil.findChildTextComponent(mainGo, "txtScore")

	txtTime.text = string.format("第%s天", data.taskId)
	txtScore.text = string.format("%s积分", data.score)

	GameUtil.SetActive(btnReceive, state == GameEnum.PrizeState.IsCanGet)
	GameUtil.SetActive(btnGoto, state == GameEnum.PrizeState.IsNotEnough)
	GameUtil.SetActive(receivedGo, state == GameEnum.PrizeState.IsHasGain)
	GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGo, self, data))
	GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onClickBtnReceive, self, data.taskId))
end

function NsopPlayMusicMainView:_clearTaskCell(cell)
	return
end

function NsopPlayMusicMainView:_onClickBtnGo(data)
	return
end

function NsopPlayMusicMainView:_onClickBtnReceive(taskId)
	if NewSummonPetObtainController.instance:isCanGetPrizeAsMusicTask(taskId) then
		NewSummonPetObtainController.instance:sendPM_NewSummonPetObtainGainTaskScoreReq(self._activityId, taskId)
	end
end

function NsopPlayMusicMainView:_onClickBtnClose()
	NewSummonPetObtainController.instance:stopNsopBgMusic()
	self:close()
end

function NsopPlayMusicMainView:_onClickBtnTip()
	TipsFacade.instance:openRulesView("playmusicscenceview_rule")
end

function NsopPlayMusicMainView:_onClickBtnMusic()
	if NewSummonPetObtainModel.instance:isHasPlayGameTodayInMusic() then
		FloatWordMgr.instance:show("今日已完成，明日再来吧！")

		return
	end

	if NewSummonPetObtainController.instance:isFinishAllTask() then
		FloatWordMgr.instance:show("你已完成全部演奏！")

		return
	end

	SurveyController.instance:reportBehavior(SurveyBehaviorID.NsoPlayMusic)
	UIStateManager.instance:push(ViewName.PlayMusicScenceView, self._activityId)
end

return NsopPlayMusicMainView
