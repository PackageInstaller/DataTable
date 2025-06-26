-- chunkname: @IQIGame\\Scene\\TownArea\\AreaEventEntry.lua

local AreaEventEntry = {}

function AreaEventEntry.New(view)
	local obj = Clone(AreaEventEntry)

	obj:Init(view)

	return obj
end

function AreaEventEntry:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end
end

function AreaEventEntry:Refresh(townFunctionData, position)
	self.townFunctionData = townFunctionData

	self:SetActive(true)

	self.View.transform.localPosition = position

	self:PlayEffect()
	self:RefreshMisc()
	self:OnAddListener()
end

function AreaEventEntry:OnUpdate()
	return
end

function AreaEventEntry:OnHide()
	self:StopEffect()
	self:OnRemoveListener()
end

function AreaEventEntry:OnDestroy()
	self:OnHide()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function AreaEventEntry:OnAddListener()
	self:OnRemoveListener()

	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = self.onClickBtnSelfDelegate
	end
end

function AreaEventEntry:OnRemoveListener()
	if self.goBtnSelf ~= nil then
		EventTriggerListener.Get(self.goBtnSelf).onClick = nil
	end
end

function AreaEventEntry:OnClickBtnSelf()
	TownModule.ExecutionEvent(self.townFunctionData)
end

function AreaEventEntry:RefreshMisc()
	self.goSignStory:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SOUL_NEW_STORY)
	self.goSignShopping:SetActive(self.townFunctionData.functionType == TownModule.TOWN_FUNCTION_SHOPPING)
end

function AreaEventEntry:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

function AreaEventEntry:PlayEffect()
	self:StopEffect()

	self.effectId = GameEntry.Effect:PlayMountPointEffect(9001180, 50000, 0, self.goEffectRoot)
end

function AreaEventEntry:StopEffect()
	if self.effectId ~= nil then
		GameEntry.Effect:StopEffect(self.effectId)
	end
end

return AreaEventEntry
