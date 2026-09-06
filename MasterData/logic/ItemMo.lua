-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/model/ItemMo.lua

module("logic.extensions.material.model.ItemMo", package.seeall)

local ItemMo = class("ItemMo", MaterialMo)

function ItemMo:ctor()
	ItemMo.super.ctor(self)
end

function ItemMo:initData(matType, id, num)
	ItemMo.super.initData(self, matType, id, num)

	self.quality = 0

	local subType = 0

	if matType == MatType.Item then
		local cfg = ItemConfig.instance:getCfgById(id)

		if cfg then
			subType = cfg.subType
			self.quality = cfg.quality
		end
	end

	self.subType = subType
end

function ItemMo:clone()
	local item = ItemMo.New()

	item.type = self.type
	item.id = self.id
	item.num = self.num
	item.subType = self.subType

	return item
end

return ItemMo
