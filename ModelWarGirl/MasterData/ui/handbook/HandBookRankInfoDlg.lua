-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankInfoDlg.lua

local HandBookRankInfoPanel = require("UI/HandBook/HandBookRankInfoPanel")
local DragTwoPages = require("UI/Control/DragTwoPages")
local strClassName = "HandBookRankInfoDlg"
local HandBookRankInfoDlg = Class(strClassName, UIControls.Window)

function HandBookRankInfoDlg:ctor()
	self:initUI()
end

function HandBookRankInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.dragPages = DragTwoPages(self, "MainInfoPanel/Mask/ContentPanel1", "MainInfoPanel/Mask/ContentPanel2", "MainInfoPanel/BtnPre", "MainInfoPanel/BtnNext")
	self.dragPages.dragEvent = Slot(self.onDragEvent, self)
	self.pages = {}

	local pagePrefabPath = "System/HandBook/HandBookRankInfoPanel"

	for i = 1, 2 do
		self.pages[i] = HandBookRankInfoPanel(self, "MainInfoPanel/Mask/ContentPanel" .. i, pagePrefabPath, 0, 0, true)
	end
end

function HandBookRankInfoDlg:onBtnCloseClick()
	self:setVisible(false)
end

function HandBookRankInfoDlg:setData(btnPanelInfo, idx, playersInfo)
	self.btnPanelInfo = btnPanelInfo
	self.idx = idx
	self.playersInfo = playersInfo

	self.dragPages:initPage(#btnPanelInfo, self.idx)
end

function HandBookRankInfoDlg:refreshOnePlayer(rank, rankType)
	for idx, _ in ipairs(self.playersInfo) do
		if self.btnPanelInfo[idx].rankType == rankType then
			self.playersInfo[idx] = rank

			if self.curPage.data.rankType == rankType then
				self.curPage.contentPanel:setPlayerInfo(rank)
				self.curPage.contentPanel.playerHead.sensor:setEnable(rank.comm.uid ~= CurAvatar.uid)
			end
		end
	end
end

function HandBookRankInfoDlg:onDragEvent(sender, currentPageIndex, panelIndex)
	self.curPage = self.pages[panelIndex]

	self.curPage:setData(self.btnPanelInfo[currentPageIndex], self.playersInfo[currentPageIndex])
	self.btnClose:setText(self.btnPanelInfo[currentPageIndex].title)
end

return HandBookRankInfoDlg
