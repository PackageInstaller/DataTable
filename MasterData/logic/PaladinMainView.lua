-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/moonking/view/PaladinMainView.lua

module("logic.extensions.moonking.view.PaladinMainView", package.seeall)

local PaladinMainView = class("PaladinMainView", ViewComponent)

function PaladinMainView:ctor()
	PaladinMainView.super.ctor(self)
end

function PaladinMainView:bindEvents()
	PaladinMainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "paladinmain")
	end, self)
	self._gotoBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.PaladinBattle, self._challCfg.challengeId)
	end, self)
	self._rankBtn:AddClickListener(function()
		if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo2) then
			return
		end

		GotoMgr.gotoByString(self._challCfg.jumpTo2)
	end, self)
	self._tryBtn:AddClickListener(function()
		if self._challCfg == nil or string.nilorempty(self._challCfg.jumpTo1) then
			return
		end

		GotoMgr.gotoByString(self._challCfg.jumpTo1)
	end, self)
	self._skillBtn:AddClickListener(function()
		PetbookController.instance:previewBattle(self._challCfg.skinId)
	end, self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(self._challCfg.skinId)
	end, self)
	self._daibiItemBtn:AddClickListener(function()
		if string.nilorempty(self._challCfg.daibiStr) then
			return
		end

		MaterialMgr.openGetSourceByStr(self._challCfg.daibiStr)
	end, self)
end

function PaladinMainView:unbindEvents()
	PaladinMainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._gotoBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._tryBtn:RemoveClickListener()
	self._skillBtn:RemoveClickListener()
	self._introduceBtn:RemoveClickListener()
	self._daibiItemBtn:RemoveClickListener()
end

function PaladinMainView:onExit()
	PaladinMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMoonKingInfo, self._updataShowGetProgress, self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._anEff then
		UIEffectManager.instance:stopEffect(self._anEff)
	end

	self._anEff = nil
	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)

	MaterialMgr.resetAll(self._sprintRareGo)
	MaterialMgr.resetAll(self._rankGoods)
	uGuiUtil.clearImage(self._daibiIconIma.gameObject)
	uGuiUtil.clearImage(self._matIconIma.gameObject)
end

function PaladinMainView:destroyUI()
	PaladinMainView.super.destroyUI(self)
end

function PaladinMainView:buildUI()
	PaladinMainView.super.buildUI(self)

	self._sprintGo = self:getGo("sprintGo")

	local sprintInfoGo = self:getGo("sprintInfoGo")

	self._sprintRareGo = goutil.findChild(sprintInfoGo, "rareGo")
	self._skillBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "skillBtn")
	self._introduceBtn = Framework.ButtonAdapter.GetFrom(sprintInfoGo, "introduceBtn")
	self._tryBtn = self:getBtn("tryBtn")
	self._tryGo = self:getGo("tryGo")
	self._rankBtn = self:getBtn("rankBtn")
	self._rankGo = self:getGo("rankGo")
	self._rankGoods = goutil.findChild(self._rankGo, "rankGoods")
	self._gotoBtn = self:getBtn("gotoBtn")
	self._gotoRedGo = self:getGo("gotoBtn/redpointGo")
	self._countTxt = self:getTxt("gotoBtn/countTxt")
	self._matIconIma = self:getGo("gotoBtn/countTxt/iconIma"):GetComponent("Image")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._closeBtn = self:getBtn("closeBtn")
	self._timerTxt = self:getTxt("timerTxt")
	self._descTxt = self:getTxt("descTxt")
	self._daibiItemBtn = self:getBtn("daibiItem")
	self._daibiIconIma = self:getGo("daibiItem/daibiIconIma"):GetComponent("Image")
	self._daibiCountTxt = self:getTxt("daibiItem/daibiCountTxt")

	self._gotoRedGo:SetActive(false)
	self._tryGo:SetActive(false)

	self._timerTxt.text = ""
end

function PaladinMainView:onEnter()
	PaladinMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateMoonKingInfo, self._updataShowGetProgress, self)

	self._challCfg = MoonKingConfig.instance:getBattleBaseCfg(MoonKingModel.instance.pbChallendId)
	self._descTxt.text = lang("text_tong_desc_28")

	self:_showActivityTimer()
	self:_firstOpenStory()
	MaterialMgr.setCell(MatType.Rare, self._challCfg.skinId, self._sprintRareGo)

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, self._challCfg.skinId, self._sprintGo, self._challCfg.modelScale, nil, true, 0, 0)

	self:_updataShowGetProgress()

	if self._challCfg and not string.nilorempty(self._challCfg.showPrize) then
		GameUtil.SetActive(self._rankGo, true)
		MaterialMgr.setCellByCfg(self._challCfg.showPrize, self._rankGoods)
	else
		GameUtil.SetActive(self._rankGo, false)
	end

	self._gotoRedGo:SetActive(MoonKingModel.instance:getPaladinRedpoint(true))

	local effPath = "20220729/shengqixiaoyan/fx_ui_xiaoyan_ksqs.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)

	effPath = "20220729/shengqixiaoyan/fx_ui_xiaoyan_anniu.prefab"
	self._anEff = UIEffectManager.instance:playEffect(self, "20220729/shengqixiaoyan/fx_ui_xiaoyan_anniu.prefab", self._gotoBtn.gameObject, 0, 0, true, nil, nil, nil, self)

	self._anEff:setParent(self._gotoBtn.gameObject.transform)
	self._anEff:setLocalPos(-168, -11, 0)
	self._anEff:setScale(1)
	MoonKingController.instance:csGetMoonShadowKingChallengeGetInfoReq(self._challCfg.challengeId)
end

function PaladinMainView:_showActivityTimer()
	self._isActivityEnd = false

	removetimer(self._calculationSurplusTime, self)

	if not TLChallengeController.instance:isInOpenTime(self._challCfg.challengeId) then
		self._isActivityEnd = true
		self._timerTxt.text = ""

		return
	end

	local actCfg = TimeLimitedConfig.instance:getCfgById(self._challCfg.challengeId)
	local start, timer = TLChallengeController.instance:getStartAndEndTime(actCfg)

	if start == nil or checknumber(timer) <= ServerTime.now() then
		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true
	end

	self._endTime = timer

	self:_calculationSurplusTime()
	settimer(1, self._calculationSurplusTime, self, true)
end

function PaladinMainView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = lang("text_tong_desc_12")
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and langPara("text_suo_timer_1", day, hour, min) or langPara("text_suo_timer_2", hour, min, sec)
end

function PaladinMainView:_updataShowGetProgress()
	local matInfo = string.split(self._challCfg.daibiStr, ":")
	local matType = matInfo and tonumber(matInfo[1]) or MatType.ACTIVITY_ITEM
	local matId = matInfo and tonumber(matInfo[2]) or 43
	local count = MaterialModel.instance:getMaterialsNumber(matType, matId)

	self._daibiCountTxt.text = tostring(count)

	MaterialMgr.setIcon(self._daibiIconIma, matType, matId)

	self._countTxt.text = lang("text_tong_desc_30")

	MaterialMgr.setIcon(self._matIconIma, matType, matId)
end

function PaladinMainView:_firstOpenStory()
	local str = "PaladinMainView_UserId_" .. LoginModel.instance.userId

	if checknumber(GameUtil.getUserData(str)) == 1 then
		return
	end

	ViewBlockMgr.instance:blockClick(true, self)
	AnimationPlayer.play("storyconfig/animations/yanshen_dengchang.txt", function()
		ViewBlockMgr.instance:blockClick(false, self)
	end, nil, self)
	GameUtil.saveUserData(str, 1)
end

return PaladinMainView
