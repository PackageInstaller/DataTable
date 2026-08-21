-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeShopHaloCard.lua

local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeFetters = require("ClientData/ResNewMazeFetters")
local strClassName = "NewMazeShopHaloCard"
local NewMazeShopHaloCard = Class(strClassName, UIControls.Child)
local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)

function NewMazeShopHaloCard:ctor()
	self:initUI()
end

function NewMazeShopHaloCard:initUI()
	self.iconLosder = UIControls.Image(self, "IconLosder")
	self.textTitle = UIControls.Label(self, "BgTextTitle/TextTitle")
	self.textBuff = UIControls.Label(self, "BgTextDec/TextBuff")
	self.btnIconLosder = UIControls.Button(self, "IconLosder")

	self.btnIconLosder:addEventClick(self.onIconLosderClick)

	self.btnReduce = UIControls.Button(self, "BgTextDec/BtnReduce")

	self.btnReduce:addEventClick(self.onBtnReduceClick)

	self.btnExtend = UIControls.Button(self, "BgTextDec/BtnExtend")

	self.btnExtend:addEventClick(self.onBtnExtendClick)

	self.bgTextDec = UIControls.Image(self, "BgTextDec")
	self.comDescLayout = self.bgTextDec:getComObj():GetComponent(LayoutElementType)
end

function NewMazeShopHaloCard:setData(itemId)
	self.haloId = itemId

	local haloData = ResNewMazeHalo[self.haloId]

	if haloData then
		self.textTitle:setText(haloData.name)
		self.textBuff:setText(haloData.description)

		if haloData.icon_path then
			self.iconLosder:setImage(haloData.icon_path, haloData.icon_name)
		end

		if self.textBuff:getHeight() > 120 then
			self.btnExtend:setVisible(true)
			self.btnReduce:setVisible(false)
		else
			self.btnExtend:setVisible(false)
			self.btnReduce:setVisible(false)
		end
	end
end

function NewMazeShopHaloCard:onIconLosderClick()
	if self.mWindow.losderTipsInfoPanel then
		local fettersData, fettersTableData = self:getHaloLosderData()

		if fettersData and fettersTableData then
			self.mWindow.losderTipsInfoPanel:setData(fettersData, fettersTableData)
			self.mWindow.losderTipsInfoPanel:setVisible(true)
			self.mWindow.losderTipsPanel:setVisible(true)
		end

		if self.mWindow.fettersCellList then
			for i, cell in pairs(self.mWindow.fettersCellList) do
				cell.imgSel:setVisible(fettersData.type == cell.fettersType)
			end
		end
	end
end

function NewMazeShopHaloCard:getHaloLosderData()
	local label = ResNewMazeHalo[self.haloId].label

	if self.mWindow.fettersCellList then
		for i, v in pairs(self.mWindow.fettersCellList) do
			if v.fettersType == label then
				return v.fettersData, v.fettersTableData
			end
		end
	end

	local fettersData = {
		formationNum = 0,
		num = 0,
		type = label,
		heros = {},
		formationHeros = {},
		halo = {}
	}
	local fettersTableData

	for i, data in pairs(ResNewMazeFetters) do
		if data.type == label and data.level == 1 then
			fettersTableData = data

			break
		end
	end

	return fettersData, fettersTableData
end

function NewMazeShopHaloCard:onBtnExtendClick()
	self.btnExtend:setVisible(false)
	self.btnReduce:setVisible(true)

	self.comDescLayout.enabled = false
end

function NewMazeShopHaloCard:onBtnReduceClick()
	self.btnExtend:setVisible(true)
	self.btnReduce:setVisible(false)

	self.comDescLayout.enabled = true
	self.comDescLayout.preferredHeight = 128
end

return NewMazeShopHaloCard
