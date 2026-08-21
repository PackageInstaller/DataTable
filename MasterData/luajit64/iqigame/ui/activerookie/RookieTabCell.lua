-- chunkname: @IQIGame\\UI\\ActiveRookie\\RookieTabCell.lua

local RookieTabCell = {}

function RookieTabCell.New(go)
	local o = Clone(RookieTabCell)

	o:Initialize(go)

	return o
end

function RookieTabCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfNameDown = self.goDownSign.transform:Find("Text"):GetComponent("Text")
	self.tfNameUp = self.goUpSign.transform:Find("Text"):GetComponent("Text")
	self.imgIconDown = self.goDownSign.transform:Find("Icon"):GetComponent("Image")
	self.imgIconUp = self.goUpSign.transform:Find("Icon"):GetComponent("Image")
end

function RookieTabCell:Refresh(index)
	self.index = index

	self:RefreshMisc()
	self:RefreshRedPoint()
end

function RookieTabCell:OnHide()
	return
end

function RookieTabCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function RookieTabCell:OnTaskUpdate()
	self:RefreshRedPoint()
end

function RookieTabCell:RefreshMisc()
	self.tfNameUp.text = ActiveRookieUIApi:GetString("tabName", self.index)
	self.tfNameDown.text = self.tfNameUp.text

	local path = ActiveRookieUIApi:GetString("tabIconPath", self.index)

	AssetUtil.LoadImage(self, path, self.imgIconUp)
	AssetUtil.LoadImage(self, path, self.imgIconDown)
end

function RookieTabCell:RefreshRedPoint()
	self.goRedPoint:SetActive(ActiveModule.CheckRedPointOnActiveRookieTask(self.index))
end

function RookieTabCell:SetLight(isLight)
	self.goDownSign:SetActive(isLight)
	self.goUpSign:SetActive(not isLight)
end

return RookieTabCell
