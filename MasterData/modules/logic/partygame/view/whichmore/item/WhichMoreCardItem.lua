-- chunkname: @modules/logic/partygame/view/whichmore/item/WhichMoreCardItem.lua

module("modules.logic.partygame.view.whichmore.item.WhichMoreCardItem", package.seeall)

local WhichMoreCardItem = class("WhichMoreCardItem", SimpleListItem)

function WhichMoreCardItem:onInit()
	self.cardBkg = gohelper.findChild(self.viewGO, "cardBkg")
	self.imgCard = gohelper.findChildSingleImage(self.viewGO, "cardBkg/imgCard")
	self.imgUnknown = gohelper.findChild(self.viewGO, "imgUnknown")
	self.transImgCard = self.cardBkg.transform
	self.transImgFlip = self.imgUnknown.transform
	self.WhichMoreGameInterface = PartyGameCSDefine.WhichMoreGameInterface
	self.flipFlow = FlowSequence.New()
end

function WhichMoreCardItem:onDestroy()
	self:removeTween()

	if self.flipFlow then
		self.flipFlow:destroy()

		self.flipFlow = nil
	end
end

function WhichMoreCardItem:onItemShow(data)
	self.id = data.id
	self.resId = data.resId

	if self.flipFlow then
		self.flipFlow:destroy()

		self.flipFlow = nil
	end

	self:removeTween()

	local cfg = lua_partygame_whichmore_pictures.configDict[self.resId]

	self.imgCard:LoadImage(cfg.resource)

	self.isFlip = false

	if self.isFlip then
		gohelper.setActive(self.cardBkg, true)
		gohelper.setActive(self.imgUnknown, false)
	else
		gohelper.setActive(self.cardBkg, false)
		gohelper.setActive(self.imgUnknown, true)
	end

	transformhelper.setLocalRotation(self.transImgCard, 0, 0, 0)
	transformhelper.setLocalRotation(self.transImgFlip, 0, 0, 0)
	self:frameTick()
end

function WhichMoreCardItem:frameTick()
	local isFlip = self.WhichMoreGameInterface.IsFlip(self.itemIndex)

	if self.isFlip ~= isFlip then
		self.isFlip = isFlip

		self:playFlip()
		AudioMgr.instance:trigger(AudioEnum3_4.PartyGame15.play_ui_bulaochun_photo_flip)
	end
end

function WhichMoreCardItem:playFlip()
	if self.flipFlow then
		self.flipFlow:destroy()

		self.flipFlow = nil
	end

	self.flipFlow = FlowSequence.New()

	local r = math.random(1, 2)

	r = r == 1 and 1 or -1

	local flipTimeS = 0.5

	if self.isFlip then
		local flowSequence = FlowSequence.New()

		flowSequence:addWork(FunctionWork.New(function()
			gohelper.setActive(self.cardBkg.gameObject, false)
			gohelper.setActive(self.imgUnknown.gameObject, true)
			transformhelper.setLocalRotation(self.transImgFlip, 0, 0, 0)
		end))
		flowSequence:addWork(TweenWork.New({
			toz = 0,
			type = "DOLocalRotate",
			tox = 0,
			tr = self.transImgFlip,
			toy = r * 90,
			t = flipTimeS / 2,
			ease = EaseType.Linear
		}))
		flowSequence:addWork(FunctionWork.New(function()
			gohelper.setActive(self.cardBkg.gameObject, true)
			gohelper.setActive(self.imgUnknown.gameObject, false)
			transformhelper.setLocalRotation(self.transImgCard, 0, r * 90, 0)
		end))
		flowSequence:addWork(TweenWork.New({
			toz = 0,
			type = "DOLocalRotate",
			tox = 0,
			toy = 0,
			tr = self.transImgCard,
			t = flipTimeS / 2,
			ease = EaseType.Linear
		}))
		self.flipFlow:addWork(flowSequence)
	else
		local flowSequence = FlowSequence.New()

		flowSequence:addWork(FunctionWork.New(function()
			gohelper.setActive(self.cardBkg.gameObject, true)
			gohelper.setActive(self.imgUnknown.gameObject, false)
			transformhelper.setLocalRotation(self.transImgCard, 0, 0, 0)
		end))
		flowSequence:addWork(TweenWork.New({
			toz = 0,
			type = "DOLocalRotate",
			tox = 0,
			tr = self.transImgCard,
			toy = r * 90,
			t = flipTimeS / 2,
			ease = EaseType.Linear
		}))
		flowSequence:addWork(FunctionWork.New(function()
			gohelper.setActive(self.cardBkg.gameObject, false)
			gohelper.setActive(self.imgUnknown.gameObject, true)
			transformhelper.setLocalRotation(self.transImgFlip, 0, r * 90, 0)
		end))
		flowSequence:addWork(TweenWork.New({
			toz = 0,
			type = "DOLocalRotate",
			tox = 0,
			toy = 0,
			tr = self.transImgFlip,
			t = flipTimeS / 2,
			ease = EaseType.Linear
		}))
		self.flipFlow:addWork(flowSequence)
	end

	self.flipFlow:start()
end

function WhichMoreCardItem:removeTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

return WhichMoreCardItem
