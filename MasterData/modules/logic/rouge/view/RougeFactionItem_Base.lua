-- chunkname: @modules/logic/rouge/view/RougeFactionItem_Base.lua

module("modules.logic.rouge.view.RougeFactionItem_Base", package.seeall)

local RougeFactionItem_Base = class("RougeFactionItem_Base", RougeItemNodeBase)

function RougeFactionItem_Base:_editableInitView()
	self._itemClick = gohelper.getClickWithAudio(self._goBg)
end

function RougeFactionItem_Base:addEventListeners()
	RougeItemNodeBase.addEventListeners(self)
	self._itemClick:AddClickListener(self._onItemClick, self)
end

function RougeFactionItem_Base:removeEventListeners()
	RougeItemNodeBase.removeEventListeners(self)
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick")
end

function RougeFactionItem_Base:_onItemClick()
	local data = self:staticData()

	if not data then
		return
	end

	local baseViewContainer = data.baseViewContainer

	if not baseViewContainer then
		return
	end

	baseViewContainer:dispatchEvent(RougeEvent.RougeFactionView_OnSelectIndex, self:index())
end

function RougeFactionItem_Base:setData(mo)
	self._mo = mo

	local styleCO = mo.styleCO

	self._txtname.text = styleCO.name
	self._txtscrollDesc.text = styleCO.desc

	UISpriteSetMgr.instance:setRouge2Sprite(self._imageicon, styleCO.icon)
end

function RougeFactionItem_Base:difficulty()
	local p = self:parent()

	return p:difficulty()
end

return RougeFactionItem_Base
