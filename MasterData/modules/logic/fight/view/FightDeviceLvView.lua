-- chunkname: @modules/logic/fight/view/FightDeviceLvView.lua

module("modules.logic.fight.view.FightDeviceLvView", package.seeall)

local FightDeviceLvView = class("FightDeviceLvView", FightBaseView)

function FightDeviceLvView:onInitView()
	self.goLvItem = gohelper.findChild(self.viewGO, "go_levelitem")
	self.viewRect = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.goLvItem, false)

	self.itemList = {}
end

local CounterId2Lang = {
	[FightCounterDataMgr.CounterId.DeviceCostPower] = "fight_3_7_device_cost_power",
	[FightCounterDataMgr.CounterId.DeviceUseSkill] = "fight_3_7_device_use_skill"
}
local CounterId2Image = {
	[FightCounterDataMgr.CounterId.DeviceCostPower] = "fight_device_icon_1",
	[FightCounterDataMgr.CounterId.DeviceUseSkill] = "fight_device_icon_2"
}
local CounterId2PlayedAnim = {
	[FightCounterDataMgr.CounterId.DeviceCostPower] = false,
	[FightCounterDataMgr.CounterId.DeviceUseSkill] = false
}

FightDeviceLvView.ItemHeight = 100

function FightDeviceLvView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.OnCounterChange, self.onCounterChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.AfterEffectWorkDone, self.onAfterEffectWorkDone, self)
end

function FightDeviceLvView:onAfterEffectWorkDone()
	for counterId, _ in pairs(CounterId2Lang) do
		FightDataHelper.setCounterValue(counterId, nil)
	end

	for key, _ in pairs(CounterId2PlayedAnim) do
		CounterId2PlayedAnim[key] = false
	end

	for _, item in ipairs(self.itemList) do
		if item.go.activeSelf then
			item.animator:Play("close", self.hideAllItem, self)
		end
	end
end

function FightDeviceLvView:hideAllItem()
	for _, item in ipairs(self.itemList) do
		gohelper.setActive(item.go, false)
	end
end

function FightDeviceLvView:onCounterChange(counterId, value)
	if not CounterId2Lang[counterId] then
		return
	end

	self:refreshUI()
end

function FightDeviceLvView:onOpen()
	self:refreshUI()
end

function FightDeviceLvView:refreshUI()
	for _, item in ipairs(self.itemList) do
		if item.go.activeSelf then
			item.animator:Stop()
		end
	end

	local count = 0

	for counterId, _ in pairs(CounterId2Lang) do
		local value = FightDataHelper.getCounterValue(counterId)

		value = tonumber(value)

		if value and value > 0 then
			count = count + 1

			local item = self.itemList[count]

			item = item or self:createItem()

			gohelper.setActive(item.go, true)

			local name = luaLang(CounterId2Lang[counterId])
			local lv = "LV." .. value

			item.txt.text = string.format("%s <color=#C35E2F>%s</color>", name, lv)

			UISpriteSetMgr.instance:setFightSprite(item.imageIcon, CounterId2Image[counterId])

			if not CounterId2PlayedAnim[counterId] then
				item.animator:Play("open")

				CounterId2PlayedAnim[counterId] = true
			end
		end
	end

	for i = count + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].go, false)
	end

	local height = recthelper.getHeight(self.viewRect)

	FightController.instance:dispatchEvent(FightEvent.RightElements_ShowElement, FightRightElementEnum.Elements.DeviceLV, height)
end

function FightDeviceLvView:createItem()
	local go = gohelper.cloneInPlace(self.goLvItem)
	local item = self:getUserDataTb_()

	item.go = go
	item.txt = gohelper.findChildText(go, "#txt")
	item.imageIcon = gohelper.findChildImage(go, "#image_icon")
	item.animator = ZProj.ProjAnimatorPlayer.Get(item.go)

	table.insert(self.itemList, item)

	return item
end

function FightDeviceLvView:onDestroyView()
	return
end

return FightDeviceLvView
