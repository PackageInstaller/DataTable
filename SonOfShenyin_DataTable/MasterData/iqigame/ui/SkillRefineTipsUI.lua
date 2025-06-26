-- chunkname: @IQIGame\\UI\\SkillRefineTipsUI.lua

local attrItemCell = {}

function attrItemCell.New(view)
	local obj = Clone(attrItemCell)

	obj:Init(view)

	return obj
end

function attrItemCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function attrItemCell:SetData(_attrType, curValue, _value)
	local attrCfg = CfgAttributeTable[_attrType]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(attrCfg.ImageUrl), self.lastGradeImg:GetComponent("Image"))
	UGUIUtil.SetText(self.attGrowthNameText, DiySkillStrengthenUIApi:GetAttrGrowUpTitle(_attrType))
	UGUIUtil.SetText(self.lastNumText, curValue == nil and 0 or curValue)
	UGUIUtil.SetText(self.presentNumText, _value)
end

function attrItemCell:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function attrItemCell:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function attrItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local SkillRefineTipsUI = {}

SkillRefineTipsUI = Base:Extend("SkillRefineTipsUI", "IQIGame.Onigao.UI.SkillRefineTipsUI", SkillRefineTipsUI)

function SkillRefineTipsUI:OnInit()
	function self.DelegateOnCloseBtnClick()
		UIModule.CloseSelf(self)
	end

	self.closeBtnCom = self.CloseBtn:GetComponent("Button")
	self.attributeObjectPool = UIViewObjectPool.New(self.propertyPrefab, self.propertyContent.transform, function(_view)
		return attrItemCell.New(_view)
	end)
end

function SkillRefineTipsUI:GetPreloadAssetPaths()
	return nil
end

function SkillRefineTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SkillRefineTipsUI:IsManualShowOnOpen(userData)
	return false
end

function SkillRefineTipsUI:GetBGM(userData)
	return nil
end

function SkillRefineTipsUI:OnOpen(userData)
	self.closeBtnCom.interactable = false
	self.oldSkillPod = userData.oldSkillPod
	self.currentSkillPod = userData.currentSkillPod

	local quality = CfgSkillTable[self.oldSkillPod.skillCid]

	self.oldSkillPod.Quality = quality
	self.currentSkillPod.Quality = quality

	self:RefreshSkillInfo()
end

function SkillRefineTipsUI:OnClose(userData)
	return
end

function SkillRefineTipsUI:OnAddListeners()
	self.closeBtnCom.onClick:AddListener(self.DelegateOnCloseBtnClick)
end

function SkillRefineTipsUI:OnRemoveListeners()
	self.closeBtnCom.onClick:RemoveListener(self.DelegateOnCloseBtnClick)
end

function SkillRefineTipsUI:OnPause()
	return
end

function SkillRefineTipsUI:OnResume()
	return
end

function SkillRefineTipsUI:OnCover()
	return
end

function SkillRefineTipsUI:OnReveal()
	return
end

function SkillRefineTipsUI:OnRefocus(userData)
	return
end

function SkillRefineTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SkillRefineTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SkillRefineTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SkillRefineTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SkillRefineTipsUI:OnDestroy()
	self.attributeObjectPool:Dispose(function(item)
		item:Dispose()
	end)

	if self.closeCo ~= nil then
		coroutine.stop(self.closeCo)

		self.closeCo = nil
	end

	AssetUtil.UnloadAsset(self)
end

function SkillRefineTipsUI:RefreshSkillInfo()
	local lastSkillCfg = DiySkillModule.GetSkillRefineCfg(self.oldSkillPod.skillCid, self.oldSkillPod.purifyLv)
	local currentSkillCfg = DiySkillModule.GetSkillRefineCfg(self.currentSkillPod.skillCid, self.currentSkillPod.purifyLv)

	LuaUtility.SetText(self.textLastLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(self.oldSkillPod.purifyLv))
	LuaUtility.SetText(self.textCurrentLevel, DiySkillStrengthenUIApi:GetTextRefineLevel(self.currentSkillPod.purifyLv))
	LuaUtility.SetText(self.nextRefineEffectText, currentSkillCfg.SkillTips)
	self.attributeObjectPool:ForItems(function(_item)
		_item:Hide()
	end)
	self:GetSkillAttribute()

	self.closeCo = coroutine.start(function()
		coroutine.wait(2)

		self.closeBtnCom.interactable = true
		self.closeCo = nil
	end)
end

function SkillRefineTipsUI:GetSkillAttribute()
	local curLevelCfg = DiySkillModule.GetSkillRefineCfg(self.oldSkillPod.skillCid, self.oldSkillPod.purifyLv)
	local nextLevelCfg = DiySkillModule.GetSkillRefineCfg(self.currentSkillPod.skillCid, self.currentSkillPod.purifyLv)
	local curPropertyTable = {}
	local curPropertyCount = 0

	ForArrayCustomStep(curLevelCfg.RefineAttribute, function(_index, _attrType)
		local value = curLevelCfg.RefineAttribute[_index + 1]

		curPropertyTable[_attrType] = value
		curPropertyCount = curPropertyCount + 1
	end, 2)

	local nextPropertyTable = {}
	local nextPropertyCount = 0

	ForArrayCustomStep(nextLevelCfg.RefineAttribute, function(_index, _attrType)
		local value = nextLevelCfg.RefineAttribute[_index + 1]

		nextPropertyTable[_attrType] = value
		nextPropertyCount = nextPropertyCount + 1
	end, 2)

	if nextPropertyCount <= curPropertyCount then
		ForPairs(curPropertyTable, function(_attrType, _value)
			local nextValue = nextPropertyTable[_attrType]

			self:__ShowAttr(_attrType, _value, nextValue)
		end)
	else
		ForPairs(nextPropertyTable, function(_attrType, _value)
			local curValue = curPropertyTable[_attrType]

			self:__ShowAttr(_attrType, curValue, _value)
		end)
	end
end

function SkillRefineTipsUI:__ShowAttr(_attrType, curValue, _value)
	local attributeItem = self.attributeObjectPool:GetFree(function(_item)
		return not _item.View.activeSelf
	end)

	attributeItem:Show()
	attributeItem:SetData(_attrType, curValue, _value)
end

return SkillRefineTipsUI
