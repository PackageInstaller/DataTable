-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheHandbookItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheHandbookItem", package.seeall)

local SodacheHandbookItem = class("SodacheHandbookItem", ListScrollCell)

function SodacheHandbookItem:init(go)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

	self.cardItem:setOverrideClick(self._btnItemOnClick, self)
end

function SodacheHandbookItem:onUpdateMO(config)
	self.config = config

	self.cardItem:updateMo(SodacheCardMo.Create(self.config.eleId))
end

function SodacheHandbookItem:onSelect(isSelect)
	self.isSelect = isSelect

	self.cardItem:setActiveSelect(isSelect)
end

function SodacheHandbookItem:_btnItemOnClick()
	if self.isSelect then
		return
	end

	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickHandbookItem, self.config)
end

return SodacheHandbookItem
