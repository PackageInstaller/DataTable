-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/RoguelikelevelView.lua

module("logic.extensions.roguelike.view.RoguelikelevelView", package.seeall)

local RoguelikelevelView = class("RoguelikelevelView", ViewComponent)

function RoguelikelevelView:buildUI()
	RoguelikelevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnStart = self:getBtn("normalLevel/btnStart")
	self._btnExtraStart = self:getBtn("extraLevel/btnExtraStart")
	self._txtStart = self:getTxt("normalLevel/btnStart/txt")
	self._txtExtraStart = self:getTxt("extraLevel/btnExtraStart/txt")
	self._txtNormalNum = self:getTxt("normalLevel/txtNum")
	self._txtExtraNum = self:getTxt("extraLevel/txtNum")
	self._txtExtraKill = self:getTxt("extraLevel/txtKill")
end

function RoguelikelevelView:bindEvents()
	RoguelikelevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickReset, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnExtraStart, self._onClickExtraStart, self)
end

function RoguelikelevelView:unbindEvents()
	RoguelikelevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnReset)
	GameUtil.rmClickHandler(self._btnBuff)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnExtraStart)
end

function RoguelikelevelView:onEnter()
	RoguelikelevelView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._phaseId = params[2]

	self:_updateNormalLevel()
	self:_updateExtraLevel()
end

function RoguelikelevelView:onExit()
	RoguelikelevelView.super.onExit(self)
end

function RoguelikelevelView:_onClickReset()
	RoguelikeController.instance:onClickRefreshBuff(self._activityId, self._phaseId)
end

function RoguelikelevelView:_onClickBuff()
	UIStateManager.instance:push(ViewName.RoguelikebufflookView, self._activityId, self._phaseId)
end

function RoguelikelevelView:_onClickStart()
	local isPass = RoguelikeModel.instance:isPassAllNormalLevel(self._activityId, self._phaseId)

	if not isPass then
		RoguelikeController.instance:openNormalMissionView(self._activityId, self._phaseId)
	else
		FloatWordMgr.instance:show("普通试炼已通关！")
	end
end

function RoguelikelevelView:_onClickExtraStart()
	local isPassNormal = RoguelikeModel.instance:isPassAllNormalLevel(self._activityId, self._phaseId)
	local isPassExtra = RoguelikeModel.instance:isPassAllExtraLevel(self._activityId, self._phaseId)

	if not isPassNormal then
		FloatWordMgr.instance:show("需通过普通试炼全部关卡后才可解锁噢！")

		return
	end

	if isPassExtra then
		FloatWordMgr.instance:show("额外试炼已通关！")

		return
	end

	RoguelikeController.instance:openExtraMissionView(self._activityId, self._phaseId)
end

function RoguelikelevelView:_updateNormalLevel()
	local passNum = RoguelikeModel.instance:getNormalPassNum(self._activityId, self._phaseId)
	local isPass = RoguelikeModel.instance:isPassAllNormalLevel(self._activityId, self._phaseId)

	if isPass then
		self._txtNormalNum.text = string.format("第 %d 关", passNum)
	else
		local curShowStageId = RoguelikeController.instance:getNormalStartStageId(self._activityId, self._phaseId, passNum + 1)

		self._txtNormalNum.text = string.format("第 %d 关", curShowStageId)
	end

	GameUtil.SetGray(self._btnStart, isPass)

	self._txtStart.text = isPass and "已通关" or "开启试炼"
end

function RoguelikelevelView:_updateExtraLevel()
	local passNum = RoguelikeModel.instance:getExtraPassNum(self._activityId, self._phaseId)
	local killCount = RoguelikeModel.instance:getExtraKillCount(self._activityId, self._phaseId)

	self._txtExtraNum.text = string.format("最高记录\n%d关", passNum)
	self._txtExtraKill.text = string.format("当前击杀数\n%d", killCount)

	local isPassNormal = RoguelikeModel.instance:isPassAllNormalLevel(self._activityId, self._phaseId)

	if not isPassNormal then
		self._txtExtraStart.text = "未解锁试炼"

		GameUtil.SetGray(self._btnExtraStart, true)
	else
		local isPassExtra = RoguelikeModel.instance:isPassAllExtraLevel(self._activityId, self._phaseId)

		self._txtExtraStart.text = isPassExtra and "已通关" or "开启试炼"

		GameUtil.SetGray(self._btnExtraStart, isPassExtra)
	end
end

return RoguelikelevelView
