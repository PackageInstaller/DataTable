-- chunkname: @IQIGame\\UI\\UserInfo\\SkillView.lua

local m = {
	curSelectIndex = 1,
	isEnough = true,
	skillItems = {}
}
local UIViewObjectPool = require("IQIGame.UI.Common.UIViewObjectPool")
local roleSkillItemCell = require("IQIGame.UI.UserInfo.ItemCell.RoleSkillItemCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickStrengthBtn()
		self:OnClickStrengthBtn()
	end

	function self.DelegateRoleSkillUpgradeSuccess()
		self:RoleSkillUpgradeSuccess()
	end

	self.skillItemPool = UIViewObjectPool.New(self.roleSkillPrefab, nil, function(_view)
		return roleSkillItemCell.New(_view, function(skillDatas, index)
			self:SelectSkillCallBack(skillDatas, index)
		end)
	end)
	self.materialItemPool = UIViewObjectPool.New(self.CommonSlotUI, nil, function(_view)
		return ItemCell.New(_view)
	end)

	self:AddListeners()
end

function m:AddListeners()
	self.strengthBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStrengthBtn)
	EventDispatcher.AddEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateRoleSkillUpgradeSuccess)
end

function m:RemoveListeners()
	self.strengthBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStrengthBtn)
	EventDispatcher.RemoveEventListener(EventID.RoleSkillUpgradeSucess, self.DelegateRoleSkillUpgradeSuccess)
end

function m:SetData()
	local agentSkills = WarehouseModule.GetAgentSkillDataList()

	self.skillItemPool:ForItems(function(_item)
		_item:Hide()
	end)

	self.skillItems = {}

	for i = 1, #agentSkills do
		local skillItem = self.skillItemPool:GetFree(function(_item)
			return not _item.View.activeSelf
		end)

		self.skillItems[i] = skillItem

		skillItem:Show()
		skillItem:SetData(agentSkills[i], i)
	end

	if #self.skillItems == 0 then
		return
	end

	if self.curSelectIndex > #self.skillItems then
		self.curSelectIndex = 0
	end

	self.skillItems[self.curSelectIndex]:SelectSkill()
end

function m:SelectSkillCallBack(skillDatas, index)
	self.curSelectIndex = index

	for k, v in pairs(self.skillItems) do
		if k == index then
			v:Select()
		else
			v:UnSelect()
		end
	end

	self:RefreshSkillData(skillDatas)
end

function m:RefreshSkillData(skillDatas)
	self.selectSkillData = skillDatas.mainSkillData

	UGUIUtil.SetText(self.lvNumText, skillDatas.mainSkillData.lv)
	UGUIUtil.SetText(self.skillNameText, CfgItemTable[skillDatas.mainSkillData.itemCid].Name)
	UGUIUtil.SetText(self.normalCDNumText, skillDatas.normalSkillData.CD)
	UGUIUtil.SetText(self.normalSkillDetailText, skillDatas.normalSkillData.skillCfgByLv.SkillTips)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(skillDatas.normalSkillData:GetCfg().Icon), self.normalSkillImage:GetComponent("Image"))

	local skillRangeId = skillDatas.normalSkillData:GetCfg().SkillRangeID

	LuaUtility.SetGameObjectShow(self.normalRangeImg, skillRangeId > 0)

	if skillRangeId > 0 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgUtil.GetCfgSkillRangeWithID(skillDatas.normalSkillData:GetCfg().SkillRangeID).SkillRangeImg), self.normalRangeImg:GetComponent("Image"))
	end

	UGUIUtil.SetText(self.eternalCDNumText, skillDatas.otherSkillData.CD)
	UGUIUtil.SetText(self.eternalSkillDetailText, skillDatas.otherSkillData.skillCfgByLv.SkillTips)
	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(skillDatas.otherSkillData:GetCfg().Icon), self.eternalSkillImage:GetComponent("Image"))

	skillRangeId = skillDatas.otherSkillData:GetCfg().SkillRangeID

	LuaUtility.SetGameObjectShow(self.normalRangeImg, skillRangeId > 0)

	if skillRangeId > 0 then
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgUtil.GetCfgSkillRangeWithID(skillDatas.otherSkillData:GetCfg().SkillRangeID).SkillRangeImg), self.eternalRangeImg:GetComponent("Image"))
	end

	local isMaxLv = skillDatas.mainSkillData:IsMaxLv()

	LuaUtility.SetGameObjectShow(self.skillMaxState, isMaxLv)
	LuaUtility.SetGameObjectShow(self.skillNormalState, not isMaxLv)

	local materials = skillDatas.mainSkillData.skillCfgByLv.UpgradeNeedExp

	self.materialItemPool:ForItems(function(_item)
		LuaUtility.SetGameObjectShow(_item.ViewGo, false)
	end)

	self.NeedMaterials = {}
	self.isEnough = true

	for i = 1, #materials, 2 do
		local itemCellItem = self.materialItemPool:GetFree(function(_item)
			return not _item.ViewGo.activeSelf
		end)
		local itemData = WarehouseModule.FindItemForCid(materials[i])

		if itemData == nil then
			itemData = ItemData.CreateByCIDAndNumber(materials[i], 0)
		end

		itemCellItem:SetItem(itemData)
		itemCellItem:SetCustomNum(materials[i + 1])

		if itemData.num < materials[i + 1] then
			self.isEnough = false
		end

		local items = WarehouseModule.GetEnoughItemsByNum(materials[i], materials[i + 1])

		for k, v in pairs(items) do
			self.NeedMaterials[k] = v
		end
	end
end

function m:OnClickStrengthBtn()
	if not self.isEnough then
		NoticeModule.ShowNotice(12003)

		return
	end

	RoleDevelopmentModule.RoleSkillUpgrade(self.selectSkillData.id, self.NeedMaterials)
end

function m:RoleSkillUpgradeSuccess()
	self:SetData()
end

function m:OnOpen()
	self.curSelectIndex = 1

	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:OnClose()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	for k, v in pairs(self.skillItems) do
		v:Dispose()
	end

	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
