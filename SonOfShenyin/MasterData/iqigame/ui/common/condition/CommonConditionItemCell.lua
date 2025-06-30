-- chunkname: @IQIGame\\UI\\Common\\Condition\\CommonConditionItemCell.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function m:SetData(conditionID, unControlColor)
	self.unControlColor = unControlColor
	self.conditionCfg = CfgConditionTable[conditionID]

	self:RefreshConditionInfo()
end

function m:RefreshConditionInfo()
	self.isUnlock = ConditionModule.Check(self.conditionCfg.Id)

	LuaUtility.SetGameObjectShow(self.unlockImg, self.isUnlock)
	LuaUtility.SetGameObjectShow(self.lockImg, not self.isUnlock)

	if self.unControlColor then
		LuaUtility.SetText(self.ConditionText, self.conditionCfg.Name)
	elseif self.isUnlock then
		UGUIUtil.SetText(self.ConditionText, string.format(ColorCfg.Purple, self.conditionCfg.Name))
	else
		UGUIUtil.SetText(self.ConditionText, string.format(ColorCfg.White, self.conditionCfg.Name))
	end
end

function m:GetIsUnlock()
	return self.isUnlock
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
