-- chunkname: @modules/logic/backpack/model/BackpackPropListModel.lua

module("modules.logic.backpack.model.BackpackPropListModel", package.seeall)

local BackpackPropListModel = class("BackpackPropListModel", ListScrollModel)

function BackpackPropListModel:setCategoryPropItemList(list)
	local co = {}
	local fillId = 1

	if not list then
		self:setList(co)
	end

	table.sort(list, BackpackPropListModel._sortProp)

	local function addPropList(v)
		local o = {}

		o.id = fillId
		o.config = v
		fillId = fillId + 1

		table.insert(co, o)
	end

	for _, v in pairs(list) do
		if v.isShow == 1 and v.isStackable == 1 then
			addPropList(v)
		end

		if v.isShow == 1 and v.isStackable == 0 then
			for i = 1, v.quantity do
				addPropList(v)
			end
		end
	end

	self:setList(co)
end

function BackpackPropListModel:clearList()
	self:clear()
end

function BackpackPropListModel._sortProp(a, b)
	local aconfig = ItemModel.instance:getItemConfig(a.type, a.id)
	local bconfig = ItemModel.instance:getItemConfig(b.type, b.id)

	if aconfig then
		if not aconfig.itemSortIdx then
			local aSortIdx = 0

			if bconfig then
				if not bconfig.itemSortIdx then
					local bSortIdx = 0

					if aSortIdx ~= bSortIdx then
						return bSortIdx < aSortIdx
					end

					local aType = a.type

					if aType == MaterialEnum.MaterialType.Currency then
						aType = -3
					elseif aType == MaterialEnum.MaterialType.NewInsight then
						aType = -2
					elseif aType == MaterialEnum.MaterialType.PowerPotion then
						aType = -1

						if a.id ~= b.id and a.id == MaterialEnum.PowerId.OverflowPowerId then
							return false
						end
					end

					local bType = b.type

					if bType == MaterialEnum.MaterialType.Currency then
						bType = -3
					elseif bType == MaterialEnum.MaterialType.NewInsight then
						bType = -2
					elseif bType == MaterialEnum.MaterialType.PowerPotion then
						bType = -1

						if a.id ~= b.id and b.id == MaterialEnum.PowerId.OverflowPowerId then
							return true
						end
					end

					if aType ~= bType then
						return aType < bType
					end

					local aExpireTime = a:itemExpireTime()
					local bExpireTime = b:itemExpireTime()

					if aExpireTime ~= bExpireTime then
						if bExpireTime == -1 or aExpireTime == -1 then
							return bExpireTime < aExpireTime
						else
							return aExpireTime < bExpireTime
						end
					end

					local aUseType = BackpackPropListModel._getSubTypeUseType(a.subType)
					local bUseType = BackpackPropListModel._getSubTypeUseType(b.subType)

					if aUseType ~= bUseType then
						return bUseType < aUseType
					end

					if aconfig.subType ~= bconfig.subType then
						return BackpackPropListModel._getSubclassPriority(aconfig.subType) < BackpackPropListModel._getSubclassPriority(bconfig.subType)
					elseif aconfig.rare ~= bconfig.rare then
						return aconfig.rare > bconfig.rare
					elseif a.id ~= b.id then
						return a.id > b.id
					end
				end
			end
		end
	end
end

function BackpackPropListModel._getSubclassPriority(id)
	local subCO = BackpackConfig.instance:getSubclassCo()

	if not subCO[id] then
		return 0
	end

	return subCO[id].priority
end

function BackpackPropListModel._getSubTypeUseType(subTypeId)
	local useTypeConfig = lua_item_use.configDict[subTypeId]

	if not useTypeConfig then
		return 0
	end

	return useTypeConfig.useType or 0
end

BackpackPropListModel.instance = BackpackPropListModel.New()

return BackpackPropListModel
