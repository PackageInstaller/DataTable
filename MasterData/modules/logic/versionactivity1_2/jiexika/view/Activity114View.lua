-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114View.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114View", package.seeall)

local Activity114View = class("Activity114View", BaseView)

function Activity114View:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg/#simage_rightbg")
	self._simagemirror = gohelper.findChildSingleImage(self.viewGO, "#simage_mirror")
	self._simagemirrorlight2 = gohelper.findChildSingleImage(self.viewGO, "#simage_mirrorlight2")
	self._simagespinemask = gohelper.findChildSingleImage(self.viewGO, "#simage_spinemask")
	self._simageframe = gohelper.findChildSingleImage(self.viewGO, "#simage_spinemask/#simage_frame")
	self._simagemirrorlight1 = gohelper.findChildSingleImage(self.viewGO, "#simage_mirrorlight1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114View:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg.png"))
	self._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg2.png"))
	self._simagemirror:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingzi.png"))
	self._simagespinemask:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("zz_jingzi.png"))
	self._simageframe:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingkuang.png"))
	self._simagemirrorlight2:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung2.png"))
	self._simagemirrorlight1:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung1.png"))

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Activity114View:addEvents()
	self.addEventCb(self, self.viewContainer, ViewEvent.ToSwitchTab, self.onTabChange, self)
end

function Activity114View:removeEvents()
	self.removeEventCb(self, self.viewContainer, ViewEvent.ToSwitchTab, self.onTabChange, self)
end

function Activity114View:onTabChange(tabId, tabIndex, preIndex)
	if tabId ~= 2 then
		return
	end

	if tabIndex == Activity114Enum.TabIndex.MainView then
		self._viewAnim:Play("start_open", 0, 0)

		self._lastOpenView = tabIndex
	elseif tabIndex == Activity114Enum.TabIndex.TaskView then
		self._viewAnim:Play("quest_open", 0, 0)

		self._lastOpenView = tabIndex
	elseif preIndex == Activity114Enum.TabIndex.MainView then
		self._viewAnim:Play("start_close", 0, 0)
	elseif preIndex == Activity114Enum.TabIndex.TaskView then
		self._viewAnim:Play("quest_close", 0, 0)
	else
		self._viewAnim:Play("open", 0, 0)
	end
end

function Activity114View:onOpenFinish()
	self._viewAnim.enabled = true
end

function Activity114View:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simagespinemask:UnLoadImage()
	self._simagemirror:UnLoadImage()
	self._simageframe:UnLoadImage()
	self._simagemirrorlight2:UnLoadImage()
	self._simagemirrorlight1:UnLoadImage()
end

return Activity114View
