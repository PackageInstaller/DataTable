-- chunkname: @IQIGame\\UI\\Common\\ElementCell.lua

local m = {
	TownAlienEventBookResCid = 0
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

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:SetData(townAlienEventBookResCid)
	self.TownAlienEventBookResCid = townAlienEventBookResCid

	self.View:SetActive(townAlienEventBookResCid ~= nil)

	if townAlienEventBookResCid == nil then
		return
	end

	local cfgTownAlienEventBookResData = CfgTownAlienEventBookResTable[townAlienEventBookResCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgTownAlienEventBookResData.ElementIcon), self.Icon:GetComponent("Image"))
end

function m:OnClick()
	UIModule.Open(Constant.UIControllerName.ElementTipsUI, Constant.UILayer.Tooltip, {
		cid = self.TownAlienEventBookResCid
	})
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
