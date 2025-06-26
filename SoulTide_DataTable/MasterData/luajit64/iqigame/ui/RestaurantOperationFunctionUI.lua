-- chunkname: @IQIGame\\UI\\RestaurantOperationFunctionUI.lua

local RestaurantOperationFunctionUI = {
	functionItemCells = {}
}

RestaurantOperationFunctionUI = Base:Extend("RestaurantOperationFunctionUI", "IQIGame.Onigao.UI.RestaurantOperationFunctionUI", RestaurantOperationFunctionUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ROFunctionItemCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationFunction.ROFunctionItemCell")

function RestaurantOperationFunctionUI:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	self.FunctionMould:SetActive(false)

	self.functionItemCellPool = UIObjectPool.New(6, function()
		local functionCell = ROFunctionItemCell.New(UnityEngine.Object.Instantiate(self.FunctionMould))

		function functionCell.clickSelfCallBack(functionID)
			self:DoFunction(functionID)
		end

		return functionCell
	end, function(cell)
		cell:Dispose()
	end)
end

function RestaurantOperationFunctionUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationFunctionUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationFunctionUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationFunctionUI:GetBGM(userData)
	return nil
end

function RestaurantOperationFunctionUI:OnOpen(userData)
	self.roleCid = userData.RoleID
	self.wordPos = userData.WorldPos

	EventDispatcher.Dispatch(EventID.RORefreshNpcAiMoveEvent, self.roleCid, false)
	self:UpdateView()
end

function RestaurantOperationFunctionUI:OnClose(userData)
	EventDispatcher.Dispatch(EventID.RORefreshNpcAiMoveEvent, self.roleCid, true)
end

function RestaurantOperationFunctionUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function RestaurantOperationFunctionUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function RestaurantOperationFunctionUI:OnPause()
	return
end

function RestaurantOperationFunctionUI:OnResume()
	return
end

function RestaurantOperationFunctionUI:OnCover()
	return
end

function RestaurantOperationFunctionUI:OnReveal()
	return
end

function RestaurantOperationFunctionUI:OnRefocus(userData)
	return
end

function RestaurantOperationFunctionUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationFunctionUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationFunctionUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationFunctionUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationFunctionUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.functionItemCells) do
		self.functionItemCellPool:Release(v)
	end

	self.functionItemCells = {}

	self.functionItemCellPool:Dispose()
end

function RestaurantOperationFunctionUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantOperationFunctionUI:DoFunction(functionID)
	log("执行功能 " .. functionID)

	if functionID == RestaurantOperationConstant.FunctionType.FunctionType_Chatting then
		EventDispatcher.Dispatch(EventID.RONpcTalkEvent, self.roleCid)
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Certificate then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationUnlockPlayerUI, Constant.UILayer.UI)
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Education then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationUpdateUI, Constant.UILayer.UI, {
			ROPlayerCid = self.roleCid
		})
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Talk then
		local cfgROPlayerData = CfgRestaurantOperationPlayerTable[self.roleCid]

		if cfgROPlayerData.PlotId > 0 then
			DialogModule.OpenDialog(cfgROPlayerData.PlotId, false, false)
		end
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Training then
		UIModule.Open(Constant.UIControllerName.RestaurantOperationChallengeUI, Constant.UILayer.UI)
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Answer then
		ROAnswerGameModule.StartAnswerGame()
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Blocks then
		ROPuzzleGameModule.StartPuzzleGame()
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Connect then
		ROFruitCleanGameModule.StartCardGame()
	elseif functionID == RestaurantOperationConstant.FunctionType.FunctionType_Card then
		ROCardGameModule.StartCardGame()
	end

	self:OnClickBtnClose()
end

function RestaurantOperationFunctionUI:UpdateView()
	local uiPos = self:ConvertPosToUI(self.wordPos)

	uiPos.y = uiPos.y + 2
	self.Panel.transform.position = uiPos

	for i, v in pairs(self.functionItemCells) do
		self.functionItemCellPool:Release(v)
		v.View:SetActive(false)
		v.View.transform:SetParent(self.UIController.transform, false)
	end

	self.functionItemCells = {}

	local cfgData = CfgRestaurantOperationPlayerTable[self.roleCid]

	for i = 1, #cfgData.FunctionGroup do
		local isUnlock = true
		local functionID = cfgData.FunctionGroup[i]

		if functionID == RestaurantOperationConstant.FunctionType.FunctionType_Talk then
			if cfgData.PlotCondition > 0 then
				isUnlock = RestaurantOperationModule.CheckConditions({
					cfgData.PlotCondition
				})
			end

			local roPlayerData = RestaurantOperationModule.GetROPlayerData(cfgData.Id)

			isUnlock = isUnlock and roPlayerData:GetTotalAttrValue() >= cfgData.PlotNeedAtt
		end

		local render = self.functionItemCellPool:Obtain()

		render.View:SetActive(isUnlock)
		render.View.transform:SetParent(self.FunctionNode.transform, false)
		render:SetData(functionID)
		table.insert(self.functionItemCells, render)
	end
end

function RestaurantOperationFunctionUI:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local canvas = self.UIController:GetComponent("Canvas")
	local v_ui = canvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, canvas.transform.anchoredPosition3D.z - 1)

	return v_new, v_v3
end

return RestaurantOperationFunctionUI
