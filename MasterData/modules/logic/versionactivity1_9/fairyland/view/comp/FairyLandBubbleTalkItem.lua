-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandBubbleTalkItem.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandBubbleTalkItem", package.seeall)

local FairyLandBubbleTalkItem = class("FairyLandBubbleTalkItem", UserDataDispose)

function FairyLandBubbleTalkItem:init(go, bubbleView)
	self:__onInit()

	self._go = go
	self.bubbleView = bubbleView
	self.transform = go.transform
	self.parent = self.transform.parent
	self.goRoot = gohelper.findChild(self._go, "root")
	self.goBubble = gohelper.findChild(self.goRoot, "image_Bubble")
	self.trsBubble = self.goBubble.transform
	self.goText = gohelper.findChild(self.goRoot, "image_Bubble/Scroll View/Viewport/#txt_Descr")
	self.textFade = MonoHelper.addNoUpdateLuaComOnceToGo(self.goText, FairyLandTextFade)
	self.goArrow = gohelper.findChild(self.goRoot, "image_Bubble/Scroll View/image_Arrow")
end

function FairyLandBubbleTalkItem:showBubble(content, tween, hasNext)
	gohelper.setActive(self._go, true)

	local param = {}

	param.content = content
	param.tween = tween
	param.layoutCallback = self.layoutBubble
	param.callback = self.onTextPlayFinish
	param.callbackObj = self

	self.textFade:setText(param)
	gohelper.setActive(self.goArrow, hasNext)
	self:addUpdate()
end

function FairyLandBubbleTalkItem:addUpdate()
	if not self.addFlag then
		self.addFlag = true

		LateUpdateBeat:Add(self._forceUpdatePos, self)
	end
end

function FairyLandBubbleTalkItem:layoutBubble(height)
	recthelper.setHeight(self.trsBubble, height + 215)
end

function FairyLandBubbleTalkItem:onTextPlayFinish()
	self.bubbleView:onTextPlayFinish()
end

function FairyLandBubbleTalkItem:setTargetGO(go)
	self.targetGO = go
end

function FairyLandBubbleTalkItem:_forceUpdatePos()
	if gohelper.isNil(self.targetGO) then
		return
	end

	local x, y = recthelper.rectToRelativeAnchorPos2(self.targetGO.transform.position, self.parent)

	recthelper.setAnchor(self.transform, x, y)
end

function FairyLandBubbleTalkItem:hide()
	gohelper.setActive(self._go, false)

	if self.addFlag then
		LateUpdateBeat:Remove(self._forceUpdatePos, self)

		self.addFlag = false
	end

	if self.textFade then
		self.textFade:killTween()
	end
end

function FairyLandBubbleTalkItem:dispose()
	if self.addFlag then
		LateUpdateBeat:Remove(self._forceUpdatePos, self)

		self.addFlag = false
	end

	if self.textFade then
		self.textFade:onDestroy()
	end

	self:__onDispose()
end

return FairyLandBubbleTalkItem
