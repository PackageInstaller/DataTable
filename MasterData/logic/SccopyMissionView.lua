-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SccopyMissionView.lua

module("logic.extensions.scenariocopy.view.SccopyMissionView", package.seeall)

local SccopyMissionView = class("SccopyMissionView", MissionView)

function SccopyMissionView:ctor()
	SccopyMissionView.super.ctor(self)

	self.model = ScenariocopyModel.instance
end

function SccopyMissionView:buildUI()
	SccopyMissionView.super.buildUI(self)

	self._goBtnRule = self:getGo("btnRule")
end

function SccopyMissionView:onEnter()
	self:onEnterInherit()
	self:procMid()
	self._videoButton.gameObject:SetActive(false)
	self._btnEvaluate.gameObject:SetActive(false)
	GameUtil.SetActive(self._btnOneKey, true)
end

function SccopyMissionView:_initPowerCostNode()
	self._powerNode = self:getGo("NodePower")
	self._powerCostNum = self:getTxt("NodePower/Power")
	self._iconPower = self:getGo("NodePower/Icon")
end

function SccopyMissionView:_updatePowerCost(num, isShowNoCost)
	local stageCfg = ScenariocopyModel.instance:getStageCfg()

	if not string.nilorempty(stageCfg.energyConsume) then
		local matType, id, matNum = MaterialMgr.getMatParams(stageCfg.energyConsume)

		self._powerNode.gameObject:SetActive(checknumber(matNum) > 0 and not isPass)

		local matCfg = MaterialMgr.getMatCfgByStr(stageCfg.energyConsume)

		uGuiUtil.setSpriteToImage(self._iconPower, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))

		self._powerCostNum.text = matNum
	else
		self._powerNode.gameObject:SetActive(false)
	end
end

function SccopyMissionView:onExit()
	SccopyMissionView.super.onExit(self)
	uGuiUtil.clearImage(self._iconPower)
end

function SccopyMissionView:_saveFormationEx()
	return false
end

function SccopyMissionView:procMid()
	local titleStr = ScenariocopyController.instance:getStageName(nil, nil, nil, true)
	local levelStr = ""
	local stageCfg = ScenariocopyModel.instance:getStageCfg()
	local ruleDesc, perfectDesc = "", ""

	if stageCfg then
		ruleDesc = stageCfg.passDesc
		perfectDesc = stageCfg.perfetPassDesc
	end

	self:_setPerfectRuleDesc(perfectDesc)
	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
	self:_updatePowerCost()
end

function SccopyMissionView:_onClickStart()
	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function SccopyMissionView:_startClg()
	self:_setMaskBlock(true)
	self:_startNow()
end

function SccopyMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = self.model:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = self:_maxPetNum()
	local petsNum = self.model:diffRacePetCount()
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
		local function forceFightCallBack()
			self:_startClg()
		end

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("上阵精灵未满%s只（上阵精灵越多，战斗力越强），请一键布阵上阵%s只精灵吧！", showNum, showNum), forceFightCallBack, nil, lang("确定"), lang("去布阵"))
	end

	return boo
end

function SccopyMissionView:_setBattleResultTxtTitle()
	local stageId = ScenariocopyModel.instance:getStageId()
	local chapterId = ScenariocopyModel.instance:getChapterId()
	local stageCfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)

	BattleSettlementModel.instance:setTxtTitle(stageCfg.enemyName)
end

function SccopyMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	ScenariocopyFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function SccopyMissionView:_onClickClean()
	local fixedPosDic = MissionModel.instance:getFixedPos()

	ScenariocopyFastFormation.instance:clean(fixedPosDic)
end

function SccopyMissionView:_enterBattle()
	local chapterId = ScenariocopyModel.instance:getChapterId()
	local stageId = ScenariocopyModel.instance:getStageId()
	local viewName = self:getFirstParam()

	ScenariocopyController.instance:pushOneStackView(chapterId, stageId, viewName)
	ScenariocopyController.instance:startBattle()
end

function SccopyMissionView:_maxPetNum()
	return 5
end

return SccopyMissionView
