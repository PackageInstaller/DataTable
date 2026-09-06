-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/XiongMaoJumpView.lua

module("logic.extensions.challenge.view.specialviews.XiongMaoJumpView", package.seeall)

local XiongMaoJumpView = class("XiongMaoJumpView", ViewComponent)
local json = require("cjson")

function XiongMaoJumpView:ctor()
	self._descTable = {
		function(num)
			return langPara("累计获得<color=#ffd70f>%s个</color>梅花之证\n即可通过梅花桩试炼，开启功夫熊猫进化！", num)
		end,
		function(num)
			return langPara("累计获得<color=#ffd70f>%s个</color>八卦之证\n即可通过八卦桩极限试炼！", num)
		end,
		function(num)
			return langPara("挑战和游戏次数每天<color=#ffd70f>5:00重置</color>\n每天会有<color=#ffd70f>%s次免费</color>游戏次数，挑战胜利可增加次数", num)
		end
	}

	XiongMaoJumpView.super.ctor(self)
end

function XiongMaoJumpView:_getCardDesc(index)
	local desc = {
		"已得梅花之证",
		"已得八卦之证"
	}

	return desc[index]
end

function XiongMaoJumpView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._findBtn:AddClickListener(self._onClickFind, self)

	for i = 1, 3 do
		self._missionBtns[i]:AddClickListener(function()
			self:_onClickBtn(i)
		end, self)
	end
end

function XiongMaoJumpView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._findBtn:RemoveClickListener()

	for i = 1, 3 do
		self._missionBtns[i]:RemoveClickListener()
	end
end

function XiongMaoJumpView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._findBtn = self:getBtn("BtnFind")
	self._imgBtnFind = self:getGo("BtnFind"):GetComponent("Image")
	self._desc = self:getGo("Img/TxtDesc"):GetComponent("Text")
	self._desc1 = self:getGo("Img/TxtDesc1"):GetComponent("Text")
	self._leftTime = self:getGo("ImgLeft/TxtNum"):GetComponent("Text")
	self._target = self:getGo("Prog/Num2/TxtDesc"):GetComponent("Text")
	self._targetHlf = self:getGo("Prog/Num1/TxtDesc"):GetComponent("Text")
	self._halfLeaf = self:getGo("Prog/Num1/img")
	self._allLeaf = self:getGo("Prog/Num2/img")
	self._foundNum = self:getGo("ImgFound/TxtFindNum"):GetComponent("Text")
	self._txtFound = self:getGo("ImgFound/TxtFound"):GetComponent("Text")
	self._prog = self:getGo("Prog"):GetComponent("Slider")
	self._prog1 = self:getGo("Prog1"):GetComponent("Slider")
	self._imgIcon = self:getGo("Img/TxtDesc/img"):GetComponent("UIImageSpriteChange")
	self._missionBtns = {}
	self._zdlTxts = {}
	self._addTimeTxts = {}
	self._passed = {}

	for i = 1, 3 do
		local markObj = self:getGo("M" .. i)

		self._missionBtns[i] = Framework.ButtonAdapter.GetFrom(markObj, "BtnChallenge")
		self._zdlTxts[i] = goutil.findChild(markObj, "TxtZDL"):GetComponent("Text")
		self._addTimeTxts[i] = goutil.findChild(markObj, "TxtDesc"):GetComponent("Text")
		self._passed[i] = goutil.findChild(markObj, "Passed")
	end

	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), 9)
end

function XiongMaoJumpView:destroyUI()
	return
end

function XiongMaoJumpView:onEnter()
	local curPhase = ChallengeModel.instance:getCurPhase()

	if not curPhase or curPhase == -1 then
		return
	end

	self._fightTimes = {}

	for i = 1, 3 do
		local addCfg = self:_getFmtAdd(i)

		self._zdlTxts[i].text = addCfg.zdl
		self._addTimeTxts[i].text = langPara("%s次", addCfg.playTimesAdd)
		self._fightTimes[i] = self:_getFightTime(i)

		self._passed[i]:SetActive(self._fightTimes[i] > 0)
	end

	self._txtFound.text = self:_getCardDesc(ChallengeModel.instance:getCurPhase())

	self:refreshInfo()
end

function XiongMaoJumpView:_getLeftTime()
	local clgCfg = self:_getClgCfg()
	local para = self:_getGamePara()

	return clgCfg.freeTimes - para.playTimes
end

function XiongMaoJumpView:refreshInfo()
	local clgCfg = self:_getClgCfg()
	local halfNum = math.ceil(clgCfg.accumulateTarget / 2)

	self._target.text = clgCfg.accumulateTarget
	self._targetHlf.text = halfNum

	self._imgIcon:ChangeStateNow(ChallengeModel.instance:getCurPhase() - 1)

	self._desc.text = self._descTable[ChallengeModel.instance:getCurPhase()](clgCfg.accumulateTarget)
	self._desc1.text = self._descTable[3](clgCfg.freeTimes)

	local para = self:_getGamePara()
	local times = clgCfg.freeTimes - para.playTimes

	self._imgBtnFind.color = times <= 0 and Color.black or Color.white
	self._leftTime.text = times

	self._halfLeaf:SetActive(halfNum <= para.accumulateCount)
	self._allLeaf:SetActive(para.accumulateCount >= clgCfg.accumulateTarget)

	self._foundNum.text = para.accumulateCount

	local percent = para.accumulateCount / clgCfg.accumulateTarget

	self._prog.value = percent
	self._prog1.value = percent
	self._leftCount = clgCfg.freeTimes - para.playTimes

	if para.accumulateCount >= clgCfg.accumulateTarget then
		self:_onClickClose()
	end
end

function XiongMaoJumpView:onEnterFinished()
	return
end

function XiongMaoJumpView:onExit()
	self._leftCount = 0
end

function XiongMaoJumpView:_getFmtAdd(idx)
	local phaseIdx = ChallengeModel.instance:getCurPhase() - 1
	local curId = ChallengeModel.instance:getCurId()
	local evCfg = ChallengeConfig.instance:getChallengeKV(curId, phaseIdx * 3 + idx)

	if evCfg then
		return evCfg.value
	end

	evCfg = ChallengeConfig.instance:getChallengeKV(curId, 1)

	return evCfg.value
end

function XiongMaoJumpView:_getClgCfg()
	local phaseIdx = ChallengeModel.instance:getCurPhase() - 1
	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), phaseIdx + 7)

	return evCfg.value
end

function XiongMaoJumpView:_getFightTime(idx)
	local extPara = ChallengeModel.instance:getBranchExtPara(idx - 1)

	return json.decode(extPara).fightTimes
end

function XiongMaoJumpView:_getGamePara()
	local extPara = ChallengeModel.instance:getBranchExtPara(3)

	return json.decode(extPara)
end

function XiongMaoJumpView:_onClickClose()
	UIStateManager.instance:popByName(self._viewPresentor.viewName)
end

function XiongMaoJumpView:_onClickFind()
	if self._leftCount <= 0 then
		FloatWordMgr.instance:show(lang("没有游戏次数了哦"))

		return
	end

	local clgCfg = self:_getClgCfg()
	local para = self:_getGamePara()
	local params = {
		para.accumulateCount,
		clgCfg.accumulateTarget
	}

	UIStateManager.instance:open("jumpStartView", ChallengeModel.instance:getCurPhase(), params)
end

function XiongMaoJumpView:_onClickBtn(index)
	if self._fightTimes[index] > 0 then
		FloatWordMgr.instance:show(lang("今天已挑战过"))

		return
	end

	if self:_getLeftTime() > 0 then
		local title = ""
		local content = "先去把剩余的游戏次数都使用光后再来挑战吧"
		local btnTxt = "知道了"

		TipsFacade.instance:openTipWindow(title, content, nil, btnTxt)

		return
	end

	XiongMaoView._prePhase = ChallengeModel.instance:getCurPhase()
	XiongMaoView._preBranch = index - 1

	UIStateManager.instance:push(ViewName.missionview, ChallengeModel.instance:getCurPhase(), index - 1)
end

return XiongMaoJumpView
