-- chunkname: @IQIGame\\UI\\Common\\CommonRoleDisplayView.lua

local CommonRoleDisplaySpineView = require("IQIGame/UI/Common/CommonRoleDisplaySpineView")
local CommonRoleDisplayView = {
	showPosition = 0
}

function CommonRoleDisplayView.New(view, showPosition)
	local obj = Clone(CommonRoleDisplayView)

	obj:__Init(view, showPosition)

	return obj
end

function CommonRoleDisplayView:__Init(view, showPosition)
	self.gameObject = view
	self.showPosition = showPosition
	self.bgmSerialID = 0

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.spineView = CommonRoleDisplaySpineView.New(self.skinSpineRoot, self.showPosition)
end

function CommonRoleDisplayView:Show(skinCid, userData)
	if self.skinCid == skinCid then
		return
	end

	self.userData = userData

	self:RefreshSpineView(skinCid)

	if not EventUtil.HasEventListener(self, EventID.UIGroupTopUIChange) then
		EventUtil.AddEventListener(self, EventID.UIGroupTopUIChange, self.__OnUIGroupTopUIChangeEventHandler)
	end
end

function CommonRoleDisplayView:RefreshSpineView(skinCid)
	self.skinCid = skinCid

	self.gameObject:SetActive(true)

	local heroSkinData = CfgHeroSkinTable[self.skinCid]

	if self.showPosition == Constant.DynamicSkinShowPosition.MobilePhone then
		if not UIModule.MainUIIsVisible() then
			self.__isShowing = false

			return
		end

		if heroSkinData.BGM ~= nil and heroSkinData.BGM ~= 0 then
			self:__ChangeBGM(heroSkinData.BGM)
		else
			self:__RemoveBGM()
		end
	end

	if heroSkinData.UIDynamicEntityID ~= nil and heroSkinData.UIDynamicEntityID ~= 0 then
		self.__isShowing = true

		local userData = self.userData or {}

		userData.__skinEntityCid = heroSkinData.UIDynamicEntityID
		userData.__skinDiscreteCid = self.skinCid

		self.spineView:Show(userData)
		self:__HideVerticalDrawImage()
	else
		self.__isShowing = false

		self.spineView:Hide()

		local verticalDrawPath = SkinModule.GetHeroSkinImgPathByType(heroSkinData, Constant.SkinImageType.HeroResourcesVerticalDraw)

		self:__ShowVerticalDrawImage(verticalDrawPath)
	end
end

function CommonRoleDisplayView:PlayBGM(bgmCid)
	if self.showPosition ~= Constant.DynamicSkinShowPosition.MobilePhone then
		return
	end

	self:__ChangeBGM(bgmCid)
end

function CommonRoleDisplayView:__ChangeBGM(bgmCid)
	if self.__playingBMGCid == bgmCid then
		return
	end

	self.__playingBMGCid = bgmCid

	if self.bgmSerialID == 0 then
		self.bgmSerialID = LuaUtility.PlayBGMWithID(bgmCid)
	else
		LuaUtility.ReplaceBGM(self.bgmSerialID, bgmCid)
	end
end

function CommonRoleDisplayView:__RemoveBGM()
	if self.showPosition ~= Constant.DynamicSkinShowPosition.MobilePhone then
		return
	end

	if self.bgmSerialID == 0 then
		return
	end

	LuaUtility.RemoveBGM(self.bgmSerialID)

	self.bgmSerialID = 0
end

function CommonRoleDisplayView:Hide()
	EventUtil.RemoveEventListener(self, EventID.UIGroupTopUIChange)
	self:__RemoveBGM()

	self.skinCid = nil

	self.gameObject:SetActive(false)
	self.spineView:Hide()
end

function CommonRoleDisplayView:Dispose()
	EventUtil.ClearEventListener(self)
	self:__RemoveBGM()
	self.spineView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function CommonRoleDisplayView:OnCover()
	self.__isShowing = false

	self:__RemoveBGM()

	if self.spineView == nil then
		return
	end

	self.spineView:Hide()
end

function CommonRoleDisplayView:OnReveal()
	if self.skinCid == 0 then
		return
	end

	if self.skinCid == nil then
		return
	end

	if self.__isShowing then
		return
	end

	self:RefreshSpineView(self.skinCid, self.userData)
end

function CommonRoleDisplayView:__OnUIGroupTopUIChangeEventHandler(groupName, uiName)
	if self.skinCid == nil then
		return
	end

	if self.skinCid == 0 then
		return
	end

	if self.showPosition == Constant.DynamicSkinShowPosition.BattleResultUI then
		return
	end

	if self.showPosition == Constant.DynamicSkinShowPosition.MobilePhone_Skin then
		return
	end

	if not self.gameObject.activeInHierarchy then
		return
	end

	if groupName ~= Constant.UILayer.UI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.BuffTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.CommonEquipSuitTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.CommonEquipTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.CommonGiftTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.CommonItemTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.CommonSkillTipsUI then
		return
	end

	if UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.BuyResItemUI then
		return
	end

	local needShow = false

	if self.showPosition == Constant.DynamicSkinShowPosition.RoleDevelopmentPanel then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.RoleDevelopmentPanel
	elseif self.showPosition == Constant.DynamicSkinShowPosition.SkinPanel then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.HeroSkinUI
	elseif self.showPosition == Constant.DynamicSkinShowPosition.MobilePhone then
		needShow = LuaUtility.StrIsNullOrEmpty(uiName)
	elseif self.showPosition == Constant.DynamicSkinShowPosition.GetHero then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.GetSkinShowUI
	elseif self.showPosition == Constant.DynamicSkinShowPosition.UserInfo then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.UserInfoUI
	elseif self.showPosition == Constant.DynamicSkinShowPosition.RoleInfoDetails then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.RoleInfoDetailsUI
	elseif self.showPosition == Constant.DynamicSkinShowPosition.DetailsPreviewUI then
		needShow = UIModule.GetUINameWithoutClone(uiName) == Constant.UIControllerName.DetailsPreviewUI
	end

	if needShow then
		self:OnReveal()
	else
		self:OnCover()
	end
end

function CommonRoleDisplayView:__ShowVerticalDrawImage(imgPath)
	self.skinImageRoot.gameObject:SetActive(true)
	AssetUtil.LoadImage_VerticalDraw(self, imgPath, self.skinImage)
end

function CommonRoleDisplayView:__HideVerticalDrawImage()
	self.skinImageRoot.gameObject:SetActive(false)
end

return CommonRoleDisplayView
