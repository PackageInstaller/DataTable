-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itemget/view/ItemEffectFlyView.lua

module("logic.extensions.itemget.view.ItemEffectFlyView", package.seeall)

local ItemEffectFlyView = class("ItemEffectFlyView", ViewComponent)

function ItemEffectFlyView:ctor()
	ItemEffectFlyView.super.ctor(self)
end

function ItemEffectFlyView:bindEvents()
	self._sequence:AddListener(self._onEndFly, self)
end

function ItemEffectFlyView:unbindEvents()
	self._sequence:RemoveListener()
end

function ItemEffectFlyView:buildUI()
	self.icon = self:getGo("icon")
	self._sequence = self.mainGO:GetComponent(UnityTweensType.TweenSpawn)
end

function ItemEffectFlyView:destroyUI()
	return
end

function ItemEffectFlyView:onEnter()
	self._param = self._viewPresentor._openParam[1]

	local cfg

	uGuiUtil.setSpriteToImage(self.icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(ItemConfig.instance:getCfgById(checknumber(self._param.id)).icon))
end

function ItemEffectFlyView:onEnterFinished()
	return
end

function ItemEffectFlyView:onExit()
	return
end

function ItemEffectFlyView:onExitFinished()
	return
end

function ItemEffectFlyView:_onEndFly()
	ViewMgr.instance:destroy(ViewName.ItemEffectFly)
end

return ItemEffectFlyView
