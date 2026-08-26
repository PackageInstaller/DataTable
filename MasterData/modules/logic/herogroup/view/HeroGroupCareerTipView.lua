-- chunkname: @modules/logic/herogroup/view/HeroGroupCareerTipView.lua

module("modules.logic.herogroup.view.HeroGroupCareerTipView", package.seeall)

local HeroGroupCareerTipView = class("HeroGroupCareerTipView", BaseView)

function HeroGroupCareerTipView:onInitView()
	self._btnmask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_mask")
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._imagecareer1 = gohelper.findChildImage(self.viewGO, "#go_bg/container/#image_career1")
	self._imagecareer2 = gohelper.findChildImage(self.viewGO, "#go_bg/container/#image_career2")
	self._imagecareer3 = gohelper.findChildImage(self.viewGO, "#go_bg/container/#image_career3")
	self._imagecareer4 = gohelper.findChildImage(self.viewGO, "#go_bg/container/#image_career4")
	self._imagecareer5 = gohelper.findChildImage(self.viewGO, "#go_bg/restrain2/#image_career5")
	self._imagecareer6 = gohelper.findChildImage(self.viewGO, "#go_bg/restrain2/#image_career6")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupCareerTipView:addEvents()
	self._btnmask:AddClickListener(self._btnmaskOnClick, self)
end

function HeroGroupCareerTipView:removeEvents()
	self._btnmask:RemoveClickListener()
end

function HeroGroupCareerTipView:_btnmaskOnClick()
	if self._closing then
		return
	end

	if not self._isGuide then
		self:closeThis()

		return
	end

	local containerName = "UIRoot/HUD/FightView/root/btnRestraintInfo"
	local container = gohelper.find(containerName)

	if not container then
		self:closeThis()

		return
	end

	self:_clearTween()

	self._closing = true

	local duration = 0.5
	local targetPos = recthelper.rectToRelativeAnchorPos(container.transform.position, self.viewGO.transform)

	self._anchorPosId = ZProj.TweenHelper.DOAnchorPos(self._gobg.transform, targetPos.x, targetPos.y, duration, function()
		gohelper.setActive(container, true)
		ViewMgr.instance:closeView(self.viewName, true)
	end, nil)

	local scale = 0.2

	self._scaleId = ZProj.TweenHelper.DOScale(self._gobg.transform, scale, scale, scale, duration)
end

function HeroGroupCareerTipView:_editableInitView()
	self._fightBlurMask = gohelper.findChild(self.viewGO, "#go_bg/uiblurmask_infightscene")
	self._normalBlurMask = gohelper.findChild(self.viewGO, "#go_bg/uiblurmask")
end

function HeroGroupCareerTipView:onUpdateParam()
	return
end

function HeroGroupCareerTipView:onOpen()
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer1, "lssx_1")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer2, "lssx_2")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer3, "lssx_3")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer4, "lssx_4")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer5, "lssx_5")
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer6, "lssx_6")
	self:_onGuide()

	local curScene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(self._fightBlurMask, curScene == SceneType.Fight)
	gohelper.setActive(self._normalBlurMask, curScene ~= SceneType.Fight)
end

function HeroGroupCareerTipView:_onGuide()
	if self.viewParam then
		self._isGuide = self.viewParam.isGuide
	end

	if not self._isGuide then
		return
	end

	recthelper.setAnchorX(self._gobg.transform, -220)
end

function HeroGroupCareerTipView:onClose()
	self:_clearTween()
end

function HeroGroupCareerTipView:_clearTween()
	if self._anchorPosId then
		ZProj.TweenHelper.KillById(self._anchorPosId)

		self._anchorPosId = nil
	end

	if self._scaleId then
		ZProj.TweenHelper.KillById(self._scaleId)

		self._scaleId = nil
	end
end

function HeroGroupCareerTipView:onDestroyView()
	return
end

return HeroGroupCareerTipView
