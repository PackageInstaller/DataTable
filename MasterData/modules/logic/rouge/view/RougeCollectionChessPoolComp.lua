-- chunkname: @modules/logic/rouge/view/RougeCollectionChessPoolComp.lua

module("modules.logic.rouge.view.RougeCollectionChessPoolComp", package.seeall)

local RougeCollectionChessPoolComp = class("RougeCollectionChessPoolComp", BaseView)

function RougeCollectionChessPoolComp:onInitView()
	self._btnclosetipArea = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_closetipArea")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gochessContainer = gohelper.findChild(self.viewGO, "chessboard/#go_chessContainer")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_cellModel")
	self._gochessitem = gohelper.findChild(self.viewGO, "chessboard/#go_dragContainer/#go_chessitem")
	self._goraychessitem = gohelper.findChild(self.viewGO, "chessboard/#go_raychessitem")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._scrollbag = gohelper.findChildScrollRect(self.viewGO, "#scroll_bag")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content")
	self._gocollectionItem = gohelper.findChild(self.viewGO, "#scroll_bag/Viewport/#go_Content/#go_collectionItem")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._gosingleTipsContent = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	self._gosingleAttributeItem = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	self._gosizeitem = gohelper.findChild(self.viewGO, "#go_sizebag/#go_sizecollections/#go_sizeitem")
	self._golevelupeffect = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer/#go_levelupeffect")
	self._goengulfeffect = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer/#go_engulfeffect")
	self._goplaceeffect = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer/#go_placeeffect")
	self._goareaeffect = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer/#go_areaeffect")
	self._golightingeffect = gohelper.findChild(self.viewGO, "chessboard/#go_effectContainer/#go_lightingeffect")
	self._golinelevelup = gohelper.findChild(self.viewGO, "chessboard/#go_lineContainer/#go_linelevelup")
	self._golineengulf = gohelper.findChild(self.viewGO, "chessboard/#go_lineContainer/#go_lineengulf")
	self._goleveluptrigger1 = gohelper.findChild(self.viewGO, "chessboard/#go_triggerContainer/#go_levelup1")
	self._goleveluptrigger2 = gohelper.findChild(self.viewGO, "chessboard/#go_triggerContainer/#go_levelup2")
	self._goengulftrigger1 = gohelper.findChild(self.viewGO, "chessboard/#go_triggerContainer/#go_engulf1")
	self._goengulftrigger2 = gohelper.findChild(self.viewGO, "chessboard/#go_triggerContainer/#go_engulf2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeCollectionChessPoolComp:addEvents()
	return
end

function RougeCollectionChessPoolComp:removeEvents()
	return
end

function RougeCollectionChessPoolComp:_editableInitView()
	self._buildDragItemCount = 0
	self._buildEffectItemCount = 0
end

function RougeCollectionChessPoolComp:onUpdateParam()
	return
end

function RougeCollectionChessPoolComp:onOpen()
	return
end

function RougeCollectionChessPoolComp:getCollectionItem(cls)
	local clsPool = self:getOrCreateCollectionPool(cls)

	if clsPool then
		return (clsPool:getObject())
	end
end

function RougeCollectionChessPoolComp:recycleCollectionItem(cls, collectionItem)
	if not collectionItem then
		return
	end

	if self._poolMap then
		local clsPool = self._poolMap[cls]

		if clsPool then
			clsPool:putObject(collectionItem)
		end
	end
end

function RougeCollectionChessPoolComp:getOrCreateCollectionPool(cls)
	self._poolMap = self._poolMap or self:getUserDataTb_()

	local clsPool = self._poolMap[cls]

	if not clsPool then
		clsPool = cls == RougeCollectionDragItem.__cname and self:buildCollectionDragItemPool() or self:buildCollectionSizePool()
		self._poolMap[cls] = clsPool
	end

	return clsPool
end

function RougeCollectionChessPoolComp:buildCollectionDragItemPool()
	local poolCollectionMaxCount = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y

	return (LuaObjPool.New(poolCollectionMaxCount, function()
		local cacheCollectionCount = self._buildDragItemCount

		self._buildDragItemCount = cacheCollectionCount + 1

		local creatGOName = string.format("collection_%s", self._buildDragItemCount)
		local collectionDragItem = RougeCollectionDragItem.New()

		collectionDragItem:onInit(creatGOName, self)

		return collectionDragItem
	end, self.releaseCollectionItemFunction, self.resetCollectionItemFunction))
end

function RougeCollectionChessPoolComp.releaseCollectionItemFunction(collectionDragItem)
	if collectionDragItem then
		collectionDragItem:destroy()
	end
end

function RougeCollectionChessPoolComp.resetCollectionItemFunction(collectionDragItem)
	if collectionDragItem then
		collectionDragItem:reset()
	end
end

function RougeCollectionChessPoolComp:buildCollectionSizePool()
	local poolCollectionMaxCount = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y

	return (LuaObjPool.New(poolCollectionMaxCount, function()
		return (RougeCollectionSizeBagItem.New())
	end, self.releaseSizeItemFunction, self.resetSizeItemFunction))
end

function RougeCollectionChessPoolComp.releaseSizeItemFunction(collectionSizeItem)
	if collectionSizeItem then
		collectionSizeItem:destroy()
	end
end

function RougeCollectionChessPoolComp.resetSizeItemFunction(collectionSizeItem)
	if collectionSizeItem then
		collectionSizeItem:reset()
	end
end

function RougeCollectionChessPoolComp:getEffectItem(effectType)
	local effectPool = self:getOrCreateEffectPool(effectType)

	if effectPool then
		return (effectPool:getObject())
	else
		logError("cannot find effectpool, effectType = " .. tostring(effectType))
	end
end

function RougeCollectionChessPoolComp:recycleEffectItem(effectType, effectItem)
	if not effectType or not effectItem then
		return
	end

	if self._effectPoolMap then
		local effectPool = self._effectPoolMap[effectType]

		if effectPool then
			effectPool:putObject(effectItem)
		end
	end
end

function RougeCollectionChessPoolComp:getOrCreateEffectPool(effectType)
	self._effectPoolMap = self._effectPoolMap or self:getUserDataTb_()

	local effectPool = self._effectPoolMap[effectType]

	if not effectPool then
		effectPool = self:buildEffectPool(effectType)
		self._effectPoolMap[effectType] = effectPool
	end

	return effectPool
end

local maxEffectPerCell = 4

function RougeCollectionChessPoolComp:buildEffectPool(effectType)
	local poolCollectionMaxCount = RougeEnum.MaxCollectionSlotSize.x * RougeEnum.MaxCollectionSlotSize.y * maxEffectPerCell

	return (LuaObjPool.New(poolCollectionMaxCount, function()
		local cacheEffectCount = self._buildEffectItemCount

		self._buildEffectItemCount = cacheEffectCount + 1

		local creatGOName = string.format("effect_%s_%s", effectType, self._buildEffectItemCount)
		local prefab = self:getEffectClonePrefab(effectType)

		if not prefab then
			logError("克隆造物动效失败,失败原因:找不到指定效果类型的动效预制体,效果类型effectType = " .. tostring(effectType))
		end

		local effectGO = gohelper.cloneInPlace(prefab, creatGOName)

		if effectType == RougeEnum.CollectionArtType.LevelUpLine then
			local lineImg = gohelper.findChildImage(effectGO, "line")

			lineImg.material = UnityEngine.GameObject.Instantiate(lineImg.material)

			local lineupImage = gohelper.findChildImage(effectGO, "lineup")

			lineupImage.material = UnityEngine.GameObject.Instantiate(lineupImage.material)
		elseif effectType == RougeEnum.CollectionArtType.EngulfLine then
			local lineImg = gohelper.findChildImage(effectGO, "line")

			lineImg.material = UnityEngine.GameObject.Instantiate(lineImg.material)

			local lineupImage = gohelper.findChildImage(effectGO, "lineup")

			lineupImage.material = UnityEngine.GameObject.Instantiate(lineupImage.material)
		end

		return effectGO
	end, self.releaseEffectItemFunction, self.resetEffectItemFunction))
end

function RougeCollectionChessPoolComp:getEffectClonePrefab(effectType)
	if not self._effectPrefabTab then
		self._effectPrefabTab = self:getUserDataTb_()
		self._effectPrefabTab[RougeEnum.CollectionArtType.Place] = self._goplaceeffect
		self._effectPrefabTab[RougeEnum.CollectionArtType.Effect] = self._goareaeffect
		self._effectPrefabTab[RougeEnum.CollectionArtType.Lighting] = self._golightingeffect
		self._effectPrefabTab[RougeEnum.CollectionArtType.LevelUpLine] = self._golinelevelup
		self._effectPrefabTab[RougeEnum.CollectionArtType.EngulfLine] = self._golineengulf
		self._effectPrefabTab[RougeEnum.CollectionArtType.LevelUP] = self._golevelupeffect
		self._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger1] = self._goleveluptrigger1
		self._effectPrefabTab[RougeEnum.CollectionArtType.LevelUPTrigger2] = self._goleveluptrigger2
		self._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger1] = self._goengulftrigger1
		self._effectPrefabTab[RougeEnum.CollectionArtType.EngulfTrigger2] = self._goengulftrigger2
	end

	return self._effectPrefabTab and self._effectPrefabTab[effectType]
end

function RougeCollectionChessPoolComp.releaseEffectItemFunction(effectItem)
	if effectItem then
		gohelper.destroy(effectItem)
	end
end

function RougeCollectionChessPoolComp.resetEffectItemFunction(effectItem)
	if effectItem then
		gohelper.setActive(effectItem, false)
	end
end

function RougeCollectionChessPoolComp:onDestroyView()
	if self._poolMap then
		for _, clsPool in pairs(self._poolMap) do
			clsPool:dispose()
		end

		self._poolMap = nil
	end

	if self._effectPoolMap then
		for _, effectPool in pairs(self._effectPoolMap) do
			effectPool:dispose()
		end

		self._effectPoolMap = nil
	end
end

return RougeCollectionChessPoolComp
