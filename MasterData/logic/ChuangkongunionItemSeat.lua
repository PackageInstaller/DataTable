-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/view/ChuangkongunionItemSeat.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionItemSeat", package.seeall)

local ChuangkongunionItemSeat = class("ChuangkongunionItemSeat", ItemSeat)

function ChuangkongunionItemSeat.AddOnce(go)
	local component = ChuangkongunionItemSeat.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, ChuangkongunionItemSeat)

	return component
end

function ChuangkongunionItemSeat.Get(go)
	return (Framework.LuaComponentContainer.Get(go, ChuangkongunionItemSeat))
end

function ChuangkongunionItemSeat.Remove(go)
	Framework.LuaComponentContainer.Remove(go, ChuangkongunionItemSeat)
end

function ChuangkongunionItemSeat:_getPet(petId)
	return ChuangkongunionModel.instance:getPetMo(petId)
end

return ChuangkongunionItemSeat
