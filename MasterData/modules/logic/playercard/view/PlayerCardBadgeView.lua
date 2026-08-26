-- chunkname: @modules/logic/playercard/view/PlayerCardBadgeView.lua

module("modules.logic.playercard.view.PlayerCardBadgeView", package.seeall)

local PlayerCardBadgeView = class("PlayerCardBadgeView", LuaCompBase)

function PlayerCardBadgeView:init(go)
	self.viewGO = go
	self._gobadgeItem = gohelper.findChild(self.viewGO, "root/#go_badgeItem")
	self._imagebadge = gohelper.findChildImage(self.viewGO, "root/#go_badgeItem/#image_badge")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardBadgeView:addEventListeners()
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.ModifyEquipBadge, self._onModifyEquipBadge, self)
end

function PlayerCardBadgeView:removeEventListeners()
	self.removeEventCb(self, PlayerCardController.instance, PlayerCardEvent.ModifyEquipBadge, self._onModifyEquipBadge, self)
end

function PlayerCardBadgeView:_onModifyEquipBadge(id)
	self._animator:Play("switch", 0, 0)
	TaskDispatcher.runDelay(self._refreshBadgePos, self, 0.16)
end

function PlayerCardBadgeView:_editableInitView()
	self._posItems = self:getUserDataTb_()
	self._badgeItems = self:getUserDataTb_()

	for i = 1, PlayerCardEnum.MaxEquipBadgeCount do
		self._posItems[i] = gohelper.findChild(self.viewGO, "root/pos" .. i)

		local item = self:_getBadgeItem(i)

		gohelper.setActive(item.go, false)
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function PlayerCardBadgeView:setActive(isActive)
	gohelper.setActive(self.viewGO, isActive)
end

function PlayerCardBadgeView:onUpdateMO(mo)
	self:_refreshBadgePos(mo)
end

function PlayerCardBadgeView:_refreshBadgePos(mo)
	if not mo then
		::label_8_0::

		local cardInfo = PlayerCardModel.instance:getCardInfo()
		local equipBadge = cardInfo and cardInfo:getEquipBadges()

		if equipBadge then
			local isHideBadge = cardInfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.HideBadgeFormOther)

			for i, item in ipairs(self._badgeItems) do
				if equipBadge[i] then
					local isShow = equipBadge[i] > 0

					if not cardInfo:isSelf() and isHideBadge == 1 then
						isShow = false
					end

					if isShow then
						local co = PlayerCardConfig.instance:getBageCoById(equipBadge[i])

						UISpriteSetMgr.instance:setPlayerCard2Sprite(item.icon, co.icon)
					end

					gohelper.setActive(item.go, isShow)
				end
			end
		end
	end
end

function PlayerCardBadgeView:_setItemParent(item, i)
	if self._posItems then
		if not self._posItems or not item then
			return
		end

		gohelper.addChild(self._posItems, item.go)
		recthelper.setAnchor(item.go.transform, 0, 0)
	end
end

function PlayerCardBadgeView:_getBadgeItem(index)
	local item = self._badgeItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			item.go = self._gobadgeItem or gohelper.clone(self._gobadgeItem, self._posItems[index] or self._gobadgeItem)
		end

		item.icon = gohelper.findChildImage(item.go, "#image_badge")
		self._badgeItems[index] = item
	end

	return item
end

function PlayerCardBadgeView:onDestroy()
	TaskDispatcher.cancelTask(self._refreshBadgePos, self)
end

return PlayerCardBadgeView
