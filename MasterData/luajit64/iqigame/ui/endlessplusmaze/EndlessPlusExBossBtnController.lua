-- chunkname: @IQIGame\\UI\\EndlessPlusMaze\\EndlessPlusExBossBtnController.lua

local m = {}

function m.New(view, onClick)
	local obj = Clone(m)

	obj:Init(view, onClick)

	return obj
end

function m:Init(view, onClick)
	self.View = view
	self.OnClickCallback = onClick

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickMainBtn()
		self:OnClickMainBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.MainBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMainBtn)
end

function m:RemoveListeners()
	self.MainBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMainBtn)
end

function m:Refresh()
	self.NormalView:SetActive(true)
	self.LockView:SetActive(false)

	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	UGUIUtil.SetTextInChildren(self.MainBtn, cfgEndlessPlusGlobalData.ButtonWord)
	UGUIUtil.SetTextInChildren(self.LockBtn, cfgEndlessPlusGlobalData.ButtonWord)
end

function m:OnClickMainBtn()
	self.OnClickCallback()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickCallback = nil
end

return m
