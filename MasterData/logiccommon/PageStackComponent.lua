-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/page/PageStackComponent.lua

module("logiccommon.common.viewlib.page.PageStackComponent", package.seeall)

local PageStackComponent = class("PageStackComponent")
local itemPrefab

local function createFloatItem()
	local go = goutil.clone(itemPrefab)

	GameUtil.SetActive(go, true)

	return go
end

local function destroyFloatItem(obj)
	goutil.destroy(obj.gameObject)
end

local function resetFloatItem(obj)
	obj.gameObject:SetActive(false)
end

function PageStackComponent:ctor()
	return
end

function PageStackComponent:init(parentGo, cellGo, width, cellWidth, count)
	self.parentGo = parentGo
	self.cellGo = cellGo
	self.totalWidth = width
	self.cellWidth = cellWidth

	self:setLimitCount(count)

	self.offsetX = 0

	GameUtil.SetActive(self.cellGo, false)

	itemPrefab = cellGo
	self.objPool = ObjectPool.New(10, createFloatItem, destroyFloatItem, resetFloatItem)
	self.itemPool = {}
	self.tweenPool = {}
	self.currIdx = 1
	self.targetIdx = self.currIdx
end

function PageStackComponent:setCallBack(updatecell, moveEnd, clearCell)
	self.updatecellCallBack = updatecell
	self.moveEndCallBack = moveEnd
	self.clearCellCallBack = clearCell
end

function PageStackComponent:setLimitCount(count)
	if checknumber(count) <= 0 then
		count = 1
	end

	self.cellCount = count
	self.gap = self.totalWidth / (count + 2)
end

function PageStackComponent:setOffectX(ofx)
	self.offsetX = ofx
end

function PageStackComponent:clearUI()
	self:clearAllTween()

	for k, cell in pairs(self.itemPool) do
		GameUtil.handler(self.clearCellCallBack, cell)
	end
end

function PageStackComponent:reloadData(arr, idx)
	self.datas = arr
	self.currIdx = idx == nil and 1 or idx

	self:gotoIndex(self.currIdx, true)
end

function PageStackComponent:gotoIndex(idx, force, isCallBackEnd)
	if self.datas and #self.datas > 0 then
		local len = #self.datas

		idx = checknumber(idx)
		idx = 1 + (idx - 1) % len

		if force then
			self:clearAllTween()

			self.currCellIdList = nil
			self.targetIdx = idx
		end

		self.currIdx = idx

		local arr = {}

		table.insert(arr, idx)

		local hc = math.floor(self.cellCount * 0.5)

		for i = 1, hc do
			local idr = (idx + i - 1) % len + 1
			local idl = (idx - i - 1) % len + 1

			table.insert(arr, idr)

			if idr ~= idl then
				table.insert(arr, idl)
			end
		end

		self:updateCurrStack(arr, isCallBackEnd)
	end
end

function PageStackComponent:clearAllTween()
	for k, v in pairs(self.tweenPool) do
		if v then
			v:Kill(false)
		end
	end

	self.tweenPool = {}
end

function PageStackComponent:moveToIdx(idx)
	self.targetIdx = idx

	self:checkMoveToIdx()
end

function PageStackComponent:checkMoveToIdx()
	local tweenNum = 0

	for k, v in pairs(self.tweenPool) do
		tweenNum = tweenNum + 1

		break
	end

	if tweenNum == 0 then
		if self.targetIdx == self.currIdx then
			for id, cell in pairs(self.itemPool) do
				local data = self.datas[id]

				if data then
					GameUtil.callBack(self.updatecellCallBack, self, cell, data, id, true)
				end
			end

			GameUtil.callBack(self.moveEndCallBack, self)
		else
			local len = #self.datas
			local base = self.targetIdx - self.currIdx
			local absBase = math.abs(base)
			local com = -base / absBase * (len - absBase)

			if absBase > math.abs(com) then
				if com > 0 then
					self:gotoIndex(self.currIdx + 1)
				else
					self:gotoIndex(self.currIdx - 1)
				end
			elseif base > 0 then
				self:gotoIndex(self.currIdx + 1)
			else
				self:gotoIndex(self.currIdx - 1)
			end
		end
	end
end

function PageStackComponent:updateCurrStack(arr, isCallBackEnd)
	local delCount = 0

	if self.currCellIdList == nil then
		self.currCellIdList = arr

		for k, cell in pairs(self.itemPool) do
			GameUtil.SetActive(cell, false)
		end

		for i, v in ipairs(arr) do
			self:createCell(v, i, true)
		end

		if isCallBackEnd == nil or isCallBackEnd == true then
			GameUtil.callBack(self.moveEndCallBack, self)
		end
	else
		local temPool = {}

		for i, v in ipairs(self.currCellIdList) do
			temPool[v] = i
		end

		for i, v in ipairs(arr) do
			local idx = temPool[v]

			if idx == nil then
				self:createCell(v, i, false)
			elseif idx > 0 then
				temPool[v] = nil

				if idx ~= i then
					self:moveCell(v, idx, i)
				end
			end
		end

		for k, v in pairs(temPool) do
			self:removeCell(k, delCount)

			delCount = delCount + 1
		end

		self.currCellIdList = arr
	end

	self:changeSiblingIndex(delCount)
end

function PageStackComponent:changeSiblingIndex(delCount)
	local len = #self.currCellIdList

	for i, v in ipairs(self.currCellIdList) do
		local cell = self.itemPool[v]

		cell.transform:SetSiblingIndex(delCount + len - i)
	end
end

function PageStackComponent:removeCell(id, idx)
	local cell = self.itemPool[id]

	if cell then
		cell.transform:SetSiblingIndex(idx)
	end

	self.itemPool[id] = nil

	local tween = self.tweenPool[id]

	if tween then
		tween:Kill(false)
	end

	tween = TweenUtil.ValueTo(0, 1, 0.2, function(val)
		return
	end, function()
		self.tweenPool[id] = nil

		if cell then
			self.objPool:returnObject(cell)
		end

		self:checkMoveToIdx()
	end, self)
	self.tweenPool[id] = tween
end

function PageStackComponent:moveCell(id, fromIdx, toIdx)
	local tween = self.tweenPool[id]

	if tween then
		tween:Kill(false)
	end

	local cell = self.itemPool[id]
	local posx, px = self:getPosX(toIdx)
	local curX = GameUtil.getAnchoredPos(cell).x
	local curScale = GameUtil.getLocalScale(cell).x
	local gapX = posx - curX
	local gapScale = ((px > 0 or nil) and 0.9) - curScale

	tween = TweenUtil.ValueTo(0, 1, 0.2, function(val)
		GameUtil.setLocalScale(cell, curScale + val * gapScale)
		GameUtil.setAnchoredPos(cell, curX + val * gapX, 0)
	end, function()
		self.tweenPool[id] = nil

		self:checkMoveToIdx()
	end, self)
	self.tweenPool[id] = tween
end

function PageStackComponent:createCell(id, idx, isEnd)
	local tween = self.tweenPool[id]

	if tween then
		tween:Kill(false)
	end

	self.tweenPool[id] = nil

	local cell = self.itemPool[id]

	if cell == nil then
		cell = self.objPool:fetchObject()
	end

	self.itemPool[id] = cell

	GameUtil.SetActive(cell, true)

	if cell.transform.parent ~= self.parentGo.transform then
		goutil.addChildToParent(cell, self.parentGo)
	end

	local posx, px = self:getPosX(idx)

	if px == 0 then
		GameUtil.setLocalScale(cell, 1 - px * 0.1)
	else
		GameUtil.setLocalScale(cell, 0.9)
	end

	GameUtil.setAnchoredPos(cell, posx, 0)

	local data = self.datas[id]

	GameUtil.callBack(self.updatecellCallBack, self, cell, data, id, isEnd)
end

function PageStackComponent:getPosX(idx)
	local ii = idx - 1
	local ofx = ii % 2
	local px = math.ceil(ii * 0.5)

	if px > 0 then
		px = px + 1
	end

	return ofx == 1 and self.offsetX + px * self.gap or self.offsetX - px * self.gap, px
end

return PageStackComponent
