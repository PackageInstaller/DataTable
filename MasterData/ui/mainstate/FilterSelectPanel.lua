-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\FilterSelectPanel.lua

local strClassName = "FilterSelectPanel"
local FilterSelectPanel = Class(strClassName, UIControls.Panel)

function FilterSelectPanel:ctor()
	self:initUI()
end

function FilterSelectPanel:initUI()
	self.selectedIdx = {}
	self.filterDatas = {}
	self.btnAll = UIControls.Button(self, self.mPath .. "/BtnAll")

	self.btnAll:addEventClick(self.onBtnAllClick)

	self.btnSelList = {}

	for i = 1, 6 do
		if UIControls.checkControlFunc(self, self.mPath .. "/Btn" .. i) then
			local btnSel = UIControls.Button(self, self.mPath .. "/Btn" .. i)

			btnSel:addEventClick(self.onBtnSelClick)

			local imgBtn = UIControls.Image(self, self.mPath .. "/Btn" .. i .. "/Img")

			self.btnSelList[i] = {
				btnSel,
				imgBtn
			}
		end
	end
end

function FilterSelectPanel:filterAllFuncNoCallBack()
	for _, btnInfo in ipairs(self.btnSelList) do
		btnInfo[1]:setEnable(true)
	end

	self.btnAll:setEnable(false)

	self.selectedIdx[self.filterIdx] = 0

	local function checkFilterFunc(data)
		for filterIdx, selIdx in pairs(self.selectedIdx) do
			if selIdx ~= 0 and data[self.filterDatas[filterIdx].data[selIdx][2]] ~= self.filterDatas[filterIdx].data[selIdx][3] then
				return false
			end
		end

		return true
	end

	return checkFilterFunc
end

function FilterSelectPanel:onBtnAllClick()
	for _, btnInfo in ipairs(self.btnSelList) do
		btnInfo[1]:setEnable(true)
	end

	self.btnAll:setEnable(false)

	self.selectedIdx[self.filterIdx] = 0

	local function checkFilterFunc(data)
		for filterIdx, selIdx in pairs(self.selectedIdx) do
			if selIdx ~= 0 and data[self.filterDatas[filterIdx].data[selIdx][2]] ~= self.filterDatas[filterIdx].data[selIdx][3] then
				return false
			end
		end

		return true
	end

	if self.callback then
		self.callback(checkFilterFunc)
	end
end

function FilterSelectPanel:onBtnSelClick(sender)
	for idx, btnInfo in ipairs(self.btnSelList) do
		if sender == btnInfo[1] then
			btnInfo[1]:setEnable(false)

			self.selectedIdx[self.filterIdx] = idx

			if self.btnImgSelected then
				self.btnImgSelected[self.filterIdx]:setImage(self.filterDatas[self.filterIdx].atlas, self.filterDatas[self.filterIdx].data[idx][1])
			end
		else
			btnInfo[1]:setEnable(true)
		end
	end

	self.btnAll:setEnable(true)

	local function checkFilterFunc(data)
		for filterIdx, selIdx in pairs(self.selectedIdx) do
			if selIdx ~= 0 and data[self.filterDatas[filterIdx].data[selIdx][2]] ~= self.filterDatas[filterIdx].data[selIdx][3] then
				return false
			end
		end

		return true
	end

	if self.callback then
		self.callback(checkFilterFunc)
	end
end

function FilterSelectPanel:setFilterData(filterData, callback, filterIdx)
	self.filterDatas[filterIdx] = filterData
	self.filterIdx = filterIdx or 0
	self.callback = callback

	if not self.selectedIdx[self.filterIdx] then
		self.selectedIdx[self.filterIdx] = 0
	end

	for idx, data in ipairs(filterData.data) do
		if self.btnSelList[idx] then
			self.btnSelList[idx][2]:setImage(filterData.atlas, data[1])
			self.btnSelList[idx][1]:setVisible(true)
			self.btnSelList[idx][1]:setEnable(self.selectedIdx[self.filterIdx] ~= idx)
		else
			self.btnSelList[idx][1]:setVisible(false)
		end
	end

	for idx = #filterData.data + 1, #self.btnSelList do
		self.btnSelList[idx][1]:setVisible(false)
	end

	self.btnAll:setEnable(self.selectedIdx[self.filterIdx] ~= 0)
end

function FilterSelectPanel:setFilterClear()
	for _, btnInfo in ipairs(self.btnSelList) do
		btnInfo[1]:setEnable(true)
	end

	self.btnAll:setEnable(false)

	self.selectedIdx = {}
	self.filterDatas = {}

	self:setVisible(false)
end

function FilterSelectPanel:resetFilterData()
	self.selectedIdx = {}
	self.filterDatas = {}
end

return FilterSelectPanel
