-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDFlyableTipsView.lua

local UIViewObjectPool = require("IQIGame/UI/Common/UIViewObjectPool")
local FlyableTipsItem = {}

function FlyableTipsItem.New(view)
	local obj = Clone(FlyableTipsItem)

	obj:__Init(view)

	return obj
end

function FlyableTipsItem:__Init(view)
	self.gameObject = view
	self.endPoint = self.gameObject.transform.localPosition
	self.gameObject.transform.localPosition = Vector3.zero

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.gameObject:SetActive(false)
end

function FlyableTipsItem:Show(content)
	self.contentText:GetComponent("Text").text = content

	self.gameObject:SetActive(true)

	self.tweenPosition = TweenPosition.Begin(self.gameObject, 1, self.endPoint)
	self.updateTimer = ModuleTimerUtil.NewTimer(Constant.ModuleTimerName.Battle, function()
		self:Hide()
	end, 1.1)

	self.updateTimer:Start()
end

function FlyableTipsItem:Hide()
	self.gameObject:SetActive(false)

	self.gameObject.transform.localPosition = Vector3.zero

	if self.updateTimer ~= nil then
		self.updateTimer:Stop()
	end

	if self.tweenPosition ~= nil then
		UnityEngine.GameObject.Destroy(self.tweenPosition)
	end
end

function FlyableTipsItem:Dispose()
	self:Hide()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.flyableItemPool = UIViewObjectPool.New(self.template, nil, function(_view)
		return FlyableTipsItem.New(_view)
	end)
end

function m:AddFlyableTips(content)
	local flyableTips = self.flyableItemPool:GetFree(function(_item)
		return not _item.gameObject.activeSelf
	end)

	flyableTips:Show(content)
end

function m:AddBuffFlyableTips(buffCid, updateType)
	local buffCfg = CfgBuffTable[buffCid]

	if buffCfg.ShowType == nil then
		return
	end

	if not self:__CheckBuffShowType(buffCfg.ShowType, updateType) then
		return
	end

	BattleModule.Log("Buff 【{0}】 飘字 ---->> {1}", updateType, buffCfg.Name, tostring(updateType))
	self:AddFlyableTips(BattleUIApi:GetBuffPropertyTipsText(updateType, buffCfg.Name))
end

function m:__CheckBuffShowType(showType, type)
	for i = 1, #showType do
		if showType[i] == type then
			return true
		end
	end

	return false
end

function m:Release()
	self.flyableItemPool:ForItems(function(_item)
		_item:Hide()
	end)
end

function m:Dispose()
	self.flyableItemPool:Dispose(function(_item)
		_item:Dispose()
	end)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
