-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yuanhuang/view/YuanhuangmainView.lua

module("logic.extensions.yuanhuang.view.YuanhuangmainView", package.seeall)

local YuanhuangmainView = class("YuanhuangmainView", ASheMainView)

function YuanhuangmainView:_getActivityId()
	self._activityId = 246003
end

function YuanhuangmainView:_openMissionView(creepsMasterId)
	ASheController.instance:openMissionView(self._activityId, self._tabId, creepsMasterId, ViewName.YuanhuangenterView, ViewName.YuanhuangmainView)
end

return YuanhuangmainView
