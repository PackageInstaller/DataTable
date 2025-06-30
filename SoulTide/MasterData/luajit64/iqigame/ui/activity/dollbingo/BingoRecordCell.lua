-- chunkname: @IQIGame\\UI\\Activity\\DollBingo\\BingoRecordCell.lua

local BingoRecordCell = {}

function BingoRecordCell.New(view)
	local obj = Clone(BingoRecordCell)

	obj:Init(view)

	return obj
end

function BingoRecordCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfTime = self.goTime:GetComponent("Text")
	self.tfReward = self.goRewardCell:GetComponent("Text")
end

function BingoRecordCell:Refresh(data)
	self.cfgNumData = nil
	self.cfgBingoData = nil

	if data.type == 1 then
		self.cfgNumData = CfgNewCharacterBingoNumTable[data.id]
	elseif data.type == 2 then
		self.cfgBingoData = CfgNewCharacterBingoTable[data.id]
	end

	if self.cfgBingoData ~= nil then
		self.name = self.cfgBingoData.Name
	else
		self.name = self.cfgNumData.Clue
	end

	self.time = data.time
	self.rewardDatum = data.rewardDatum

	self:RefreshMisc()
end

function BingoRecordCell:OnHide()
	return
end

function BingoRecordCell:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function BingoRecordCell:RefreshMisc()
	self.tfName.text = ActivityNewDollBingoUIApi:GetString("recordName", self.name)
	self.tfTime.text = ActivityNewDollBingoUIApi:GetString("recordTime", self.time)

	self.goSignNum:SetActive(self.cfgNumData ~= nil)
	self.goSignBigBingo:SetActive(self.cfgBingoData ~= nil and #self.cfgBingoData.Combina == 8)
	self.goSignLittleBingo:SetActive(self.cfgBingoData ~= nil and #self.cfgBingoData.Combina ~= 8)
	self:RefreshReward()
end

function BingoRecordCell:RefreshReward()
	local datum = {}

	for i, v in ipairs(self.rewardDatum) do
		datum[#datum + 1] = {
			name = CfgItemTable[v[1]].Name,
			num = v[2]
		}
	end

	self.tfReward.text = ActivityNewDollBingoUIApi:GetString("rewardItemDesc", datum)
end

return BingoRecordCell
