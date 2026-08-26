-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateEffectView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateEffectView", package.seeall)

local EliminateEffectView = class("EliminateEffectView", BaseView)

function EliminateEffectView:onInitView()
	self._goeffect = gohelper.findChild(self.viewGO, "#go_effect")
	self._godamages = gohelper.findChild(self.viewGO, "#go_damages")
	self._gohpFlys = gohelper.findChild(self.viewGO, "#go_hpFlys")
	self._goflyitem = gohelper.findChild(self.viewGO, "#go_flyitem")
	self._godamage = gohelper.findChild(self.viewGO, "#go_damage")
	self._txtdamage = gohelper.findChildText(self.viewGO, "#go_damage/#txt_damage")
	self._gohpFlyItem1 = gohelper.findChild(self.viewGO, "#go_hpFlyItem_1")
	self._gohpFlyItem2 = gohelper.findChild(self.viewGO, "#go_hpFlyItem_2")
	self._gohpFlyItem3 = gohelper.findChild(self.viewGO, "#go_hpFlyItem_3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateEffectView:addEvents()
	return
end

function EliminateEffectView:removeEvents()
	return
end

local green = GameUtil.parseColor("#AACD70")
local red = GameUtil.parseColor("#E0551D")

function EliminateEffectView:_editableInitView()
	if self.flyItemPool == nil then
		self.flyItemPool = LuaObjPool.New(EliminateEnum.dieEffectCacheCount, function()
			local itemGo = gohelper.clone(self._goflyitem, self._goeffect, "FlyItem")

			gohelper.setActive(itemGo, false)

			return itemGo
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
				gohelper.destroy(itemGo)
			end
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
			end
		end)
	end

	if self.damageItemPool == nil then
		self.damageItemPool = LuaObjPool.New(EliminateEnum.damageCacheCount, function()
			local itemGo = gohelper.clone(self._godamage, self._godamages, "damageItem")

			gohelper.setActive(itemGo, false)

			return itemGo
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
				gohelper.destroy(itemGo)
			end
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
			end
		end)
	end

	if self.characterHpFlyItemPools == nil then
		self.characterHpFlyItemPools = {}
	end

	for i = 1, 3 do
		self.characterHpFlyItemPools[i] = LuaObjPool.New(EliminateEnum.hpDamageCacheCount, function()
			local itemGo = gohelper.clone(self["_gohpFlyItem" .. i], self._gohpFlys, "hpFlyItem")

			gohelper.setActive(itemGo, false)

			return itemGo
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
				gohelper.destroy(itemGo)
			end
		end, function(itemGo)
			if not gohelper.isNil(itemGo) then
				gohelper.setActive(itemGo, false)
			end
		end)
	end

	self._godamagesTr = self._godamages.transform
	self._goeffectTr = self._goeffect.transform
	self._gohpFlysTr = self._gohpFlys.transform
end

function EliminateEffectView:onUpdateParam()
	return
end

function EliminateEffectView:onOpen()
	self.addEventCb(self, EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, self.playResourceFlyEffect, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, self.playDamageEffect, self)
	self.addEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, self.playCharacterHpChange, self)
end

function EliminateEffectView:onClose()
	self.removeEventCb(self, EliminateChessController.instance, EliminateChessEvent.ChessResourceFlyEffectPlay, self.playResourceFlyEffect, self)
	self.removeEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.PlayDamageEffect, self.playDamageEffect, self)
	self.removeEventCb(self, EliminateTeamChessController.instance, EliminateChessEvent.PlayCharacterDamageFlyEffect, self.playCharacterHpChange, self)
end

function EliminateEffectView:onDestroyView()
	if self.flyItemPool then
		self.flyItemPool:dispose()

		self.flyItemPool = nil
	end
end

local tweenHelper = ZProj.TweenHelper

function EliminateEffectView:playResourceFlyEffect(resourceId, startPosX, startPosY, endPosX, endPosY)
	local itemGo = self.flyItemPool:getObject()
	local itemTr = itemGo.transform
	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(startPosX, startPosY, 1, self._goeffectTr)

	recthelper.setAnchor(itemTr, rectPosX, rectPosY)
	gohelper.setActive(itemGo, true)

	rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(endPosX, endPosY, 1, self._goeffectTr)

	tweenHelper.DOAnchorPos(itemTr, rectPosX, rectPosY, EliminateEnum.ResourceFlyTime, self.resourceFlyEnd, self, {
		item = itemGo,
		resourceId = resourceId
	}, EaseType.OutQuart)
end

function EliminateEffectView:resourceFlyEnd(data)
	local itemGo = data.item
	local resourceId = data.resourceId

	if self.flyItemPool and not gohelper.isNil(itemGo) then
		self.flyItemPool:putObject(itemGo)
	end

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffectPlayFinish, resourceId)
end

function EliminateEffectView:playDamageEffect(diffValue, posX, posY, hpType)
	local itemGo = self.damageItemPool:getObject()
	local tr = itemGo.transform
	local size = EliminateTeamChessEnum.ChessDamageSize
	local delayTime = EliminateTeamChessEnum.teamChessPowerJumpTime

	if EliminateTeamChessEnum.HpDamageType.Character == hpType then
		size = EliminateTeamChessEnum.CharacterHpDamageSize
		delayTime = EliminateTeamChessEnum.hpDamageJumpTime
	end

	local txtDamage = gohelper.findChildText(itemGo, "#txt_damage")
	local formatStr = diffValue > 0 and "＋%d" or "－%d"

	txtDamage.text = string.format(formatStr, math.abs(diffValue))

	if diffValue > 0 then
		txtDamage.color = green or red
	end

	txtDamage.fontSize = size

	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(posX, posY, 1, self._godamagesTr)

	recthelper.setAnchor(tr, rectPosX, rectPosY)
	gohelper.setActive(itemGo, true)

	local height = recthelper.getHeight(tr)

	tweenHelper.DOHeight(tr, height, (EliminateTeamChessEnum.HpDamageType.GrowUpToChess == hpType or nil) and EliminateTeamChessEnum.teamChessGrowUpToChangePowerJumpTime, self.playDamageEffectEnd, self, itemGo)
end

function EliminateEffectView:playDamageEffectEnd(itemGo)
	if self.damageItemPool and not gohelper.isNil(itemGo) then
		self.damageItemPool:putObject(itemGo)
	end
end

local tweenHelper = ZProj.TweenHelper

function EliminateEffectView:playCharacterHpChange(teamType, diffValue, startPosX, startPosY, endPosX, endPosY)
	local damageGear = EliminateTeamChessModel.instance:calDamageGear(math.abs(diffValue))
	local pool = self.characterHpFlyItemPools[damageGear]

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_fire)

	local itemGo = pool:getObject()
	local itemTr = itemGo.transform
	local deltaX = endPosX - startPosX
	local deltaY = endPosY - startPosY
	local angleInRadians = math.atan2(deltaY, deltaX)
	local angleInDegrees = math.deg(angleInRadians)

	transformhelper.setEulerAngles(itemTr, 0, 0, angleInDegrees + 180)

	local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(startPosX, startPosY, 1, self._gohpFlysTr)

	recthelper.setAnchor(itemTr, rectPosX, rectPosY)
	gohelper.setActive(itemGo, true)

	local height = recthelper.getHeight(itemTr)

	rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(endPosX, endPosY, 1, self._gohpFlysTr)

	tweenHelper.DOAnchorPos(itemTr, rectPosX, rectPosY, EliminateTeamChessEnum.characterHpDamageFlyTime, nil, nil, nil, EaseType.OutQuart)
	tweenHelper.DOHeight(itemTr, height, EliminateTeamChessEnum.characterHpDamageFlyTimeTipHpChange, self.playCharacterHpChangeFlyEnd, self, {
		TeamType = teamType,
		Gear = damageGear,
		ItemGo = itemGo,
		diffValue = diffValue
	}, EaseType.OutQuart)
end

function EliminateEffectView:playCharacterHpChangeFlyEnd(data)
	local itemGo = data.ItemGo
	local gear = data.Gear
	local teamType = data.TeamType
	local diffValue = data.diffValue

	if self.characterHpFlyItemPools and self.characterHpFlyItemPools[gear] and not gohelper.isNil(itemGo) then
		self.characterHpFlyItemPools[gear]:putObject(itemGo)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.CharacterHpDamageFlyEffectPlayFinish, teamType, diffValue, gear)
end

return EliminateEffectView
