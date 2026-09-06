-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankrace/controller/RankRaceFmtController.lua

module("logic.extensions.rankrace.controller.RankRaceFmtController", package.seeall)

local RankRaceFmtController = class("RankRaceFmtController", BaseController)

function RankRaceFmtController:onInit()
	RankRaceFmtController.super.onInit(self)
end

function RankRaceFmtController:onReset()
	RankRaceFmtController.super.onReset(self)

	self._defenseFormMatchType = nil
	self._defenseFormCallback = nil
	self._defenseFormCallbackObj = nil
	self._enterDefenseFormOnBack = nil
	self._readyFight = nil
	self._isOnlyGetDefenseFormData = false
end

function RankRaceFmtController:checkDefenseForm(matchType, callback, callbackObj)
	local defenseForm = RankRaceFmtModel.instance:getDefenseForm(matchType)
	local defenseBuffId = RankRaceFmtModel.instance:getDefenseBuffId(matchType)

	self._defenseFormMatchType = matchType
	self._defenseFormCallback = callback
	self._defenseFormCallbackObj = callbackObj
	self._enterDefenseFormOnBack = nil

	if defenseForm and not defenseForm:isEmpty() and defenseBuffId and defenseBuffId ~= 0 then
		self:_notyfyDefenseForm()
	else
		RankingMatchAgent.instance:sendRM_GetMyDefenseFormReq(matchType)
	end
end

function RankRaceFmtController:enterDefenseForm(matchType, force)
	local defenseForm = RankRaceFmtModel.instance:getDefenseForm(matchType)

	self._defenseFormMatchType = matchType

	if not defenseForm or force == true then
		self._enterDefenseFormOnBack = true

		RankingMatchAgent.instance:sendRM_GetMyDefenseFormReq(matchType)
	else
		self._enterDefenseFormOnBack = nil

		UIStateManager.instance:push(ViewName.RankRaceDefenseFormView, matchType)
	end
end

function RankRaceFmtController:_notyfyDefenseForm()
	local callback = self._defenseFormCallback
	local callbackObj = self._defenseFormCallbackObj
	local matchType = self._defenseFormMatchType

	self._defenseFormMatchType = nil
	self._defenseFormCallback = nil
	self._defenseFormCallbackObj = nil
	self._enterDefenseFormOnBack = nil

	if callback then
		if callbackObj then
			self._defenseFormCallback(callbackObj, matchType)
		else
			self._defenseFormCallback(matchType)
		end
	end
end

function RankRaceFmtController:onGetMyDefenseForm(defenseForm, defenseBuffId)
	local matchType = self._defenseFormMatchType

	RankRaceFmtModel.instance:setDefenseForm(matchType, defenseForm)
	RankRaceFmtModel.instance:setDefenseBuffId(matchType, defenseBuffId)

	if self._isOnlyGetDefenseFormData then
		self._isOnlyGetDefenseFormData = false

		return
	end

	if self._enterDefenseFormOnBack then
		self:enterDefenseForm(matchType)
	else
		local hasPos = false

		for i = 1, 9 do
			if defenseForm.pos[i] and defenseForm.pos[i] ~= 0 then
				hasPos = true

				break
			end
		end

		if defenseForm and hasPos and defenseBuffId and defenseBuffId ~= 0 then
			self:_notyfyDefenseForm()
		else
			self._defenseFormCallback = nil

			UIStateManager.instance:push(ViewName.RankRaceFmtSelectView, matchType)
		end
	end
end

function RankRaceFmtController:onAutoSetDefenseFormRes(defenseBuffId)
	local matchType = self._defenseFormMatchType
	local currFormation = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local defenseForm = {}

	defenseForm.formId = currFormation:GetId()
	defenseForm.pos = table.values(currFormation:GetPositions())
	defenseForm._hasPets = {}

	table.merge(defenseForm._hasPets, currFormation._hasPets)

	defenseForm.extParams = {
		heroSkillId = currFormation:GetHeroSkillId(),
		psychicSkillId = currFormation:GetPsychicedSkillId()
	}

	RankRaceFmtModel.instance:setDefenseForm(matchType, defenseForm, true)
	RankRaceFmtModel.instance:setDefenseBuffId(matchType, defenseBuffId)
	self:_notyfyDefenseForm()
	self:notify(GlobalNotify.RankAutoSetDefenseForm)
end

function RankRaceFmtController:onSetDefenseFormRes()
	self:_notyfyDefenseForm()
	self:notify(GlobalNotify.RankSetDefenseForm)
end

function RankRaceFmtController:notifyBeginGame(info)
	RankRaceChallengerModel.instance:notifyBeginGame(info)
	UIStateManager.instance:push(ViewName.RankRaceMissionView, info.matchType)
end

function RankRaceFmtController:notifyOpReadyFight()
	self._readyFight = true

	self:notify(GlobalNotify.RankRaceOpPlayerReady)
end

function RankRaceFmtController:getReadyFight()
	return self._readyFight
end

function RankRaceFmtController:setReadyFight(_tag)
	self._readyFight = _tag
end

function RankRaceFmtController:onlySendGetDefenseFormData(matchType)
	self._isOnlyGetDefenseFormData = true
	self._defenseFormMatchType = matchType

	RankingMatchAgent.instance:sendRM_GetMyDefenseFormReq(matchType)
end

RankRaceFmtController.instance = RankRaceFmtController.New()

return RankRaceFmtController
