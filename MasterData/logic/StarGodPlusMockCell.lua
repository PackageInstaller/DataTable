-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/stargodplus/StarGodPlusMockCell.lua

module("logic.extensions.material.proxy.item.StarGodPlusMockCell", package.seeall)

local StarGodPlusMockCell = class("StarGodPlusMockCell", ItemCell)

function StarGodPlusMockCell:setData(data)
	StarGodPlusMockCell.super.setData(self, data)
	self:setUiOfMock(true)
end

return StarGodPlusMockCell
