-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleStartMultiDlg.lua

local strClassName = "BattleStartMultiDlg"
local BattleStartMultiDlg = Class(strClassName, UIControls.Window)

function BattleStartMultiDlg:ctor()
	self.imgRound = UIControls.Image(self, "BgPanel/ImgRoundNum")
end

function BattleStartMultiDlg:setRound(round)
	self.imgRound:setImage("Atlas/BattleAtlas/BattleEnterAtlas3", "Bg" .. round)
end

return BattleStartMultiDlg
