-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuanhuang/view/YuanhuangenterView.lua

module("logic.extensions.yuanhuang.view.YuanhuangenterView", package.seeall)

local YuanhuangenterView = class("YuanhuangenterView", ASheEnterView)

function YuanhuangenterView:_getActivityId()
	self._activityId = 246003
end

function YuanhuangenterView:_onClickChallenge()
	UIStateManager.instance:push(ViewName.YuanhuangmainView)
end

return YuanhuangenterView
