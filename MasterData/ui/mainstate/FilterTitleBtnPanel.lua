-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\FilterTitleBtnPanel.lua

local ResColor = require("ClientData/ResColor")
local strClassName = "FilterTitleBtnPanel"
local FilterTitleBtnPanel = Class(strClassName, UIControls.Panel)

function FilterTitleBtnPanel:ctor(parent, path, titleCount, filterSelectPanel, filterCallback, mapData)
	self.titleCount = titleCount
	self.filterSelectPanel = filterSelectPanel
	self.filterCallback = filterCallback
	self.mapData = mapData

	self:initUI()
end

function FilterTitleBtnPanel:initUI()
	self.btnFilterList = {}
	self.btnFilterDir = {}
	self.btnImgSelected = {}

	for i = 1, 10 do
		if not UIControls.checkControlFunc(self, self.mPath .. "/BtnListCustom" .. i) then
			self.titleCount = i - 1

			break
		end
	end

	for idx = 1, self.titleCount do
		local btnFilter = UIControls.Button(self, self.mPath .. "/BtnListCustom" .. idx, "GroupPanel/Text")

		if self.mapData and self.mapData[idx] then
			btnFilter:setVisible(true)
			btnFilter:addEventClick(self.onBtnFilterClick)
			btnFilter:setText(self.mapData[idx].title)

			self.btnFilterList[idx] = btnFilter

			local imgDrop = UIControls.Image(self, self.mPath .. "/BtnListCustom" .. idx .. "/GroupPanel/ImgDrop")
			local imgUp = UIControls.Image(self, self.mPath .. "/BtnListCustom" .. idx .. "/GroupPanel/ImgUp")
			local imgSelected = UIControls.Image(self, self.mPath .. "/BtnListCustom" .. idx .. "/ImgGroup")

			self.btnFilterDir[idx] = {
				imgDrop,
				imgUp
			}
			self.btnImgSelected[idx] = imgSelected
		else
			btnFilter:setVisible(false)
		end
	end

	self.filterSelectPanel.btnImgSelected = self.btnImgSelected
end

function FilterTitleBtnPanel:onBtnFilterClick(sender)
	local showFilterIdx = 0

	for idx, btn in ipairs(self.btnFilterList) do
		if btn == sender then
			if idx == self.filterSelectPanel.filterIdx and self.filterSelectPanel:getVisible() then
				self.filterSelectPanel:setVisible(false)
				self.btnImgSelected[idx]:setVisible(self.filterSelectPanel.selectedIdx[idx] ~= 0)
				self:setBtnShow(idx, false)
			else
				showFilterIdx = idx

				self.filterSelectPanel:setVisible(true)
				self.filterSelectPanel:setFilterData(self.mapData[idx], self.filterCallback, idx)
				self.btnImgSelected[idx]:setVisible(false)
				self:setBtnShow(idx, true)
			end
		end
	end

	for idx, imgSel in ipairs(self.btnImgSelected) do
		if idx ~= showFilterIdx then
			self.btnImgSelected[idx]:setVisible(self.filterSelectPanel.selectedIdx[idx] and self.filterSelectPanel.selectedIdx[idx] ~= 0)
			self:setBtnShow(idx, false)
		end
	end
end

function FilterTitleBtnPanel:setBtnShow(idx, isSelected)
	local color = isSelected == true and ResColor.SELECTYELLOW or ResColor.QUALITYWHITE

	self.btnFilterDir[idx][1]:setVisible(not isSelected)
	self.btnFilterDir[idx][2]:setVisible(isSelected)
	self.btnFilterList[idx]:setFontColor(color)
end

function FilterTitleBtnPanel:setFilterClear()
	self.filterSelectPanel:setFilterClear()

	for idx, btn in ipairs(self.btnFilterList) do
		self:setBtnShow(idx, false)
		self.btnImgSelected[idx]:setVisible(false)
	end
end

return FilterTitleBtnPanel
