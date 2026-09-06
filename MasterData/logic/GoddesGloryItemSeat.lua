-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryItemSeat.lua

module("logic.extensions.goddessglory.view.GoddesGloryItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local GoddesGloryItemSeat = class("GoddesGloryItemSeat", ItemSeat)

function GoddesGloryItemSeat.AddOnce(go)
	local component = GoddesGloryItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, GoddesGloryItemSeat)

	return component
end

function GoddesGloryItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, GoddesGloryItemSeat))
end

function GoddesGloryItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, GoddesGloryItemSeat)
end

function GoddesGloryItemSeat:_getPet(petId)
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	return GoddessGloryPetsModel.instance:getPet(challengeId, stageId, petId)
end

function GoddesGloryItemSeat:_getCurFormId()
	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()

	return GoddessGloryFmtModel.instance:getCurFormationId(challengeId, stageId)
end

return GoddesGloryItemSeat
