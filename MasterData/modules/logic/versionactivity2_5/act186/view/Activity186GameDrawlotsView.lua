-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameDrawlotsView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameDrawlotsView", package.seeall)

local Activity186GameDrawlotsView = class("Activity186GameDrawlotsView", BaseView)

function Activity186GameDrawlotsView:onInitView()
	self.goQian = gohelper.findChild(self.viewGO, "chouqian")
	self.goResult = gohelper.findChild(self.viewGO, "result")
	self.txtResult = gohelper.findChildTextMesh(self.viewGO, "result/left/#txt_resultdec")
	self.simageTitle = gohelper.findChildSingleImage(self.viewGO, "result/right/#simage_title")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "result/right/#simage_title/#txt_result")
	self.goReward1 = gohelper.findChild(self.viewGO, "result/right/rewards/reward1")
	self.txtRewardNum1 = gohelper.findChildTextMesh(self.viewGO, "result/right/rewards/reward1/#txt_num")
	self.goReward2 = gohelper.findChild(self.viewGO, "result/right/rewards/reward2")
	self.simageReward2 = gohelper.findChildSingleImage(self.viewGO, "result/right/rewards/reward2/icon")
	self.txtRewardNum2 = gohelper.findChildTextMesh(self.viewGO, "result/right/rewards/reward2/#txt_num")
	self.btnSure = gohelper.findChildButtonWithAudio(self.viewGO, "result/right/#btn_Sure")
	self.btnAgain = gohelper.findChildButtonWithAudio(self.viewGO, "result/right/#btn_Again")
	self.txtRest = gohelper.findChildTextMesh(self.viewGO, "result/right/#btn_Again/#txt_rest")
	self.goExit = gohelper.findChild(self.viewGO, "result/right/txt_exit")
	self.viewAnim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.qiantongAnim = gohelper.findChildComponent(self.viewGO, "chouqian/qiantong", gohelper.Type_Animator)
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "FullBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186GameDrawlotsView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addClickCb(self, self.btnSure, self.onClickBtnSure, self)
	self.addClickCb(self, self.btnAgain, self.onClickBtnAgain, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.PlayGame, self.onPlayGame, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishGame, self.onFinishGame, self)
end

function Activity186GameDrawlotsView:removeEvents()
	return
end

function Activity186GameDrawlotsView:_editableInitView()
	return
end

function Activity186GameDrawlotsView:onClickBtnClose()
	if self.gameStatus == Activity186Enum.GameStatus.Result then
		local mo = Activity186Model.instance:getById(self.actId)
		local gameInfo = mo and mo:getGameInfo(self.gameId)

		if not gameInfo then
			return
		end

		local retryCount = gameInfo.bTypeRetryCount

		if retryCount <= 0 then
			self:closeThis()
		end
	end
end

function Activity186GameDrawlotsView:onClickBtnSure()
	local mo = Activity186Model.instance:getById(self.actId)
	local gameInfo = mo and mo:getGameInfo(self.gameId)

	if not gameInfo then
		return
	end

	local rewardId = gameInfo.rewardId

	if rewardId and rewardId > 0 then
		Activity186Rpc.instance:sendFinishAct186BTypeGameRequest(self.actId, self.gameId)
		self:closeThis()
	end
end

function Activity186GameDrawlotsView:onClickBtnAgain()
	self.viewAnim:Play("change")
	self:startGame()
end

function Activity186GameDrawlotsView:onPlayGame()
	self.viewAnim:Play("finish")
	self:_showResult()
end

function Activity186GameDrawlotsView:onFinishGame()
	self:checkGameNotOnline()
end

function Activity186GameDrawlotsView:checkGameNotOnline()
	local mo = Activity186Model.instance:getById(self.actId)

	if not mo then
		return
	end

	local gameInfo = mo:getGameInfo(self.gameId)

	if not gameInfo then
		return
	end

	if not mo:isGameOnline(self.gameId) then
		self:closeThis()
	end
end

function Activity186GameDrawlotsView:onUpdateParam()
	return
end

function Activity186GameDrawlotsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_page_turn)
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)

	self.actId = self.viewParam.activityId
	self.gameId = self.viewParam.gameId
	self.gameStatus = self.viewParam.gameStatus

	self:refreshView()
	self:_showDeadline()
end

function Activity186GameDrawlotsView:refreshView()
	local mo = Activity186Model.instance:getById(self.actId)
	local gameInfo = mo and mo:getGameInfo(self.gameId)

	if not gameInfo then
		return
	end

	local rewardId = gameInfo.rewardId

	if rewardId and rewardId > 0 then
		self.viewAnim:Play("open1")
		self:_showResult()
	else
		self.viewAnim:Play("open")
		self:startGame()
	end
end

function Activity186GameDrawlotsView:startGame()
	self.gameStatus = Activity186Enum.GameStatus.Playing

	self.qiantongAnim:Play("idle")

	self.inDelayTime = false

	self:addTouchEvents()
	self:startCheckShake()
end

function Activity186GameDrawlotsView:startCheckShake()
	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)

	self.previousAcceleration = Vector3.New(curX, curY, curZ)

	TaskDispatcher.cancelTask(self._onCheckShake, self)
	TaskDispatcher.runRepeat(self._onCheckShake, self, 0.1)
end

function Activity186GameDrawlotsView:_onCheckShake()
	if self.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	local curX, curY, curZ = ZProj.EngineUtil.GetInputAcceleration(0, 0, 0)
	local currentAcceleration = Vector3.New(curX, curY, curZ)
	local accelerationDelta = currentAcceleration - self.previousAcceleration
	local accelerationDeltaMagnitude = accelerationDelta.magnitude

	if accelerationDeltaMagnitude > 0.5 then
		self:startDelayTime()
	end

	self.previousAcceleration = currentAcceleration
end

function Activity186GameDrawlotsView:addTouchEvents()
	if self._touchEventMgr then
		return
	end

	self._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(self.goQian)

	self._touchEventMgr:SetIgnoreUI(true)
	self._touchEventMgr:SetOnlyTouch(true)
	self._touchEventMgr:SetOnDragBeginCb(self._onDragBegin, self)
	self._touchEventMgr:SetOnDragEndCb(self._onDragEnd, self)
end

function Activity186GameDrawlotsView:_onDragBegin()
	self.inDrag = true

	if self.gameStatus == Activity186Enum.GameStatus.Playing then
		self:startDelayTime()
	end
end

function Activity186GameDrawlotsView:_onDragEnd()
	self.inDrag = false

	if self.gameStatus == Activity186Enum.GameStatus.Playing then
		-- block empty
	end
end

function Activity186GameDrawlotsView:startDelayTime()
	if self.inDelayTime then
		return
	end

	self.inDelayTime = true

	self.qiantongAnim:Play("open")
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_tangren_qiuqian)
	TaskDispatcher.cancelTask(self.checkFinish, self)
	TaskDispatcher.runDelay(self.checkFinish, self, 3)
end

function Activity186GameDrawlotsView:checkFinish()
	if self.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	self:showResult()
end

function Activity186GameDrawlotsView:showResult()
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)

	self.gameStatus = Activity186Enum.GameStatus.Result

	Activity186Rpc.instance:sendAct186BTypeGamePlayRequest(self.actId, self.gameId)
end

function Activity186GameDrawlotsView:_showResult()
	AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_day_night)

	self.gameStatus = Activity186Enum.GameStatus.Result

	local mo = Activity186Model.instance:getById(self.actId)
	local gameInfo = mo and mo:getGameInfo(self.gameId)

	if not gameInfo then
		return
	end

	local rewardId = gameInfo.rewardId
	local retryCount = gameInfo.bTypeRetryCount
	local rewardConfig = Activity186Config.instance:getGameRewardConfig(2, rewardId)

	if rewardConfig then
		if rewardId == 6 then
			self.simageTitle:LoadImage("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag5.png")
		else
			self.simageTitle:LoadImage(string.format("singlebg/v2a5_act186_singlebg/tag/v2a5_act186_tag%s.png", rewardId))
		end

		self.txtTitle.text = rewardConfig.blessingtitle
		self.txtResult.text = rewardConfig.blessingdes

		self:refreshReward(rewardConfig.bonus)
	end

	gohelper.setActive(self.btnAgain, retryCount > 0)
	gohelper.setActive(self.goExit, retryCount <= 0)

	if retryCount > 0 then
		self.txtRest.text = formatLuaLang("act186_gameview_remaintimes", retryCount)
	end
end

function Activity186GameDrawlotsView:refreshReward(bonus)
	local list = GameUtil.splitString2(bonus, true)
	local reward = {}

	for i, v in ipairs(list) do
		if v[1] ~= 26 then
			table.insert(reward, v)
		end
	end

	local reward1 = reward[1]
	local reward2 = reward[2]

	if reward1 then
		self.txtRewardNum1.text = string.format("×%s", reward1[3])

		gohelper.setActive(self.goReward1, true)
	else
		gohelper.setActive(self.goReward1, false)
	end

	if reward2 then
		gohelper.setActive(self.goReward2, true)

		local _, icon = ItemModel.instance:getItemConfigAndIcon(reward2[1], reward2[2], true)

		self.simageReward2:LoadImage(icon)

		self.txtRewardNum2.text = string.format("×%s", reward2[3])
	else
		gohelper.setActive(self.goReward2, false)
	end
end

function Activity186GameDrawlotsView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function Activity186GameDrawlotsView:_onRefreshDeadline()
	self:checkGameNotOnline()
end

function Activity186GameDrawlotsView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function Activity186GameDrawlotsView:onDestroyView()
	AudioMgr.instance:trigger(AudioEnum.Act186.stop_ui_bus)
	self.simageReward2:UnLoadImage()
	self.simageTitle:UnLoadImage()
	ViewMgr.instance:closeView(ViewName.Activity186GameInviteView)
	TaskDispatcher.cancelTask(self.checkFinish, self)
	TaskDispatcher.cancelTask(self._onCheckShake, self)
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

return Activity186GameDrawlotsView
