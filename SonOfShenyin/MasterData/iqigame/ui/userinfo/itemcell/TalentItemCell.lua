-- chunkname: @IQIGame\\UI\\UserInfo\\ItemCell\\TalentItemCell.lua

local m = {
	isUnlock = false
}

function m.New(view, selectEvent)
	local obj = Clone(m)

	obj:Init(view, selectEvent)

	return obj
end

function m:Init(view, selectEvent)
	self.View = view
	self.selectEvent = selectEvent

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelectBtn()
		self:OnClickSelectBtn()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelectBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelectBtn)
end

function m:SetData(talentCfg)
	self.talentItemType = talentCfg.TalentType
	self.talentCfg = talentCfg

	LuaUtility.SetAnchoredPositionWithRectTransform(self.View:GetComponent("RectTransform"), talentCfg.Coordinate[1], talentCfg.Coordinate[2])
	LuaUtility.SetGameObjectShow(self.smallItem, self.talentItemType == 1)
	LuaUtility.SetGameObjectShow(self.bigItem, self.talentItemType == 2)

	local talentImgCom

	if self.talentItemType == 1 then
		talentImgCom = self.smallTalentImg:GetComponent("Image")
	elseif self.talentItemType == 2 then
		talentImgCom = self.bigTalentImg:GetComponent("Image")
	end

	AssetUtil.LoadImage(self, self.talentCfg.TalentIcon, talentImgCom, function()
		talentImgCom:SetNativeSize()
	end)
end

function m:RefreshInfo()
	self.isUnlock = UserInfoModule.GetTalentIsActive(self.talentCfg.Id)
end

function m:OnClickSelectBtn()
	if self.selectEvent ~= nil then
		self.selectEvent(self.talentCfg.Id)
	end
end

function m:Select()
	LuaUtility.SetGameObjectShow(self.smallSelectImg, self.talentItemType == 1)
	LuaUtility.SetGameObjectShow(self.bigSelectImg, self.talentItemType == 2)
end

function m:UnSelect()
	LuaUtility.SetGameObjectShow(self.smallSelectImg, false)
	LuaUtility.SetGameObjectShow(self.bigSelectImg, false)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.View, false)
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
