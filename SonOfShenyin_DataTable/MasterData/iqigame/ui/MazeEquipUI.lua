-- chunkname: @IQIGame\\UI\\MazeEquipUI.lua

local UITabList = require("IQIGame.UI.Common.UITabList")
local mazeEquipMainView = require("IQIGame.UI.Maze.UI.MazeEquipMainView")
local mazeEquipBuffView = require("IQIGame.UI.Maze.UI.MazeEquipBuffView")
local MazeEquipUI = {}

MazeEquipUI = Base:Extend("MazeEquipUI", "IQIGame.Onigao.UI.MazeEquipUI", MazeEquipUI)

function MazeEquipUI:OnInit()
	self.uiTabList = UITabList.Create()
	self.mazeEquipMainPanel = mazeEquipMainView.New(self.equipPanel)

	self.uiTabList:AddTableItem(self.equipTab, function()
		return self.mazeEquipMainPanel
	end, function(_isOn, _view)
		if not _isOn then
			return
		end

		_view:SetData(self.PlayerData)
		_view:Show()
	end)

	self.mazeEquipBuffPanel = mazeEquipBuffView.New(self.buffPanel)

	self.uiTabList:AddTableItem(self.buffTab, function()
		return self.mazeEquipBuffPanel
	end, function(_isOn, _view)
		LuaUtility.SetGameObjectShow(self.equipTab, not _isOn)

		if not _isOn then
			_view:Hide()
			self.mazeEquipMainPanel:Show()

			return
		else
			self.mazeEquipMainPanel:Hide()
		end

		_view:Show()
		_view:SetData()
	end)

	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
end

function MazeEquipUI:GetPreloadAssetPaths()
	return nil
end

function MazeEquipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeEquipUI:IsManualShowOnOpen(userData)
	return false
end

function MazeEquipUI:GetBGM(userData)
	return nil
end

function MazeEquipUI:OnOpen(userData)
	self.commonReturnBtn:SetHomeBtnState(not MazeModule.InTheMaze)
	LuaUtility.SetGameObjectShow(self.outMazeImg, not MazeModule.InTheMaze)
	LuaUtility.SetGameObjectShow(self.inMazeImg, MazeModule.InTheMaze)
	self.uiTabList:ChangeSelectIndex(1)

	self.buffTab:GetComponent("Toggle").isOn = false
end

function MazeEquipUI:OnClose(userData)
	StoryModule.SendTreeEvent(10102, "1-1 Talk", "MazeEquipUICloseEvent")
end

function MazeEquipUI:OnAddListeners()
	return
end

function MazeEquipUI:OnRemoveListeners()
	return
end

function MazeEquipUI:OnPause()
	return
end

function MazeEquipUI:OnResume()
	return
end

function MazeEquipUI:OnCover()
	return
end

function MazeEquipUI:OnReveal()
	return
end

function MazeEquipUI:OnRefocus(userData)
	return
end

function MazeEquipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeEquipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeEquipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeEquipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeEquipUI:OnDestroy()
	self.uiTabList:Dispose()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

return MazeEquipUI
