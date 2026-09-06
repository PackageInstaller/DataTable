-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originelizabeth/view/OriginelizabethposView.lua

module("logic.extensions.originelizabeth.view.OriginelizabethposView", package.seeall)

local OriginelizabethposView = class("OriginelizabethposView", FanRuiChallengePosView)

function OriginelizabethposView:_onClickBuff()
	UIStateManager.instance:push(ViewName.OriginelizabethforecastView, self._creepsMasterId)
end

return OriginelizabethposView
