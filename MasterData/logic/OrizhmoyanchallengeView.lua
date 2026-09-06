-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fantian/view/copy/OrizhmoyanchallengeView.lua

module("logic.extensions.fantian.view.copy.OrizhmoyanchallengeView", package.seeall)

local OrizhmoyanchallengeView = class("OrizhmoyanchallengeView", ViewComponent)

function OrizhmoyanchallengeView:ctor()
	OrizhmoyanchallengeView.super.ctor(self)
end

function OrizhmoyanchallengeView:unbindEvents()
	OrizhmoyanchallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnInfo)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnGift)
end

function OrizhmoyanchallengeView:bindEvents()
	OrizhmoyanchallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickLottery, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnGift, self._onClickBtnGift, self)
end

function OrizhmoyanchallengeView:buildUI()
	OrizhmoyanchallengeView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._btnChallenge = self:getGo("btnChallenge")
	self._txtTitle = self:getTxt("txtTitle")
	self._txtTime = self:getTxt("time/txt")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtName = self:getTxt("petInfo/txtName")
	self._btnShop = self:getGo("btnShop")
	self._btnLottery = self:getGo("btnLottery")
	self._btnGift = self:getGo("btnGift")
	self._btnRank = self:getGo("btnRank")
	self._txtTotal = self:getTxt("progressReward/total/txt")
	self._item = self:getGo("progressReward/total/item")
	self._tableviewGo = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = ScrollerList.create(self._tableviewGo, self._rewardCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._redBuff = self:getGo("buffCol/cell/red")
end

function OrizhmoyanchallengeView:onExit()
	OrizhmoyanchallengeView.super.onExit(self)
	self._tableview:dispose()

	self.loader = RoleObjectPool.instance:removeRole(self.loader)

	MaterialMgr.resetAll(self._pointRare)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnGainBuff)
end

function OrizhmoyanchallengeView:onEnter()
	OrizhmoyanchallengeView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 313003
	end

	self:_refreshUI()
	self.addGEvent(self, GlobalNotify.FanTianChallengeUpdate, self._refreshUI, self)
	FanTianChallengeController.instance:sendGetInfo(self._activityId)
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnGainBuff, function(param)
		self:_updateBuffUI(param)
	end)
end

function OrizhmoyanchallengeView:_refreshUI()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._actCfg = FanTianChallengeConfig.instance:getActivityCfgById(self._activityId)

	local skinId = self._actCfg.skinId

	self:_showPetSkin(skinId)

	local info = FanTianChallengeModel.instance:getInfo(self._activityId) or {}
	local dragonSoulProgress = checknumber(info.dragonSoulProgress)

	self._curProgress = dragonSoulProgress
	self._prizeGainedBitIdList = info.prizeGainedBitId or {}

	local curTierId = checknumber(info.curTierId)

	self._txtTotal.text = dragonSoulProgress

	local progressCfgList = FanTianChallengeConfig.instance:getProgressCfgList(self._activityId) or {}
	local scoreArr = {}
	local idx = -1

	for k, v in ipairs(progressCfgList) do
		table.insert(scoreArr, v.progress)

		local isCanGet = self._curProgress >= v.progress
		local isGainPrize = table.indexof(self._prizeGainedBitIdList, v.dataBitId) ~= false

		if isCanGet and not isGainPrize and idx == -1 then
			idx = k - 1
		end
	end

	self._tableview:reloadData(progressCfgList)
	self._tableview:updateUnderSlider(self._progressBar, dragonSoulProgress, scoreArr)
	self._tableview:MoveCellToCenter(idx == -1 and 0 or idx)
end

function OrizhmoyanchallengeView:_showPetSkin(skinId)
	local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			local y = 0

			if not modelCfg[3] then
				local scale = 1

				self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, skinId, self._con, scale, function(go)
					return
				end, true, modelCfg[1], y)
				self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

				MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
			end
		end
	end
end

function OrizhmoyanchallengeView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.OrizhmoyanlevelselectView, self._activityId)
end

function OrizhmoyanchallengeView:_onClickInfo()
	local skinId = self._actCfg.skinId
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	PetbookController.instance:openPetinfoView(petSkinCfg.raceId)
end

function OrizhmoyanchallengeView:_onClickSkill()
	local skinId = self._actCfg.skinId
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

	PetbookController.instance:previewBattle(petSkinCfg.raceId, skinId)
end

function OrizhmoyanchallengeView:_onClickBtnTip()
	TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
end

function OrizhmoyanchallengeView:_onClickShop()
	local str = self._actCfg.shopJump

	GotoMgr.gotoByString(str)
end

function OrizhmoyanchallengeView:_onClickLottery()
	local str = self._actCfg.lotteryJump

	GotoMgr.gotoByString(str)
end

function OrizhmoyanchallengeView:_onClickRank()
	local str = self._actCfg.rankJump

	GotoMgr.gotoByString(str)
end

function OrizhmoyanchallengeView:_onClickBtnGift()
	local str = self._actCfg.giftJump

	GotoMgr.gotoByString(str)
end

function OrizhmoyanchallengeView:_updateCell(view, cell, data)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._curProgress >= data.progress
	local isGainPrize = table.indexof(self._prizeGainedBitIdList, data.dataBitId) ~= false

	GameUtil.SetActive(canGet, isCanGet and not isGainPrize)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data.dataBitId), self)
end

function OrizhmoyanchallengeView:_onClickGetPrize(id)
	FanTianChallengeController.instance:sendGetPrize(self._activityId, id)
end

function OrizhmoyanchallengeView:_clearCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
end

function OrizhmoyanchallengeView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function OrizhmoyanchallengeView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

function OrizhmoyanchallengeView:_updateBuffUI(param)
	GameUtil.SetActive(self._redBuff, param.isCanGain)

	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "点击激活Buff"
	end
end

return OrizhmoyanchallengeView
