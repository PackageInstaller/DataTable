-- chunkname: @IQIGame\\UI\\RoleInfoDetails\\RoleBaseInfoView.lua

local m = {}
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local favorAttributePanelClass = require("IQIGame/UI/RoleInfoDetails/RoleInfoDetails_FavorAttributePanel")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.displayView = CommonRoleDisplayView.New(self.RoleDisplayViewRoot, Constant.DynamicSkinShowPosition.RoleInfoDetails)
	self.attributePanel = favorAttributePanelClass.New(self.AttributePopUp, self)

	self.attributePanel:Hide()
	self:InitDelegate()
	self:AddListeners()
end

function m:InitDelegate()
	function self.delegateOnClickAttributeDetailedBtn()
		self:OnClickAttributeDetailedBtn()
	end

	function self.delegateOnClickButtonMessage()
		self:OnClickButtonMessage()
	end
end

function m:AddListeners()
	self.AttributeDetailedBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickAttributeDetailedBtn)
	self.buttonMessage:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMessage)
	EventUtil.AddEventListener(self, EventID.UnlockFunction)
	EventUtil.AddEventListener(self, EventID.FavorabilityExpItemResult)
end

function m:RemoveListeners()
	self.AttributeDetailedBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickAttributeDetailedBtn)
	self.buttonMessage:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMessage)
	EventUtil.ClearEventListener(self)
end

function m:__OnFavorabilityExpItemResultHandler(isUp)
	if isUp then
		LuaUtility.SetGameObjectShow(self.effectFavorUp, false)
		LuaUtility.SetGameObjectShow(self.effectFavorUp, true)
	end
end

function m:__OnUnlockFunctionHandler()
	local funcList = {}

	funcList[Constant.UnlockType.FUNC_Affinity] = self.FavoriteItem

	UnlockFunctionModule.FuncSwitchHandler(funcList)
end

function m:OnClickButtonMessage()
	UIModule.Open(Constant.UIControllerName.AffinityChatUI, Constant.UILayer.UI, {
		selectRole = self.heroCid
	})
end

function m:OnClickAttributeDetailedBtn()
	self.attributePanel:Show()
	self.attributePanel:Refresh(self.heroCid)
end

function m:SetData(heroCid)
	self.cfgData = RoleInfoDetailsModule.GetHeroCfg(heroCid)
	self.warlockData = WarlockModule.GetHeroData(heroCid)
	self.heroCid = heroCid
	self.prepareAddFavorValue = 0

	self:__OnUnlockFunctionHandler()
	self:RefreshProgress()
	UGUIUtil.SetText(self.CNName, self.cfgData.Name)
	UGUIUtil.SetText(self.ENName, self.cfgData.EnglishName)
	UGUIUtil.SetText(self.CNCV, self.cfgData.JpCVName)
	UGUIUtil.SetText(self.ENCV, self.cfgData.JpCVName)

	local skinCfg = SkinModule.GetHeroCurrentSkinConfig(heroCid)

	self.displayView:Show(skinCfg.Id)
	LuaUtility.SetGameObjectShow(self.favorMax, self.warlockData:GetMaxFavorLv() == self.warlockData.favorabilityLevel)
	LuaUtility.SetGameObjectShow(self.favorGiftIcon, self.warlockData:GetMaxFavorLv() ~= self.warlockData.favorabilityLevel)
end

function m:PrepareAddFavor(value)
	self.prepareAddFavorValue = self.prepareAddFavorValue + value

	self:RefreshProgress()
end

function m:PrepareReduceFavor(value)
	self.prepareAddFavorValue = self.prepareAddFavorValue - value

	self:RefreshProgress()
end

function m:ResetFavorPrepare()
	self.prepareAddFavorValue = 0

	self:RefreshProgress()
end

function m:SetFavorProgress(value)
	LuaUtility.SetImageFillAmount(self.favoriteImg, value)
end

function m:RefreshProgress()
	local cfgFavorLv = RoleInfoDetailsModule.GetHeroFavorLevelCfg(self.heroCid, self.warlockData.favorabilityLevel)

	self:SetFavorProgress((self.warlockData.favorabilityExp + self.prepareAddFavorValue) / cfgFavorLv.FavorExp)
end

function m:LoadImage(path, imgobj)
	AssetUtil.LoadImage(self, path, imgobj, self.LoadImageSucess, nil, imgobj)
end

function m:LoadImageSucess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function m:Dispose()
	self.attributePanel:OnDestroy()
	self.displayView:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
