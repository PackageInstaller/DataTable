-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterji/view/SummonMasterJiNormalView.lua

module("logic.extensions.summonmasterji.view.SummonMasterJiNormalView", package.seeall)

local SummonMasterJiNormalView = class("SummonMasterJiNormalView", ViewComponent)

function SummonMasterJiNormalView:ctor()
	SummonMasterJiNormalView.super.ctor(self)
end

function SummonMasterJiNormalView:buildUI()
	SummonMasterJiNormalView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._imgProgress = self:getImg("progressPanel/progress")
	self._txtProgress = self:getTxt("progressPanel/txtProgress")
	self._btnOneKey = self:getBtn("progressPanel/btnOneKey")
	self.scrollerGo = self:getGo("levelPanel/tableview")
	self.cellGo = self:getGo("levelPanel/tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.scrollerGo2 = self:getGo("levelPanel/tableview2")
	self.cellGo2 = self:getGo("levelPanel/tablecell2")
	self._scrollList2 = ScrollerList.create(self.scrollerGo2, self.cellGo2, GameUtil.handler(self._updateCell2, self), GameUtil.handler(self.clearCell2, self))
	self.scrollerGo3 = self:getGo("levelPanel/enemyFmt/tableview3")
	self.cellGo3 = self:getGo("levelPanel/enemyFmt/tablecell3")
	self._scrollList3 = ScrollerList.create(self.scrollerGo3, self.cellGo3, GameUtil.handler(self._updateCell3, self), GameUtil.handler(self.clearCell3, self))
	self._rewardIcon = self:getGo("levelPanel/reward/icon")
	self._txtReward = self:getTxt("levelPanel/reward/txt")
	self._btnBuff = self:getBtn("levelPanel/buff/btnBuff")
	self._txtBuffName = self:getTxt("levelPanel/buff/txtBuffName")
	self._txtBuffDesc = self:getTxt("levelPanel/buff/txtBuffDesc")
	self._buffEmpty = self:getGo("levelPanel/buff/btnBuff/buffEmpty")
	self._buffIcon = self:getGo("levelPanel/buff/btnBuff/buffIcon")
	self._txtEmpty = self:getGo("levelPanel/buff/txtEmpty")
	self._buffRedPoint = self:getGo("levelPanel/buff/btnBuff/redPoint")
	self._btnChallenge = self:getBtn("btnChallenge")
	self._powerPetMo = FightingPowerPetMo.New()
	self._effectGo = self:getGo("effect")
end

function SummonMasterJiNormalView:bindEvents()
	SummonMasterJiNormalView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
end

function SummonMasterJiNormalView:unbindEvents()
	SummonMasterJiNormalView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.addClickHandler(self._btnOneKey)
	GameUtil.addClickHandler(self._btnBuff)
	GameUtil.addClickHandler(self._btnChallenge)
end

function SummonMasterJiNormalView:onEnter()
	SummonMasterJiNormalView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SummonMasterJiOneKeyPassNormalRes, self._onOneKeyPassNormalRes, self)
	SummonMasterJiController.instance:registerLocalNotify(SummonMasterJiController.SelectBuffFinishEvent, self._onSelectBuffFinish, self)
	self:_loadEffect()

	self._activityId = self:getFirstParam()
	self._cfgActivity = SummonMasterJiConfig.instance:getActivityCfg(self._activityId)
	self._totalProgress = self._cfgActivity.normalPassProgress
	self._curChapterId = 1
	self._curStageId = 1
	self._selectBlessingId = -1
	self._curSelectStageId = 1
	self._isPassAll = SummonMasterJiModel.instance:isPassNormalChallenge(self._activityId)

	self:_updateProgress()
	self:_updateStages()

	self._selectBlessingId = SummonMasterJiController.instance:getBlessingId(self._activityId, self._curStageId)

	self:_updateBuffInfo(self._selectBlessingId)
	RedPointController.instance:regRedPoint(self._buffRedPoint, SummonMasterJiController.instance:getRedPointIds(self._activityId))
end

function SummonMasterJiNormalView:onExit()
	SummonMasterJiNormalView.super.onExit(self)
	SummonMasterJiController.instance:unregisterLocalNotify(SummonMasterJiController.SelectBuffFinishEvent, self._onSelectBuffFinish, self)
	RedPointController.instance:unregRedPoint(self._buffRedPoint)
	self._scrollList:dispose()
	self._scrollList2:dispose()
	self._scrollList3:dispose()
	self:_clearReward()
	self:_clearBuffIcon()
	self:_removeEffect()
end

function SummonMasterJiNormalView:_onClickOneKey()
	if SummonMasterJiModel.instance:isPassNormalChallenge(self._activityId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	local costStr = SummonMasterJiController.instance:getNormalOneKeyCost(self._activityId)
	local matType, id, matNum = MaterialMgr.getMatParams(costStr)

	if matNum > MaterialModel.instance:getMaterialsNumber(matType, id) then
		MaterialMgr.openGetSource(matType, id)

		return
	end

	local content = string.format("是否确认消耗[<quad name=%d:%d|icon size=30 width=1 offsetY=-5/>*%d]，一键补足剩余召唤进度\nps：价格根据当前剩余进度换算，剩余进度越少，价格越低哦！", matType, id, matNum)

	local function successCallBack()
		SummonMasterJiAgent.instance:sendPM_SummonMasterJiOneKeyPassNormalReq(self._activityId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, successCallBack)
end

function SummonMasterJiNormalView:_onClickBuff()
	UIStateManager.instance:push(ViewName.SummonMasterJiBuffView, self._activityId, self._selectBlessingId)
end

function SummonMasterJiNormalView:_onClickChallenge()
	SummonMasterJiController.instance:openNormalMissionView(self._activityId, self._curStageId, self._selectBlessingId)
end

function SummonMasterJiNormalView:_onOneKeyPassNormalRes()
	self:close()
end

function SummonMasterJiNormalView:_onSelectBuffFinish(blessingId)
	printInfo("test SummonMasterJiNormalView:_onSelectBuffFinish(blessingId)", blessingId)

	self._selectBlessingId = blessingId

	self:_updateBuffInfo(blessingId)
	SummonMasterJiController.instance:saveBlessingId(self._activityId, self._curStageId, blessingId)
end

function SummonMasterJiNormalView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txt")
	local pass = goutil.findChild(cell, "pass")
	local lock = goutil.findChild(cell, "lock")
	local selectGo = goutil.findChild(cell, "select")
	local cfgStage = data.cfgs[1]

	txtName.text = cfgStage.chapterName

	local isLock = data.chapterId > self._curChapterId

	if not self._isPassAll then
		local isPass = self._curChapterId > data.chapterId

		GameUtil.SetActive(pass, isPass)
		GameUtil.SetActive(lock, isLock)
		GameUtil.SetActive(selectGo, data.chapterId == self._curChapterId)
	end
end

function SummonMasterJiNormalView:clearCell(cell)
	return
end

function SummonMasterJiNormalView:_updateCell2(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "btn/txtName")
	local pass = goutil.findChild(cell, "btn/pass")
	local lock = goutil.findChild(cell, "btn/lock")
	local selectGo = goutil.findChild(cell, "btn/select")
	local btn = goutil.findChild(cell, "btn")

	txtName.text = GameUtil.toRomanNumber(data.index)

	local isLock = data.cfg.stageId > self._curStageId

	if not self._isPassAll then
		local isPass = self._curStageId > data.cfg.stageId

		GameUtil.SetActive(pass, isPass)
		GameUtil.SetActive(lock, isLock)
		GameUtil.SetActive(selectGo, data.cfg.stageId == self._curStageId)
		GameUtil.addClickHandler(btn, function()
			if isLock then
				FloatWordMgr.instance:show("请通关上一关卡后解锁")
			end
		end)
	end
end

function SummonMasterJiNormalView:clearCell2(cell)
	return
end

function SummonMasterJiNormalView:_updateCell3(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")

	self._powerPetMo:fromChallengeCreepCo(data)

	local bagPetMo = self._powerPetMo:toBaseBagPetMo()

	MaterialMgr.resetAll(node)

	local proxy = MaterialMgr.setCellByMo(bagPetMo, node)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(bagPetMo)
	end)
end

function SummonMasterJiNormalView:clearCell3(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function SummonMasterJiNormalView:_updateProgress()
	local curStageId = SummonMasterJiModel.instance:getNormalCurProgress(self._activityId)
	local curProgress, totalProgress = SummonMasterJiController.instance:getProgress(self._activityId, curStageId)

	self._txtProgress.text = string.format("召唤进度：%d/%d", curProgress, totalProgress)
	self._imgProgress.fillAmount = Mathf.Clamp01(curProgress / totalProgress)

	self:_updateSliderPercent()
end

function SummonMasterJiNormalView:_updateStages()
	local curPassStageId = SummonMasterJiModel.instance:getNormalCurProgress(self._activityId)
	local maxStageId = SummonMasterJiController.instance:getMaxNormalStageId(self._activityId)
	local curStageId = curPassStageId + 1

	curStageId = curStageId <= maxStageId and curStageId or maxStageId
	self._curChapterId = SummonMasterJiController.instance:getChapterIdByStageId(self._activityId, curStageId)
	self._curStageId = curStageId
	self._curSelectStageId = curStageId

	local chapterList = SummonMasterJiController.instance:getChapterList(self._activityId)

	for i, v in ipairs(chapterList) do
		v.isSelect = v.chapterId == self._curChapterId
	end

	self._scrollList:reloadData(chapterList)

	local stageCfgList = SummonMasterJiConfig.instance:getNormalChapterStageList(self._activityId, self._curChapterId)
	local list = {}

	for i, v in ipairs(stageCfgList) do
		local info = {}

		info.index = i
		info.isSelect = v.stageId == self._curStageId
		info.cfg = v

		table.insert(list, info)
	end

	self._scrollList2:reloadData(list)
	self:_updateEnemyFmt(self._curStageId)
	self:_updateReward(self._curStageId)
end

function SummonMasterJiNormalView:_updateEnemyFmt(stageId)
	local stageCfg = SummonMasterJiConfig.instance:getNormalStageCfg(self._activityId, stageId)

	if stageCfg then
		local cfgCreeps = SummonMasterJiConfig.instance:getCreeps(stageCfg.creepsMasterId)

		self._scrollList3:reloadData(cfgCreeps)
	end
end

function SummonMasterJiNormalView:_updateReward(stageId)
	self:_clearReward()

	local cfgStr = SummonMasterJiConfig.instance:getCommonValue("PROCESS_ITEM")

	MaterialMgr.setCellByCfg(cfgStr, self._rewardIcon)
end

function SummonMasterJiNormalView:_clearReward()
	MaterialMgr.resetAll(self._rewardIcon)
end

function SummonMasterJiNormalView:_updateBuffInfo(blessingId)
	local cfgBlessing = SummonMasterJiConfig.instance:getBlessingCfg(self._activityId, blessingId)

	if cfgBlessing then
		local cfg = SummonMasterJiConfig.instance:getBuffCfg(cfgBlessing.buffId)

		if cfg then
			self._txtBuffName.text = cfg.name
			self._txtBuffDesc.text = cfg.desc

			GameUtil.SetActive(self._txtBuffName, true)
			GameUtil.SetActive(self._txtBuffDesc, true)
			GameUtil.SetActive(self._buffEmpty, false)
			GameUtil.SetActive(self._txtEmpty, false)
			GameUtil.SetActive(self._buffIcon, true)
			uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, cfg.iconPath)

			return
		end
	end

	self._txtBuffName.text = "无"
	self._txtBuffDesc.text = "无"

	GameUtil.SetActive(self._txtBuffName, false)
	GameUtil.SetActive(self._txtBuffDesc, false)
	GameUtil.SetActive(self._buffEmpty, true)
	GameUtil.SetActive(self._txtEmpty, true)
	GameUtil.SetActive(self._buffIcon, false)
	self:_clearBuffIcon()
end

function SummonMasterJiNormalView:_clearBuffIcon()
	uGuiUtil.clearImage(self._buffIcon)
end

function SummonMasterJiNormalView:_loadEffect()
	self:_removeEffect()

	local effectPath = SummonMasterJiNormalViewPresentor.EffectPath1

	local function loadedHandler(handlerTarget, eff)
		self:_updateSliderPercent()
	end

	local uiEffect = UIEffectManager.instance:playEffect(self, effectPath, self._effectGo.transform, 0, 0, true, false, nil, loadedHandler, nil)

	uiEffect:setParent(self._effectGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._uiEffect = uiEffect
end

function SummonMasterJiNormalView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

function SummonMasterJiNormalView:_updateSliderPercent()
	if not self._uiEffect then
		return
	end

	if goutil.isNil(self._uiEffect.effGo) then
		return
	end

	local effGo = self._uiEffect.effGo
	local startY = -0.45
	local height = 0.9
	local shuiGo = goutil.findChild(effGo, "glow/shuimian")
	local pos = shuiGo.transform.localPosition
	local curStageId = SummonMasterJiModel.instance:getNormalCurProgress(self._activityId)
	local curProgress, totalProgress = SummonMasterJiController.instance:getProgress(self._activityId, curStageId)
	local percent = Mathf.Clamp01(curProgress / totalProgress)
	local y = startY + percent * height

	shuiGo.transform.localPosition = Vector3.New(pos.x, y, pos.z)
end

return SummonMasterJiNormalView
