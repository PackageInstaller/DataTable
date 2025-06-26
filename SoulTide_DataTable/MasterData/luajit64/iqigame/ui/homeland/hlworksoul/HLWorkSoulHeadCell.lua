-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkSoul\\HLWorkSoulHeadCell.lua

local HLWorkSoulHeadCell = {}

function HLWorkSoulHeadCell.New(go, mainView)
	local o = Clone(HLWorkSoulHeadCell)

	o:Initialize(go, mainView)

	return o
end

function HLWorkSoulHeadCell:Initialize(go, mainView)
	self.goView = go
	self.mainView = mainView

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.headCell = SoulHeadCell.New(self.goHead)

	function self.headCell.clickCallBack()
		self:OnClickBtnClear()
	end
end

function HLWorkSoulHeadCell:Refresh(soulData)
	self.soulData = soulData

	self.goHead:SetActive(self.soulData ~= nil)
	self.goSignAdd:SetActive(self.soulData == nil)

	if self.soulData ~= nil then
		self.headCell:RefreshView(self.soulData)
	end
end

function HLWorkSoulHeadCell:OnHide()
	return
end

function HLWorkSoulHeadCell:OnDestroy()
	self.headCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
	self.mainView = nil
end

function HLWorkSoulHeadCell:OnClickBtnClear()
	self.mainView:ClearSelectedSoul(self.soulData)
end

function HLWorkSoulHeadCell:SetActive(vs)
	self.goView:SetActive(vs)
end

return HLWorkSoulHeadCell
