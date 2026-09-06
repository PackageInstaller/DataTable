-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tongbattle/view/TongRuleView.lua

module("logic.extensions.tongbattle.view.TongRuleView", package.seeall)

local TongRuleView = class("TongRuleView", ViewComponent)

function TongRuleView:ctor()
	TongRuleView.super.ctor(self)
end

function TongRuleView:bindEvents()
	TongRuleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
	self._cancelBtn:AddClickListener(self.close, self)
end

function TongRuleView:unbindEvents()
	TongRuleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
	self._cancelBtn:RemoveClickListener()
end

function TongRuleView:onExit()
	TongRuleView.super.onExit(self)
end

function TongRuleView:destroyUI()
	TongRuleView.super.destroyUI(self)
end

function TongRuleView:buildUI()
	TongRuleView.super.buildUI(self)

	local viewBgGo = self:getGo("viewBgGo")

	self._titleTxt = goutil.findChildTextComponent(viewBgGo, "titleTxt")
	self._descTxt = goutil.findChildTextComponent(viewBgGo, "descGo/descTxt")
	self._condTxt = goutil.findChildTextComponent(viewBgGo, "conditionsGo/condTxt")
	self._closeBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "closeBtn")
	self._sureBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "sureBtn")
	self._cancelBtn = Framework.ButtonAdapter.GetFrom(viewBgGo, "cancelBtn")
end

function TongRuleView:onEnter()
	TongRuleView.super.onEnter(self)

	self._paramInfo = self:getFirstParam()

	if self._paramInfo == nil or checknumber(self._paramInfo.chalType) == 0 then
		printError("sr---桶挑战 TongRuleView:onEnter()   传入参数错误！")

		return
	end

	local stageCfg = TongBattleConfig.instance:getMasterTeamCfg(self._paramInfo.planId, self._paramInfo.chalType, self._paramInfo.stageIndex)

	if stageCfg == nil then
		print("sr---桶挑战 TongRuleView:onEnter()   获取的挑战配置空 = ", self._paramInfo.planId, self._paramInfo.chalType, self._paramInfo.stageIndex)

		return
	end

	self._titleTxt.text = stageCfg.name
	self._descTxt.text = stageCfg.popExplanation
	self._condTxt.text = stageCfg.popCondition
end

function TongRuleView:_onClickSureBtn()
	if not TLChallengeController.instance:isInOpenTime(TongBattleModel.instance.challengeId) then
		FloatWordMgr.instance:show(lang("text_tong_desc_12"))
		self:close()

		return
	end

	local params = {
		planId = self._paramInfo.planId,
		chalType = self._paramInfo.chalType,
		stageId = self._paramInfo.stageIndex
	}

	UIStateManager.instance:push(ViewName.TongMission, params)
	self:close()
end

return TongRuleView
