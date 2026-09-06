-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddishitian/view/GodDiShiTianMainView.lua

module("logic.extensions.goddishitian.view.GodDiShiTianMainView", package.seeall)

local GodDiShiTianMainView = class("GodDiShiTianMainView", ViewComponent)

function GodDiShiTianMainView:ctor()
	GodDiShiTianMainView.super.ctor(self)
end

function GodDiShiTianMainView:buildUI()
	GodDiShiTianMainView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnTip = self:getBtn("btnTip")
	self._commonItems = {}
	self._colorChanges = {}

	for i = 1, 3 do
		local item = {}

		item.go = self:getGo(string.format("state_1/btn_%d", i))
		item.btn = self:getBtn(string.format("state_1/btn_%d", i))
		item.txtScore = self:getTxt(string.format("state_1/btn_%d/txtScore", i))
		item.txtPass = self:getTxt(string.format("state_1/btn_%d/txtPass", i))

		table.insert(self._commonItems, item)

		local cc = self:getGo(string.format("state_1/btn_4/finalState1/progress_%d", i)):GetComponent(ComponentType.UIImageSpriteChange)

		table.insert(self._colorChanges, cc)
	end

	self._btnFinal = self:getBtn("state_1/btn_4")
	self._finalState1 = self:getGo("state_1/btn_4/finalState1")
	self._finalState2 = self:getGo("state_1/btn_4/finalState2")
	self._txtScore = self:getTxt("state_1/btn_4/finalState2/txtScore")
	self._txtDesc = self:getTxt("state_1/btn_4/finalState2/txtDesc")
	self._oneKeyItem = self:getGo("oneKeyItem")
	self._item = self:getGo("oneKeyItem/item")
	self._txtTip = self:getTxt("oneKeyItem/txtTip")
	self._role = self:getGo("role")
end

function GodDiShiTianMainView:bindEvents()
	GodDiShiTianMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBuy:AddClickListener(self._onClickBuy, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnFinal:AddClickListener(self._onClickFinal, self)

	for i, v in ipairs(self._commonItems) do
		v.btn:AddClickListener(function()
			self:_onClickCommonLevel(i)
		end)
	end
end

function GodDiShiTianMainView:unbindEvents()
	GodDiShiTianMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnFinal:RemoveClickListener()
end

function GodDiShiTianMainView:onEnter()
	GodDiShiTianMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GodDiShiTianQuickPassRes, self._onQuickPassRes, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._setItem, self)

	local params = self:getOpenParam()
	local enterType = params and params[1]
	local value = params and params[2]
	local isShowChallengeSuccessView = false

	if type(value) == "boolean" then
		isShowChallengeSuccessView = value
	end

	printInfo("test GodDiShiTianMainView", params and params[1], params and params[2], isShowChallengeSuccessView)

	self._enterType = 1
	self._enterType = enterType and 1 or 2

	printInfo("test 进入方式", self._enterType, enterType)

	self._challengeId = GodDiShiTianModel.instance:getChallengeId()
	self._cfgChallenge = GodDiShiTianConfig.instance:getChallengeCfg(self._challengeId)

	self:_setItem()
	self:_showRoleModel()
	GodDiShiTianAgent.instance:sendPM_GodDiShiTianGetInfoReq()

	if isShowChallengeSuccessView then
		local function callback()
			UIStateManager.instance:popByName(ViewName.GodDiShiTianMainView)
		end

		UIStateManager.instance:push(ViewName.DivineEvolveTipView, callback)
	end
end

function GodDiShiTianMainView:onExit()
	GodDiShiTianMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GodDiShiTianGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GodDiShiTianQuickPassRes, self._onQuickPassRes, self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._setItem, self)
	self:_clearItem()
	self:_resetRoleModel()
end

function GodDiShiTianMainView:_onGetInfoRes()
	self:_updateShow()
end

function GodDiShiTianMainView:_onQuickPassRes()
	self:_updateShow()
end

function GodDiShiTianMainView:_onClickClose()
	self:close()
end

function GodDiShiTianMainView:_onClickBuy()
	if GodDiShiTianModel.instance:isPassFinalLevel() then
		FloatWordMgr.instance:show("帝释天挑战已通关")

		return
	end

	local matType, matId, matNum = MaterialMgr.getMatParams(self._cfgChallenge.passSaleCost)
	local content = string.format("是否消耗%d神钻一键通关神启帝释天？", matNum)

	local function successCallBack()
		GodDiShiTianAgent.instance:sendPM_GodDiShiTianQuickPassReq()
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, successCallBack)
end

function GodDiShiTianMainView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "goddishitianrule")
end

function GodDiShiTianMainView:_onClickFinal()
	if GodDiShiTianModel.instance:isPassFinalLevel() then
		FloatWordMgr.instance:show("帝释天挑战已通关")

		return
	elseif not GodDiShiTianModel.instance:isFinalLevelOpen() then
		FloatWordMgr.instance:show("星月夜关卡评分一致且高于每关最低分后开启")

		return
	else
		UIStateManager.instance:push(ViewName.GodDiShiTianStageView, 4, self._enterType)
	end
end

function GodDiShiTianMainView:_onClickCommonLevel(levelIndex)
	if GodDiShiTianModel.instance:isPassFinalLevel() then
		FloatWordMgr.instance:show("帝释天挑战已通关")

		return
	elseif not GodDiShiTianModel.instance:isFinalLevelOpen() then
		UIStateManager.instance:push(ViewName.GodDiShiTianStageView, levelIndex, self._enterType)
	else
		FloatWordMgr.instance:show("最终章已开放")

		return
	end
end

function GodDiShiTianMainView:_updateShow()
	if GodDiShiTianModel.instance:isPassFinalLevel() or GodDiShiTianModel.instance:isFinalLevelOpen() then
		for i = 1, 3 do
			goutil.setActive(self._commonItems[i].go, false)
			self._colorChanges[i]:SetState(2)
		end

		goutil.setActive(self._finalState1, false)
		goutil.setActive(self._finalState2, true)

		local finalStageType = 4

		self._txtScore.text = GodDiShiTianModel.instance:getChapterScore(finalStageType)

		local cfg = GodDiShiTianConfig.instance:getStageTypeCfg(finalStageType)

		if cfg then
			self._txtDesc.text = string.format("达到<color=#%s>%d</color>分通关", ColorConst.Green, cfg.passLine)
		end
	else
		local stateList = GodDiShiTianController.instance:getChapterColorState()

		for i = 1, 3 do
			local score = GodDiShiTianModel.instance:getChapterScore(i)
			local isChapterPass = GodDiShiTianModel.instance:isChapterPass(i)

			self._colorChanges[i]:SetState(stateList[i])

			self._commonItems[i].txtScore.text = string.format("评分：%d", score)
			self._commonItems[i].txtPass.text = string.format("<color=#%s>%s</color>", (isChapterPass or nil) and (ColorConst.Green or ColorConst.Red), isChapterPass and "已通关" or "未通关")
		end

		goutil.setActive(self._finalState1, true)
		goutil.setActive(self._finalState2, false)
	end
end

function GodDiShiTianMainView:_setItem()
	local endTime = GameUtil.string2time(self._cfgChallenge.passSaleAwardTime)

	if ServerTime.now() < endTime - 2 then
		goutil.setActive(self._oneKeyItem, true)

		local day = Mathf.Floor((endTime - ServerTime.now()) / 86400) + 1

		self._txtTip.text = string.format("剩余%d天\n一键通关获得", day)

		MaterialMgr.setCellByCfg(self._cfgChallenge.passSaleAward, self._item)
	else
		goutil.setActive(self._oneKeyItem, false)
	end
end

function GodDiShiTianMainView:_clearItem()
	MaterialMgr.resetAll(self._item)
end

function GodDiShiTianMainView:_showRoleModel()
	local skinId = 11006
	local offset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	local function onLoadedCallback(go)
		local firstChild = go.transform:GetChild(0)

		goutil.setActive(firstChild.gameObject, false)
	end

	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._role, scale, onLoadedCallback, true, x, y)
end

function GodDiShiTianMainView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return GodDiShiTianMainView
