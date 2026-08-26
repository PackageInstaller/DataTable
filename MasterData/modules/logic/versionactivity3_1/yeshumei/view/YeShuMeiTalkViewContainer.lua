-- chunkname: @modules/logic/versionactivity3_1/yeshumei/view/YeShuMeiTalkViewContainer.lua

module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiTalkViewContainer", package.seeall)

local YeShuMeiTalkViewContainer = class("YeShuMeiTalkViewContainer", BaseViewContainer)

function YeShuMeiTalkViewContainer:buildViews()
	return {
		YeShuMeiTalkView.New()
	}
end

return YeShuMeiTalkViewContainer
