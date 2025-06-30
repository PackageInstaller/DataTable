-- chunkname: @IQIGame\\UI\\Activity\\MagicWaxMuseum\\TimeLimitedBossCell.lua

local m = {
	EntityId = 0,
	WordTipCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MagicWaxMuseumWordCell = require("IQIGame.UI.Activity.MagicWaxMuseum.MagicWaxMuseumWordCell")

function m.New(view, root)
	local obj = Clone(m)

	obj:Init(view, root)

	return obj
end

function m:Init(view, root)
	self.root = root
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextKilled, ActivityUIApi:GetString("TextKilled"))

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.WordModule:SetActive(false)

	self.WordTipPool = UIObjectPool.New(4, function()
		local cell = MagicWaxMuseumWordCell.New(UnityEngine.Object.Instantiate(self.WordModule))

		return cell
	end, function(cell)
		cell:Dispose()

		local v = cell.View

		UnityEngine.Object.Destroy(v)
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
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgMagicWaxMuseumListData.ShowUiSize, self.cfgMagicWaxMuseumListData.ShowUiSize, self.cfgMagicWaxMuseumListData.ShowUiSize)
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgMagicWaxMuseumListData.ShowUiPosition[1], self.cfgMagicWaxMuseumListData.ShowUiPosition[2], self.cfgMagicWaxMuseumListData.ShowUiPosition[3])

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

function m:SetData(data, operateEventID)
	self.cfgMagicWaxMuseumListData = data
	self.operateEventID = operateEventID

	self:ShowMonster(self.cfgMagicWaxMuseumListData.MonsterSpine)

	for i, v in pairs(self.WordTipCells) do
		v.View.transform:SetParent(self.root.UIController.transform, false)
		v.View:SetActive(false)
		self.WordTipPool:Release(v)
	end

	self.WordTipCells = {}

	for i = 1, #self.cfgMagicWaxMuseumListData.AffixList do
		local id = self.cfgMagicWaxMuseumListData.AffixList[i]
		local cfgData = CfgSkillSpecialEffectExplainTable[id]
		local cell = self.WordTipPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.WorldBox.transform, false)
		cell:SetData(cfgData)
		table.insert(self.WordTipCells, cell)
	end

	local killed = ActiveMagicWaxMuseumModule.GetMagicWaxMuseumBossKillState(self.operateEventID, self.cfgMagicWaxMuseumListData.Id)

	self.Killed:SetActive(killed)
	UGUIUtil.SetText(self.TextBossLv, ActivityUIApi:GetString("TextBossLevel", self.cfgMagicWaxMuseumListData.BossLevel))
end

function m:Dispose()
	self:RemoveListener()
	self:HideEntity()

	for i, v in pairs(self.WordTipCells) do
		self.WordTipPool:Release(v)
	end

	self.WordTipCells = {}

	self.WordTipPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
