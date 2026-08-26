-- chunkname: @modules/logic/partygame/view/carddrop/CardDropFloatItem.lua

module("modules.logic.partygame.view.carddrop.CardDropFloatItem", package.seeall)

local CardDropFloatItem = class("CardDropFloatItem", UserDataDispose)

function CardDropFloatItem:init(itemGo, type)
	self:__onInit()

	self.type = type
	self.itemGo = itemGo
	self.rectTr = self.itemGo:GetComponent(gohelper.Type_RectTransform)
	self.txtDamage = gohelper.findChildText(self.itemGo, "x/txtNum")
	self.startFloatTime = 0
end

function CardDropFloatItem:showDamage(damage, anchorX, anchorY)
	self:clearTween()
	recthelper.setAnchor(self.rectTr, anchorX, anchorY)
	gohelper.setActive(self.itemGo, true)

	self.txtDamage.text = damage
	self.startFloatTime = Time.realtimeSinceStartup
end

function CardDropFloatItem:checkFloatDone()
	return Time.realtimeSinceStartup - self.startFloatTime >= CardDropEnum.FloatDuration
end

function CardDropFloatItem:tweenAnchorY(anchorY)
	self:clearTween()

	self.tweenId = ZProj.TweenHelper.DOAnchorPosY(self.rectTr, anchorY, CardDropEnum.TweenDuration)
end

function CardDropFloatItem:hide()
	gohelper.setActive(self.itemGo, false)
end

function CardDropFloatItem:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function CardDropFloatItem:destroy()
	self:clearTween()
	self:hide()
	self:__onDispose()
end

return CardDropFloatItem
