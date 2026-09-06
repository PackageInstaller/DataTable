-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miukechallenge/view/MiukechallengeView.lua

module("logic.extensions.miukechallenge.view.MiukechallengeView", package.seeall)

local MiukechallengeView = class("MiukechallengeView", InfinfuchallengeView)

function MiukechallengeView:_openChallengeView()
	UIStateManager.instance:push(ViewName.MiukellevelsView)
end

return MiukechallengeView
