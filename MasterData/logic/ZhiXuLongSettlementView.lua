-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongSettlementView.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongSettlementView", package.seeall)

local ZhiXuLongSettlementView = class("ZhiXuLongSettlementView", TimedPointRaceModeSettlementView)

function ZhiXuLongSettlementView:buildUI()
	ZhiXuLongSettlementView.super.buildUI(self)

	self._showTips = {
		lang("创造秩序"),
		lang("毁灭秩序")
	}
end

return ZhiXuLongSettlementView
