-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/QianNiaoZhenShenView.lua

module("logic.extensions.challenge.view.specialviews.QianNiaoZhenShenView", package.seeall)

local QianNiaoZhenShenView = class("QianNiaoZhenShenView", ViewComponent)
local json = require("cjson")

function QianNiaoZhenShenView:ctor()
	self._descTable = {
		function(num)
			return langPara("累计找到<color=#ff5068>%s个</color>千鸟真身，即可通过真假道试炼，开启千鸟进化！", num)
		end,
		function(num)
			return langPara("累计找到<color=#ff5068>%s个</color>千鸟真身，即可通过虚幻道试炼！", num)
		end,
		function(num)
			return langPara("每天会有<color=#ff5068>%s次</color>免费次数，挑战胜利可增加次数，挑战和次数每天5:00重置", num)
		end
	}

	QianNiaoZhenShenView.super.ctor(self)
end

function QianNiaoZhenShenView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._findBtn:AddClickListener(self._onClickFind, self)

	for i = 1, 3 do
		self._missionBtns[i]:AddClickListener(function()
			self:_onClickBtn(i)
		end, self)
	end
end

function QianNiaoZhenShenView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._findBtn:RemoveClickListener()

	for i = 1, 3 do
		self._missionBtns[i]:RemoveClickListener()
	end
end

function QianNiaoZhenShenView:buildUI()
	self._closeButton = self:getBtn("Btn_Close")
	self._findBtn = self:getBtn("BtnFind")
	self._desc = self:getGo("Img/TxtDesc"):GetComponent("Text")
	self._desc1 = self:getGo("Img/TxtDesc1"):GetComponent("Text")
	self._leftTime = self:getGo("ImgLeft/TxtNum"):GetComponent("Text")
	self._target = self:getGo("Prog/Num2/TxtDesc"):GetComponent("Text")
	self._targetHlf = self:getGo("Prog/Num1/TxtDesc"):GetComponent("Text")
	self._foundNum = self:getGo("ImgFound/TxtFindNum"):GetComponent("Text")
	self._prog = self:getGo("Prog"):GetComponent("Slider")
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

function QianNiaoZhenShenView:destroyUI()
	return
end

function QianNiaoZhenShenView:onEnter()
	self._fightTimes = {}

	for i = 1, 3 do
		local addCfg = self:_getFmtAdd(i)

		self._zdlTxts[i].text = langPara("推荐战斗力:%s", addCfg.zdl)
		self._addTimeTxts[i].text = langPara("挑战胜利可增加<color=#ff5068>%s</color>次游戏次数", addCfg.playTimesAdd)
		self._fightTimes[i] = self:_getFightTime(i)

		self._passed[i]:SetActive(self._fightTimes[i] > 0)
	end

	self:refreshInfo()
end

function QianNiaoZhenShenView:refreshInfo()
	local clgCfg = self:_getClgCfg()

	self._target.text = clgCfg.accumulateTarget
	self._targetHlf.text = math.ceil(clgCfg.accumulateTarget / 2)
	self._desc.text = self._descTable[ChallengeModel.instance:getCurPhase()](clgCfg.accumulateTarget)
	self._desc1.text = self._descTable[3](clgCfg.freeTimes)

	local para = self:_getGamePara()

	self._leftTime.text = clgCfg.freeTimes - para.playTimes
	self._foundNum.text = para.accumulateCount
	self._prog.value = para.accumulateCount / clgCfg.accumulateTarget
	self._leftCount = clgCfg.freeTimes - para.playTimes

	if para.accumulateCount >= clgCfg.accumulateTarget then
		self:_onClickClose()
	end
end

function QianNiaoZhenShenView:onEnterFinished()
	return
end

function QianNiaoZhenShenView:onExit()
	self._leftCount = 0
end

function QianNiaoZhenShenView:onExitFinished()
	return
end

function QianNiaoZhenShenView:_getFmtAdd(idx)
	local phaseIdx = ChallengeModel.instance:getCurPhase() - 1
	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), phaseIdx * 3 + idx)

	return evCfg.value
end

function QianNiaoZhenShenView:_getClgCfg()
	local phaseIdx = ChallengeModel.instance:getCurPhase() - 1
	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), phaseIdx + 7)

	return evCfg.value
end

function QianNiaoZhenShenView:_getFightTime(idx)
	local extPara = ChallengeModel.instance:getBranchExtPara(idx - 1)

	return json.decode(extPara).fightTimes
end

function QianNiaoZhenShenView:_getGamePara()
	local extPara = ChallengeModel.instance:getBranchExtPara(3)

	return json.decode(extPara)
end

function QianNiaoZhenShenView:_onClickClose()
	self:close()
end

function QianNiaoZhenShenView:_onClickFind()
	if self._leftCount <= 0 then
		FloatWordMgr.instance:show(lang("没有游戏次数了哦"))

		return
	end

	self:close()

	local clgCfg = self:_getClgCfg()
	local para = self:_getGamePara()
	local params = {
		para.accumulateCount,
		clgCfg.accumulateTarget
	}
	local cls = QianNiaoPickAPet.New()

	cls:setParams(params)
	cls:setGateId(ChallengeModel.instance:getCurPhase())
	UIStateManager.instance:push(ViewName.PickAPetView, cls)
end

function QianNiaoZhenShenView:_onClickBtn(index)
	if self._fightTimes[index] > 0 then
		FloatWordMgr.instance:show(lang("今天已挑战过"))

		return
	end

	QianNiaoWanView._prePhase = ChallengeModel.instance:getCurPhase()
	QianNiaoWanView._preBranch = index - 1

	UIStateManager.instance:push(ViewName.missionview, ChallengeModel.instance:getCurPhase(), index - 1)
end

return QianNiaoZhenShenView
