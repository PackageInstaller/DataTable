-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/Material.lua

module("logic.extensions.material.proxy.Material", package.seeall)

local Material = class("Material")

function Material:ctor(materialType, id, name, vipType, maxQuantity, dailyLimit, description, canSale, sale)
	self.materialType = materialType
	self.id = id
	self.name = name
	self.maxQuantity = maxQuantity
	self.dailyLimit = dailyLimit
	self.description = description
	self.canSale = canSale
	self.sale = sale
end

function Material:clone()
	return Material.New(self.materialType, self.id, self.name, self.maxQuantity, self.dailyLimit, self.description, self.canSale, self.sale)
end

return Material
