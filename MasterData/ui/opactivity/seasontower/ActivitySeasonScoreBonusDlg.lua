-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonTower\\ActivitySeasonScoreBonusDlg.lua

local strClassName = "ActivitySeasonScoreBonusDlg"
local ActivitySeasonScoreBonusDlg = Class(strClassName, UIControls.Window)

function ActivitySeasonScoreBonusDlg:ctor()
	self.textScore = UIControls.Label(self, "BgPanel/CodePanel/TxtNum")
end

function ActivitySeasonScoreBonusDlg:onShow(score)
	self.textScore:setText(score)
end

return ActivitySeasonScoreBonusDlg
