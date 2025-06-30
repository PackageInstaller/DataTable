-- chunkname: @IQIGame\\UI\\Common\\BuffCell.lua

local BuffCell = {
	layers = 1,
	tipType = 1,
	enableClick = true
}

function BuffCell.New(go, tipTrans)
	local o = Clone(BuffCell)

	o:Initialize(go, tipTrans)

	return o
end

function BuffCell:Initialize(go, tipTrans)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.tipTrans = tipTrans

	function self.DelegateOnClickGoView()
		self:OnClickBtn()
	end

	self.goView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickGoView)

	self.tfBuffLayers = self.goLayers:GetComponent("Text")
end

function BuffCell:Refresh(cfgData, enableClick, tipType, puppetData, hostTroopType)
	self.cfgData = cfgData

	if enableClick == nil then
		enableClick = true
	end

	self.enableClick = enableClick

	if tipType == nil then
		tipType = 1
	end

	self.tipType = tipType
	self.puppetData = puppetData
	self.hostTroopType = hostTroopType

	self:RefreshIcon()
	self:RefreshLayers(1)
end

function BuffCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.goView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickGoView)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
	self.tipTrans = nil
	self.tfBuffLayers = nil
end

function BuffCell:RefreshIcon()
	if self.cfgData.Icon == "" then
		warning("buff " .. self.cfgData.Id .. " 没有配置Icon")
	end

	local path = UIGlobalApi.IconPath .. self.cfgData.Icon

	AssetUtil.LoadImage(self, path, self.goIcon:GetComponent("Image"))

	local bgPath = MiscApi:GetString("BuffBg", self.cfgData.BuffTag)

	self.goBg:SetActive(bgPath ~= nil)

	if bgPath ~= nil then
		AssetUtil.LoadImage(self, bgPath, self.goBg:GetComponent("Image"))
	end

	local arrowPath = MiscApi:GetString("BuffArrow", self.cfgData.BuffTag)

	self.goArrow:SetActive(arrowPath ~= nil)

	if arrowPath ~= nil then
		AssetUtil.LoadImage(self, arrowPath, self.goArrow:GetComponent("Image"))
	end
end

function BuffCell:RefreshLayers(value)
	if value == nil then
		value = 1
	end

	self.layers = value

	self.goLayers:SetActive(self.layers ~= 1)

	self.tfBuffLayers.text = BuffTipsUIApi:GetString("goBuffLayers", self.layers)
end

function BuffCell:SetActive(vs)
	self.goView:SetActive(vs)
end

function BuffCell:SetParent(goParent)
	self.goView.transform:SetParent(goParent.transform, false)
end

function BuffCell:OnClickBtn()
	if self.enableClick == false then
		return
	end

	if self.tipType == 1 then
		UIModule.Open(Constant.UIControllerName.BuffTipsUI, Constant.UILayer.UI, {
			self.cfgData.Id,
			self.layers,
			self.puppetData
		})
	elseif self.tipType == 2 then
		UIModule.Open(Constant.UIControllerName.MazeBuffTipsUI, Constant.UILayer.Tooltip, {
			buffs = MazeDataModule.PlayerInfo.Buffs,
			tipTrans = self.tipTrans
		})
	end
end

return BuffCell
