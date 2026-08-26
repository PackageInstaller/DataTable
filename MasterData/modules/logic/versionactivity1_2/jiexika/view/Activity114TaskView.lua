-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114TaskView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskView", package.seeall)

local Activity114TaskView = class("Activity114TaskView", BaseView)

function Activity114TaskView:onInitView()
	self._simagetxtbg = gohelper.findChildSingleImage(self.viewGO, "#go_info/#simage_txtbg")
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114TaskView:addEvents()
	return
end

function Activity114TaskView:removeEvents()
	return
end

function Activity114TaskView:_editableInitView()
	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromView
	scrollParam.prefabUrl = "#scroll/item"
	scrollParam.cellClass = Activity114TaskItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirV
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 1150
	scrollParam.cellHeight = 168
	scrollParam.cellSpaceH = 0
	scrollParam.cellSpaceV = 10.5
	scrollParam.startSpace = 5
	scrollParam.frameUpdateMs = 100

	local itemAnimDelayTimes = {}

	for i = 1, 6 do
		itemAnimDelayTimes[i] = i * 0.06
	end

	self._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(self.viewGO, "#scroll"))
	self._scrollView = LuaListScrollViewWithAnimator.New(Activity114TaskModel.instance, scrollParam, itemAnimDelayTimes)

	self:addChildView(self._scrollView)
	self._simagetxtbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_heidi.png"))
end

function Activity114TaskView:onOpen()
	self._csListView.VerticalScrollPixel = 0

	self._viewAnim:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function Activity114TaskView:onOpenFinish()
	self._viewAnim.enabled = true
end

function Activity114TaskView:onClose()
	self._viewAnim:Play("close", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_close)
end

function Activity114TaskView:onDestroyView()
	self._simagetxtbg:UnLoadImage()
end

return Activity114TaskView
