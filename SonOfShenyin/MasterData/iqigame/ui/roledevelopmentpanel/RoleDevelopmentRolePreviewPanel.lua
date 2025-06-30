-- chunkname: @IQIGame\\UI\\RoleDevelopmentPanel\\RoleDevelopmentRolePreviewPanel.lua

local RoleDevelopmentPanelBase = require("IQIGame/UI/RoleDevelopmentPanel/RoleDevelopmentPanelBase")
local commonRoleStar = require("IQIGame.UI.Common.RoleStar.CommonRoleStar")
local CommonRoleDisplayView = require("IQIGame/UI/Common/CommonRoleDisplayView")
local panel = Clone(RoleDevelopmentPanelBase)

function panel:__OnInit()
	function self.__OnRoleBreakThroughEventProxy()
		self:__OnRefresh()
	end

	function self.delegateOnClickPortraitImage()
		self:OnClickPortraitImage()
	end

	function self.__OnChangeSkinResult()
		self:__OnRefresh()
	end

	function self.DelegateAscendingStartSucess()
		self:__OnRefresh()
	end

	self.commonRoleStar = commonRoleStar.New(self.com_RoleStar)
	self.displayView = CommonRoleDisplayView.New(self.roleDisplayViewRoot, Constant.DynamicSkinShowPosition.RoleDevelopmentPanel)
end

function panel:__OnAddListeners()
	EventDispatcher.AddEventListener(EventID.RoleBreakThroughSucess, self.__OnRoleBreakThroughEventProxy)
	EventDispatcher.AddEventListener(EventID.ChangeSkinResult, self.__OnChangeSkinResult)
	EventDispatcher.AddEventListener(EventID.AscendingStartSucess, self.DelegateAscendingStartSucess)
end

function panel:__OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.RoleBreakThroughSucess, self.__OnRoleBreakThroughEventProxy)
	EventDispatcher.RemoveEventListener(EventID.ChangeSkinResult, self.__OnChangeSkinResult)
	EventDispatcher.RemoveEventListener(EventID.AscendingStartSucess, self.DelegateAscendingStartSucess)
end

function panel:OnClickPortraitImage()
	CVModule.PlayCV(Constant.CVActionType.RoleDetailUIClick, self.roleCid)
end

function panel:__OnShow()
	self:SetActive(true)
	self:__ShowRole()
end

function panel:__OnRefresh()
	self:__ShowRole()
end

function panel:__OnHide()
	self:SetActive(false)
end

function panel:__OnDispose()
	self.commonRoleStar:Dispose()
	self.displayView:Dispose()
end

function panel:__ShowRole()
	local heroWarlockData = WarlockModule.WarlockDataDic[self.roleCid]
	local heroData = heroWarlockData:GetCfg()
	local elementPath = WarlockApi:GetElementIconPath(heroData.Elements)

	AssetUtil.LoadImage(self, elementPath, self.elementImage:GetComponent("Image"), self.__OnLoadImageSucess, nil, self.elementImage)

	local professionPath = WarlockApi:GetProfessionIconPath(heroData.Profession)

	AssetUtil.LoadImage(self, professionPath, self.professionImage:GetComponent("Image"), self.__OnLoadImageSucess, nil, self.professionImage)

	local forcePath = WarlockApi:GetForceImgPath(heroData.Forces)

	AssetUtil.LoadImage(self, forcePath, self.forceImage:GetComponent("Image"), self.__OnLoadImageSucess, nil, self.forceImage)
	UGUIUtil.SetText(self.nameText, heroData.Name)
	self.commonRoleStar:RefreshStar(heroWarlockData)

	local skinCfg = SkinModule.GetHeroCurrentSkinConfig(self.roleCid)

	self.displayView:Show(skinCfg.Id)
end

function panel:__OnLoadImageSucess(assetName, asset, duration, userData)
	local img = userData:GetComponent("Image")

	img:SetNativeSize()
	LuaUtility.SetImageRectTransformPivot(userData:GetComponent("RectTransform"), img)
end

function panel:__OnCover()
	return
end

function panel:__OnReveal()
	return
end

return panel
