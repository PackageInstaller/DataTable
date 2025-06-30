-- chunkname: @IQIGame\\UI\\Lottery\\LotteryTipsView\\LotteryTipsView2.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local LotteryTipsView = require("IQIGame/UI/Lottery/LotteryTipsView/LotteryTipsView")
local LotteryTipsView2_Item_Card = {}

function LotteryTipsView2_Item_Card.New(view)
	local obj = Clone(LotteryTipsView2_Item_Card)

	obj:__Init(view)

	return obj
end

function LotteryTipsView2_Item_Card:__Init(view)
	self.view = view
	self.roleView = {}
	self.diyView = {}

	LuaCodeInterface.BindOutlet(self.view, self)
	LuaCodeInterface.BindOutlet(self.roleRoot, self.roleView)
	LuaCodeInterface.BindOutlet(self.diyRoot, self.diyView)

	function self.__delegateOnItemClick()
		UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
			type = self.detailsType,
			cid = self.targetCid
		})
	end

	self.view:GetComponent("Button").onClick:AddListener(self.__delegateOnItemClick)
end

function LotteryTipsView2_Item_Card:ShowRole(roleID)
	self.diyRoot.gameObject:SetActive(false)
	self.roleRoot.gameObject:SetActive(true)
	self.view.gameObject:SetActive(true)

	local heroCfg = CfgHeroTable[roleID]
	local path = SkinModule.GetHeroDefaultSkinImgPath(roleID, Constant.SkinImageType.HeroResourcesHead)

	AssetUtil.LoadImage(self, path, self.roleView.headIcon:GetComponent("Image"))

	self.roleView.nameText:GetComponent("Text").text = heroCfg.Name

	local elementIconPath = UIGlobalApi.GetImagePath(heroCfg.ElementsIcon)

	AssetUtil.LoadImage(self, elementIconPath, self.roleView.elementIcon:GetComponent("Image"))

	local professionIconPath = UIGlobalApi.GetImagePath(heroCfg.ProfessionIcon)

	AssetUtil.LoadImage(self, professionIconPath, self.roleView.professionIcon:GetComponent("Image"))

	self.detailsType = Constant.ItemType.Hero
	self.targetCid = roleID
end

function LotteryTipsView2_Item_Card:ShowDiy(itemCid)
	self.roleRoot.gameObject:SetActive(false)
	self.diyRoot.gameObject:SetActive(true)
	self.view.gameObject:SetActive(true)

	local itemCfg = CfgItemTable[itemCid]
	local iconPath = UIGlobalApi.GetIconPath(itemCfg.Icon)

	AssetUtil.LoadImage(self, iconPath, self.diyView.headIcon:GetComponent("Image"))

	local skillCfg = CfgSkillTable[itemCfg.LikeId]

	self.diyView.nameText:GetComponent("Text").text = skillCfg.Name

	local cfgSkillDetailData = CfgSkillDetailTable[skillCfg.SkillDetail]

	if cfgSkillDetailData.Element ~= 0 then
		local elementIconPath = CommonSlotUIApi:GetSkillElement(cfgSkillDetailData.Element)

		self.diyView.elementIcon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, elementIconPath, self.diyView.elementIcon:GetComponent("Image"))
	else
		self.diyView.elementIcon.gameObject:SetActive(false)
	end

	self.detailsType = Constant.ItemType.Skill
	self.targetCid = itemCfg.LikeId
end

function LotteryTipsView2_Item_Card:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView2_Item_Card:Dispose()
	self.view:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemClick)
	LuaCodeInterface.ClearOutlet(self.roleRoot, self.roleView)
	LuaCodeInterface.ClearOutlet(self.diyRoot, self.diyView)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil

	LuaUtility.UnLoadAsset(self)
end

local LotteryTipsView2_Item = {}

function LotteryTipsView2_Item.New(view)
	local obj = Clone(LotteryTipsView2_Item)

	obj:__Init(view)

	return obj
end

function LotteryTipsView2_Item:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self.cardTemplate.gameObject:SetActive(false)

	self.cardPool = UIViewObjectPool.New(self.cardTemplate, nil, function(_view)
		return LotteryTipsView2_Item_Card.New(_view)
	end)
end

function LotteryTipsView2_Item:Show(starNum, heroIds, itemIds, tipsCid)
	self.view.gameObject:SetActive(true)
	self:__RefreshStart(starNum)

	self.contentText:GetComponent("Text").text = LotteryUIApi:GetDetailTipsStarText(tipsCid)

	local path = LotteryUIApi:GetDetailTipsStarBg(starNum)

	AssetUtil.LoadImage(self, path, self.bgImg:GetComponent("Image"))
	self.cardPool:ForItems(function(_item)
		_item:Hide()
	end)
	ForArray(heroIds, function(_, _heroId)
		local cardItem = self.cardPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		cardItem:ShowRole(_heroId)
	end)
	ForArray(itemIds, function(_, _itemId)
		local cardItem = self.cardPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		cardItem:ShowDiy(_itemId)
	end)
end

function LotteryTipsView2_Item:__RefreshStart(starNum)
	for i = 0, self.startRoot.transform.childCount - 1 do
		self.startRoot.transform:GetChild(i).gameObject:SetActive(i < starNum)
	end
end

function LotteryTipsView2_Item:Hide()
	self.view.gameObject:SetActive(false)
end

function LotteryTipsView2_Item:Dispose()
	self.cardPool:ForItems(function(_item)
		_item:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local LotteryTipsView2 = Clone(LotteryTipsView)

LotteryTipsView2.templatePool = nil

function LotteryTipsView2.New(view)
	local obj = Clone(LotteryTipsView2)

	obj:Init(view)

	return obj
end

function LotteryTipsView2:__Init()
	LuaCodeInterface.BindOutlet(self.view, self)
	self.itemTemplate.gameObject:SetActive(false)

	self.templatePool = UIViewObjectPool.New(self.itemTemplate, nil, function(view)
		return LotteryTipsView2_Item.New(view)
	end)
end

function LotteryTipsView2:__Show()
	self.templatePool:ForItems(function(_item)
		_item:Hide()
	end)

	self.scrollContent.transform.localPosition = Vector3.zero

	local cardJackpotShowData = LotteryModule.GetCardJackpotShowConfig(self.cardJackpotID)

	if cardJackpotShowData == nil then
		return
	end

	local ShowDetailID = cardJackpotShowData.ShowDetail[1]

	if ShowDetailID == nil then
		return
	end

	local instructionData = CfgCardJackpotDetailTable[ShowDetailID]

	if instructionData == nil then
		return
	end

	for i = 5, 1, -1 do
		local heroIds = instructionData["Hero" .. i]
		local itemIds = instructionData["Item" .. i]
		local tipsCid = instructionData["StarTips" .. i]

		if heroIds ~= nil or itemIds ~= nil then
			self:__FillShowData(i, heroIds, itemIds, tipsCid)
		end
	end
end

function LotteryTipsView2:__FillShowData(starNum, heroIds, itemIds, tipsCid)
	local item = self.templatePool:GetFree(function(_item)
		return not _item.view.gameObject.activeSelf
	end)

	item:Show(starNum, heroIds, itemIds, tipsCid)
end

function LotteryTipsView2:__Dispose()
	self.templatePool:Dispose(function(item)
		item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

return LotteryTipsView2
