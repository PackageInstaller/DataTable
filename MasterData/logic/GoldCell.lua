-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/gold/GoldCell.lua

module("logic.extensions.material.proxy.gold.GoldCell", package.seeall)

local GoldCell = class("GoldCell", ItemCell)

function GoldCell:ctor(target)
	GoldCell.super.ctor(self, target)
end

return GoldCell
