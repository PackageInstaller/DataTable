-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\GameAssistantNoticeDlg.lua

local ResGameAssistant = require("ClientData/ResGameAssistant")
local ResGameAssistantPush = require("ClientData/ResGameAssistantPush")
local strClassName = "GameAssistantNoticeDlg"
local GameAssistantNoticeDlg = Class(strClassName, UIControls.Window)

function GameAssistantNoticeDlg:ctor()
	self:initUI()
end

function GameAssistantNoticeDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textDesc = UIControls.Label(self, "NoticePanel/TextDesc")
	self.btnMore = UIControls.Button(self, "NoticePanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)
end

function GameAssistantNoticeDlg:setData(pushData)
	self.pushData = pushData
	self.assistId = self.pushData.assist_id

	self.textDesc:setText(self.pushData.push_text)
end

function GameAssistantNoticeDlg:onBtnMoreClick()
	UIManager.getUI("gameAssistantMainDlg", true):setData()
	self:setVisible(false)
end

function GameAssistantNoticeDlg:onBtnCloseClick()
	self:setVisible(false)
end

return GameAssistantNoticeDlg
