-- chunkname: @modules/logic/versionactivity3_6/yami/model/V3a6YaMiProductMO.lua

module("modules.logic.versionactivity3_6.yami.model.V3a6YaMiProductMO", package.seeall)

local V3a6YaMiProductMO = class("V3a6YaMiProductMO")

function V3a6YaMiProductMO:initConfig(co)
	self.co = co
	self.id = co.id
	self.isNew = GameUtil.playerPrefsGetNumberByUserId(V3a6YaMiEnum.PrefsKey.HankbookProductNew .. self.id, 0) == 0
	self._attrMo = V3a6YaMiAttrMO.New()

	if not string.nilorempty(co.attributeWeight) then
		local attributeWeight = string.splitToNumber(co.attributeWeight, "#")

		for i, v in ipairs(attributeWeight) do
			self._attrMo:setAttrValue(i, v)
		end
	end

	self.subType = co.type
	self.materials = not string.nilorempty(co.recipe) and string.splitToNumber(co.recipe, "#") or {}
end

function V3a6YaMiProductMO:refreshInfo(info)
	self._attrMo:refreshInfo(info.attr)

	self.rating = info.rating
	self.aiIndex = info.aiIndex
end

function V3a6YaMiProductMO:setMaterials(subType, materials)
	self.subType = subType
	self.materials = materials and tabletool.copy(materials) or {}
end

function V3a6YaMiProductMO:setLock(isLock)
	self.isLock = isLock
end

function V3a6YaMiProductMO:refreshNewTag(isNew)
	self.isNew = isNew

	GameUtil.playerPrefsSetNumberByUserId(V3a6YaMiEnum.PrefsKey.HankbookProductNew .. self.id, isNew and 0 or 1)
end

function V3a6YaMiProductMO:getAttrMo()
	return self._attrMo
end

function V3a6YaMiProductMO:getAttrValue(type)
	return self._attrMo:getAttrValue(type)
end

function V3a6YaMiProductMO:_isConformTo(type, list)
	if self.subType ~= type then
		return false
	end

	if not list or not self.materials then
		return false
	end

	if #list ~= #self.materials then
		return false
	end

	for _, v in ipairs(list) do
		if not LuaUtil.tableContains(self.materials, v) then
			return true
		end
	end

	return true
end

function V3a6YaMiProductMO:onForceChangeMaterials(type, list)
	self.subType = type
	self.materials = {}

	if list then
		for _, v in ipairs(list) do
			table.insert(self.materials, v)
		end
	end
end

function V3a6YaMiProductMO:isTrash()
	return self.id == V3a6YaMiConfig.instance:getConstValueByConst(V3a6YaMiEnum.ConstId.TrashProduct)
end

function V3a6YaMiProductMO:getCost()
	local cost = 0

	if self.subType then
		local co = V3a6YaMiConfig.instance:getMaterialCo(self.subType)

		cost = co and co.cost or 0
	end

	if self.materials then
		for _, v in ipairs(self.materials) do
			local co = V3a6YaMiConfig.instance:getMaterialCo(v)

			cost = cost + ((co or nil) and (co.cost or 0))
		end
	end

	return cost
end

return V3a6YaMiProductMO
