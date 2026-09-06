-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/numberbomb/view/NumberRuleView.lua

module("logic.extensions.numberbomb.view.NumberRuleView", package.seeall)

local NumberRuleView = class("NumberRuleView", ViewComponent)

function NumberRuleView:ctor()
	NumberRuleView.super.ctor(self)

	self._scoreTxtList = nil
end

function NumberRuleView:bindEvents()
	NumberRuleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NumberRuleView:unbindEvents()
	NumberRuleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NumberRuleView:onExit()
	NumberRuleView.super.onExit(self)
end

function NumberRuleView:destroyUI()
	NumberRuleView.super.destroyUI(self)

	self._scoreTxtList = nil
end

function NumberRuleView:buildUI()
	NumberRuleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local rankScoreGo = self:getGo("ruleGo4/rankScoreGo")

	self._scoreTxtList = {
		goutil.findChildTextComponent(rankScoreGo, "number1/scoreTxt1"),
		goutil.findChildTextComponent(rankScoreGo, "number2/scoreTxt2"),
		goutil.findChildTextComponent(rankScoreGo, "number3/scoreTxt3"),
		goutil.findChildTextComponent(rankScoreGo, "number4/scoreTxt4")
	}
end

function NumberRuleView:onEnter()
	NumberRuleView.super.onEnter(self)

	if self._scoreTxtList and #self._scoreTxtList > 0 then
		for i = 1, #self._scoreTxtList do
			local cfg = NumberGameConfig.instance:getSettleCfg(i)

			self._scoreTxtList[i].text = (cfg == nil or string.nilorempty(cfg.scoreDes)) and "" or cfg.scoreDes
		end
	end
end

return NumberRuleView
