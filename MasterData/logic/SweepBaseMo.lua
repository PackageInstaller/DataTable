-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mopup/model/SweepBaseMo.lua

module("logic.extensions.mopup.model.SweepBaseMo", package.seeall)

local SweepBaseMo = class("SweepBaseMo")

function SweepBaseMo:ctor()
	self.matType = 0
	self.matId = 0
	self.unitCost = 1
	self.sweepType = self:_initSweepType()
end

function SweepBaseMo:_initSweepType()
	return MopupModel.Default
end

function SweepBaseMo:setMatCost(ticketStr)
	local isSuccess = false
	local arr = string.split(ticketStr, ":")

	if arr and #arr >= 3 then
		local matType = checknumber(arr[1])

		self.matType = matType
		self.matId = checknumber(arr[2])
		self.unitCost = checknumber(arr[#arr])
		isSuccess = true
	end

	return isSuccess
end

return SweepBaseMo
