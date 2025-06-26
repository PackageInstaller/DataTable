-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDBossView.lua

local BattleHUDBuffView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDBuffView")
local BattleHUDWakeView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDWakeView")
local BattleHUDWakeNumView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDWakeNumView")
local BattleHUDHPView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDHPView")
local BattleHUDElementView = require("IQIGame/UI/Battle/BattleHUD/BattleHUDElementView")
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

	self.buffView = BattleHUDBuffView.New(self.buffPanel)
	self.wakeView = BattleHUDWakeView.New(self.wakePanel)
	self.wakeNumView = BattleHUDWakeNumView.New(self.levelItem)
	self.hpView = BattleHUDHPView.New(self.hpPanel)
	self.elememtView = BattleHUDElementView.New(self.elementItem)

	function self.__delegateOnDetailBtnClick()
		self:__OnDetailBtnClick()
	end

	self.detailBtn:GetComponent("Button").onClick:AddListener(self.__delegateOnDetailBtnClick)
end

function m:InitByUnitData(battleUnitData)
	self.battleUnitID = battleUnitData.battleUnitID

	local monsterCfg = CfgMonsterTable[battleUnitData.monsterConfigID]

	self.bossName.gameObject:GetComponent("Text").text = monsterCfg.Name

	self.hpView:OnInitMaterialInfo(false)
	self:__InitWake(battleUnitData)
	self:__InitSpecialBuff()
	self:__ShowBattleUnitElement(battleUnitData)
	self.gameObject:SetActive(true)
end

function m:OnUpdate()
	self.hpView:OnUpdate()
end

function m:__InitHPView()
	return
end

function m:UpdateHPAndShieldView(hp, maxHp, shield)
	self.hpView:UpdateHP(hp, maxHp, shield)
end

function m:UpdateEnergy(energy, maxEnergy)
	return
end

function m:AddBuff(battleBuffData)
	self.buffView:AddBuff(battleBuffData)
end

function m:UpdateBuff(battleBuffData)
	self.buffView:UpdateBuff(battleBuffData)
end

function m:RemoveBuff(buffCid)
	self.buffView:RemoveBuff(buffCid)
end

function m:__InitSpecialBuff()
	self:HideSpecialBuff()
end

function m:ShowSpecialBuff(tagId, stack)
	self.specialBuffItem:SetActive(true)

	local path = BattleApi:GetSpecialBuffIcon(tagId)

	AssetUtil.LoadImage(self, path, self.specialBuffIcon:GetComponent(typeof(UnityEngine.UI.Image)))
end

function m:UpdateSpecialBuffStack(stack)
	return
end

function m:HideSpecialBuff()
	self.specialBuffItem:SetActive(false)
end

function m:__InitWake(battleUnitData)
	self.wakeView.battleUnitID = battleUnitData.battleUnitID

	self.wakeView:Show()

	local wakeCount = 0

	for wakeCid, status in pairs(battleUnitData.PODData.WeakStatus) do
		self.wakeView:AddWake(wakeCid, status)

		wakeCount = wakeCount + 1
	end

	self.wakeNumView:Show()

	if wakeCount > 0 then
		self:UpdateWakeNum(battleUnitData.PODData.WeakNum, false)
	end
end

function m:AddWake(wakeCid, status)
	self.wakeView:AddWake(wakeCid, status)
end

function m:UpdateWakeStatus(wakeCid, status)
	self.wakeView:UpdateWakeStatus(wakeCid, status)
end

function m:RemoveWake(wakeCid)
	self.wakeView:RemoveWake(wakeCid)
end

function m:UpdateWakeNum(num, showEffect)
	self.wakeNumView:UpdateWakeNum(num, showEffect)
end

function m:__ShowBattleUnitElement(battleUnitData)
	local monsterConfig = CfgMonsterTable[battleUnitData.monsterConfigID]

	self.elememtView:Show()
	self.elememtView:SetData(monsterConfig)
end

function m:SetActiveEx(active)
	if not active then
		self.wakeView:HideAllWakeEffect()
	end

	self.gameObject:SetActive(active)
end

function m:__OnDetailBtnClick()
	EventDispatcher.Dispatch(EventID.OnShowBossInfoView, self.battleUnitID)
end

function m:Dispose()
	self.detailBtn:GetComponent("Button").onClick:RemoveListener(self.__delegateOnDetailBtnClick)
	self.gameObject:SetActive(false)
	self.buffView:Dispose()
	self.wakeView:Dispose()
	self.wakeNumView:Dispose()
	self.hpView:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

return m
