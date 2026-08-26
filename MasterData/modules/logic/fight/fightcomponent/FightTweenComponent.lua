-- chunkname: @modules/logic/fight/fightcomponent/FightTweenComponent.lua

module("modules.logic.fight.fightcomponent.FightTweenComponent", package.seeall)

local FightTweenComponent = class("FightTweenComponent", FightBaseClass)

function FightTweenComponent:onConstructor()
	self.TweenHelper = ZProj.TweenHelper
	self.index = 0
	self.tweenList = {}
end

function FightTweenComponent:DOTweenFloat(from, to, duration, frameCallback, finishCallback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOTweenFloat(from, to, duration, frameCallback, finishCallback, handle, param, ease)
end

function FightTweenComponent:DOAnchorPos(tr, x, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOAnchorPos(tr, x, y, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOAnchorPosX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOAnchorPosX(tr, x, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOAnchorPosY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOAnchorPosY(tr, y, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOWidth(tr, endWidth, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOWidth(tr, endWidth, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOHeight(tr, endHeight, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOHeight(tr, endHeight, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOSizeDelta(tr, endWidth, endHeight, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOSizeDelta(tr, endWidth, endHeight, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOMove(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOMove(tr, x, y, z, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOMoveX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOMoveX(tr, x, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOMoveY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOMoveY(tr, y, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOLocalMove(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOLocalMove(tr, x, y, z, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOLocalMoveX(tr, x, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOLocalMoveX(tr, x, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOLocalMoveY(tr, y, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOLocalMoveY(tr, y, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOScale(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOScale(tr, x, y, z, duration, callback, handle, param, ease)
end

function FightTweenComponent:DORotate(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DORotate(tr, x, y, z, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOLocalRotate(tr, x, y, z, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOLocalRotate(tr, x, y, z, duration, callback, handle, param, ease)
end

function FightTweenComponent:DoFade(graphic, start, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DoFade(graphic, start, final, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOColor(graphic, endColor, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOColor(graphic, endColor, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOText(text, content, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOText(text, content, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOFadeCanvasGroup(obj, start, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOFadeCanvasGroup(obj, start, final, duration, callback, handle, param, ease)
end

function FightTweenComponent:DOFillAmount(img, final, duration, callback, handle, param, ease)
	ease = EaseType.Str2Type(ease)
	self.index = self.index + 1
	self.tweenList[self.index] = self.TweenHelper.DOFillAmount(img, final, duration, callback, handle, param, ease)
end

function FightTweenComponent:scrollNumTween(text, start, final, duration, ease)
	ease = EaseType.Str2Type(ease)

	local instanceId = text:GetInstanceID()

	self.scrollNumtweenList = self.scrollNumtweenList or {}

	self:killTween(self.scrollNumtweenList[instanceId])

	local tweenId = self.DOTweenFloat(self, start, final, duration, self.onScrollNumFrame, nil, self, text, ease)

	self.scrollNumtweenList[instanceId] = tweenId

	return tweenId
end

function FightTweenComponent:onScrollNumFrame(value, text)
	text.text = math.ceil(value)
end

function FightTweenComponent:killTween(tweenId)
	if not tweenId then
		return
	end

	return self.TweenHelper.KillById(tweenId)
end

function FightTweenComponent:KillTweenByObj(obj, complete)
	return self.TweenHelper.KillByObj(obj, complete)
end

function FightTweenComponent:onDestructor()
	for i = 1, self.index do
		self.TweenHelper.KillById(self.tweenList[i])
	end
end

return FightTweenComponent
