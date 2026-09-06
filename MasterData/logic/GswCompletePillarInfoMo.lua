-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GswCompletePillarInfoMo.lua

module("logic.extensions.godstatueswar.data.GswCompletePillarInfoMo", package.seeall)

local GswCompletePillarInfoMo = class("GswCompletePillarInfoMo")

function GswCompletePillarInfoMo:ctor()
	self._fmtInfoMoPoolInTier = {}
	self._emptyFmtInfoMo = GswCompleteTierFmtInfoMo.New()
end

function GswCompletePillarInfoMo:onReset()
	self:resetAllTierFmtInfoMo()
end

function GswCompletePillarInfoMo:initData(msg)
	self:onReset()

	local seasonId = msg.seasonId
	local tierCount = GodStatuesWarController.instance:getTierCount(seasonId)
	local formInfoMap = {}

	for _, v in ipairs(msg.challengeInfoList) do
		local tierId = v.tier

		formInfoMap[tierId] = {}

		for idx, vv in ipairs(v.formList) do
			formInfoMap[tierId][idx] = vv
		end
	end

	for tierId = 1, tierCount do
		local seatCount = GodStatuesWarController.instance:getSeatCountInTier(seasonId, tierId)

		for seatIdx = 1, seatCount do
			local mo = self:addTierFmtInfoMo(tierId, seatIdx)

			if formInfoMap[tierId] then
				local formInfo = formInfoMap[tierId][seatIdx]

				if formInfo then
					mo:initData(formInfo)
				end
			end
		end
	end
end

function GswCompletePillarInfoMo:getTierFmtInfoMo(tierId, seatIdx)
	if self._fmtInfoMoPoolInTier[tierId] then
		return self._fmtInfoMoPoolInTier[tierId][seatIdx] or self._emptyFmtInfoMo
	end
end

function GswCompletePillarInfoMo:getTotalCurHp(tierId)
	local result = 0

	if not self._fmtInfoMoPoolInTier[tierId] then
		for seatIdx, fmtInfoMo in ipairs(self._fmtInfoMoPoolInTier[tierId]) do
			local hp = fmtInfoMo:getCurHp()

			result = result + hp
		end

		return result
	end
end

function GswCompletePillarInfoMo:addTierFmtInfoMo(tierId, seatIdx)
	local mo

	if self._fmtInfoMoPoolInTier[tierId] then
		mo = self._fmtInfoMoPoolInTier[tierId][seatIdx]
	else
		self._fmtInfoMoPoolInTier[tierId] = {}
	end

	if mo == nil then
		mo = GswCompleteTierFmtInfoMo.New()
		self._fmtInfoMoPoolInTier[tierId][seatIdx] = mo
	end

	return mo
end

function GswCompletePillarInfoMo:resetTierFmtInfoMo(tierId, seatIdx)
	local mo = self:getTierFmtInfoMo(tierId, seatIdx)

	if mo then
		mo:onReset()
	end
end

function GswCompletePillarInfoMo:resetAllTierFmtInfoMo()
	if self._fmtInfoMoPoolInTier then
		for tierId, v in pairs(self._fmtInfoMoPoolInTier) do
			for seatIdx, mo in pairs(v) do
				mo:onReset()
			end
		end
	end
end

return GswCompletePillarInfoMo
