-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/drawequipments/model/DrawEquipGiftMO.lua

module("logic.extensions.drawequipments.model.DrawEquipGiftMO", package.seeall)

local DrawEquipGiftMO = class("DrawEquipGiftMO")

function DrawEquipGiftMO:ctor()
	self.goodsId = 0
	self.giftName = nil
	self.giftType = 0
	self.label = nil
	self.goodsCfgId = 0
	self.giftIcon = nil
	self.payType = 0
end

return DrawEquipGiftMO
