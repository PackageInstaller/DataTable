-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/duolalight/view/Duolalightmain2View.lua

module("logic.extensions.duolalight.view.Duolalightmain2View", package.seeall)

local Duolalightmain2View = class("Duolalightmain2View", DuoLaLightMainView)

function Duolalightmain2View:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.Duolalightstage2View)
end

return Duolalightmain2View
