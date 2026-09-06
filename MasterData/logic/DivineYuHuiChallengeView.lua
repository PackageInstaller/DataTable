-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineyuhui/view/DivineYuHuiChallengeView.lua

module("logic.extensions.divineyuhui.view.DivineYuHuiChallengeView", package.seeall)

local DivineYuHuiChallengeView = class("DivineYuHuiChallengeView", ViewComponent)

function DivineYuHuiChallengeView:ctor()
	DivineYuHuiChallengeView.super.ctor(self)
end

function DivineYuHuiChallengeView:unbindEvents()
	DivineYuHuiChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnReset)
end

function DivineYuHuiChallengeView:bindEvents()
	DivineYuHuiChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function DivineYuHuiChallengeView:buildUI()
	DivineYuHuiChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnChallenge = self:getGo("rightCol/btnChallenge")
	self._btnReset = self:getGo("rightCol/btnReset")
	self._Content = self:getTxt("rightCol/ruleTitle/scrView/Viewport/Content")
	self._txtName = self:getTxt("rightCol/txtName")
	self._txtBuff = self:getTxt("rightCol/txtBuff")
	self._stages = self:getGo("stages")
	self._stageList = {}

	for i = 1, self._stages.transform.childCount do
		local stage = self:getGo("stages/stage" .. i)

		table.insert(self._stageList, stage)
	end

	self._tableviewPet = self:getGo("rightCol/tableviewPet")
	self._tablecellPet = self:getGo("rightCol/tableviewPet/tablecell")
	self._scrollListPet = ScrollerList.create(self._tableviewPet, self._tablecellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
	self._tableviewReward = self:getGo("rightCol/tableviewReward")
	self._tablecellReward = self:getGo("rightCol/tableviewReward/tablecell")
	self._scrollListReward = ScrollerList.create(self._tableviewReward, self._tablecellReward, GameUtil.handler(self._updateCellReward, self), GameUtil.handler(self._clearCellReward, self))
end

function DivineYuHuiChallengeView:onExit()
	DivineYuHuiChallengeView.super.onExit(self)
	self:_clearStages()
	self._scrollListPet:dispose()
	self._scrollListReward:dispose()
end

function DivineYuHuiChallengeView:onEnter()
	DivineYuHuiChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineYuHuiClgInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_DivineYuHuiClgResetRes, self._onResetRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 499001
	end

	self._stageId = DivineYuHuiController.instance:getCurChooseStageId(self._activityId)
	self._actCfg = DivineYuHuiConfig.instance:getActCfg(self._activityId)
	self._stageCfgs = DivineYuHuiConfig.instance:getStageCfg(self._activityId)

	self:_onUpdate()
	DivineYuHuiController.instance:sendPM_DivineYuHuiClgInfoReq(self._activityId)
end

function DivineYuHuiChallengeView:_onUpdate()
	self._info = DivineYuHuiModel.instance:getInfo(self._activityId) or {}
	self._curStageCfg = DivineYuHuiConfig.instance:getStageCfgByStageId(self._activityId, self._stageId)

	local rewardStr = self._actCfg.prize
	local rewardArr = string.split(rewardStr, "#")
	local infoStages = self._info.stages
	local raceIds = {}

	if infoStages then
		local stageInfo = infoStages[self._stageId]

		if stageInfo then
			raceIds = stageInfo.raceIds
		end
	end

	self._Content.text = self._curStageCfg.stageRule
	self._txtName.text = self._curStageCfg.name
	self._txtBuff.text = self._curStageCfg.stageBuffDesc

	self._scrollListPet:reloadData(raceIds)
	self._scrollListReward:reloadData(rewardArr)
	self:updateStages()
end

function DivineYuHuiChallengeView:updateStages()
	for i, stageCfg in ipairs(self._stageCfgs) do
		local stageGo = self._stageList[i]
		local imgChoose = goutil.findChild(stageGo, "imgChoose")
		local btnChoose = goutil.findChild(stageGo, "btnChoose")
		local pass = goutil.findChild(stageGo, "pass")
		local txtName = goutil.findChildTextComponent(stageGo, "txtName")
		local changeGroup = stageGo:GetComponent(ComponentType.UIChangeGroup)
		local headChangeComp = goutil.findChild(stageGo, "head"):GetComponent(ComponentType.UIImageSpriteChange)
		local stageInfo

		if self._info.stages then
			stageInfo = self._info.stages[stageCfg.stageId]
		end

		txtName.text = stageCfg.name

		headChangeComp:SetState(stageCfg.stageId - 1)
		GameUtil.SetActive(imgChoose, self._stageId == stageCfg.stageId)
		GameUtil.SetActive(pass, stageInfo ~= nil)
		GameUtil.addClickHandler(btnChoose, function()
			self._stageId = stageCfg.stageId

			self:_onUpdate()
			DivineYuHuiController.instance:setCurChooseStageId(self._activityId, self._stageId)
		end, self)
	end
end

function DivineYuHuiChallengeView:_clearStages()
	for i, stageCfg in ipairs(self._stageCfgs) do
		local stageGo = self._stageList[i]
		local btnChoose = goutil.findChild(stageGo, "btnChoose")

		GameUtil.rmClickHandler(btnChoose)
	end
end

function DivineYuHuiChallengeView:_updateCellPet(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function DivineYuHuiChallengeView:_clearCellPet(cell)
	MaterialMgr.resetAll(cell)
end

function DivineYuHuiChallengeView:_updateCellReward(view, cell, data)
	local reward = goutil.findChild(cell, "reward")
	local receive = goutil.findChild(cell, "receive")

	MaterialMgr.setCellByCfg(data, reward)

	local hasFirstPass = self._info.hadGainFinishPrize

	GameUtil.SetActive(receive, hasFirstPass)
end

function DivineYuHuiChallengeView:_clearCellReward(cell)
	local reward = goutil.findChild(cell, "reward")

	MaterialMgr.resetAll(reward)
end

function DivineYuHuiChallengeView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DivineYuHuiChallengeView:_onClickBtnChallenge()
	local stages = self._info.stages
	local stageInfo = stages and stages[self._stageId]

	if stageInfo and stageInfo then
		FloatWordMgr.instance:show("已挑战过，请重置后再挑战")

		return
	end

	DivineYuHuiController.instance:enterBattleClg(self._activityId, self._stageId)
end

function DivineYuHuiChallengeView:_onClickBtnReset()
	local stages = self._info.stages
	local stageInfo = stages[self._stageId]

	if stageInfo then
		local allStageHasPass = DivineYuHuiController.instance:allStageHasPass(self._activityId)

		if allStageHasPass then
			TipsFacade:openPopupWindow("提示", "您已首通，重置后将重置所有关卡是否继续", function()
				DivineYuHuiController.instance:sendPM_DivineYuHuiClgResetReq(self._activityId, -1)
			end, nil, "确认", "取消")
		else
			TipsFacade:openPopupWindow("提示", "是否重置此关卡", function()
				DivineYuHuiController.instance:sendPM_DivineYuHuiClgResetReq(self._activityId, self._stageId)
			end, nil, "确认", "取消")
		end
	else
		FloatWordMgr.instance:show("尚未挑战过，无法重置")

		return
	end
end

function DivineYuHuiChallengeView:_onResetRes(stageId)
	self._stageId = checknumber(stageId) <= 0 and DivineYuHuiController.instance:getCurChooseStageId(self._activityId) or stageId

	self:_onUpdate()
end

return DivineYuHuiChallengeView
