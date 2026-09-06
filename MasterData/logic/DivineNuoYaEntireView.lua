-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinenuoyachallenge/view/DivineNuoYaEntireView.lua

module("logic.extensions.divinenuoyachallenge.view.DivineNuoYaEntireView", package.seeall)

local DivineNuoYaEntireView = class("DivineNuoYaEntireView", ViewComponent)
local selectKey = "DivineNuoYaEntireView_key"

function DivineNuoYaEntireView:buildUI()
	DivineNuoYaEntireView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnBuff = self:getBtn("btnBuff")
	self._btnChallenge = self:getBtn("enemyFmt/btnChallenge")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regReloadFinish(GameUtil.handler(self._reloadFinish, self))

	self._icon = self:getGo("btnBuff/icon")
	self._effect = self:getGo("btnBuff/effect")
	self._txtDesc = self:getTxt("btnBuff/txtDesc")
	self._mainRect = self.mainGO:GetComponent(goutil.Type_RectTransform)
	self._fmtList = {}

	for i = 1, 9 do
		local item = {}

		item.go = self:getGo(string.format("enemyFmt/fmt/cell_%d", i))
		item.con = self:getGo(string.format("enemyFmt/fmt/cell_%d/con", i))

		table.insert(self._fmtList, item)
	end

	self._txtName = self:getTxt("enemyFmt/txtName")
	self._txtPassNum = self:getTxt("enemyFmt/txtPassNum")
	self._txtLeftNum = self:getTxt("enemyFmt/txtLeftNum")
	self._txtLevelDesc = self:getTxt("enemyFmt/txtLevelDesc")
	self._txtTip = self:getTxt("txtTip")
	self._powerPetMo = FightingPowerPetMo.New()
end

function DivineNuoYaEntireView:bindEvents()
	DivineNuoYaEntireView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnChallenge:AddClickListener(self._onClickChallenge, self)
end

function DivineNuoYaEntireView:unbindEvents()
	DivineNuoYaEntireView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function DivineNuoYaEntireView:onEnter()
	DivineNuoYaEntireView.super.onEnter(self)
	DivineNuoYaChallengeController.instance:registerLocalNotify(DivineNuoYaChallengeController.SelectEvent, self._onSelectSupportPet, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = DivineNuoYaChallengeConfig.instance:getActivityCfg(self._activityId)
	self._planId = self:_getRecentlySelectPlanId()

	self:_initSupportFmtList()
	self:_loadEffect()
	SignInBuffController.instance:regSignInBuffPartSimple(self._activityId, self._btnBuff, function(param)
		self:_updateSignInBuffUI(param)
	end)
	self:_initEnemyFmt()
	self:_updateChallengeDesc()
end

function DivineNuoYaEntireView:onExit()
	DivineNuoYaEntireView.super.onExit(self)
	DivineNuoYaChallengeController.instance:unregisterLocalNotify(DivineNuoYaChallengeController.SelectEvent, self._onSelectSupportPet, self)
	SignInBuffController.instance:unregSignInBuffPartSimple(self._activityId, self._btnBuff)
	self:_saveRecentlySelectPlanId()
	self._scrollList:dispose()
	self:_removeEffect()
	self:_clearEnemyFmt()
end

function DivineNuoYaEntireView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "divinenuoyaentireview_rule")
end

function DivineNuoYaEntireView:_onClickChallenge()
	if DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local curChallengeTimes = DivineNuoYaChallengeModel.instance:normalChallengeTimes()
	local maxChallengeTimes = self._cfgActivity.normalClgDailyCount

	if maxChallengeTimes <= curChallengeTimes then
		FloatWordMgr.instance:show("今日挑战次数已用完，请明天继续努力哦")

		return
	end

	DivineNuoYaChallengeController.instance:openNormalMissionView(self._activityId, self:_getStageId(), self._planId)
end

function DivineNuoYaEntireView:_getStageId()
	local isPassAll = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)
	local progress = DivineNuoYaChallengeModel.instance:getNormalClgProgress()

	return isPassAll and progress or progress + 1
end

function DivineNuoYaEntireView:_onSelectSupportPet(index)
	local curViewDatas = self._scrollList:getData()

	for i, v in ipairs(curViewDatas) do
		v.isSelect = v.index == index
	end

	self._scrollList:refresh()

	self._planId = index
end

function DivineNuoYaEntireView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, DNYEntireCell)

	component:init(data)
end

function DivineNuoYaEntireView:_clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, DNYEntireCell)

	component:clear()
end

function DivineNuoYaEntireView:_reloadFinish()
	self._scrollList:MoveCellToCenter(self._planId - 1)
end

function DivineNuoYaEntireView:_getRecentlySelectPlanId()
	local planId = checknumber(GameUtil.getUserData(selectKey .. self._activityId))

	return planId > 0 and planId or 1
end

function DivineNuoYaEntireView:_saveRecentlySelectPlanId()
	GameUtil.saveUserData(selectKey .. self._activityId, self._planId)
end

function DivineNuoYaEntireView:_initSupportFmtList()
	local cfgsList = DivineNuoYaChallengeConfig.instance:getSupportPetPlanIdList(self._activityId)
	local list = {}

	for i, v in ipairs(cfgsList) do
		local data = {}

		data.index = i
		data.petCfgs = v
		data.isSelect = self._planId == i

		table.insert(list, data)
	end

	self._scrollList:reloadData(list)
end

function DivineNuoYaEntireView:_updateSignInBuffUI(param)
	local buffCfg = param.buffCfg

	if buffCfg then
		self._txtDesc.text = buffCfg.des or "无buff"
	end

	goutil.setActive(self._effect, param.isCanGain)

	local iconCfg = buffCfg

	if not iconCfg then
		local buffCfgs = SignInBuffConfig.instance:getBuffCfgsByActId(self._activityId) or {}

		iconCfg = buffCfgs[1]
	end

	local icon = iconCfg and iconCfg.icon

	if string.nilorempty(icon) then
		uGuiUtil.clearImage(self._icon)
	else
		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, GameUrl.getIconUrl(icon))
	end
end

function DivineNuoYaEntireView:_loadEffect()
	self:_removeEffect()

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, self._effect.transform, 0, 0, true, false, nil, function(target, eff)
		if not goutil.isNil(self._mainRect) then
			eff:setClipping(self._mainRect)
		end
	end)

	uiEffect:setParent(self._effect.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect = uiEffect
end

function DivineNuoYaEntireView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function DivineNuoYaEntireView:_initEnemyFmt()
	self:_clearEnemyFmt()

	local cfgStage = DivineNuoYaChallengeConfig.instance:getNormalStage(self._activityId, self:_getStageId())

	if cfgStage then
		local cfgCreeps = DivineNuoYaChallengeConfig.instance:getCreeps(cfgStage.creepsMasterId)

		for i, cfgEnemy in ipairs(cfgCreeps) do
			local item = self._fmtList[cfgEnemy.posId]

			if item and item.go then
				goutil.setActive(item.go, true)
				GameUtil.setLocalScale(item.con, 0.8, 0.8, 0.8)
				self._powerPetMo:fromChallengeCreepCo(cfgEnemy)

				local bagPetMo = self._powerPetMo:toBaseBagPetMo()
				local proxy = MaterialMgr.setCellByMo(bagPetMo, item.con)

				proxy.binder:setAutoTips(false)
				proxy:setCallBack(function()
					CommonTipsMgr.instance:showPetTips(bagPetMo)
				end)
			end
		end
	end
end

function DivineNuoYaEntireView:_clearEnemyFmt()
	for i, v in ipairs(self._fmtList) do
		MaterialMgr.resetAll(v.con)
		goutil.setActive(v.go, false)
	end
end

function DivineNuoYaEntireView:_updateChallengeDesc()
	local isPassAll = DivineNuoYaChallengeModel.instance:isPassNormalClgProgress(self._activityId)
	local progress = DivineNuoYaChallengeModel.instance:getNormalClgProgress()
	local cfgStages = DivineNuoYaChallengeConfig.instance:getNormalStageList(self._activityId)
	local maxStageNum = #cfgStages
	local stageId = isPassAll and progress or progress + 1
	local curChallengeTimes = DivineNuoYaChallengeModel.instance:normalChallengeTimes()
	local maxChallengeTimes = self._cfgActivity.normalClgDailyCount

	self._txtName.text = string.format("第%d关", stageId)
	self._txtPassNum.text = string.format("累计通关：%d/%d", progress, maxStageNum)

	local leftTime = Mathf.Max(0, maxChallengeTimes - curChallengeTimes)

	self._txtLeftNum.text = string.format("剩余挑战次数：%d/%d", leftTime, maxChallengeTimes)

	GameUtil.SetGray(self._btnChallenge, leftTime == 0)

	local cfgStage = DivineNuoYaChallengeConfig.instance:getNormalStage(self._activityId, self:_getStageId())

	self._txtLevelDesc.text = string.format("共上阵%d只助战精灵", cfgStage.supportPetCount)
	self._txtTip.text = langPara("先选择助阵阵容，挑战时，需从助阵阵容挑选%d只精灵上阵", cfgStage.supportPetCount)
end

return DivineNuoYaEntireView
