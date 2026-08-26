-- chunkname: @modules/logic/fight/view/FightHeatScaleView_BLE.lua

module("modules.logic.fight.view.FightHeatScaleView_BLE", package.seeall)

local FightHeatScaleView_BLE = class("FightHeatScaleView_BLE", FightHeatScaleView)

function FightHeatScaleView_BLE:initView(viewGo, teamType)
	FightHeatScaleView_BLE.super.initView(self, viewGo, teamType)

	local goLayout = gohelper.findChild(self.root, "crystal_layout")

	gohelper.setActive(goLayout, true)

	self.goImageItem = gohelper.findChild(self.root, "crystal_layout/crystal_item")

	gohelper.setActive(self.goImageItem, false)

	self.countPosListDict = {
		[2] = self:getPosList(gohelper.findChild(self.root, "crystal_layout/pos2"), 2),
		[3] = self:getPosList(gohelper.findChild(self.root, "crystal_layout/pos3"), 3),
		[4] = self:getPosList(gohelper.findChild(self.root, "crystal_layout/pos4"), 4)
	}
	self.crystalImageList = self:getUserDataTb_()
end

function FightHeatScaleView_BLE:addEvents()
	FightHeatScaleView_BLE.super.addEvents(self)
	self.addEventCb(self, FightController.instance, FightEvent.Crystal_ValueChange, self.onCrystalValueChange, self)
end

function FightHeatScaleView_BLE:onOpen()
	FightHeatScaleView_BLE.super.onOpen(self)
	self:refreshCrystal()
end

function FightHeatScaleView_BLE:refreshCrystal()
	self:hideAllCrystalImage()

	local heatScale = FightDataHelper.getHeatScale(self.teamType)
	local hasCrystal = heatScale:hasCrystal()

	if not hasCrystal then
		return
	end

	local totalSelectCount = heatScale:getMaxCrystalNum()
	local posList = self.countPosListDict[totalSelectCount]

	if not posList then
		return
	end

	self:buildCrystalList()

	for i = 1, totalSelectCount do
		local image = self.crystalImageList[i]

		if not image then
			local go = gohelper.clone(self.goImageItem, posList[i].gameObject)

			image = go:GetComponent(gohelper.Type_Image)

			table.insert(self.crystalImageList, image)
		else
			image.transform:SetParent(posList[i])
		end

		recthelper.setAnchor(image.transform, 0, 0)

		local crystal = self.crystalEnumList[i]
		local crystalCo = FightHeroSpEffectConfig.instance:getBLECrystalCo(crystal)

		UISpriteSetMgr.instance:setFightSprite(image, crystalCo.smallIcon)

		local go = image.gameObject

		gohelper.setActive(go, true)
		gohelper.setActive(gohelper.findChild(go, "glow_purple"), crystal == FightEnum.CrystalEnum.Purple)
		gohelper.setActive(gohelper.findChild(go, "glow_blue"), crystal == FightEnum.CrystalEnum.Blue)
		gohelper.setActive(gohelper.findChild(go, "glow_green"), crystal == FightEnum.CrystalEnum.Green)
	end
end

function FightHeatScaleView_BLE:buildCrystalList()
	local heatScale = FightDataHelper.getHeatScale(self.teamType)
	local blue, purple, green = heatScale:getCrystalNum()

	self.crystalEnumList = self.crystalEnumList or {}

	tabletool.clear(self.crystalEnumList)

	for _ = 1, blue do
		table.insert(self.crystalEnumList, FightEnum.CrystalEnum.Blue)
	end

	for _ = 1, purple do
		table.insert(self.crystalEnumList, FightEnum.CrystalEnum.Purple)
	end

	for _ = 1, green do
		table.insert(self.crystalEnumList, FightEnum.CrystalEnum.Green)
	end
end

function FightHeatScaleView_BLE:hideAllCrystalImage()
	for _, image in ipairs(self.crystalImageList) do
		gohelper.setActive(image.gameObject, false)
	end
end

function FightHeatScaleView_BLE:onCrystalValueChange(teamType)
	if teamType ~= self.teamType then
		return
	end

	self:refreshCrystal()
end

function FightHeatScaleView_BLE:getDesc()
	local desc = FightConfig.instance:getJGZDesc()
	local heatScale = FightDataHelper.getHeatScale(self.teamType)
	local blue, purple, green = heatScale:getCrystalNum()
	local crystalDesc = self:getCrystalDesc(FightEnum.CrystalEnum.Blue, blue)

	if crystalDesc then
		desc = desc .. "\n" .. crystalDesc
	end

	crystalDesc = self:getCrystalDesc(FightEnum.CrystalEnum.Purple, purple)

	if crystalDesc then
		desc = desc .. "\n" .. crystalDesc
	end

	crystalDesc = self:getCrystalDesc(FightEnum.CrystalEnum.Green, green)

	if crystalDesc then
		desc = desc .. "\n" .. crystalDesc
	end

	return desc
end

function FightHeatScaleView_BLE:getCrystalDesc(crystal, count)
	if count < 1 then
		return
	end

	local crystalDesc = FightHeroSpEffectConfig.instance:getBLECrystalDescAndTag(crystal, count)
	local crystalCo = FightHeroSpEffectConfig.instance:getBLECrystalCo(crystal)

	return (string.format("<color=#%s>%s</color> : %s;", crystalCo.nameColor, crystalCo.name, crystalDesc))
end

return FightHeatScaleView_BLE
