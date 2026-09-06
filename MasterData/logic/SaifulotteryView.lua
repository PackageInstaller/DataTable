-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/SaifulotteryView.lua

module("logic.extensions.infinitefuture.view.SaifulotteryView", package.seeall)

local SaifulotteryView = class("SaifulotteryView", InfinfulotteryView)

function SaifulotteryView:ctor()
	SaifulotteryView.super.ctor(self)

	self._curActId = 112028
end

return SaifulotteryView
