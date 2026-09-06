-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodSelectCopyView.lua

module("logic.extensions.xiunuobrotherhoodcopy.view.XiuNuoBrotherhoodSelectCopyView", package.seeall)

local XiuNuoBrotherhoodSelectCopyView = class("XiuNuoBrotherhoodSelectCopyView", XiuNuoBrotherhoodSelectView)

function XiuNuoBrotherhoodSelectCopyView:ctor()
	XiuNuoBrotherhoodSelectCopyView.super.ctor(self)

	self._gameViewName = ViewName.XiuNuoBrotherhoodGameCopyView
end

return XiuNuoBrotherhoodSelectCopyView
