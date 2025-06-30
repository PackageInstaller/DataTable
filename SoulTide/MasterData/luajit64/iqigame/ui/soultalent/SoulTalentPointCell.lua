-- chunkname: @IQIGame\\UI\\SoulTalent\\SoulTalentPointCell.lua

local SoulTalentPointCell = {
	stateSign = {}
}

function SoulTalentPointCell.New(go)
	local o = Clone(SoulTalentPointCell)

	o:Initialize(go)

	return o
end

function SoulTalentPointCell:Initialize(go)
	self.goView = go

	LuaCodeInterface.BindOutlet(self.goView, self)

	self.stateSign[1] = self.goSignNow
	self.stateSign[2] = self.goSignActivated
	self.stateSign[3] = self.goSignLock
end

function SoulTalentPointCell:Refresh(cfgTalentData, soulData, curGroupIndex)
	self.cfgTalentData = cfgTalentData
	self.soulData = soulData
	self.curGroupIndex = curGroupIndex

	self:StopEffect()
	self:RefreshState()
end

function SoulTalentPointCell:OnHide()
	self:StopEffect()
end

function SoulTalentPointCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function SoulTalentPointCell:RefreshState()
	if SoulModule.CheckTalentIsActivated(self.soulData, self.cfgTalentData.Id) then
		self.curState = 2
	elseif #self.cfgTalentData.PreTalent ~= 0 then
		local existActivated = false

		for i, v in pairs(self.cfgTalentData.PreTalent) do
			if SoulModule.CheckTalentIsActivated(self.soulData, v) then
				existActivated = true

				break
			end
		end

		if existActivated then
			self.curState = 1
		else
			self.curState = 3
		end
	else
		self.curState = 1
	end

	for i, v in pairs(self.stateSign) do
		v:SetActive(i == self.curState)
	end
end

function SoulTalentPointCell:OnActivateTalentSuccess()
	self:PlayEffect()
end

function SoulTalentPointCell:PlayEffect()
	self:StopEffect()
	self.goEffect:SetActive(true)
end

function SoulTalentPointCell:StopEffect()
	self.goEffect:SetActive(false)
end

return SoulTalentPointCell
