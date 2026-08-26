-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheAttrContainerMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheAttrContainerMo", package.seeall)

local SodacheAttrContainerMo = pureTable("SodacheAttrContainerMo")

function SodacheAttrContainerMo:init(data)
	self.attrs = GameUtil.rpcInfosToMap(data.attrs, SodacheAttrValueMo, "id")
end

function SodacheAttrContainerMo:getAttr(attrId)
	return (self.attrs[attrId] or nil) and (self.attrs[attrId].finalVal or 0)
end

function SodacheAttrContainerMo:updateAttr(attrs)
	for i, v in ipairs(attrs) do
		self.attrs[v.id] = self.attrs[v.id] or SodacheAttrValueMo.New()

		self.attrs[v.id]:init(v)
	end
end

return SodacheAttrContainerMo
