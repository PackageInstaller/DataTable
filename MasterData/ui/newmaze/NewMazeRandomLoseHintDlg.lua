-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRandomLoseHintDlg.lua

local strClassName = "NewMazeRandomLoseHintDlg"
local NewMazeRandomLoseHintDlg = Class(strClassName, UIControls.Window)

function NewMazeRandomLoseHintDlg:ctor(...)
	self:initUI()
end

function NewMazeRandomLoseHintDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)
end

function NewMazeRandomLoseHintDlg:setData(items)
	self.items = items
end

function NewMazeRandomLoseHintDlg:_onAniFinish()
	self:setVisible(false)

	local loseDlg = UIManager.getUI("newMazeRandomLoseDlg", true)

	loseDlg:setData(self.items)
end

return NewMazeRandomLoseHintDlg
