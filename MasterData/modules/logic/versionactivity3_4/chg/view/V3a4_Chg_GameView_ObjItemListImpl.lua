-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_ObjItemListImpl.lua

local ti = table.insert

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_ObjItemListImpl", package.seeall)

local V3a4_Chg_GameView_ObjItemListImpl = class("V3a4_Chg_GameView_ObjItemListImpl", RougeSimpleItemBase)

function V3a4_Chg_GameView_ObjItemListImpl:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameView_ObjItemListImpl:_editableInitView()
	V3a4_Chg_GameView_ObjItemListImpl.super._editableInitView(self)

	self._gridLayoutComp = self:GetComponent(gohelper.Type_GridLayoutGroup)
	self._containerList = self:getUserDataTb_()

	local childCount = self:childCount()

	for i = 0, childCount - 1 do
		local childTr = self._trans:GetChild(i)

		ti(self._containerList, childTr)
	end

	self:onMapSizeChange()
end

function V3a4_Chg_GameView_ObjItemListImpl:ctor(ctorParam)
	V3a4_Chg_GameView_ObjItemListImpl.super.ctor(self, ctorParam)

	self._objItemList = {}
	self._key2Index = {}
	self._index2Key = {}
end

function V3a4_Chg_GameView_ObjItemListImpl:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_objItemList")
end

function V3a4_Chg_GameView_ObjItemListImpl:setCol(newCol)
	self._gridLayoutComp.constraintCount = newCol
end

function V3a4_Chg_GameView_ObjItemListImpl:setSpacing(x, y)
	local spacing = self._gridLayoutComp.spacing

	spacing.x = x
	spacing.y = y
	self._gridLayoutComp.spacing = spacing
	self._spacing = spacing
end

function V3a4_Chg_GameView_ObjItemListImpl:getSpacing()
	self._spacing = self._spacing or self._gridLayoutComp.spacing

	return self._spacing
end

function V3a4_Chg_GameView_ObjItemListImpl:setPadding(l, r, t, b)
	local padding = self._gridLayoutComp.padding

	padding.left = l or padding.left
	padding.right = r or padding.right
	padding.top = t or padding.top
	padding.bottom = b or padding.bottom
	self._gridLayoutComp.padding = padding
	self._padding = padding
end

function V3a4_Chg_GameView_ObjItemListImpl:getPadding()
	self._padding = self._padding or self._gridLayoutComp.padding

	return self._padding
end

function V3a4_Chg_GameView_ObjItemListImpl:getContainerGo(index)
	local tr = self._containerList[index]

	return tr.gameObject
end

function V3a4_Chg_GameView_ObjItemListImpl:cellSize()
	self._cellSize = self._cellSize or self._gridLayoutComp.cellSize

	return self._cellSize
end

function V3a4_Chg_GameView_ObjItemListImpl:vertexRowCol()
	local c = self:baseViewContainer()

	return c:vertexRowCol()
end

function V3a4_Chg_GameView_ObjItemListImpl:count()
	local row, col = self:vertexRowCol()

	return row * col
end

function V3a4_Chg_GameView_ObjItemListImpl:getContainerGoByKey(key)
	return self:getContainerGo(self._key2Index[key])
end

function V3a4_Chg_GameView_ObjItemListImpl:getItemIndexByKey(key)
	if not key then
		return
	end

	return self._key2Index[key]
end

function V3a4_Chg_GameView_ObjItemListImpl:getObjByIndex(index)
	local c = self:baseViewContainer()
	local key = self._index2Key[index]

	return c:getObj(key) or self:newFallbackMapObj(key)
end

function V3a4_Chg_GameView_ObjItemListImpl:getItemByKey(key)
	local index = self:getItemIndexByKey(key)

	return self:getItemByIndex(index)
end

function V3a4_Chg_GameView_ObjItemListImpl:getItemByIndex(index)
	if not index then
		return
	end

	return self._objItemList[index]
end

function V3a4_Chg_GameView_ObjItemListImpl:g_getItemByKey(key)
	local p = self:parent()

	return p:getItemByKey(key)
end

function V3a4_Chg_GameView_ObjItemListImpl:_refresh()
	local count = self:count()

	for i = 1, count do
		local mapObj = self:getObjByIndex(i)
		local parentGO = self:getContainerGo(i)
		local item

		if i > #self._objItemList then
			item = self:_create_V3a4_Chg_GameItem(parentGO, i)

			table.insert(self._objItemList, item)
		else
			item = self._objItemList[i]
		end

		item:onUpdateMO(mapObj)
		item:setActive(true)
		item:playIdleAnim()
	end

	for i = count + 1, #self._objItemList do
		local item = self._objItemList[i]

		item:setActive(false)
	end
end

function V3a4_Chg_GameView_ObjItemListImpl:_create_V3a4_Chg_GameItem(parentGO, index)
	local c = self:baseViewContainer()
	local go = c:getResInst(ChgEnum.ResPath.v3a4_chg_gameitem, parentGO)
	local item = self:newObject(V3a4_Chg_GameItem)

	item:setIndex(index)
	item:init(go)

	return item
end

function V3a4_Chg_GameView_ObjItemListImpl:expectAreaListByKey(key)
	local index = self:getItemIndexByKey(key)

	return self:expectAreaListByIndex(index)
end

function V3a4_Chg_GameView_ObjItemListImpl:expectAreaListByIndex(index)
	local curItem = self._objItemList[index]

	if not curItem then
		return {}
	end

	return curItem:expectAreaList()
end

function V3a4_Chg_GameView_ObjItemListImpl:getNeighborItemListByKey(key)
	local index = self:getItemIndexByKey(key)

	return self:getNeighborItemListByIndex(index)
end

function V3a4_Chg_GameView_ObjItemListImpl:getNeighborItemListByIndex(index)
	local curItem = self._objItemList[index]

	if not curItem then
		return {}
	end

	return curItem:getNeighborItemList()
end

function V3a4_Chg_GameView_ObjItemListImpl:onMapSizeChange()
	assert(false, "please override this function")
end

function V3a4_Chg_GameView_ObjItemListImpl:newFallbackMapObj(key)
	local c = self:baseViewContainer()

	if not c then
		return
	end

	local PuzzleMazeObjInfo = {
		key = key
	}

	return ChgMapObjBase.s_ctor(c:mapMO(), PuzzleMazeObjInfo)
end

function V3a4_Chg_GameView_ObjItemListImpl:getLineItemAPosByKey(key)
	local index = self:getItemIndexByKey(key)

	return self:getLineItemAPosByIndex(index)
end

function V3a4_Chg_GameView_ObjItemListImpl:getLineItemAPosByIndex(index)
	local curItem = self._objItemList[index]

	if not curItem then
		return
	end

	local mapObj = curItem:mapObj()

	if mapObj:objIsPoint() then
		return self:_getLineItemAPosByIndexImpl(mapObj:x(), mapObj:y())
	else
		return self:_getLineItemAPosByIndexImpl(mapObj:center())
	end
end

function V3a4_Chg_GameView_ObjItemListImpl:_getLineItemAPosByIndexImpl(keyX, keyY)
	local cellSize = self:cellSize()
	local lineThickness = cellSize.x
	local halfLine = lineThickness * 0.5
	local spacing = self:getSpacing()
	local sx = spacing.x + lineThickness
	local sy = spacing.y + lineThickness
	local x, y, w, h = self:XYWH()
	local hw = w * 0.5
	local hh = h * 0.5
	local maxRow, _ = self:baseViewContainer():vertexRowCol()
	local ltx = (keyX - 1) * sx + halfLine
	local lty = -((maxRow - keyY) * sy + halfLine)
	local mmx = ltx - hw
	local mmy = hh + lty
	local ax = mmx + x
	local ay = mmy + y

	return ax, ay
end

return V3a4_Chg_GameView_ObjItemListImpl
