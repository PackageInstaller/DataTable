-- chunkname: @IQIGame\\UI\\ActiveActivityList\\GhostActivity\\GhostBossUI_bossTabItem.lua

local GhostBossUI_bossTabItem = {}
local diffItemClass = require("IQIGame/UI/ActiveActivityList/GhostActivity/GhostBossUI_bossTabItem_diffItem")
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local dataName = "tabPrefab"
local stateName_selected = "selected"
local stateName_unSelected = "unSelected"

function GhostBossUI_bossTabItem.New(go, mainView)
	local o = Clone(GhostBossUI_bossTabItem)

	o:Initialize(go, mainView)

	return o
end

function GhostBossUI_bossTabItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.selectState = false

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function GhostBossUI_bossTabItem:InitComponent()
	self.diffItemPool = UIViewObjectPool.New(self.subTagPrefab, self.subItemParent.transform, function(_view)
		return diffItemClass.New(_view)
	end)
end

function GhostBossUI_bossTabItem:InitDelegate()
	function self.delegateOnClickClickBtn()
		self:OnClickClickBtn()
	end
end

function GhostBossUI_bossTabItem:AddListener()
	self.ClickBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickClickBtn)
end

function GhostBossUI_bossTabItem:RemoveListener()
	self.ClickBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickClickBtn)
end

function GhostBossUI_bossTabItem:OnClickClickBtn()
	self:SetSubTabParentState(not self.selectState)
end

function GhostBossUI_bossTabItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function GhostBossUI_bossTabItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function GhostBossUI_bossTabItem:SetSubTabParentState(state)
	LuaUtility.SetGameObjectShow(self.subItemParent, state)

	self.selectState = state

	if state then
		LuaUtility.SetStateController(self.gameObject, dataName, stateName_selected)
	else
		LuaUtility.SetStateController(self.gameObject, dataName, stateName_unSelected)
	end
end

function GhostBossUI_bossTabItem:Refresh(Data, index)
	self.data = Data
	self.index = index

	LuaUtility.SetText(self.textName, self.data:GetCfg().Name)
	self:RefreshDiffScroll()
	self:SetSubTabParentState(false)

	local showRedDot = false

	if RedDotModule.ghostBossTaskDic and RedDotModule.ghostBossTaskDic[self.data.cid] then
		showRedDot = true
	end

	LuaUtility.SetGameObjectShow(self.RedDot, showRedDot)
end

function GhostBossUI_bossTabItem:RefreshDiffScroll()
	local stageArray = BossChapterModule.GetResourcePassByChapterID(self.data.cid)

	self.diffItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	local len = #stageArray

	for i = 1, len do
		local item = self.diffItemPool:GetFree(function(_item)
			return not _item.gameObject.activeSelf
		end)

		item:Show()
		item:Refresh(stageArray[i], self.data, i)
	end
end

function GhostBossUI_bossTabItem:SelectFirst()
	self:SetSubTabParentState(true)
	self.diffItemPool:ForItems(function(_item)
		if _item.index == 1 then
			_item:OnClickButtonClick()

			return true
		end
	end)
end

function GhostBossUI_bossTabItem:SelectWithStageId(stageId)
	self.diffItemPool:ForItems(function(diffItem)
		if diffItem.gameObject.activeSelf and diffItem.data and diffItem.data.Id == stageId then
			diffItem:OnClickButtonClick()
			self:SetSubTabParentState(true)

			return true
		end
	end)
end

function GhostBossUI_bossTabItem:OnDestroy()
	self.diffItemPool:Dispose(function(_item)
		_item:OnDestroy()
	end)
	AssetUtil.UnloadAsset(self)
end

return GhostBossUI_bossTabItem
