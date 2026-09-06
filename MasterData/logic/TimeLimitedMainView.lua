-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimeLimitedMainView.lua

module("logic.extensions.timelimitedchallenge.view.TimeLimitedMainView", package.seeall)

local TimeLimitedMainView = class("TimeLimitedMainView", ViewComponent)

function TimeLimitedMainView:unbindEvents()
	TimeLimitedMainView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnRank:RemoveClickListener()

	if self._btnExchange then
		self._btnExchange:RemoveClickListener()
	end

	GameUtil.rmClickHandler(self._btnStart)
	self._btnTry:RemoveClickListener()
	self._tipRank:RemoveClickListener()
	self._tipTry:RemoveClickListener()
	self._btnRule:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	GameUtil.rmClickHandler(self.btnHelp)
	GameUtil.rmClickHandler(self._btnBuffTip)
	GameUtil.rmClickHandler(self._btnVip)
end

function TimeLimitedMainView:bindEvents()
	TimeLimitedMainView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._tipRank:AddClickListener(self._onClickRank, self)
	self._tipTry:AddClickListener(self._onClickTry, self)

	if self._btnExchange then
		self._btnExchange:AddClickListener(self._onClickExchange, self)
	end

	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	self._btnTry:AddClickListener(self._onClickTry, self)
	self._btnRule:AddClickListener(self._onClickRule, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	GameUtil.addClickHandler(self.btnHelp, self.onHelpClick, self)
	GameUtil.addClickHandler(self._btnBuffTip, self._onClickBuffTips, self)
	GameUtil.addClickHandler(self._btnVip, self._onClickVip, self)
end

function TimeLimitedMainView:buildUI()
	self._leftTimeFmt = "距离活动结束：%s"

	TimeLimitedMainView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
	self._txtLeftChallengeCount = goutil.findChildTextComponent(self.mainGO, "txtLeftCount")
	self._btnStart = self:getGo("btnStart")

	if not goutil.isNil(self._btnStart) then
		self._txtStart = goutil.findChildTextComponent(self._btnStart.gameObject, "txt")
		self._txtStart = goutil.findChildTextComponent(self._btnStart.gameObject, "txt")
		self._redPoint = goutil.findChild(self._btnStart.gameObject, "dot")
	end

	self._con = self:getGo("con")

	self:_buildInfoUI()

	self._rules = self:getGo("rules")
	self._btnRule = self:getBtn("topleft/btnRule")
	self.btnHelp = self:getGo("btnHelp")
	self._btnRank = self:getBtn("btnRank")
	self._tipRank = self:getBtn("tipRank")
	self._pointRankItem = self:getGo("tipRank/pointItem")
	self._txtTipRank = goutil.findChildTextComponent(self._tipRank, "txtTip")
	self._btnTry = self:getBtn("btnTry")
	self._pointTryItem = self:getGo("tipTry/pointItem")
	self._tipTry = self:getBtn("tipTry")
	self._btnExchange = self:getBtn("btnExchange")
	self._pointExchangeItem = self:getGo("tipExchange/pointItem")
	self._tipExchange = self:getGo("tipExchange")

	if not goutil.isNil(self._tipExchange) then
		self._txtTipExchange = goutil.findChildTextComponent(self._tipExchange, "txtTip")
	end

	local buffCell = self:getGo("buff/buffCell")

	if not goutil.isNil(buffCell) then
		self._buffCell = PanduolaBuffCell.New(buffCell)
	end

	self._txtNull = self:getGo("buff/txtBuffEmpty")
	self._btnBuffTip = self:getGo("buff/btnTip")
	self._btnVip = self:getGo("btnVip")
	self._txtVip = self:getTxt("txtVip")
	self._vipAddTimes = 0
end

function TimeLimitedMainView:_buildInfoUI()
	self._info = self:getGo("info")
	self._pointRare = goutil.findChild(self._info, "pointRare")
	self._txtName = goutil.findChildTextComponent(self._info, "txtName")
	self._btnIntroduce = Framework.ButtonAdapter.GetFrom(self._info, "btnIntroduce")
	self._btnSkill = Framework.ButtonAdapter.GetFrom(self._info, "btnSkill")
end

function TimeLimitedMainView:onExit()
	TimeLimitedMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
	end

	removetimer(self._onTick, self)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = nil

	MaterialMgr.resetAll(self._pointTryItem)
	MaterialMgr.resetAll(self._pointExchangeItem)
	RedPointController.instance:unregRedPoint(self._redPoint)
	GlobalDispatcher:removeListener(GlobalNotify.CircleChallengeReset, self._updateCircleUI, self)
	TimedChallengeMiYaAgent.instance:removeHandler(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightInfoRes, self.agentHandler)
end

function TimeLimitedMainView:onEnter()
	TimeLimitedMainView.super.onEnter(self)

	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	self:_updateInfo(self._challengeCfg.raceId)
	self:_updateRules(self._challengeCfg.desc)

	self._txtLeftTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)

	self:_setEffectUrls()
	self:_createEffs()

	if TimeLimitedConfig.instance:isCircleChallenge(self._challengeId) then
		self.agentHandler = TimedChallengeMiYaAgent.instance:addHandler(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightInfoRes, self._onCircleFightInfoRes, self)

		TimedChallengeCircleFightAgent.instance:sendPM_TimedChallengeCircleFightInfoReq(self._challengeId)
		GlobalDispatcher:addListener(GlobalNotify.CircleChallengeReset, self._updateCircleUI, self)
	end

	RedPointController.instance:regRedPoint(self._redPoint, self._challengeCfg.redPointId)
end

function TimeLimitedMainView:_onCircleFightInfoRes(msg)
	TLChallengeModel.instance:setFightInfo(self._challengeId, msg)
	self:_updateCircleUI()
end

function TimeLimitedMainView:_updateCircleUI()
	print("update CircleUI")

	self._info = TLChallengeModel.instance:getFightInfo(self._challengeId)

	local curRound = self._info.curRound
	local challengedCount = self._info.hasChallengeCircle
	local cfg = TimeLimitedConfig.instance:getCircleFightCfg(self._challengeId)

	self._circleCfg = cfg
	self._leftChallengeCount = cfg.dailyTimes - challengedCount
	self._isEmpty = self._leftChallengeCount == 0
	self._txtStart.text = self._isEmpty and "明日\n再来" or curRound > 0 and "继续\n挑战" or "进入\n挑战"

	if curRound > 0 then
		self._leftChallengeCount = self._leftChallengeCount - 1
	end

	self._leftChallengeCount = math.max(0, self._leftChallengeCount)
	self._txtLeftChallengeCount.text = string.format("今天剩余次数：  <color=#4FEA91FF>%s</color>/%s", self._leftChallengeCount, cfg.dailyTimes)

	self:_activeTipExchange(not self._info.hasGainPet)

	local petRankThreshold = checknumber(cfg.petRankThreshold)

	self._txtTipRank.text = string.format("前%s名\n可获得", petRankThreshold)

	MaterialMgr.setCellByCfg(cfg.petRankPrize, self._pointRankItem)

	local hasInBag = true
	local list = string.split(cfg.petRankPrize, "#")

	for i, v in ipairs(list) do
		local type, id, num = MaterialMgr.getMatParams(v)

		if type == MatType.HeadFrame or type == MatType.HeadIcon then
			local myCount = MaterialMgr.getMatCount(v)

			if myCount >= 1 then
				-- block empty
			else
				hasInBag = false

				break
			end
		else
			hasInBag = false

			break
		end
	end

	self:_activeTipRank(petRankThreshold > self._info.petRankSize and not hasInBag)
end

function TimeLimitedMainView:_onTick()
	if self._challengeId == nil or not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		if self._txtLeftTime then
			self._txtLeftTime.text = ""
		end

		local text = "活动已经结束"

		TipsFacade.instance:openTipWindowNoX("提示", text, function()
			UIStateManager.instance:popByName(self._viewPresentor.viewName)
		end)
		removetimer(self._onTick, self)
	else
		local leftTimeFormat = TLChallengeController.instance:getLeftTimeFormat(self._challengeId)

		if self._txtLeftTime then
			self._txtLeftTime.text = string.format(self._leftTimeFmt, leftTimeFormat)
		end
	end
end

function TimeLimitedMainView:_updateInfo(raceId)
	self.skinId = raceId

	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	self._petName = petCfg.name

	local names = string.split(petCfg.name, "·")

	self._shortName = names[#names]

	MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)

	if self._txtName then
		self._txtName.text = petCfg.name
	end

	if not self._skinId then
		local skinId = raceId
		local displayBagOffset = CharactorFacade.instance:getPetBagModelUIPosAndScale(skinId)
		local x, y, scale = 0, 0, 1

		if displayBagOffset then
			x = checknumber(displayBagOffset[1])
			y = checknumber(displayBagOffset[2])
			scale = displayBagOffset[3] or 1
		end

		if not self._donotLoadRole then
			self._role = RoleObjectPool.instance:removeRole(self._role)
			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, scale, nil, true, x, y)
		end

		if self._pointExchangeItem then
			MaterialMgr.setCell(MatType.Pet, raceId, self._pointExchangeItem)
		end

		local names = string.split(petCfg.name, "·")

		if self._txtTipExchange then
			self._txtTipExchange.text = string.format("可兑换%s", self._shortName)
		end

		local collegeId = PetCollegeConfig.instance:raceId2ChallengeId(checknumber(self.skinId))

		if checknumber(collegeId) > 0 then
			local stageCfgs = PetCollegeConfig.instance:getStageCfg(collegeId)
			local passedStageId = PetCollegeModel.instance:getCurrPassStageId(collegeId)
			local prizeDic = {}

			for k, v in ipairs(stageCfgs) do
				if passedStageId < k then
					local matType, matId, matNum = unpack(string.splitToNumber(v.firstPassPrize, ":"))
					local key = matType .. ":" .. matId

					prizeDic[key] = checknumber(prizeDic[key]) + matNum
				end
			end

			local matStr = ""

			for k, v in pairs(prizeDic) do
				matStr = k .. ":" .. v
			end

			MaterialMgr.setCellByCfg(matStr, self._pointTryItem)
			self:_activeTipTry(not string.nilorempty(matStr))
		end
	end
end

function TimeLimitedMainView:_onClickClose()
	self:close()
end

function TimeLimitedMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.TLChallengerankView, self._challengeCfg.rankType)
end

function TimeLimitedMainView:_onClickExchange()
	UIStateManager.instance:push(ViewName.TLCExchangeView, self._challengeId)
end

function TimeLimitedMainView:_onClickTry()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			FuncOpenController.instance:openFunc(149, raceId)
		end
	end
end

function TimeLimitedMainView:_onClickIntroduce()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:openPetinfoView(raceId)
		end
	end
end

function TimeLimitedMainView:_onClickSkill()
	local skinId = self.skinId

	if skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self.skinId)
		end
	end
end

function TimeLimitedMainView:_onClickStart()
	FloatWordMgr.instance:show("点击开始")
end

function TimeLimitedMainView:onHelpClick()
	UIStateManager.instance:push(ViewName.TimelinitedcheatsView, self._challengeId)
end

function TimeLimitedMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._challengeCfg.ruleKey)
end

function TimeLimitedMainView:_onClickBuffTips()
	return
end

function TimeLimitedMainView:_updateRules(text)
	if not goutil.isNil(self._rules) then
		GameUtil.updateCellsWithCreate(self._rules, string.split(text, "\n"), function(cell, data)
			cell:GetComponent(goutil.Type_UIText).text = data
		end)
	end
end

function TimeLimitedMainView:_onClickGainBuff()
	return
end

function TimeLimitedMainView:_onClickRegainBuff()
	return
end

function TimeLimitedMainView:_updateBuffUI()
	return
end

function TimeLimitedMainView:_onClickVip()
	local vipLv = 1
	local text = langPara("timed_challenge_vip_tip", vipLv, self._shortName, self._vipAddTimes)
	local okText = ""
	local okHandler

	if vipLv > VipModel.instance:getCurVipLv() then
		text = text .. "\n当前还不是特权用户"

		function okHandler()
			UIStateManager.instance:push(ViewName.VipView)
		end

		okText = "去激活"
	else
		text = text .. "\n正在享用特权"
		okText = "确定"
	end

	TLChallengeController.instance:openTLCTip(nil, text, okText, okHandler, nil, self._challengeId)
end

function TimeLimitedMainView:_createEffs()
	self._effs = {}

	for _, v in ipairs(self._effPaths) do
		local parent = self.mainGO

		if not string.nilorempty(v.goPath) then
			parent = self:getGo(v.goPath)
		end

		local eff = UIEffectManager.instance:playEffect(self, v.path, parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)
		eff:setLocalEulerAngle(0, 0, 0)
		table.insert(self._effs, eff)
	end
end

function TimeLimitedMainView:_setEffectUrls()
	self._effPaths = {}
end

function TimeLimitedMainView:_activeTipTry(isActive)
	goutil.setActive(self._tipTry.gameObject, isActive)
end

function TimeLimitedMainView:_activeTipRank(isActive)
	goutil.setActive(self._tipRank.gameObject, isActive)
end

function TimeLimitedMainView:_activeTipExchange(isActive)
	GameUtil.SetActive(self._tipExchange, isActive)
end

return TimeLimitedMainView
