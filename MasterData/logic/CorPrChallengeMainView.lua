-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/corpr/view/CorPrChallengeMainView.lua

module("logic.extensions.corpr.view.CorPrChallengeMainView", package.seeall)

local CorPrChallengeMainView = class("CorPrChallengeMainView", ViewComponent)

function CorPrChallengeMainView:buildUI()
	CorPrChallengeMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._petCon = goutil.findChild(self.mainGO, "petCon")
	self._btnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank")
	self._redBtnRank = goutil.findChild(self.mainGO, "jumpButton/btnRank/redPoint")
	self._btnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery")
	self._redBtnLottery = goutil.findChild(self.mainGO, "jumpButton/btnLottery/redPoint")
	self._btnShop = goutil.findChild(self.mainGO, "jumpButton/btnShop")
	self._redBtnShop = goutil.findChild(self.mainGO, "jumpButton/btnShop/redPoint")
	self._btnEnter = goutil.findChild(self.mainGO, "btnEnter")
	self._redBtnEnter = goutil.findChild(self.mainGO, "btnEnter/redPoint")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")

	goutil.setActive(self._btnShop, false)
end

function CorPrChallengeMainView:bindEvents()
	CorPrChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickBtnRank, self)
	GameUtil.addClickHandler(self._btnLottery, self._onClickBtnLottery, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
end

function CorPrChallengeMainView:unbindEvents()
	CorPrChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnLottery)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnEnter)
end

function CorPrChallengeMainView:onEnter()
	CorPrChallengeMainView.super.onEnter(self)

	self._challengeId = CorPrChallengeConfig.instance:getCpCurChallengeId()

	if self._challengeId == 0 then
		printError("缺失挑战id")
	end

	self:_onSetUI()
	GameUtil.doCallbackWhenFirst("Kd_Rule_" .. self._challengeId, function()
		self:_onClickBtnTip()
	end, nil)

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, 15014, self._petCon, 1, nil, true, 0, 0)
end

function CorPrChallengeMainView:onExit()
	CorPrChallengeMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function CorPrChallengeMainView:_onSetUI()
	if self._txtOpenTime then
		self._txtOpenTime.text = TimeGateController.instance:getActTimeShowByChallengeId(self._challengeId)
	end

	local raceId = self:_getRaceId()

	if raceId > 0 then
		MaterialMgr.setCell(MatType.Rare, raceId, self._pointRare)
	end
end

function CorPrChallengeMainView:_getRaceId()
	local tlData = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	return (tlData or nil) and (tlData.raceId or 0)
end

function CorPrChallengeMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()

	if raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function CorPrChallengeMainView:_onClickBtnIntroduce()
	local raceId = self:_getRaceId()

	if raceId > 0 then
		PetbookController.instance:openPetinfoView(raceId)
	end
end

function CorPrChallengeMainView:_onClickBtnRank()
	local jumpToStr = CorPrChallengeConfig.instance:getCpCommonValue("JUMP_RANK")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function CorPrChallengeMainView:_onClickBtnLottery()
	local jumpToStr = CorPrChallengeConfig.instance:getCpCommonValue("JUMP_LOTTERY")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function CorPrChallengeMainView:_onClickBtnShop()
	local jumpToStr = CorPrChallengeConfig.instance:getCpCommonValue("JUMP_SHOP")

	if not string.nilorempty(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function CorPrChallengeMainView:_onClickBtnEnter()
	UIStateManager.instance:push(ViewName.CorPrIdentityMainView)
end

function CorPrChallengeMainView:_onClickBtnTip()
	local tlData = TimeLimitedConfig.instance:getCfgById(self._challengeId)

	if tlData then
		TipsFacade.instance:openRulesView(tlData.ruleKey)
	end
end

return CorPrChallengeMainView
