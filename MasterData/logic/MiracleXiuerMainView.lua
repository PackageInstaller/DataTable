-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclexiuer/view/MiracleXiuerMainView.lua

module("logic.extensions.miraclexiuer.view.MiracleXiuerMainView", package.seeall)

local MiracleXiuerMainView = class("MiracleXiuerMainView", ViewComponent)

function MiracleXiuerMainView:ctor()
	MiracleXiuerMainView.super.ctor(self)
end

function MiracleXiuerMainView:unbindEvents()
	MiracleXiuerMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump1)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump2)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump3)
	GameUtil.rmClickHandler(self._jumpBtnCol_btnJump4)
	GameUtil.rmClickHandler(self._btnGainBuff)
	self._btnChallenge:RemoveClickListener()
end

function MiracleXiuerMainView:bindEvents()
	MiracleXiuerMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickBtnSkill, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onClickBtnIntroduce, self)
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump1, GameUtil.handler(self._onClickBtnJump, self, "jumpStr1"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump2, GameUtil.handler(self._onClickBtnJump, self, "jumpStr2"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump3, GameUtil.handler(self._onClickBtnJump, self, "jumpStr3"))
	GameUtil.addClickHandler(self._jumpBtnCol_btnJump4, GameUtil.handler(self._onClickBtnJump, self, "jumpStr4"))
	GameUtil.addClickHandler(self._btnGainBuff, self._onClickBuff, self)
	self._btnChallenge:AddClickListener(self._onClickbtnChallenge, self)
end

function MiracleXiuerMainView:buildUI()
	MiracleXiuerMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._con = goutil.findChild(self.mainGO, "con")
	self._jumpBtnCol = goutil.findChild(self.mainGO, "jumpBtnCol")
	self._jumpBtnCol_btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._jumpBtnCol_btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._jumpBtnCol_btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._jumpBtnCol_btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._jumpBtnCol_btnJump1_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1/redPoint")
	self._jumpBtnCol_btnJump2_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2/redPoint")
	self._jumpBtnCol_btnJump3_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3/redPoint")
	self._jumpBtnCol_btnJump4_redPoint = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4/redPoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._txtChallenge = self:getTxt("btnChallenge/text")
	self._passGo = self:getGo("btnChallenge/pass")
	self._btnGainBuff = self:getGo("buffCol/btnGain")
	self._txtDescBuff = self:getTxt("buffCol/txtDesc")
	self._txtBuffLv = self:getTxt("buffCol/Lv/txt")
	self._iconBuff = self:getGo("buffCol/cell/con/icon")
	self._rdBuff = self:getGo("buffCol/cell/rd")
end

function MiracleXiuerMainView:onExit()
	MiracleXiuerMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._clgBtnCol_btnClg1_bubble_itemcell)

	if self._effectHandler then
		UIEffectManager.instance:stopEffect(self._effectHandler)

		self._effectHandler = nil
	end
end

function MiracleXiuerMainView:onEnter()
	MiracleXiuerMainView.super.onEnter(self)

	self._challengeId = 177

	if not TLChallengeController.instance:isInOpenTime(self._challengeId) then
		local text = string.format("限时挑战不在开启期限内( challengeId  = %d )", self._challengeId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self.addGEvent(self, GlobalNotify.PM_CynthiaGetInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.PM_CynthiaBuffUpRes, self._onUpgradeBuff, self)
	CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeGetInfoReq(self._challengeId)
end

function MiracleXiuerMainView:_updateUIByCfg()
	self._challengeCfg = TimeLimitedConfig.instance:getCfgById(self._challengeId)
	self._actCfg = CynthiaConfig.instance:getActCfg(self._challengeId)

	local stime = GameUtil.string2time(self._challengeCfg.absoluteOpenDay)
	local etime = GameUtil.string2time(self._challengeCfg.absoluteEndDay)

	self._txtOpenTime.text = string.format("活动时间：%s", etime >= GameUtil.string2time(GameUtil.ForeverActTimeString) and "常驻" or GameUtil.getTimeTxt(stime, etime, GameEnum.TimeTxt.M_D_H))

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end
end

function MiracleXiuerMainView:_updateUIByInfo()
	self._mo = CynthiaModel.instance:getActMo(self._challengeId)

	local isPass = self._mo.isAllPass

	self._txtChallenge.text = isPass and "扫荡" or "进入\n挑战"

	goutil.setActive(self._passGo, false)
	self:_updateBuff()
end

function MiracleXiuerMainView:_updateBuff()
	local curBuffLv = self._mo.buffLv
	local isGainBuff = self._mo.isUpToday
	local buffCfgs = CynthiaConfig.instance:getBuffCfgs(self._challengeId)
	local maxBuffLv = #buffCfgs
	local showEff = not isGainBuff and curBuffLv < maxBuffLv
	local buffCfg = buffCfgs[curBuffLv]

	self._txtBuffLv.text = string.format("Lv.%s", curBuffLv)

	if buffCfg then
		self._txtDescBuff.text = buffCfg.des or "未激活"
	end

	goutil.setActive(self._rdBuff, showEff)
end

function MiracleXiuerMainView:_onUpgradeBuff()
	FloatWordMgr.instance:show("升级成功")
	self:_updateBuff()
end

function MiracleXiuerMainView:_onClickBtnSkill()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId ~= 0 then
		if raceId == skinId then
			PetbookController.instance:previewBattle(raceId)
		else
			PetbookController.instance:previewBattle(raceId, skinId)
		end
	end
end

function MiracleXiuerMainView:_onClickBtnIntroduce()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function MiracleXiuerMainView:_getRaceId()
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self:_getSkinId())

	return petSkinCfg and petSkinCfg.raceId
end

function MiracleXiuerMainView:_getSkinId()
	return self._challengeCfg.raceId
end

function MiracleXiuerMainView:_onClickBtnJump(key)
	local jumpToStr = self._actCfg[key]

	if not GameUtil.isEmptyString(jumpToStr) then
		GotoMgr.gotoByString(jumpToStr)
	end
end

function MiracleXiuerMainView:_onClickBtnTip()
	local key = self._challengeCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MiracleXiuerMainView:_onClickbtnChallenge()
	if not CynthiaModel.instance:getIsTimeAbleToChallenge(self._challengeId) then
		TipsFacade.instance:openCommonTips(lang("每天早上9点到次日5点开放挑战！"))

		return
	end

	if not self._mo.isAllPass then
		UIStateManager.instance:push(ViewName.MiracleXiuerChallengeView, self._challengeId)

		return
	end

	if CynthiaModel.instance:getIsAbleToSweep(self._challengeId) then
		CynthiaChallengeAgent.instance:sendPM_CynthiaChallengeSweepReq(self._challengeId)
	else
		TipsFacade.instance:openCommonTips(lang("明日再来扫荡吧！"))
	end
end

function MiracleXiuerMainView:_onClickBuff()
	local curBuffLv = self._mo.buffLv
	local isGainBuff = self._mo.isUpToday
	local buffCfgs = CynthiaConfig.instance:getBuffCfgs(self._challengeId)
	local maxBuffLv = #buffCfgs

	if maxBuffLv <= curBuffLv then
		FloatWordMgr.instance:show("已满级")

		return
	end

	if isGainBuff then
		FloatWordMgr.instance:show("今日已升级")

		return
	end

	if self._mo.isAllPass then
		FloatWordMgr.instance:show("已通关")

		return
	end

	CynthiaController.instance:upBuff(self._challengeId)
end

function MiracleXiuerMainView:_onClickClose()
	self:close()
	UIStateManager.instance:push(ViewName.MiracleXiuerMainView)
end

return MiracleXiuerMainView
