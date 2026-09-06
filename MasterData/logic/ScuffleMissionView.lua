-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/buzhen/ScuffleMissionView.lua

module("logic.extensions.scuffle.view.buzhen.ScuffleMissionView", package.seeall)

local ScuffleMissionView = class("ScuffleMissionView", MissionView)

function ScuffleMissionView:buildUI()
	ScuffleMissionView.super.buildUI(self)

	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._maxPetCount = checknumber(ScuffleConfig.instance:getCommonValueByKey("PET_NUM"))
end

function ScuffleMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SF_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.SF_NotifyGameEndRes, self._onGameEndRes, self)
	ScuffleModel.instance:initFormation()
	self:onEnterInherit()
	self:_hideGameObject()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return ScuffleModel.instance:getFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return ScuffleModel.instance:getAllPets()
	end)

	self._countdown = ScuffleModel.instance:getFormationCountDown()
	self._isCountDown = true
	self.isWaitingEmeny = false

	uGuiUtil.setImageGrayStateRecursive(self._startBtn.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnOneKey.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnClean.gameObject, self.isWaitingEmeny)
	settimer(1, self._onSecond, self)
end

function ScuffleMissionView:onExit()
	ScuffleMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_SetFormRes, self._onSetFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.SF_NotifyGameEndRes, self._onGameEndRes, self)
	removetimer(self._onSecond, self)
end

function ScuffleMissionView:_onSecond()
	if self._isCountDown then
		if self._countdown > 0 then
			self._countdown = self._countdown - 1

			if self._countdown < 2 then
				local formation = ScuffleModel.instance:getFormation()

				if formation and formation:isEmpty() then
					self:_onClickOneKey()
				end
			end
		else
			self:_enterBattle()

			self._isCountDown = false
		end
	end
end

function ScuffleMissionView:procMid()
	self:_setDescStr("精灵大乱斗", nil, "击败对方所有精灵即可获胜")
end

function ScuffleMissionView:_saveFormationEx()
	return
end

function ScuffleMissionView:_onClickStart()
	local formation = ScuffleModel.instance:getFormation()

	if formation and formation:isEmpty() then
		FloatWordMgr.instance:show("请先上阵精灵哦")
	elseif self.isWaitingEmeny == false then
		GlobalDispatcher:dispatch(GlobalNotify.ScuffleClickEnterBattle)
		self:_enterBattle()
	end
end

function ScuffleMissionView:_onClickOneKey()
	if self.isWaitingEmeny == false then
		SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
		FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), nil, function(posList, petPool)
			local needPets = FastFormation.instance.needPets
			local count = self._maxPetCount - table.nums(petPool)
			local tem = {}

			for i, petMo in ipairs(needPets) do
				local isHas = false

				for k, v in pairs(petPool) do
					if v == petMo then
						isHas = true

						break
					end
				end

				if isHas == false then
					table.insert(tem, petMo)

					count = count - 1

					if count <= 0 then
						break
					end
				end
			end

			for i = 1, self._maxPetCount do
				if table.indexof(posList, i) == false then
					table.insert(posList, i)
				end

				if petPool[i] == nil and #tem > 0 then
					petPool[i] = table.remove(tem, 1)
				end
			end

			return posList, petPool
		end)
		MissionModel.instance:setForceResetOneKey(false)
	end
end

function ScuffleMissionView:_onClickClean()
	if self.isWaitingEmeny == false then
		ScuffleMissionView.super._onClickClean(self)
	end
end

function ScuffleMissionView:_enterBattle()
	self._isCountDown = false

	self:_setMaskBlock(true)

	local fmo = ScuffleModel.instance:getFormation()
	local pet_poisition = fmo:GetPositions() or {}
	local isHasPet = false

	for i = 1, 9 do
		local petId = checknumber(pet_poisition[i])

		if petId > 0 then
			isHasPet = true
		end
	end

	local simpleForm = fmo:createFormPb()

	simpleForm.formId = 0

	local buffId = ScuffleModel.instance:getSelectBuffId()

	if isHasPet then
		ScuffleAgent.instance:sendSF_SetFormReq(simpleForm, buffId)
	end
end

function ScuffleMissionView:_onSetFormRes()
	self.isWaitingEmeny = true

	uGuiUtil.setImageGrayStateRecursive(self._startBtn.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnOneKey.gameObject, self.isWaitingEmeny)
	uGuiUtil.setImageGrayStateRecursive(self._btnClean.gameObject, self.isWaitingEmeny)
end

function ScuffleMissionView:_onGameEndRes()
	ScuffleController.instance:onGameEndRes(function()
		UIStateManager.instance:popByName(ViewName.ScuffleBuffView)
		self:_onClickClose()
	end)
end

function ScuffleMissionView:_hideGameObject()
	goutil.setActive(self._Titlebg, false)
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._closeButton.gameObject, false)
end

function ScuffleMissionView:_maxPetNum()
	return self._maxPetCount
end

return ScuffleMissionView
