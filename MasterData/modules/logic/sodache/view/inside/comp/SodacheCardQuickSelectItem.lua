-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCardQuickSelectItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheCardQuickSelectItem", package.seeall)

local SodacheCardQuickSelectItem = class("SodacheCardQuickSelectItem", LuaCompBase)

function SodacheCardQuickSelectItem:ctor(param)
	self.cellParam = param
end

function SodacheCardQuickSelectItem:init(go)
	self._goitem = gohelper.findChild(go, "sodache_carditem")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._btnsub = gohelper.findChildButtonWithAudio(go, "#btn_sub")

	gohelper.setActive(self._btnsub, false)

	self.item = MonoHelper.addNoUpdateLuaComOnceToGo(self._goitem, SodacheCardItem)

	self.item:showInfo({
		false,
		true,
		false
	})
	self.item:setShowStar(true)
end

function SodacheCardQuickSelectItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClickItem, self)
	self._btnsub:AddClickListener(self._onClickSub, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickCardQuickSelectItem, self.updateCount, self)
end

function SodacheCardQuickSelectItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickCardQuickSelectItem, self.updateCount, self)
end

function SodacheCardQuickSelectItem:_onClickItem()
	local curSelectCount = self.cellParam:getItemSelectCount(self.data.serverMo.configId)

	if curSelectCount >= 1 then
		if self.cellParam:addItemCount(self.data.serverMo.configId, -1) then
			SodacheController.instance:dispatchEvent(SodacheEvent.OnClickCardQuickSelectItem, self.data, false)
		end
	elseif self.cellParam:addItemCount(self.data.serverMo.configId, 1) then
		SodacheController.instance:dispatchEvent(SodacheEvent.OnClickCardQuickSelectItem, self.data, true)
	end
end

function SodacheCardQuickSelectItem:_onClickSub()
	self.cellParam:addItemCount(self.data.serverMo.configId, -1)
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickCardQuickSelectItem, self.data, false)
end

function SodacheCardQuickSelectItem:updateMo(data)
	self.data = data

	self.item:updateMo(data)
	self:updateCount()
end

function SodacheCardQuickSelectItem:updateCount()
	local curSelectCount = self.cellParam:getItemSelectCount(self.data.serverMo.configId)

	self.item:setActiveSelect(curSelectCount > 0)
end

return SodacheCardQuickSelectItem
