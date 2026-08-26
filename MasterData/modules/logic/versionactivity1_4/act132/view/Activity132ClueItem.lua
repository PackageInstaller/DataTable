-- chunkname: @modules/logic/versionactivity1_4/act132/view/Activity132ClueItem.lua

module("modules.logic.versionactivity1_4.act132.view.Activity132ClueItem", package.seeall)

local Activity132ClueItem = class("Activity132ClueItem", UserDataDispose)

function Activity132ClueItem:ctor(go, index)
	self:__onInit()

	self.index = index
	self._viewGO = go
	self._goRoot = gohelper.findChild(go, "root")
	self._maskGO = gohelper.findChild(self._goRoot, "mask")
	self._mask = self._maskGO:GetComponent(typeof(Coffee.UISoftMask.SoftMask))
	self._txtNode = gohelper.findChildTextMesh(self._goRoot, "#txt_note")
	self._goReddot = gohelper.findChild(self._goRoot, "#go_reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self._goRoot, "btn_click")
	self._rect = go.transform
	self._redDot = RedDotController.instance:addRedDot(self._goReddot, 1081, nil, self.refreshRed, self)

	self.addClickCb(self, self._btnClick, self.onClickBtn, self)
	self.addEventCb(self, Activity132Controller.instance, Activity132Event.OnContentUnlock, self.onRefreshRed, self)
end

function Activity132ClueItem:refreshRed()
	if not self.data then
		return
	end

	self._redDot.show = Activity132Model.instance:checkClueRed(self.data.activityId, self.data.clueId)

	self._redDot:showRedDot(1)
end

function Activity132ClueItem:onClickBtn()
	if not self.data then
		return
	end

	Activity132Controller.instance:dispatchEvent(Activity132Event.OnForceClueItem, self.index)
end

function Activity132ClueItem:resetMask()
	local offsetX = 0
	local offsetY = 0

	gohelper.addChild(self._goRoot, self._maskGO)
	gohelper.setAsFirstSibling(self._maskGO)
	recthelper.setAnchor(self._maskGO.transform, offsetX, offsetY)
	transformhelper.setLocalScale(self._maskGO.transform, 2, 2, 2)
end

function Activity132ClueItem:setData(data)
	self.data = data

	self:resetMask()

	if not data then
		self:setActive(false)

		return
	end

	self:setActive(false)
	self:setActive(true)

	self._txtNode.text = self.data.name

	local posX, posY = self.data:getPos()

	recthelper.setAnchor(self._rect, posX, posY)

	self.posX, self.posY, self.posZ = transformhelper.getPos(self._rect)

	self._redDot:refreshDot()

	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	self._fadeTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.34, self.fadeUpdateCallback, nil, self)
end

function Activity132ClueItem:fadeUpdateCallback(val)
	self._mask.alpha = val
end

function Activity132ClueItem:onRefreshRed()
	if not self.data then
		return
	end

	self._redDot:refreshDot()
end

function Activity132ClueItem:setActive(isVisible)
	if self.isVisible == isVisible then
		return
	end

	self.isVisible = isVisible

	gohelper.setActive(self._maskGO, isVisible)
	gohelper.setActive(self._viewGO, isVisible)
end

function Activity132ClueItem:setRootVisible(isVisible)
	gohelper.setActive(self._goRoot, isVisible)
end

function Activity132ClueItem:destroy()
	if self._fadeTweenId then
		ZProj.TweenHelper.KillById(self._fadeTweenId)

		self._fadeTweenId = nil
	end

	gohelper.destroy(self._viewGO)
	self:__onDispose()
end

function Activity132ClueItem:getMask()
	return self._maskGO
end

function Activity132ClueItem:getPos()
	return self.posX, self.posY, self.posZ
end

function Activity132ClueItem:getRealPos()
	return transformhelper.getPos(self._rect)
end

return Activity132ClueItem
