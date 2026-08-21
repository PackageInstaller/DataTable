-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeRandomWinHintDlg.lua

local strClassName = "NewMazeRandomWinHintDlg"
local NewMazeRandomWinHintDlg = Class(strClassName, UIControls.Window)

function NewMazeRandomWinHintDlg:ctor(...)
	self:initUI()
end

function NewMazeRandomWinHintDlg:initUI()
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self._onAniFinish)
end

function NewMazeRandomWinHintDlg:setData(items, isTreasure)
	self.items = items
	self.isTreasure = isTreasure
end

function NewMazeRandomWinHintDlg:_onAniFinish()
	self:setVisible(false)

	if self.isTreasure then
		local chooseThreeDlg = UIManager.getUI("newMazeChooseThreeDlg", true)

		chooseThreeDlg:setData(self.items)
	else
		local winDlg = UIManager.getUI("newMazeRandomWinDlg", true)

		winDlg:setData(self.items)
	end
end

return NewMazeRandomWinHintDlg
