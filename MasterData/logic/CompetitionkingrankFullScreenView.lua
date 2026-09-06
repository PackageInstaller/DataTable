-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingrankFullScreenView.lua

module("logic.extensions.competitionking.view.CompetitionkingrankFullScreenView", package.seeall)

local CompetitionkingrankFullScreenView = class("CompetitionkingrankFullScreenView", CompetitionkingrankView)

function CompetitionkingrankFullScreenView:onEnter()
	CompetitionkingrankFullScreenView.super.onEnter(self)
	GameUtil.SetActive(self._leftTop, true)
end

return CompetitionkingrankFullScreenView
