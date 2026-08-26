-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameView_Line_item.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameView_Line_item", package.seeall)

local V3a4_Chg_GameView_Line_item = class("V3a4_Chg_GameView_Line_item", RougeSimpleItemBase)

function V3a4_Chg_GameView_Line_item:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4_Chg_GameView_Line_item:addEvents()
	return
end

function V3a4_Chg_GameView_Line_item:removeEvents()
	return
end

local function _approximately(f0, f1)
	return math.abs(f0 - f1) < 1e-06
end

function V3a4_Chg_GameView_Line_item:_getLineItemAPosByKey(key)
	return self:baseViewContainer():getLineItemAPosByKey(key)
end

function V3a4_Chg_GameView_Line_item:snapByKey(key)
	local ax, ay = self:_getLineItemAPosByKey(key)

	self:setAPos(ax, ay)
end

function V3a4_Chg_GameView_Line_item:ctor(ctorParam)
	self:__onInit()
	V3a4_Chg_GameView_Line_item.super.ctor(self, ctorParam)

	self._impl = false
	self._h = self:newObject(V3a4_Chg_GameView_Line_item_Impl)
	self._v = self:newObject(V3a4_Chg_GameView_Line_item_Impl)
	self._startItem = false
	self._endItem = false
	self._startEnergy = 0
end

function V3a4_Chg_GameView_Line_item:startItem()
	return self._startItem
end

function V3a4_Chg_GameView_Line_item:startEnergy()
	return self._startEnergy or 0
end

function V3a4_Chg_GameView_Line_item:endItem()
	return self._endItem
end

function V3a4_Chg_GameView_Line_item:_editableInitView()
	V3a4_Chg_GameView_Line_item.super._editableInitView(self)
	self._h:init(gohelper.findChild(self.viewGO, "Line_Horizontal"))
	self._v:init(gohelper.findChild(self.viewGO, "Line_Vertical"))

	self._lightGo = gohelper.findChild(self.viewGO, "Light")

	self:clear()
end

function V3a4_Chg_GameView_Line_item:onDestroyView()
	GameUtil.onDestroyViewMember(self, "_h")
	GameUtil.onDestroyViewMember(self, "_v")
	V3a4_Chg_GameView_Line_item.super.onDestroyView(self)
	self:__onDispose()
end

function V3a4_Chg_GameView_Line_item:clear()
	self:_clearRefLine()

	self._impl = false
	self._startItem = false
	self._endItem = false

	self:setActive(false)
end

function V3a4_Chg_GameView_Line_item:_clearRefLine()
	if not self._refLineItem then
		return
	end

	if not self._impl then
		return
	end

	self._impl:setActiveTopLight(false)
	self._impl:setWidth(0)

	self._refLineItem = false
end

function V3a4_Chg_GameView_Line_item:bindStart(newStartItem, optDir, optEnergy, optRefLineItem)
	self:clear()

	self._startItem = newStartItem
	self._startEnergy = optEnergy

	self:reset(optDir, optRefLineItem)
	self:_snapBegin()
end

function V3a4_Chg_GameView_Line_item:bindEnd(newEndItem)
	if not newEndItem then
		return
	end

	if not self._impl then
		return
	end

	if not self._startItem then
		return
	end

	self._endItem = newEndItem

	self:_snapEnd()

	if self._endItem == self._startItem then
		self:setActive_lightGo(false)
	end

	self:setActiveTopLight(false)
end

function V3a4_Chg_GameView_Line_item:setActiveTopLight(...)
	if self._impl then
		self._impl:setActiveTopLight(...)
	end
end

function V3a4_Chg_GameView_Line_item:setActive_finish(...)
	if self._impl then
		self._impl:setActive_finish(...)
	end
end

function V3a4_Chg_GameView_Line_item:reset(eDir, refLineItem)
	eDir = eDir or ChgEnum.Dir.None

	if ChgEnum.rDir then
		local using = self:parent()._using

		self:setName(ChgEnum.rDir[eDir] .. " " .. tostring(using))
	end

	self:_clearRefLine()

	self._impl = false

	self._h:setActive(false)
	self._v:setActive(false)
	self:setActive_lightGo(false)
	self:setActiveTopLight(false)

	if eDir == ChgEnum.Dir.None then
		return
	end

	local isH = eDir == ChgEnum.Dir.Right or ChgEnum.Dir.Left == eDir

	self._refLineItem = refLineItem

	self:setActive_lightGo(not refLineItem and true or false)

	if isH then
		self._impl = self._h or self._v
	end

	self._impl:reset(eDir)
	self:setActive(true)
end

function V3a4_Chg_GameView_Line_item:getDir()
	if not self._impl then
		return ChgEnum.Dir.None
	end

	return self._impl:getDir()
end

function V3a4_Chg_GameView_Line_item:getDirStr()
	if ChgEnum.rDir then
		return ChgEnum.rDir[self:getDir()]
	end

	return ""
end

function V3a4_Chg_GameView_Line_item:isParallel(eDir)
	if not self._impl then
		return false
	end

	local curDir = self:getDir()

	if ChgEnum.isParallelDir(curDir, eDir) then
		return true
	end

	return false
end

function V3a4_Chg_GameView_Line_item:isVertical()
	local curDir = self:getDir()

	return curDir == ChgEnum.Dir.Down or curDir == ChgEnum.Dir.Up
end

function V3a4_Chg_GameView_Line_item:isHorizontal()
	local curDir = self:getDir()

	return curDir == ChgEnum.Dir.Right or curDir == ChgEnum.Dir.Left
end

function V3a4_Chg_GameView_Line_item:setWidth(newWidth)
	if not self._impl then
		return
	end

	if not self._startItem then
		return
	end

	newWidth = self._startItem:clampMovableDistance(self:getDir(), newWidth)

	self._impl:setWidth(newWidth)
end

function V3a4_Chg_GameView_Line_item:setDummyWidth(newWidth)
	if not self._impl then
		return
	end

	if not self._startItem then
		return
	end

	self._impl:setActiveTopLight(false)
	self._impl:setDummyWidth(newWidth)
end

function V3a4_Chg_GameView_Line_item:getWidth()
	if not self._impl then
		return 0
	end

	return self._impl:getWidth()
end

function V3a4_Chg_GameView_Line_item:_snapBegin()
	if not self._startItem then
		return
	end

	if not self._refLineItem then
		self:snapByKey(self._startItem:key())
	end
end

function V3a4_Chg_GameView_Line_item:calcDistFromStart(item)
	if not self._startItem then
		return 0
	end

	if not item or item == self._startItem then
		return 0
	end

	local curDir = self:getDir()

	if self._startItem:relativeDir(item) ~= curDir then
		return 0
	end

	local deltaV2 = self._startItem:calcDeltaV2(item)

	return (ChgEnum.deltaV2ToDeltaDistance(curDir, deltaV2))
end

function V3a4_Chg_GameView_Line_item:_snapEnd()
	if not self._startItem then
		return
	end

	if not self._endItem then
		return
	end

	self:_snapEndImpl(self._endItem)
end

function V3a4_Chg_GameView_Line_item:_snapEndImpl(item)
	local deltaDistance = self:calcDistFromStart(item)

	self:setWidth(deltaDistance)
end

function V3a4_Chg_GameView_Line_item:setWidthByV2(v2)
	if not v2 then
		return
	end

	local deltaDistance = ChgEnum.deltaV2ToDeltaDistance(self:getDir(), v2)

	self:setWidth(deltaDistance)
end

function V3a4_Chg_GameView_Line_item:debugStr()
	if not self._impl then
		return ""
	end

	if ChgEnum.rDir then
		local hover = self:hoverItem()

		return (string.format("%s dir:%s, %s, w:%s, (%s,%s)", self._refLineItem and "Dummy" or "", ChgEnum.rDir[self:getDir()], hover and hover:key() or "None", math.modf(self:getWidth()), math.modf(self:posX()), (math.modf(self:posY()))))
	end

	return ""
end

function V3a4_Chg_GameView_Line_item:isZero()
	return self:getDir() == ChgEnum.Dir.None or _approximately(self:getWidth(), 0)
end

function V3a4_Chg_GameView_Line_item:hoverItem()
	if not self:startItem() or self:isZero() then
		return
	end

	return self:startItem():getItemByVector(self:getDir(), self:getWidth())
end

function V3a4_Chg_GameView_Line_item:getValidItemInfoList(bUseWholeLine, optWidth)
	if not self:startItem() or self:isZero() then
		return {}
	end

	optWidth = optWidth or self:getWidth()

	if bUseWholeLine and self._refLineItem then
		optWidth = optWidth + self._refLineItem:getWidth()

		return self._refLineItem:getValidItemInfoList(bUseWholeLine, optWidth)
	end

	return self:startItem():getItemInfoListByVector(self:getDir(), optWidth)
end

function V3a4_Chg_GameView_Line_item:setActive_lightGo(isActive)
	gohelper.setActive(self._lightGo, isActive)
end

function V3a4_Chg_GameView_Line_item:calcValidSubLineInfo()
	local infoList = self:getValidItemInfoList()
	local indexByInfoList = -1

	for i = #infoList, 1, -1 do
		local info = infoList[i]
		local mapObj = info.item:mapObj()

		if mapObj:isSavable() then
			indexByInfoList = i

			break
		end
	end

	return infoList, indexByInfoList
end

return V3a4_Chg_GameView_Line_item
