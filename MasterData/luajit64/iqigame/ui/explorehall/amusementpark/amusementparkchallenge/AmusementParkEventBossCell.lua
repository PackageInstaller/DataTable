-- chunkname: @IQIGame\\UI\\ExploreHall\\AmusementPark\\AmusementParkChallenge\\AmusementParkEventBossCell.lua

local m = {
	EntityId = 0,
	WordTipCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MagicWaxMuseumWordCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumWordCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.WordModule:SetActive(false)

	self.WordTipPool = UIObjectPool.New(4, function()
		local cell = MagicWaxMuseumWordCell.New(UnityEngine.Object.Instantiate(self.WordModule))

		return cell
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:RemoveListener()
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function m:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.AmusementParkMonsterData:GetCfgData().ShowUiSize, self.AmusementParkMonsterData:GetCfgData().ShowUiSize, self.AmusementParkMonsterData:GetCfgData().ShowUiSize)
		args.Entity.gameObject.transform.localPosition = Vector3(self.AmusementParkMonsterData:GetCfgData().ShowUiPosition[1], self.AmusementParkMonsterData:GetCfgData().ShowUiPosition[2], self.AmusementParkMonsterData:GetCfgData().ShowUiPosition[3])

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function m:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
end

function m:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function m:SetData(data)
	self.AmusementParkMonsterData = data

	self:ShowMonster(self.AmusementParkMonsterData:GetCfgData().MonsterSpine)

	for i, v in pairs(self.WordTipCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.WordTipPool:Release(v)
	end

	self.WordTipCells = {}

	for i = 1, #self.AmusementParkMonsterData:GetCfgData().AffixList do
		local id = self.AmusementParkMonsterData:GetCfgData().AffixList[i]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local cell = self.WordTipPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.WorldBox.transform, false)
		cell:SetData(cfgData)
		table.insert(self.WordTipCells, cell)
	end

	local killed = self.AmusementParkMonsterData.isPass

	self.Killed:SetActive(killed)
	UGUIUtil.SetText(self.TextBossLv, AmusementParkChallengeDetailUIApi:GetString("TextBossLevel", self.AmusementParkMonsterData:GetCfgData().BossLevel))
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self:HideEntity()

	for i, v in pairs(self.WordTipCells) do
		self.WordTipPool:Release(v)
	end

	self.WordTipCells = {}

	self.WordTipPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
