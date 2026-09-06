-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hoshigami/view/HoshigamieprefabquipcomparetipsView.lua

module("logic.extensions.hoshigami.view.HoshigamieprefabquipcomparetipsView", package.seeall)

local HoshigamieprefabquipcomparetipsView = class("HoshigamieprefabquipcomparetipsView", HoshigamieprefabquiptipsView)

function HoshigamieprefabquipcomparetipsView:ctor()
	HoshigamieprefabquipcomparetipsView.super.ctor(self)

	self._isCompare = true
end

return HoshigamieprefabquipcomparetipsView
