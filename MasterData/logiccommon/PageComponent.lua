-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/viewlib/page/PageComponent.lua

module("logiccommon.common.viewlib.page.PageComponent", package.seeall)

local PageComponent = class("PageComponent")

function PageComponent:ctor()
	self.cellList = {}
	self.cellPool = {}
	self.last3DragDelta = {
		0,
		0,
		0
	}
	self.centerThreshold = 150
	self.cellSizeX = 1280
	self.dragOffset = 300
	self.gap = 0
	self.moveRatio = 1
	self._curIndex = 0
end

function PageComponent:init(parent, cell, width, height, size, gap)
	if size then
		self.cellSizeX = size
	end

	if gap then
		self.gap = gap
	end

	self.tempCell = cell

	GameUtil.SetActive(self.tempCell, false)

	self._mask = goutil.create("page_mask")
	self._container = goutil.create("page_container")

	goutil.addChildToParent(self._mask, parent)
	goutil.addChildToParent(self._container, self._mask)
	goutil.addComponentOnce(self._mask, goutil.Type_UIImage)

	local maskC = goutil.addComponentOnce(self._mask, typeof(UnityEngine.UI.Mask))

	maskC.showMaskGraphic = false

	GameUtil.setWidth(self._mask, width)
	GameUtil.setHeight(self._mask, height)

	self._drag = Framework.UIDragTrigger.Get(self._mask)
	self._curIndex = 0

	Framework.TransformUtil.SetLocalPos(self._container.transform, 0, 0, 0)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
	self._drag:AddDragListener(self._onDrag, self)
end

function PageComponent:setMoveEndCallBack(cb)
	self.moveEndCallback = cb
end

function PageComponent:setUpdateCallBack(updateCallback)
	self.onUpdateCell = updateCallback
end

function PageComponent:setSaveCallBack(saveCallBack)
	self.onSaveCell = saveCallBack
end

function PageComponent:setData(datas)
	self.datas = datas
	self._len = #datas

	self:reloadData()
end

function PageComponent:getTotalSize()
	return self.cellSizeX + self.gap
end

function PageComponent:getCurIndex()
	return self._curIndex
end

function PageComponent:reloadData(force)
	local totalSize = self.cellSizeX + self.gap
	local x, y, z = Framework.TransformUtil.GetLocalPos(self._container.transform, 0, 0, 0)
	local tempS = math.floor(-x / totalSize)

	tempS = math.max(tempS, 0)
	tempS = math.min(tempS, self._len - 1)

	local tempE = math.floor((-x + self.cellSizeX) / totalSize)

	tempE = math.max(tempE, 0)
	tempE = math.min(tempE, self._len - 1)

	local fe = tempS * totalSize + self.cellSizeX
	local ee = tempE * totalSize
	local sx = tempS

	if -x > math.max(0, fe) then
		sx = tempS + 1
	end

	for i = 0, self._len - 1 do
		local idx = i + 1
		local temCell = self.cellList[idx]

		if i < sx or ((ee >= -x + self.cellSizeX or nil) and tempE - 1) < i then
			self:saveCell(temCell, idx, force)
		else
			self:createCell(temCell, idx, force)
		end
	end
end

function PageComponent:saveCell(cell, idx, force)
	if cell then
		self.cellList[idx] = nil

		table.insert(self.cellPool, cell)
		GameUtil.SetActive(cell, false)

		local data = self.datas[idx]

		GameUtil.callBack(self.onSaveCell, cell, data, idx)
	end
end

function PageComponent:createCell(cell, idx, force)
	local totalSize = self.cellSizeX + self.gap

	if cell == nil then
		force = true
		cell = #self.cellPool > 0 and table.remove(self.cellPool) or goutil.clone(self.tempCell, "cell")

		goutil.addChildToParent(cell, self._container)
	end

	if force then
		local data = self.datas[idx]

		self.cellList[idx] = cell

		GameUtil.callBack(self.onUpdateCell, cell, data, idx)
	end

	GameUtil.setAnchoredPos(cell, (idx - 1) * totalSize, 0)
	GameUtil.SetActive(cell, true)
end

function PageComponent:_springToTargetPos()
	self:moveToIdx(self._curIndex, true)
end

function PageComponent:moveToIdx(idx, isAni)
	self._curIndex = idx
	self._curIndex = math.max(self._curIndex, 0)
	self._curIndex = math.min(self._curIndex, self._len - 1)

	local ex = -self:getTotalSize() * self._curIndex

	if isAni then
		local pos = GameUtil.getAnchoredPos(self._container)

		self.tween = TweenUtil.ValueTo(pos.x, ex, 0.2, function(val)
			GameUtil.setAnchoredPos(self._container, val, 0)
			self:reloadData()
		end, function()
			self.tween = nil

			GameUtil.callBack(self.moveEndCallback)
		end, self, DG.Tweening.Ease.OutCubic)
	else
		GameUtil.setAnchoredPos(self._container, ex, 0)
		self:reloadData(true)
		GameUtil.callBack(self.moveEndCallback)
	end
end

function PageComponent:prePage()
	self._curIndex = self._curIndex - 1

	self:moveToIdx(self._curIndex, true)
end

function PageComponent:nextPage()
	self._curIndex = self._curIndex + 1

	self:moveToIdx(self._curIndex, true)
end

function PageComponent:_onBeginDrag(eventData)
	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	if self._len < 1 then
		return
	end

	self.rcdPos = eventData.position

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._container.transform, 0, 0, 0)

	self._curLocalPosX = x
	self._curDelta = 0
	self.last3DragDelta = {
		0,
		0,
		0
	}
end

function PageComponent:_onEndDrag(eventData)
	if self._len < 1 then
		return
	end

	local delta = self.localCursor.x - self.rcdPos.x

	if delta > self.centerThreshold then
		self._curIndex = self._curIndex - 1
	elseif delta < -self.centerThreshold then
		self._curIndex = self._curIndex + 1
	end

	self:_springToTargetPos()
end

function PageComponent:_onDrag(eventData)
	if self._len < 1 then
		return
	end

	self.localCursor = eventData.position
	self.last3DragDelta[3] = self.last3DragDelta[2]
	self.last3DragDelta[2] = self.last3DragDelta[1]
	self.last3DragDelta[1] = eventData.delta.x
	self._curDelta = self._curDelta + eventData.delta.x * self.moveRatio

	local targetPos = self._curLocalPosX + self._curDelta

	targetPos = math.min(targetPos, self.dragOffset)
	targetPos = math.max(targetPos, -(self._len - 1) * self:getTotalSize() - self.dragOffset)

	Framework.TransformUtil.SetLocalPos(self._container.transform, targetPos, 0, 0)
	self:reloadData()
end

function PageComponent:dispose()
	for k, cell in pairs(self.cellList) do
		goutil.destroy(cell)
	end

	for k, cell in pairs(self.cellPool) do
		goutil.destroy(cell)
	end

	self.cellList = nil
	self.cellPool = nil

	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
	self._drag:RemoveDragListener()
end

return PageComponent
