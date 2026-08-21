-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\SiftTypePanel.lua

local strClassName = "SiftOption"
local SiftOption = Class(strClassName, UIControls.Child)

function SiftOption:ctor()
	self:initUI()
end

function SiftOption:initUI()
	self.option = UIControls.Toggle(self, "")
	self.txtOption = UIControls.Label(self, "Text")
end

local strClassName = "SiftTypePanel"
local SiftTypePanel = Class(strClassName, UIControls.Child)

function SiftTypePanel:ctor()
	self:initUI()
end

function SiftTypePanel:initUI()
	self.txtTitle = UIControls.Label(self, "TextTitle")
end

function SiftTypePanel:onDataToggleChange(table, toggle, isOn)
	self:checkToControlToggleAll()
end

function SiftTypePanel:onAllToggleChange(table, toggle, isOn)
	if not isOn and not self.programSetAll then
		self.toggleAll:setOnVoidUnChange(true)

		return
	end

	self.programSetAll = nil

	if isOn then
		self:clearSiftData()
	end
end

function SiftTypePanel:checkToControlToggleAll()
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

function SiftTypePanel:initData(title, filterData, isHaveAll)
	self.filterData = filterData

	self:initIsHaveAllInfo(isHaveAll)
	self.txtTitle:setText(title)

	for idx, _ in ipairs(self.toggleGroup) do
		if self.filterData[idx] then
			self.toggleGroup[idx]:setVisible(true)

			local toggleText = self.filterData[idx][1]

			self.toggleTextList[idx]:setText(toggleText)
		else
			self.toggleGroup[idx]:setVisible(false)
		end
	end

	self:checkToControlToggleAll()
end

function SiftTypePanel:initIsHaveAllInfo(isHaveAll)
	self.isHaveAll = isHaveAll

	if self.isHaveAll ~= nil then
		self.siftOptionAll = SiftOption(self, "", "System/Common/SiftBox/SiftOption", 0, 0, true)
		self.toggleAll = self.siftOptionAll.option

		self.toggleAll:addEventValueChanged(Slot(self.onAllToggleChange, self))

		self.toggleAllTxt = self.siftOptionAll.txtOption

		self.toggleAllTxt:setText(Lang.get(370))
	end

	self.toggleGroup = {}
	self.toggleTextList = {}

	for i = 1, #self.filterData do
		local siftOption = SiftOption(self, "", "System/Common/SiftBox/SiftOption", 0, 0, true)
		local toggle = siftOption.option

		toggle:addEventValueChanged(Slot(self.onDataToggleChange, self))
		table.insert(self.toggleGroup, toggle)

		local txtToggle = siftOption.txtOption

		table.insert(self.toggleTextList, txtToggle)
	end
end

function SiftTypePanel:getSiftData()
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

function SiftTypePanel:setSiftData(siftDatas)
	for _, data in ipairs(siftDatas) do
		self.toggleGroup[data.idx]:setOnVoidUnChange(true)
	end

	self:checkToControlToggleAll()
end

function SiftTypePanel:clearSiftData()
	if self.isHaveAll then
		self.toggleAll:setOnVoidUnChange(true)
	end

	for _, toggle in ipairs(self.toggleGroup) do
		toggle:setOnVoidUnChange(false)
	end
end

return SiftTypePanel
