-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanzhaomueventView.lua

module("logic.extensions.richmanxplan.view.RmxplanzhaomueventView", package.seeall)

local RmxplanzhaomueventView = class("RmxplanzhaomueventView", ViewComponent)

function RmxplanzhaomueventView:ctor()
	RmxplanzhaomueventView.super.ctor(self)
end

function RmxplanzhaomueventView:unbindEvents()
	RmxplanzhaomueventView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function RmxplanzhaomueventView:bindEvents()
	RmxplanzhaomueventView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
end

function RmxplanzhaomueventView:buildUI()
	RmxplanzhaomueventView.super.buildUI(self)

	self._txtBuffDesc = self:getTxt("txts/txtBuffDesc")
	self._txtWorkType = self:getTxt("txts/txtWorkType")
	self._txtName = self:getTxt("txts/txtName")
	self._txtHave = self:getTxt("txtHave")
	self._txtCost = self:getTxt("txtCost")
	self._btnBuy = self:getBtn("btns/btnBuy")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._goRole = self:getGo("role")
end

function RmxplanzhaomueventView:onExit()
	RmxplanzhaomueventView.super.onExit(self)
	uGuiUtil.clearImage(self._goRole)
end

function RmxplanzhaomueventView:onEnter()
	RmxplanzhaomueventView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._params = GameUtil.jsonToTable(self._event.param)
	self._raceId = self._params.raceId

	self:_updateUI()
end

function RmxplanzhaomueventView:_onClickbtnBuy()
	local cfg = RichmanxplanConfig.instance:getRecruitEventItemCfg(self._activityId, self._event.eventId, self._raceId)

	if self._score >= cfg.cost then
		local text = "确定招募该精灵吗？"

		TipsFacade.instance:openPopupWindow("提示", text, function()
			RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false)
			self:close()
		end)
	else
		FloatWordMgr.instance:show("货币不足，暂时无法招募该伙伴噢！")
	end
end

function RmxplanzhaomueventView:_onClickbtnCancel()
	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true)
	self:close()
end

function RmxplanzhaomueventView:_updateUI()
	local cfg = RichmanxplanConfig.instance:getRecruitEventItemCfg(self._activityId, self._event.eventId, self._raceId)
	local petCfg = RichmanxplanConfig.instance:getPetCfg(self._activityId, self._raceId)

	self._txtHave.text = self._score
	self._txtCost.text = cfg.cost
	self._txtName.text = petCfg.name
	self._txtWorkType.text = petCfg.workType
	self._txtBuffDesc.text = petCfg.effectDesc

	local modelCo = CharacterConfig.instance:getModelCo(petCfg.linkRaceId)

	uGuiUtil.setSpriteToImage(self._goRole, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

return RmxplanzhaomueventView
