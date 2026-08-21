-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\MainStageTitleBox.lua

local ResStage = require("ClientData/ResStage")
local ResMainBattleChapter = require("ClientData/ResMainBattleChapter")
local strClassName = "MainStageTitleBox"
local MainStageTitleBox = Class(strClassName, UIControls.Window)

function MainStageTitleBox:ctor()
	self:initUI()
end

function MainStageTitleBox:initUI()
	self.textChapter = UIControls.Label(self, "BgPanel/TextChapterName")
	self.textLevel = UIControls.Label(self, "BgPanel/TextLvName")
	self.textNum = UIControls.Label(self, "BgPanel/TextNum")
end

function MainStageTitleBox:onShow(stageData)
	local season = stageData[1]
	local chaper = stageData[2]
	local level = stageData[3]

	self.textNum:setText(chaper .. "-" .. level)

	if ResMainBattleChapter[season] and ResMainBattleChapter[season][chaper] then
		self.textChapter:setText(ResMainBattleChapter[season][chaper].name or "")
	end

	if ResStage[season] and ResStage[season][chaper] and ResStage[season][chaper][level] then
		self.textLevel:setText(ResStage[season][chaper][level].name or "")
	end
end

return MainStageTitleBox
