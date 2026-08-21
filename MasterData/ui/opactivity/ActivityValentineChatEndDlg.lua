-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityValentineChatEndDlg.lua

local strClassName = "ValentineChatEndDlg"
local ValentineChatEndDlg = Class(strClassName, UIControls.Window)

function ValentineChatEndDlg:ctor()
	self:initUI()
end

function ValentineChatEndDlg:initUI()
	self.bgCook = UIControls.Image(self, "BgCook")
	self.textTitle = UIControls.Label(self, "Text")
end

function ValentineChatEndDlg:setChatEndData(path, name, title)
	self.bgCook:setImage(path, name)
	self.textTitle:setText(title)
end

return ValentineChatEndDlg
