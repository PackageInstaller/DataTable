-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/XiaonuoBirthCopyView.lua

module("logic.extensions.bonus.view.XiaonuoBirthCopyView", package.seeall)

local XiaonuoBirthCopyView = class("XiaonuoBirthCopyView", XiaonuoBirthView)

function XiaonuoBirthCopyView:_getActivityId()
	local activityId = XiaonuoBirthConfig.instance:getCommonValue("COPY_CURR_ACTIVITY_ID")

	return checknumber(activityId)
end

function XiaonuoBirthCopyView:_onClickClose()
	BounsModel.instance:setSummerDoubleTabIndex()
	XiaonuoBirthCopyView.super._onClickClose(self)
end

return XiaonuoBirthCopyView
