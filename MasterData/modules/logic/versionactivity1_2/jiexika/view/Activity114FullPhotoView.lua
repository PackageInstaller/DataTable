-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114FullPhotoView.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114FullPhotoView", package.seeall)

local Activity114FullPhotoView = class("Activity114FullPhotoView", BaseView)

function Activity114FullPhotoView:onInitView()
	self._simagephoto = gohelper.findChildSingleImage(self.viewGO, "#simage_photo")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_leftArrow")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_rightArrow")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "#txt_name")
	self._txtnameen = gohelper.findChildTextMesh(self.viewGO, "#txt_name/#txt_nameen")
	self._txtpage = gohelper.findChildTextMesh(self.viewGO, "#txt_page")
	self._goempty = gohelper.findChild(self.viewGO, "#simage_photo/#go_empty")
	self._animationEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._image = gohelper.findChildImage(self.viewGO, "#simage_photo")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity114FullPhotoView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnleft:AddClickListener(self.onLeftPhoto, self)
	self._btnright:AddClickListener(self.onRightPhoto, self)
	self._animationEventWrap:AddEventListener("switch", self.updatePhotoShow, self)
end

function Activity114FullPhotoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._animationEventWrap:RemoveAllEventListener()
end

function Activity114FullPhotoView:_editableInitView()
	return
end

function Activity114FullPhotoView:onOpen()
	self.nowShowIndex = self.viewParam

	self:updatePhotoShow()
end

function Activity114FullPhotoView:updatePhotoShow()
	self._animLock = nil

	local photoCo = Activity114Config.instance:getPhotoCoList(Activity114Model.instance.id)
	local co = photoCo[self.nowShowIndex]

	if Activity114Model.instance.unLockPhotoDict[self.nowShowIndex] then
		self._txtname.text = co.name
		self._txtnameen.text = co.nameEn

		gohelper.setActive(self._goempty, false)

		self._image.enabled = true

		self._simagephoto:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("photo/" .. photoCo[self.nowShowIndex].bigCg .. ".png"))
	else
		self._txtname.text = "？？？"
		self._txtnameen.text = ""

		gohelper.setActive(self._goempty, true)

		self._image.enabled = false
	end

	self._txtpage.text = co.desc
end

function Activity114FullPhotoView:onLeftPhoto()
	if self._animLock then
		return
	end

	self._animLock = true

	local index = self.nowShowIndex - 1

	if index <= 0 then
		index = 9
	end

	self.nowShowIndex = index

	self._anim:Play(UIAnimationName.Left, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function Activity114FullPhotoView:onRightPhoto()
	if self._animLock then
		return
	end

	self._animLock = true

	local index = self.nowShowIndex + 1

	if index > 9 then
		index = 1
	end

	self.nowShowIndex = index

	self._anim:Play(UIAnimationName.Right, 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function Activity114FullPhotoView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mail_close)
end

function Activity114FullPhotoView:onDestroyView()
	self._simagephoto:UnLoadImage()
end

return Activity114FullPhotoView
