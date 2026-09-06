-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/view/CloudCutFanMainView.lua

module("logic.extensions.cloudcutfan.view.CloudCutFanMainView", package.seeall)

local CloudCutFanMainView = class("CloudCutFanMainView", ViewComponent)

function CloudCutFanMainView:ctor()
	CloudCutFanMainView.super.ctor(self)
end

function CloudCutFanMainView:unbindEvents()
	CloudCutFanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnMake)
	GameUtil.rmClickHandler(self._btnPreview)
end

function CloudCutFanMainView:bindEvents()
	CloudCutFanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnMake, self._onClickBtnMake, self)
	GameUtil.addClickHandler(self._btnPreview, self._onClickBtnPreview, self)
end

function CloudCutFanMainView:buildUI()
	CloudCutFanMainView.super.buildUI(self)

	self._con = self:getGo("con")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClg = self:getGo("btnClg")
	self._btnMake = self:getGo("btnMake")
	self._btnPreview = self:getGo("btnPreview")
	self._txtTimeTips = self:getTxt("timeTips/txt")
	self._txtDamValue = self:getTxt("damValue/txt")
	self._rp = self:getGo("btnMake/rp")

	local gocellPrizeInfo = self:getGo("prizeInfo/tableview/tablecell")
	local goTabPrizeInfo = self:getGo("prizeInfo/tableview")

	self._tableviewPrizeInfo = ScrollerList.create(goTabPrizeInfo, gocellPrizeInfo, GameUtil.handler(self._updateCellPrizeInfo, self), GameUtil.handler(self._clearCellPrizeInfo, self))
end

function CloudCutFanMainView:onExit()
	CloudCutFanMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._tableviewPrizeInfo:dispose()
end

function CloudCutFanMainView:onEnter()
	CloudCutFanMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_CloudCutFanInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = CloudCutFanController.instance:getDefaultActivityId() or 0
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
	CloudCutFanController.instance:getInfo(self._activityId)
end

function CloudCutFanMainView:_updateUIByCfg()
	self._actCfg = CloudCutFanConfig.instance:getActCfgByActId(self._activityId) or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._allChallengePrizeCfgs = CloudCutFanConfig.instance:getAllChallengePrizeCfgs(self._activityId) or {}
	self._dailyClgLimit = self._actCfg.dailyClgCount or 0

	self:_updatePetInfo()
	self._tableviewPrizeInfo:reloadData(self._allChallengePrizeCfgs)
end

function CloudCutFanMainView:_updatePetInfo()
	self._curSkinId = self._actCfg.skinId or 0
	self._curRaceId = 0

	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(self._curSkinId)

	if petSkinCfg then
		self._curRaceId = petSkinCfg.raceId or 0

		local displayBagOffset = CharacterConfig.instance:getModelUIPosAndScale("drawing", self._curSkinId)

		self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, displayBagOffset[3], nil, true, displayBagOffset[1], displayBagOffset[2])
	end
end

function CloudCutFanMainView:_updateUIByInfo()
	self._todayMaxDamage = 0
	self._challengeCount = 0

	local info = CloudCutFanModel.instance:getInfo(self._activityId)

	if info then
		self._todayMaxDamage = checknumber(info.todayMaxDamage)
		self._challengeCount = checknumber(info.todayUsedChallengeCount)
	end

	self._txtDamValue.text = langPara("今日最高伤害：%s", MmUtil.formatNumber(self._todayMaxDamage, MmUtil.Units_CN, 1))
	self._txtTimeTips.text = langPara("今日挑战次数：%s/%s", self._dailyClgLimit - self._challengeCount, self._dailyClgLimit)

	local isRed = CloudCutFanController.instance:isRPActive(self._activityId)

	goutil.setActive(self._rp, isRed)
end

function CloudCutFanMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function CloudCutFanMainView:_onClickBtnClg()
	if self._challengeCount >= self._dailyClgLimit then
		TipsFacade.instance:openCommonTips(lang("今日挑战次数已达上限"))

		return
	end

	CloudCutFanController.instance:enterFmtMo(self._activityId, false)
end

function CloudCutFanMainView:_onClickBtnPreview()
	CloudCutFanController.instance:enterFmtMo(self._activityId, true)
end

function CloudCutFanMainView:_onClickBtnMake()
	UIStateManager.instance:push(ViewName.CloudCutFanBookView, self._activityId)
end

function CloudCutFanMainView:_updateCellPrizeInfo(view, cell, data)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txt = goutil.findChildTextComponent(go, "txt")

	if not data.transDesc then
		txtDesc.text = data.transDesc

		if not data.damagePrize then
			local damagePrize = ""
			local matType, id, matNum = MaterialMgr.getMatParams(damagePrize)

			txt.text = matNum
		end
	end
end

function CloudCutFanMainView:_clearCellPrizeInfo(cell)
	return
end

return CloudCutFanMainView
