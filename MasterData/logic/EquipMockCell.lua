-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/equip/EquipMockCell.lua

module("logic.extensions.material.proxy.equip.EquipMockCell", package.seeall)

local EquipMockCell = class("EquipMockCell", EquipCell)

function EquipMockCell:ctor(target)
	EquipMockCell.super.ctor(self, target)
end

function EquipMockCell:setData(data)
	return
end

return EquipMockCell
