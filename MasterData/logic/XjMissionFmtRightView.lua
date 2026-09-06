-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjMissionFmtRightView.lua

module("logic.extensions.xingjiang.view.XjMissionFmtRightView", package.seeall)

local XjMissionFmtRightView = class("XjMissionFmtRightView", FormationRightView)

function XjMissionFmtRightView:_getCurFormation()
	return (XingJiangModel.instance:GetCurFormation())
end

return XjMissionFmtRightView
