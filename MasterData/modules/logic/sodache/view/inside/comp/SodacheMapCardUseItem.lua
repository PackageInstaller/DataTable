-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheMapCardUseItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheMapCardUseItem", package.seeall)

local SodacheMapCardUseItem = class("SodacheMapCardUseItem", LuaCompBase)

function SodacheMapCardUseItem:init(go)
	self.go = go
	self.cardGo = gohelper.findChild(go, "sodache_carditem")
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self.cardGo, SodacheCardItem)

	self.cardItem:setOverrideClick(self.onCardClick, self)

	self._btnUse = gohelper.findChildButtonWithAudio(go, "#btn_use")
end

function SodacheMapCardUseItem:addEventListeners()
	self._btnUse:AddClickListener(self._onUseItem, self)
end

function SodacheMapCardUseItem:removeEventListeners()
	self._btnUse:RemoveClickListener()
end

function SodacheMapCardUseItem:_onUseItem()
	SodacheInsideRpc.instance:sendSodacheInsideSceneOperation(SodacheEnum.OperType.UseCard, tostring(self.data.serverMo.configId))
end

function SodacheMapCardUseItem:updateMo(data)
	self.data = data

	self.cardItem:updateMo(data)
end

function SodacheMapCardUseItem:onCardClick()
	ViewMgr.instance:openView(ViewName.SodacheCardDetailView, {
		cardMo = self.data,
		subView = SodacheCardDetailUseItemPart.New()
	})
end

function SodacheMapCardUseItem:setActive(isActive)
	gohelper.setActive(self.cardGo, isActive)
end

return SodacheMapCardUseItem
