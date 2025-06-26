-- chunkname: @IQIGame\\UI\\MemoryStory\\MemoryStoryDialogSelectItem.lua

local m = {
	selectIndex = 0
}

function m.New(view, callback)
	local obj = Clone(m)

	obj:__Init(view, callback)

	return obj
end

function m:__Init(view, callback)
	self.ViewRoot = view
	self.clickedEvent = callback

	function self.btnClickEventProxy()
		self:__OnItemClickedEventHandler()
	end

	self.ViewRoot.gameObject:GetComponent("Button").onClick:AddListener(self.btnClickEventProxy)
	LuaCodeInterface.BindOutlet(self.ViewRoot, self)

	self.normalText = self.Text:GetComponent("Text")
	self.disabledText = self.DisabledText:GetComponent("Text")

	self:OnHide()
end

function m:IsFree()
	return not self.ViewRoot.gameObject.activeSelf
end

function m:ShowNormal(str, index)
	self.selectIndex = index
	self.normalText.text = str
	self.disabledText.text = str

	self.ViewRoot.gameObject:SetActive(true)
end

function m:OnHide()
	self.ViewRoot.gameObject:SetActive(false)
end

function m:OnDestroy()
	self.ViewRoot.gameObject:GetComponent("Button").onClick:RemoveListener(self.btnClickEventProxy)
	LuaCodeInterface.ClearOutlet(self.ViewRoot, self)
	UnityEngine.GameObject.Destroy(self.ViewRoot.gameObject)

	self.ViewRoot = nil
end

function m:__OnItemClickedEventHandler()
	self.clickedEvent(self.selectIndex)
end

return m
