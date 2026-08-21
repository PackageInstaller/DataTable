-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\FilterMultiSelectPanel.lua

local strClassName = "FilterMultiSelectPanel"
local FilterMultiSelectPanel = Class(strClassName, UIControls.Panel)

function FilterMultiSelectPanel:ctor()
	return
end

function FilterMultiSelectPanel:onAllToggleChange(table, toggle, isOn)
	if not isOn and not self.programSetAll then
		self.toggleAll:setOnVoidUnChange(true)

		return
	end

	self.programSetAll = nil

	if isOn then
		self:clearSiftData()
	end
end

function FilterMultiSelectPanel:checkToControlToggleAll()
	if self.isHaveAll then
		for _, toggle in ipairs(self.toggleGroup) do
			if toggle:isOn() then
				if self.toggleAll:isOn() then
					self.programSetAll = true

					self.toggleAll:setOn(false)
				end

				return
			end
		end

		self.toggleAll:setOnVoidUnChange(true)
	end
end

function FilterMultiSelectPanel:setFilterData(filterData, isHaveAll, callback)
	self:initIsHaveAllInfo(isHaveAll)

	self.filterData = filterData
	self.callback = callback

	for idx, _ in ipairs(self.toggleGroup) do
		if self.filterData.data[idx] then
			local atlas = self.filterData.atlas
			local sprite = self.filterData.data[idx][1]

			self.toggleImgList[idx]:setImage(atlas, sprite)
			self.toggleGroup[idx]:setOnVoidUnChange(false)
			self.toggleGroup[idx]:setVisible(true)
		else
			self.toggleGroup[idx]:setVisible(false)
		end
	end
end

function FilterMultiSelectPanel:onDataToggleChange(table, toggle, isOn)
	self:executeCallBack()
end

function FilterMultiSelectPanel:filterAllFuncNoCallBack()
	for idx, _ in ipairs(self.toggleGroup) do
		self.toggleGroup[idx]:clearEventValueChanged()
		self.toggleGroup[idx]:setOnVoidUnChange(false)
		self.toggleGroup[idx]:addEventValueChanged(Slot(self.onDataToggleChange, self))
	end

	local function checkFilterFunc(data)
		return true
	end

	return checkFilterFunc
end

function FilterMultiSelectPanel:onFilterAll()
	for idx, _ in ipairs(self.toggleGroup) do
		self.toggleGroup[idx]:clearEventValueChanged()
		self.toggleGroup[idx]:setOnVoidUnChange(false)
		self.toggleGroup[idx]:addEventValueChanged(Slot(self.onDataToggleChange, self))
	end

	self:executeCallBack()
end

function FilterMultiSelectPanel:executeCallBack()
	local isAllSelect = true
	local tempIsOnFlag = self.toggleGroup[1]:isOn()
	local selectedIdx = {}

	for idx, _ in ipairs(self.toggleGroup) do
		if self.toggleGroup[idx]:isOn() then
			table.insert(selectedIdx, idx)
		end

		if idx ~= 1 and tempIsOnFlag ~= self.toggleGroup[idx]:isOn() then
			isAllSelect = false
		end
	end

	local function checkFilterFunc(data)
		if isAllSelect then
			return true
		else
			for _, selIdx in pairs(selectedIdx) do
				if data[self.filterData.data[selIdx][2]] == self.filterData.data[selIdx][3] then
					return true
				end
			end

			return false
		end
	end

	if self.callback then
		self.callback(checkFilterFunc)
	end
end

function FilterMultiSelectPanel:initIsHaveAllInfo(isHaveAll)
	self.isHaveAll = isHaveAll

	local startIdx = self.isHaveAll ~= nil and 2 or 1

	self.toggleGroup = {}

	for i = startIdx, 6 do
		local toggle = UIControls.Toggle(self, self.mPath .. "/Toggle" .. i)

		toggle:addEventValueChanged(Slot(self.onDataToggleChange, self))
		table.insert(self.toggleGroup, toggle)
	end

	self.toggleImgList = {}

	for i = startIdx, 6 do
		local imgToggle = UIControls.Image(self, self.mPath .. "/Toggle" .. i .. "/Icon")

		table.insert(self.toggleImgList, imgToggle)
	end

	if self.isHaveAll then
		self.toggleAll = UIControls.Toggle(self, self.mPath .. "/Option1")

		self.toggleAll:addEventValueChanged(Slot(self.onAllToggleChange, self))

		self.toggleAllTxt = UIControls.Label(self, self.mPath .. "/Option1/Text")

		self.toggleAllTxt:setText(Lang.get(370))
	end
end

function FilterMultiSelectPanel:getSiftData()
	local siftDatas = {}

	for idx, toggle in ipairs(self.toggleGroup) do
		if self.filterData[idx] and toggle:isOn() == true then
			local prop = self.filterData[idx][2]
			local value = self.filterData[idx][3]
			local data = {}

			data.idx = idx
			data.prop = prop
			data.value = value

			table.insert(siftDatas, data)
		end
	end

	return siftDatas
end

function FilterMultiSelectPanel:setSiftData(siftDatas)
	for _, data in ipairs(siftDatas) do
		self.toggleGroup[data.idx]:setOnVoidUnChange(true)
	end

	self:checkToControlToggleAll()
end

function FilterMultiSelectPanel:clearSiftData()
	if self.isHaveAll then
		self.toggleAll:setOnVoidUnChange(true)
	end

	for _, toggle in ipairs(self.toggleGroup) do
		toggle:setOnVoidUnChange(false)
	end
end

return FilterMultiSelectPanel
