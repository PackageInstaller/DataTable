-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186GameDialogueView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186GameDialogueView", package.seeall)

local Activity186GameDialogueView = class("Activity186GameDialogueView", BaseView)

function Activity186GameDialogueView:onInitView()
	self.goRight = gohelper.findChild(self.viewGO, "root/right")
	self.rightAnim = self.goRight:GetComponent(gohelper.Type_Animator)
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/right/desc")
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "root/#goRole/bottom/#txt_Dialouge")
	self.options = {}
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_close")
	self.goOptions = gohelper.findChild(self.viewGO, "root/right/options")
	self.goRewards = gohelper.findChild(self.viewGO, "root/right/rewards")
	self.goReward1 = gohelper.findChild(self.viewGO, "root/right/rewards/reward1")
	self.txtRewardNum1 = gohelper.findChildTextMesh(self.viewGO, "root/right/rewards/reward1/#txt_num")
	self.goReward2 = gohelper.findChild(self.viewGO, "root/right/rewards/reward2")
	self.simageReward2 = gohelper.findChildSingleImage(self.viewGO, "root/right/rewards/reward2/icon")
	self.txtRewardNum2 = gohelper.findChildTextMesh(self.viewGO, "root/right/rewards/reward2/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186GameDialogueView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.FinishGame, self.onFinishGame, self)
end

function Activity186GameDialogueView:removeEvents()
	return
end

function Activity186GameDialogueView:_editableInitView()
	return
end

function Activity186GameDialogueView:onClickBtnClose()
	self:closeThis()
end

function Activity186GameDialogueView:onClickOption(index)
	if self.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	if self._selectIndex ~= index then
		self._selectIndex = index

		self:updateSelect()
	end

	if not self.questionConfig then
		return
	end

	local rewardId = self.questionConfig["rewardId" .. index]

	if rewardId == 0 then
		return
	end

	self.txtDesc.text = self.questionConfig["feedback" .. index]
	self.txtContent.text = self.questionConfig.hanzhangline4

	self:showResult(rewardId)
	Activity186Rpc.instance:sendFinishAct186ATypeGameRequest(self.actId, self.gameId, rewardId)
end

function Activity186GameDialogueView:onFinishGame()
	self:checkGameNotOnline()
end

function Activity186GameDialogueView:checkGameNotOnline()
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

function Activity186GameDialogueView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186GameDialogueView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function Activity186GameDialogueView:refreshParam()
	self.actId = self.viewParam.activityId
	self.gameId = self.viewParam.gameId
	self.gameStatus = self.viewParam.gameStatus
end

function Activity186GameDialogueView:refreshView()
	if self.gameStatus == Activity186Enum.GameStatus.Playing then
		self:_showDeadline()
		self.rightAnim:Play("open")

		local mo = Activity186Model.instance:getById(self.actId)
		local questionConfig = mo:getQuestionConfig(self.gameId)

		self.questionConfig = questionConfig
		self.txtDesc.text = questionConfig.question

		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_unlock)
		self:updateOptions(questionConfig)
	end
end

function Activity186GameDialogueView:updateOptions(config)
	for i = 1, 3 do
		self:updateOption(i, config)
	end

	self:updateSelect()
end

function Activity186GameDialogueView:updateSelect()
	for i = 1, 3 do
		local item = self:getOrCreateOption(i)

		gohelper.setActive(item.goNormal, self._selectIndex ~= i)
		gohelper.setActive(item.goSelect, self._selectIndex == i)
	end
end

function Activity186GameDialogueView:updateOption(index, config)
	local item = self:getOrCreateOption(index)
	local answer = config["answer" .. index]

	if string.nilorempty(answer) then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	item.txtNormal.text = answer
	item.txtSelect.text = answer
end

function Activity186GameDialogueView:getOrCreateOption(index)
	local item = self.options[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.findChild(self.viewGO, "root/right/options/item" .. index)
		item.goNormal = gohelper.findChild(item.go, "normal")
		item.goSelect = gohelper.findChild(item.go, "select")
		item.txtNormal = gohelper.findChildTextMesh(item.goNormal, "#txt_dec")
		item.txtSelect = gohelper.findChildTextMesh(item.goSelect, "#txt_dec")
		item.btn = gohelper.findButtonWithAudio(item.go)

		item.btn:AddClickListener(self.onClickOption, self, index)

		self.options[index] = item
	end

	return item
end

function Activity186GameDialogueView:showResult(rewardId)
	self.gameStatus = Activity186Enum.GameStatus.Result

	self.rightAnim:Play("finish")

	local rewardConfig = Activity186Config.instance:getGameRewardConfig(1, rewardId)

	self:refreshReward(rewardConfig.bonus)
end

function Activity186GameDialogueView:refreshReward(bonus)
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

function Activity186GameDialogueView:_showDeadline()
	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
end

function Activity186GameDialogueView:_onRefreshDeadline()
	self:checkGameNotOnline()
end

function Activity186GameDialogueView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
end

function Activity186GameDialogueView:onDestroyView()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	for i, v in ipairs(self.options) do
		v.btn:RemoveClickListener()
	end
end

return Activity186GameDialogueView
