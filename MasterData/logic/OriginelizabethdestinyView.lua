-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethdestinyView.lua

module("logic.extensions.originelizabeth.view.OriginelizabethdestinyView", package.seeall)

local OriginelizabethdestinyView = class("OriginelizabethdestinyView", FanRuiChallengeDestinyView)

function OriginelizabethdestinyView:_onClickForecast()
	UIStateManager.instance:push(ViewName.OriginelizabethbuffView, self._planId, self._choiceId1, self._choiceId2, self._choiceId3)
end

return OriginelizabethdestinyView
