-- chunkname: @IQIGame\\UI\\Battle\\BattleHUD\\BattleHUDBuffView.lua

local UIObjectPool = require("IQIGame/UI/Common/UIObjectPool")
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

	self.buffViewTable = {}
	self.buffItemViewPool = UIObjectPool.New(8, function()
		return self:__CreateBuffItemView()
	end, function(_buffItemView)
		self:__DisposeBuffItemView(_buffItemView)
	end)

	self.gameObject:SetActive(true)
end

function m:UpdateLayout(isFriendly)
	if isFriendly then
		UGUIUtil.SetLayoutChildAlignmentWithGameObject(self.gameObject, 3)
	else
		UGUIUtil.SetLayoutChildAlignmentWithGameObject(self.gameObject, 5)
	end
end

function m:__CreateBuffItemView()
	local buffItemView = {}

	buffItemView.gameObject = UnityEngine.Object.Instantiate(self.template)

	buffItemView.gameObject.transform:SetParent(self.gameObject.transform, false)
	LuaCodeInterface.BindOutlet(buffItemView.gameObject, buffItemView)
	buffItemView.gameObject:SetActive(false)

	return buffItemView
end

function m:__DisposeBuffItemView(buffItemView)
	buffItemView.gameObject:SetActive(false)
	LuaCodeInterface.ClearOutlet(buffItemView.gameObject, buffItemView)
	UnityEngine.Object.Destroy(buffItemView.gameObject)

	buffItemView.gameObject = nil
end

function m:AddBuff(battleBuffData)
	if self.buffViewTable[battleBuffData.cid] ~= nil then
		logError("战斗单位 {0}, HUD 重复添加Buff {1}", self.battleUnitID, battleBuffData.cid)

		return
	end

	local buffItemView = self.buffItemViewPool:Obtain()

	buffItemView.gameObject:SetActive(true)

	self.buffViewTable[battleBuffData.cid] = buffItemView

	local buffConfig = CfgBuffTable[battleBuffData.cid]

	if LuaUtility.StrIsNullOrEmpty(buffConfig.Icon) then
		logError("Buff: {0} 配置了 IsVisible 字段，但是未配置 icon", tostring(buffConfig.Id))
	else
		local path = BattleApi:GetAttributeIconUrl(buffConfig.Icon)

		AssetUtil.LoadImage(self, path, buffItemView.buffImage:GetComponent(typeof(UnityEngine.UI.Image)))
	end

	buffItemView.stackText:GetComponent(typeof(TMPro.TextMeshProUGUI)).text = battleBuffData.stack > 1 and battleBuffData.stack or ""
	buffItemView.roundText:GetComponent(typeof(TMPro.TextMeshProUGUI)).text = battleBuffData.leftCount ~= -1 and battleBuffData.leftCount or ""
end

function m:UpdateBuff(battleBuffData)
	local buffItemView = self.buffViewTable[battleBuffData.cid]

	if buffItemView == nil then
		logError("战斗单位 {0}, HUD 更新不存在的Buff {1}", self.battleUnitID, battleBuffData.cid)

		return
	end

	buffItemView.stackText:GetComponent(typeof(TMPro.TextMeshProUGUI)).text = battleBuffData.stack > 1 and battleBuffData.stack or ""
	buffItemView.roundText:GetComponent(typeof(TMPro.TextMeshProUGUI)).text = battleBuffData.leftCount ~= -1 and battleBuffData.leftCount or ""
end

function m:RemoveBuff(buffCid)
	local buffItemView = self.buffViewTable[buffCid]

	if buffItemView == nil then
		logError("战斗单位 {0}, HUD 移除一个不存在的Buff {1}", self.battleUnitID, buffCid)

		return
	end

	buffItemView.gameObject:SetActive(false)
	self.buffItemViewPool:Release(buffItemView)

	self.buffViewTable[buffCid] = nil
end

function m:OnClose()
	return
end

function m:Dispose()
	self.buffItemViewPool:Dispose()

	for _, _buffItemView in pairs(self.buffViewTable) do
		self:__DisposeBuffItemView(_buffItemView)
	end

	self.buffViewTable = nil
end

function m:Clear()
	for _buffCid, _ in pairs(self.buffViewTable) do
		self:RemoveBuff(_buffCid)
	end
end

return m
