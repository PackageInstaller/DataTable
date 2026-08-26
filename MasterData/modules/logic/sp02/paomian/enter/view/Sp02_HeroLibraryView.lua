-- chunkname: @modules/logic/sp02/paomian/enter/view/Sp02_HeroLibraryView.lua

module("modules.logic.sp02.paomian.enter.view.Sp02_HeroLibraryView", package.seeall)

local Sp02_HeroLibraryView = class("Sp02_HeroLibraryView", BaseView)

function Sp02_HeroLibraryView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._simageHeadIcon = gohelper.findChildSingleImage(self.viewGO, "root/daily/#simage_headicon")
	self._simageHeadIcon2 = gohelper.findChildSingleImage(self.viewGO, "root/daily/#simage_headicon2")
	self._txtName = gohelper.findChildText(self.viewGO, "root/daily/#txt_name")
	self._txtDesc = gohelper.findChildText(self.viewGO, "root/daily/scroll_desc/viewport/#txt_desc")
	self._txtPage = gohelper.findChildText(self.viewGO, "root/daily/#txt_papernum")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Right")
	self._goActiveRight = gohelper.findChild(self.viewGO, "root/#btn_Right/#go_ActiveRight")
	self._goDisactiveRight = gohelper.findChild(self.viewGO, "root/#btn_Right/#go_DisactiveRight")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Left")
	self._goActiveLeft = gohelper.findChild(self.viewGO, "root/#btn_Left/#go_ActiveLeft")
	self._goDisactiveLeft = gohelper.findChild(self.viewGO, "root/#btn_Left/#go_DisactiveLeft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Sp02_HeroLibraryView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function Sp02_HeroLibraryView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()
end

function Sp02_HeroLibraryView:_btnCloseOnClick()
	self:closeThis()
end

function Sp02_HeroLibraryView:_btnLeftOnClick()
	if self._selectIndex <= 1 or self._isSwitching then
		return
	end

	self._isSwitching = true
	self._isSwitchNext = false

	self._viewAnimator:Play("left", self._onPlaySwitchAinmDone, self)
end

function Sp02_HeroLibraryView:_btnRightOnClick()
	if self._selectIndex >= self._heroNum or self._isSwitching then
		return
	end

	self._isSwitching = true
	self._isSwitchNext = true

	self._viewAnimator:Play("right", self._onPlaySwitchAinmDone, self)
end

function Sp02_HeroLibraryView:_editableInitView()
	self._viewAnimator = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._animEventWrap = gohelper.onceAddComponent(self.viewGO, gohelper.Type_AnimationEventWrap)

	self._animEventWrap:AddEventListener("switch", self.startSwitchHero, self)
end

function Sp02_HeroLibraryView:onOpen()
	self._heroList = self.viewParam and self.viewParam.heroList
	self._heroList = self._heroList or {}
	self._heroNum = #self._heroList
	self._selectIndex = self.viewParam and self.viewParam.selectIndex
	self._selectIndex = self._selectIndex or 1

	self:refreshUI()
end

function Sp02_HeroLibraryView:refreshUI()
	self._selectHeroCo = self._heroList[self._selectIndex]

	if not self._selectHeroCo then
		return
	end

	self._txtName.text = self._selectHeroCo.name
	self._txtDesc.text = self._selectHeroCo.desc
	self._txtPage.text = string.format("%s/%s", self._selectIndex, self._heroNum)

	self._simageHeadIcon:LoadImage(ResUrl.getS02PaoMianSingleBg("hero/zm_" .. self._selectHeroCo.headIcon))
	self._simageHeadIcon2:LoadImage(ResUrl.getS02PaoMianSingleBg("hero/cm_" .. self._selectHeroCo.headIcon))
	self:refreshArrow()
end

function Sp02_HeroLibraryView:refreshArrow()
	gohelper.setActive(self._goActiveLeft, self._selectIndex > 1)
	gohelper.setActive(self._goDisactiveLeft, self._selectIndex <= 1)
	gohelper.setActive(self._goActiveRight, self._selectIndex < self._heroNum)
	gohelper.setActive(self._goDisactiveRight, self._selectIndex >= self._heroNum)
end

function Sp02_HeroLibraryView:switch(isNext)
	if isNext then
		if not (self._selectIndex + 1) then
			local nextIndex = self._selectIndex - 1

			if nextIndex <= 0 or nextIndex > self._heroNum then
				return
			end

			self._selectIndex = nextIndex

			self:refreshUI()
		end
	end
end

function Sp02_HeroLibraryView:startSwitchHero()
	self:switch(self._isSwitchNext)
end

function Sp02_HeroLibraryView:_onPlaySwitchAinmDone()
	self._isSwitching = false
end

function Sp02_HeroLibraryView:onClose()
	return
end

function Sp02_HeroLibraryView:onDestroyView()
	self._simageHeadIcon:UnLoadImage()
	self._simageHeadIcon2:UnLoadImage()
end

return Sp02_HeroLibraryView
