-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaNoticeViewContainer.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaNoticeViewContainer", package.seeall)

local MaLiAnNaNoticeViewContainer = class("MaLiAnNaNoticeViewContainer", BaseViewContainer)

function MaLiAnNaNoticeViewContainer:buildViews()
	return {
		MaLiAnNaNoticeView.New()
	}
end

return MaLiAnNaNoticeViewContainer
