-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/view/ZhiXinQuanErTalkViewContainer.lua

module("modules.logic.versionactivity2_3.zhixinquaner.view.ZhiXinQuanErTalkViewContainer", package.seeall)

local ZhiXinQuanErTalkViewContainer = class("ZhiXinQuanErTalkViewContainer", BaseViewContainer)

function ZhiXinQuanErTalkViewContainer:buildViews()
	return {
		ZhiXinQuanErTalkView.New()
	}
end

return ZhiXinQuanErTalkViewContainer
