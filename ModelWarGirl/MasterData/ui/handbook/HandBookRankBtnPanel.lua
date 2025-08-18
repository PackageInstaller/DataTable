-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookRankBtnPanel.lua

local HandBookRankContentPanel = require("UI/HandBook/HandBookRankContentPanel")
local strClassName = "HandBookRankBtnPanel"
local HandBookRankBtnPanel = Class(strClassName, UIControls.Panel)

function HandBookRankBtnPanel:ctor()
	self:initUI()
end

function HandBookRankBtnPanel:initUI()
	self.btnSelf = UIControls.Button(self, self.mPath)

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.contentPanel = HandBookRankContentPanel(self, self.mPath .. "/Content")
	self.imgIconNew = UIControls.Image(self, self.mPath .. "/Content/IconNew")
end

function HandBookRankBtnPanel:onBtnSelfClick()
	local handBookRankInfoDlg = UIManager.getUI("handBookRankInfoDlg", true)

	handBookRankInfoDlg:setData(self.mParent.btnPanelInfo, self.idx, self.mParent.playersInfo)
end

function HandBookRankBtnPanel:setRankBtnPanelInfo(data, idx)
	self.data = data
	self.idx = idx

	self.contentPanel:setContentPanel(self.data)
end

return HandBookRankBtnPanel
