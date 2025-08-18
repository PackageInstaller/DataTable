-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\GraphicListMovieDlg.lua

local DragTwoPages = require("UI/Control/DragTwoPages")
local ResGraphicList = require("ClientData/ResGraphicList")
local GraphicMovieListPage = Class("GraphicMovieListPage", UIControls.Child)

function GraphicMovieListPage:ctor()
	self.bg = UIControls.RawImage(self, "BgImg")
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textContent = UIControls.Label(self, "Text")
	self.lazyEfx = UIControls.LazyEffectPlayer(self, "Efx")
	self.panelVideo = UIControls.Panel(self, "SetTeamVideoPlayer")
	self.videoPlayerCell = UIControls.LazyVideoPlayer(self, "SetTeamVideoPlayer", "System/PlayerGuide/SetTeamVideoPlayer", 0, 0, true)
end

function GraphicMovieListPage:onPageLeave()
	if self.playing then
		self.playing = false

		self.videoPlayerCell:pauseVideo()
	end
end

function GraphicMovieListPage:setData(graphicData)
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

	if graphicData.movie_path then
		self.playing = true

		self.panelVideo:setVisible(true)
		self.videoPlayerCell:playVideo(graphicData.movie_path, nil, false, false, false, true)
	else
		self.panelVideo:setVisible(false)

		if self.playing then
			self.playing = false

			self.videoPlayerCell:stopVideo()
		end
	end
end

local strClassName = "GraphicListMovieDlg"
local GraphicListMovieDlg = Class(strClassName, UIControls.Window)

function GraphicListMovieDlg:ctor()
	self:initUI()
end

function GraphicListMovieDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onCloseClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)

	local page1 = GraphicMovieListPage(self, "MainInfoPanel/Mask/ContentPanel1", "System/PlayerGuide/SetTeamContentPage")

	page1:setVisible(true)

	local page2 = GraphicMovieListPage(self, "MainInfoPanel/Mask/ContentPanel2", "System/PlayerGuide/SetTeamContentPage")

	page2:setVisible(true)

	self.pages = {
		page1,
		page2
	}
end

function GraphicListMovieDlg:onCloseClick()
	self:setVisible(false)

	if self.callBack then
		self.callBack()
	end
end

function GraphicListMovieDlg:startGraphicList(listId, callBack)
	self.closeEnable = false
	self.graphicData = ResGraphicList[listId]

	if self.graphicData then
		self.callBack = callBack

		self.dragPages:initPage(#self.graphicData, 1)
	elseif callBack then
		callBack()
	end
end

function GraphicListMovieDlg:onDragEvent(sender, currentPageIndex, panelIndex, isOnOpen)
	if currentPageIndex >= #self.graphicData then
		self.closeEnable = true
	end

	if self.currentPanelIndex and self.pages[self.currentPanelIndex] and self.currentPanelIndex ~= panelIndex then
		self.pages[self.currentPanelIndex]:onPageLeave()
	end

	self.currentPageIndex = currentPageIndex
	self.currentPanelIndex = panelIndex

	self.pages[panelIndex]:setData(self.graphicData[self.currentPageIndex])
	self.btnClose:setVisible(self.closeEnable)
end

return GraphicListMovieDlg
