-- chunkname: @IQIGame\\UI\\ImagePuzzleUI.lua

local ImagePuzzleUI = {}

ImagePuzzleUI = Base:Extend("ImagePuzzleUI", "IQIGame.Onigao.UI.ImagePuzzleUI", ImagePuzzleUI)

function ImagePuzzleUI:OnInit()
	self:InitComponent()
	self:InitDelegate()
end

function ImagePuzzleUI:InitComponent()
	return
end

function ImagePuzzleUI:InitDelegate()
	return
end

function ImagePuzzleUI:OnAddListeners()
	return
end

function ImagePuzzleUI:OnRemoveListeners()
	return
end

function ImagePuzzleUI:OnOpen(userData)
	self:Refresh(userData)
end

function ImagePuzzleUI:OnClose(userData)
	return
end

function ImagePuzzleUI:OnDestroy()
	return
end

function ImagePuzzleUI:GetPreloadAssetPaths()
	return nil
end

function ImagePuzzleUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ImagePuzzleUI:IsManualShowOnOpen(userData)
	return false
end

function ImagePuzzleUI:GetBGM(userData)
	return nil
end

function ImagePuzzleUI:OnPause()
	return
end

function ImagePuzzleUI:OnResume()
	return
end

function ImagePuzzleUI:OnCover()
	return
end

function ImagePuzzleUI:OnReveal()
	return
end

function ImagePuzzleUI:OnRefocus(userData)
	return
end

function ImagePuzzleUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ImagePuzzleUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ImagePuzzleUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ImagePuzzleUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ImagePuzzleUI:Refresh(openData)
	local cfgData = PuzzleModule.GetCfgImagePuzzleDataWithID(openData.imagePuzzleID)

	self.currentImagePuzzleID = openData.imagePuzzleID

	if self.ImagePuzzlePrefab then
		GameObject.Destroy(self.ImagePuzzlePrefab)

		self.ImagePuzzlePrefab = nil
	end

	AssetUtil.LoadAsset(self, cfgData.ImagePrefabPath, self.OnLoadPrefabSuccess, nil)
	coroutine.start(function()
		coroutine.wait(0.1)
		self:MoveDownToStoryUI()
	end)
	LuaUtility.SetGameObjectShow(self.rawImg, cfgData.IsAlphaBG)
	LuaUtility.SetGameObjectShow(self.blackMaskZZ, cfgData.IsAlphaBG)
end

function ImagePuzzleUI:OnLoadPrefabSuccess(assetName, asset, duration, userData)
	self.ImagePuzzlePrefab = GameObject.Instantiate(asset, self.PuzzleMount.transform)
	self.ImagePuzzleControl = self.ImagePuzzlePrefab:GetComponent(typeof(IQIGame.Onigao.Game.Story.ImagePuzzleControl))

	if self.ImagePuzzleControl then
		self.ImagePuzzleControl:Entry()
	end
end

function ImagePuzzleUI:MoveDownToStoryUI()
	local control = self.gameObject:GetComponent("UIController")

	control:OnDepthChanged(0, 0)
end

return ImagePuzzleUI
