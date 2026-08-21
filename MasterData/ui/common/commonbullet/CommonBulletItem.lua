-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\CommonBullet\\CommonBulletItem.lua

local strClassName = "CommonBulletItem"
local CommonBulletItem = Class(strClassName, UIControls.Child)
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local UIEmojiText = typeof(Framework.UI.UIEmojiText)
local UIUtils = require("Framework.UI.UIUtils")

function CommonBulletItem:ctor()
	self.itemPanel = UIControls.Panel(self, "")
	self.emojiLargePanel = UIControls.Panel(self, "BgTextLargeEmoji/TextLargeEmoji")
	self.tweenComponent = self.itemPanel:getGameObject():AddComponent(DOTweenComponent)
	self.contentText = UIControls.Panel(self, "BgText/Text"):getGameObject():GetComponent(UIEmojiText)
	self.largeEmojiText = UIControls.Panel(self, "BgTextLargeEmoji/TextLargeEmoji"):getGameObject():GetComponent(UIEmojiText)
	self.textOutlineImage = UIControls.Image(self, "BgText")
	self.emojiOutlineImage = UIControls.Image(self, "BgTextLargeEmoji")
end

function CommonBulletItem:setData(content, gap, duration, rowInfo, clickCallback, showCallback, moveCallback)
	self.clickCallback = clickCallback
	self.moveCallback = moveCallback

	local contentText = content.text
	local isLargeEmoji = utils.isLargeEmoji(contentText)
	local contentLen

	self.textOutlineImage:setVisible(not isLargeEmoji)
	self.emojiOutlineImage:setVisible(isLargeEmoji ~= nil)

	if isLargeEmoji then
		self.contentText.text = ""
		self.largeEmojiText.text = contentText
		contentLen = 40
	else
		self.contentText.text = contentText
		self.largeEmojiText.text = ""
		contentLen = utils.utf8len(contentText, 2) * 20
	end

	if content.isMainPlayer then
		self.textOutlineImage:setColorAlpha(255)
		self.emojiOutlineImage:setColorAlpha(255)
	else
		self.textOutlineImage:setColorAlpha(0)
		self.emojiOutlineImage:setColorAlpha(0)
	end

	contentLen = contentLen + gap

	local screenLen = UIUtils.GetCurDesignWidth()
	local allLen = screenLen + contentLen

	duration = duration * (allLen / screenLen)

	local dstPosY = rowInfo.posY

	self.itemPanel:setPosition(screenLen, dstPosY)

	local worldPosX = 0
	local worldPosY = self.itemPanel:getPosition().y
	local worldPosZ = self.itemPanel._obj.transform.localPosition.z
	local showTime = duration * (contentLen / allLen)
	local showEndPos = Vector3(worldPosX + screenLen - contentLen, worldPosY, worldPosZ)
	local moveTime = duration - showTime
	local moveEndValue = Vector3(worldPosX - contentLen, worldPosY, worldPosZ)

	self.showCallback = showCallback
	self.moveCallback = moveCallback

	self.tweenComponent:UITweenMoveFull(showEndPos, showTime, Functor(self._showCallback, self, moveEndValue, moveTime), 1, true)
end

function CommonBulletItem:_onBtnClick()
	if self.clickCallback then
		self.clickCallback()
	end
end

function CommonBulletItem:_showCallback(moveEndValue, moveTime)
	if self.showCallback then
		self.showCallback()
	end

	self.tweenComponent:UITweenMoveFull(moveEndValue, moveTime, self.moveCallback, 1, false)
end

function CommonBulletItem:stop()
	if self.tweenComponent and not tolua.isnull(self.tweenComponent) then
		self.tweenComponent:KillTween()
	end
end

return CommonBulletItem
