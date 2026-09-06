-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamiequipcomparetipsView.lua

module("logic.extensions.hoshigami.view.HoshigamiequipcomparetipsView", package.seeall)

local HoshigamiequipcomparetipsView = class("HoshigamiequipcomparetipsView", HoshigamiequiptipsView)

function HoshigamiequipcomparetipsView:ctor()
	HoshigamiequipcomparetipsView.super.ctor(self)

	self._isCompare = true
end

return HoshigamiequipcomparetipsView
