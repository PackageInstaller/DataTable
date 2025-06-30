-- chunkname: @IQIGame\\UI\\HeroIntroduceUI.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local SubItemCard = {}

function SubItemCard.New(view)
	local obj = Clone(SubItemCard)

	obj:__Init(view)

	return obj
end

function SubItemCard:__Init(view)
	self.view = view
	self.roleView = {}

	LuaCodeInterface.BindOutlet(self.view, self)
	LuaCodeInterface.BindOutlet(self.roleRoot, self.roleView)

	function self.__delegateOnItemClick()
		UIModule.Open(Constant.UIControllerName.DetailsPreviewUI, Constant.UILayer.UI, {
			type = self.detailsType,
			cid = self.targetCid
		})
	end

	self.view:GetComponent("Button").onClick:AddListener(self.__delegateOnItemClick)

	self.grayComponent = self.view:GetComponent("GrayComponent")
end

function SubItemCard:ShowRole(roleID)
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

	local heroData = WarlockModule.GetHeroData(roleID)
	local gray = heroData == nil

	self.grayComponent:SetGray(gray)
end

function SubItemCard:Hide()
	self.view.gameObject:SetActive(false)
end

function SubItemCard:Dispose()
	self.view:GetComponent("Button").onClick:RemoveListener(self.__delegateOnItemClick)

	self.grayComponent = nil

	LuaCodeInterface.ClearOutlet(self.roleRoot, self.roleView)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil

	LuaUtility.UnLoadAsset(self)
end

local SubItem = {}

function SubItem.New(view)
	local obj = Clone(SubItem)

	obj:__Init(view)

	return obj
end

function SubItem:__Init(view)
	self.view = view

	LuaCodeInterface.BindOutlet(self.view, self)
	self.cardTemplate.gameObject:SetActive(false)

	self.cardPool = UIViewObjectPool.New(self.cardTemplate, nil, function(_view)
		return SubItemCard.New(_view)
	end)
end

function SubItem:Show(cfg)
	self.view.gameObject:SetActive(true)

	self.TitleText:GetComponent("Text").text = cfg.TitleText
	self.ContentText:GetComponent("Text").text = cfg.IntroduceText

	self.cardPool:ForItems(function(_item)
		_item:Hide()
	end)
	ForArray(cfg.IntroduceHero, function(_, _heroId)
		local cardItem = self.cardPool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		cardItem:ShowRole(_heroId)
	end)
end

function SubItem:Hide()
	self.view.gameObject:SetActive(false)
end

function SubItem:Dispose()
	self.cardPool:ForItems(function(_item)
		_item:Dispose()
	end)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.view, self)

	self.view = nil
end

local HeroIntroduceUI = {
	subItemTable = {}
}

HeroIntroduceUI = Base:Extend("HeroIntroduceUI", "IQIGame.Onigao.UI.HeroIntroduceUI", HeroIntroduceUI)

function HeroIntroduceUI:OnInit()
	self:__OnInit()
end

function HeroIntroduceUI:GetPreloadAssetPaths()
	return
end

function HeroIntroduceUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HeroIntroduceUI:IsManualShowOnOpen(userData)
	return false
end

function HeroIntroduceUI:GetBGM(userData)
	return
end

function HeroIntroduceUI:OnOpen(userData)
	self:__OnShow(userData)
end

function HeroIntroduceUI:OnClose(userData)
	return
end

function HeroIntroduceUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn", self.__OnCloseBtnClick)
end

function HeroIntroduceUI:OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
end

function HeroIntroduceUI:OnPause()
	return
end

function HeroIntroduceUI:OnResume()
	return
end

function HeroIntroduceUI:OnCover()
	return
end

function HeroIntroduceUI:OnReveal()
	return
end

function HeroIntroduceUI:OnRefocus(userData)
	return
end

function HeroIntroduceUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HeroIntroduceUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HeroIntroduceUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HeroIntroduceUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HeroIntroduceUI:OnDestroy()
	self:__OnDispose()
end

function HeroIntroduceUI:__OnInit()
	self.SubItemTemplate.gameObject:SetActive(false)

	self.templatePool = UIViewObjectPool.New(self.SubItemTemplate, nil, function(view)
		return SubItem.New(view)
	end)
end

function HeroIntroduceUI:__OnShow(args)
	self.templatePool:ForItems(function(_item)
		_item:Hide()
	end)

	self.ScrollContentRoot.transform.localPosition = Vector3.zero

	local tabs = {}

	ForPairs(CfgHeroIntroduceTable, function(_, _cfg)
		table.insert(tabs, _cfg)
	end)
	table.sort(tabs, function(a, b)
		return a.Order < b.Order
	end)
	ForArray(tabs, function(_, _cfg)
		local item = self.templatePool:GetFree(function(_item)
			return not _item.view.gameObject.activeSelf
		end)

		item:Show(_cfg)
	end)
end

function HeroIntroduceUI:__OnDispose()
	self.templatePool:Dispose(function(item)
		item:Dispose()
	end)
end

function HeroIntroduceUI:__OnCloseBtnClick()
	UIModule.Close(Constant.UIControllerName.HeroIntroduceUI)
end

return HeroIntroduceUI
