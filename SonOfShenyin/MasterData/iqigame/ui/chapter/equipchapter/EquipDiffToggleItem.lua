-- chunkname: @IQIGame\\UI\\Chapter\\EquipChapter\\EquipDiffToggleItem.lua

local m = {}

function m.New(view, refreshFunc)
	local obj = Clone(m)

	obj:Init(view, refreshFunc)

	return obj
end

function m:Init(view, refreshFunc)
	self.View = view
	self.refreshFunc = refreshFunc

	LuaCodeInterface.BindOutlet(self.View, self)
	self:AddListeners()
end

function m:AddListeners()
	return
end

function m:RemoveListeners()
	return
end

function m:SetData(data, index)
	self.stageData = data
	self.stageData.isUnLock = ConditionModule.Check(self.stageData:GetCfg().UnlockConditionId)

	self:OnUnselected()
	self.UnLock:SetActive(self.stageData.isUnLock)
	self.Lock:SetActive(not self.stageData.isUnLock)

	if index == 1 and self.stageData.isUnLock then
		self:OnClickCell()
	end

	UGUIUtil.SetText(self.View.transform:Find("goOff/UnLock/Tittle_Text").gameObject, ChapterUIApi:GetDifficultyStr(index))
	UGUIUtil.SetText(self.View.transform:Find("goOff/Lock/Tittle_Text").gameObject, ChapterUIApi:GetDifficultyStr(index))
	UGUIUtil.SetText(self.View.transform:Find("goOn/Tittle_Text").gameObject, ChapterUIApi:GetDifficultyStr(index))
end

function m:OnClickCell()
	self:Select()
end

function m:Select()
	self.goOn:SetActive(true)
	self.goOff:SetActive(false)

	if self.refreshFunc ~= nil then
		self.refreshFunc(self.stageData)
	end
end

function m:OnUnselected()
	self.goOn:SetActive(false)
	self.goOff:SetActive(true)
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
