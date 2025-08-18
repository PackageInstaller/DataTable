-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\FilterBtnSelPanel.lua

local strClassName = "FilterBtnSelPanel"
local FilterBtnSelPanel = Class(strClassName, UIControls.Panel)

function FilterBtnSelPanel:ctor(parent, path, filterSelectPanel, filterMultiSelectPanel, filterCallback, mapData)
	self.filterSelectPanel = filterSelectPanel
	self.filterMultiSelectPanel = filterMultiSelectPanel
	self.filterCallback = filterCallback
	self.mapData = mapData
end

function FilterBtnSelPanel:initBtnSelPanel(invokeCallBack)
	self.panelListType = UIControls.Panel(self, self.mPath .. "/ListTypePanel")
	self.btnTypeInfoList = {}

	for i = 1, 3 do
		local btnType = UIControls.Button(self, self.mPath .. "/ListTypePanel/BtnType" .. i)

		btnType:addEventClick(self.onBtnTypeClick)

		local txtBtnType = UIControls.Label(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/Text")
		local txtBtnTypeSel = UIControls.Label(self, self.mPath .. "/ListTypePanel/BtnType" .. i .. "/Text1")

		self.btnTypeInfoList[i] = {
			btn = btnType,
			btnName = txtBtnType,
			btnNameSel = txtBtnTypeSel
		}
	end

	self.btnSel = UIControls.Button(self, self.mPath .. "/BtnSel", "Text")

	self.btnSel:addEventClick(self.onBtnSelClick)

	for idx, btnTypeInfo in ipairs(self.btnTypeInfoList) do
		if not self.mapData[idx] then
			btnTypeInfo.btn:setVisible(false)
		else
			btnTypeInfo.btn:setVisible(true)

			local filterPanelInfo = self.mapData[idx]

			btnTypeInfo.btnName:setText(filterPanelInfo.map.title)
			btnTypeInfo.btnNameSel:setText(filterPanelInfo.map.title)
		end
	end

	self.imgIconUp = UIControls.Image(self, self.mPath .. "/BtnSel/IconUp")

	self:onBtnTypeClick(self.btnTypeInfoList[1].btn, not invokeCallBack)
end

function FilterBtnSelPanel:onBtnTypeClick(sender, noCallBack)
	local clickIdx = 0

	for idx, btnTypeInfo in ipairs(self.btnTypeInfoList) do
		if btnTypeInfo.btn == sender then
			clickIdx = idx

			local filterPanelInfo = self.mapData[idx]

			self.btnSel:setText(filterPanelInfo.map.title)
			btnTypeInfo.btnName:setVisible(false)
			btnTypeInfo.btnNameSel:setVisible(true)
		else
			btnTypeInfo.btnName:setVisible(true)
			btnTypeInfo.btnNameSel:setVisible(false)
		end
	end

	self.panelListType:setVisible(false)
	self.imgIconUp:setScaleXYZ(1, -1, 1)

	if not self.selectedIdx or self.selectedIdx ~= clickIdx then
		self.selectedIdx = clickIdx

		local filterPanelInfo = self.mapData[self.selectedIdx]

		if filterPanelInfo.type == UIConst.FILTER_TYPE_SINGLE_SEL then
			self.filterSelectPanel:setVisible(true)

			if self.filterMultiSelectPanel then
				self.filterMultiSelectPanel:setVisible(false)
			end

			self.filterSelectPanel:resetFilterData()
			self.filterSelectPanel:setFilterData(self.mapData[self.selectedIdx].map, self.filterCallback, self.selectedIdx)

			if not noCallBack then
				self.filterSelectPanel:onBtnAllClick()
			end
		elseif filterPanelInfo.type == UIConst.FILTER_TYPE_MULTI_SEL then
			if self.filterSelectPanel then
				self.filterSelectPanel:setVisible(false)
			end

			self.filterSelectPanel:setVisible(false)
			self.filterMultiSelectPanel:setVisible(true)
			self.filterMultiSelectPanel:setFilterData(self.mapData[self.selectedIdx].map, nil, self.filterCallback)

			if not noCallBack then
				self.filterMultiSelectPanel:onFilterAll()
			end
		end
	end
end

function FilterBtnSelPanel:filterAllFuncNoCallBack()
	if self.filterSelectPanel:getVisible() then
		return self.filterSelectPanel:filterAllFuncNoCallBack()
	elseif self.filterMultiSelectPanel:getVisible() then
		return self.filterMultiSelectPanel:filterAllFuncNoCallBack()
	end
end

function FilterBtnSelPanel:onBtnSelClick()
	self.panelListType:changeVisible()

	local scaleY = self.panelListType:getVisible() and 1 or -1

	self.imgIconUp:setScaleXYZ(1, scaleY, 1)
end

return FilterBtnSelPanel
