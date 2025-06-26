-- chunkname: @IQIGame\\UI\\Shop\\ShopScrollItemView\\RecommendTabTagItemView.lua

local m = {}

function m.New(view, tabClickEvent)
	local obj = Clone(m)

	obj:Init(view, tabClickEvent)

	return obj
end

function m:Init(view, tabClickEvent)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TabClickEvent = tabClickEvent

	function self.DelegateOnBtnClick()
		self:OnBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnClick)
end

function m:RemoveListeners()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnClick)
end

function m:SetData(cfg, index)
	self.Index = index

	UGUIUtil.SetText(self.textNormalName, cfg.Name)
	UGUIUtil.SetText(self.textCheckName, cfg.Name)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfg.NormaToggleImg), self.normalImg:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfg.CheckToggleImg), self.checkImg:GetComponent("Image"))
end

function m:OnBtnClick()
	if self.TabClickEvent then
		self.TabClickEvent(self.Index)
	end
end

function m:Selected()
	LuaUtility.SetGameObjectShow(self.gameObjectNormal, false)
	LuaUtility.SetGameObjectShow(self.gameObjectCheck, true)
end

function m:UnSelected()
	LuaUtility.SetGameObjectShow(self.gameObjectNormal, true)
	LuaUtility.SetGameObjectShow(self.gameObjectCheck, false)
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
	UnityEngine.Object.Destroy(self.View)
end

return m
