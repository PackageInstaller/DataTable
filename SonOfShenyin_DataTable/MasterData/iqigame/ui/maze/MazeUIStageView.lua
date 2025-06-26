-- chunkname: @IQIGame\\UI\\Maze\\MazeUIStageView.lua

local MazeUIStageElement = require("IQIGame/UI/Maze/MazeUIStageElement")
local m = {}

function m.New(view, stageClickHandler)
	local obj = Clone(m)

	obj:Init(view, stageClickHandler)

	return obj
end

function m:Init(view, stageClickHandler)
	self.View = view
	self.stageClickHandler = stageClickHandler

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateOnClickStageRefreshBtn()
		self:OnClickStageRefreshBtn()
	end

	function self.delegateOnRefreshMazeStageEvent()
		self:OnRefreshMazeStageEvent()
	end

	self.commonReturnBtn = CommonReturnBtn.New(self.commonReturnBtn, self)

	self.commonReturnBtn:SetHomeBtnState(false)
	self.commonReturnBtn:RegisterReturnEvent(function()
		self:Hide()
	end)
	self:RefreshStageConsume()
	self:AddListeners()
end

function m:AddListeners()
	self.stageRefreshBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickStageRefreshBtn)
	EventDispatcher.AddEventListener(EventID.OnRefreshMazeStageEvent, self.delegateOnRefreshMazeStageEvent)
end

function m:RemoveListeners()
	self.stageRefreshBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickStageRefreshBtn)
	EventDispatcher.RemoveEventListener(EventID.OnRefreshMazeStageEvent, self.delegateOnRefreshMazeStageEvent)
end

function m:SetData()
	self:ReleaseStageElement()

	local labyrinthData = MazeModule.GetLabyrinthData()
	local path = "Assets/03_Prefabs/UI/Maze/MazeStageContent_1.prefab"

	AssetUtil.LoadAsset(self, path, function(_, _assetUrl, _asset, _duration, _userData)
		self:__InitStageContentView(_asset)
	end, function()
		logError(string.format("关卡预制加载失败{%s}", path))
	end)
end

function m:__InitStageContentView(_asset)
	local stageView = UnityEngine.Object.Instantiate(_asset)
	local trans = stageView.gameObject.transform

	trans:SetParent(self.Content.transform, false)

	trans.localPosition = Vector3.zero
	trans.localScale = Vector3.one
	self.stageElement = MazeUIStageElement.New(trans.gameObject, self.stageClickHandler)

	self.stageElement:Show()
end

function m:ReleaseStageElement()
	if self.stageElement then
		self.stageElement:Dispose()

		self.stageElement = nil
	end
end

function m:RefreshStageConsume()
	local discreateDataCfg = CfgDiscreteDataTable[Constant.DiscreteData.MazeStageRefreshData]

	UGUIUtil.SetText(self.consumeText, "×" .. discreateDataCfg.Data[2])
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[discreateDataCfg.Data[1]].Icon), self.consumeImg:GetComponent("Image"))
end

function m:OnClickStageRefreshBtn()
	if WarehouseModule.GetPlayerNormalMoneyNum() < CfgDiscreteDataTable[Constant.DiscreteData.MazeStageRefreshData].Data[2] then
		NoticeModule.ShowNotice(51018)

		return
	end

	MazeModule.OnRefreshStage()
end

function m:OnRefreshMazeStageEvent()
	self.stageElement:RefreshStage()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	self:ReleaseStageElement()
	self.commonReturnBtn:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
