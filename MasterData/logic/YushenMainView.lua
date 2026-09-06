-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/copy/YushenMainView.lua

module("logic.extensions.dragonxiuer.view.YushenMainView", package.seeall)

local YushenMainView = class("YushenMainView", ViewComponent)

function YushenMainView:ctor()
	YushenMainView.super.ctor(self)
end

function YushenMainView:unbindEvents()
	YushenMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevel)
	GameUtil.rmClickHandler(self._btnBoss)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSkill)
	self._btnJump3:RemoveClickListener()
	self._btnJump4:RemoveClickListener()
	self._btnJump1:RemoveClickListener()
	self._btnJump2:RemoveClickListener()
end

function YushenMainView:bindEvents()
	YushenMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevel, self._onClickLevel, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBoss, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	self._btnJump3:AddClickListener(self._onClickbtnJump3, self)
	self._btnJump4:AddClickListener(self._onClickbtnJump4, self)
	self._btnJump1:AddClickListener(self._onClickbtnJump1, self)
	self._btnJump2:AddClickListener(self._onClickbtnJump2, self)
end

function YushenMainView:buildUI()
	YushenMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnTip = self:getGo("static/btnTip")
	self._btnLevel = self:getGo("levelChallenge/btnLevel")
	self._btnBoss = self:getGo("bossChallenge/btnBoss")
	self._txtTime = self:getTxt("openTime/txt")
	self._levelPrize = self:getGo("levelChallenge/prize")
	self._levelPrizeCon = self:getGo("levelChallenge/prize/con")
	self._levelPrizeTxt = self:getTxt("levelChallenge/prize/txtTip")
	self._bossPrize = self:getGo("bossChallenge/prize")
	self._bossPrizeCon = self:getGo("bossChallenge/prize/con")
	self._bossPrizeTxt = self:getTxt("bossChallenge/prize/txtTip")
	self._petCon = self:getGo("static/bg/con")
	self._btnIntroduce = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._rareGo = self:getGo("petInfo/pointRare")
	self._btnJump3 = self:getBtn("btns/btnJump3")
	self._btnJump4 = self:getBtn("btns/btnJump4")
	self._btnJump1 = self:getBtn("btns/btnJump1")
	self._btnJump2 = self:getBtn("btns/btnJump2")
	self._redPointGo = self:getGo("btnBuff/redPoint")
	self._btnBuffGo = self:getGo("btnBuff")
	self._buffText = self:getTxt("btnBuff/txtBuff")
end

function YushenMainView:onExit()
	YushenMainView.super.onExit(self)
	MaterialMgr.resetAll(self._levelPrizeCon)
	MaterialMgr.resetAll(self._bossPrizeCon)

	if self._petObj then
		RoleObjectPool.instance:removeRole(self._petObj)
	end

	SignInBuffController.instance:unregSignInBuffPartSimple(self._actId, self._btnBuffGo)
end

function YushenMainView:onEnter()
	YushenMainView.super.onEnter(self)

	self._actId = checknumber(self:getFirstParam())

	if self._actId == 0 then
		self._actId = 323002
	end

	if self._actId <= 0 then
		FloatWordMgr.instance:show(lang("活动未开放"))
		self:close()

		return
	end

	self._actCfg = DragonXiuerConfig.instance:getActCfg(self._actId)

	DragonXiuerAgent.instance:sendPM_DragonXiuerGetInfoReq(self._actId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._actId)

	MaterialMgr.resetAll(self._levelPrizeCon)

	if not string.nilorempty(self._actCfg.allDestroyPrize) then
		MaterialMgr.setCellByCfg(self._actCfg.allDestroyPrize, self._levelPrizeCon)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.allDestroyPrize)

		self._levelPrizeTxt.text = langPara("挑战获得\n%s", MaterialMgr.getMaterialsName(matType, matId))
	end

	MaterialMgr.resetAll(self._bossPrizeCon)

	if not string.nilorempty(self._actCfg.soulPrize) then
		MaterialMgr.setCellByCfg(self._actCfg.soulPrize, self._bossPrizeCon)

		local matType, matId, matNum = MaterialMgr.getMatParams(self._actCfg.soulPrize)

		self._bossPrizeTxt.text = langPara("挑战获得\n%s", MaterialMgr.getMaterialsName(matType, matId))
	end

	local petCfg = CharacterConfig.instance:getPetCo(self._actCfg.raceId)

	self._txtPetName.text = petCfg.name

	MaterialMgr.setCell(MatType.Rare, self._actCfg.raceId, self._rareGo)

	self._petObj = RoleObjectPool.instance:addRoleToParent(self._petObj, self._actCfg.raceId, self._petCon)

	SignInBuffController.instance:regSignInBuffPartSimple(self._actId, self._btnBuffGo, function(param)
		goutil.setActive(self._redPointGo, param.isCanGain)

		local buffCfg = param.buffCfg

		self._buffText.text = buffCfg == nil and "未获得加成" or buffCfg.des
	end)
	DragonXiuerModel.instance:setResultViewName(ViewName.YushenSettlementSuccessView)
end

function YushenMainView:_onClickLevel()
	local maxStageCount = DragonXiuerConfig.instance:getMaxStage(self._actId)

	if maxStageCount > DragonXiuerModel.instance:getPassStageId(self._actId) then
		UIStateManager.instance:push(ViewName.YushenLevelView, self._actId)
	else
		FloatWordMgr.instance:show(lang("已通关"))
	end
end

function YushenMainView:_onClickBoss()
	if DragonXiuerModel.instance:getIsPassBoss(self._actId) == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.YushenBossView, self._actId)
	end
end

function YushenMainView:_onClickTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(241)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function YushenMainView:_onClickShop()
	if not string.nilorempty(self._actCfg.jumpTo[1]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[1])
	end
end

function YushenMainView:_onClickRank()
	if not string.nilorempty(self._actCfg.jumpTo[2]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[2])
	end
end

function YushenMainView:_onClickCard()
	if not string.nilorempty(self._actCfg.jumpTo[3]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[3])
	end
end

function YushenMainView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._actCfg.raceId)
end

function YushenMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._actCfg.raceId)
end

function YushenMainView:_onClickbtnJump1()
	if not string.nilorempty(self._actCfg.jumpTo[1]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[1])
	end
end

function YushenMainView:_onClickbtnJump2()
	if not string.nilorempty(self._actCfg.jumpTo[2]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[2])
	end
end

function YushenMainView:_onClickbtnJump3()
	if not string.nilorempty(self._actCfg.jumpTo[3]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[3])
	end
end

function YushenMainView:_onClickbtnJump4()
	if not string.nilorempty(self._actCfg.jumpTo[4]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[4])
	end
end

return YushenMainView
