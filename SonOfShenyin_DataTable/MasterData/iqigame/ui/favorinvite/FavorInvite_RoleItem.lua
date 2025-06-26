-- chunkname: @IQIGame\\UI\\FavorInvite\\FavorInvite_RoleItem.lua

local FavorInvite_RoleItem = {}
local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")

function FavorInvite_RoleItem.New(go, mainView)
	local o = Clone(FavorInvite_RoleItem)

	o:Initialize(go, mainView)

	return o
end

function FavorInvite_RoleItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.mainView = mainView
	self.gameObject = go

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function FavorInvite_RoleItem:InitComponent()
	self.commonRoleStar = commonRoleStar.New(self.CommonRoleStar)
end

function FavorInvite_RoleItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function FavorInvite_RoleItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function FavorInvite_RoleItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function FavorInvite_RoleItem:OnClickButtonClick()
	self.mainView:OnRoleClick(self)
end

function FavorInvite_RoleItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function FavorInvite_RoleItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function FavorInvite_RoleItem:Selected()
	LuaUtility.SetGameObjectShow(self.Chooseing, true)
end

function FavorInvite_RoleItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.Chooseing, false)
end

function FavorInvite_RoleItem:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.name, self.data.BaseData.Name)
	LuaUtility.SetText(self.CurGrade, self.data.lv)
	AssetUtil.LoadImage_SetNativeSize(self, WarlockApi:GetElementIconPath(self.data.BaseData.Elements), self.element:GetComponent("Image"))
	AssetUtil.LoadImage_SetNativeSize(self, WarlockApi:GetProfessionIconPath(self.data.BaseData.Profession), self.profession:GetComponent("Image"))

	local qualityPath, qualityBgPath = WarlockApi:GetQualityImagePath(self.data)

	AssetUtil.LoadImage_SetNativeSize(self, qualityPath, self.quality:GetComponent("Image"))
	AssetUtil.LoadImage_SetNativeSize(self, qualityBgPath, self.qualitybg:GetComponent("Image"))
	LuaUtility.SetText(self.textFavorLv, self.data.favorabilityLevel)
	LuaUtility.SetGameObjectShow(self.personalityParent, #self.data.personality > 0)
	LuaUtility.SetText(self.personalityNum, BattleUIApi:GetBattleActionOrderText(#self.data.personality))

	local path = self.data:GetCurStaticSkinImagePath(Constant.SkinImageType.HeroResourcesShowImg)

	AssetUtil.LoadImage_SetNativeSize(self, path, self.RoleImage:GetComponent("Image"))
	self.commonRoleStar:RefreshStar(self.data)

	if self.mainView.crrSelectRoleId == self.data.cid then
		self:Selected()
	else
		self:UnSelected()
	end
end

function FavorInvite_RoleItem:OnDestroy()
	self:RemoveListener()
	self.commonRoleStar:Dispose()
end

return FavorInvite_RoleItem
