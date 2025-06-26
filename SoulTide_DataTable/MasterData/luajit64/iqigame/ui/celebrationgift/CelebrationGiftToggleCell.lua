-- chunkname: @IQIGame\\UI\\CelebrationGift\\CelebrationGiftToggleCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(cid)
	self.cid = cid

	UGUIUtil.SetText(self.TextDown, CfgGiftBoxTable[self.cid].Name)
	UGUIUtil.SetText(self.TextUp, CfgGiftBoxTable[self.cid].Name)
end

function m:SetSelect(top)
	self.View:GetComponent("Toggle").isOn = top
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
