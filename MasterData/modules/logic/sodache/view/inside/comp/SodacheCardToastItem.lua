-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheCardToastItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheCardToastItem", package.seeall)

local SodacheCardToastItem = class("SodacheCardToastItem", LuaCompBase)
local OutSidePos = 10000
local csTweenHelper = ZProj.TweenHelper

function SodacheCardToastItem:init(go)
	self.width = 0
	self.height = 0
	self.tr = go.transform
	self._goget = gohelper.findChild(go, "#go_bg/get")
	self._golose = gohelper.findChild(go, "#go_bg/lose")
	self._txt = gohelper.findChildText(go, "#txt_desc")
	self._gocard = gohelper.findChild(go, "sodache_carditem")
	self._cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._gocard, SodacheCardItem)

	self._cardItem:showInfo()

	self.canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._duration = 0.3
	self._showToastDuration = 1
	self.startAnchorPositionY = 0
end

local colorStrDict = {
	[SodacheEnum.ItemQuality.One] = "#7bb681",
	[SodacheEnum.ItemQuality.Two] = "#5e7fad",
	[SodacheEnum.ItemQuality.Three] = "#c898da",
	[SodacheEnum.ItemQuality.Four] = "#bf9a5a",
	[SodacheEnum.ItemQuality.Five] = "#D2854D",
	[SodacheEnum.ItemQuality.Six] = "#E76D6D"
}

function SodacheCardToastItem:setMsg(data)
	self.canvasGroup.alpha = 1
	self.width = 712
	self.height = 166

	gohelper.setActive(self._goget, data.isGet)
	gohelper.setActive(self._golose, not data.isGet)
	self._cardItem:updateMo(data.cardMo)

	local desc = data.isGet and luaLang("sodache_drop_get_card") or luaLang("sodache_drop_lose_card")
	local cardName = data.cardMo.serverMo.itemCo.name
	local colorStr = colorStrDict[data.cardMo.serverMo.itemCo.quality]

	if colorStr then
		cardName = string.format("<color=%s>%s</color>", colorStr, cardName)
	end

	self._txt.text = GameUtil.getSubPlaceholderLuaLangTwoParam(desc, cardName, data.cardMo.serverMo.count)

	if data.isGet then
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.getcard_flip)
	else
		AudioMgr.instance:trigger(AudioEnum3_7.Sodache.losecard_toast)
	end
end

function SodacheCardToastItem:_delay()
	SodacheController.instance:dispatchEvent(SodacheEvent.RecycleToast, self)
end

function SodacheCardToastItem:appearAnimation()
	recthelper.setAnchorX(self.tr, self.width)
	csTweenHelper.KillById(self.startTweenId or -1)

	self.startTweenId = csTweenHelper.DOAnchorPosX(self.tr, 0, self._duration, function()
		self.startTweenId = nil

		TaskDispatcher.runDelay(self._delay, self, self._showToastDuration)
	end)
end

function SodacheCardToastItem:upAnimation(targetPosY)
	csTweenHelper.KillById(self.upTweenId or -1)

	self.upTweenId = csTweenHelper.DOAnchorPosY(self.tr, targetPosY, self._duration, function()
		self.upTweenId = nil
	end)
end

function SodacheCardToastItem:quitAnimation(quitAnimationDoneCallback, callbackObj)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.quitAnimationDoneCallback = quitAnimationDoneCallback
	self.callbackObj = callbackObj
	self.startAnchorPositionY = self.tr.anchoredPosition.y
	self.quitTweenId = csTweenHelper.DOTweenFloat(1, 0, self._duration, self.quitAnimationFrame, self.quitAnimationDone, self)
end

function SodacheCardToastItem:quitAnimationFrame(value)
	local upPositionY = (1 - value) * self.height

	recthelper.setAnchorY(self.tr, self.startAnchorPositionY + upPositionY)

	self.canvasGroup.alpha = value
end

function SodacheCardToastItem:quitAnimationDone()
	if self.quitAnimationDoneCallback then
		self.quitAnimationDoneCallback(self.callbackObj, self)
	end

	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
	self.quitTweenId = nil
end

function SodacheCardToastItem:clearAllTask()
	TaskDispatcher.cancelTask(self._delay, self)
	csTweenHelper.KillById(self.startTweenId or -1)
	csTweenHelper.KillById(self.upTweenId or -1)
	csTweenHelper.KillById(self.quitTweenId or -1)

	self.startTweenId = nil
	self.upTweenId = nil
	self.quitTweenId = nil
	self.quitAnimationDoneCallback = nil
	self.callbackObj = nil
end

function SodacheCardToastItem:reset()
	self.startAnchorPositionY = 0

	recthelper.setAnchor(self.tr, OutSidePos, OutSidePos)
end

function SodacheCardToastItem:getHeight()
	return self.height
end

function SodacheCardToastItem:onDestroy()
	self:clearAllTask()
end

return SodacheCardToastItem
