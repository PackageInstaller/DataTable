-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailongevolve/view/NaiLongEvolveChallengeView.lua

module("logic.extensions.nailongevolve.view.NaiLongEvolveChallengeView", package.seeall)

local NaiLongEvolveChallengeView = class("NaiLongEvolveChallengeView", ViewComponent)
local SHOW_CELL_NUM = 5

function NaiLongEvolveChallengeView:ctor()
	NaiLongEvolveChallengeView.super.ctor(self)
end

function NaiLongEvolveChallengeView:unbindEvents()
	NaiLongEvolveChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnEvolve)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)

	for idx = 1, SHOW_CELL_NUM do
		local cellGo = self:getGo("levels/cell" .. idx)

		GameUtil.rmClickHandler(cellGo)
	end
end

function NaiLongEvolveChallengeView:bindEvents()
	NaiLongEvolveChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnEvolve, self._onClickBtnEvolve, self)

	for idx = 1, SHOW_CELL_NUM do
		local cellGo = self:getGo("levels/cell" .. idx)

		GameUtil.addClickHandler(cellGo, GameUtil.handler(self._onClickStage, self, idx))
	end
end

function NaiLongEvolveChallengeView:buildUI()
	NaiLongEvolveChallengeView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._item = self:getGo("rightCol/goldBar/item")
	self._txtNum = self:getTxt("rightCol/goldBar/txtNum")
	self._slider = self:getSlider("level/slider")
	self._txtBottom = self:getTxt("level/txtBottom")
	self._txtTop = self:getTxt("level/txtTop")
	self._txtStage = self:getTxt("level/slider/FillArea/info/txtStage")
	self._headIcon = self:getGo("level/slider/FillArea/info/head")
	self._txtDebuffDesc = self:getTxt("rightCol/scrDebuff/Viewport/txtDebuffDesc")
	self._txtWinDesc = self:getTxt("rightCol/scrWin/Viewport/txtWinDesc")
	self._txtLevelTitle = self:getTxt("rightCol/txtLevel")
	self._btnChallenge = self:getGo("rightCol/btnChallenge")
	self._btnEvolve = self:getGo("rightCol/btnEvolve")
	self._tableview = self:getGo("rightCol/fmt/tableview")
	self._cell = self:getGo("rightCol/fmt/cell")
	self._scrollList = ScrollerList.create(self._tableview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._rawardTableview = self:getGo("rightCol/reward/tableview")
	self._rewardCell = self:getGo("rightCol/reward/cell")
	self._scrollRewardList = ScrollerList.create(self._rawardTableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function NaiLongEvolveChallengeView:onExit()
	NaiLongEvolveChallengeView.super.onExit(self)
	MaterialMgr.clearIcon(self._item)
	HeadItemController.instance:resetHeadCell(self._headIcon)

	for i = 1, SHOW_CELL_NUM do
		local con = self:getGo("levels/cell" .. i .. "/conMask/con")

		uGuiUtil.clearImage(con)
	end

	self._scrollList:dispose()
	self._scrollRewardList:dispose()
end

function NaiLongEvolveChallengeView:onEnter()
	NaiLongEvolveChallengeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyMilkDragonFightEndRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgPosLvlUpRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MilkDragonClgResetPosLvlRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = 451001
	end

	self._actCfg = NaiLongEvolveConfig.instance:getActData(self._activityId)
	self._stageCfgs = NaiLongEvolveConfig.instance:getStageData(self._activityId)
	self._accuBuffCfgs = NaiLongEvolveConfig.instance:getAccuBuffSortList(self._activityId)
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)
	self._skinId = self._actCfg.skinId

	local pass = NaiLongEvolveController.instance:isPass(self._activityId)

	if pass then
		self:close()
	end

	self:_onSetUI()
end

function NaiLongEvolveChallengeView:_onSetUI()
	local curChallengeId = NaiLongEvolveController.instance:getCurchanllengeId(self._activityId)

	self._curStageCfg = NaiLongEvolveConfig.instance:getStageDataByStageId(self._activityId, curChallengeId)

	local creepMasterId = self._curStageCfg.creepsMasterId
	local creepCfgs = NaiLongEvolveConfig.instance:getCreepsData(creepMasterId)
	local prizeList = string.split(self._curStageCfg.passPrize, "#")

	if self._curStageCfg.passAddScore > 0 then
		local scoreMatStr = self._actCfg.scoreIcon .. ":" .. self._curStageCfg.passAddScore

		table.insert(prizeList, scoreMatStr)
	end

	local curChallengeId = NaiLongEvolveController.instance:getCurchanllengeId(self._activityId)
	local curFloorNum = math.ceil(curChallengeId / SHOW_CELL_NUM)

	self._txtWinDesc.text = self._curStageCfg.winDesc
	self._txtDebuffDesc.text = self:_getCurDebuffDesc()
	self._txtLevelTitle.text = "第" .. curChallengeId .. "关"
	self._txtStage.text = "当前第" .. curChallengeId .. "关"
	self._txtBottom.text = "第1关"
	self._txtTop.text = "第" .. #self._stageCfgs .. "关"

	if self._info.curPassStageId == 0 then
		self._slider:SetValue(0)
	else
		self._slider:SetValue(curChallengeId / #self._stageCfgs)
	end

	for i = 1, SHOW_CELL_NUM do
		local cellGo = self:getGo("levels/cell" .. i)
		local con = self:getGo("levels/cell" .. i .. "/conMask/con")
		local imgLock = self:getGo("levels/cell" .. i .. "/imgLock")
		local imgPass = self:getGo("levels/cell" .. i .. "/imgPass")
		local imgChoose = self:getGo("levels/cell" .. i .. "/imgChoose")
		local txtLevel = self:getTxt("levels/cell" .. i .. "/txtLevel")
		local curStageId = i + (curFloorNum - 1) * SHOW_CELL_NUM
		local hasPassed = curStageId <= self._info.curPassStageId
		local isChallenge = curStageId == self._info.curPassStageId + 1

		txtLevel.text = "第" .. curStageId .. "关"

		GameUtil.SetActive(imgPass, hasPassed)
		GameUtil.SetActive(imgChoose, isChallenge)
		GameUtil.SetActive(imgLock, not isChallenge and not hasPassed)
		GameUtil.SetActive(cellGo, self._stageCfgs[curStageId] ~= nil)

		local skinId = NaiLongEvolveConfig.instance:getCreepSkinId(self._activityId, curStageId)
		local modelCo = CharacterConfig.instance:getModelCo(skinId)

		if modelCo then
			if not modelCo.headName then
				local petIconName = ""

				uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(petIconName))
			end
		end
	end

	local creepCfgList = {}

	for i, cfg in ipairs(creepCfgs) do
		if cfg.posId > 0 then
			table.insert(creepCfgList, cfg)
		end
	end

	self._scrollList:reloadData(creepCfgList)
	self._scrollRewardList:reloadData(prizeList)

	local headInfo = RoleModel.instance:getHeadInfo()

	HeadItemController.instance:setHeadCellByInfo(self._headIcon, headInfo, true)

	local matStr = self._actCfg.scoreIcon
	local arr = string.split(matStr, ":")

	MaterialMgr.clearIcon(self._item)
	MaterialMgr.setIcon(self._item, arr[1], arr[2])

	self._txtNum.text = self._info.curScore or 0
end

function NaiLongEvolveChallengeView:_onUpdate()
	self._info = NaiLongEvolveModel.instance:getInfo(self._activityId)

	self:_onSetUI()
end

function NaiLongEvolveChallengeView:_updateCell(view, cell, data)
	local con = goutil.findChild(cell, "con")
	local petMo
	local fMo = FightingPowerPetMo.New()

	fMo:fromChallengeCreepCo(data)

	petMo = fMo:toBaseBagPetMo()

	if petMo and data.posId > 0 then
		local skinId = data.raceId

		if checknumber(data.faceId) > 0 then
			skinId = checknumber(data.faceId)
		end

		local proxy = MaterialMgr.setCellByMo(petMo, con)

		proxy.binder:setAutoTips(false)
		proxy:setCallBack(function()
			CommonTipsMgr.instance:showPetTips(petMo)
		end)
		GameUtil.SetActive(cell, true)
		GameUtil.SetActive(con, true)
	end
end

function NaiLongEvolveChallengeView:_clearCell(cell)
	local con = goutil.findChild(cell, "con")

	MaterialMgr.resetAll(con)
end

function NaiLongEvolveChallengeView:_updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function NaiLongEvolveChallengeView:_clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function NaiLongEvolveChallengeView:_getCurDebuffDesc()
	local consumeScore = self._info.consumedScore
	local desc

	for i, cfg in ipairs(self._accuBuffCfgs) do
		if consumeScore >= cfg.accScore then
			desc = cfg.desc
		end
	end

	return desc or "无"
end

function NaiLongEvolveChallengeView:_onClickStage(idx)
	local curChallengeId = NaiLongEvolveController.instance:getCurchanllengeId(self._activityId)
	local curFloorNum = math.ceil(curChallengeId / SHOW_CELL_NUM)
	local curStageId = idx + (curFloorNum - 1) * SHOW_CELL_NUM
	local isChallenge = curStageId == self._info.curPassStageId + 1
	local hasPassed = curStageId <= self._info.curPassStageId
	local curStageCfg = self._stageCfgs[curStageId]
	local minAccConsumeScore = curStageCfg and curStageCfg.minAccConsumeScore
	local canChallenge = minAccConsumeScore <= self._info.consumedScore

	if hasPassed then
		FloatWordMgr.instance:show("已挑战过，无需再次挑战")
	elseif not isChallenge then
		FloatWordMgr.instance:show("请先通关之前挑战")
	else
		if not canChallenge then
			FloatWordMgr.instance:show("尚未消耗足够技能点，请先去升级消耗再来吧~")

			return
		end

		NaiLongEvolveController.instance:enterBattleClg(self._activityId, curStageId)
	end
end

function NaiLongEvolveChallengeView:_onClickBtnChallenge()
	local curChallengeId = NaiLongEvolveController.instance:getCurchanllengeId(self._activityId)
	local curStageCfg = self._stageCfgs[curChallengeId]
	local minAccConsumeScore = curStageCfg and curStageCfg.minAccConsumeScore
	local canChallenge = minAccConsumeScore <= self._info.consumedScore

	if curChallengeId == self._info.curPassStageId then
		FloatWordMgr.instance:show("已通关所有关卡")

		return
	end

	if not canChallenge then
		FloatWordMgr.instance:show("技能点消耗不满足进入条件")

		return
	end

	NaiLongEvolveController.instance:enterBattleClg(self._activityId, curChallengeId)
end

function NaiLongEvolveChallengeView:_onClickBtnEvolve()
	UIStateManager.instance:push(ViewName.NaiLongEvolveView, self._activityId)
end

function NaiLongEvolveChallengeView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyChallenge

	TipsFacade.instance:openRulesView(key)
end

return NaiLongEvolveChallengeView
