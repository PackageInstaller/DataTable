-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Main\\SceneNoticeDlg.lua

local ResMainBattleChapter = require("ClientData/ResMainBattleChapter")
local SceneNoticeDlg = Class("SceneNoticeDlg", UIControls.Window)

function SceneNoticeDlg:ctor()
	self.textName = UIControls.Label(self, "BgPanel/BgName/TextName")
	self.textDesc = UIControls.Label(self, "BgPanel/BgInfo/TextInfo")
end

function SceneNoticeDlg:onOpen()
	SceneNoticeDlg.super.onOpen(self)

	local stageInfo = CurAvatar:getNowStageData()
	local stageData = ResMainBattleChapter[stageInfo.season] or {}

	stageData = stageData[stageInfo.chapter]

	if stageData then
		self.textName:setText(stageData.scene_name or "")
		self.textDesc:setText(stageData.scene_desc or "")
	end
end

return SceneNoticeDlg
