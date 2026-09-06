-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameAmazing.lua

module("logic.extensions.sxgame.view.SxGameAmazing", package.seeall)

local SxGameAmazing = class("SxGameAmazing")

function SxGameAmazing:ctor(componetContainer)
	self._container = componetContainer

	settimer(0.6, self._fadeOutFinishCallBack, self, false)
end

function SxGameAmazing:_fadeOutFinishCallBack()
	removetimer(self._fadeOutFinishCallBack, self)
	goutil.destroy(self._container.gameObject)
end

return SxGameAmazing
