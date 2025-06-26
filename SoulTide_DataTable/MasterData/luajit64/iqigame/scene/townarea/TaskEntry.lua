-- chunkname: @IQIGame\\Scene\\TownArea\\TaskEntry.lua

local TaskEntry = {}

function TaskEntry.New(view)
	local obj = Clone(TaskEntry)

	obj:Init(view)

	return obj
end

function TaskEntry:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgIcon = self.goIcon:GetComponent("SpriteRenderer")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end
end

function TaskEntry:Refresh(townFunctionData, position)
	self.townFunctionData = townFunctionData

	self:SetActive(true)

	self.View.transform.localPosition = position

	AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(townFunctionData.icon), self.OnLoadSuccess)
	self:OnAddListener()
end

function TaskEntry:OnHide()
	self:OnRemoveListener()
end

function TaskEntry:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:OnHide()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function TaskEntry:OnAddListener()
	self:OnRemoveListener()

	EventTriggerListener.Get(self.goBtnSelf).onClick = self.onClickBtnSelfDelegate
end

function TaskEntry:OnRemoveListener()
	EventTriggerListener.Get(self.goBtnSelf).onClick = nil
end

function TaskEntry:OnClickBtnSelf()
	TownModule.ExecutionEvent(self.townFunctionData)
end

function TaskEntry:OnLoadSuccess(assetName, asset, duration, userData)
	self.imgIcon.sprite = LuaCodeInterface.ToSprite(asset)
end

function TaskEntry:SetActive(vs)
	if not vs then
		self:OnHide()
	end

	self.isWorking = vs

	self.View:SetActive(vs)
end

return TaskEntry
