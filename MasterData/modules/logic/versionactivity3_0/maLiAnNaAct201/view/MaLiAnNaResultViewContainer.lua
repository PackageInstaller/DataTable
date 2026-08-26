-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaResultViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaResultViewContainer", package.seeall)

local MaLiAnNaResultViewContainer = class("MaLiAnNaResultViewContainer", BaseViewContainer)

function MaLiAnNaResultViewContainer:buildViews()
	return {
		MaLiAnNaResultView.New()
	}
end

return MaLiAnNaResultViewContainer
