-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinemimengliclg/view/DivineMiMengLiClgStageResultView.lua

module("logic.extensions.divinemimengliclg.view.DivineMiMengLiClgStageResultView", package.seeall)

local DivineMiMengLiClgStageResultView = class("DivineMiMengLiClgStageResultView", ViewComponent)

function DivineMiMengLiClgStageResultView:buildUI()
	DivineMiMengLiClgStageResultView.super.buildUI(self)

	self._txtTitle1 = self:getTxt("title1/txt")
	self._txtTitle2 = self:getTxt("title2/txt")
	self._txtCur = self:getTxt("txtCur")
	self._btnCancel = self:getGo("btnCancel")
	self._btnSure = self:getGo("btnSure")
	self._values = self:getGo("values")
	self._tagGo = self:getGo("values/tagGo")
	self._txtResult = self:getTxt("values/txtResult")
	self._txtLast = self:getTxt("values/txtLast")
end

function DivineMiMengLiClgStageResultView:bindEvents()
	DivineMiMengLiClgStageResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickBtnCancel, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function DivineMiMengLiClgStageResultView:unbindEvents()
	DivineMiMengLiClgStageResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function DivineMiMengLiClgStageResultView:onEnter()
	DivineMiMengLiClgStageResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._divineMmlClgMo = DivineMiMengLiClgController.instance:getDivineMmlClgMo(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_DivineMiMengLiNotifyFightRes, self._onUpdate, self)
	self:_onUpdate()
end

function DivineMiMengLiClgStageResultView:onExit()
	DivineMiMengLiClgStageResultView.super.onExit(self)
end

function DivineMiMengLiClgStageResultView:_onUpdate()
	local msg = self._divineMmlClgMo:getFightMsg()

	if msg == nil then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId

	GameUtil.SetActive(self._tagGo, false)
	GameUtil.SetActive(self._txtResult.gameObject, false)
	GameUtil.SetActive(self._txtLast.gameObject, false)

	local stageType = DivineMiMengLiClgConfig.instance:getStageType(activityId, stageId)

	if stageType == DivineMmlClgEnum.StageType_One then
		-- block empty
	elseif stageType == DivineMmlClgEnum.StageType_Two then
		local value1 = msg.signBuffCount
		local teamCfg = DivineMiMengLiClgConfig.instance:getTeamCfg(activityId, stageId)
		local value2 = 0

		for _, data in ipairs(teamCfg) do
			value2 = value2 + self._divineMmlClgMo:getSignBuffCount(stageId, data.teamId)
		end

		self._txtTitle1.text = "本关卡已进入漩涡精灵数："
		self._txtCur.text = value1
		self._txtLast.text = value2
		self._txtResult.text = value1

		GameUtil.SetActive(self._tagGo, true)
		GameUtil.SetActive(self._txtResult.gameObject, true)
		GameUtil.SetActive(self._txtLast.gameObject, true)
	elseif stageType == DivineMmlClgEnum.StageType_Three then
		local signBuffCount = msg.signBuffCount

		self._txtTitle1.text = "击杀一横排数量："
		self._txtTitle2.text = "已生成的记忆冤魂数量："
		self._txtCur.text = signBuffCount
		self._txtResult.text = Mathf.Max(3 - signBuffCount, 0)

		GameUtil.SetActive(self._txtResult.gameObject, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._values:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._tagGo:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtResult.gameObject:GetComponent(goutil.Type_RectTransform))
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._txtLast.gameObject:GetComponent(goutil.Type_RectTransform))
end

function DivineMiMengLiClgStageResultView:_onClickBtnCancel()
	BattleController.instance:endBattle()
end

function DivineMiMengLiClgStageResultView:_onClickBtnSure()
	local msg = self._divineMmlClgMo:getFightMsg()

	if msg == nil then
		return
	end

	local activityId = msg.activityId
	local stageId = msg.stageId
	local teamId = msg.teamId

	DivineMiMengLiClgController.instance:sendPM_DivineMiMengLiClgConfirmReq(activityId, stageId, teamId)
	BattleController.instance:endBattle()
end

return DivineMiMengLiClgStageResultView
