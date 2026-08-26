-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_UIFlying.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_UIFlying", package.seeall)

local CS_UIFlying = typeof(UnityEngine.UI.UIFlying)
local V3a4_Chg_UIFlying = class("V3a4_Chg_UIFlying", RougeSimpleItemBase)

function V3a4_Chg_UIFlying:ctor(ctorParam)
	self:__onInit()
	V3a4_Chg_UIFlying.super.ctor(self, ctorParam)
end

function V3a4_Chg_UIFlying:onDestroyView()
	self:clear()
	self:__onDispose()

	self._csUIFlyingCmp = nil
end

function V3a4_Chg_UIFlying:_editableInitView()
	V3a4_Chg_UIFlying.super._editableInitView(self)

	self._csUIFlyingCmp = self.viewGO:GetComponent(CS_UIFlying)
	self._icon = gohelper.findChildImage(self.viewGO, "flyitem/Prop/icon")
end

function V3a4_Chg_UIFlying:setIcon(name)
	self:baseViewContainer():setSprite(self._icon, name, true)
end

function V3a4_Chg_UIFlying:config(startPosition, endPosition, emitCount)
	self:setActive(false)

	self._csUIFlyingCmp.emitCount = math.max(0, emitCount or 0)
	self._csUIFlyingCmp.startPosition = startPosition
	self._csUIFlyingCmp.endPosition = endPosition
end

function V3a4_Chg_UIFlying:SetAllFlyItemDoneCallback(...)
	self._csUIFlyingCmp:SetAllFlyItemDoneCallback(...)
end

function V3a4_Chg_UIFlying:parentTrans()
	return self:transform().parent
end

function V3a4_Chg_UIFlying:StartFlying()
	self:setActive(true)
	self._csUIFlyingCmp:StartFlying()
end

function V3a4_Chg_UIFlying:StopAllFlying()
	self:setActive(false)
	self._csUIFlyingCmp:StopAllFlying()
end

function V3a4_Chg_UIFlying:clear()
	self:setActive(false)
	self._csUIFlyingCmp:RemoveAllCallback()
	self._csUIFlyingCmp:StopAllFlying()
end

return V3a4_Chg_UIFlying
