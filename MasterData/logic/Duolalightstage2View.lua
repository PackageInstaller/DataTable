-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/Duolalightstage2View.lua

module("logic.extensions.duolalight.view.Duolalightstage2View", package.seeall)

local Duolalightstage2View = class("Duolalightstage2View", DuoLaLightStageView)

function Duolalightstage2View:_openLigthView(params)
	UIStateManager.instance:push(ViewName.Lightgame2View, params)
end

return Duolalightstage2View
