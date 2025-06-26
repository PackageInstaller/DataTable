-- chunkname: @IQIGame\\UI\\EquipUpLevelTipUI.lua

local EquipUpLevelTipUI = {}

EquipUpLevelTipUI = Base:Extend("EquipUpLevelTipUI", "IQIGame.Onigao.UI.EquipUpLevelTipUI", EquipUpLevelTipUI)

local AttrItemClass = require("IQIGame/UI/EquipUpLevelTipUI/EquipUpLevelTip_AttrItem")

function EquipUpLevelTipUI:OnInit()
	self:InitMembers()
	self:InitComponent()
	self:InitDelegate()
end

function EquipUpLevelTipUI:InitMembers()
	self.AttrItemArray = {}
end

function EquipUpLevelTipUI:InitComponent()
	self.imageMainIcon = self.imageMainIcon:GetComponent("Image")
end

function EquipUpLevelTipUI:InitDelegate()
	function self.delegateOnClickButtonClose()
		UIModule.CloseSelf(self)
	end
end

function EquipUpLevelTipUI:OnAddListeners()
	self.buttonClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClose)
end

function EquipUpLevelTipUI:OnRemoveListeners()
	self.buttonClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClose)
end

function EquipUpLevelTipUI:OnOpen(userData)
	self:Refresh(userData.oldEquipPOD, userData.equipPOD)
end

function EquipUpLevelTipUI:OnClose(userData)
	return
end

function EquipUpLevelTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function EquipUpLevelTipUI:GetPreloadAssetPaths()
	return nil
end

function EquipUpLevelTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EquipUpLevelTipUI:IsManualShowOnOpen(userData)
	return false
end

function EquipUpLevelTipUI:GetBGM(userData)
	return nil
end

function EquipUpLevelTipUI:OnPause()
	return
end

function EquipUpLevelTipUI:OnResume()
	return
end

function EquipUpLevelTipUI:OnCover()
	return
end

function EquipUpLevelTipUI:OnReveal()
	return
end

function EquipUpLevelTipUI:OnRefocus(userData)
	return
end

function EquipUpLevelTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EquipUpLevelTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EquipUpLevelTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EquipUpLevelTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EquipUpLevelTipUI:Refresh(oldEquipData, currentEquipData)
	LuaUtility.SetText(self.textLastLevel, oldEquipData.lv)
	LuaUtility.SetText(self.textCurrentLevel, currentEquipData.lv)

	for id, value in pairs(currentEquipData.masterAttrs) do
		local cfgEquipAttr = CfgUtil.CfgEquipAttrDataWithID(id)
		local cfgAttribute = CfgUtil.GetCfgAttributeDataWithID(cfgEquipAttr.MasterAttrType)

		LuaUtility.LoadImage(self, UIGlobalApi.IconPath .. cfgAttribute.ImageUrl, self.imageMainIcon)
		LuaUtility.SetText(self.textMainAttName, cfgAttribute.Name)
		LuaUtility.SetText(self.textMainLastValue, CommonEquipTipsUIApi:GetMainAttributeText(EquipApi:FormatAttrValue(cfgAttribute.IsPer, oldEquipData.masterAttrs[id])))
		LuaUtility.SetText(self.textMainCurrentValue, CommonEquipTipsUIApi:GetMainAttributeText(EquipApi:FormatAttrValue(cfgAttribute.IsPer, value)))

		break
	end

	table.sort(oldEquipData.slaverAttrs, function(a, b)
		return a.equipLevel < b.equipLevel
	end)
	table.sort(currentEquipData.slaverAttrs, function(a, b)
		return a.equipLevel < b.equipLevel
	end)

	local index = 1
	local slaverAttr = currentEquipData.slaverAttrs

	for i, v in pairs(slaverAttr) do
		if math.abs(oldEquipData.slaverAttrs[i].attrValue - v.attrValue) ~= 0 then
			local item = self:_GetItem(index)

			item:Refresh(oldEquipData.slaverAttrs[i], v)
			item:Show()

			index = index + 1
		end
	end

	LuaUtility.SetGameObjectShow(self.textNewAdditionalAttr, index > 1)

	local len = #self.AttrItemArray

	for i = index, len do
		self.AttrItemArray[i]:Hide()
	end
end

function EquipUpLevelTipUI:_GetItem(index)
	if not self.AttrItemArray[index] then
		local o = GameObject.Instantiate(self.additionalAttributePrefab, self.additionalAttributeRoot.transform)

		self.AttrItemArray[index] = AttrItemClass.New(o, self)
	end

	return self.AttrItemArray[index]
end

return EquipUpLevelTipUI
