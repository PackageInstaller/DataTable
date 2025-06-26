-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTipsView\\LotteryTipsView3.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local LotteryTipsView = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView")
local LotteryTipsView3_Item_Item = {}

function LotteryTipsView3_Item_Item.New(view)
	local obj = Clone(LotteryTipsView3_Item_Item)

	obj:__Init(view)

	return obj
end

function LotteryTipsView3_Item_Item:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
end

function LotteryTipsView3_Item_Item:Show(t1, t2, t3, t4)
	self.view.gameObject:SetActive(true)

	self.text1:GetComponent("Text").text = t1
	self.text2:GetComponent("Text").text = t2

	if LuaUtility.StrIsNullOrEmpty(t3) then
		self.text3.gameObject.transform.parent.gameObject:SetActive(false)
	else
		self.text3.gameObject.transform.parent.gameObject:SetActive(true)

		self.text3:GetComponent("Text").text = t3
	end

	if LuaUtility.StrIsNullOrEmpty(t4) then
		self.text4.gameObject.transform.parent.gameObject:SetActive(false)
	else
		self.text4.gameObject.transform.parent.gameObject:SetActive(true)

		self.text4:GetComponent("Text").text = t4
	end
end

function LotteryTipsView3_Item_Item:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView3_Item_Item:Dispose()
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotteryTipsView3_Item = {}

function LotteryTipsView3_Item.New(view)
	local obj = Clone(LotteryTipsView3_Item)

	obj:__Init(view)

	return obj
end

function LotteryTipsView3_Item:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self.itemTemplate.gameObject:SetActive(false)

	self.templatePool = UIViewObjectPool.New(self.itemTemplate, nil, function(_view)
		return LotteryTipsView3_Item_Item.New(_view)
	end)
end

function LotteryTipsView3_Item:Show(starNum, title, items)
	self.templatePool:ForItems(function(_item)
		_item:Hide()
	end)
	self.view.gameObject:SetActive(true)

	local path = LotteryUIApi:GetDetailTipsStarBg(starNum)

	AssetUtil.LoadImage(self, path, self.bgImg:GetComponent("Image"))
	self:__RefreshStart(starNum)

	self.contentText:GetComponent("Text").text = LotteryUIApi:GetCfgTextWithNumberString(title)

	if items == nil then
		return
	end

	local titleText = LotteryUIApi:GetProbabilityTipsItemTitle()
	local titleItem = self.templatePool:GetFree(function(_item)
		return not _item.view.gameObject.activeSelf
	end)

	titleItem:Show(titleText[1], titleText[2], titleText[1], titleText[2])
	table.sort(items, function(a, b)
		if a.itemTypes ~= b.itemTypes then
			return a.itemTypes < b.itemTypes
		end

		return a.Cid > b.Cid
	end)

	for i = 1, #items, 2 do
		local str1 = LotteryUIApi:GetProbabilityTipsItemType(items[i].itemTypes)
		local str2 = items[i].Name
		local str3 = items[i + 1] == nil and "" or LotteryUIApi:GetProbabilityTipsItemType(items[i + 1].itemTypes)
		local str4 = items[i + 1] == nil and "" or items[i + 1].Name
		local subItem = self.templatePool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		subItem:Show(str1, str2, str3, str4)
	end
end

function LotteryTipsView3_Item:__RefreshStart(starNum)
	for i = 0, self.startRoot.transform.childCount - 1 do
		self.startRoot.transform:GetChild(i).gameObject:SetActive(i < starNum)
	end
end

function LotteryTipsView3_Item:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView3_Item:Dispose()
	self.templatePool:Dispose(function(_item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotteryTipsView3 = Clone(LotteryTipsView)

LotteryTipsView3.templatePool = nil

function LotteryTipsView3.New(view)
	local obj = Clone(LotteryTipsView3)

	obj:Init(view)

	return obj
end

function LotteryTipsView3:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
	self.itemTemplate.gameObject:SetActive(false)

	self.templatePool = UIViewObjectPool.New(self.itemTemplate, nil, function(view)
		return LotteryTipsView3_Item.New(view)
	end)
end

function LotteryTipsView3:__Show()
	self.view.gameObject:SetActive(true)
	self.templatePool:ForItems(function(_item)
		_item:Hide()
	end)

	local qualityTable = {}
	local allItems = LotteryModule.GetAllCardJackpotShowItems(self.cardJackpotID)

	ForPairs(allItems, function(_cid, _itemCid)
		local itemCfg = CfgItemTable[_itemCid]

		if qualityTable[itemCfg.Quality] == nil then
			qualityTable[itemCfg.Quality] = {}
		end

		table.insert(qualityTable[itemCfg.Quality], {
			Cid = _itemCid,
			itemTypes = itemCfg.ItemTypes,
			Name = itemCfg.Name
		})
	end)

	local showData = LotteryModule.GetCardJackpotShowConfig(self.cardJackpotID)

	for i = 1, #showData.ShowProbability, 2 do
		local itemView = self.templatePool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)
		local starNum = tonumber(showData.ShowProbability[i])

		itemView:Show(starNum, showData.ShowProbability[i + 1], qualityTable[starNum])
	end
end

function LotteryTipsView3:__Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView3:__Dispose()
	self.templatePool:Dispose(function(item)
		item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return LotteryTipsView3
