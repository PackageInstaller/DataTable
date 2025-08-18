-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\HeadPendantAttrDlg.lua

local HeadAttrOneInfoCell = Class("HeadAttrOneInfoCell", UIControls.Child)

function HeadAttrOneInfoCell:ctor()
	self.imgIcon = UIControls.Image(self, "IconPendant")
	self.textName = UIControls.Label(self, "TextName")
	self.panelLimit = UIControls.Panel(self, "TextName/IconLimit")
	self.attrCells = {}

	for index = 1, 2 do
		local newCell = UIControls.AttrCellPanel(self, "Attr" .. index)

		table.insert(self.attrCells, newCell)
	end

	self.textState = UIControls.Label(self, "Text")
end

function HeadAttrOneInfoCell:setData(onePendantData)
	self.onePendantData = onePendantData

	local resData = onePendantData.base

	self.imgIcon:setImage(resData.picture_path, resData.picture_name)
	self.textName:setText(resData.name or "")

	for index, cell in ipairs(self.attrCells) do
		if resData.attrs[index] then
			cell:setVisible(true)
			cell:setTypeData(resData.attrs[index].type, resData.attrs[index].value)
		else
			cell:setVisible(false)
		end
	end

	self.valid = true

	ClientTimerManager.RemoveSecondTickUI(self.textState)

	if onePendantData.endTime and onePendantData.endTime > 0 then
		self.panelLimit:setVisible(true)

		if onePendantData.endTime > ClientUtils.getServerTime() then
			local leftTime = onePendantData.endTime - ClientUtils.getServerTime()

			ClientTimerManager.AddSecondFormatTickUI(self.textState, leftTime, nil, Lang.get(48659))
			self:playStateAnimator("AttrListCellNml")
		else
			self.valid = false

			self.textState:setText(Lang.get(653))
			self:playStateAnimator("AttrListCellDis")
		end
	else
		self.textState:setText(Lang.get(32799))
		self:playStateAnimator("AttrListCellNml")
		self.panelLimit:setVisible(false)
	end
end

local HeadAttrInfoPanel = Class("HeadAttrInfoPanel", UIControls.Child)

function HeadAttrInfoPanel:ctor()
	self.textName = UIControls.Label(self, "AttrLessSumPanel/Text")
	self.attrCells = {}

	for index = 1, 2 do
		local newCell = UIControls.AttrCellPanel(self, "AttrLessSumPanel/Attr" .. index)

		table.insert(self.attrCells, newCell)
	end

	self.contentCells = {}
end

function HeadAttrInfoPanel:setData(pendantData)
	self.pendantData = pendantData

	for index = #self.contentCells, #pendantData - 1 do
		local newCell = HeadAttrOneInfoCell(self, "AttrLessPanel", "System/PlayerInfor/EditPlayerHeadAttrListCell")

		table.insert(self.contentCells, newCell)
	end

	local attrs = {}

	for index, cell in ipairs(self.contentCells) do
		if pendantData[index] then
			cell:setVisible(true)
			cell:setData(pendantData[index])

			for _, info in ipairs(pendantData[index].base.attrs) do
				if cell.valid then
					attrs[info.type] = (attrs[info.type] or 0) + info.value
				else
					attrs[info.type] = attrs[info.type] or 0
				end
			end
		else
			cell:setVisible(false)
		end
	end

	local index = 1

	for propType, propValue in pairs(attrs) do
		if self.attrCells[index] then
			self.attrCells[index]:setVisible(true)
			self.attrCells[index]:setTypeData(propType, propValue)

			index = index + 1
		end
	end

	for hIndex = index, #self.attrCells do
		self.attrCells[hIndex]:setVisible(false)
	end
end

local strClassName = "HeadPendantAttrDlg"
local HeadPendantAttrDlg = Class(strClassName, UIControls.Window)

function HeadPendantAttrDlg:ctor(...)
	self:initUI()
end

function HeadPendantAttrDlg:initUI(...)
	self.panelEmpty = UIControls.Panel(self, "Bg/EmptyPanel")
	self.panelPendantInfo = HeadAttrInfoPanel(self, "Bg/AttrLessList/Content", "System/PlayerInfor/EditPlayerHeadAttrPanel")
end

function HeadPendantAttrDlg:onShow(pendantData)
	self.pendantData = {}
	self.hasAttr = false

	for index, pData in ipairs(pendantData) do
		local resData = pData.base

		if resData.attrs then
			table.insert(self.pendantData, pData)
		end
	end

	if #self.pendantData > 0 then
		self.panelEmpty:setVisible(false)
		self.panelPendantInfo:setVisible(true)
		self.panelPendantInfo:setData(self.pendantData)
	else
		self.panelEmpty:setVisible(true)
		self.panelPendantInfo:setVisible(false)
	end
end

return HeadPendantAttrDlg
