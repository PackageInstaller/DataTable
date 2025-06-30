-- chunkname: @IQIGame\\UI\\Common\\UITabList.lua

local __tableItem = {}

function __tableItem.New(toggleObj, createViewFunc, showFunc)
	local obj = Clone(__tableItem)

	obj:__Init(toggleObj, createViewFunc, showFunc)

	return obj
end

function __tableItem:__Init(toggleObj, createViewFunc, showFunc)
	self.gameObject = toggleObj
	self.onShowFunc = showFunc

	function self.__delegateOnValueChangedEventProxy(isOn)
		self:__onDelegateOnValueChangedEventHandler(isOn)
	end

	self.gameObject:GetComponent("Toggle").onValueChanged:AddListener(self.__delegateOnValueChangedEventProxy)

	if createViewFunc ~= nil then
		self.viewTable = createViewFunc()

		if self.viewTable == nil then
			logError("createViewFunc 未正常返回关联的Table")
		elseif type(self.viewTable) == "table" and type(self.viewTable.Dispose) ~= "function" then
			logError("Toggle " .. self.gameObject.name .. " 关联 View 未实现 :Dispose 方法")
		end
	end

	self:UpdateActive()
end

function __tableItem:UpdateActive()
	local showView = true

	if self.onShowFunc ~= nil then
		showView = self.onShowFunc()
	end

	self.gameObject:SetActive(showView)

	if not showView then
		self.gameObject:GetComponent("Toggle").isOn = false

		self.OnValueChangeEvent(false, self.viewTable)
	end
end

function __tableItem:SetText()
	logError("------ 预制体制作方式需要统一才方便实现此公共方法 ------")
end

function __tableItem:__onDelegateOnValueChangedEventHandler(isOn)
	self:SetSelectViewActive(isOn)
end

function __tableItem:SetSelectViewActive(isOn)
	self.OnValueChangeEvent(isOn, self.viewTable)
end

function __tableItem:Dispose()
	self.gameObject:GetComponent("Toggle").onValueChanged:RemoveListener(self.__delegateOnValueChangedEventProxy)

	if self.viewTable ~= nil then
		if type(self.viewTable) == "table" then
			self.viewTable:Dispose()
		end

		self.viewTable = nil
	end

	self.gameObject = nil
	self.OnValueChangeEvent = nil
end

local UITabList = {
	selectIndex = 1,
	tableItems = {}
}

UITabList.TableItem = __tableItem

function UITabList.Create()
	local obj = Clone(UITabList)

	obj.tableItems = {}

	return obj
end

function UITabList:AddTableItem(toggleObj, createViewFunc, toggleValueChangeFunc, showFunc)
	local tableItem = self.TableItem.New(toggleObj, createViewFunc)

	table.insert(self.tableItems, tableItem)

	tableItem.tableIndex = #self.tableItems

	function tableItem.OnValueChangeEvent(_isOn, _view)
		if _isOn then
			self.selectIndex = tableItem.tableIndex
		end

		if toggleValueChangeFunc ~= nil then
			toggleValueChangeFunc(_isOn, _view)
		end
	end

	tableItem.onShowFunc = showFunc

	return tableItem
end

function UITabList:UpdateTableActive(newIndex, forceChangeIndex)
	local needReset = forceChangeIndex == true

	ForPairs(self.tableItems, function(tableIndex, tableItem)
		tableItem:UpdateActive()

		if not tableItem.gameObject.activeSelf and self.selectIndex == tableIndex then
			needReset = true
		end
	end)

	if needReset then
		self:ChangeSelectIndex(newIndex)
	end

	return needReset
end

function UITabList:ChangeSelectIndex(index)
	if index < 1 or index > #self.tableItems then
		return
	end

	local toggleComponent = self.tableItems[index].gameObject:GetComponent("Toggle")

	if not toggleComponent.isOn then
		toggleComponent.isOn = true

		return
	end

	self.selectIndex = index

	self.tableItems[index]:SetSelectViewActive(true)
	ForArrayTable(self.tableItems, function(_index, _tableItem)
		if _index == index then
			return
		end

		local _toggleComponent = _tableItem.gameObject:GetComponent("Toggle")

		if _toggleComponent.isOn then
			_toggleComponent.isOn = false
		else
			_tableItem:SetSelectViewActive(false)
		end
	end)
end

function UITabList:GetSelectIndex()
	return self.selectIndex
end

function UITabList:GetSelectItem()
	return self.tableItems[self.selectIndex]
end

function UITabList:Dispose()
	for i = 1, #self.tableItems do
		self.tableItems[i]:Dispose()
	end

	self.tableItems = nil
end

return UITabList
