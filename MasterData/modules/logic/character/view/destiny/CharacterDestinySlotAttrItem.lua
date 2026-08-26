-- chunkname: @modules/logic/character/view/destiny/CharacterDestinySlotAttrItem.lua

module("modules.logic.character.view.destiny.CharacterDestinySlotAttrItem", package.seeall)

local CharacterDestinySlotAttrItem = class("CharacterDestinySlotAttrItem", LuaCompBase)

function CharacterDestinySlotAttrItem:onInitView()
	self._gospecialbg = gohelper.findChild(self.viewGO, "#go_specialbg")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._txtunlocktips = gohelper.findChildText(self.viewGO, "#go_lock/#txt_unlocktips")
	self._txtlockname = gohelper.findChildText(self.viewGO, "#go_lock/layout/#txt_lockname")
	self._imagelockicon = gohelper.findChildImage(self.viewGO, "#go_lock/layout/#txt_lockname/#image_lockicon")
	self._txtlockcur = gohelper.findChildText(self.viewGO, "#go_lock/layout/num/#txt_lockcur")
	self._golockarrow = gohelper.findChild(self.viewGO, "#go_lock/layout/num/#go_lockarrow")
	self._txtlocknext = gohelper.findChildText(self.viewGO, "#go_lock/layout/num/#txt_locknext")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._txtunlockname = gohelper.findChildText(self.viewGO, "#go_unlock/#txt_unlockname")
	self._imageunlockicon = gohelper.findChildImage(self.viewGO, "#go_unlock/#txt_unlockname/#image_unlockicon")
	self._txtunlockcur = gohelper.findChildText(self.viewGO, "#go_unlock/num/#txt_unlockcur")
	self._gounlockarrow = gohelper.findChild(self.viewGO, "#go_unlock/num/#go_unlockarrow")
	self._txtunlocknext = gohelper.findChildText(self.viewGO, "#go_unlock/num/#txt_unlocknext")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDestinySlotAttrItem:addEvents()
	return
end

function CharacterDestinySlotAttrItem:removeEvents()
	return
end

function CharacterDestinySlotAttrItem:_editableInitView()
	return
end

function CharacterDestinySlotAttrItem:init(go)
	self.viewGO = go
	self._lockItem = self:getUserDataTb_()
	self._golockItem = gohelper.findChild(self.viewGO, "#go_lock/layout")
	self._levelup = gohelper.findChild(self.viewGO, "#leveup")
	self._lockItem[1] = self:__getLockItem(self._golockItem)

	self:onInitView()
	gohelper.setActive(go, true)
	gohelper.setActive(self._levelup, false)
end

function CharacterDestinySlotAttrItem:addEventListeners()
	self:addEvents()
end

function CharacterDestinySlotAttrItem:removeEventListeners()
	self:removeEvents()
end

function CharacterDestinySlotAttrItem:onDestroy()
	TaskDispatcher.cancelTask(self._levelupAnimCallback, self)
end

function CharacterDestinySlotAttrItem:onUpdateBaseAttrMO(index, mo, isShowBg, bgHeight)
	local co = HeroConfig.instance:getHeroAttributeCO(mo.attrId)
	local name = co.name

	if not mo.curNum then
		if not mo.nextNum then
			local nextNum = 0

			self._txtunlockname.text = name
			self._txtunlockcur.text = self:_showAttrValue(mo.curNum, co.showType)
			self._txtunlocknext.text = self:_showAttrValue(mo.curNum + nextNum, co.showType)

			local attrId = mo.attrId

			self.attrId = attrId

			local _parseAttrId = CharacterDestinyModel.instance:destinyUpBaseReverseParseAttr(attrId)

			attrId = _parseAttrId or mo.attrId

			CharacterController.instance:SetAttriIcon(self._imageunlockicon, attrId)
			gohelper.setActive(self._gounlockarrow, nextNum > 0)
			gohelper.setActive(self._txtunlocknext.gameObject, nextNum > 0)
			gohelper.setActive(self._gounlock, true)
			gohelper.setActive(self._golock, false)
			recthelper.setAnchorY(self._gospecialbg.transform, 0)

			if isShowBg then
				local height = self:_getSpecialBgHeight(bgHeight)

				recthelper.setHeight(self._gospecialbg.transform, height)
			end

			gohelper.setActive(self._gospecialbg, isShowBg)
		end
	end
end

function CharacterDestinySlotAttrItem:onUpdateSpecailAttrMO(index, mo, isShowBg, count)
	self:onUpdateBaseAttrMO(index, mo, isShowBg, count)
end

function CharacterDestinySlotAttrItem:onUpdateLockSpecialAttrMO(index, rank, mo)
	if mo then
		local index = 1
		local specialIndex = 0

		for _, info in pairs(mo) do
			local co = HeroConfig.instance:getHeroAttributeCO(info.attrId)
			local name = co.name

			if not info.curNum then
				local item = self:_getLockItem(index)

				if item then
					item.nameTxt.text = name
					item.curNumTxt.text = self:_showAttrValue(info.curNum, co.showType)

					local attrId = info.attrId

					if (LuaUtil.tableContains(CharacterDestinyEnum.DestinyUpSpecialAttr, attrId) or LuaUtil.tableContains(CharacterEnum.UpAttrIdList, attrId)) and not self._gospecialbg.activeSelf then
						recthelper.setAnchorY(self._gospecialbg.transform, -50 - (index - 1) * 53)
						gohelper.setActive(self._gospecialbg, true)

						specialIndex = index
					end

					local _parseAttrId = CharacterDestinyModel.instance:destinyUpBaseReverseParseAttr(attrId)

					attrId = _parseAttrId or info.attrId

					CharacterController.instance:SetAttriIcon(item.iconImage, attrId)
				end

				index = index + 1
			end
		end

		if specialIndex > 0 and self._gospecialbg.activeSelf then
			local height = self:_getSpecialBgHeight(index - specialIndex)

			recthelper.setHeight(self._gospecialbg.transform, height)
		end

		local lang = luaLang("character_destinyslot_unlockrank")
		local unlock = CharacterDestinyEnum.RomanNum[rank]

		self._txtunlocktips.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, unlock)
	end

	gohelper.setActive(self._gounlock, false)
	gohelper.setActive(self._golock, true)
end

function CharacterDestinySlotAttrItem:_getSpecialBgHeight(count)
	return 50 + count * 70
end

function CharacterDestinySlotAttrItem:_showAttrValue(num, showType)
	return showType == 1 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), num) or num
end

function CharacterDestinySlotAttrItem:_getLockItem(index)
	local item = self._lockItem[index]

	if not item then
		local go = gohelper.cloneInPlace(self._golockItem)

		item = self:__getLockItem(go)
		self._lockItem[index] = item
	end

	return item
end

function CharacterDestinySlotAttrItem:__getLockItem(go)
	if not go then
		return
	end

	local item = self:getUserDataTb_()

	item.go = go
	item.nameTxt = gohelper.findChildText(go, "#txt_lockname")
	item.iconImage = gohelper.findChildImage(go, "#txt_lockname/#image_lockicon")
	item.curNumTxt = gohelper.findChildText(go, "num/#txt_lockcur")
	item.arrowGo = gohelper.findChild(go, "num/#go_lockarrow")
	item.nextNumTxt = gohelper.findChildText(go, "num/#txt_locknext")

	return item
end

function CharacterDestinySlotAttrItem:playLevelUpAnim()
	gohelper.setActive(self._levelup, true)
	TaskDispatcher.runDelay(self._levelupAnimCallback, self, 1)
end

function CharacterDestinySlotAttrItem:_levelupAnimCallback()
	gohelper.setActive(self._levelup, false)
end

return CharacterDestinySlotAttrItem
