-- chunkname: @modules/logic/sp01/act205/view/Act205RuleTipsView.lua

module("modules.logic.sp01.act205.view.Act205RuleTipsView", package.seeall)

local Act205RuleTipsView = class("Act205RuleTipsView", BaseView)

function Act205RuleTipsView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")
	self._txttitle = gohelper.findChildText(self.viewGO, "title/#txt_title")
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#scroll_info/Viewport/Content/#txt_desc")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act205RuleTipsView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function Act205RuleTipsView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function Act205RuleTipsView:_btnclose1OnClick()
	self:closeThis()
end

function Act205RuleTipsView:_btnclose2OnClick()
	self:closeThis()
end

function Act205RuleTipsView:_editableInitView()
	return
end

function Act205RuleTipsView:onUpdateParam()
	return
end

function Act205RuleTipsView:onOpen()
	self.activityId = Act205Model.instance:getAct205Id()
	self.gameStageId = Act205Model.instance:getGameStageId()

	local stageConfig = Act205Config.instance:getStageConfig(self.activityId, self.gameStageId)

	self._txttitle.text = stageConfig.ruleTitle
	self._txtdesc.text = stageConfig.ruleDesc
end

function Act205RuleTipsView:onClose()
	return
end

function Act205RuleTipsView:onDestroyView()
	return
end

return Act205RuleTipsView
