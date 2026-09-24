-- chunkname: @modules/logic/tips/view/QteOutEffectViewContainer.lua

module("modules.logic.tips.view.QteOutEffectViewContainer", package.seeall)

local QteOutEffectViewContainer = class("QteOutEffectViewContainer", BaseViewContainer)

function QteOutEffectViewContainer:buildViews()
	return {
		QteOutEffectView.New()
	}
end

return QteOutEffectViewContainer
