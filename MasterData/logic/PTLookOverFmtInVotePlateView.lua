-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/lookfmt/PTLookOverFmtInVotePlateView.lua

module("logic.extensions.peaktournament.view.common.PTLookOverFmtInVotePlateView", package.seeall)

local PTLookOverFmtInVotePlateView = class("PTLookOverFmtInVotePlateView", LookOverFmtBaseView)

function PTLookOverFmtInVotePlateView:onEnter()
	PTLookOverFmtInVotePlateView.super.onEnter(self)
	GameUtil.SetActive(self._btnCancel, false)
	GameUtil.SetActive(self._btnFmt, false)
end

function PTLookOverFmtInVotePlateView:_onUpdata()
	local params = self:getOpenParam()
	local resultInfoMo = params[1]

	self._isMe = params[2]
	self._fmtCount = resultInfoMo:getFormCount()
	self._fmtZdlPool = {}
	self._petInfoListGroup = {}

	for fmtIdx = 1, self._fmtCount do
		self._fmtZdlPool[fmtIdx] = resultInfoMo:getPlayerZdl(fmtIdx, self._isMe)

		local petInfoList = resultInfoMo:getPetInfoList(fmtIdx, self._isMe)

		self._petInfoListGroup[fmtIdx] = {}

		for _, petInfo in ipairs(petInfoList) do
			if petInfo.posId then
				self._petInfoListGroup[fmtIdx][petInfo.posId] = petInfo
			end
		end
	end
end

function PTLookOverFmtInVotePlateView:_isLeftFmt()
	return self._isMe
end

function PTLookOverFmtInVotePlateView:_getFmtCount()
	return self._fmtCount
end

function PTLookOverFmtInVotePlateView:_getFmtZdl(fmtIdx)
	return self._fmtZdlPool[fmtIdx]
end

function PTLookOverFmtInVotePlateView:_getFmtName(fmtIdx)
	return string.format("守阵%s", fmtIdx)
end

function PTLookOverFmtInVotePlateView:_getPetSkinId(fmtIdx, posId)
	local petInfo = self:_getPetInfo(fmtIdx, posId)
	local skind = checknumber(petInfo.faceId)

	if skind == 0 then
		skind = self:_getPetRaceId(fmtIdx, posId)
	end

	return skind
end

function PTLookOverFmtInVotePlateView:_getPetRaceId(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).raceId or 0
end

function PTLookOverFmtInVotePlateView:_getPetLevel(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).level or 0
end

function PTLookOverFmtInVotePlateView:_getPetAwakenLv(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).awakenLevel or 0
end

function PTLookOverFmtInVotePlateView:_getPetInfo(fmtIdx, posId)
	return self._petInfoListGroup[fmtIdx][posId] or {}
end

function PTLookOverFmtInVotePlateView:_onClickBtnSure()
	self:close()
end

return PTLookOverFmtInVotePlateView
