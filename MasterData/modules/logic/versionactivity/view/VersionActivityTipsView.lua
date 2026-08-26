-- chunkname: @modules/logic/versionactivity/view/VersionActivityTipsView.lua

module("modules.logic.versionactivity.view.VersionActivityTipsView", package.seeall)

local VersionActivityTipsView = class("VersionActivityTipsView", BaseView)

function VersionActivityTipsView:onInitView()
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1", AudioEnum.UI.play_ui_help_close)
	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._goinfoitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_infoitem")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2", AudioEnum.UI.play_ui_help_close)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivityTipsView:addEvents()
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
	self._btnclose2:AddClickListener(self._btnclose2OnClick, self)
end

function VersionActivityTipsView:removeEvents()
	self._btnclose1:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function VersionActivityTipsView:_btnclose1OnClick()
	self:closeThis()
end

function VersionActivityTipsView:_btnclose2OnClick()
	self:closeThis()
end

function VersionActivityTipsView:_editableInitView()
	return
end

function VersionActivityTipsView:onUpdateParam()
	return
end

function VersionActivityTipsView:onOpen()
	local langTxt = luaLang("versionactivityexchange_rule")
	local strs = string.split(langTxt, "|")

	for i = 1, #strs, 2 do
		local item = gohelper.cloneInPlace(self._goinfoitem, "infoitem")

		gohelper.setActive(item, true)

		gohelper.findChildTextMesh(item, "txt_title").text = strs[i]
		gohelper.findChildTextMesh(item, "txt_desc").text = strs[i + 1]
	end
end

function VersionActivityTipsView:onClose()
	return
end

function VersionActivityTipsView:onDestroyView()
	return
end

return VersionActivityTipsView
