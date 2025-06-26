-- chunkname: @IQIGame\\UI\\FurnitureResultUI.lua

local FurnitureResultUI = Base:Extend("FurnitureResultUI", "IQIGame.Onigao.UI.FurnitureResultUI", {})
local FurnitureSlot = require("IQIGame.UI.Common.FurnitureSlot")

function FurnitureResultUI:OnInit()
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.TextSure:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextSure")

	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end
end

function FurnitureResultUI:GetPreloadAssetPaths()
	return nil
end

function FurnitureResultUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FurnitureResultUI:OnOpen(userData)
	self.baseShowItems = userData[1]
	self.showItems = userData[2]

	self:UpdateView()
end

function FurnitureResultUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateClickBtnClose)
end

function FurnitureResultUI:OnClose(userData)
	return
end

function FurnitureResultUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateClickBtnClose)
end

function FurnitureResultUI:OnPause()
	return
end

function FurnitureResultUI:OnResume()
	return
end

function FurnitureResultUI:OnCover()
	return
end

function FurnitureResultUI:OnReveal()
	return
end

function FurnitureResultUI:OnRefocus(userData)
	return
end

function FurnitureResultUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function FurnitureResultUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FurnitureResultUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FurnitureResultUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FurnitureResultUI:OnDestroy()
	FurnitureSlot.DisposeIn(self)

	self.baseShowItems = nil
	self.showItems = nil
end

function FurnitureResultUI:UpdateView()
	local str = ""

	if #self.baseShowItems > 0 then
		for i, v in pairs(self.baseShowItems) do
			local cfgItem = CfgItemTable[v.cid]

			str = str .. cfgItem.Name .. " x" .. v.num .. ","
		end
	end

	self.TextReward:GetComponent("Text").text = FurnitureLotteryUIApi:GetString("TextReward", str)

	local parentTransform = self.Furniture.transform

	for i = 0, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(0).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	for i, v in pairs(self.showItems) do
		local tab = {}
		local starObj = UnityEngine.Object.Instantiate(self.Grid)

		starObj:SetActive(true)
		starObj.transform:SetParent(parentTransform, false)
		LuaCodeInterface.BindOutlet(starObj, tab)

		local cfgItem = CfgItemTable[v.cid]

		tab.TextName:GetComponent("Text").text = FurnitureSlotApi:GetString("TextColorName", cfgItem.Name, cfgItem.Quality)

		local obj = tab.Slot.transform:GetChild(0).gameObject
		local furnitureCell = FurnitureSlot.PackageOrReuseView(self, obj)

		furnitureCell:SetItem(v.cid, true)
		LuaCodeInterface.ClearOutlet(starObj, tab)
	end
end

function FurnitureResultUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.FurnitureResultUI)
end

return FurnitureResultUI
