-- chunkname: @IQIGame\\UI\\MazeTeam\\MazeTeamEquipController.lua

local m = {
	IsShow = false,
	EquipCards = {},
	SuitItems = {}
}
local prototype = m
local MazeTeamSubPanel = require("IQIGame.UI.MazeTeam.MazeTeamSubPanel")

m = Clone(MazeTeamSubPanel)

m.InitFieldDefaultValues(m, prototype)

local FormationEquipCard = require("IQIGame.UI.FormationUI.FormationEquipCard")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MazeTeamSuitEffectItem = require("IQIGame.UI.MazeTeam.MazeTeamSuitEffectItem")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:OnInit()
	function self.DelegateOnUpdateDoll()
		self:OnUpdateDoll()
	end

	for i = 1, 3 do
		local card = FormationEquipCard.New(UnityEngine.Object.Instantiate(self.EquipCardPrefab), i, function(card)
			self:OnClickEquipCard(card)
		end, function(card)
			self:OnLongClickEquipCard(card)
		end)

		card:SetSelected(false)
		card.View.transform:SetParent(self.EquipCardGrid.transform, false)

		self.EquipCards[i] = card
	end

	self.SuitItemPool = UIObjectPool.New(3, function()
		local item = MazeTeamSuitEffectItem.New(UnityEngine.Object.Instantiate(self.SuitEffectItemPrefab))

		return item
	end, function(item)
		local v = item.View

		item:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
end

function m:OnRootUIOpen()
	return
end

function m:OnRootUIClose()
	return
end

function m:OnShow(dollPOD)
	self.DollPOD = dollPOD

	self:Refresh()
end

function m:OnHide(isDestroy)
	return
end

function m:AddListeners()
	EventDispatcher.AddEventListener(EventID.MazeUpdateDoll, self.DelegateOnUpdateDoll)
end

function m:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.MazeUpdateDoll, self.DelegateOnUpdateDoll)
end

function m:Refresh()
	self:RefreshWearingEquips()
	self:RefreshSuit()
end

function m:RefreshWearingEquips()
	local equipMap = MazeDataModule.GetWearingEquipMap(self.DollPOD.soulCid)

	for i = 1, #self.EquipCards do
		local card = self.EquipCards[i]
		local itemData = equipMap[i]

		card:SetData(itemData)
	end
end

function m:RefreshSuit()
	self:ClearSuitItems()

	local equipMap = MazeDataModule.GetWearingEquipMap(self.DollPOD.soulCid)
	local wearingEquipCids = {}

	for index, itemData in pairs(equipMap) do
		table.insert(wearingEquipCids, itemData.cid)
	end

	local hasNum = 0
	local cfgSoulPaintingSuitData
	local isTrigger = false

	for index, itemData in pairs(equipMap) do
		hasNum = 0

		local cfgItemData = itemData:GetCfg()

		if cfgItemData.SoulPaintingSuitId ~= 0 then
			cfgSoulPaintingSuitData = CfgSoulPaintingSuitTable[cfgItemData.SoulPaintingSuitId]

			for i = 1, #wearingEquipCids do
				local wearingEquipCid = wearingEquipCids[i]

				if table.indexOf(cfgSoulPaintingSuitData.NeedSoulPainting, wearingEquipCid) ~= -1 then
					hasNum = hasNum + 1
				end
			end

			for i = 1, #cfgSoulPaintingSuitData.Num do
				local needNum = cfgSoulPaintingSuitData.Num[i]

				if needNum > 0 and needNum <= hasNum then
					isTrigger = true

					break
				end
			end

			if isTrigger then
				break
			end
		end
	end

	self.SuitView:SetActive(isTrigger)

	if not isTrigger then
		return
	end

	UGUIUtil.SetText(self.SuitTitleText, RpgMazeTeamUIApi:GetString("SuitTitleText", cfgSoulPaintingSuitData.Name))

	for i = 1, #cfgSoulPaintingSuitData.Num do
		local needNum = cfgSoulPaintingSuitData.Num[i]

		if needNum > 0 then
			local suitItem = self.SuitItemPool:Obtain()

			suitItem.View:SetActive(true)
			suitItem.View.transform:SetParent(self.SuitEffectGrid.transform, false)
			suitItem:SetData(cfgSoulPaintingSuitData.PabilityID[i], hasNum, needNum)
			table.insert(self.SuitItems, suitItem)
		end
	end
end

function m:ClearSuitItems(isDestroy)
	for i = 1, #self.SuitItems do
		local suitItem = self.SuitItems[i]

		suitItem.View:SetActive(false)

		if not isDestroy then
			suitItem.View.transform:SetParent(self.View.transform, false)
		end

		self.SuitItemPool:Release(suitItem)
	end

	self.SuitItems = {}
end

function m:OnClickEquipCard(card)
	self:SelectEquipCard(card)
	self:OpenEquipListUI(card.EquipCell.itemData, card.Index)
end

function m:OnLongClickEquipCard(card)
	if card.EquipCell.itemData ~= nil then
		local allEquipDataList = {}

		for i = 1, #self.EquipCards do
			local equipCard = self.EquipCards[i]

			if equipCard.EquipCell.itemData ~= nil then
				table.insert(allEquipDataList, equipCard.EquipCell.itemData)
			end
		end

		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			forShow = true,
			data = allEquipDataList,
			defaultItemData = card.EquipCell.itemData
		})
	end
end

function m:SelectEquipCard(card)
	self.SelectedEquipCard = card
end

function m:OpenEquipListUI(itemData, position)
	UIModule.Open(Constant.UIControllerName.MazeTeamSelectEquipUI, Constant.UILayer.UI, {
		wearing = itemData,
		position = position,
		dollPOD = self.DollPOD
	})
end

function m:OnUpdateDoll()
	self.DollPOD = MazeDataModule.GetDollPODByID(self.DollPOD.id)

	self:Refresh()
end

function m:OnDispose()
	for i = 1, #self.EquipCards do
		local equipCard = self.EquipCards[i]

		equipCard:Dispose()
	end

	self:ClearSuitItems(true)
	self.SuitItemPool:Dispose()
end

return m
