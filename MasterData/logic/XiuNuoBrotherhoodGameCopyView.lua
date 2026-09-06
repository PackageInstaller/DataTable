-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiunuobrotherhoodcopy/view/XiuNuoBrotherhoodGameCopyView.lua

module("logic.extensions.xiunuobrotherhoodcopy.view.XiuNuoBrotherhoodGameCopyView", package.seeall)

local XiuNuoBrotherhoodGameCopyView = class("XiuNuoBrotherhoodGameCopyView", XiuNuoBrotherhoodGameView)

function XiuNuoBrotherhoodGameCopyView:ctor()
	XiuNuoBrotherhoodGameCopyView.super.ctor(self)

	self._buffViewName = ViewName.XiuNuoBrotherhoodBuffCopyView
end

return XiuNuoBrotherhoodGameCopyView
