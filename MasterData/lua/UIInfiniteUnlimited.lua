--不规则无限滚动，只支持单行或单列
local this = {}

function this.New()
	this.__index = this.__index or this
	local ins = {}
	setmetatable(ins, this)
	return ins
end

--- 初始化
---@param itemPath 地址
---@param refreshFunc 刷新函数
---@param parent 父物体
---@param spacing 间距
---@param padding 里边距
function this:Init(itemPath,refreshFunc,parent,spacing,padding)
	self.path = itemPath
	self.func = refreshFunc
	self.parent = parent
	self.spacing = spacing or 0
	self.padding = padding or {0,0} --上下或左右
	if self.parent then
		self.sr = ComUtil.GetComInParent(self.parent.gameObject,"ScrollRect")
		if not IsNil(self.sr) then
			self.isHor = self.sr.horizontal
			local size = CSAPI.GetRealRTSize(self.sr.gameObject)
			if size then
				if self.isHor then
					self.maxLen = size[0]
				else
					self.maxLen = size[1]
				end	
			end
			-- local dropEvent = ComUtil.GetOrAddCom(self.sr.gameObject,"UIInfiniteUnlimitDragEvent")
			-- dropEvent:SetValueChangedAction(function (x,y)
			-- 	self:Update()
			-- end)
		end

		self.rect = ComUtil.GetCom(self.parent.gameObject,"RectTransform")
		if not IsNil(self.rect) then
			if self.isHor then
				self.rect.anchorMin = UnityEngine.Vector2(0, 0)
				self.rect.anchorMax = UnityEngine.Vector2(0, 1)
			else
				self.rect.anchorMin = UnityEngine.Vector2(0, 1)
				self.rect.anchorMax = UnityEngine.Vector2(1, 1)
			end
		end
	end
end

--- 显示列表
---@param datas 数据列表，子数据须包含GetSize函数来设置尺寸
---@param loadSuccess 加载完子物体后回调
---@param index 跳转序号
function this:IEShowList(datas,loadSuccess,index)
	self.maxNum = datas and #datas or 0
	if self.info and #self.info> 0 then
		for i, v in ipairs(self.info) do
			if v.isSet then
				self:Push(v.rect)
			end
		end
	end
	self.info = {}
	self.length = 0
	if self.maxNum > 0 then
		self.length = self.padding[1]
		if datas and #datas > 0 then
			for i, v in ipairs(datas) do
				self.info[i] = {}
				self.info[i].len = v:GetSize()
				self.info[i].pos = self.length
				self.length = self.length + self.info[i].len + self.spacing
			end
		end
		self.length = self.length + self.padding[2]
		CSAPI.SetRTSize(self.parent,self.isHor and self.length or 0,self.isHor and 0 or self.length)
	end
	self.loadSuccess = loadSuccess
	index = index or 0
	self:MoveToIndex(index)
	self.isUpdate = false
	self:UpdateItems(function ()
		if self.loadSuccess then
			self.loadSuccess()
		end
		self.isUpdate = true
	end)
end

function this:Update()
	if not self.isUpdate then
		return
	end

	self:UpdateItems()
end

function this:UpdateItems(cb)
	if self.maxNum > 0 then
		for i = 1, self.maxNum do
			self:UpdateItem(i,function ()
				if i == self.maxNum and cb then
					cb()
				end
			end)
		end
	end
end

function this:UpdateItem(i,cb)
	if self:IsShowActive(i) then
		if not self.info[i].isSet then
			self.info[i].isSet = true
			self:Pop(function (rect)
				self.info[i].rect = rect
				if self.func then --刷新子物体状态
					self.func(i)
				end
				CSAPI.SetAnchor(self.info[i].rect.gameObject,self.isHor and -self.info[i].pos or 0,self.isHor and 0 or -self.info[i].pos)
				if cb then
					cb()
				end
			end)
		else
			if cb then
				cb()
			end
		end
	else
		if self.info[i].isSet == true then
			self:Push(self.info[i].rect)
			self.info[i].rect = nil
			self.info[i].isSet = false
		end
		if cb then
			cb()
		end
	end
end

function this:IsShowActive(i)
	if self.isHor then
		if self.rect.anchoredPosition.x > (self.info[i].pos + self.info[i].len) then
			return false
		elseif self.rect.anchoredPosition.x + self.maxLen < self.info[i].pos then
			return false
		end
	else
		if self.rect.anchoredPosition.y > (self.info[i].pos + self.info[i].len) then
			return false
		elseif self.rect.anchoredPosition.y + self.maxLen < self.info[i].pos then
			return false
		end
	end
	return true
end

function this:Push(rect)
	CSAPI.SetGOActive(rect.gameObject, false)
	self.itemPool = self.itemPool or {}
	table.insert(self.itemPool, rect)
end

function this:Pop(cb)
	if self.itemPool and #self.itemPool > 0 then
		local rect = table.remove(self.itemPool,1)
		CSAPI.SetGOActive(rect.gameObject, true)
		if cb then
			cb(rect)
		end
		return
	end

	if self.path and self.parent then
		ResUtil:CreateUIGOAsync(self.path,self.parent,function (go)
			local rect = ComUtil.GetCom(go,"RectTransform")
			if not IsNil(rect) then
				rect.anchorMin = UnityEngine.Vector2(0, 1)
				rect.anchorMax = UnityEngine.Vector2(0, 1)	
				rect.pivot = UnityEngine.Vector2(0, 1)
				if cb then
					cb(rect)
				end
			end
		end)
	end
end

--接口
function this:GetItemLua(index)
	if self.info and self.info[index] and self.info[index].isSet and not IsNil(self.info[index].rect) then
		return ComUtil.GetLuaTable(self.info[index].rect.gameObject)
	end
	return nil
end

function this:MoveToIndex(index)
	if not index or index== 0 then
		return
	end
	if self.info and self.info[index] and self.info[index].pos then
		if self.isHor then
			if self.rect.sizeDelta.x <= self.maxLen then --sv长度大于parent长度
				CSAPI.SetAnchor(self.parent,0,0)
			elseif self.info[index].pos > self.rect.sizeDelta.x - self.maxLen then --item位置在末尾
				CSAPI.SetAnchor(self.parent,self.rect.sizeDelta.y - self.maxLen,0)
			else
				CSAPI.SetAnchor(self.parent,self.info[index].pos,0)
			end
		else
			if self.rect.sizeDelta.y <= self.maxLen then --sv长度大于parent长度
				CSAPI.SetAnchor(self.parent,0,0)
			elseif self.info[index].pos > self.rect.sizeDelta.y - self.maxLen then --item位置在末尾
				CSAPI.SetAnchor(self.parent,0,self.rect.sizeDelta.y - self.maxLen)
			else
				CSAPI.SetAnchor(self.parent,0,self.info[index].pos)
			end
		end
	end
end

function this:UpdateList()
	if self.infos and #self.infos > 0 then
		for i, v in ipairs(self.infos) do
			if v.isSet and v.rect then
				self.func(i)
			end
		end
	end
end

return this