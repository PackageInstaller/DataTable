-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongBuffEnterView.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongBuffEnterView", package.seeall)

local ZhiXuLongBuffEnterView = class("ZhiXuLongBuffEnterView", TimedPointRaceModeBuffEnterView)

function ZhiXuLongBuffEnterView:buildUI()
	ZhiXuLongBuffEnterView.super.buildUI(self)

	self._petName = lang("秩序龙")
end

return ZhiXuLongBuffEnterView
