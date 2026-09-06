-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/noahchallenge/view/NoahChallengeView.lua

module("logic.extensions.noahchallenge.view.NoahChallengeView", package.seeall)

local NoahChallengeView = class("NoahChallengeView", ViewComponent)

function NoahChallengeView:ctor()
	NoahChallengeView.super.ctor(self)
end

function NoahChallengeView:buildUI()
	NoahChallengeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("main/btnBuy")
	self._btnReset = self:getBtn("main/btnReset")
	self._btnChallenge = self:getBtn("main/btnChallenge")
	self._btnTip = self:getBtn("main/btnTip")
	self._txtBuy = self:getTxt("main/btnBuy/Text")
	self._effectGo = self:getGo("effect")
	self._birthdayTag = self:getGo("birthdayTag")
	self._txtBuff = self:getTxt("birthdayTag/txtBuff")
	self._levelGos = {}

	for i = 1, 4 do
		local levelItem = {}

		levelItem.imgBattle = self:getGo(string.format("main/level%d/imgBattle", i))
		levelItem.select = self:getGo(string.format("main/level%d/select", i))
		levelItem.head = self:getGo(string.format("main/level%d/head", i))
		self._levelGos[i] = levelItem
	end
end

function NoahChallengeView:bindEvents()
	NoahChallengeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function NoahChallengeView:unbindEvents()
	NoahChallengeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function NoahChallengeView:onEnter()
	NoahChallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeInfoRes, self._onNoahChallengeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeResetRes, self._onNoahChallengeResetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)

	local param = self:getOpenParam()

	self._challengeId = param[1]
	self._raceId = param[2]
	self._curChallengeCfg = NoahChallengeConfig.instance:getChallengeCfg(self._challengeId)

	if not self._curChallengeCfg then
		return
	end

	SurveyController.instance:reportBehavior(200489, self._curChallengeCfg.raceId)
	self:_initLevels()
	self:_setTxtBtnBuy()
	self:_loadEffect()
	GameUtil.SetActive(self._birthdayTag, self:_birthdayTagState())
	NoahChallengeAgent.instance:sendPM_NoahChallengeInfoReq(self._challengeId)
end

function NoahChallengeView:onExit()
	NoahChallengeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeInfoRes, self._onNoahChallengeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeResetRes, self._onNoahChallengeResetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.NoahChallengeBuyEndRes, self._onNoahChallengeBuyEndRes, self)
	self:_removeLevels()
	self:_removeEffect()
	goutil.addChildToParent(self._effectGo, self.mainGO)
end

function NoahChallengeView:_onClickClose()
	self:close()
end

function NoahChallengeView:_onClickBuy()
	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	if not isPassed then
		local cfgPay = NoahChallengeConfig.instance:getChallengePay(self._curChallengeCfg.payPlanId)

		if self._curChallengeCfg and cfgPay then
			PayController.instance:pay(cfgPay.payGoodsId, GameEnum.PaySubGoodsType.NOAHCHALLENGE, self._curChallengeCfg.challengeId)
		end
	else
		FloatWordMgr.instance:show(lang("noahchallenge_tip1"))
	end
end

function NoahChallengeView:_onClickReset()
	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	if not isPassed then
		if NoahChallengeModel.instance:isNoStage(self._challengeId) then
			FloatWordMgr.instance:show(lang("您还没有通过任何关卡哦"))
		else
			local text = lang("noahchallenge_tip2")

			local function okFunc()
				NoahChallengeAgent.instance:sendPM_NoahChallengeResetReq(self._challengeId)
			end

			TipsFacade.instance:openPopupWindow(lang("tip"), text, okFunc, nil, lang("confirm"), lang("cancel"))
		end
	else
		FloatWordMgr.instance:show(lang("noahchallenge_tip1"))
	end
end

function NoahChallengeView:_onClickChallenge()
	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	if not isPassed then
		local curStage = NoahChallengeModel.instance:getCurStage(self._challengeId)

		curStage = curStage + 1

		ViewAutoShowController.instance:saveCurModalView()
		UIStateManager.instance:push(ViewName.NoahMissionView, self._challengeId, curStage, self._raceId)
	else
		FloatWordMgr.instance:show(lang("noahchallenge_tip1"))
	end
end

function NoahChallengeView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "noahchallenge")
end

function NoahChallengeView:_onNoahChallengeInfoRes()
	self:_refreshView()
end

function NoahChallengeView:_onNoahChallengeResetRes()
	FloatWordMgr.instance:show("重置成功！")
	self:_refreshView()
end

function NoahChallengeView:_onNoahChallengeBuyEndRes()
	self:_refreshView()
end

function NoahChallengeView:_refreshView()
	self:_refreshLevels()
	self:_refreshBtns()
end

function NoahChallengeView:_initLevels()
	if not self._curChallengeCfg then
		return
	end

	local list = NoahChallengeConfig.instance:getChallengeStageList(self._curChallengeCfg.challengePlanId)

	for i, v in ipairs(self._levelGos) do
		if list[i] then
			MaterialMgr.setIcon(v.head, MatType.Pet, list[i].raceId)
		end
	end
end

function NoahChallengeView:_removeLevels()
	for i, v in ipairs(self._levelGos) do
		MaterialMgr.clearIcon(v.head)
	end
end

function NoahChallengeView:_refreshLevels()
	local passedStage = NoahChallengeModel.instance:getCurStage(self._challengeId)
	local curStage = passedStage + 1

	for i, v in ipairs(self._levelGos) do
		v.select:SetActive(curStage == i)
		v.imgBattle:SetActive(curStage == i)

		if curStage == i then
			goutil.addChildToParent(self._effectGo, v.select)
			Framework.TransformUtil.SetLocalPos(self._effectGo.transform, 0, 0, 0)
		end
	end
end

function NoahChallengeView:_refreshBtns()
	local isPassed = NoahChallengeModel.instance:isPassed(self._challengeId)

	GameUtil.SetGray(self._btnReset, isPassed)
	GameUtil.SetGray(self._btnChallenge, isPassed)
	GameUtil.SetGray(self._btnBuy, isPassed)
end

function NoahChallengeView:_setTxtBtnBuy()
	if not self._curChallengeCfg then
		return
	end

	local cfgPay = NoahChallengeConfig.instance:getChallengePay(self._curChallengeCfg.payPlanId)
	local arr = string.split(cfgPay.payGoodsId, "_")

	self._txtBuy.text = string.format("%s元一键通关", arr[2])
end

function NoahChallengeView:_loadEffect()
	local effectPath = "fx_ui_2021930/fx_ui_shenqi/fx_ui_xuanzhong_shenqitiaozhan.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, self._effectGo.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._uiEffect = uiEffect
end

function NoahChallengeView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function NoahChallengeView:_birthdayTagState()
	local buffCfg = BattleConfig.instance:getBuffCo(self._curChallengeCfg.buff)

	if string.nilorempty(buffCfg.buffDesc) then
		return false
	else
		self._txtBuff.text = buffCfg.buffDesc

		local arr = string.split(self._curChallengeCfg.buffTime, "|")
		local str = string.split(arr[2], ",")
		local startTime, endTime = str[1], str[2]

		return GameUtil.checkIsInTimePeriod(startTime, endTime)
	end
end

return NoahChallengeView
