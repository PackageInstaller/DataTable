-- chunkname: @IQIGame\\UI\\Skin\\SkinUIFunctionButtonsPanel.lua

local SkinUIFunctionButtonsPanel = {}

function SkinUIFunctionButtonsPanel.New(view)
	local obj = Clone(SkinUIFunctionButtonsPanel)

	obj:Init(view)

	return obj
end

function SkinUIFunctionButtonsPanel:Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self:InitProperties()
	self:AddListeners()
	self:SetVisible(true)
	self:Refresh(0, 0, Constant.SkinState.NONE)
end

function SkinUIFunctionButtonsPanel:InitProperties()
	self.equipSkinButton = self.canEquipSkinPanelObj:GetComponentInChildren(typeof(UnityEngine.UI.Button), true)
	self.gainSkinButton = self.notHaveAndCanGetSkinPanelObj:GetComponentInChildren(typeof(UnityEngine.UI.Button), true)

	function self.DelegateOnEquipSkinButtonClick()
		self:OnEquipSkinButtonClick()
	end

	function self.DelegateOnGainSkinButtonClick()
		self:OnGainSkinButtonClick()
	end
end

function SkinUIFunctionButtonsPanel:DisposeProperties()
	self.equipSkinButton = nil
	self.gainSkinButton = nil
end

function SkinUIFunctionButtonsPanel:AddListeners()
	self.equipSkinButton.onClick:AddListener(self.DelegateOnEquipSkinButtonClick)
	self.gainSkinButton.onClick:AddListener(self.DelegateOnGainSkinButtonClick)
end

function SkinUIFunctionButtonsPanel:RemoveListeners()
	self.equipSkinButton.onClick:RemoveListener(self.DelegateOnEquipSkinButtonClick)
	self.gainSkinButton.onClick:RemoveListener(self.DelegateOnGainSkinButtonClick)
end

function SkinUIFunctionButtonsPanel:Dispose()
	self:RemoveListeners()
	self:DisposeProperties()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function SkinUIFunctionButtonsPanel:SetVisible(isVisible)
	LuaUtility.SetGameObjectShow(self.gameObject, isVisible)
end

function SkinUIFunctionButtonsPanel:Refresh(heroCid, skinCid, skinState)
	self.heroCid = heroCid
	self.skinCid = skinCid
	self.skinState = skinState

	self:RefreshFunctionPanel()
end

function SkinUIFunctionButtonsPanel:RefreshFunctionPanel()
	LuaUtility.SetGameObjectShow(self.curEquippingSkinPanelObj, self.skinState == Constant.SkinState.OwnedAndEquipping)
	LuaUtility.SetGameObjectShow(self.canEquipSkinPanelObj, self.skinState == Constant.SkinState.OwnedAndNotEquipping)
	LuaUtility.SetGameObjectShow(self.notHaveAndCanGetSkinPanelObj, self.skinState == Constant.SkinState.NotOwnAndCanGet)
	LuaUtility.SetGameObjectShow(self.notHaveAndCanNotGetSkinPanelObj, self.skinState == Constant.SkinState.NotOwnAndCanNotGet)

	local buttonDescObj = self:GetButtonDescObj(self.skinState)

	if buttonDescObj ~= nil then
		LuaUtility.SetText(buttonDescObj, SkinUIApi:GetSkinFunctionButtonDesc(self.skinState))
	end

	local skinDescObj = self:GetSkinDescObj(self.skinState)

	if skinDescObj ~= nil then
		local skinDescStr = SkinUIApi:GetSkinObtainDesc(self.skinCid)

		if skinDescStr ~= nil and skinDescStr ~= "" then
			LuaUtility.SetText(skinDescObj, skinDescStr)
			LuaUtility.SetGameObjectShow(skinDescObj, true)
		else
			LuaUtility.SetGameObjectShow(skinDescObj, false)
		end
	end
end

function SkinUIFunctionButtonsPanel:OnEquipSkinButtonClick()
	local haveSameSkinCanEquip, canTogetherEquipSkinCids = self:CheckIsHaveSameSkinGroupSkinItem(self.heroCid, self.skinCid)

	if haveSameSkinCanEquip then
		local function equipAllBtnClickCallback()
			SkinModule.ChangeSkinBySkinCid(self.heroCid, self.skinCid)

			for _, skinCid in pairs(canTogetherEquipSkinCids) do
				SkinModule.ChangeSkinBySkinCid(self.heroCid, skinCid)
			end
		end

		local function equipSingleBtnClickCallback()
			SkinModule.ChangeSkinBySkinCid(self.heroCid, self.skinCid)
		end

		if SettingModule.GetHadConfirmEquipSkinModeSetting() then
			if SettingModule.GetEquipSkinTogetherSetting() == 1 then
				equipAllBtnClickCallback()
			else
				equipSingleBtnClickCallback()
			end
		else
			EventDispatcher.Dispatch(EventID.ShowEquipSkinConfirmPanel, equipAllBtnClickCallback, equipSingleBtnClickCallback)
		end
	else
		SkinModule.ChangeSkinBySkinCid(self.heroCid, self.skinCid)
	end
end

function SkinUIFunctionButtonsPanel:OnGainSkinButtonClick()
	local skinItemCid = SkinModule.GetSkinItemCidBySkinCid(self.skinCid)
	local jumpFunctionCid = CfgItemTable[skinItemCid].Source[1]

	if jumpFunctionCid ~= nil then
		JumpModule.Jump(jumpFunctionCid)
	end
end

function SkinUIFunctionButtonsPanel:CheckIsHaveSameSkinGroupSkinItem(heroCid, skinCid)
	local isHave = false
	local sameSkinGroupSkinItemSkinCids = {}
	local skinGroupCid = SkinModule.GetSkinGroupCidBySkinCid(skinCid)
	local ownedSkinType = SkinModule.GetSkinTypeBySkinCid(skinCid)
	local sameSkinGroupSkinItemSkinType

	if ownedSkinType == Constant.SkinType.StaticImage then
		sameSkinGroupSkinItemSkinType = Constant.SkinType.SpineElementEntity
	elseif ownedSkinType == Constant.SkinType.SpineElementEntity then
		sameSkinGroupSkinItemSkinType = Constant.SkinType.StaticImage
	end

	if sameSkinGroupSkinItemSkinType ~= nil then
		local ownedSkinGroups = SkinModule.GetAllSkinGroupFromPlayerByHeroCid(heroCid)

		if ownedSkinGroups[skinGroupCid] ~= nil then
			for skinType, skinPOD in pairs(ownedSkinGroups[skinGroupCid]) do
				if self:IsSkinTypeLegal(skinType) and skinType ~= ownedSkinType and not SkinModule.IsHeroEquippingTargetSkinCid(heroCid, skinPOD.skinCid) then
					sameSkinGroupSkinItemSkinCids[skinType] = skinPOD.skinCid
					isHave = true
				end
			end
		end
	end

	return isHave, sameSkinGroupSkinItemSkinCids
end

function SkinUIFunctionButtonsPanel:IsSkinTypeLegal(skinType)
	if skinType == Constant.SkinType.StaticImage or skinType == Constant.SkinType.SpineElementEntity then
		return true
	end

	return false
end

function SkinUIFunctionButtonsPanel:GetButtonDescObj(skinState)
	local buttonDescObj

	if skinState == Constant.SkinState.OwnedAndEquipping then
		buttonDescObj = self.curEquippingSkinPanelObj.transform:Find("PanelRoot/ButtonDesc").gameObject
	elseif skinState == Constant.SkinState.OwnedAndNotEquipping then
		buttonDescObj = self.canEquipSkinPanelObj.transform:Find("PanelRoot/ButtonDesc").gameObject
	elseif skinState == Constant.SkinState.NotOwnAndCanGet then
		buttonDescObj = self.notHaveAndCanGetSkinPanelObj.transform:Find("PanelRoot/ButtonDesc").gameObject
	elseif skinState == Constant.SkinState.NotOwnAndCanNotGet then
		buttonDescObj = self.notHaveAndCanNotGetSkinPanelObj.transform:Find("PanelRoot/ButtonDesc").gameObject
	end

	return buttonDescObj
end

function SkinUIFunctionButtonsPanel:GetSkinDescObj(skinState)
	local SkinDescObj

	if skinState == Constant.SkinState.OwnedAndEquipping then
		-- block empty
	elseif skinState == Constant.SkinState.OwnedAndNotEquipping then
		-- block empty
	elseif skinState == Constant.SkinState.NotOwnAndCanGet then
		SkinDescObj = self.notHaveAndCanGetSkinPanelObj.transform:Find("PanelRoot/SkinDesc").gameObject
	elseif skinState == Constant.SkinState.NotOwnAndCanNotGet then
		SkinDescObj = self.notHaveAndCanNotGetSkinPanelObj.transform:Find("PanelRoot/SkinDesc").gameObject
	end

	return SkinDescObj
end

return SkinUIFunctionButtonsPanel
