-- chunkname: @modules/logic/handbook/view/HandbookView.lua

module("modules.logic.handbook.view.HandbookView", package.seeall)

local HandbookView = class("HandbookView", BaseView)

function HandbookView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btncharacter = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_character")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_equip")
	self._btnstory = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_story")
	self._btnweekWalk = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_weekWalk")
	self._goSkin = gohelper.findChild(self.viewGO, "skin")
	self._goSkinRedDot = gohelper.findChild(self.viewGO, "skin/#goRedDot")
	self._btnskin = gohelper.findChildButtonWithAudio(self.viewGO, "btns/#btn_skin")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookView:addEvents()
	self._btncharacter:AddClickListener(self._btncharacterOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnstory:AddClickListener(self._btnstoryOnClick, self)
	self._btnweekWalk:AddClickListener(self._btnweekWalkOnClick, self)
	self._btnskin:AddClickListener(self._btnskinOnClick, self)
	self.addEventCb(self, HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, self.refreshRedDot, self)
end

function HandbookView:removeEvents()
	self._btncharacter:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._btnstory:RemoveClickListener()
	self._btnweekWalk:RemoveClickListener()
	self._btnskin:RemoveClickListener()
end

function HandbookView:_btnweekWalkOnClick()
	HandbookController.instance:openHandbookWeekWalkMapView()
end

function HandbookView:_btncharacterOnClick()
	HandbookController.instance:openCharacterView()
end

function HandbookView:_btnequipOnClick()
	HandbookController.instance:openEquipView()
end

function HandbookView:_btnstoryOnClick()
	HandbookController.instance:openStoryView()
end

function HandbookView:_btnskinOnClick()
	HandbookController.instance:openHandbookSkinView()
end

function HandbookView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg"))
	gohelper.setActive(self._btnweekWalk.gameObject, false)

	self._skinNewRedDot = RedDotController.instance:addNotEventRedDot(self._goSkinRedDot)

	self._skinNewRedDot:setShowType(RedDotEnum.Style.Green)
	self._skinNewRedDot:setCheckShowRedDotFunc(self.checkHandBookRedDot, self)
	self._skinNewRedDot:refreshRedDot()
end

function HandbookView:onOpen()
	gohelper.addUIClickAudio(self._btncharacter.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(self._btnstory.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(self._btnequip.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)
	gohelper.addUIClickAudio(self._btnskin.gameObject, AudioEnum.UI.play_ui_screenplay_photo_open)

	local isReview = VersionValidator.instance:isInReviewing()

	gohelper.setActive(self._goSkin, not isReview)
	gohelper.setActive(self._btnskin.gameObject, not isReview)
	self:refreshRedDot()
end

function HandbookView:refreshRedDot()
	local hasRedDot = HandbookController.instance:hasAnyHandBookSkinGroupRedDot()

	gohelper.setActive(self._goSkinRedDot, hasRedDot)
end

function HandbookView:checkHandBookRedDot()
	return true
end

function HandbookView:onClose()
	return
end

function HandbookView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return HandbookView
