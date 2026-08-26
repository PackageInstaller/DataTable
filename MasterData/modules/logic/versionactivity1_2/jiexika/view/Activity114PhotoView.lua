-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114PhotoView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114PhotoView", package.seeall)

local Activity114PhotoView = class("Activity114PhotoView", BaseView)

function Activity114PhotoView:ctor(path)
	self._path = path
end

function Activity114PhotoView:onInitView()
	self.go = self.viewGO

	if self._path then
		self.go = gohelper.findChild(self.viewGO, self._path)
		self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")

		self._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/bg.png"))
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114PhotoView:addEvents()
	self.addEventCb(self, Activity114Controller.instance, Activity114Event.OnCGUpdate, self.updatePhotos, self)
end

function Activity114PhotoView:removeEvents()
	self.removeEventCb(self, Activity114Controller.instance, Activity114Event.OnCGUpdate, self.updatePhotos, self)
end

function Activity114PhotoView:_editableInitView()
	self._photos = self:getUserDataTb_()
	self._photosEmpty = self:getUserDataTb_()

	local photoCo = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)

	for i = 1, 9 do
		self._photos[i] = gohelper.findChildSingleImage(self.go, tostring(i))
		self._photosEmpty[i] = gohelper.findChild(self.go, "empty/" .. tostring(i))

		self._photos[i]:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. photoCo[i].bigCg .. ".png"))
		self.addClickCb(self, gohelper.findChildButtonWithAudio(self.go, "btn_click" .. i), self.clickPhoto, self, i)
	end

	self:updatePhotos()

	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.ActivityJieXiKaPhoto, 0) then
		Activity114Rpc.instance:markPhotoRed(Activity114Model.instance.id)
	end
end

function Activity114PhotoView:clickPhoto(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_role_open)
	ViewMgr.instance:openView(ViewName.Activity114FullPhotoView, index)
end

function Activity114PhotoView:updatePhotos()
	for i = 1, 9 do
		gohelper.setActive(self._photos[i].gameObject, Activity114Model.instance.unLockPhotoDict[i])
		gohelper.setActive(self._photosEmpty[i], not Activity114Model.instance.unLockPhotoDict[i])
	end
end

function Activity114PhotoView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_detailed_tabs_click)
end

function Activity114PhotoView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_checkpoint_Insight_close)
end

function Activity114PhotoView:onDestroyView()
	for i = 1, 9 do
		self._photos[i]:UnLoadImage()
	end

	if self._simagebg then
		self._simagebg:UnLoadImage()
	end
end

return Activity114PhotoView
