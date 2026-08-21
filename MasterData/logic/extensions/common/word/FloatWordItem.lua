-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/word/FloatWordItem.lua

module("logic.extensions.common.word.FloatWordItem", package.seeall)

local FloatWordItem = class("FloatWordItem")

function FloatWordItem:ctor(container)
	self._go = container.gameObject
	self._contentText = nil
	self._bg = nil
	self._rt = nil
	self._originPos = Vector3.zero
	self._lastTween = nil
	self._showType = nil
	self.gameObject = self._go

	self:_buildUI()
end

function FloatWordItem:Awake()
	self._rt = self._go.transform
	self._originPos = self._rt.localPosition
end

function FloatWordItem:_buildUI()
	self._floatItem1Go = goutil.findChild(self._go, "float_item")
	self._floatItem2Go = goutil.findChild(self._go, "rolefithint_top")
	self._floatItem3Go = goutil.findChild(self._go, "donatehint_top")
	self._floatItem4Go = goutil.findChild(self._go, "favorunlock_item")
	self._clickGo = goutil.findChild(self._go, "click")
	self._click = Astral.UIClickTrigger.Get(self._clickGo)
	self._guiAnimation = goutil.addComponentOnce(self._go, typeof(Astral.GUITimelineAniLua))
end

function FloatWordItem:_bindEvents()
	self._click:AddClickListener(self._onClick, self)
	self._guiAnimation:AddListener(self._dealTimelineListener, self)
end

function FloatWordItem:_unbindEvents()
	self._click:RemoveClickListener()
	self._guiAnimation:RemoveListener()
end

function FloatWordItem:getContentText()
	if self._showType == FloatWordMgr.showType1 then
		self._contentText = goutil.findChildComponent(self._go, "float_item/FloatText", "Text")
	elseif self._showType == FloatWordMgr.showType2 then
		self._contentText = goutil.findChildComponent(self._go, "rolefithint_top/txtHint", "Text")
	elseif self._showType == FloatWordMgr.showType3 then
		self._contentText = goutil.findChildComponent(self._go, "donatehint_top/txtHint", "Text")
	elseif self._showType == FloatWordMgr.showType4 then
		self._contentText = goutil.findChildComponent(self._go, "favorunlock_item/Image8/Text2", "Text")
	end

	return self._contentText
end

function FloatWordItem:getcontentTextStr()
	local text

	if self._contentText then
		text = self._contentText.text
	end

	return text
end

function FloatWordItem:getBg()
	if self._showType == FloatWordMgr.showType1 then
		self._bg = self._go.transform:Find("float_item/Image1"):GetComponent(typeof(UnityEngine.UI.Image))
	elseif self._showType == FloatWordMgr.showType2 then
		self._bg = self._go.transform:Find("rolefithint_top"):GetComponent(typeof(UnityEngine.UI.Image))
	elseif self._showType == FloatWordMgr.showType3 then
		self._bg = self._go.transform:Find("donatehint_top"):GetComponent(typeof(UnityEngine.UI.Image))
	elseif self._showType == FloatWordMgr.showType4 then
		self._bg = self._go.transform:Find("favorunlock_item/Image8"):GetComponent(typeof(UnityEngine.UI.Image))
	end

	return self._bg
end

function FloatWordItem:setShowType(showType)
	self:_bindEvents()

	self._showType = showType

	if self._showType == FloatWordMgr.showType1 then
		goutil.setActive(self._floatItem1Go, true)
		goutil.setActive(self._floatItem2Go, false)
		goutil.setActive(self._floatItem3Go, false)
		goutil.setActive(self._floatItem4Go, false)
	elseif self._showType == FloatWordMgr.showType2 then
		goutil.setActive(self._floatItem1Go, false)
		goutil.setActive(self._floatItem2Go, true)
		goutil.setActive(self._floatItem3Go, false)
		goutil.setActive(self._floatItem4Go, false)
	elseif self._showType == FloatWordMgr.showType3 then
		goutil.setActive(self._floatItem1Go, false)
		goutil.setActive(self._floatItem2Go, false)
		goutil.setActive(self._floatItem3Go, true)
		goutil.setActive(self._floatItem4Go, false)
	elseif self._showType == FloatWordMgr.showType4 then
		goutil.setActive(self._floatItem1Go, false)
		goutil.setActive(self._floatItem2Go, false)
		goutil.setActive(self._floatItem3Go, false)
		goutil.setActive(self._floatItem4Go, true)
	end
end

function FloatWordItem:setContent(content)
	local contentText = self:getContentText()

	contentText.text = content

	RectTransformUtils.ForceRebuildLayoutImmediate(self._rt)
end

function FloatWordItem:flyTo(flyTargetHeight, flySpeed, stayTime, completeCallback, completeCallbackSelf)
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")

	if self._lastTween then
		self._lastTween:Kill(false)

		self._lastTween = nil
	end

	if self._showType == FloatWordMgr.showType2 then
		stayTime = 3
	end

	local y = self._rt.anchoredPosition.y
	local flySequence = DG.Tweening.DOTween.Sequence()

	self._lastTween = flySequence

	if stayTime > 0 then
		flySequence:AppendInterval(stayTime)
		flySequence:AppendCallback(function()
			self._onPlayingAni = true

			self._guiAnimation:PlayAniByName("close")
		end)
		flySequence:AppendInterval(0.3)
	end

	if completeCallback then
		flySequence:AppendCallback(function()
			self._lastTween = nil

			if completeCallbackSelf then
				completeCallback(completeCallbackSelf, self)
			else
				completeCallback(self)
			end
		end)
	end
end

function FloatWordItem:reset()
	self:_unbindEvents()

	if self._lastTween then
		self._lastTween:Kill()

		self._lastTween = nil
	end

	self._rt.localPosition = self._originPos

	if self._contentText then
		self._contentText.text = ""
	end
end

function FloatWordItem:_onClick()
	if self._onPlayingAni then
		return
	end

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
end

function FloatWordItem:_dealTimelineListener(tagName)
	if tagName == "close" then
		FloatWordMgr.instance:clear()

		self._onPlayingAni = false
	end
end

return FloatWordItem
