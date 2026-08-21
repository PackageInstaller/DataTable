---@class VerticalScroll
local VerticalScroll = {}
local this = VerticalScroll

local defaultPos = Vector3.New(-9999, -9999, -9999)

ItemData = DataClass("VerticalData", {
	go = nil,
	data = nil,
	index = 1,
	pos = Vector2.New(0, 0),
	row = 0,
	__init = function(self, go, data, index, pos, row)
		self.go = go
		self.data = data
		self.index = index
		self.pos = pos
		self.row = row
		local rectTnf = go:GetComponent("RectTransform")
		rectTnf.anchorMin = Vector2.New(0, 1);
		rectTnf.anchorMax = Vector2.New(0, 1);
		go.transform.localPosition = pos
	end
})

-- vertical布局：列数取有效最小值
function this.GetLimitCol(self)
	if self.limitCol ~= 0 then
		return self.limitCol
	end
	self.limitCol = math.floor((self.maxWidth - self.paddingLeft - self.paddingRight) / self.itemWidth)
	if self.limitCol <= 1 then
		self.limitCol = 1
		return
	end
	for i = self.limitCol, 1, -1 do
		if self.itemWidth * i + (i - 1) * self.spacingWidth <= self.maxWidth - self.paddingLeft - self.paddingRight then
			self.limitCol = i
			return
		end
	end
	self.limitCol = 1
end

-- vertical布局：行数取有效最大值
function this.GetLimitRow(self)
	if self.limitRow ~= 0 then
		return self.limitRow
	end
	self.limitRow = math.ceil((self.viewPort.rect.height - self.paddingTop - self.paddingBottom) / self.itemHeight)
	if self.limitRow <= 1 then
		self.limitRow = 1
		return
	end
	for i = 1, self.limitRow + 1 do
		if self.itemHeight * i + (i + 1) * self.spacingHeight > self.viewPort.rect.height - self.paddingTop - self.paddingBottom then
			self.limitRow = i + 1
			return
		end
	end
	self.limitRow = 1
end

-- vertical布局：获取item的位置
function this.GetPos(self, index)
	local row = math.ceil(index / self.limitCol)
	local col = index - (row - 1) * self.limitCol
	local x = self.paddingLeft + self.itemWidth / 2 + (col - 1) * (self.itemWidth + self.spacingWidth)
	local y = -(self.paddingTop + self.itemHeight / 2 + (row - 1) * (self.itemHeight + self.spacingHeight))
	return Vector2.New(x, y + self.deltaY)
end

function this.SetDeltaY(self, y)
	self.deltaY = y
end

-- 一滑动就会进来，这里判断多长时间没进来
local function ScrollViewChange(self)
	self.time = Time.time
	self.viewChangeMode = 1
end

-- Public API 1:
-- arg1：数组 
-- arg2：scrollview的gameobject 
-- arg3：item的名字 
-- arg4：实例化回调，回调参数ItemData类
function this.ScrollInit(self, list, scrollView, itemName, callback, moveToBottonCallback, moveToTopCallback)
	-- 初始化数组
	self.array = table.sortbykey(list)
	self.itemList = {}
	self.isInit = false
	self.callback = callback
	self.callbackList = {}
	self.moveToBottonCallback = moveToBottonCallback
	self.moveToTopCallback = moveToTopCallback

	self.delay = 0.3
	self.time = 0
	self.viewChangeMode = 0
	self.lastChange = 1
	self.deltaY = 0
	
	-- Layout组件和ContentSizeFitter组件禁用
	self.scrollRect = scrollView.transform:GetComponent("ScrollRect")
	if not IsNull(self.scrollRect.verticalScrollbar) then
		self.scrollRect.verticalScrollbar.interactable = false
		self.barImg = self.scrollRect.verticalScrollbar.transform:GetComponent("Image")
		self.handleImg = self.scrollRect.verticalScrollbar.transform:Find("Sliding Area/Handle"):GetComponent("Image")
		self.barImg:DOFade(0,0)
		self.handleImg:DOFade(0,0)
	end
	if not IsNull(self.scrollRect.horizontalScrollbar) then
		self.scrollRect.horizontalScrollbar.interactable = false
	end
	self.scrollRect.movementType = 2
	self.content = self.scrollRect.content
	self.viewPort = self.scrollRect.viewport
	self.viewPort.pivot = Vector2.New(0, 1)
	if self.scrollRect.horizontalScrollbar ~= nil then
		self.scrollRect.horizontalScrollbar.value = 1
	end
	if self.scrollRect.verticalScrollbar ~= nil then
		self.scrollRect.verticalScrollbar.value = 1
	end
	self.content:DOMoveY(0, 0)
	self.lastPos = self.content.localPosition

	-- 监听事件
	self.scrollRect.onValueChanged:AddListener(function () self:OnValueChanged() end)
	self.scrollChangeFunc = Bind(self, ScrollViewChange)
	self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)
	
	-- 实例化
	local instantiate = function(parent, name)
		local object = GameObjectPool:GetInstance():CoGetGameObjectAsync(HomeSceneItemPath.."/"..name..".prefab");
		object.transform:SetParent(parent.transform)
		object.transform.localScale = Vector3.one
		object.transform.localPosition = Vector3.zero
		object:SetActive(false)
		return object
	end
	
	coroutine.start(function ()
		local obj = instantiate(self.content, itemName)
		coroutine.waitforframes(1)
		-- 等待1帧获取item的宽高
		local itemRect = obj:GetComponent("RectTransform").rect
		self.itemWidth = itemRect.width
		self.itemHeight = itemRect.height

		local contentSizeFitter = self.content.transform:GetComponent("ContentSizeFitter")
		if contentSizeFitter ~= nil then
			contentSizeFitter.enabled = false
		end
		local gridLayout = self.content.transform:GetComponent("GridLayoutGroup")
		if gridLayout ~= nil then
			gridLayout.enabled = false
		end
		local verticalLayout = self.content.transform:GetComponent("VerticalLayoutGroup")
		if verticalLayout ~= nil then
			verticalLayout.enabled = false
		end
		local horizontalLayout = self.content.transform:GetComponent("HorizontalLayoutGroup")
		if horizontalLayout ~= nil then
			horizontalLayout.enabled = false
		end

		self.maxWidth = math.min(self.viewPort.rect.width, self.content.rect.width)
		self.paddingLeft = 0
		self.paddingRight = 0
		self.paddingTop = 0
		self.paddingBottom = 0
		self.spacingWidth = 0
		self.spacingHeight = 0
		self.limitRow = 0
		self.limitCol = 0

		-- ***目前只考虑Vertical排列方式***
		-- 如果有grid布局组件，则以改组件的数据为准
		if gridLayout ~= nil then
			self.paddingLeft = gridLayout.padding.left
			self.paddingRight = gridLayout.padding.right
			self.paddingTop = gridLayout.padding.top
			self.paddingBottom = gridLayout.padding.bottom
			self.spacingWidth = gridLayout.spacing.x
			self.spacingHeight = gridLayout.spacing.y
			self.itemWidth = gridLayout.cellSize.x
			self.itemHeight = gridLayout.cellSize.y
			if gridLayout.constraint == CS.UnityEngine.UI.GridLayoutGroup.Constraint.FixedColumnCount then -- 固定列的个数
				self.limitCol = gridLayout.constraintCount
			end
		elseif verticalLayout ~= nil then
			self.paddingLeft = verticalLayout.padding.left
			self.paddingRight = verticalLayout.padding.right
			self.paddingTop = verticalLayout.padding.top
			self.paddingBottom = verticalLayout.padding.bottom
			self.spacingWidth = 0
			self.spacingHeight = verticalLayout.spacing
		end

		-- vertical布局：行数多加一行，用于轮替
		self:GetLimitCol()
		self:GetLimitRow()
		self.limitRow = self.limitRow + 1

		-- vertical布局：计算content的真实高度
		self.totalRow = math.ceil(#self.array / self.limitCol)
		self.content.sizeDelta = Vector2.New(self.content.sizeDelta.x, (self.itemHeight * self.totalRow + (self.totalRow - 1) * self.spacingHeight + self.paddingTop + self.paddingBottom))
		if self.recordPos ~= nil then
			self.content:DOLocalMove(self.recordPos, 0)
		end
		
		-- 创建显示的item数组
		obj:SetActive(false)
		local index = 0
		for r = 1, self.limitRow do
			local rowList = {}
			for l = 1, self.limitCol do
				index = index + 1
				local ins = instantiate(self.content, itemName)
				rowList[l] = ItemData.New(ins, self.array[index], index, self:GetPos(index), r)
				ins.gameObject:SetActive(true)
				if index <= #self.array then
					table.insert(self.callbackList, rowList[l])
				end
				rowList[l].pos = self:GetPos(rowList[l].index)
				rowList[l].go.transform.localPosition = defaultPos
			end
			self.itemList[r] = rowList
		end
		self.isInit = true
		if not self.__update_handle then
			self.__update_handle = BindCallback(self, self.Update)
			UpdateManager:GetInstance():AddUpdate(self.__update_handle)
		end
	end)
end

function this.CoScrollInit(self, list, scrollView, itemName, callback)
	-- 初始化数组
	self.array = table.sortbykey(list)
	self.itemList = {}
	self.isInit = false
	self.callback = callback
	self.callbackList = {}

	self.delay = 0.3
	self.time = 0
	self.viewChangeMode = 0
	self.lastChange = 1
	self.deltaY = 0
	
	-- Layout组件和ContentSizeFitter组件禁用
	self.scrollRect = scrollView.transform:GetComponent("ScrollRect")
	if not IsNull(self.scrollRect.verticalScrollbar) then
		self.scrollRect.verticalScrollbar.interactable = false
		self.barImg = self.scrollRect.verticalScrollbar.transform:GetComponent("Image")
		self.handleImg = self.scrollRect.verticalScrollbar.transform:Find("Sliding Area/Handle"):GetComponent("Image")
		self.barImg:DOFade(0,0)
		self.handleImg:DOFade(0,0)
	end
	if not IsNull(self.scrollRect.horizontalScrollbar) then
		self.scrollRect.horizontalScrollbar.interactable = false
	end
	
	self.scrollRect.movementType = 2
	self.content = self.scrollRect.content
	self.viewPort = self.scrollRect.viewport
	self.viewPort.pivot = Vector2.New(0, 1)
	if self.scrollRect.horizontalScrollbar ~= nil then
		self.scrollRect.horizontalScrollbar.value = 1
	end
	if self.scrollRect.verticalScrollbar ~= nil then
		self.scrollRect.verticalScrollbar.value = 1
	end
	self.content:DOMoveY(0, 0)
	self.lastPos = self.content.localPosition

	-- 监听事件
	self.scrollRect.onValueChanged:AddListener(function () self:OnValueChanged() end)
	self.scrollChangeFunc = Bind(self, ScrollViewChange)
	self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)

	-- 实例化
	local instantiate = function(parent, name)
		local object = GameObjectPool:GetInstance():CoGetGameObjectAsync(HomeSceneItemPath.."/"..name..".prefab");
		object.transform:SetParent(parent.transform)
		object.transform.localScale = Vector3.one
		object.transform.localPosition = Vector3.zero
		object:SetActive(false)
		return object
	end

	local obj = instantiate(self.content, itemName)
	coroutine.waitforframes(1)
	-- 等待1帧获取item的宽高
	local itemRect = obj:GetComponent("RectTransform").rect
	self.itemWidth = itemRect.width
	self.itemHeight = itemRect.height

	local contentSizeFitter = self.content.transform:GetComponent("ContentSizeFitter")
	if contentSizeFitter ~= nil then
		contentSizeFitter.enabled = false
	end
	local gridLayout = self.content.transform:GetComponent("GridLayoutGroup")
	if gridLayout ~= nil then
		gridLayout.enabled = false
	end
	local verticalLayout = self.content.transform:GetComponent("VerticalLayoutGroup")
	if verticalLayout ~= nil then
		verticalLayout.enabled = false
	end
	local horizontalLayout = self.content.transform:GetComponent("HorizontalLayoutGroup")
	if horizontalLayout ~= nil then
		horizontalLayout.enabled = false
	end

	self.maxWidth = math.min(self.viewPort.rect.width, self.content.rect.width)
	self.paddingLeft = 0
	self.paddingRight = 0
	self.paddingTop = 0
	self.paddingBottom = 0
	self.spacingWidth = 0
	self.spacingHeight = 0
	self.limitRow = 0
	self.limitCol = 0

	-- ***目前只考虑Vertical排列方式***
	-- 如果有grid布局组件，则以改组件的数据为准
	if gridLayout ~= nil then
		self.paddingLeft = gridLayout.padding.left
		self.paddingRight = gridLayout.padding.right
		self.paddingTop = gridLayout.padding.top
		self.paddingBottom = gridLayout.padding.bottom
		self.spacingWidth = gridLayout.spacing.x
		self.spacingHeight = gridLayout.spacing.y
		self.itemWidth = gridLayout.cellSize.x
		self.itemHeight = gridLayout.cellSize.y
		if gridLayout.constraint == CS.UnityEngine.UI.GridLayoutGroup.Constraint.FixedColumnCount then -- 固定列的个数
			self.limitCol = gridLayout.constraintCount
		end
	elseif verticalLayout ~= nil then
		self.paddingLeft = verticalLayout.padding.left
		self.paddingRight = verticalLayout.padding.right
		self.paddingTop = verticalLayout.padding.top
		self.paddingBottom = verticalLayout.padding.bottom
		self.spacingWidth = 0
		self.spacingHeight = verticalLayout.spacing
	end

	-- vertical布局：行数多加一行，用于轮替
	self:GetLimitCol()
	self:GetLimitRow()
	self.limitRow = self.limitRow + 1

	-- vertical布局：计算content的真实高度
	self.totalRow = math.ceil(#self.array / self.limitCol)
	self.content.sizeDelta = Vector2.New(self.content.sizeDelta.x, (self.itemHeight * self.totalRow + (self.totalRow - 1) * self.spacingHeight + self.paddingTop + self.paddingBottom))
	if self.recordPos ~= nil then
		self.content:DOLocalMove(self.recordPos, 0)
	end
	
	-- 创建显示的item数组
	obj:SetActive(false)
	local index = 0
	for r = 1, self.limitRow do
		local rowList = {}
		for l = 1, self.limitCol do
			index = index + 1
			local ins = instantiate(self.content, itemName)
			rowList[l] = ItemData.New(ins, self.array[index], index, self:GetPos(index), r)
			ins.gameObject:SetActive(true)
			rowList[l].pos = self:GetPos(rowList[l].index)
			if index <= #self.array then
				if self.callback ~= nil then
					rowList[l].upDating = true
					rowList[l].go:SetActive(true)
					self.callback(rowList[l]) -- 如果回调资源加载是协程，则会出现图片不能及时更新。如果回调资源加载是阻塞同步，则这一批资源会阻塞显示的比较慢
					rowList[l].go.transform.localPosition = rowList[l].pos
					rowList[l].upDating = false
				end
			else
				--ins.gameObject:SetActive(false)
				rowList[l].go.transform.localPosition = defaultPos
			end
		end
		self.itemList[r] = rowList
	end
	self.isInit = true
	if not self.__update_handle then
		self.__update_handle = BindCallback(self, self.Update)
		UpdateManager:GetInstance():AddUpdate(self.__update_handle)
	end
	return coroutine.yieldbreak()
end

function this.RecordPosition(self)
	self.recordPos = self.content.localPosition
end

function this.ClearRecord(self)
	self.recordPos = nil
end

-- Public API 2:
-- 设置每帧更新个数
function this.SetUpdateCount(self, count)
	self.count = count or 1
end

function this.GetUpdateCount(self)
	return self.count or 1
end

-- 更新资源
function this.Update(self)
	if self.scrollRect.verticalScrollbar ~= nil then
		if Time.time - self.time >= self.delay and self.viewChangeMode == 1 then
			self.viewChangeMode = 0
		end
		if self.lastChange ~= self.viewChangeMode then
			self.lastChange = self.viewChangeMode
			if self.viewChangeMode == 0 then
				self.barImg:DOKill()
				self.handleImg:DOKill()
				self.barImg:DOFade(0,0.3)
				self.handleImg:DOFade(0,0.3)
			else
				self.barImg:DOKill()
				self.handleImg:DOKill()
				self.barImg:DOFade(1,0.3)
				self.handleImg:DOFade(1,0.3)
			end
		end
	end
	if table.count(self.callbackList) <= 0 then
		return
	end
	for i = 1, self:GetUpdateCount() do
		if table.count(self.callbackList) <= 0 then
			break
		end
		local itemData = table.remove(self.callbackList, 1)
		coroutine.start(function ()
			coroutine.waituntil(function () return not itemData.upDating end)
			if self.callback ~= nil then
				itemData.upDating = true
				itemData.go:SetActive(true)
				itemData.go.transform.localPosition = itemData.pos
				self.callback(itemData) -- 如果回调资源加载是协程，则会出现图片不能及时更新。如果回调资源加载是阻塞同步，则这一批资源会阻塞显示的比较慢
				itemData.upDating = false
			end
		end)
	end
end

-- 移动几行
function this.MoveAll(self, count)
	self:All(function (v)
		self:Move(v, count)
	end)
end

function this.Move(self, v, count)
	v.row = v.row + count
	v.index = v.index + count * self.limitCol
	if v.index <= #self.array then
		if v.index == #self.array then
			if self.moveToBottonCallback ~= nil then
				self.moveToBottonCallback(self.array[v.index], v.index)
			end
		end
		if v.index == 1 then
			if self.moveToTopCallback ~= nil then
				self.moveToTopCallback(self.array[v.index], v.index)
			end
		end
		v.pos = self:GetPos(v.index)
		--v.go.transform.localPosition = v.pos
		v.data = self.array[v.index]
		v.go:SetActive(true)
		if not table.any(self.callbackList, function (val) return val == v end) then
			if count ~= 0 then
				v.go.transform.localPosition = defaultPos
			end
			table.insert(self.callbackList, v)
		end
	else
		--v.go:SetActive(false)
		v.go.transform.localPosition = defaultPos
	end
end

-- 置顶且滑动条不闪烁
function this.MoveTop(self)
	self.scrollRect.onValueChanged:RemoveListener(self.scrollChangeFunc)
	if not IsNull(self.scrollRect.verticalScrollbar) then
		self.scrollRect.verticalScrollbar.value = 1
	else
		self.content:DOLocalMoveY(0, 0)
	end
	coroutine.start(function () 
		coroutine.waitforframes(20)
		self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)
	end)
end

-- 置于物品位置
function this.MoveToItem(self, id, row)
	self.scrollRect.onValueChanged:RemoveListener(self.scrollChangeFunc)
	local verticalValue = 1
	for index, itemInfo in ipairs(self.array) do
		if itemInfo.Id== id then
			if index <= 3 then
				verticalValue = 1
			elseif index >= #self.array-row then
				verticalValue = 0
			else
				verticalValue = 1 - (math.ceil(index/ row)) / (#self.array/ row)
			end
		end
	end

	coroutine.start(function ()
		coroutine.waitforframes(5)
		self.scrollRect.verticalNormalizedPosition = verticalValue
		self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)
	end)
end

function this.MoveToLastPos(self, verticalValue)
	self.scrollRect.onValueChanged:RemoveListener(self.scrollChangeFunc)
	coroutine.start(function ()
		coroutine.waitforframes(2)
		self.scrollRect.verticalNormalizedPosition = verticalValue
		self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)
	end)
end

function this.UpdateNow(self)

end

-- 滑动事件
function this.OnValueChanged(self)
	if not self.isInit then
		return
	end
	local isSliderDown = self.content.localPosition.y >= self.lastPos.y
	self.lastPos = self.content.localPosition
	-- 最上面一行快显示完了
	if not isSliderDown then
		while((self.itemList[1][1].pos + self.content.localPosition).y < 0 and
				self.itemList[1][1].row > 1) do
			-- 最下面的一组移动到最上面
			local tmp = self.itemList[#self.itemList]
			for i = #self.itemList, 2, -1 do
				self.itemList[i] = self.itemList[i - 1]
			end
			self.itemList[1] = tmp
			-- 更新行数数据, index数据, 更新最新位置数据
			for i = 1, #tmp do
				self:Move(tmp[i], -self.limitRow)
			end
		end
	else
		while((self.itemList[#self.itemList][1].pos + self.content.localPosition).y + self.viewPort.rect.height > 0 and
				self.itemList[#self.itemList][1].row < self.totalRow) do
			-- 最上面的一组移动到最下面
			local tmp = self.itemList[1]
			for i = 1, #self.itemList - 1 do
				self.itemList[i] = self.itemList[i + 1]
			end
			self.itemList[#self.itemList] = tmp
			-- 更新行数数据, index数据, 更新最新位置数据
			for i = 1, #tmp do
				self:Move(tmp[i], self.limitRow)
			end
		end
	end
	self:UpdateNow()
end

-- Public API 3:
-- 切换类型，排序，搜索等 改变显示的数据时
function this.RefreshData(self, list)
	self.array = table.sortbykey(list)
	
	-- 已知当前显示了哪些行数
	-- 判断应该显示哪些行数
	-- 1.显示的最小行数总是1，不用管
	-- 2.显示的最大行数小于新list的最大行数时，直接更新图片就好
	-- 3.显示的最大行数大禹新list的最大行数时，
	if not self.isInit then
		return
	end
	self.totalRow = math.ceil(#self.array / self.limitCol)
	self.scrollRect.onValueChanged:RemoveListener(self.scrollChangeFunc)
	self.content.sizeDelta = Vector2.New(self.content.sizeDelta.x, (self.itemHeight * self.totalRow + (self.totalRow - 1) * self.spacingHeight + self.paddingTop + self.paddingBottom))
	coroutine.start(function ()
		coroutine.waitforframes(20) -- 改变了content的大小   会触发几帧事件！！！
		self.scrollRect.onValueChanged:AddListener(self.scrollChangeFunc)
	end)
	if self.recordPos ~= nil then
		self.content:DOLocalMove(self.recordPos, 0)
	end
	
	-- 当前最大行数不大于数字的最大行数
	if self.itemList[#self.itemList][1].row <= self.totalRow then
		self:MoveAll(0)
	else -- 最大行数超了
		local delta = self.itemList[#self.itemList][1].row - self.totalRow
		if self.itemList[1][1].row - delta <= 1 then
			if self.content.sizeDelta.y <= self.viewPort.rect.height then
				self.content:DOMoveY(0, 0)
				self.lastPos = self.content.localPosition
			end
			delta = self.itemList[1][1].row - 1
		end
		if delta > 0 then
			self:MoveAll(-delta)
		else
			self:MoveAll(0)
		end
	end
	self:UpdateNow()
end

-- Public API:
function this.All(self, func)
	for i = 1, #self.itemList do
		for j = 1, #self.itemList[i] do
			func(self.itemList[i][j])
		end
	end
end

--function this.Add(self, item)
--
--end
--
--function this.RemoveByIndex(self, index)
--
--end

function this.GetItem(self, func)
	for i = 1, #self.itemList do
		for j = 1, #self.itemList[i] do
			if func(self.itemList[i][j]) then
				return self.itemList[i][j]
			end
		end
	end
end

--function this.RemoveByFunc(self, list, func)
--	self.array = list
--	self.totalRow = math.ceil(#self.array / self.limitCol)
--	self.content.sizeDelta = Vector2.New(self.content.sizeDelta.x, (self.itemHeight * self.totalRow + (self.totalRow - 1) * self.spacingHeight + self.paddingTop + self.paddingBottom))
--	local item = self:GetItem(func)
--	if item ~= nil then
--		local count = 0
--		self:SomeItemsDoFunc(function (v) return v.index > item.index end, function(v) 
--			self:Move(v, -1)
--			count = count + 1
--		end)
--		self:Move(item, count)
--	end
--end
--
--function this.Insert(self, index)
--
--end

-- Public API 4:
-- 获取数据
function this.GetItemsByFunc(self, func)
	local tab = {}
	self:All(function (v)
		if func(v) then
			table.insert(tab, v)
		end
	end)
	return tab
end

-- Public API 5:
-- 对部分item进行操作
function this.SomeItemsDoFunc(self, func, callback)
	self:All(function (v)
		if func(v) then
			callback(v)
		end
	end)
end

function this.Clear(self)
	if self.content ~= nil then
		ListChildPool:GetInstance():ClearContent(self.content)
	end
end

-- Public API 6:
-- 销毁
function this.Dispose(self)
	self.itemList = {}
	if self.content ~= nil then
		ListChildPool:GetInstance():ClearContent(self.content)
	end
	if self.__update_handle then
		UpdateManager:GetInstance():RemoveUpdate(self.__update_handle)
		self.__update_handle = nil
	end
	self.callbackList = {}
	if self.scrollRect~=nil then
		self.scrollRect.onValueChanged:RemoveAllListeners()
	end
end

return DataClass("VerticalScroll", this)