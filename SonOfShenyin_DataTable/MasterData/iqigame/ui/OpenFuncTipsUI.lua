-- chunkname: @IQIGame\\UI\\OpenFuncTipsUI.lua

local OpenFuncTipsUI = {
	ItemListLen = 0,
	ItemList = {},
	CurShowItemList = {}
}

OpenFuncTipsUI = Base:Extend("OpenFuncTipsUI", "IQIGame.Onigao.UI.OpenFuncTipsUI", OpenFuncTipsUI)

function OpenFuncTipsUI:OnInit()
	UGUIUtil.SetText(self.Title, OpenFuncTipsUIApi:GetFunctionOpenTitleText())
end

function OpenFuncTipsUI:GetPreloadAssetPaths()
	return nil
end

function OpenFuncTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function OpenFuncTipsUI:IsManualShowOnOpen(userData)
	return false
end

function OpenFuncTipsUI:GetBGM(userData)
	return nil
end

function OpenFuncTipsUI:OnOpen(userData)
	self:RefreshView()
end

function OpenFuncTipsUI:OnClose(userData)
	return
end

function OpenFuncTipsUI:OnAddListeners()
	return
end

function OpenFuncTipsUI:OnRemoveListeners()
	return
end

function OpenFuncTipsUI:OnPause()
	return
end

function OpenFuncTipsUI:OnResume()
	return
end

function OpenFuncTipsUI:OnCover()
	return
end

function OpenFuncTipsUI:OnReveal()
	return
end

function OpenFuncTipsUI:OnRefocus(userData)
	return
end

function OpenFuncTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function OpenFuncTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function OpenFuncTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function OpenFuncTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function OpenFuncTipsUI:OnDestroy()
	return
end

function OpenFuncTipsUI:RefreshView()
	self.ItemList = {}
	self.FuncItemParent:GetComponent("GridLayoutGroup").enabled = true

	LuaCodeInterface.SetGameObjectShow(self.BG, true)
	LuaCodeInterface.SetGameObjectShow(self.titleParent, true)
	LuaCodeInterface.SetGameObjectShow(self.Title, true)

	local index = 1

	while NoticeModule.funcQueue.Size > 0 do
		local funcCfg = NoticeModule.funcQueue:Dequeue()
		local item = self:CreateFuncItem(index)

		item.funcCfg = funcCfg

		LuaCodeInterface.SetGameObjectShow(item.View, true)
		UGUIUtil.SetText(item.Name, funcCfg.FuncName)

		index = index + 1
	end

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(2.5))

		self.FuncItemParent:GetComponent("GridLayoutGroup").enabled = false

		for k, v in pairs(self.ItemList) do
			local rect = v.View:GetComponent("RectTransform")
			local historyPos = rect.position

			rect.anchorMax = Vector2(0.5, 0.5)
			rect.anchorMin = Vector2(0.5, 0.5)
			rect.position = historyPos
		end

		self:FlyGameObject()
		LuaCodeInterface.SetGameObjectShow(self.BG, false)
		LuaCodeInterface.SetGameObjectShow(self.titleParent, false)
		LuaCodeInterface.SetGameObjectShow(self.Title, false)
	end)
end

function OpenFuncTipsUI:CreateFuncItem(index)
	local luaTable = {}
	local itemObj = UnityEngine.Object.Instantiate(self.FuncItemPrefab)

	itemObj.transform:SetParent(self.FuncItemParent.transform, false)
	LuaCodeInterface.BindOutlet(itemObj, luaTable)

	self.ItemList[index] = luaTable

	return luaTable
end

function OpenFuncTipsUI:FlyGameObject()
	return
end

function OpenFuncTipsUI:GetTargetObj(funcCfg)
	return UnityEngine.GameObject.Find(funcCfg.TargetObjectName)
end

local index = 0

function OpenFuncTipsUI:PlayAnimCallback()
	index = index + 1

	if index >= self.ItemListLen then
		self:DestoryItem()
		UIModule.CloseSelf(self)

		index = 0
	end
end

function OpenFuncTipsUI:DestoryItem()
	for i = #self.ItemList, 1, -1 do
		UnityEngine.Object.Destroy(self.ItemList[i].View)

		self.ItemList[i] = nil
	end

	self.ItemList = {}
end

return OpenFuncTipsUI
