-- chunkname: @modules/logic/rouge/model/RougeCollectionOverListModel.lua

module("modules.logic.rouge.model.RougeCollectionOverListModel", package.seeall)

local RougeCollectionOverListModel = class("RougeCollectionOverListModel", ListScrollModel)

function RougeCollectionOverListModel:onInitData()
	self:onCollectionDataUpdate()
end

function RougeCollectionOverListModel:onCollectionDataUpdate()
	local showCollectionList = {}
	local collectionMap = {}
	local slotAreaCollections = RougeCollectionModel.instance:getSlotAreaCollection()

	if slotAreaCollections then
		for _, collection in ipairs(slotAreaCollections) do
			if not collectionMap[collection.id] then
				collectionMap[collection.id] = true

				table.insert(showCollectionList, collection)
			end
		end
	end

	table.sort(showCollectionList, self.sortFunc)
	self:setList(showCollectionList)
end

function RougeCollectionOverListModel.sortFunc(a, b)
	local aCfg = RougeCollectionConfig.instance:getCollectionCfg(a.cfgId)
	local bCfg = RougeCollectionConfig.instance:getCollectionCfg(b.cfgId)

	if aCfg then
		if not aCfg.showRare then
			local aShowRare = 0

			if bCfg then
				if not bCfg.showRare then
					local bShowRare = 0

					if aShowRare ~= bShowRare then
						return bShowRare < aShowRare
					end

					local aShapeArea = RougeCollectionConfig.instance:getOriginEditorParam(a.cfgId, RougeEnum.CollectionEditorParamType.Shape)
					local bShapeArea = RougeCollectionConfig.instance:getOriginEditorParam(b.cfgId, RougeEnum.CollectionEditorParamType.Shape)

					if aShapeArea then
						if not #aShapeArea then
							local aShapeAreaSize = 0

							if bShapeArea then
								if not #bShapeArea then
									local bShapeAreaSize = 0

									if aShapeAreaSize ~= bShapeAreaSize then
										return bShapeAreaSize < aShapeAreaSize
									end

									return a.id < b.id
								end
							end
						end
					end
				end
			end
		end
	end
end

function RougeCollectionOverListModel:isBagEmpty()
	return self:getCount() <= 0
end

RougeCollectionOverListModel.instance = RougeCollectionOverListModel.New()

return RougeCollectionOverListModel
