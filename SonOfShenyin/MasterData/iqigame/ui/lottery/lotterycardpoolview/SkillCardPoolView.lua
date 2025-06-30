-- chunkname: @IQIGame\\UI\\Lottery\\LotteryCardPoolView\\SkillCardPoolView.lua

local LotteryCardPoolView = require("IQIGame/UI/Lottery/LotteryCardPoolView/LotteryCardPoolView")
local LotterySkillNameTemplate = require("IQIGame/UI/Lottery/Template/LotterySkillNameTemplate")
local SubSkillItem = {}

function SubSkillItem.New(view)
	local obj = Clone(SubSkillItem)

	obj:__Init(view)

	return obj
end

function SubSkillItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.nameItem = LotterySkillNameTemplate.New(self.nameRoot)
end

function SubSkillItem:Show(itemCid)
	self.gameObject:SetActive(true)

	local bgPath = LotteryUIApi:GetSubItemBackground(itemCid)

	AssetUtil.LoadImage(self, bgPath, self.gameObject:GetComponent("Image"))
	self.nameItem:Show(itemCid)
end

function SubSkillItem:Hide()
	self.gameObject:SetActive(false)
end

function SubSkillItem:Dispose()
	self.nameItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local SkillCardPoolView = Clone(LotteryCardPoolView)

SkillCardPoolView.mainNameItem = nil
SkillCardPoolView.subItems = {}

function SkillCardPoolView.New(view)
	local obj = Clone(SkillCardPoolView)

	obj:Init(view)

	return obj
end

function SkillCardPoolView:__Init()
	self.mainNameItem = LotterySkillNameTemplate.New(self.mainNameRoot)

	for i = 0, self.subItemRoot.transform.childCount - 1 do
		local subItemView = self.subItemRoot.transform:GetChild(i):GetChild(0).gameObject
		local subItem = SubSkillItem.New(subItemView)

		table.insert(self.subItems, subItem)
	end
end

function SkillCardPoolView:__Show()
	local cardJackpotData = CfgCardJackpotTable[self.cardJackpotID]
	local mainItemCid = cardJackpotData.CardDetailShow[1]

	self:__FillMainSkillData(mainItemCid)

	for i = 2, #cardJackpotData.CardDetailShow do
		local subItem = self.subItems[i - 1]

		subItem:Show(cardJackpotData.CardDetailShow[i])
	end
end

function SkillCardPoolView:__FillMainSkillData(mainItemCid)
	local bgPath = LotteryUIApi:GetMainItemBackground(mainItemCid)

	AssetUtil.LoadImage(self, bgPath, self.mainItem:GetComponent("Image"))
	self.mainNameItem:Show(mainItemCid)
end

function SkillCardPoolView:__Hide()
	return
end

function SkillCardPoolView:__Dispose()
	self.mainNameItem:Dispose()
	AssetUtil.UnloadAsset(self)
end

return SkillCardPoolView
