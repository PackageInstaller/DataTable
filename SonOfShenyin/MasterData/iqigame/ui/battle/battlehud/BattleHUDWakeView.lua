-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDWakeView.lua

local UIObjectPool = require("IQIGame/UI/Common/UIObjectPool")
local WakeViewItem = {
	wakeCid = 0
}

function WakeViewItem.New(view)
	local obj = Clone(WakeViewItem)

	obj:__Init(view)

	return obj
end

function WakeViewItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function WakeViewItem:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

function WakeViewItem:Show(wakeCid, status)
	self.showEffect.gameObject:SetActive(false)
	self.unlockEffect.gameObject:SetActive(false)
	self.hideEffect.gameObject:SetActive(false)
	self.lockEffect.gameObject:SetActive(false)

	self.wakeCid = wakeCid

	self:UpdateStatus(status)
	self.gameObject:SetActive(true)
end

function WakeViewItem:UpdateStatus(status)
	if status == BattleConstant.Weak_Status.hide then
		self.elementImg.gameObject:SetActive(false)
		self.lockImg.gameObject:SetActive(false)
		self.hideImg.gameObject:SetActive(true)
		self:__PlayEffect(self.hideEffect)
	elseif status == BattleConstant.Weak_Status.show then
		self.elementImg.gameObject:SetActive(true)
		self.lockImg.gameObject:SetActive(false)
		self.hideImg.gameObject:SetActive(false)

		local cfg = CfgMonsterWeakTable[self.wakeCid]
		local path = BattleUIApi:GetWakeIcon(cfg.Icon)

		AssetUtil.LoadImage(self, path, self.elementImg.gameObject:GetComponent(typeof(UnityEngine.UI.Image)))

		if self.lastStatus == BattleConstant.Weak_Status.locked then
			self:__PlayEffect(self.unlockEffect)
		else
			self:__PlayEffect(self.showEffect)
		end
	elseif status == BattleConstant.Weak_Status.locked then
		self.elementImg.gameObject:SetActive(true)
		self.lockImg.gameObject:SetActive(true)
		self.hideImg.gameObject:SetActive(false)

		local cfg = CfgMonsterWeakTable[self.wakeCid]
		local path = BattleUIApi:GetWakeIcon(cfg.Icon)

		AssetUtil.LoadImage(self, path, self.elementImg.gameObject:GetComponent(typeof(UnityEngine.UI.Image)))
		self:__PlayEffect(self.lockEffect)
	end

	self.lastStatus = status
end

function WakeViewItem:__PlayEffect(effectGo)
	effectGo.gameObject:SetActive(false)
	effectGo.gameObject:SetActive(true)
end

function WakeViewItem:HideAllEffect()
	self.showEffect.gameObject:SetActive(false)
	self.unlockEffect.gameObject:SetActive(false)
	self.hideEffect.gameObject:SetActive(false)
	self.lockEffect.gameObject:SetActive(false)
end

function WakeViewItem:Hide()
	self.lastStatus = nil

	self:HideAllEffect()
	self.gameObject:SetActive(false)
end

local m = {
	battleUnitID = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:__Init(view)

	return obj
end

function m:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	self.template.gameObject:SetActive(false)

	self.wakeItemTable = {}
	self.wakeItemPool = UIObjectPool.New(8, function()
		local wakeItem = UnityEngine.GameObject.Instantiate(self.template)

		wakeItem.gameObject.transform:SetParent(self.template.transform.parent, false)

		return WakeViewItem.New(wakeItem)
	end, function(_item)
		_item:Dispose()
	end)
end

function m:Show()
	self.gameObject:SetActive(true)
end

function m:Hide()
	self.gameObject:SetActive(false)
end

function m:AddWake(wakeCid, status)
	if self.wakeItemTable[wakeCid] ~= nil then
		logError("HUD 重复添加一个已经存在的弱点 Cid: {0} Status: {1}", wakeCid, status)

		return
	end

	local wakeItem = self.wakeItemPool:Obtain()

	wakeItem:Show(wakeCid, status)

	self.wakeItemTable[wakeCid] = wakeItem
end

function m:UpdateWakeStatus(wakeCid, status)
	local wakeItem = self.wakeItemTable[wakeCid]

	if wakeItem == nil then
		logError("HUD 更新一个不存在的弱点 Cid: {0} Status: {1}", wakeCid, status)

		return
	end

	wakeItem:UpdateStatus(status)
end

function m:RemoveWake(wakeCid)
	local wakeItem = self.wakeItemTable[wakeCid]

	if wakeItem == nil then
		logError("HUD 删除一个不存在的弱点 Cid: {0}", wakeCid)

		return
	end

	self:__ReleaseWakeItem(wakeItem)
end

function m:__ReleaseWakeItem(wakeItem)
	wakeItem:Hide()
	self.wakeItemPool:Release(wakeItem)

	self.wakeItemTable[wakeItem.wakeCid] = nil
end

function m:HideAllWakeEffect()
	for _, wakeItem in pairs(self.wakeItemTable) do
		wakeItem:HideAllEffect()
	end
end

function m:Dispose()
	for _, wakeItem in pairs(self.wakeItemTable) do
		wakeItem:Dispose()
	end

	self.wakeItemTable = nil

	self.wakeItemPool:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:Clear()
	for _, wakeItem in pairs(self.wakeItemTable) do
		self:__ReleaseWakeItem(wakeItem)
	end
end

return m
