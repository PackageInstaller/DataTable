-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipDiceIconItem.lua

module("logic.extensions.charactersystem.view.equip.EquipDiceIconItem", package.seeall)

local M = class("EquipDiceIconItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._transform = self._mainGo.transform
	self._imgDiGo = goutil.findChild(self._mainGo, "imgDi")

	self._imgDiGo:SetActive(false)

	self._imgIconBg = goutil.findChildImageComponent(self._mainGo, "iconBg")
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "iconBg/icon")
	self._goUnlock = self._imgIconBg.gameObject
	self._goLock = goutil.findChild(self._mainGo, "imgNoCalibration")
	self._goQuestion = goutil.findChild(self._mainGo, "imgQuestion")
	self._enhanceAniGo = {
		goutil.findChild(self._mainGo, "01"),
		goutil.findChild(self._mainGo, "02")
	}

	for _, go in ipairs(self._enhanceAniGo) do
		goutil.setActive(go, false)
	end

	self._defaultIconColor = self._imgIcon.color
	self._defaultIconBgColor = self._imgIconBg.color
end

function M:getIconTransPos()
	return self._imgIcon.transform.position
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	return
end

function M:closeEnhanceAni()
	goutil.setActive(self._enhanceAniGo[1], false)
	goutil.setActive(self._enhanceAniGo[2], false)
end

function M:playAllAni()
	goutil.setActive(self._enhanceAniGo[1], true)
	goutil.setActive(self._enhanceAniGo[2], true)
end

function M:playEnhanceAni()
	goutil.setActive(self._enhanceAniGo[2], true)
end

function M:setStatus(value)
	goutil.setActive(self._goUnlock, EquipEnum.DiceStatus.Unlock == value or EquipEnum.DiceStatus.Unlocking == value)
	goutil.setActive(self._goLock, EquipEnum.DiceStatus.Lock == value)
	goutil.setActive(self._goQuestion, EquipEnum.DiceStatus.CanUnLock == value)
end

function M:setData(diceAttMo)
	if not diceAttMo then
		return
	end

	local iconName = string.format("citiaogroup_%d", diceAttMo:getEnhanceType())

	if iconName ~= self._iconBgName then
		self._iconBgName = iconName

		IconLoader.setSprite(self._imgIconBg, IconType.EquipDiceIcon, iconName)
	end

	if iconName ~= self._iconName then
		self._iconName = iconName

		IconLoader.setSprite(self._imgIcon, IconType.EquipDiceIcon, diceAttMo:getIcon())
	end
end

function M:setClickCallback(callback)
	self._callback = callback
end

function M:setVisible(visible)
	goutil.setActive(self._mainGo, visible)
end

function M:setPos(x, y)
	TransformUtils.SetLocalPosition(self._transform, x, y, 0)
end

function M:setGoName(name)
	self._mainGo.name = name
end

function M:setHoleBgVisible(visible)
	goutil.setActive(self._imgDiGo, visible)
end

return M
