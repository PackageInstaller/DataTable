-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendItemSeat.lua

module("logic.extensions.recommendfmt.view.RecommendItemSeat", package.seeall)

local RecommendItemSeat = class("RecommendItemSeat", ItemSeat)

function RecommendItemSeat.AddOnce(go)
	local component = RecommendItemSeat.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, RecommendItemSeat)

	return component
end

function RecommendItemSeat.Get(go)
	return (Framework.LuaComponentContainer.Get(go, RecommendItemSeat))
end

function RecommendItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, RecommendItemSeat)
end

function RecommendItemSeat:_getPet(petId)
	return RecommendFmtModel.instance:getPet(petId)
end

return RecommendItemSeat
