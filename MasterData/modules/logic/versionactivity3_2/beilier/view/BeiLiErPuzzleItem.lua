-- chunkname: @modules/logic/versionactivity3_2/beilier/view/BeiLiErPuzzleItem.lua

module("modules.logic.versionactivity3_2.beilier.view.BeiLiErPuzzleItem", package.seeall)

local BeiLiErPuzzleItem = class("BeiLiErPuzzleItem", ListScrollCellExtend)

function BeiLiErPuzzleItem:init(go)
	self.go = go
	self._tr = go.transform

	self:initPos(0, 0)
	self:initRotation(BeiLiErEnum.Rotation[4])

	self._simagebg = gohelper.findChildSingleImage(go, "image")
	self._imagebg = gohelper.findChildImage(go, "image")
	self._simagebglight = gohelper.findChildSingleImage(go, "image_light")
	self._imagebglight = gohelper.findChildImage(go, "image_light")
	self._simagefocusbg = gohelper.findChildSingleImage(go, "image_frameorange")
	self._imagefocusbg = gohelper.findChildImage(go, "image_frameorange")
	self._simagelaybg = gohelper.findChildSingleImage(go, "image_framewhite")
	self._imagelaybg = gohelper.findChildImage(go, "image_framewhite")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._rotationTime = 0.2

	gohelper.setActive(go, true)
end

function BeiLiErPuzzleItem:addEventListeners()
	return
end

function BeiLiErPuzzleItem:removeEventListeners()
	return
end

function BeiLiErPuzzleItem:tweenRotation(rotation)
	self._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(self._tr, 0, 0, BeiLiErEnum.Rotation[rotation], self._rotationTime, self._afterRotation, self, nil, EaseType.Linear)
end

function BeiLiErPuzzleItem:onClick()
	if self._rotationTweenId or self._isDrag or self._mo:checkIsCorrect() then
		return
	end

	local fakeRotation = self._mo:getClickPuzzle()

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	self:tweenRotation(fakeRotation)
end

function BeiLiErPuzzleItem:cleanTween()
	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)

		self._rotationTweenId = nil
	end
end

function BeiLiErPuzzleItem:_afterRotation()
	local rotation = self._mo:getClickPuzzle()

	self._mo:setRotation(rotation)
	self:cleanTween()
end

function BeiLiErPuzzleItem:_beginDrag(_, pointerEventData)
	if self._mo:checkIsCorrect() then
		return
	end

	self._isDrag = true

	local position = pointerEventData.position

	gohelper.setAsLastSibling(self.go)
	gohelper.setActive(self._simagefocusbg.gameObject, false)
	gohelper.setActive(self._simagelaybg.gameObject, true)
	self._beginDragCb(self._beginDragCbObj, {
		id = self.id,
		position = position
	})
end

function BeiLiErPuzzleItem:_onDrag(_, pointerEventData)
	local position = pointerEventData.position

	self._dragCb(self._dragCbObj, {
		id = self.id,
		position = position
	})
end

function BeiLiErPuzzleItem:_endDrag(_, pointerEventData)
	self._isDrag = false

	local position = pointerEventData.position

	self._endDragCb(self._endDragCbObj, {
		id = self.id,
		position = position
	})
end

function BeiLiErPuzzleItem:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function BeiLiErPuzzleItem:initRotation(rotation)
	transformhelper.setLocalRotation(self._tr, 0, 0, rotation)
end

function BeiLiErPuzzleItem:getLocalPos()
	return self._localPosX, self._localPosY
end

function BeiLiErPuzzleItem:initInfo(mo)
	if not mo then
		return
	end

	self._mo = mo
	self.id = mo.id
	self.config = BeiLiErConfig.instance:getPuzzleConfigById(self.id)
	self.type = mo.type

	self._simagebg:LoadImage(ResUrl.getBeilierIcon(self.config.img), self._loadedImageBg, self)
	self._simagebglight:LoadImage(ResUrl.getBeilierIcon(self.config.img), self._loadedImageBgLight, self)
	self._simagefocusbg:LoadImage(ResUrl.getBeilierIcon(self.config.img .. "_1"), self._loadedImageFocusBg, self)
	self._simagelaybg:LoadImage(ResUrl.getBeilierIcon(self.config.img .. "_2"), self._loadedImageLayBg, self)
	gohelper.setActive(self._simagefocusbg.gameObject, false)
	gohelper.setActive(self._simagelaybg.gameObject, true)
	self:updatePos()
	self:playLoopAnim()
	gohelper.setActive(self.go, true)

	if self.type == BeiLiErEnum.PuzzleType.OutCrystal then
		CommonDragHelper.instance:registerDragObj(self.go, self._beginDrag, self._onDrag, self._endDrag, nil, self, nil, true)

		self._click = gohelper.getClickWithDefaultAudio(self.go)

		self._click:AddClickListener(self.onClick, self)
	end
end

function BeiLiErPuzzleItem:_loadedImageBg()
	self._imagebg:SetNativeSize()
end

function BeiLiErPuzzleItem:_loadedImageBgLight()
	self._imagebglight:SetNativeSize()
end

function BeiLiErPuzzleItem:_loadedImageFocusBg()
	self._imagefocusbg:SetNativeSize()
end

function BeiLiErPuzzleItem:_loadedImageLayBg()
	self._imagelaybg:SetNativeSize()
end

function BeiLiErPuzzleItem:updatePos()
	self.posX = self._mo.posX
	self.posY = self._mo.posY
	self.rotation = self._mo.rotation

	self:initPos(self.posX, self.posY)
	self:initRotation(BeiLiErEnum.Rotation[self.rotation])
end

function BeiLiErPuzzleItem:updateInfo(mo)
	if not mo then
		return
	end

	self._mo = mo

	self:updatePos()
	self:updateUI()
end

function BeiLiErPuzzleItem:updateUI()
	return
end

function BeiLiErPuzzleItem:clearPuzzle()
	self.id = 0
	self._mo = nil
	self.typeId = 1
	self.posX = 0
	self.posY = 0

	self:initPos(self.posX, self.posY)
	gohelper.setActive(self.go, false)
	self:clearBgState()
end

function BeiLiErPuzzleItem:checkPuzzleId(id)
	return id == self.id
end

function BeiLiErPuzzleItem:registerBeginDrag(cb, cbObj)
	self._beginDragCb = cb
	self._beginDragCbObj = cbObj
end

function BeiLiErPuzzleItem:registerDrag(cb, cbObj)
	self._dragCb = cb
	self._dragCbObj = cbObj
end

function BeiLiErPuzzleItem:registerEndDrag(cb, cbObj)
	self._endDragCb = cb
	self._endDragCbObj = cbObj
end

function BeiLiErPuzzleItem:hideBg()
	gohelper.setActive(self._simagebg.gameObject, false)
end

function BeiLiErPuzzleItem:showOrangeBg()
	gohelper.setActive(self._simagefocusbg.gameObject, true)
end

function BeiLiErPuzzleItem:showWhiteBg()
	gohelper.setActive(self._simagelaybg.gameObject, true)
end

function BeiLiErPuzzleItem:clearBgState()
	gohelper.setActive(self._simagefocusbg.gameObject, false)
	gohelper.setActive(self._simagelaybg.gameObject, false)
end

function BeiLiErPuzzleItem:playCorrectAnim()
	self._anim:Play("get", 0, 0)
end

function BeiLiErPuzzleItem:playIdleAnim()
	self._anim:Play("idle", 0, 0)
end

function BeiLiErPuzzleItem:playLoopAnim()
	self._anim:Play("loop", 0, 0)
end

function BeiLiErPuzzleItem:onDestroy()
	self:clearPuzzle()
	self:cleanTween()
	CommonDragHelper.instance:unregisterDragObj(self.go)

	if self._click then
		self._click:RemoveClickListener()
	end
end

return BeiLiErPuzzleItem
