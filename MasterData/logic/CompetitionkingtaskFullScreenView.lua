-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/competitionking/view/CompetitionkingtaskFullScreenView.lua

module("logic.extensions.competitionking.view.CompetitionkingtaskFullScreenView", package.seeall)

local CompetitionkingtaskFullScreenView = class("CompetitionkingtaskFullScreenView", CompetitionkingtaskView)

function CompetitionkingtaskFullScreenView:onEnter()
	CompetitionkingtaskFullScreenView.super.onEnter(self)
	GameUtil.SetActive(self._leftTop, true)
end

return CompetitionkingtaskFullScreenView
