-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114GetPhotoView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114GetPhotoView", package.seeall)

local Activity114GetPhotoView = class("Activity114GetPhotoView", BaseView)

function Activity114GetPhotoView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg2")
	self._simagebg3 = gohelper.findChildSingleImage(self.viewGO, "bg/#simage_bg3")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagephoto = gohelper.findChildSingleImage(self.viewGO, "#simage_photo")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self._txtnameen = gohelper.findChildTextMesh(self.viewGO, "#txt_name/#txt_nameen")
end

function Activity114GetPhotoView:addEvents()
	self._btnclose:AddClickListener(self.showNext, self)
end

function Activity114GetPhotoView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity114GetPhotoView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_reward_ending)

	self._index = 0

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	self._simagebg3:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/img_huode_bg.png"))
	self:showNext()
end

function Activity114GetPhotoView:onClose()
	self._simagebg1:UnLoadImage()
	self._simagebg3:UnLoadImage()
	self._simagephoto:UnLoadImage()
end

function Activity114GetPhotoView:showNext()
	self._index = self._index + 1

	if self._index > #Activity114Model.instance.newPhotos then
		Activity114Model.instance.newPhotos = {}

		self:closeThis()

		return
	end

	local photo = Activity114Model.instance.newPhotos[self._index]
	local photoCo = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)
	local co = photoCo[photo]

	self._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. photoCo[photo].bigCg .. ".png"))

	self._txtname.text = co.name
	self._txtnameen.text = co.nameEn
end

return Activity114GetPhotoView
