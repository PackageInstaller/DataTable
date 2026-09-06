-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/common/lookfmt/PTLookOverFmtInQualifierView.lua

module("logic.extensions.peaktournament.view.common.PTLookOverFmtInQualifierView", package.seeall)

local PTLookOverFmtInQualifierView = class("PTLookOverFmtInQualifierView", LookOverFmtBaseView)

function PTLookOverFmtInQualifierView:onEnter()
	PTLookOverFmtInQualifierView.super.onEnter(self)
	GameUtil.SetActive(self._btnCancel, true)
	GameUtil.SetActive(self._btnFmt, true)
	GameUtil.SetActive(self._btnSure, false)
end

function PTLookOverFmtInQualifierView:_onUpdata()
	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local formList = params[2]

	self._fmtCount = #formList
	self._petInfoListGroup = {}
	self._fmtZdlPool = {}

	for fmtIdx, form in ipairs(formList) do
		self._fmtZdlPool[fmtIdx] = form.zdl

		local playerView = form.view
		local petInfoList = {}

		for posId, petId in pairs(playerView.curForm.pos) do
			local petView

			for _, v in ipairs(playerView.petSimpleView) do
				if v.petId == petId then
					petView = v

					break
				end
			end

			local petInfo = {}

			if petView then
				petInfo.raceId = petView.raceId
				petInfo.skinId = checknumber(petView.curFaceId)

				if petInfo.skinId == 0 then
					petInfo.skinId = petView.raceId
				end

				petInfo.level = petView.curLv
				petInfo.awakenLv = petView.awakenLv
			end

			petInfoList[posId] = petInfo
		end

		self._petInfoListGroup[fmtIdx] = petInfoList
	end
end

function PTLookOverFmtInQualifierView:_getFmtCount()
	return self._fmtCount
end

function PTLookOverFmtInQualifierView:_getFmtZdl(fmtIdx)
	return self._fmtZdlPool[fmtIdx] or "？？？"
end

function PTLookOverFmtInQualifierView:_getFmtName(fmtIdx)
	return string.format("守阵%s", fmtIdx)
end

function PTLookOverFmtInQualifierView:_getPetSkinId(fmtIdx, posId)
	local petInfo = self:_getPetInfo(fmtIdx, posId)
	local skind = checknumber(petInfo.faceId)

	if skind == 0 then
		skind = self:_getPetRaceId(fmtIdx, posId)
	end

	return skind
end

function PTLookOverFmtInQualifierView:_getPetRaceId(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).raceId or 0
end

function PTLookOverFmtInQualifierView:_getPetLevel(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).level or 0
end

function PTLookOverFmtInQualifierView:_getPetAwakenLv(fmtIdx, posId)
	return self:_getPetInfo(fmtIdx, posId).awakenLv or 0
end

function PTLookOverFmtInQualifierView:_getPetInfo(fmtIdx, posId)
	return self._petInfoListGroup[fmtIdx][posId] or {}
end

function PTLookOverFmtInQualifierView:_isLeftFmt()
	return false
end

function PTLookOverFmtInQualifierView:_onClickBtnFmt()
	local result, tips = PeakTournamentController.instance:getStartFightResultAndTipsAsQua(self._activityId)

	if not string.nilorempty(tips) then
		FloatWordMgr.instance:show(tips)
	end

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	self:close()
	PeakTournamentController.instance:enterBattleAsPT(self._activityId)
end

return PTLookOverFmtInQualifierView
