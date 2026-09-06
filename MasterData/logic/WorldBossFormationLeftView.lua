-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/worldboss/view/WorldBossFormationLeftView.lua

module("logic.extensions.worldboss.view.WorldBossFormationLeftView", package.seeall)

local WorldBossFormationLeftView = class("WorldBossFormationLeftView", FormationLeftView)

function WorldBossFormationLeftView:_getCurFormation()
	return WorldBossModel.instance:_getCurFormation()
end

function WorldBossFormationLeftView:_getPet(id)
	local mo

	return (WorldBossFormationLeftView.super._getPet(self, id))
end

return WorldBossFormationLeftView
