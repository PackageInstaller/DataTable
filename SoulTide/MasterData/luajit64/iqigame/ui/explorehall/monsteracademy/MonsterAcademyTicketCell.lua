-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyTicketCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnUpdateItem()
		self:OnUpdateItem()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:RemoveListeners()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateOnUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateItem, self.DelegateOnUpdateItem)
end

function m:Refresh()
	if not MonsterAcademyModule.IsShow() then
		return
	end

	self.cfgGalGameMonsterGlobalData = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]

	local path = UIGlobalApi.GetIconPath(CfgItemTable[self.cfgGalGameMonsterGlobalData.AchPoint].Icon)

	AssetUtil.LoadImage(self, path, self.Icon:GetComponent("Image"))

	local value = WarehouseModule.GetItemNumByCfgID(CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid].AchPoint)

	UGUIUtil.SetText(self.ValueText, value)
end

function m:OnUpdateDailyDupEvent()
	self:Refresh()
end

function m:OnUpdateItem()
	self:Refresh()
end

function m:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.TextFollowingTipUI, Constant.UILayer.UI, {
		title = CfgItemTable[self.cfgGalGameMonsterGlobalData.AchPoint].Name,
		content = CfgItemTable[self.cfgGalGameMonsterGlobalData.AchPoint].Describe,
		refTrans = self.View.transform
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
