-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/funarena/view/formation/FunArenaFormationView.lua

module("logic.extensions.funarena.view.formation.FunArenaFormationView", package.seeall)

local FunArenaFormationView = class("FunArenaFormationView", FormationView)

function FunArenaFormationView:buildUI()
	FunArenaFormationView.super.buildUI(self)
	goutil.setActive(self._btnRecFormation.gameObject, false)
	goutil.setActive(self._btnShare.gameObject, false)
	self._btnSingleLine:Layout()
end

function FunArenaFormationView:onExit()
	FunArenaFormationView.super.onExit(self)

	local formationMO = FunArenaModel.instance:getCurFormMo()

	formationMO:_setAllPositions(self.positions)
	GlobalDispatcher:removeListener(FunArenaAgent.PM_BigCastChallengeSetFormReq, self.onMsgHandler, self)
end

function FunArenaFormationView:onEnter()
	self._titleTxt1.text = ""

	GameUtil.SetActive(self._titleTxt1.gameObject, false)

	self._tipObj.text = lang("FunArena_Formation_Tips_1")

	GameUtil.SetActive(self._tipObj.gameObject, true)

	local formationMO = FunArenaModel.instance:getCurFormMo()
	local posList = formationMO:GetPositions()

	self.positions = {}

	for _, pos in ipairs(posList) do
		table.insert(self.positions, pos)
	end

	GlobalDispatcher:addListener(FunArenaAgent.PM_BigCastChallengeSetFormReq, self.onMsgHandler, self)
end

function FunArenaFormationView:onMsgHandler()
	self:_onClickClose()

	local canGainBuffIds = FunArenaModel.instance._infoRes.canGainBuffIds

	if #canGainBuffIds ~= 0 then
		UIStateManager.instance:push(ViewName.FunArenaBuffView)
	else
		FunArenaController.instance:onSendFightReq(FunArenaModel.instance.activityId)
	end
end

function FunArenaFormationView:_onClickSave()
	local formationMO = FunArenaModel.instance:getCurFormMo()
	local maxPetNum = self:_maxPetNum()
	local isNeedSummonPet = true
	local curPetNum = formationMO:getCurExistPetNumber(isNeedSummonPet)

	if formationMO:isEmpty() then
		FloatWordMgr.instance:show(lang("FunArena_Formation_Tips_4"))

		return
	end

	local function okFunc()
		FunArenaController.instance:onSendSetFormReq()
	end

	local function cencelFunc()
		return
	end

	local title = lang("tip")
	local tips = ""
	local okFuncText = lang("confirm")
	local cancelFuncText = lang("cancel")
	local alignment

	if curPetNum < maxPetNum then
		tips = langPara("FunArena_Formation_Tips_2", 5)
	elseif maxPetNum <= curPetNum then
		tips = lang("FunArena_Formation_Tips_3")
	end

	TipsFacade.instance:openPopupWindow(title, tips, okFunc, cencelFunc, okFuncText, cancelFuncText, alignment)
end

function FunArenaFormationView:_onClickClose()
	self:close()
end

return FunArenaFormationView
