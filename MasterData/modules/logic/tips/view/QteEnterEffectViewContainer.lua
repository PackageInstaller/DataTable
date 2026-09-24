-- chunkname: @modules/logic/tips/view/QteEnterEffectViewContainer.lua

module("modules.logic.tips.view.QteEnterEffectViewContainer", package.seeall)

local QteEnterEffectViewContainer = class("QteEnterEffectViewContainer", BaseViewContainer)

function QteEnterEffectViewContainer:buildViews()
	return {
		QteEnterEffectView.New()
	}
end

return QteEnterEffectViewContainer
