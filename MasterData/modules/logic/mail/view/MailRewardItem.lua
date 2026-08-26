-- chunkname: @modules/logic/mail/view/MailRewardItem.lua

module("modules.logic.mail.view.MailRewardItem", package.seeall)

local MailRewardItem = class("MailRewardItem")

function MailRewardItem:init(go)
	self.go = go
	self._commonitemcontainer = gohelper.findChild(go, "commonitemcontainer")
	self._canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._txtcount = gohelper.findChildText(go, "countbg/count")
	self._bg = gohelper.findChild(go, "countbg")
end

function MailRewardItem:addEventListeners()
	return
end

function MailRewardItem:removeEventListeners()
	return
end

function MailRewardItem:onUpdateMO(mo)
	self._mo = mo
	self.itemType = tonumber(self._mo[1])
	self.itemId = tonumber(self._mo[2])

	local itemQuantity = tonumber(self._mo[3])

	if self.itemType == MaterialEnum.MaterialType.EquipCard or self.itemType == MaterialEnum.MaterialType.Season123EquipCard then
		recthelper.setWidth(self.go.transform, 80.69)

		if self._commonitem then
			gohelper.setActive(self._commonitem.go, false)
		end

		gohelper.setActive(self._bg.gameObject, false)

		if not self._equipCardItem then
			self._equipItemGo = gohelper.create2d(self.go, "EquipCard")

			transformhelper.setLocalScale(self._equipItemGo.transform, 0.265, 0.265, 0.265)

			self._equipCardItem = Season123CelebrityCardItem.New()

			self._equipCardItem:init(self._equipItemGo, self.itemId, {
				noClick = true
			})
		else
			gohelper.setActive(self._equipItemGo, true)
			self._equipCardItem:reset(nil, nil, self.itemId)
		end
	else
		recthelper.setWidth(self.go.transform, 115)

		self._commonitem = self._commonitem or IconMgr.instance:getCommonPropItemIcon(self._commonitemcontainer)

		gohelper.setActive(self._equipItemGo, false)
		gohelper.setActive(self._commonitem.go, true)
		gohelper.setActive(self._bg.gameObject, true)
		self._commonitem:setMOValue(self.itemType, self.itemId, itemQuantity, nil, true)
		self._commonitem:hideEffect()

		if self._commonitem:isEquipIcon() then
			self._commonitem:ShowEquipCount(self._bg, self._txtcount)
			self._commonitem:setHideLvAndBreakFlag(true)
			self._commonitem:hideEquipLvAndBreak(true)
		else
			self._commonitem:isShowCount(false)

			self._txtcount.text = tostring(itemQuantity)

			self._commonitem:showStackableNum2(self._bg, self._txtcount)
		end
	end

	self._canvasGroup.alpha = self._mo.state == MailEnum.ReadStatus.Read and 0.5 or 1

	if self.itemType == MaterialEnum.MaterialType.Item then
		local config = lua_item.configDict[self.itemId]

		if config.subType == ItemEnum.SubType.Portrait then
			self._commonitem:setFrameMaskable(true)
		end
	end
end

function MailRewardItem:onDestroy()
	if self._commonitem then
		self._commonitem:onDestroy()
	end

	if self._equipCardItem then
		self._equipCardItem:destroy()
	end

	gohelper.destroy(self._equipItemGo)

	self._mo = nil
	self._commonitem = nil
	self._equipCardItem = nil
	self._equipItemGo = nil
	self.go = nil
	self._commonitemcontainer = nil
	self._canvasGroup = nil
	self._txtcount = nil
	self._bg = nil
end

return MailRewardItem
