-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodMainCopyView.lua

module("logic.extensions.xiunuobrotherhoodcopy.view.XiuNuoBrotherhoodMainCopyView", package.seeall)

local XiuNuoBrotherhoodMainCopyView = class("XiuNuoBrotherhoodMainCopyView", XiuNuoBrotherhoodMainView)

function XiuNuoBrotherhoodMainCopyView:ctor()
	XiuNuoBrotherhoodMainCopyView.super.ctor(self)

	self._selectViewName = ViewName.XiuNuoBrotherhoodSelectCopyView
end

function XiuNuoBrotherhoodMainCopyView:initData()
	self._activityId = XiuNuoBrotherhoodModel.instance:getCurrActId(2)

	if not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.XiuNuoBrotherhood, self._activityId) then
		FloatWordMgr.instance:show("未在开放时间内")
	end
end

function XiuNuoBrotherhoodMainCopyView:_setJumpViewNames()
	XiuNuoBrotherhoodModel.instance.instance:setJumpViewNames(ViewName.XiuNuoBrotherhoodMainCopyView, ViewName.XiuNuoBrotherhoodSelectCopyView, ViewName.XiuNuoBrotherhoodGameCopyView)
end

return XiuNuoBrotherhoodMainCopyView
