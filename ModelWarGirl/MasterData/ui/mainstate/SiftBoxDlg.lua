-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\SiftBoxDlg.lua

local strClassName = "SiftBoxDlg"
local SiftTypePanel = require("UI/MainState/SiftTypePanel")
local SiftBoxDlg = Class(strClassName, UIControls.Window)

function SiftBoxDlg:ctor()
	self:initUI()
end

function SiftBoxDlg:initUI()
	if CurAvatar then
		self.currentEntity = CurAvatar
	end

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.btnReset = UIControls.Button(self, "BgPanel/BtnReset", "Text")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")
end

function SiftBoxDlg:onBtnResetClick()
	for _, filterPanel in ipairs(self.totalFilterPanel) do
		filterPanel:clearSiftData()
	end
end

function SiftBoxDlg:initFilterInfo(_filterMap, filterConfig, filterCallBack, typePrefab)
	self.filterMap = _filterMap

	if not self.totalFilterPanel then
		self.totalFilterPanel = {}
	end

	for i, filterInfo in ipairs(self.filterMap) do
		if not self.totalFilterPanel[i] then
			self.totalFilterPanel[i] = SiftTypePanel(self, "BgPanel", "System/Common/SiftBox/" .. (typePrefab or "SiftTypePanel1"), 0, 0, true)
		end

		self.totalFilterPanel[i]:initData(filterInfo.title, filterInfo.data, self.isHaveAll)
	end

	if filterConfig then
		self:onBtnResetClick()

		for idx, siftDatas in pairs(filterConfig) do
			self.totalFilterPanel[idx]:setSiftData(siftDatas)
		end
	end

	self.filterCallBack = filterCallBack
end

function SiftBoxDlg:setTitle(txtTitle)
	self.txtTitle:setText(txtTitle)
end

function SiftBoxDlg:setIsHaveAll(isHaveAll)
	self.isHaveAll = isHaveAll

	if self.isHaveAll then
		self.btnReset:setText(Lang.get(919))
	end
end

function SiftBoxDlg:onBtnConfirmClick()
	self.toggleGroupTypeFilter = {}

	for idx, filterPanel in ipairs(self.totalFilterPanel) do
		local siftDatas = filterPanel:getSiftData()

		self.toggleGroupTypeFilter[idx] = {}

		for _, data in ipairs(siftDatas) do
			table.insert(self.toggleGroupTypeFilter[idx], data)
		end
	end

	local function checkFilterFunc(data)
		local typeCertList = {}
		local emptyPanelCount = 0

		for panelIdx, panelSiftDatas in ipairs(self.toggleGroupTypeFilter) do
			if #panelSiftDatas > 0 then
				for _, siftData in ipairs(panelSiftDatas) do
					if type(siftData.value) == "table" then
						if data[siftData.prop] >= siftData.value[1] and data[siftData.prop] <= siftData.value[2] then
							typeCertList[panelIdx] = true
						end
					elseif data[siftData.prop] == siftData.value then
						typeCertList[panelIdx] = true
					end
				end

				if not typeCertList[panelIdx] then
					typeCertList[panelIdx] = false
				end
			else
				emptyPanelCount = emptyPanelCount + 1
				typeCertList[panelIdx] = true
			end
		end

		if not self.isHaveAll and emptyPanelCount == #self.toggleGroupTypeFilter then
			return false
		end

		local isCertPass = true

		for _, pass in pairs(typeCertList) do
			if pass == false then
				isCertPass = false
			end
		end

		return isCertPass
	end

	if self.filterCallBack then
		self.filterCallBack(checkFilterFunc, self.toggleGroupTypeFilter)
	end
end

function SiftBoxDlg:onCloseClick()
	self:setVisible(false)
end

return SiftBoxDlg
