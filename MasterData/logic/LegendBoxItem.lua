-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/LegendBoxItem.lua

module("logic.extensions.legend.view.treasure.LegendBoxItem", package.seeall)

local LegendBoxItem = class("LegendBoxItem")

function LegendBoxItem:ctor()
	return
end

function LegendBoxItem:init(go, cfg, view)
	self._boxCfg = cfg
	self._view = view

	self:_buildUI(go)
	self:_bindEvents()
	self:_setEffect()
	self:_updateBoxState()
end

function LegendBoxItem:_buildUI(go)
	self._icon = goutil.findChild(go, "icon")
	self._iconChange = self._icon:GetComponent("UIImageSpriteChange")
	self._effect = goutil.findChild(go, "effect")
	self._btn = Framework.ButtonAdapter.Get(go)
end

function LegendBoxItem:_bindEvents()
	self._btn:AddClickListener(self._onClick, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeGainTreasureRes, self._onGainTreasure, self)
end

function LegendBoxItem:_unbindEvents()
	self._btn:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeGainTreasureRes, self._onGainTreasure, self)
end

function LegendBoxItem:reset()
	self:_unbindEvents()
	self:_removeEffect()

	self._icon = nil
	self._iconChange = nil
	self._effect = nil
	self._boxCfg = nil
	self._view = nil
end

function LegendBoxItem:_onGainTreasure(id)
	if self._boxCfg.treasureId == id then
		self:_updateBoxState()
	end
end

function LegendBoxItem:_onClick()
	local state = self:_getBoxState()

	if state == LegendController.BoxStateEnum.Off then
		UIStateManager.instance:open(ViewName.BoxPopupView, self._boxCfg)
	elseif state == LegendController.BoxStateEnum.CanGet then
		LegendController.instance:sendLegendChallengeGainTreasureReq(self._boxCfg.treasureId)
	else
		FloatWordMgr.instance:show("已领取宝箱奖励")
	end
end

function LegendBoxItem:_setEffect()
	local effect = UIEffectManager.instance:playEffect(self._view, "fx_ui_renwu/fx_ui_kelingqubaoxiang.prefab", self._effect.transform, 0, 0, true)

	effect:setParent(self._effect.transform)
	effect:setScale(0.8)

	self._uiEffect = effect
end

function LegendBoxItem:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function LegendBoxItem:_getBoxState()
	return LegendController.instance:getBoxState(self._boxCfg.treasureId, self._boxCfg.condition)
end

function LegendBoxItem:_updateBoxState()
	local state = self:_getBoxState()

	self._iconChange:SetState(state)
	goutil.setActive(self._effect, state == LegendController.BoxStateEnum.CanGet)
	goutil.setActive(self._icon, state ~= LegendController.BoxStateEnum.CanGet)
end

return LegendBoxItem
