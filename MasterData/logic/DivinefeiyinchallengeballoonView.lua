-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinefeiyin/view/DivinefeiyinchallengeballoonView.lua

module("logic.extensions.divinefeiyin.view.DivinefeiyinchallengeballoonView", package.seeall)

local DivinefeiyinchallengeballoonView = class("DivinefeiyinchallengeballoonView", SunWuKongChallengeBalloonView)

function DivinefeiyinchallengeballoonView:_initFlyViewName()
	self._flyViewName = ViewName.DivinefeiyinchallengeballoontipsView
end

return DivinefeiyinchallengeballoonView
