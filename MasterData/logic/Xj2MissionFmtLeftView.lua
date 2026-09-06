-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/Xj2MissionFmtLeftView.lua

module("logic.extensions.xingjiang.view.Xj2MissionFmtLeftView", package.seeall)

local Xj2MissionFmtLeftView = class("Xj2MissionFmtLeftView", FormationLeftView)

function Xj2MissionFmtLeftView:_getPet(petId)
	return XingJiangModel.instance:getPetMo(petId)
end

return Xj2MissionFmtLeftView
