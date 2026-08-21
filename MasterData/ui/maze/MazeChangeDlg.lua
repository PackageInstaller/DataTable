-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Maze\\MazeChangeDlg.lua

local strClassName = "MazeChangeDlg"
local MazeChangeDlg = Class(strClassName, UIControls.Window)

function MazeChangeDlg:ctor(...)
	return
end

function MazeChangeDlg:show(...)
	self:refreshMazeData()

	local ui = UIManager.getUI("mazeMainDlg", nil, false)

	if ui then
		ui:changeLayer()
		ui:resetNewLayer()
		ui:show(true)
	end

	self.timer = Timer(Slot(self.outAni, self), 1, 1)

	self.timer:Start()
end

function MazeChangeDlg:outAni(...)
	self:setVisible(false)
end

function MazeChangeDlg:refreshMazeData(...)
	return
end

function MazeChangeDlg:destroy(...)
	MazeChangeDlg.super.destroy(self)

	if self.timer then
		self.timer:Stop()
	end
end

return MazeChangeDlg
