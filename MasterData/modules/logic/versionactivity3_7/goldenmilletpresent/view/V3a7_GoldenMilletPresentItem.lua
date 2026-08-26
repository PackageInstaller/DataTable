-- chunkname: @modules/logic/versionactivity3_7/goldenmilletpresent/view/V3a7_GoldenMilletPresentItem.lua

module("modules.logic.versionactivity3_7.goldenmilletpresent.view.V3a7_GoldenMilletPresentItem", package.seeall)

local V3a7_GoldenMilletPresentItem = class("V3a7_GoldenMilletPresentItem", RougeSimpleItemBase)

function V3a7_GoldenMilletPresentItem:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "img_namebg/#txt/#txt_name")
	self._btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Present")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7_GoldenMilletPresentItem:addEvents()
	self._btnPresent:AddClickListener(self._btnPresentOnClick, self)
end

function V3a7_GoldenMilletPresentItem:removeEvents()
	self._btnPresent:RemoveClickListener()
end

function V3a7_GoldenMilletPresentItem:ctor(...)
	V3a7_GoldenMilletPresentItem.super.ctor(self, ...)
end

function V3a7_GoldenMilletPresentItem:_btnPresentOnClick()
	local p = self:parent()

	p:onPresentBtnClick(self)
end

function V3a7_GoldenMilletPresentItem:_editableInitView()
	V3a7_GoldenMilletPresentItem.super._editableInitView(self)

	self._txt = gohelper.findChildText(self.viewGO, "img_namebg/#txt")
end

function V3a7_GoldenMilletPresentItem:setData(mo)
	V3a7_GoldenMilletPresentItem.super.setData(self, mo)

	local skinId = mo[1]
	local skinCO = self:baseViewContainer():getSkinCo(skinId)
	local heroId = skinCO.characterId
	local heroCO = self:baseViewContainer():getHeroCO(heroId)

	self._txt.text = skinCO.name
	self._txtname.text = heroCO.name
end

function V3a7_GoldenMilletPresentItem:onDestroyView()
	V3a7_GoldenMilletPresentItem.super.onDestroyView(self)
end

return V3a7_GoldenMilletPresentItem
