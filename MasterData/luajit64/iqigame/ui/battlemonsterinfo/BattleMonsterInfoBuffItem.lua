-- chunkname: @IQIGame\\UI\\BattleMonsterInfo\\BattleMonsterInfoBuffItem.lua

local m = {
	BuffCid = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
end

function m:SetData(cid, stack)
	self.BuffCid = cid

	self.View:SetActive(cid ~= nil)

	if cid == nil then
		return
	end

	local cfgBuffData = CfgBuffTable[cid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgBuffData.Icon), self.Icon:GetComponent("Image"))
	UGUIUtil.SetText(self.NameText, cfgBuffData.Name)
	UGUIUtil.SetText(self.StackText, BattleMonsterInfoUIApi:GetString("ResistantBuffValue", stack))
end

function m:OnClickSelf()
	UIModule.Open(Constant.UIControllerName.BattleMonsterResistanceTipUI, Constant.UILayer.UI, {
		buffCid = self.BuffCid,
		srcRefTrans = self.View.transform
	})
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
