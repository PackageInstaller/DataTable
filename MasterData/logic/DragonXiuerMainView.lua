-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonxiuer/view/DragonXiuerMainView.lua

module("logic.extensions.dragonxiuer.view.DragonXiuerMainView", package.seeall)

local DragonXiuerMainView = class("DragonXiuerMainView", ViewComponent)

function DragonXiuerMainView:ctor()
	DragonXiuerMainView.super.ctor(self)
end

function DragonXiuerMainView:unbindEvents()
	DragonXiuerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnLevel)
	GameUtil.rmClickHandler(self._btnBoss)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnCard)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSkill)
end

function DragonXiuerMainView:bindEvents()
	DragonXiuerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevel, self._onClickLevel, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBoss, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCard, self._onClickCard, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
end

function DragonXiuerMainView:buildUI()
	DragonXiuerMainView.super.buildUI(self)

	self._btnClose = self:getGo("static/btnClose")
	self._btnTip = self:getGo("static/btnTip")
	self._btnLevel = self:getGo("levelChallenge/btnLevel")
	self._btnBoss = self:getGo("bossChallenge/btnBoss")
	self._btnShop = self:getGo("btnShop")
	self._btnRank = self:getGo("btnRank")
	self._btnCard = self:getGo("btnCard")
	self._txtTime = self:getTxt("openTime/txt")
	self._levelPrize = self:getGo("levelChallenge/prize")
	self._levelPrizeCon = self:getGo("levelChallenge/prize/con")
	self._levelPrizeTxt = self:getTxt("levelChallenge/prize/txtTip")
	self._bossPrize = self:getGo("bossChallenge/prize")
	self._bossPrizeCon = self:getGo("bossChallenge/prize/con")
	self._bossPrizeTxt = self:getTxt("bossChallenge/prize/txtTip")
	self._petCon = self:getGo("static/bg/con")
	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._rareGo = self:getGo("petInfo/pointRare")
end

function DragonXiuerMainView:onExit()
	DragonXiuerMainView.super.onExit(self)
	MaterialMgr.resetAll(self._levelPrizeCon)
	MaterialMgr.resetAll(self._bossPrizeCon)

	if self._petObj then
		RoleObjectPool.instance:removeRole(self._petObj)
	end
end

function DragonXiuerMainView:onEnter()
	DragonXiuerMainView.super.onEnter(self)

	self._actId = self:getFirstParam() or ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DragonXiuer)

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

	DragonXiuerModel.instance:setResultViewName(ViewName.DragonXiuerSettlementSuccessView)
end

function DragonXiuerMainView:_onClickLevel()
	local maxStageCount = DragonXiuerConfig.instance:getMaxStage(self._actId)

	if maxStageCount > DragonXiuerModel.instance:getPassStageId(self._actId) then
		UIStateManager.instance:push(ViewName.DragonXiuerLevelView, self._actId)
	else
		FloatWordMgr.instance:show(lang("已通关"))
	end
end

function DragonXiuerMainView:_onClickBoss()
	if DragonXiuerModel.instance:getIsPassBoss(self._actId) == true then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.DragonXiuerBossView, self._actId)
	end
end

function DragonXiuerMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "dragonxiuerchallenge_rule")
end

function DragonXiuerMainView:_onClickShop()
	if not string.nilorempty(self._actCfg.jumpTo[1]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[1])
	end
end

function DragonXiuerMainView:_onClickRank()
	if not string.nilorempty(self._actCfg.jumpTo[2]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[2])
	end
end

function DragonXiuerMainView:_onClickCard()
	if not string.nilorempty(self._actCfg.jumpTo[3]) then
		GotoMgr.gotoByString(self._actCfg.jumpTo[3])
	end
end

function DragonXiuerMainView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._actCfg.raceId)
end

function DragonXiuerMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._actCfg.raceId)
end

return DragonXiuerMainView
