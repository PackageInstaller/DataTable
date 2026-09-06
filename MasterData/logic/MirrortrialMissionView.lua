-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mirrortrial/view/MirrortrialMissionView.lua

module("logic.extensions.mirrortrial.view.MirrortrialMissionView", package.seeall)

local MirrortrialMissionView = class("MirrortrialMissionView", MissionView)

function MirrortrialMissionView:ctor()
	MirrortrialMissionView.super.ctor(self)
end

function MirrortrialMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(false)
	self._btnEvaluate.gameObject:SetActive(false)
	GameUtil.SetActive(self._btnOneKey, true)
	GlobalDispatcher:addListener(MirrorTrialController.DailyReset, self._dailyReset, self)
	GlobalDispatcher:addListener(MirrorTrialController.EnterFightFailed, self._enterBattleFail, self)
end

function MirrortrialMissionView:_initPowerCostNode()
	self._powerNode = self:getGo("NodePower")
	self._powerCostNum = self:getTxt("NodePower/Power")
	self._iconPower = self:getGo("NodePower/Icon")
end

function MirrortrialMissionView:_updatePowerCost(num, isShowNoCost)
	local stageCfg = self._curStageCfg

	if not string.nilorempty(stageCfg.strengthConsumption) then
		local matType, id, matNum = MaterialMgr.getMatParams(stageCfg.strengthConsumption)

		self._powerNode.gameObject:SetActive(checknumber(matNum) > 0 and not isPass)

		local matCfg = MaterialMgr.getMatCfgByStr(stageCfg.strengthConsumption)

		uGuiUtil.setSpriteToImage(self._iconPower, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))

		self._powerCostNum.text = matNum
	else
		self._powerNode.gameObject:SetActive(false)
	end
end

function MirrortrialMissionView:onExit()
	MirrortrialMissionView.super.onExit(self)
	uGuiUtil.clearImage(self._iconPower)
	GlobalDispatcher:removeListener(MirrorTrialController.EnterFightFailed, self._enterBattleFail, self)
	GlobalDispatcher:removeListener(MirrorTrialController.DailyReset, self._dailyReset, self)
end

function MirrortrialMissionView:procMid()
	self._params = self:getOpenParam()
	self._curActBaseCfg = self._params[1]
	self._curStage = MirrorTrialModel.instance:getCurStage()
	self._curStageCfg = MirrorTrialConfig.instance:getStageCfgsById(self._curActBaseCfg.activityId, self._curStage + 1)

	local cfg = self._curStageCfg

	if not cfg then
		self:_onClickClose()

		return
	end

	local titleStr = cfg.name
	local levelStr = ""

	if not cfg.desc then
		local perfectDesc = ""

		self:_setPerfectRuleDesc(perfectDesc)
		self:_setDescStr(titleStr, levelStr, cfg.desc)
		self:_setTitleName()
		self:_updatePowerCost()
	end
end

function MirrortrialMissionView:_enterBattle()
	MirrorTrialAgent:sendPM_MirrorTrialFightReq(self._curActBaseCfg.activityId, self._curStage + 1)
	BattleFacade.instance:startMirrorTrial(self._curStage + 1)
	UIJumper.instance:pushOneStack(ViewName.MirrortrialchapterView)
end

function MirrortrialMissionView:_dailyReset()
	self._curActCfg = MirrorTrialModel.instance:getCurActCfg()

	if self._curActCfg then
		-- block empty
	else
		TipsFacade.instance:openCommonTips("活动已结束")
		self:_onClickClose()
	end
end

function MirrortrialMissionView:_enterBattleFail()
	TipsFacade.instance:openCommonTips("无法进行镜像挑战")
	self:_onClickClose()
end

function MirrortrialMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if FormationFacade.instance:checkFormationEmpty() then
		return true
	end

	return self:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
end

function MirrortrialMissionView:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
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

return MirrortrialMissionView
