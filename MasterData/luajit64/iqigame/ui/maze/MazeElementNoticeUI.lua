-- chunkname: @IQIGame\\UI\\Maze\\MazeElementNoticeUI.lua

local m = {
	EventDataList = {}
}

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

	function self.DelegateOnAlienEventUnlock(cid, elementCid)
		self:OnAlienEventUnlock(cid, elementCid)
	end

	self.Tweens = {}

	local tweens = self.View:GetComponentsInChildren(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		self.Tweens[i + 1] = tweens[i]
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
	EventDispatcher.AddEventListener(EventID.MazeAlienEventUnlock, self.DelegateOnAlienEventUnlock)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	EventDispatcher.RemoveEventListener(EventID.MazeAlienEventUnlock, self.DelegateOnAlienEventUnlock)
end

function m:OnAlienEventUnlock(cid, elementCid)
	table.insert(self.EventDataList, {
		cid = cid,
		elementCid = elementCid
	})
	self:Show()
end

function m:Show()
	self.View:SetActive(true)

	self.NumberText:GetComponent("Text").text = #self.EventDataList
end

function m:Hide()
	self.EventDataList = {}

	self.View:SetActive(false)

	for i = 1, #self.Tweens do
		local tween = self.Tweens[i]

		tween:ResetToBeginning()

		tween.enabled = true
	end
end

function m:OnClick()
	UIModule.Open(Constant.UIControllerName.MazeAlienEventUnlockUI, Constant.UILayer.Mid, {
		dataList = self.EventDataList
	})
	self:Hide()
end

function m:Dispose()
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Tweens = nil
end

return m
