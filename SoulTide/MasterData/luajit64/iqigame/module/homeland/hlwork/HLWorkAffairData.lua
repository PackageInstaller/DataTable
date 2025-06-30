-- chunkname: @IQIGame\\Module\\HomeLand\\HLWork\\HLWorkAffairData.lua

HLWorkAffairData = {}

function HLWorkAffairData.New()
	local o = Clone(HLWorkAffairData)

	return o
end

function HLWorkAffairData:Initialize(POD)
	self.id = POD.id
	self.cid = POD.cid
	self.status = POD.status
	self.finishTime = POD.finishTime
	self.soulCids = POD.soulCids
	self.events = POD.events
	self.cfgAffairData = CfgTransactionListTable[POD.cid]

	if #self.events > 1 then
		table.sort(self.events, function(a, b)
			return a.time < b.time
		end)
	end
end
