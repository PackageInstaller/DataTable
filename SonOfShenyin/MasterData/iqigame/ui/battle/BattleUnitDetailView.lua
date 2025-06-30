-- chunkname: @IQIGame\\UI\\Battle\\BattleUnitDetailView.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local BattleUnitDetailUI = {}

function BattleUnitDetailUI.New(view)
	local obj = Clone(BattleUnitDetailUI)

	obj:Init(view)

	return obj
end

function BattleUnitDetailUI:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.statusPrefab:SetActive(false)

	self.levelLabel:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleApi:GetCfgText(1300001)
	self.hpLabel:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleApi:GetCfgText(6050007)
	self.statusLabel:GetComponent(typeof(UnityEngine.UI.Text)).text = BattleApi:GetCfgText(6050008)

	function self.delegateUpdateStatus(battleUnitID)
		if self.selectedBattleUnitID == battleUnitID then
			self:UpdateStatus(battleUnitID)
		end
	end

	function self.delegateClose()
		self:Close()
	end

	self:AddListeners()

	self.buffs = {}
	self.buffObjPool = UIObjectPool.New(16, function()
		local buffObj = UnityEngine.Object.Instantiate(self.statusPrefab)

		buffObj:SetActive(false)

		return buffObj
	end, function(buffObj)
		UnityEngine.Object.Destroy(buffObj)
	end)
end

function BattleUnitDetailUI:AddListeners()
	EventDispatcher.AddEventListener(EventID.BattleUnitUpdateStatus, self.delegateUpdateStatus)
	self.closeButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:AddListener(self.delegateClose)
end

function BattleUnitDetailUI:RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitUpdateStatus, self.delegateUpdateStatus)
	self.closeButton:GetComponent(typeof(UnityEngine.UI.Button)).onClick:RemoveListener(self.delegateClose)
end

function BattleUnitDetailUI:OnClose()
	if self.View ~= nil then
		self:Close()
	end
end

function BattleUnitDetailUI:OnDestroy()
	self:RemoveListeners()
	self:ResetBuffObjs()
	self.buffObjPool:Dispose()

	self.buffObjPool = nil

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BattleUnitDetailUI:ResetBuffObjs()
	for _, buff in pairs(self.buffs) do
		buff.obj:SetActive(false)
		LuaCodeInterface.ClearOutlet(buff.obj, buff)
		self.buffObjPool:Release(buff.obj)
	end

	self.buffObjPool:Clear()
end

function BattleUnitDetailUI:UpdateStatus(battleUnitID)
	self:ResetBuffObjs()

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)

	self.nameText:GetComponent(typeof(UnityEngine.UI.Text)).text = battleUnitData.name
	self.maxHpText:GetComponent(typeof(UnityEngine.UI.Text)).text = battleUnitData.maxHp
	self.hpText:GetComponent(typeof(UnityEngine.UI.Text)).text = battleUnitData.hp
	self.levelText:GetComponent(typeof(UnityEngine.UI.Text)).text = battleUnitData.level
	self.buffs = {}

	for _, buff in pairs(battleUnitData.buffsData) do
		local buffConfig = CfgBuffTable[buff.cid]
		local buffObj = self.buffObjPool:Obtain()

		buffObj:SetActive(true)
		buffObj.transform:SetParent(self.statusParent.transform, false)
		buffObj:SetActive(buffConfig.IsTipsVisible)

		local buffTable = {
			obj = buffObj
		}

		table.insert(self.buffs, buffTable)
		LuaCodeInterface.BindOutlet(buffObj, buffTable)

		local isIconVisible = buffConfig.Icon and buffConfig.Icon ~= ""

		if isIconVisible then
			local iconPath = BattleApi:GetAttributeIconUrl(buffConfig.Icon)

			AssetUtil.LoadImage(self, iconPath, buffTable.buffImage:GetComponent(typeof(UnityEngine.UI.Image)))
		end

		buffTable.leftCountText:GetComponent(typeof(UnityEngine.UI.Text)).text = buff.leftCount >= 0 and buff.leftCount .. BattleApi:GetCfgText(6050009) or ""
		buffTable.stackText:GetComponent(typeof(UnityEngine.UI.Text)).text = buff.stack <= 1 and "" or buff.stack
		buffTable.descriptionText:GetComponent(typeof(UnityEngine.UI.Text)).text = buffConfig.Describe
	end
end

function BattleUnitDetailUI:Open()
	self.View.gameObject:SetActive(true)
end

function BattleUnitDetailUI:Close()
	self.View.gameObject:SetActive(false)
end

return BattleUnitDetailUI
