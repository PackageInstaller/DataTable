-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonSortPanel.lua

local SortBtnListTypeCell = {}
local SortBtnListTypeCell = Class("SortBtnListTypeCell", UIControls.Child)

function SortBtnListTypeCell:ctor()
	self:_initUI()
end

function SortBtnListTypeCell:_initUI()
	self.btnSort = UIControls.Button(self, "", "Text")

	self.btnSort:addEventClick(self.onBtnSortClick)

	self.imgArrow = UIControls.Image(self, "ImgArrow")
	self.txtName = UIControls.Label(self, "Text")
	self.imgBg = UIControls.Image(self, "Bg")
end

function SortBtnListTypeCell:onBtnSortClick()
	self.mParent:onBtnSortTypeClick(self.btnSort)
end

local CommonSortPanel = Class("CommonSortPanel", UIControls.Panel)
local ResColor = require("ClientData/ResColor")

function CommonSortPanel:ctor()
	self:initUI()

	self.mEventDataListChanged = nil
end

function CommonSortPanel:initUI()
	self.btnSortType = UIControls.Button(self, self.mPath .. "/BtnListType", "Text")

	self.btnSortType:addEventClick(self.onBtnListTypeClick)

	self.imgSortTypeArrow = UIControls.Image(self, self.mPath .. "/BtnListType/ImgArrow")
	self.panelSortType = UIControls.Panel(self, self.mPath .. "/ListTypePanel")
	self.btnsSortType = {}
	self.btnsSortLabel = {}
	self.btnsSortCell = {}
	self.btnSensor = UIControls.Button(self, self.mPath .. "/UIClickThrough")

	self.btnSensor:addEventClick(self.onBtnSensorClick)
end

function CommonSortPanel:initSortInfo(sortMap, isSort, topFunc)
	self.defaultIsSort = isSort or false
	self.sortMap = sortMap

	local btnIdx = 1

	for idx, sortInfo in ipairs(self.sortMap) do
		if not sortInfo.hide then
			if not self.btnsSortType[btnIdx] then
				local listPath = self.mPath .. "/ListTypePanel"
				local btnCell = SortBtnListTypeCell(self, listPath, "System/Hero/BtnListTypeCell")

				btnCell:setVisible(true)

				btnCell.btnSort.arrow = btnCell.imgArrow
				self.btnsSortType[btnIdx] = btnCell.btnSort
				self.btnsSortLabel[btnIdx] = btnCell.txtName
				self.btnsSortCell[btnIdx] = btnCell
			end

			self.btnsSortType[btnIdx].sortIdx = idx

			self.btnsSortType[btnIdx]:setText(self.sortMap[self.btnsSortType[btnIdx].sortIdx].text)

			self.btnsSortType[btnIdx].isSort = self.defaultIsSort
			btnIdx = btnIdx + 1
		end
	end

	for i, v in ipairs(self.btnsSortType) do
		if not self.btnsSortType[i].sortIdx then
			self.btnsSortType[i]:setVisible(false)
		end
	end

	self.topFunc = topFunc
end

function CommonSortPanel:_sortDatas(sortInfo, isSort, firstIdx)
	local function sortData(dataA, dataB)
		if self.topFunc then
			local result = self.topFunc(dataA, dataB)

			if result ~= 0 then
				return result == 1
			end
		end

		for i, pName in ipairs(sortInfo) do
			local vA = dataA[pName]
			local vB = dataB[pName]

			if vA and vB then
				if vA ~= vB then
					if i == (firstIdx or 1) then
						if isSort then
							return vB < vA
						else
							return vA < vB
						end
					elseif self.defaultIsSort then
						return vA < vB
					else
						return vB < vA
					end
				end
			elseif vA or vB then
				return vA ~= nil
			end
		end
	end

	table.sort(self._allDatas, sortData)

	if self.mEventDataListChanged then
		self.mEventDataListChanged(self._allDatas)
	end
end

function CommonSortPanel:onBtnListTypeClick(sender)
	self.panelSortType:changeVisible()
	self.btnSensor:setVisible(self.panelSortType:getVisible())
end

function CommonSortPanel:onBtnSensorClick(sender)
	self.panelSortType:setVisible(false)
	self.btnSensor:setVisible(false)
end

function CommonSortPanel:onBtnSortTypeClick(sender)
	local isSort = true

	self.curSortBtn = sender

	for i, btn in ipairs(self.btnsSortType) do
		if btn ~= self.curSortBtn then
			btn.arrow:setVisible(false)
			self.btnsSortCell[i].imgBg:setVisible(false)

			btn.isSort = self.defaultIsSort
		else
			btn.arrow:setVisible(true)
			self.btnsSortCell[i].imgBg:setVisible(true)

			btn.isSort = not btn.isSort
			isSort = btn.isSort

			local angle = isSort and 180 or 0

			btn.arrow:setRotate(angle)
		end
	end

	self.btnSortType:setText(self.sortMap[self.curSortBtn.sortIdx].text)
	self.imgSortTypeArrow:setImage("Atlas/CommonAtlas/OtherAtlas", isSort and "IconBtnLevelDown" or "IconBtnLevelUp")
	self:sortData(isSort)
	self:onBtnSensorClick()
end

function CommonSortPanel:sortByCurConfig(datas)
	self._allDatas = datas

	if not self.curSortBtn then
		self:onBtnSortTypeClick(self.btnsSortType[1])
	else
		self:sortData(self.curSortBtn.isSort)
	end
end

function CommonSortPanel:sortData(isSort)
	for idx, label in ipairs(self.btnsSortLabel) do
		local color = self.btnsSortType[idx] == self.curSortBtn and ResColor.ORANGEBTN or ResColor.GREYLIGHT

		self.btnsSortLabel[idx]:setFontColor(color)
		self.btnsSortCell[idx].imgBg:setVisible(self.btnsSortType[idx] == self.curSortBtn)
	end

	local sortFirstIdx = self.curSortBtn.sortIdx
	local sortInfos = {}
	local firstIdxIndex = 1

	for _, sortInfo in ipairs(self.sortMap) do
		if sortInfo.forceTop then
			table.insert(sortInfos, sortInfo.name)

			firstIdxIndex = firstIdxIndex + 1
		end
	end

	table.insert(sortInfos, self.sortMap[sortFirstIdx].name)

	for i, sortInfo in ipairs(self.sortMap) do
		if i ~= sortFirstIdx and not sortInfo.forceTop then
			table.insert(sortInfos, sortInfo.name)
		end
	end

	table.insert(sortInfos, "id")
	table.insert(sortInfos, "gid")
	self:_sortDatas(sortInfos, isSort, firstIdxIndex)
end

return CommonSortPanel
