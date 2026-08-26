-- chunkname: @modules/logic/versionactivity3_0/karong/view/KaRongTalkViewContainer.lua

module("modules.logic.versionactivity3_0.karong.view.KaRongTalkViewContainer", package.seeall)

local KaRongTalkViewContainer = class("KaRongTalkViewContainer", BaseViewContainer)

function KaRongTalkViewContainer:buildViews()
	return {
		KaRongTalkView.New()
	}
end

return KaRongTalkViewContainer
