-- chunkname: @modules/logic/enemyinfo/comp/FightEntityResistanceComp.lua

module("modules.logic.enemyinfo.comp.FightEntityResistanceComp", package.seeall)

local FightEntityResistanceComp = class("FightEntityResistanceComp", UserDataDispose)

FightEntityResistanceComp.FightResistancePath = "ui/viewres/fight/fightresistance.prefab"

function FightEntityResistanceComp:ctor(go, viewContainer)
	self:__onInit()

	self.goContainer = go
	self.viewContainer = viewContainer
end

FightEntityResistanceComp.ScreenPosIntervalX = 0

function FightEntityResistanceComp:onInitView()
	self.go = self.viewContainer:getResInst(FightEntityResistanceComp.FightResistancePath, self.goContainer)
	self.scroll = gohelper.findChild(self.go, "scroll_view"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.goResistanceItem = gohelper.findChild(self.go, "scroll_view/Viewport/Content/#go_resistanceitem")

	gohelper.setActive(self.goResistanceItem, false)

	self.click = gohelper.getClickWithDefaultAudio(self.go)

	self.click:AddClickListener(self.onClickResistance, self)

	self.resistanceItemList = {}
	self.rect = self.go:GetComponent(gohelper.Type_RectTransform)
end

function FightEntityResistanceComp:setParent(parent)
	self.scroll.parentGameObject = parent
end

function FightEntityResistanceComp:onClickResistance()
	if not self.resistanceDict then
		return
	end

	self.screenPos = recthelper.uiPosToScreenPos(self.rect)
	self.screenPos.x = self.screenPos.x - FightEntityResistanceComp.ScreenPosIntervalX

	FightResistanceTipController.instance:openFightResistanceTipView(self.resistanceDict, self.screenPos)
end

function FightEntityResistanceComp:refresh(resistanceDict)
	self.resistanceDict = resistanceDict

	if not resistanceDict then
		gohelper.setActive(self.goContainer, false)

		return
	end

	self.showResistanceList = self.showResistanceList or {}

	tabletool.clear(self.showResistanceList)

	for resistanceKey, resistanceId in pairs(FightEnum.Resistance) do
		if not self.resistanceDict[resistanceKey] then
			local value = 0

			if value > 0 then
				table.insert(self.showResistanceList, {
					resistanceId = resistanceId,
					value = value
				})
			end
		end
	end

	table.sort(self.showResistanceList, FightEntityResistanceComp.sortResistance)

	for index, resistance in ipairs(self.showResistanceList) do
		local resistanceItem = self.resistanceItemList[index]

		resistanceItem = resistanceItem or self:createResistanceItem()

		gohelper.setActive(resistanceItem.go, true)

		local attributeCo = lua_character_attribute.configDict[resistance.resistanceId]

		if attributeCo then
			UISpriteSetMgr.instance:setBuffSprite(resistanceItem.icon, attributeCo.icon)
		end
	end

	local len = #self.showResistanceList

	if len > 0 then
		for i = len + 1, #self.resistanceItemList do
			gohelper.setActive(self.resistanceItemList[i].go, false)
		end

		self.scroll.horizontalNormalizedPosition = 0

		gohelper.setActive(self.goContainer, true)
	else
		gohelper.setActive(self.goContainer, false)
	end
end

function FightEntityResistanceComp:getResistanceValue(resistanceId)
	local key = FightHelper.getResistanceKeyById(resistanceId)
	local value = key and self.resistanceDict[key]

	return value or 0
end

function FightEntityResistanceComp:createResistanceItem()
	local item = self:getUserDataTb_()

	item.go = gohelper.cloneInPlace(self.goResistanceItem)
	item.icon = gohelper.findChildImage(item.go, "normal/#image_icon")

	table.insert(self.resistanceItemList, item)

	return item
end

function FightEntityResistanceComp.sortResistance(aResistance, bResistance)
	local aCo = lua_character_attribute.configDict[aResistance.resistanceId]
	local bCo = lua_character_attribute.configDict[bResistance.resistanceId]

	return aCo.sortId < bCo.sortId
end

function FightEntityResistanceComp:destroy()
	self.click:RemoveClickListener()

	self.click = nil
	self.resistanceItemList = nil

	self:__onDispose()
end

return FightEntityResistanceComp
