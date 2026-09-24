-- chunkname: @modules/logic/matchgame/outside/comp/MatchGameItemTipView.lua

module("modules.logic.matchgame.outside.comp.MatchGameItemTipView", package.seeall)

local MatchGameItemTipView = class("MatchGameItemTipView", BaseView)

function MatchGameItemTipView:onInitView()
	self._imageIcon = gohelper.findChildImage(self.viewGO, "iconbg/#image_propicon")
	self._txtName = gohelper.findChildText(self.viewGO, "#txt_propname")
	self._txtCount = gohelper.findChildText(self.viewGO, "iconbg/#go_hadnumber/#txt_count")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_desc/viewport/content/#txt_desc")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameItemTipView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function MatchGameItemTipView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function MatchGameItemTipView:_btnCloseOnClick()
	self:closeThis()
end

function MatchGameItemTipView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function MatchGameItemTipView:onOpen()
	self._itemId = self.viewParam and self.viewParam.itemId
	self._itemCo = lua_activity244_item.configDict[self._itemId]

	self:refreshUI()
end

function MatchGameItemTipView:refreshUI()
	self._txtName.text = self._itemCo and self._itemCo.name

	local count = MatchGameModel.instance:getItemCount(self._itemId)

	self._txtCount.text = formatLuaLang("materialtipview_itemquantity", count)

	MatchGameHelper.setItemIcon(self._itemId, self._imageIcon, nil, MatchGameEnum.ItemIconType.Large)

	self._txtDesc.text = self._itemCo and self._itemCo.desc
end

return MatchGameItemTipView
