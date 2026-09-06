-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/item/FruitCell.lua

module("logic.extensions.material.proxy.item.FruitCell", package.seeall)

local FruitCell = class("FruitCell", ItemCell)

function FruitCell:ctor(target)
	FruitCell.super.ctor(self, target)
end

return FruitCell
