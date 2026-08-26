-- chunkname: @modules/logic/versionactivity3_5/lorentz/view/LorentzPuzzleItem.lua

module("modules.logic.versionactivity3_5.lorentz.view.LorentzPuzzleItem", package.seeall)

local LorentzPuzzleItem = class("LorentzPuzzleItem", ListScrollCellExtend)

function LorentzPuzzleItem:init(go)
	self.go = go
	self._tr = go.transform

	self:initPos(0, 0)
	self:initRotation(LorentzEnum.Rotation[4])

	self._simagebg = gohelper.findChildSingleImage(go, "image")
	self._imagebg = gohelper.findChildImage(go, "image")
	self._simagebglight = gohelper.findChildSingleImage(go, "image_light")
	self._imagebglight = gohelper.findChildImage(go, "image_light")
	self._simagefocusbg = gohelper.findChildSingleImage(go, "image_glow")
	self._imagefocusbg = gohelper.findChildImage(go, "image_glow")
	self._anim = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._rotationTime = 0.2

	gohelper.setActive(go, true)
end

function LorentzPuzzleItem:addEventListeners()
	return
end

function LorentzPuzzleItem:removeEventListeners()
	return
end

function LorentzPuzzleItem:tweenRotation(rotation)
	self._rotationTweenId = ZProj.TweenHelper.DOLocalRotate(self._tr, 0, 0, LorentzEnum.Rotation[rotation], self._rotationTime, self._afterRotation, self, nil, EaseType.Linear)
end

function LorentzPuzzleItem:onClick()
	if self._rotationTweenId or self._isDrag or self._mo:checkIsCorrect() then
		return
	end

	local fakeRotation = self._mo:getClickPuzzle()

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_gone)
	self:tweenRotation(fakeRotation)
end

function LorentzPuzzleItem:cleanTween()
	if self._rotationTweenId then
		ZProj.TweenHelper.KillById(self._rotationTweenId)

		self._rotationTweenId = nil
	end
end

function LorentzPuzzleItem:_afterRotation()
	local rotation = self._mo:getClickPuzzle()

	self._mo:setRotation(rotation)
	self:cleanTween()
end

function LorentzPuzzleItem:_beginDrag(_, pointerEventData)
	if self._mo:checkIsCorrect() then
		return
	end

	self._isDrag = true

	local position = pointerEventData.position

	gohelper.setAsLastSibling(self.go)
	self._beginDragCb(self._beginDragCbObj, {
		id = self.id,
		position = position
	})
end

function LorentzPuzzleItem:_onDrag(_, pointerEventData)
	local position = pointerEventData.position

	self._dragCb(self._dragCbObj, {
		id = self.id,
		position = position
	})
end

function LorentzPuzzleItem:_endDrag(_, pointerEventData)
	self._isDrag = false

	local position = pointerEventData.position

	self._endDragCb(self._endDragCbObj, {
		id = self.id,
		position = position
	})
end

function LorentzPuzzleItem:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function LorentzPuzzleItem:initRotation(rotation)
	transformhelper.setLocalRotation(self._tr, 0, 0, rotation)
end

function LorentzPuzzleItem:getLocalPos()
	return self._localPosX, self._localPosY
end

function LorentzPuzzleItem:initInfo(mo)
	if not mo then
		return
	end

	self._mo = mo
	self.id = mo.id
	self.config = LorentzConfig.instance:getPuzzleConfigById(self.id)
	self.type = mo.type

	self._simagebg:LoadImage(ResUrl.getLorentzIcon(self.config.img), self._loadedImageBg, self)
	self._simagebglight:LoadImage(ResUrl.getLorentzIcon(self.config.img), self._loadedImageBgLight, self)
	self._simagefocusbg:LoadImage(ResUrl.getLorentzIcon(self.config.img), self._loadedImageFocusBg, self)
	self:updatePos()
	self:playLoopAnim()
	gohelper.setActive(self.go, true)

	if self.type == LorentzEnum.PuzzleType.OutCrystal then
		CommonDragHelper.instance:registerDragObj(self.go, self._beginDrag, self._onDrag, self._endDrag, nil, self, nil, true)
	end
end

function LorentzPuzzleItem:_loadedImageBg()
	self._imagebg:SetNativeSize()
end

function LorentzPuzzleItem:_loadedImageBgLight()
	self._imagebglight:SetNativeSize()
end

function LorentzPuzzleItem:_loadedImageFocusBg()
	self._imagefocusbg:SetNativeSize()
end

function LorentzPuzzleItem:_loadedImageLayBg()
	self._imagelaybg:SetNativeSize()
end

function LorentzPuzzleItem:updatePos()
	self.posX = self._mo.posX
	self.posY = self._mo.posY
	self.rotation = self._mo.rotation

	self:initPos(self.posX, self.posY)
	self:initRotation(LorentzEnum.Rotation[self.rotation])
end

function LorentzPuzzleItem:updateInfo(mo)
	if not mo then
		return
	end

	self._mo = mo

	self:updatePos()
	self:updateUI()
end

function LorentzPuzzleItem:updateUI()
	return
end

function LorentzPuzzleItem:clearPuzzle()
	self.id = 0
	self._mo = nil
	self.typeId = 1
	self.posX = 0
	self.posY = 0

	self:initPos(self.posX, self.posY)
	gohelper.setActive(self.go, false)
	self:clearBgState()
end

function LorentzPuzzleItem:checkPuzzleId(id)
	return id == self.id
end

function LorentzPuzzleItem:registerBeginDrag(cb, cbObj)
	self._beginDragCb = cb
	self._beginDragCbObj = cbObj
end

function LorentzPuzzleItem:registerDrag(cb, cbObj)
	self._dragCb = cb
	self._dragCbObj = cbObj
end

function LorentzPuzzleItem:registerEndDrag(cb, cbObj)
	self._endDragCb = cb
	self._endDragCbObj = cbObj
end

function LorentzPuzzleItem:hideBg()
	gohelper.setActive(self._simagebg.gameObject, false)
end

function LorentzPuzzleItem:showOrangeBg()
	return
end

function LorentzPuzzleItem:showWhiteBg()
	return
end

function LorentzPuzzleItem:clearBgState()
	return
end

function LorentzPuzzleItem:playCorrectAnim()
	self._anim:Play("get", 0, 0)
end

function LorentzPuzzleItem:playIdleAnim()
	self._anim:Play("idle", 0, 0)
end

function LorentzPuzzleItem:playLoopAnim()
	self._anim:Play("loop", 0, 0)
end

function LorentzPuzzleItem:onDestroy()
	self:clearPuzzle()
	self:cleanTween()
	CommonDragHelper.instance:unregisterDragObj(self.go)
end

return LorentzPuzzleItem
