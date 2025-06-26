-- chunkname: @IQIGame\\UI\\WarlockList\\WarlockListCell.lua

local m = {
	ischooseing = false,
	isBigCell = false
}
local LockElement = {}

function LockElement.New(view)
	local obj = Clone(LockElement)

	obj:__Init(view)

	return obj
end

function LockElement:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "BtnRoot", self.__OnCombination)
	EventUtil.AddEventListener(self, EventID.UpdateItem, self.__OnUpdateItemEventHandler)
	EventUtil.AddEventListener(self, EventID.AddItem, self.__OnAddItemEventHandler)
end

function LockElement:Show(heroCid)
	self.heroCid = heroCid

	self.gameObject:SetActive(true)
	self:__OnRefresh()
end

function LockElement:__OnRefresh()
	local _cfgCid, _needNum, _ownerNum = WarlockModule.GetLockedHeroCombinationData(self.heroCid)

	self.__combinationItemCid = _cfgCid
	self.canCombination = _needNum <= _ownerNum

	if _needNum <= 0 then
		self.canCombination = false

		self:__ChangeCombEffectRootActive(false)

		self.ContentText:GetComponent("Text").text = "0/0"

		return
	end

	if self.canCombination then
		self.ContentText:GetComponent("Text").text = "合成"
		self.canCombination = true

		self:__ChangeCombEffectRootActive(true)
	else
		self.ContentText:GetComponent("Text").text = string.format("%s/%s", _ownerNum, _needNum)

		self:__ChangeCombEffectRootActive(false)
	end
end

function LockElement:__ChangeCombEffectRootActive(active)
	if self.CombEffectRoot == nil then
		return
	end

	self.CombEffectRoot.gameObject:SetActive(active)
end

function LockElement:__OnCombination()
	if not self.canCombination then
		return
	end

	local tab = {}

	tab[self.__combinationItemCid] = 1

	ItemModule.CompositeItem(tab)
end

function LockElement:__OnUpdateItemEventHandler()
	if self.heroCid == 0 then
		return
	end

	self:__OnRefresh()
end

function LockElement:__OnAddItemEventHandler()
	self:__OnRefresh()
end

function LockElement:Hide()
	self.heroCid = 0
	self.canCombination = false

	self.gameObject:SetActive(false)
end

function LockElement:Dispose()
	self.heroCid = 0
	self.canCombination = false

	EventUtil.ClearEventListener(self)
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")

function m.New(go, mainView, isBigCell)
	local o = Clone(m)

	o:Initialize(go, mainView, isBigCell)

	return o
end

function m:Initialize(go, mainView, isBigCell)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.isBigCell = isBigCell
	self.cellName = self.NameText:GetComponent("Text")
	self.cellLv = self.CurGradeText:GetComponent("Text")
	self.cellbreakthrough = self.curDuanImage:GetComponent("Image")
	self.cellquality = self.qualityImage:GetComponent("Image")
	self.cellqualitybg = self.qualityBgImage:GetComponent("Image")
	self.cellElement = self.elementImage:GetComponent("Image")
	self.cellprofession = self.professionImage:GetComponent("Image")
	self.cellBreak = self.BreakImage:GetComponent("Image")
	self.cellMaxLvText = self.MaxGrade:GetComponent("Text")
	self.cellRoleImege = self.roleImage:GetComponent("Image")
	self.commonRoleStar = commonRoleStar.New(self.CommonRoleStar)

	function self.RefreshRedDotEvent()
		self:RefreshRedDot()
	end

	EventDispatcher.AddEventListener(EventID.roleRedDotEvent, self.RefreshRedDotEvent)

	self.LockElement = LockElement.New(self.UnlockRoot)
end

function m:Refresh(WarlockData)
	self.LockElement:Hide()

	self.WarlockData = WarlockData
	self.gameObject.name = self.WarlockData.cid
	self.cellName.text = self.WarlockData.BaseData.Name
	self.cellMaxLvText.text = self.WarlockData.BaseData.MaxLv
	self.cellMaxLvText.text = ""

	self:RefreshUpLv()
	self:RefreshElemenAndProfession()
	self:RefreshQualityAll()
	self:RefreshBreakAll()
	self:RefreshPersonalityAll()
	self:RefreshRoleImage()
	self:RefreshRedDot()
	self.commonRoleStar:RefreshStar(WarlockData)
	LuaUtility.SetGameObjectShow(self.Chooseing, WarlockData.ischooseing == true)
end

function m:RefreshLocked(heroCid)
	self.WarlockData = nil

	local cfg = CfgHeroTable[heroCid]

	self.LockElement:Show(heroCid)

	self.gameObject.name = heroCid
	self.cellName.text = cfg.Name
	self.cellMaxLvText.text = ""
	self.cellLv.text = 1

	self.commonRoleStar:RefreshStarByNumber(cfg.Quality, 0)

	local path1 = WarlockApi:GetElementIconPath(cfg.Elements)

	AssetUtil.LoadImage(self, path1, self.cellElement, function()
		self.cellElement:SetNativeSize()
	end)

	local path2 = WarlockApi:GetProfessionIconPath(cfg.Profession)

	AssetUtil.LoadImage(self, path2, self.cellprofession, function()
		self.cellprofession:SetNativeSize()
	end)

	local qualitypath = WarlockApi:GetWarlockChooseUIQuality(cfg.Quality)
	local qualitybgPath = WarlockApi:GetWarlockChooseUIQualityBg(cfg.Quality)

	AssetUtil.LoadImage(self, qualitypath, self.cellquality, function()
		self.cellquality:SetNativeSize()
	end)
	AssetUtil.LoadImage(self, qualitybgPath, self.cellqualitybg, function()
		self.cellqualitybg:SetNativeSize()
	end)
	AssetUtil.LoadImage(self, WarlockApi:GetGradPathImagePath(1), self.cellbreakthrough, function()
		return
	end)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreakIconPath(1), self.cellBreak, function()
		return
	end)
	LuaUtility.SetGameObjectShow(self.personalityParent, false)

	local path = SkinModule.GetHeroDefaultSkinImgPath(heroCid, Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.cellRoleImege, function()
		self.cellRoleImege:SetNativeSize()
	end)
	LuaUtility.SetGameObjectShow(self.RedDot_Warlock, false)
	LuaUtility.SetGameObjectShow(self.Chooseing, false)
end

function m:IsChooseIng(b_isActive)
	LuaUtility.SetGameObjectShow(self.Chooseing, b_isActive)

	self.WarlockData.ischooseing = b_isActive
end

function m:RefreshUpLv()
	self.cellLv.text = self.WarlockData.lv
end

function m:RefreshElemenAndProfession()
	local path1 = WarlockApi:GetElementIconPath(CfgHeroTable[self.WarlockData.cid].Elements)

	AssetUtil.LoadImage(self, path1, self.cellElement, function()
		self.cellElement:SetNativeSize()
	end)

	local path2 = WarlockApi:GetProfessionIconPath(CfgHeroTable[self.WarlockData.cid].Profession)

	AssetUtil.LoadImage(self, path2, self.cellprofession, function()
		self.cellprofession:SetNativeSize()
	end)
end

function m:RefreshQualityAll()
	local qualitypath, qualitybgPath = WarlockApi:GetQualityImagePath(self.WarlockData)

	AssetUtil.LoadImage(self, qualitypath, self.cellquality, function()
		self.cellquality:SetNativeSize()
	end)
	AssetUtil.LoadImage(self, qualitybgPath, self.cellqualitybg, function()
		self.cellqualitybg:SetNativeSize()
	end)
end

function m:RefreshBreakAll()
	AssetUtil.LoadImage(self, WarlockApi:GetGradPathImagePath(self.WarlockData.breakLv), self.cellbreakthrough, function()
		return
	end)
	AssetUtil.LoadImage(self, RoleDevelopmentApi:GetBreakIconPath(self.WarlockData.breakLv), self.cellBreak, function()
		return
	end)
end

function m:RefreshPersonalityAll()
	LuaUtility.SetGameObjectShow(self.personalityParent, #self.WarlockData.personality > 0)
	LuaUtility.SetText(self.personalityNumText, BattleUIApi:GetBattleActionOrderText(#self.WarlockData.personality))
end

function m:OnLoadImgSoulSucceed(assetName, asset, duration, userData)
	return
end

function m:OnLoadFailed(assetName, status, errorMessage, userData)
	log("load asset error: " .. assetName)
end

function m:OnHide()
	return
end

function m:RefreshRoleImage()
	local path = self.WarlockData:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage(self, path, self.cellRoleImege, function()
		self.cellRoleImege:SetNativeSize()
	end)
end

function m:RefreshRedDot()
	if self.WarlockData == nil then
		LuaUtility.SetGameObjectShow(self.RedDot_Warlock, false)
	else
		LuaUtility.SetGameObjectShow(self.RedDot_Warlock, RedDotModule.CanShowRedDot_WarlockItem(self.WarlockData.cid))
	end
end

function m:OnDestroy()
	self.LockElement:Dispose()
	EventDispatcher.RemoveEventListener(EventID.roleRedDotEvent, self.RefreshRedDotEvent)
	self.commonRoleStar:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
	self.mainView = nil
end

return m
