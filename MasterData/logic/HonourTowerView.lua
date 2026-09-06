-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/honourtower/view/HonourTowerView.lua

module("logic.extensions.honourtower.view.HonourTowerView", package.seeall)

local HonourTowerView = class("HonourTowerView", ViewComponent)

function HonourTowerView:ctor()
	HonourTowerView.super.ctor(self)
end

function HonourTowerView:unbindEvents()
	HonourTowerView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function HonourTowerView:bindEvents()
	HonourTowerView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._tipOnClick, self)
end

function HonourTowerView:onExit()
	HonourTowerView.super.onExit(self)
	self._tabList:dispose()
	uGuiUtil.clearImage(self._petIcon)
end

function HonourTowerView:buildUI()
	HonourTowerView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("txtTitle/btnTip")
	self._txtLevel = self:getTxt("desc/txtLevel")
	self._txtProgress = self:getTxt("desc/txtProgress")
	self._txtTime = self:getTxt("desc/txtTime")
	self._txtTitle = self:getTxt("info/level/txtTitle")
	self._txtDesc = self:getTxt("info/level/txtDesc")
	self._pet = self:getGo("info/pet")
	self._race = self:getGo("info/race")
	self._level = self:getGo("info/level")
	self._goldBarCon = self:getGo("goldBarCon")
	self._petIcon = self:getGo("info/level/petHead/petIcon")
	self._tableview = self:getGo("tableview")
	self._tabCell = self:getGo("cell")
	self._progressPrizeScroll = self._tableview:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._progressPrizeTrans = self:getGo("tableview/Viewport"):GetComponent(goutil.Type_RectTransform)
	self._tabList = ScrollerList.create(self._tableview, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
end

function HonourTowerView:onEnter()
	HonourTowerView.super.onEnter(self)
	self.addGEvent(self, HonorTowerAgent.HonorTowerInfoRes, self._refreshUi, self)

	self._periodId = HonourTowerModel.instance:getPeriodId()
	self._params = self:getOpenParam()
	self._challengeId = self._params[1]
	self._info = HonourTowerModel.instance:getChallengeInfo(self._challengeId)
	self._rewardList = {}

	local objList = {
		{
			id = "60:1",
			showAdd = true
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)

	self._worldSliderStartOffset = 0
	self._worldSliderEndOffset = 0
	self._worldWidthSpace = 280
	self._selectId = 0
	self._periodCfg = HonourTowerConfig.instance:getPeriodCfgById(self._periodId)

	self:_refreshUi()
	HonorTowerAgent.instance:sendPM_HonorTowerInfoReq(self._periodId)
end

function HonourTowerView:_updateTabCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "pet/petIcon")
	local reward = goutil.findChild(cell, "reward")
	local rewardList = goutil.findChild(cell, "reward/rewardList")
	local rewardItem_1 = goutil.findChild(rewardList, "rewardItem_1")
	local rewardItem_2 = goutil.findChild(rewardList, "rewardItem_2")
	local pass = goutil.findChild(cell, "pass")
	local lock = goutil.findChild(cell, "lock")
	local petNum = goutil.findChild(cell, "petNum")
	local round = goutil.findChild(cell, "round")
	local txtPass = goutil.findChild(cell, "txtPass")
	local txtLevel = goutil.findChildTextComponent(cell, "level/txtLevel")
	local txtCost = goutil.findChildTextComponent(cell, "cost/txtCost")
	local txtRound = goutil.findChildTextComponent(round, "txtRound")
	local txtNum = goutil.findChildTextComponent(petNum, "txtNum")
	local singleLine = rewardList:GetComponent(ComponentType.UILayoutSingleLine)
	local isPassStageNum = self._info.curStageId + 1
	local isPass = isPassStageNum > data.stageId
	local isLock = isPassStageNum < data.stageId
	local stageInfo = HonourTowerModel.instance:getStageInfo(self._challengeId, data.stageId)

	goutil.setActive(pass, isPass)
	goutil.setActive(txtPass, isPass)
	goutil.setActive(lock, isLock)
	goutil.setActive(rewardItem_1, false)
	goutil.setActive(rewardItem_2, false)
	goutil.setActive(reward, not isPass)
	goutil.setActive(petNum, false)
	goutil.setActive(round, stageInfo.minRound > 0)

	txtLevel.text = data.stageName
	txtCost.text = 0

	if stageInfo.minRound > 0 then
		txtRound.text = stageInfo.minRound
	end

	local prizeCfg = {}
	local isFirst = not HonourTowerController.instance:isStageGainFirstPassPrize(self._challengeId, data.stageId)

	prizeCfg = isFirst and string.split(data.firstPrize, "#") or string.split(data.passPrize, "#")

	for i = #prizeCfg + 1, 3 do
		local item = goutil.findChild(rewardList, "rewardItem_" .. i)

		goutil.setActive(item, false)
	end

	for i, v in ipairs(prizeCfg) do
		local item = goutil.findChild(rewardList, "rewardItem_" .. i)
		local itemCon = goutil.findChild(item, "itemCon")
		local tag = goutil.findChild(item, "tag")

		MaterialMgr.resetAll(itemCon)
		MaterialMgr.setCellByCfg(v, itemCon)
		goutil.setActive(tag, isFirst)
		goutil.setActive(item, true)
	end

	singleLine:Layout()
	GameUtil.rmClickHandler(cell.gameObject)
	GameUtil.addClickHandler(cell.gameObject, function()
		if isLock then
			FloatWordMgr.instance:show("请先通关上一关")

			return
		end

		self._selectId = data.stageId

		self:_openForm()
	end)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.skinId))

	if not modelCo then
		printError("lbc---- HonourTowerView:_updateTabCell()   精灵图片为空 skinId = ", data.skinId)

		return
	end

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function HonourTowerView:_clearTabCell(cell)
	local petIcon = goutil.findChild(cell, "pet/petIcon")

	uGuiUtil.clearImage(petIcon)
	GameUtil.rmClickHandler(cell.gameObject)

	local rewardList = goutil.findChild(cell, "reward/rewardList")

	for i = 1, 3 do
		local item = goutil.findChild(rewardList, "rewardItem_" .. i)
		local itemCon = goutil.findChild(item, "itemCon")

		MaterialMgr.resetAll(itemCon)
	end
end

function HonourTowerView:_refreshUi()
	local modelName = "挑战模式"

	self._cfg = HonourTowerConfig.instance:getChallengeCfg(self._challengeId)

	local finalTime = self:_getFinalTime()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(finalTime - ServerTime.now())
	local time = string.format("剩余时间:%d天 %d小时", day, hour)
	local stageLengh = HonourTowerConfig.instance:getStageCfgLenghByChallengeId(self._challengeId)
	local progressStr = string.format("关卡进度:%s/%s", self._info.curStageId, stageLengh)

	self._stagePlanId = self._cfg.stagePlanId
	self._txtLevel.text = string.format("%s-%s", self._cfg.name, modelName)
	self._txtProgress.text = progressStr
	self._txtTime.text = time

	local stageCfg = HonourTowerConfig.instance:getStageCfgs(self._challengeId)

	self._tabList:reloadData(stageCfg)
	self:_refreshInfo()
	self:_setScrollRectPos()
end

function HonourTowerView:_refreshInfo()
	local buffCfg = HonourTowerConfig.instance:getBuffCfgById(self._periodCfg.buffPlanId)
	local path = GameUrl.getExpEventUrl(buffCfg.iconPath)

	uGuiUtil.clearImage(self._petIcon)
	uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, path)

	self._txtTitle.text = buffCfg.name
	self._txtDesc.text = buffCfg.buffDesc
end

function HonourTowerView:_openForm()
	local ids = HonourTowerModel.instance:getRegressChallengeIds()

	HonourTowerController.instance:openTrueOrFalseChallengeForm(self._periodId, self._challengeId, self._selectId)
end

function HonourTowerView:_tipOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "honourtowerview_2")
end

function HonourTowerView:_setScrollRectPos()
	local stageCfg = HonourTowerConfig.instance:getStageCfgs(self._challengeId)
	local rewardCount = #stageCfg
	local totalContentLength = self:_setWorldContentLength(rewardCount)
	local posX = self._info.curStageId * self._worldWidthSpace

	self._progressPrizeScroll.horizontalNormalizedPosition = self:_caculateNormalizedPosition(posX, totalContentLength, goutil.getWidth(self._progressPrizeTrans))
end

function HonourTowerView:_setWorldContentLength(rewardCount)
	local sliderLength = rewardCount * self._worldWidthSpace

	return self._worldSliderStartOffset + sliderLength + self._worldSliderEndOffset
end

function HonourTowerView:_caculateNormalizedPosition(curLength, totalLength, fixedWidth)
	if totalLength <= fixedWidth then
		return 0
	end

	local realTotalLength = totalLength - fixedWidth

	realTotalLength = realTotalLength > 0 and realTotalLength or 1

	local offset = -280
	local result = (curLength + offset) / realTotalLength

	return result <= 1 and result or 1
end

function HonourTowerView:_getFinalTime()
	local regressIds = HonourTowerModel.instance:getRegressChallengeIds()

	if table.indexof(regressIds, self._challengeId) then
		local cfg = HonourTowerConfig.instance:getPeriodCfgById(self._periodId)

		return GameUtil.string2time(cfg.endTime)
	else
		return GameUtil.string2time(self._cfg.endTime)
	end
end

return HonourTowerView
