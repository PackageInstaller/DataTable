-- chunkname: @modules/logic/activity/view/goldenmilletpresent/GoldenMilletPresentItem.lua

module("modules.logic.activity.view.goldenmilletpresent.GoldenMilletPresentItem", package.seeall)

local GoldenMilletPresentItem = class("GoldenMilletPresentItem", RougeSimpleItemBase)

function GoldenMilletPresentItem:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "img_namebg/#txt/#txt_name")
	self._btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Present")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GoldenMilletPresentItem:addEvents()
	self._btnPresent:AddClickListener(self._btnPresentOnClick, self)
end

function GoldenMilletPresentItem:removeEvents()
	self._btnPresent:RemoveClickListener()
end

function GoldenMilletPresentItem:ctor(...)
	GoldenMilletPresentItem.super.ctor(self, ...)
end

function GoldenMilletPresentItem:_btnPresentOnClick()
	local p = self:parent()

	p:onPresentBtnClick(self)
end

function GoldenMilletPresentItem:_editableInitView()
	GoldenMilletPresentItem.super._editableInitView(self)

	self._txt = gohelper.findChildText(self.viewGO, "img_namebg/#txt")
end

function GoldenMilletPresentItem:setData(mo)
	GoldenMilletPresentItem.super.setData(self, mo)

	local skinId = mo[1]
	local skinCO = self:baseViewContainer():getSkinCo(skinId)
	local heroId = skinCO.characterId
	local heroCO = self:baseViewContainer():getHeroCO(heroId)

	self._txt.text = skinCO.name
	self._txtname.text = heroCO.name
end

function GoldenMilletPresentItem:onDestroyView()
	GoldenMilletPresentItem.super.onDestroyView(self)
end

return GoldenMilletPresentItem
