-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/wushenshou/view/WuShenPrePareViewPresentor.lua

module("logic.extensions.wushenshou.view.WuShenPrePareViewPresentor", package.seeall)

local WuShenPrePareViewPresentor = class("WuShenPrePareViewPresentor", MissionViewPresentor)

WuShenPrePareViewPresentor.BAIHU_MIDDLE_PREFAB = "ui/views/challenge/choose/spmissionview/baihumiddleview.prefab"

function WuShenPrePareViewPresentor:ctor()
	WuShenPrePareViewPresentor.super.ctor(self)
end

function WuShenPrePareViewPresentor:dependWhatResources()
	return {
		"ui/views/challenge/missionview.prefab",
		self:_addCommonRes()
	}
end

function WuShenPrePareViewPresentor:buildViews()
	local views = {}
	local wushenType = self:getFirstParam()

	table.insert(views, WuShenPrePareView.New())
	table.insert(views, WuShenRightView.New())
	table.insert(views, WuShenFormationLeftView.New())
	table.insert(views, WuShenPreWuShenPreFmtView.New())

	return views
end

return WuShenPrePareViewPresentor
