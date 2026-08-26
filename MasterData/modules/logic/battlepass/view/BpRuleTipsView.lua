-- chunkname: @modules/logic/battlepass/view/BpRuleTipsView.lua

module("modules.logic.battlepass.view.BpRuleTipsView", package.seeall)

local BpRuleTipsView = class("BpRuleTipsView", BaseView)

function BpRuleTipsView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1", AudioEnum.UI.play_ui_help_close)
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2", AudioEnum.UI.play_ui_help_close)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BpRuleTipsView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function BpRuleTipsView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

local split = string.split

function BpRuleTipsView:_btnclose1OnClick()
	self:closeThis()
end

function BpRuleTipsView:_btnclose2OnClick()
	self:closeThis()
end

function BpRuleTipsView:_editableInitView()
	self._titlecn = gohelper.findChildText(self.viewGO, "title/titlecn")
	self._titleen = gohelper.findChildText(self.viewGO, "title/titlecn/titleen")
end

function BpRuleTipsView:_ruleDesc()
	if self.viewParam then
		if self.viewParam then
			return self.viewParam
		end

		return self.viewName == ViewName.BpSPRuleTipsView and luaLang("bp_sp_rule") or luaLang("bp_rule")
	end
end

function BpRuleTipsView:_title()
	return (self.viewParam or nil) and (self.viewParam.title or luaLang("p_bpruletipsview_title"))
end

function BpRuleTipsView:_titleEn()
	return (self.viewParam or nil) and (self.viewParam.titleEn or "JUKEBOX DETAILS")
end

function BpRuleTipsView:onOpen()
	self._titlecn.text = self:_title()
	self._titleen.text = self:_titleEn()

	local strs = split(self:_ruleDesc(), "|")

	for i = 1, #strs, 2 do
		local item = gohelper.cloneInPlace(self._goinfoitem, "infoitem")

		gohelper.setActive(item, true)

		gohelper.findChildTextMesh(item, "txt_title").text = strs[i]
		gohelper.findChildTextMesh(item, "txt_desc").text = strs[i + 1]
	end
end

return BpRuleTipsView
