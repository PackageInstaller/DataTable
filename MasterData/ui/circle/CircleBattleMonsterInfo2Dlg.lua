-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleMonsterInfo2Dlg.lua

local CircleBattleMonsterInfo1Dlg = require("UI/Circle/CircleBattleMonsterInfo1Dlg")
local strClassName = "CircleBattleMonsterInfo2Dlg"
local CircleBattleMonsterInfo2Dlg = Class(strClassName, CircleBattleMonsterInfo1Dlg)

function CircleBattleMonsterInfo2Dlg:ctor(...)
	return
end

function CircleBattleMonsterInfo2Dlg:initUI(...)
	CircleBattleMonsterInfo2Dlg.super.initUI(self)

	self.txtDes = UIControls.Label(self, "BgPanel/TextDes")
end

function CircleBattleMonsterInfo2Dlg:initUIShow(...)
	CircleBattleMonsterInfo2Dlg.super.initUIShow(self)
end

return CircleBattleMonsterInfo2Dlg
