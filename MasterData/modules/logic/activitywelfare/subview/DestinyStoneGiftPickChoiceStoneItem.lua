-- chunkname: @modules/logic/activitywelfare/subview/DestinyStoneGiftPickChoiceStoneItem.lua

module("modules.logic.activitywelfare.subview.DestinyStoneGiftPickChoiceStoneItem", package.seeall)

local DestinyStoneGiftPickChoiceStoneItem = class("DestinyStoneGiftPickChoiceStoneItem", LuaCompBase)

function DestinyStoneGiftPickChoiceStoneItem:init(go, type)
	self.go = go
	self.type = type
	self._gorole = gohelper.findChild(self.go, "role")
	self._imagerare = gohelper.findChildImage(self.go, "role/rare")
	self._simageheroicon = gohelper.findChildSingleImage(self.go, "role/heroicon")
	self._imagecareer = gohelper.findChildImage(self.go, "role/career")
	self._txtname = gohelper.findChildText(self.go, "role/name")
	self._goexskill = gohelper.findChild(self.go, "role/exskill")
	self._imageexskill = gohelper.findChildImage(self.go, "role/exskill/image_exskill")
	self._goranks = gohelper.findChild(self.go, "role/ranks")
	self._godestiny = gohelper.findChild(self.go, "destiny")
	self._golocked = gohelper.findChild(self.go, "destiny/locked")
	self._simagelockStone = gohelper.findChildSingleImage(self.go, "destiny/locked/simage_lockstone")
	self._gounlocked = gohelper.findChild(self.go, "destiny/unlock")
	self._simageunlockStone = gohelper.findChildSingleImage(self.go, "destiny/unlock/simage_unlockstone")
	self._txtunlocklv = gohelper.findChildText(self.go, "destiny/unlock/txt_unlocklv")
	self._goselect = gohelper.findChild(self.go, "select")
	self._btnclick = gohelper.findChildButton(self.go, "go_click")

	self:_initItem()
	self:_addEvents()
end

function DestinyStoneGiftPickChoiceStoneItem:_initItem()
	self._gorankitems = self:getUserDataTb_()

	for i = 1, 3 do
		self._gorankitems[i] = gohelper.findChild(self.go, "role/ranks/rank" .. i)
	end
end

function DestinyStoneGiftPickChoiceStoneItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	DestinyStoneGiftPickChoiceController.instance:registerCallback(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self._refreshSelect, self)
end

function DestinyStoneGiftPickChoiceStoneItem:_removeEvents()
	self._btnclick:RemoveClickListener()
	DestinyStoneGiftPickChoiceController.instance:unregisterCallback(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged, self._refreshSelect, self)
end

function DestinyStoneGiftPickChoiceStoneItem:_btnclickOnClick()
	DestinyStoneGiftPickChoiceModel.instance:setCurrentSelectStoneMo(self._stoneMO.stoneId, self.type, self._stoneMO)
	DestinyStoneGiftPickChoiceController.instance:dispatchEvent(DestinyStoneGiftPickChoiceEvent.onCustomPickListChanged)
end

function DestinyStoneGiftPickChoiceStoneItem:_refreshSelect()
	local curStoneId = DestinyStoneGiftPickChoiceModel.instance:getCurrentSelectStoneId()
	local isSelect = curStoneId == self._stoneMO.stoneId

	gohelper.setActive(self._goselect, isSelect)
end

function DestinyStoneGiftPickChoiceStoneItem:refresh(mo)
	self._stoneMO = mo

	self:_refreshHeroItem()
	self:_refreshStone()
	self:_refreshSelect()
end

local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function DestinyStoneGiftPickChoiceStoneItem:_refreshHeroItem()
	local mo = SummonCustomPickChoiceMO.New()

	mo:init(tonumber(self._stoneMO.heroId))

	local heroCo = HeroConfig.instance:getHeroCO(self._stoneMO.heroId)

	if not heroCo then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(self._stoneMO.id))

		return
	end

	local skinConfig = SkinConfig.instance:getSkinCo(heroCo.skinId)

	if not skinConfig then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(heroCo.skinId))

		return
	end

	self._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. heroCo.career)
	UISpriteSetMgr.instance:setCommonSprite(self._imagerare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

	self._txtname.text = heroCo.name

	local heroMo = HeroModel.instance:getByHeroId(self._stoneMO.heroId)

	if heroMo then
		if not heroMo.destinyStoneMo then
			local destinyStoneMo

			if destinyStoneMo then
				if not destinyStoneMo.rank then
					local rank = 1
					local rankIconIndex = rank - 1
					local isShowRanIcon = false

					for i = 1, 3 do
						local isCurRanIcon = i == rankIconIndex

						gohelper.setActive(self._gorankitems[i], isCurRanIcon)

						isShowRanIcon = isShowRanIcon or isCurRanIcon
					end

					gohelper.setActive(self._goranks, isShowRanIcon)

					if not mo:hasHero() or mo:getSkillLevel() <= 0 then
						gohelper.setActive(self._goexskill, false)

						return
					end

					gohelper.setActive(self._goexskill, true)

					self._imageexskill.fillAmount = exSkillFillAmount[mo:getSkillLevel()] or 1
				end
			end
		end
	end
end

function DestinyStoneGiftPickChoiceStoneItem:_refreshStone()
	local isUnLock = self.type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneCouldUp or self.type == DestinyStoneGiftPickChoiceEnum.HeroStoneType.OwnHeroStoneMax

	gohelper.setActive(self._golocked, not isUnLock)
	gohelper.setActive(self._gounlocked, isUnLock)

	if isUnLock then
		local heroMo = HeroModel.instance:getByHeroId(self._stoneMO.heroId)

		if heroMo then
			if not heroMo.destinyStoneMo then
				local destinyStoneMo

				if destinyStoneMo then
					if not destinyStoneMo.rank then
						local lv = 1

						self._txtunlocklv.text = GameUtil.getRomanNums(lv)
					end
				end
			end
		end
	else
		self._txtunlocklv.text = ""
	end

	local conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(self._stoneMO.stoneId)
	local icon = ResUrl.getDestinyIcon(conusmeCo.icon)

	self._simagelockStone:LoadImage(icon)
	self._simageunlockStone:LoadImage(icon)
end

function DestinyStoneGiftPickChoiceStoneItem:destroy()
	self._simageheroicon:UnLoadImage()
	self._simagelockStone:UnLoadImage()
	self._simageunlockStone:UnLoadImage()
	self:_removeEvents()
end

return DestinyStoneGiftPickChoiceStoneItem
