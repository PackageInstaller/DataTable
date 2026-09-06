-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/view/treasure/LegendPetTipView.lua

module("logic.extensions.legend.view.treasure.LegendPetTipView", package.seeall)

local LegendPetTipView = class("LegendPetTipView", ViewComponent)

function LegendPetTipView:buildUI()
	LegendPetTipView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")

	local parentGo = self:getGo("main")

	self._imgBgChange = goutil.findChild(parentGo, "imgBg"):GetComponent("UIImageSpriteChange")
	self._imgBg2Change = goutil.findChild(parentGo, "imgBg2"):GetComponent("UIImageSpriteChange")
	self._imgIcon = goutil.findChild(parentGo, "imgIcon/con")
	self._txtName = goutil.findChildTextComponent(parentGo, "petInfo/txtName")
	self._rarePoint = goutil.findChild(parentGo, "petInfo/rarePoint")
	self._btnLock = Framework.ButtonAdapter.GetFrom(parentGo, "btnLock")
	self._txtLock = goutil.findChildTextComponent(parentGo, "btnLock/txtLock")
	self._sweepBg = goutil.findChild(parentGo, "countbg")
	self._sweepTxt = goutil.findChild(parentGo, "countbg/sweepTxt")
	self._txtSweepCount = goutil.findChildTextComponent(parentGo, "countbg/txtSweepCount")
	self._btnSweep = Framework.ButtonAdapter.GetFrom(parentGo, "btnSweep")
	self._btnChallenge = Framework.ButtonAdapter.GetFrom(parentGo, "btnChallenge")
	self._btnFindGame = Framework.ButtonAdapter.GetFrom(parentGo, "btnFindGame")
	self._btnJumpGame = Framework.ButtonAdapter.GetFrom(parentGo, "btnJumpGame")
	self._zdlGo = goutil.findChild(parentGo, "zdl")
	self._imgRecZdl = goutil.findChild(parentGo, "zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
	self._btnSkill = Framework.ButtonAdapter.GetFrom(parentGo, "petInfo/btnSkill")
	self._btnIntroduce = Framework.ButtonAdapter.GetFrom(parentGo, "petInfo/btnIntroduce")
	self._roleGo = goutil.findChild(parentGo, "role")
	self._btnVip = Framework.ButtonAdapter.GetFrom(parentGo, "countbg/vip2Tip/btnTip")
	self._btnRankReward = Framework.ButtonAdapter.GetFrom(parentGo, "btnRankReward")
end

function LegendPetTipView:bindEvents()
	LegendPetTipView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnLock:AddClickListener(self._onClickBtnLock, self)
	self._btnSweep:AddClickListener(self._onClickBtnSweep, self)
	self._btnChallenge:AddClickListener(self._onClickBtnChallenge, self)
	self._btnJumpGame:AddClickListener(self._openXiongmaoView, self)
	self._btnFindGame:AddClickListener(self._openQiannaowanView, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
	self._btnIntroduce:AddClickListener(self._onClickIntroduce, self)
	self._btnVip:AddClickListener(self._onClickVip, self)
	self._btnRankReward:AddClickListener(self._onClickReward, self)
end

function LegendPetTipView:unbindEvents()
	LegendPetTipView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnLock:RemoveClickListener()
	self._btnSweep:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
	self._btnJumpGame:RemoveClickListener()
	self._btnFindGame:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnIntroduce:RemoveClickListener()
	self._btnVip:RemoveClickListener()
	self._btnRankReward:RemoveClickListener()
end

function LegendPetTipView:onEnter()
	LegendPetTipView.super.onEnter(self)
	GlobalDispatcher:addListener(MopupModel.SweepSuccessed, self._setSweepCount, self)
	GlobalDispatcher:addListener(GlobalNotify.ChallengeDataUpdate, self._onSmallGameUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.LegendChallengeTimesInfoRes, self._updateChallengeTimes, self)

	self._cfg = self:getFirstParam()

	self:_initSmallGame()
	self:_setObjActive()
	self:_setText()
	self:_setRare()
	self:_setIcon()
	self:_loadRole()
end

function LegendPetTipView:onExit()
	LegendPetTipView.super.onExit(self)
	GlobalDispatcher:removeListener(MopupModel.SweepSuccessed, self._setSweepCount, self)
	GlobalDispatcher:removeListener(GlobalNotify.ChallengeDataUpdate, self._onSmallGameUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.LegendChallengeTimesInfoRes, self._updateChallengeTimes, self)
	MaterialMgr.resetAll(self._rarePoint)

	local img = Framework.ImageBigBG.Get(self._imgIcon)

	if img then
		img:ClearImage()
	end

	self:_removeRole()
end

function LegendPetTipView:_onClickClose()
	self:close()
end

function LegendPetTipView:_onClickBtnLock()
	FloatWordMgr.instance:show(self:_getLockDesc())
end

function LegendPetTipView:_onClickBtnSweep()
	LegendController.instance:openSweepByChallengeId(self._cfg.challengeId)
end

function LegendPetTipView:_onClickBtnChallenge()
	local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(self._cfg.challengeId)

	if challengeCfg then
		GotoMgr.gotoByString(challengeCfg.jumpTo)
	end
end

function LegendPetTipView:_onClickSkill()
	PetbookController.instance:previewBattle(self._cfg.raceId)
end

function LegendPetTipView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._cfg.raceId)
end

function LegendPetTipView:_onClickVip()
	UIStateManager.instance:push(ViewName.VipView, 2)
	self:_onClickClose()
end

function LegendPetTipView:_onClickReward()
	UIStateManager.instance:push(ViewName.LegendprizeView, self._cfg.challengeId)
end

function LegendPetTipView:_getSweepCountTxt()
	local curCount = LegendModel.instance:getLeftCountByChallengeId(self._cfg.challengeId)
	local maxCount = VipModel.instance:getFreeChallengeTimesOfPet()

	return string.format("%d/%d", checknumber(curCount), maxCount)
end

function LegendPetTipView:_setSweepCount()
	self._txtSweepCount.text = self:_getSweepCountTxt()
end

function LegendPetTipView:_getLockDesc()
	local funcOpenCfg = FuncOpenConfig.instance:getFunctionOpenById(self._cfg.unlockId)

	return (funcOpenCfg or nil) and (funcOpenCfg.description or "")
end

function LegendPetTipView:_setObjActive()
	local isUnlock = LegendController.instance:isChallengeUnlock(self._cfg.unlockId)
	local isPass = LegendModel.instance:isChallengePass(self._cfg.challengeId)
	local isXiongMao = self._cfg.flag == LegendModel.XiongMaoGame
	local isQianNiaoWan = self._cfg.flag == LegendModel.QianNiaoWanGame

	if isXiongMao then
		goutil.setActive(self._btnFindGame.gameObject, false)

		if ChallengeModel.instance:isXiongMaoGamePass() then
			goutil.setActive(self._btnJumpGame.gameObject, false)
			goutil.setActive(self._btnChallenge.gameObject, isUnlock and not isPass)
		else
			goutil.setActive(self._btnJumpGame.gameObject, isUnlock)
			goutil.setActive(self._btnChallenge.gameObject, false)
		end
	elseif isQianNiaoWan then
		goutil.setActive(self._btnJumpGame.gameObject, false)

		if ChallengeModel.instance:isQianNiaoWanGamePass() then
			goutil.setActive(self._btnFindGame.gameObject, false)
			goutil.setActive(self._btnChallenge.gameObject, isUnlock and not isPass)
		else
			goutil.setActive(self._btnFindGame.gameObject, true)
			goutil.setActive(self._btnChallenge.gameObject, false)
		end
	else
		goutil.setActive(self._btnFindGame.gameObject, false)
		goutil.setActive(self._btnJumpGame.gameObject, false)
		goutil.setActive(self._btnChallenge.gameObject, isUnlock and not isPass)
	end

	goutil.setActive(self._btnLock.gameObject, not isUnlock)
	goutil.setActive(self._btnSweep.gameObject, isUnlock and isPass)
	goutil.setActive(self._sweepBg, isUnlock and isPass)
	goutil.setActive(self._zdlGo, self._btnChallenge.gameObject.activeSelf)
end

function LegendPetTipView:_setText()
	self._txtName.text = self._cfg.challengeName
	self._txtLock.text = self:_getLockDesc()

	self._imgRecZdl:SetText(tostring(self:_getZdlNum()))
	self:_setSweepCount()
end

function LegendPetTipView:_getZdlNum()
	local cfgStages = LegendConfig.instance:getLegendChallengeStageCfgList(self._cfg.challengeId)

	for i, v in ipairs(cfgStages) do
		if not LegendModel.instance:isStagePass(v.challengeId, v.stageId) then
			local cfgTeam = LegendConfig.instance:getLegendChallengeTeamCfg(v.teamId)

			return (cfgTeam or nil) and (cfgTeam.recommendZdl or 0)
		end
	end

	return 0
end

function LegendPetTipView:_setRare()
	local rareNum = CharacterConfig.instance:getInitRare(self._cfg.raceId)

	self._imgBgChange:SetState(rareNum - 1)
	self._imgBg2Change:SetState(rareNum - 1)
	MaterialMgr.resetAll(self._rarePoint)
	MaterialMgr.setCell(MatType.Rare, self._cfg.raceId, self._rarePoint)
end

function LegendPetTipView:_setIcon()
	local cfgModel = CharacterConfig.instance:getModelCo(self._cfg.raceId)

	if cfgModel then
		uGuiUtil.setSpriteToImage(self._imgIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/pet/%s.png", cfgModel.cardName))
	end
end

function LegendPetTipView:_openXiongmaoView()
	LegendController.instance:openXiongmaoView()
end

function LegendPetTipView:_openQiannaowanView()
	LegendController.instance:openQiannaowanView()
end

function LegendPetTipView:_onSmallGameUpdate()
	self:_setObjActive()
end

function LegendPetTipView:_updateChallengeTimes()
	self:_setSweepCount()
end

function LegendPetTipView:_isSmallGame()
	if self._cfg then
		if self._cfg.flag == LegendModel.XiongMaoGame then
			return true
		elseif self._cfg.flag == LegendModel.QianNiaoWanGame then
			return true
		end
	end

	return false
end

function LegendPetTipView:_initSmallGame()
	if self._cfg then
		if self._cfg.flag == LegendModel.XiongMaoGame then
			ChallengeFacade.instance:startChallange(LegendModel.OldXiongMaoId, nil, true)
		elseif self._cfg.flag == LegendModel.QianNiaoWanGame then
			ChallengeFacade.instance:startChallange(LegendModel.OldQianNiaoWanId, nil, true)
		end
	end
end

function LegendPetTipView:_loadRole()
	local faceId = self._cfg.raceId

	if not faceId or faceId == 0 then
		return
	end

	local offset = CharactorFacade.instance:getPetChallengeUIPosAndScale(faceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, faceId, self._roleGo, scale, nil, true, x, y)
end

function LegendPetTipView:_removeRole()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return LegendPetTipView
