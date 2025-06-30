-- chunkname: @IQIGame\\UI\\Battle\\BattleBuffGroupController.lua

local m = {
	HostTroopType = 0,
	BattleUnitId = "undefined"
}
local BattleBuffGroupCell = require("IQIGame.UI.Battle.BattleBuffGroupCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.BuffGroupCells = {}

	for i = 1, 5 do
		self.BuffGroupCells[i] = BattleBuffGroupCell.New(self["BuffGroupCell" .. i])
	end

	self.BuffBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:ResetBattleUnit(battleUnitId)
	self.BattleUnitId = battleUnitId

	local battleUnitPOD = BattleModule.GetBattleUnitPOD(self.BattleUnitId)

	if battleUnitPOD == nil then
		logError("Battle buff controller error: Cannot find battleUnitPOD. UnitId: " .. tostring(self.BattleUnitId))

		local companions = BattleModule.GetAttackTroopPodsTable()
		local enemies = BattleModule.GetDefendTroopPodsTable()
		local str = ""

		for i, pod in pairs(companions) do
			str = str .. tostring(pod.ID)
			str = str .. ", "
		end

		logError("Companion unit ids: " .. str)

		str = ""

		for i, pod in pairs(enemies) do
			str = str .. tostring(pod.ID)
			str = str .. ", "
		end

		logError("enemy unit ids: " .. str)

		return
	end

	self.HostTroopType = battleUnitPOD.TroopType
end

function m:OnAddBuff(buffDatas)
	self:Refresh()
end

function m:OnRemoveBuff(buffCid)
	self:Refresh()
end

function m:Clear()
	for i = 1, #self.BuffGroupCells do
		local cell = self.BuffGroupCells[i]

		cell:SetData(nil)
	end
end

function m:Refresh()
	local unitBuffs = BattleModule.UnitBuffs[self.BattleUnitId]
	local buffIconSampleCfgMap = {}

	if unitBuffs ~= nil then
		for i = 1, #unitBuffs do
			local buffData = unitBuffs[i]
			local cfgBuffData = CfgBuffTable[buffData.CID]

			if cfgBuffData.IsVisible and cfgBuffData.Icon ~= "" then
				buffIconSampleCfgMap[cfgBuffData.Icon] = cfgBuffData
			end
		end
	end

	local buffs = {}

	for icon, cfgBuffData in pairs(buffIconSampleCfgMap) do
		table.insert(buffs, cfgBuffData)
	end

	table.sort(buffs, function(cfgBuffData1, cfgBuffData2)
		local lv1Priority1, lv1Priority2

		if self.HostTroopType == Constant.BattleTroopType.Attack then
			lv1Priority1 = cfgBuffData1.DebuffType == Constant.DebuffType.Debuff and 2 or 1
			lv1Priority2 = cfgBuffData2.DebuffType == Constant.DebuffType.Debuff and 2 or 1
		else
			lv1Priority1 = cfgBuffData1.DebuffType == Constant.DebuffType.Buff and 2 or 1
			lv1Priority2 = cfgBuffData2.DebuffType == Constant.DebuffType.Buff and 2 or 1
		end

		if lv1Priority1 == lv1Priority2 then
			if cfgBuffData1.VisiblePriority == cfgBuffData2.VisiblePriority then
				return cfgBuffData1.Id < cfgBuffData2.Id
			end

			return cfgBuffData1.VisiblePriority > cfgBuffData2.VisiblePriority
		end

		return lv1Priority2 < lv1Priority1
	end)

	for i = 1, #self.BuffGroupCells do
		local cell = self.BuffGroupCells[i]

		cell:SetData(buffs[i])
	end
end

function m:OnClick()
	if not BattleModule.Initialized then
		return
	end

	if self.BattleUnitId == "undefined" then
		return
	end

	local unitBuffs = BattleModule.UnitBuffs[self.BattleUnitId]

	if unitBuffs == nil then
		local currentBattleUnitIds = ""

		if BattleModule.Initialized then
			local companions = BattleModule.GetAttackTroopPodsTable()
			local enemies = BattleModule.GetDefendTroopPodsTable()

			for i = 1, #companions do
				local battleUnitPOD = companions[i]

				currentBattleUnitIds = currentBattleUnitIds .. ", " .. battleUnitPOD.ID
			end

			for i = 1, #enemies do
				local battleUnitPOD = enemies[i]

				currentBattleUnitIds = currentBattleUnitIds .. ", " .. battleUnitPOD.ID
			end
		end

		local curUnitBuffsKeys = ""

		for k, v in pairs(BattleModule.UnitBuffs) do
			curUnitBuffsKeys = curUnitBuffsKeys .. ", " .. k
		end

		logError("点击战斗buff时出错：通过 BattleUnitId " .. (self.BattleUnitId == nil and "nil" or self.BattleUnitId) .. " 找到的buff列表为nil。战斗是否正常进行中：" .. tostring(BattleModule.Initialized) .. "。 战斗单位id列表为：" .. currentBattleUnitIds .. "。 战斗中的UnitId和Buff映射中，Keys：" .. curUnitBuffsKeys)
	end

	local buffCount = 0

	if unitBuffs ~= nil then
		for i = 1, #unitBuffs do
			local buffData = unitBuffs[i]
			local cfgBuffData = CfgBuffTable[buffData.CID]

			if cfgBuffData.IsVisible and cfgBuffData.Icon ~= "" then
				buffCount = buffCount + 1
			end
		end
	end

	if buffCount > 0 then
		local cfgElementPointDataL = CfgElementPointTable[50001]
		local cfgElementPointDataR = CfgElementPointTable[50002]
		local positionLTrans = findOnTransformByNameRecursively(self.View.transform, cfgElementPointDataL.PointName)
		local positionRTrans = findOnTransformByNameRecursively(self.View.transform, cfgElementPointDataR.PointName)

		UIModule.Open(Constant.UIControllerName.BattleBuffTipsUI, Constant.UILayer.Tooltip, {
			battleUnitId = self.BattleUnitId,
			positionL = positionLTrans.position,
			positionR = positionRTrans.position,
			hostTroopType = self.HostTroopType
		})
	end
end

function m:OnClose()
	return
end

function m:Dispose()
	self.BuffBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)

	for i = 1, #self.BuffGroupCells do
		local cell = self.BuffGroupCells[i]

		cell:Dispose()
	end

	self.BuffGroupCells = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
