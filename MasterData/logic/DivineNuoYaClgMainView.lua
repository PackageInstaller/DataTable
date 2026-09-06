-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaClgMainView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaClgMainView", package.seeall)

local DivineNuoYaClgMainView = class("DivineNuoYaClgMainView", ViewComponent)

function DivineNuoYaClgMainView:buildUI()
	DivineNuoYaClgMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnEvolve = self:getBtn("btnEvolve")
	self._btnRank = self:getBtn("btnRank")
	self._btnMonth = self:getBtn("btnMonth")
	self._btnGift = self:getBtn("btnGift")
	self._btnGift2 = self:getBtn("btnGift2")
	self._btnChallenge1 = self:getBtn("btnChallenge1")
	self._btnChallenge2 = self:getBtn("btnChallenge2")
	self._con = self:getGo("con")
	self._txtTime = self:getTxt("time/txt")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/pointRare")
	self._txtName = self:getTxt("petInfo/txtName")
	self._commonPass = self:getGo("btnChallenge1/pass")
	self._extremePass = self:getGo("btnChallenge2/pass")
	self._commonNode = self:getGo("prize1/node")
	self._commonCanGet = self:getGo("prize1/canGet")
	self._commonGeted = self:getGo("prize1/geted")
	self._extremeNode = self:getGo("prize2/node")
	self._extremeCanGet = self:getGo("prize2/canGet")
	self._extremeGeted = self:getGo("prize2/geted")
	self._mainRect = self.mainGO:GetComponent(goutil.Type_RectTransform)
end

function DivineNuoYaClgMainView:bindEvents()
	DivineNuoYaClgMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnEvolve:AddClickListener(self._onClickEvolve, self)
	self._btnRank:AddClickListener(self._onClickRank, self)
	self._btnMonth:AddClickListener(self._onClickMonth, self)
	self._btnGift:AddClickListener(self._onClickGift, self)
	self._btnGift2:AddClickListener(self._onClickGift2, self)
	self._btnChallenge1:AddClickListener(self._onClickChallenge1, self)
	self._btnChallenge2:AddClickListener(self._onClickChallenge2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function DivineNuoYaClgMainView:unbindEvents()
	DivineNuoYaClgMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnEvolve:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnMonth:RemoveClickListener()
	self._btnGift:RemoveClickListener()
	self._btnGift2:RemoveClickListener()
	self._btnChallenge1:RemoveClickListener()
	self._btnChallenge2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function DivineNuoYaClgMainView:onEnter()
	DivineNuoYaClgMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaClgGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaClgGainNormalPrizeRes, self._onGainNormalPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DivineNuoYaClgGainExtremePrizeRes, self._onGainExtremePrizeRes, self)

	self._activityId = DivineNuoYaChallengeModel.instance:getActivityId()
	self._activityType = DivineNuoYaChallengeModel.instance:getActivityType()

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("outtime"), function()
			self:close()
		end)

		return
	end

	self._cfgActivity = DivineNuoYaChallengeConfig.instance:getActivityCfg(self._activityId)
	self._challengeId = self._cfgActivity.challengeId

	local cfgChallenge = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if cfgChallenge then
		self._raceId = cfgChallenge.raceId or 0
	end

	self:_initActivityTime()
	self:_initPetInfo()
	self:_showRoleModel()
	self:_initPrizes()
	self:_refreshView()
	DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaClgGetInfoReq(self._activityId)
end

function DivineNuoYaClgMainView:onExit()
	DivineNuoYaClgMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineNuoYaClgGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineNuoYaClgGainNormalPrizeRes, self._onGainNormalPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DivineNuoYaClgGainExtremePrizeRes, self._onGainExtremePrizeRes, self)
	self:_resetRoleModel()
	self:_clearPetInfo()
	self:_clearEffect()
	self:_clearPrizes()
end

function DivineNuoYaClgMainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "divinenuoyaclgmainview_rule")
end

function DivineNuoYaClgMainView:_onClickEvolve()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo1)
end

function DivineNuoYaClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo2)
end

function DivineNuoYaClgMainView:_onClickMonth()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo3)
end

function DivineNuoYaClgMainView:_onClickGift()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo4)
end

function DivineNuoYaClgMainView:_onClickGift2()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo5)
end

function DivineNuoYaClgMainView:_onClickChallenge1()
	local isPassNormal = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)

	if isPassNormal then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineNuoYaEntireView, self._activityId)
end

function DivineNuoYaClgMainView:_onClickChallenge2()
	local isPassExtreme = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	if isPassExtreme then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineNuoYaExtremeView, self._activityId)
end

function DivineNuoYaClgMainView:_onClickInfo()
	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function DivineNuoYaClgMainView:_onClickSkill()
	if self._raceId then
		PetbookController.instance:previewBattle(self._raceId)
	end
end

function DivineNuoYaClgMainView:_onGetInfoRes()
	self:_refreshView()
end

function DivineNuoYaClgMainView:_onGainNormalPrizeRes()
	self:_refreshView()
end

function DivineNuoYaClgMainView:_onGainExtremePrizeRes()
	self:_refreshView()
end

function DivineNuoYaClgMainView:_refreshView()
	self:_updatePrize1()
	self:_updatePrize2()
	self:_updateChallengeBtns()
end

function DivineNuoYaClgMainView:_initActivityTime()
	self._txtTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
end

function DivineNuoYaClgMainView:_showRoleModel()
	local curFaceId = self._raceId
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(curFaceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, curFaceId, self._con, scale, nil, true, x, y)
end

function DivineNuoYaClgMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineNuoYaClgMainView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._raceId, self._rare)
end

function DivineNuoYaClgMainView:_clearPetInfo()
	MaterialMgr.resetAll(self._rare)
end

function DivineNuoYaClgMainView:_initPrizes()
	local proxy1 = MaterialMgr.setCellByCfg(self._cfgActivity.normalClgPrize, self._commonNode)
	local proxy2 = MaterialMgr.setCellByCfg(self._cfgActivity.extremeClgPrize, self._extremeNode)
	local matType, id = MaterialMgr.getMatParams(self._cfgActivity.normalClgPrize)

	proxy1.binder:setAutoTips(false)
	proxy1:setCallBack(function()
		local isGeted = DivineNuoYaChallengeModel.instance:isGainNormalClgPrize()
		local isPass = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)

		if isPass and not isGeted then
			DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaClgGainNormalPrizeReq(self._activityId)
		elseif not goutil.isNil(self._commonNode) then
			CommonTipsMgr.instance:openMaterialTips(self._commonNode, matType, id, 0)
		end
	end)

	local matType2, id2 = MaterialMgr.getMatParams(self._cfgActivity.extremeClgPrize)

	proxy2.binder:setAutoTips(false)
	proxy2:setCallBack(function()
		local isGeted = DivineNuoYaChallengeModel.instance:isGainExtremeClgPrize()
		local isPass = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

		if isPass and not isGeted then
			DivineNuoYaChallengeAgent.instance:sendPM_DivineNuoYaClgGainExtremePrizeReq(self._activityId)
		elseif not goutil.isNil(self._extremeNode) then
			CommonTipsMgr.instance:openMaterialTips(self._extremeNode, matType2, id2, 0)
		end
	end)
	self:_loadEffect(self._commonCanGet, 1)
	self:_loadEffect(self._extremeCanGet, 2)
	self:_updatePrize1()
	self:_updatePrize2()
end

function DivineNuoYaClgMainView:_clearPrizes()
	MaterialMgr.resetAll(self._commonNode)
	MaterialMgr.resetAll(self._extremeNode)
end

function DivineNuoYaClgMainView:_updatePrize1()
	local isGeted = DivineNuoYaChallengeModel.instance:isGainNormalClgPrize()
	local isPass = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)

	goutil.setActive(self._commonCanGet, isPass and not isGeted)
	goutil.setActive(self._commonGeted, isGeted)
end

function DivineNuoYaClgMainView:_updatePrize2()
	local isGeted = DivineNuoYaChallengeModel.instance:isGainExtremeClgPrize()
	local isPass = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	goutil.setActive(self._extremeCanGet, isPass and not isGeted)
	goutil.setActive(self._extremeGeted, isGeted)
end

function DivineNuoYaClgMainView:_updateChallengeBtns()
	local isPassNormal = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)
	local isPassExtreme = DivineNuoYaChallengeModel.instance:isPassExtremeClgStageProgress(self._activityId)

	goutil.setActive(self._commonPass, isPassNormal)
	goutil.setActive(self._extremePass, isPassExtreme)
end

function DivineNuoYaClgMainView:_loadEffect(go, index)
	self:_removeEffect(index)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, go.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._mainRect) then
			eff:setClipping(self._mainRect)
		end
	end)

	uiEffect:setParent(go.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect[index] = uiEffect
end

function DivineNuoYaClgMainView:_removeEffect(index)
	self._uiEffect = self._uiEffect or {}

	if self._uiEffect[index] then
		UIEffectManager.instance:stopEffect(self._uiEffect[index])

		self._uiEffect[index] = nil
	end
end

function DivineNuoYaClgMainView:_clearEffect()
	for k, v in pairs(self._uiEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._uiEffect)
end

return DivineNuoYaClgMainView
