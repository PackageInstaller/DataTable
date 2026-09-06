-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jiehuangchallenge/view/JieHuangChallengeMainView.lua

module("logic.extensions.jiehuangchallenge.view.JieHuangChallengeMainView", package.seeall)

local JieHuangChallengeMainView = class("JieHuangChallengeMainView", ViewComponent)

function JieHuangChallengeMainView:ctor()
	JieHuangChallengeMainView.super.ctor(self)
end

function JieHuangChallengeMainView:buildUI()
	JieHuangChallengeMainView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnShop = self:getBtn("btnShop")
	self._btnRank = self:getBtn("btnRank")
	self._btnExchange = self:getBtn("btnExchange")
	self._btnIntroduce = self:getBtn("petInfo/btnIntroduce")
	self._btnSummon = self:getGo("btnSummon")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnRule = self:getBtn("btnRule")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._rareGo = self:getGo("petInfo/pointRare")
	self._txtBuff = self:getTxt("btnStart/bubble/txtBuff")
	self._buffBubbleGo = self:getGo("btnStart/bubble")
	self._txtTime = self:getTxt("time/txt")
	self._goldBarCon = self:getGo("goldBar")
	self._redPointGo = self:getGo("btnStart/redpoint")
end

function JieHuangChallengeMainView:bindEvents()
	JieHuangChallengeMainView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnExchange, self._onClickExchange, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickIntroduce, self)
	GameUtil.addClickHandler(self._btnSummon, self._onClickSummon, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function JieHuangChallengeMainView:unbindEvents()
	JieHuangChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnStart)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnExchange)
	GameUtil.rmClickHandler(self._btnSummon)
end

function JieHuangChallengeMainView:onEnter()
	JieHuangChallengeMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = MiyaChallengeModel.instance:getJieHuangTimeGateActivityId()
	end

	self._activityCfg = MiyaChallengeConfig.instance:getActivityCfg(self._activityId)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtPetName.text = petCfg.name

	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._rareGo)

	self._mainEff = UIEffectManager.instance:playEffect(self, "20230825/jiehuangtiaozhan/fx_ui_jiehuangtiaozhan01.prefab", nil, 0, 0, true)

	self._mainEff:setParent(self._bg.transform)
	self._mainEff:setLocalPos(0, 0, 0)
	self._mainEff:setScale(1)

	self._txtBuff.text = langPara("%s", MiyaChallengeConfig.instance:getBuffCfg(self._activityCfg.buffId).des)

	GameUtil.SetActive(self._buffBubbleGo, GameUtil.string2time(self._activityCfg.endTime) > ServerTime.now())

	local actCfg = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.MiyaChallenge, self._activityId)

	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	self:_setTopGoldBar()
	GameUtil.SetActive(self._redPointGo, not MiyaChallengeModel.instance:getDailyGameStart())
end

function JieHuangChallengeMainView:onExit()
	JieHuangChallengeMainView.super.onExit(self)
	MaterialMgr.resetAll(self._rareGo)
	UIEffectManager.instance:stopEffect(self._mainEff)
end

function JieHuangChallengeMainView:_onClickStart()
	UIStateManager.instance:push(ViewName.JieHuangChallengeLevelView, self._activityId)
end

function JieHuangChallengeMainView:_onClickRank()
	GotoMgr.gotoByString("func#618#" .. self._activityCfg.raceId)
end

function JieHuangChallengeMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.funcId[1]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[1])
	end
end

function JieHuangChallengeMainView:_onClickExchange()
	if not string.nilorempty(self._activityCfg.funcId[2]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[2])
	end
end

function JieHuangChallengeMainView:_onClickSummon()
	if not string.nilorempty(self._activityCfg.funcId[3]) then
		GotoMgr.gotoByString(self._activityCfg.funcId[3])
	end
end

function JieHuangChallengeMainView:_onClickIntroduce()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function JieHuangChallengeMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function JieHuangChallengeMainView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._activityCfg.ruleKey)
end

function JieHuangChallengeMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		showAdd = false,
		id = self._activityCfg.item
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return JieHuangChallengeMainView
