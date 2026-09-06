-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchMissionView.lua

module("logic.extensions.petsearch.view.PetsearchMissionView", package.seeall)

local PetsearchMissionView = class("PetsearchMissionView", MissionView)

function PetsearchMissionView:ctor()
	PetsearchMissionView.super.ctor(self)
end

function PetsearchMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(false)
	GlobalDispatcher:addListener(GlobalNotify.RefreshSearchPet, self._dailyReset, self)
end

function PetsearchMissionView:onExit()
	PetsearchMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshSearchPet, self._dailyReset, self)
end

function PetsearchMissionView:procMid()
	local bossId = PetsearchModel.instance:getCurBossId()

	if not bossId or bossId == 0 then
		return
	end

	local cfg = PetsearchConfig.instance:getTeamCfgByBossId(bossId)

	if not cfg then
		return
	end

	local titleStr = cfg.name
	local levelStr = ""

	if cfg.description then
		if not cfg.description then
			local ruleDesc = ""

			self:_setDescStr(titleStr, levelStr, ruleDesc)
		end
	end
end

function PetsearchMissionView:_enterBattle()
	PetsearchController.instance:sendSeekPetChallenge()
	UIJumper.instance:pushOneStack(ViewName.PetsearchmainView, true)
end

function PetsearchMissionView:_dailyReset()
	FloatWordMgr.instance:show("精灵已逃逸，请重新寻觅")
	self:_onClickClose()
end

function PetsearchMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if FormationFacade.instance:checkFormationEmpty() then
		return true
	end

	return self:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
end

function PetsearchMissionView:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = FormationFacade.instance:curFormationPetNum()
	local curFormId = FormationModel.instance:getCurFormId()
	local formationCo = BattleConfig.instance:getFormationCo(curFormId)
	local totalPos = 5
	local petsNum = BagModel.instance:diffRacePetCount()
	local showNum = -1
	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

return PetsearchMissionView
