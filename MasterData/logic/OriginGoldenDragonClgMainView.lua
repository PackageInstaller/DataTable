-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgMainView.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgMainView", package.seeall)

local OriginGoldenDragonClgMainView = class("OriginGoldenDragonClgMainView", ViewComponent)

function OriginGoldenDragonClgMainView:ctor()
	OriginGoldenDragonClgMainView.super.ctor(self)
end

function OriginGoldenDragonClgMainView:unbindEvents()
	OriginGoldenDragonClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
end

function OriginGoldenDragonClgMainView:bindEvents()
	OriginGoldenDragonClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
end

function OriginGoldenDragonClgMainView:buildUI()
	OriginGoldenDragonClgMainView.super.buildUI(self)

	self._txtNamePetInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnIntroduce = self:getGo("petInfo/btnIntroduce")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._con = self:getGo("con")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClg = self:getGo("btnClg")

	local goCellPrize = self:getGo("prize/cell")
	local goTabPrize = self:getGo("prize/tableview")

	self._tableviewPrize = ScrollerList.create(goTabPrize, goCellPrize, GameUtil.handler(self._updateCellPrize, self), GameUtil.handler(self._clearCellPrize, self))
	self._progressBar = self:getSlider("prize/tableview/viewport/content/progressBar")
	self._txtNumScore = self:getTxt("prize/score/txtNum")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function OriginGoldenDragonClgMainView:onExit()
	OriginGoldenDragonClgMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	self._tableviewPrize:dispose()
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OriginGoldenDragonClgMainView:onEnter()
	OriginGoldenDragonClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgGainPrizeRes, self._updatePrizes, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = OriginGoldenDragonClgController.instance:getDefaultActivityId() or 0
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	OriginGoldenDragonClgController.instance:getInfo(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OriginGoldenDragonClgMainView:_updateUIByCfg()
	self._actCfg = OriginGoldenDragonClgConfig.instance:getActCfgByActId(self._activityId) or {}
	self._gotoStrs = self._actCfg.gotoStrs or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._allPrizeCfgs = OriginGoldenDragonClgConfig.instance:getAllPrizeCfgsByActId(self._activityId) or {}

	self:_updatePetInfo()
end

function OriginGoldenDragonClgMainView:_updatePetInfo()
	self._curSkinId = self._actCfg.skinId or 0
	self._curRaceId = 0

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	if petSkinCfg then
		self._curRaceId = petSkinCfg.raceId or 0
		self._txtNamePetInfo.text = petSkinCfg.name or ""

		MaterialMgr.setCell(MatType.Rare, self._curSkinId, self._pointRare)

		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function OriginGoldenDragonClgMainView:_updateUIByInfo()
	self:_updatePrizes()
end

function OriginGoldenDragonClgMainView:_updatePrizes()
	self._totalScore = OriginGoldenDragonClgModel.instance:getTotalScore(self._activityId) or 0
	self._txtNumScore.text = self._totalScore

	local showIndex = -1
	local lastIndex = -1
	local scoreList = {}

	for index, prizeCfg in ipairs(self._allPrizeCfgs) do
		if not prizeCfg.needScore then
			local needScore = 0

			table.insert(scoreList, needScore)

			if not prizeCfg.prizeId then
				local prizeId = 0
				local canGain = needScore <= self._totalScore and not OriginGoldenDragonClgModel.instance:hasGainPrize(self._activityId, prizeId)

				if canGain and showIndex == -1 then
					showIndex = index
				end

				if needScore <= self._totalScore then
					lastIndex = index
				end
			end
		end
	end

	if lastIndex <= 0 then
		lastIndex = 1
	end

	if showIndex < 0 then
		showIndex = lastIndex
	end

	self._tableviewPrize:updateUnderSlider(self._progressBar, self._totalScore, scoreList)
	self._tableviewPrize:MoveCellToBegin(showIndex - 1)
	self._tableviewPrize:reloadData(self._allPrizeCfgs)
end

function OriginGoldenDragonClgMainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.OriginGoldenDragonClgStageView, self._activityId)
end

function OriginGoldenDragonClgMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function OriginGoldenDragonClgMainView:_onClickBtnJump(index)
	if not self._gotoStrs[index] then
		if not GameUtil.isEmptyString(self._gotoStrs[index]) then
			GotoMgr.gotoByString(self._gotoStrs[index])
		end
	end
end

function OriginGoldenDragonClgMainView:_onClickBtnSkill()
	if self._curRaceId ~= 0 then
		if self._curRaceId == self._curSkinId then
			PetbookController.instance:previewBattle(self._curRaceId)
		else
			PetbookController.instance:previewBattle(self._curRaceId, self._curSkinId)
		end
	end
end

function OriginGoldenDragonClgMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self._curRaceId)
end

function OriginGoldenDragonClgMainView:_onClickGainPrize(data)
	if not data.prizeId then
		local prizeId = 0
		local hasGain = OriginGoldenDragonClgModel.instance:hasGainPrize(self._activityId, prizeId)

		if hasGain then
			TipsFacade.instance:openCommonTips(lang("已领取过该奖励了哦~"))
			self:_updatePrizes()

			return
		end

		if not data.needScore then
			local needScore = 0

			if needScore > self._totalScore then
				TipsFacade.instance:openCommonTips(lang("积分不足哦~"))
				self:_updatePrizes()

				return
			end

			OriginGoldenDragonClgController.instance:gainPrize(self._activityId, prizeId)
		end
	end
end

function OriginGoldenDragonClgMainView:_playCellEffect(effGo)
	self:_clearCellEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("prize/tableview/viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScaleXYZ(0.96, 1, 0.87)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function OriginGoldenDragonClgMainView:_clearCellEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function OriginGoldenDragonClgMainView:_updateCellPrize(view, cell, data)
	if not data.prizeId then
		local prizeId = 0
		local hasGain = OriginGoldenDragonClgModel.instance:hasGainPrize(self._activityId, prizeId)

		if not data.needScore then
			local needScore = 0
			local canGain = needScore <= self._totalScore and not hasGain
			local go = cell.gameObject
			local txtNum = goutil.findChildTextComponent(go, "txtNum")

			txtNum.text = needScore

			local btnGet = goutil.findChild(go, "btnGet")
			local goItem = goutil.findChild(go, "item")

			MaterialMgr.setCellByCfg(data.prize, goItem)

			local conEffect = goutil.findChild(go, "effect")

			if canGain then
				GameUtil.addClickHandler(btnGet, GameUtil.handler(self._onClickGainPrize, self, data))
				self:_playCellEffect(conEffect)
				goutil.setActive(btnGet, true)
			else
				GameUtil.rmClickHandler(btnGet)
				self:_clearCellEffect(conEffect)
				goutil.setActive(btnGet, false)
			end

			local geted = goutil.findChild(go, "geted")

			goutil.setActive(geted, hasGain)
		end
	end
end

function OriginGoldenDragonClgMainView:_clearCellPrize(cell)
	local go = cell.gameObject
	local goEffect = goutil.findChild(go, "effect")

	self:_clearCellEffect(goEffect)

	local btnGet = goutil.findChild(go, "btnGet")

	GameUtil.rmClickHandler(btnGet)
end

function OriginGoldenDragonClgMainView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return OriginGoldenDragonClgMainView
