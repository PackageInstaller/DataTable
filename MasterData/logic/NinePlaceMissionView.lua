-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NinePlaceMissionView.lua

module("logic.extensions.nineplace.view.NinePlaceMissionView", package.seeall)

local NinePlaceMissionView = class("NinePlaceMissionView", MissionView)

function NinePlaceMissionView:ctor()
	NinePlaceMissionView.super.ctor(self)
end

function NinePlaceMissionView:onEnter()
	self:onEnterInherit()
	self:_setMaskBlock(false)

	local params = self:getOpenParam()

	self.stageId = params[1]
	self.creepsMasterId = params[2]

	self:procMid()
end

function NinePlaceMissionView:onEnterFinished()
	NinePlaceMissionView.super.onEnterFinished(self)

	local userKey = "NinePlaceMission_" .. self.stageId .. "_" .. LoginModel.instance.userId
	local isFirstOpen = UnityEngine.PlayerPrefs.GetInt(userKey)

	if isFirstOpen ~= 1 then
		UnityEngine.PlayerPrefs.SetInt(userKey, 1)
		self:_openPassRuleView()
	end
end

function NinePlaceMissionView:onExit()
	NinePlaceMissionView.super.onExit(self)
end

function NinePlaceMissionView:procMid()
	local cfg = NinePlaceConfig.instance:getMonsterCfg(self.stageId, self.creepsMasterId)
	local levelStr = ""

	if cfg then
		if not cfg.name then
			local titleStr = ""

			if not cfg.passDesc then
				local ruleDesc = lang("击败所有敌方精灵可获得胜利")

				self:_setDescStr(titleStr, levelStr, ruleDesc)

				self._txtCd.text = ""

				self:_setRedPoint(cfg.redPoint)
			end
		end
	end
end

function NinePlaceMissionView:_startNow()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()
	BattleFacade.instance:startFightNightPalace(self.stageId, self.creepsMasterId)
	NinePlaceController.instance:sendPM_NinePlaceChallengeReq(self.stageId, self.creepsMasterId)
end

function NinePlaceMissionView:_onClickStart()
	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function NinePlaceMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = FormationFacade.instance:getCurFormation()
	local numPos = formation:getCurExistPetNumber(true)
	local totalPos = self:_maxPetNum()
	local petsNum = BagModel.instance:diffRacePetCount()

	if numPos == 0 then
		TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), function()
			UIStateManager.instance:push(ViewName.FormationView)
		end, lang("fight_goto_fmt"))

		return true
	end

	if numPos < totalPos and totalPos <= petsNum then
		TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("上阵精灵未满%s只（上阵精灵越多，战斗力越强），是否继续挑战？\n提示：按指定位置上阵够%s只精灵，激活阵法，获得阵法激活效果喔！"), tostring(totalPos), tostring(totalPos)), posLimitCallback)

		return true
	end
end

function NinePlaceMissionView:_isFormationValidatorMatchOnStart()
	local cfg = NinePlaceConfig.instance:getMonsterCfg(self.stageId, self.creepsMasterId)

	if cfg then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(cfg.formCondition, self:_getCurFormation()))
	end

	return true
end

function NinePlaceMissionView:_setBtnOneKeyActive()
	return false
end

return NinePlaceMissionView
