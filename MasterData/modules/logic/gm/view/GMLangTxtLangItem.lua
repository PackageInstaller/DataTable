-- chunkname: @modules/logic/gm/view/GMLangTxtLangItem.lua

module("modules.logic.gm.view.GMLangTxtLangItem", package.seeall)

local GMLangTxtLangItem = class("GMLangTxtLangItem", UserDataDispose)

GMLangTxtLangItem.pattenList = {
	"%[([^%]]*)%]",
	"【([^】]*)】",
	"%d"
}
GMLangTxtLangItem.replacement = "<color=yellow>%0</color>"

function GMLangTxtLangItem:init(go, lang)
	self._txtlang = gohelper.findChildText(go, "lang")
	self._txt = gohelper.findChildText(go, "txt")
	self._btnCopy = gohelper.findChildButtonWithAudio(go, "btnCopy")

	self._btnCopy:AddClickListener(self._onClickCopy, self)

	self._txtlang.text = lang
	self.lang = lang

	gohelper.setActive(go, true)
end

function GMLangTxtLangItem:updateStr(str)
	local inUseDic = GMLangController.instance:getInUseDic()

	if not inUseDic[str] or not inUseDic[str][self.lang] then
		self._txt.text = ""
	else
		self._langTxt = inUseDic[str][self.lang]

		local t = self._langTxt

		for _, patten in ipairs(GMLangTxtLangItem.pattenList) do
			t = string.gsub(t, patten, GMLangTxtLangItem.replacement)
		end

		self._txt.text = t
	end
end

function GMLangTxtLangItem:_onClickCopy()
	ZProj.UGUIHelper.CopyText(self._langTxt)
end

function GMLangTxtLangItem:onClose()
	self._btnCopy:RemoveClickListener()
end

return GMLangTxtLangItem
