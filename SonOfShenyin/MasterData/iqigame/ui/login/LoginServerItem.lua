-- chunkname: @IQIGame\\UI\\Login\\LoginServerItem.lua

local m = {
	State = 0
}

function m.New(view, onClickCallback)
	local obj = Clone(m)

	obj:Init(view, onClickCallback)

	return obj
end

function m:Init(view, onClickCallback)
	self.View = view
	self.OnClickCallback = onClickCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:SetData(serverData)
	self.ServerData = serverData

	self.View:SetActive(serverData ~= nil)

	if serverData == nil then
		self.State = 0

		return
	end

	self.State = serverData.state + 1

	UGUIUtil.SetText(self.NameText, LoginUIApi:SetServerNameInSelectView(serverData.serverName, self.State))

	for i = 1, 4 do
		self["StateImage" .. i]:SetActive(i == self.State)
	end

	self.MaintainBg:SetActive(self.State == 1)
	self.NormalBg:SetActive(self.State ~= 1)
	self.MaintainFlower:SetActive(self.State == 1)
	self.NormalFlower:SetActive(self.State ~= 1)
	UGUIUtil.SetTextInChildren(self.RecommendNode, LoginUIApi:GetServerRecommendNodeText())
	UGUIUtil.SetTextInChildren(self.NewNode, LoginUIApi:GetServerNewNodeText())
	self.RecommendNode:SetActive(serverData.isRmd == 1)
	self.NewNode:SetActive(false)
end

function m:OnClick()
	self.OnClickCallback(self.ServerData)
end

function m:Dispose()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
