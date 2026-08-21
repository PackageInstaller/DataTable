-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MiniGame\\MiniGamePlayDlg.lua

local strClassName = "MiniGamePlayDlg"
local MiniGamePlayDlg = Class(strClassName, UIControls.Window)

function MiniGamePlayDlg:ctor(...)
	self:initUI()
end

function MiniGamePlayDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnReset = UIControls.Button(self, "MainInfoPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.textLv = UIControls.Label(self, "MainInfoPanel/BgImg/TextLv")
	self.panelBg = UIControls.DragClickPanel(self, "DragBg")
end

function MiniGamePlayDlg:onOpen(...)
	MiniGamePlayDlg.super.onOpen(self)
end

function MiniGamePlayDlg:setData(type)
	self.type = type

	self.btnClose:setText(Const.MINI_GAME_INFO[self.type].name)

	local state = Const.MINI_GAME_INFO[self.type].state

	self.classCenter = require(Const.MINI_GAME_INFO[self.type].dragCenter)
	self.mainState = GameFsm.getState(state)

	self.mainState:setCurUI(self)
	self.classCenter.setMode(self)

	self.chapter, self.stage = CurAvatar:getChapterAndStage(type)

	self.textLv:setText(string.format("%d-%d", self.chapter, self.stage))
end

function MiniGamePlayDlg:onBtnResetClick()
	local function yesFunc()
		self.classCenter.resetLevel()
	end

	local msgContent = Lang.get(98720)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, nil, Lang.get(104), Lang.get(7))
end

function MiniGamePlayDlg:onBtnCloseClick()
	self.classCenter.leaveLevel()
	self:openInfoPanel()
	self:setVisible(false)
end

function MiniGamePlayDlg:openInfoPanel()
	self.mainState:checkMainDlg()
end

return MiniGamePlayDlg
