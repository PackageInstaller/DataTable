-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\GraphicListDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResGraphicList = require("ClientData/ResGraphicList")
local GraphicListPage = Class("GraphicListPage", UIControls.Child)

function GraphicListPage:ctor()
	self.bg = UIControls.RawImage(self, "BgImg")
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textContent = UIControls.Label(self, "Text")
	self.lazyEfx = UIControls.LazyEffectPlayer(self, "Efx")
end

function GraphicListPage:setData(graphicData)
	if graphicData.icon_path then
		self.bg:setImage(graphicData.icon_path)
	end

	self.textTitle:setText(graphicData.title or "")

	if graphicData.title_pos then
		self.textTitle:setPosition(graphicData.title_pos[1], graphicData.title_pos[2])
	end

	self.textContent:setText(graphicData.content or "")

	if graphicData.pos then
		self.textContent:setPosition(graphicData.pos[1], graphicData.pos[2])
	end

	if graphicData.effect_path then
		self.lazyEfx:playEffectByPath(graphicData.effect_path)
		self.lazyEfx:setVisible(true)
	else
		self.lazyEfx:setVisible(false)
	end
end

local strClassName = "GraphicListDlg"
local GraphicListDlg = Class(strClassName, UIControls.Window)

function GraphicListDlg:ctor()
	self:initUI()
end

function GraphicListDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)

	local page1 = GraphicListPage(self, "MainInfoPanel/Mask/ContentPanel1", "System/PlayerGuide/ContentPage")

	page1:setVisible(true)

	local page2 = GraphicListPage(self, "MainInfoPanel/Mask/ContentPanel2", "System/PlayerGuide/ContentPage")

	page2:setVisible(true)

	self.pages = {
		page1,
		page2
	}
end

function GraphicListDlg:onCloseClick()
	self:setVisible(false)

	if self.callBack then
		self.callBack()
	end
end

function GraphicListDlg:startGraphicList(listId, callBack)
	self.closeEnable = false
	self.graphicData = ResGraphicList[listId]

	if self.graphicData then
		self.callBack = callBack

		self.dragPages:initPage(#self.graphicData, 1)
	elseif callBack then
		callBack()
	end
end

function GraphicListDlg:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	if currentPageIndex >= #self.graphicData then
		self.closeEnable = true
	end

	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	self.pages[panelIndex]:setData(self.graphicData[self.currentPageIndex])
	self.btnClose:setVisible(self.closeEnable)
end

return GraphicListDlg
