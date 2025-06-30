-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyPlayerHeadView.lua

local m = {
	monsterAcademyAttrCells = {},
	monsterAcademyAtt = {}
}
local MonsterAcademyAttrCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyAttrCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")

require("IQIGame.UIExternalApi.MonsterAcademyPlayerUIApi")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.deleteHeadIconBtn()
		self:OnHeadIconBtn()
	end

	function self.delegateUpdateBaseEvent()
		self:OnUpdateBaseEvent()
	end

	function self.delegateUpdateItemEvent()
		self:OnUpdateItemEvent()
	end

	self.AttrModule:SetActive(false)

	self.monsterAcademyAttrCellPool = UIObjectPool.New(4, function()
		return MonsterAcademyAttrCell.New(UnityEngine.Object.Instantiate(self.AttrModule))
	end, function(cell)
		cell:Dispose()
	end)
	self.monsterAcademyAtt = MonsterAcademyModule.GetMonsterAcademyAtt()

	self:AddListener()
end

function m:AddListener()
	self.HeadIcon:GetComponent("Button").onClick:AddListener(self.deleteHeadIconBtn)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.delegateUpdateBaseEvent)
	EventDispatcher.AddEventListener(EventID.MonsterAcademyUpdateItemEvent, self.delegateUpdateItemEvent)
end

function m:RemoveListener()
	self.HeadIcon:GetComponent("Button").onClick:RemoveListener(self.deleteHeadIconBtn)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateBaseEvent, self.delegateUpdateBaseEvent)
	EventDispatcher.RemoveEventListener(EventID.MonsterAcademyUpdateItemEvent, self.delegateUpdateItemEvent)
end

function m:UpdateView()
	self.cfgData = MonsterAcademyModule.GetGameTime()

	UGUIUtil.SetText(self.TextData, MonsterAcademyMainUIApi:GetString("TextData", self.cfgData.Year, self.cfgData.Month, self.cfgData.Day, self.cfgData.Week))
	UGUIUtil.SetText(self.TextWeeks, MonsterAcademyMainUIApi:GetString("TextWeeks", self.cfgData.Week))
	UGUIUtil.SetText(self.TextTimeInterval, MonsterAcademyMainUIApi:GetString("TextTimeInterval", MonsterAcademyModule.SaveDataDetailPOD.basePOD.dayOfPhase))
	UGUIUtil.SetText(self.TextID, PlayerModule.PlayerInfo.baseInfo.guid)

	local cfgGalGameMonsterGlobalData = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]

	if cfgGalGameMonsterGlobalData.Money > 0 then
		self.Icon1:SetActive(true)
		self.AttrValue1:SetActive(true)

		local path1 = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[cfgGalGameMonsterGlobalData.Money].UIIcon)

		AssetUtil.LoadImage(self, path1, self.Icon1:GetComponent("Image"))

		local value1 = MonsterAcademyModule.GetItemNum(cfgGalGameMonsterGlobalData.Money)

		UGUIUtil.SetText(self.AttrValue1, value1)
	else
		self.Icon1:SetActive(false)
		self.AttrValue1:SetActive(false)
	end

	if cfgGalGameMonsterGlobalData.Power > 0 then
		self.Icon2:SetActive(true)
		self.AttrValue2:SetActive(true)

		local path2 = UIGlobalApi.GetImagePath(CfgGalgameMonsterItemTable[cfgGalGameMonsterGlobalData.Power].UIIcon)

		AssetUtil.LoadImage(self, path2, self.Icon2:GetComponent("Image"))

		local value2 = MonsterAcademyModule.GetItemNum(cfgGalGameMonsterGlobalData.Power)

		UGUIUtil.SetText(self.AttrValue2, value2)
	else
		self.Icon2:SetActive(false)
		self.AttrValue2:SetActive(false)
	end

	self:RefreshAttr()
end

function m:OnUpdateBaseEvent()
	self:UpdateView()
end

function m:RefreshAttr()
	for i, v in pairs(self.monsterAcademyAttrCells) do
		local parentObj = self.View:GetComponentInParent(typeof(UIController))

		if parentObj then
			v.View.transform:SetParent(parentObj.transform, false)
		end

		v.View:SetActive(false)
		self.monsterAcademyAttrCellPool:Release(v)
	end

	self.monsterAcademyAttrCells = {}

	for i = 1, #self.monsterAcademyAtt do
		local attributeID = self.monsterAcademyAtt[i]
		local itemCell = self.monsterAcademyAttrCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.AttrView.transform, false)
		itemCell:SetData(attributeID)
		table.insert(self.monsterAcademyAttrCells, itemCell)
	end
end

function m:OnUpdateItemEvent()
	self:UpdateView()
end

function m:OnHeadIconBtn()
	if self.CallBack then
		self.CallBack()
	end
end

function m:Dispose()
	for i, v in pairs(self.monsterAcademyAttrCells) do
		self.monsterAcademyAttrCellPool:Release(v)
	end

	self.monsterAcademyAttrCells = {}

	self.monsterAcademyAttrCellPool:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
