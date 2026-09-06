-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeCimeliaView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeCimeliaView", package.seeall)

local SunWuKongChallengeCimeliaView = class("SunWuKongChallengeCimeliaView", ViewComponent)

function SunWuKongChallengeCimeliaView:ctor()
	SunWuKongChallengeCimeliaView.super.ctor(self)
end

function SunWuKongChallengeCimeliaView:buildUI()
	SunWuKongChallengeCimeliaView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnRule = self:getBtn("btnRule")
	self._tableview = self:getGo("tableview")
	self._tableCell = self:getGo("cell")
	self._goldBarCon = self:getGo("goldBarCon")
end

function SunWuKongChallengeCimeliaView:bindEvents()
	SunWuKongChallengeCimeliaView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
end

function SunWuKongChallengeCimeliaView:unbindEvents()
	SunWuKongChallengeCimeliaView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
end

function SunWuKongChallengeCimeliaView:onEnter()
	SunWuKongChallengeCimeliaView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeGetCimeliaInfoRes, self.refreshView, self)

	self._scrollList = ScrollerList.create(self._tableview, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)

	SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeGetCimeliaInfoReq(self._activityId)
	self:_setTopGoldBar()
end

function SunWuKongChallengeCimeliaView:onExit()
	SunWuKongChallengeCimeliaView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeGetCimeliaInfoRes, self.refreshView, self)
	self._scrollList:dispose()
end

function SunWuKongChallengeCimeliaView:refreshView()
	local cimaliaCfgs = SunWuKongChallengeConfig.instance:getCimeliaCfgs(self._actCfg.cimeliaPlanId)

	self._scrollList:reloadData(cimaliaCfgs)
end

function SunWuKongChallengeCimeliaView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnClick"))
	local imgChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")
	local txtName = goutil.findChildTextComponent(go, "name/txt")
	local txtLevel = goutil.findChildTextComponent(go, "level/txt")
	local lockTip = goutil.findChild(go, "lockTip")
	local txtLockTip = goutil.findChildTextComponent(go, "lockTip/txt")
	local redPoint = goutil.findChild(go, "redpoint")
	local cimeliaLevel = SunWuKongChallengeModel.instance:getCimeliaData(data.cimeliaId)
	local curPassStage = SunWuKongChallengeModel.instance:getCurStageId(self._activityId)
	local levelCfg = SunWuKongChallengeConfig.instance:getCimeliaLevelCfg(data.cimeliaLevelPlanId)
	local isCanLevelUp = false

	if levelCfg[curPassStage + 1] then
		local matType, matId, num = MaterialMgr.getMatParams(levelCfg[curPassStage + 1].cost)

		isCanLevelUp = not (MaterialModel.instance:IsEnough(matType, matId, num) ~= true or curPassStage < data.unlockStageId)

		GameUtil.SetActive(redPoint, isCanLevelUp or SunWuKongChallengeModel.instance:getNewCimelia(self._activityId, data.cimeliaId))
	else
		GameUtil.SetActive(redPoint, isCanLevelUp)
	end

	GameUtil.SetActive(lockTip, curPassStage < data.unlockStageId)
	imgChange:ChangeSprite(data.resName)

	txtName.text = data.name
	txtLevel.text = langPara("Lv.%d", checknumber(cimeliaLevel))
	txtLockTip.text = langPara("通关第%d关解锁", data.unlockStageId - 1)

	btn:RemoveClickListener()
	btn:AddClickListener(GameUtil.handler(self._onClickCell, self, data, curPassStage, redPoint, isCanLevelUp))
end

function SunWuKongChallengeCimeliaView:_onClickCell(data, curPassStage, redPoint, isCanLevelUp)
	if curPassStage >= data.unlockStageId then
		GameUtil.SetActive(redPoint, isCanLevelUp)
		UIStateManager.instance:push(ViewName.SunWuKongChallengeCimeliaInfoView, self._activityId, data.cimeliaId)
	else
		FloatWordMgr.instance:show(lang("请先通关前面关卡"))
	end
end

function SunWuKongChallengeCimeliaView:_clearCell(cell)
	local go = cell.gameObject
	local btn = GameUtil.asBtn(goutil.findChild(go, "btnClick"))

	btn:RemoveClickListener()
end

function SunWuKongChallengeCimeliaView:_setTopGoldBar()
	local barShow = string.split(self._actCfg.goldBar2, "#")
	local btn_list = {}

	for i, v in ipairs(barShow) do
		if i == 2 then
			local matType, matId, num = MaterialMgr.getMatParams(v)

			table.insert(btn_list, {
				showAdd = true,
				id = string.format("%d:%d", matType, matId)
			})
		end
	end

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

function SunWuKongChallengeCimeliaView:_onClickRule()
	UIStateManager.instance:open(ViewName.RulesView, self._actCfg.ruleKey)
end

return SunWuKongChallengeCimeliaView
