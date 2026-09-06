-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/ResMonthCardView.lua

module("logic.extensions.monthcard.view.ResMonthCardView", package.seeall)

local ResMonthCardView = class("ResMonthCardView", MonthcardView)

function ResMonthCardView:onEnter()
	ResMonthCardView.super.onEnter(self)
	self:_loadEffect()
end

function ResMonthCardView:onExit()
	ResMonthCardView.super.onExit(self)
	self:_removeEffect()
end

function ResMonthCardView:_getCardId()
	return MonthCardModel.ResMonthCardId
end

function ResMonthCardView:_loadEffect()
	local path = "fx_ui_mibaoshangcheng/fx_ui_yueka_mibaoshangcheng.prefab"

	self._uiEffect = UIEffectManager.instance:playEffect(self, path, self.mainGO.transform, 0, 0, true, false)

	self._uiEffect:setParent(self.mainGO.transform)
	self._uiEffect:setScale(1)

	self._uiEffect.hideEffWhileNotOnTop = false
end

function ResMonthCardView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return ResMonthCardView
