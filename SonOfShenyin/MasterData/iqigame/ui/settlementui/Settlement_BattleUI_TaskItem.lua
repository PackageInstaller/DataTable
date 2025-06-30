-- chunkname: @IQIGame\\UI\\SettlementUI\\Settlement_BattleUI_TaskItem.lua

local Settlement_BattleUI_TaskItem = {}
local taskDataName = "TaskItem"

function Settlement_BattleUI_TaskItem.New(go, mainView)
	local o = Clone(Settlement_BattleUI_TaskItem)

	o:Initialize(go, mainView)

	return o
end

function Settlement_BattleUI_TaskItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function Settlement_BattleUI_TaskItem:InitComponent()
	return
end

function Settlement_BattleUI_TaskItem:InitDelegate()
	return
end

function Settlement_BattleUI_TaskItem:AddListener()
	return
end

function Settlement_BattleUI_TaskItem:RemoveListener()
	return
end

function Settlement_BattleUI_TaskItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function Settlement_BattleUI_TaskItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function Settlement_BattleUI_TaskItem:SetCompleteState()
	LuaUtility.SetStateController(self.gameObject, taskDataName, "hasDone")
end

function Settlement_BattleUI_TaskItem:Refresh(Data)
	self.data = Data

	local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data)

	LuaUtility.SetText(self.textName, cfgCondition.Name)
	LuaUtility.SetStateController(self.gameObject, taskDataName, "normal")
end

function Settlement_BattleUI_TaskItem:OnDestroy()
	return
end

return Settlement_BattleUI_TaskItem
