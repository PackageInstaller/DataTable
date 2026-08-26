-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaLevelTipsViewContainer.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelTipsViewContainer", package.seeall)

local LoperaLevelTipsViewContainer = class("LoperaLevelTipsViewContainer", BaseViewContainer)

function LoperaLevelTipsViewContainer:buildViews()
	return {
		LoperaLevelTipsView.New()
	}
end

return LoperaLevelTipsViewContainer
