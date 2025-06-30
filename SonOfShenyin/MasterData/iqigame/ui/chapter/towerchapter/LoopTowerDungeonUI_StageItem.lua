-- chunkname: @IQIGame\\UI\\Chapter\\TowerChapter\\LoopTowerDungeonUI_StageItem.lua

local LoopTowerDungeonUI_StageItem = {}
local stateDataName = "chapterItem"
local stateNormal = "normal"
local stateNormalSelected = "normal_selected"
local stateSpecial = "special"
local stateSpecialSelected = "special_selected"
local stateComplete = "completed"
local stateCompleteSelected = "completed_selected"

function LoopTowerDungeonUI_StageItem.New(go, mainView)
	local o = Clone(LoopTowerDungeonUI_StageItem)

	o:Initialize(go, mainView)

	return o
end

function LoopTowerDungeonUI_StageItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LoopTowerDungeonUI_StageItem:InitComponent()
	return
end

function LoopTowerDungeonUI_StageItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function LoopTowerDungeonUI_StageItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function LoopTowerDungeonUI_StageItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function LoopTowerDungeonUI_StageItem:OnClickButtonClick()
	self.mainView:OnStageSelected(self)
end

function LoopTowerDungeonUI_StageItem:Selected()
	if TowerChapterModule.IsStagePassed(self.data.Id) then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateCompleteSelected)

		return
	end

	if self.data.ChallengeType == Constant.TowerStageType.normal then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateNormalSelected)
	elseif self.data.ChallengeType == Constant.TowerStageType.special then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateSpecialSelected)
	end
end

function LoopTowerDungeonUI_StageItem:UnSelected()
	if TowerChapterModule.IsStagePassed(self.data.Id) then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateComplete)

		return
	end

	if self.data.ChallengeType == Constant.TowerStageType.normal then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateNormal)
	elseif self.data.ChallengeType == Constant.TowerStageType.special then
		LuaUtility.SetStateController(self.gameObject, stateDataName, stateSpecial)
	end
end

function LoopTowerDungeonUI_StageItem:OnDestroy()
	return
end

function LoopTowerDungeonUI_StageItem:Refresh(Data)
	self.data = Data

	LuaUtility.SetText(self.textLayer, self.data.Level)

	self.gameObject.name = self.data.Level

	if self.mainView.currentSelectStageId and self.mainView.currentSelectStageId == self.data.Id then
		self.mainView:OnStageSelected(self)
	else
		self:UnSelected()
	end

	if self.mainView.currentLevel and self.mainView.currentLevel == self.data.Level then
		LuaUtility.SetGameObjectShow(self.currentLayerRoot, true)
	else
		LuaUtility.SetGameObjectShow(self.currentLayerRoot, false)
	end
end

return LoopTowerDungeonUI_StageItem
