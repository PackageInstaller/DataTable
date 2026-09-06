-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/view/OriMatGameStageView.lua

module("logic.extensions.orimatgame.view.OriMatGameStageView", package.seeall)

local OriMatGameStageView = class("OriMatGameStageView", ViewComponent)
local lastStageId = 0

function OriMatGameStageView:buildUI()
	OriMatGameStageView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTitle = self:getTxt("title/txt")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnSkillTree = self:getGo("jumpBtnCol/btnSkillTree")
	self._redPointSkillTree = self:getGo("jumpBtnCol/btnSkillTree/redPoint")
	self._txtCountReset = self:getTxt("btnReset/count/txt")
	self._btnReset = self:getGo("btnReset/btn")
	self._btnResetGo = self:getGo("btnReset")
	self._redBtnReset = self:getGo("btnReset/btn/redPoint")
	self._btnWeapon = self:getGo("jumpBtnCol/btnWeapon")
	self._btnReward = self:getGo("jumpBtnCol/btnReward")
	self._redPointReward = self:getGo("jumpBtnCol/btnReward/redPoint")
	self._btnShop = self:getGo("jumpBtnCol/btnShop")

	local stageScrView = self:getGo("stageCol/scrView")
	local stageScrCell = self:getGo("stageCol/scrCell")

	self._stageScrollerList = ScrollerList.create(stageScrView, stageScrCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))

	self._stageScrollerList:setCenterMode(true)

	self._tipsGo = self:getGo("tips")
	self._txtTips = self:getTxt("tips/txtTips")
end

function OriMatGameStageView:bindEvents()
	OriMatGameStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkillTree, self._onClickBtnSkillTree, self)
	GameUtil.addClickHandler(self._btnWeapon, self._onClickBtnWeapon, self)
	GameUtil.addClickHandler(self._btnReward, self._onClickBtnReward, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickBtnShop, self)
	GameUtil.addClickHandler(self._btnReset, self._onClickBtnReset, self)
end

function OriMatGameStageView:unbindEvents()
	OriMatGameStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkillTree)
	GameUtil.rmClickHandler(self._btnWeapon)
	GameUtil.rmClickHandler(self._btnReward)
	GameUtil.rmClickHandler(self._btnShop)
	GameUtil.rmClickHandler(self._btnReset)
end

function OriMatGameStageView:onEnter()
	OriMatGameStageView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._newestSeasonId = OriMatGameController.instance:getSeasonId()

	local isInTime = OriMatGameController.instance:isInTime(self._newestSeasonId)

	if not isInTime then
		FloatWordMgr.instance:show("活动不在开启期限内")
		self:close()

		return
	end

	self._seasonId = OriMatGameController.instance:getCurSeasonId()
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.OriMatGameChangeSeason, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginMaterialGameReOpenSeasonRes, self._onUpdate, self)
	OriMatGameController.instance:sendPM_OriginMaterialGameInfoReq(self._seasonId)
	OriMatGameController.instance:sendPM_OriginMaterialGameAllSeasonReq()
	RedPointController.instance:regRedPoint(self._redPointReward, RedPointModel.ID_ORIMATGAMESEASONPRIZE)
	RedPointController.instance:regRedPoint(self._redPointSkillTree, RedPointModel.ID_ORIMATGAMETALENTTREE)
	RedPointController.instance:regRedPoint(self._redBtnReset, RedPointModel.ID_ORIMATGAMEALLSEASONPRIZE)
	self:_onUpdate()
end

function OriMatGameStageView:onExit()
	OriMatGameStageView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._redPointReward)
	RedPointController.instance:unregRedPoint(self._redPointSkillTree)
	RedPointController.instance:unregRedPoint(self._redBtnReset)
	self._stageScrollerList:dispose()
end

function OriMatGameStageView:_onUpdate()
	self._seasonId = OriMatGameController.instance:getCurSeasonId()
	self._subMo = OriMatGameController.instance:getSubMo(self._seasonId)

	local startT, endT = OriMatGameController.instance:getSeasonStartEndTime(self._newestSeasonId)
	local startStamp = startT and GameUtil.string2time(startT) or 0
	local endStamp = endT and GameUtil.string2time(endT) or 0

	self._txtOpenTime.text = string.format("赛季时间：%s", GameUtil.getFormatTimeByStamp(startStamp, endStamp))

	local seasonData = OriMatGameConfig.instance:getSeasonData(self._seasonId)

	if seasonData then
		if not seasonData.stagePlanId then
			local stagePlanId = 0

			self._stageCfgList = OriMatGameConfig.instance:getStageCfgs(stagePlanId) or {}

			self._stageScrollerList:reloadData(self._stageCfgList)

			if lastStageId > 0 then
				for index, data in ipairs(self._stageCfgList) do
					if data.stageId == lastStageId then
						lastStageId = 0

						self._stageScrollerList:MoveCellToCenter(index - 1)

						break
					end
				end
			end

			self._txtTitle.text = string.format("泰坦试炼 S%s赛季", self._seasonId)

			local newestSeasonData = OriMatGameConfig.instance:getSeasonData(self._newestSeasonId)

			if newestSeasonData then
				if not newestSeasonData.reOpenNum then
					local reOpenNum = 0

					GameUtil.SetActive(self._btnResetGo, reOpenNum > 0)

					local newesetSubMo = OriMatGameController.instance:getSubMo(self._newestSeasonId)
					local cur = newesetSubMo:getReOpenNum()
					local max = newesetSubMo:getTotalReOpenTimes()
					local left = newesetSubMo:getLeftReOpenTimes()

					self._txtCountReset.text = string.format("%s/%s", left, max)

					local isNewHand = NewhandwelfareModel.instance:isNewHandPlayer()
					local isReturn = RecallTaskModel.instance:isGetActivityOpen(false)
					local showTips = isNewHand or isReturn

					GameUtil.SetActive(self._tipsGo, showTips)

					if isNewHand then
						local times = NewhandwelfareConfig.instance:getCommonValue("ORIGIN_MATERIAL_REOPEN_TIMES")

						self._txtTips.text = langPara("新手特权生效中\n回溯次数+{0}", times)
					elseif isReturn then
						local actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
						local mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(actiInfo.actId, 2)
						local privilegeCfg = PlayerReturnConfig.instance:getReturnPlgeCfgs(mainCfg.planId, 7)
						local times = checknumber(privilegeCfg.param)

						self._txtTips.text = langPara("回归特权生效中\n回溯次数+{0}", times)
					end
				end
			end
		end
	end
end

function OriMatGameStageView:_updateStageCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local stageId = data.stageId
	local wave = self._subMo:getStageWaveById(stageId)
	local isInTime = self._subMo:isInTimeOfStage(stageId)
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txt")
	local txtOpenTime = goutil.findChildTextComponent(mainGo, "openTime/txt")
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local openTimeGo = goutil.findChild(mainGo, "openTime")
	local btnStart = goutil.findChild(mainGo, "btnStart")

	GameUtil.getUIImageSpriteChange(mainGo):ChangeSprite(data.spriteName)

	txtScore.text = string.format("最佳记录：%s波", wave)
	txtName.text = data.name

	local startTime = data.startTime

	if not isInTime and not string.nilorempty(startTime) then
		local date = GameUtil.string2date(startTime)

		txtOpenTime.text = string.format("%d.%02d.%02d %02d:%02d后开启", date.year, date.month, date.day, date.hour, date.min)
	else
		txtOpenTime.text = ""
	end

	GameUtil.SetActive(btnStart, isInTime)
	GameUtil.SetActive(openTimeGo, not isInTime)
	GameUtil.addClickHandler(btnStart, function()
		if not isInTime then
			FloatWordMgr.instance:show("未开放")

			return
		end

		lastStageId = stageId

		UIStateManager.instance:push(ViewName.OriMatGameWeaponSelectView, self._seasonId, stageId)
	end)
end

function OriMatGameStageView:_clearStageCell(cell)
	local mainGo = cell.gameObject
	local btnStart = goutil.findChild(mainGo, "btnStart")

	GameUtil.rmClickHandler(btnStart)
end

function OriMatGameStageView:_onClickBtnTip()
	local key = OriMatGameConfig.instance:getCommonValue("RULEKEY_MAIN", false)

	TipsFacade.instance:openRulesView(key)
end

function OriMatGameStageView:_onClickBtnSkillTree()
	UIStateManager.instance:push(ViewName.OriMatGameSkillTreeView, self._seasonId)
end

function OriMatGameStageView:_onClickBtnWeapon()
	UIStateManager.instance:push(ViewName.OriMatGameWeaponView, self._seasonId)
end

function OriMatGameStageView:_onClickBtnReward()
	UIStateManager.instance:push(ViewName.OriMatGameSeasonPrizeView, self._seasonId)
end

function OriMatGameStageView:_onClickBtnShop()
	local key = OriMatGameConfig.instance:getCommonValue("SHOP_JUMP", false)

	GotoMgr.gotoByString(key)
end

function OriMatGameStageView:_onClickBtnReset()
	UIStateManager.instance:push(ViewName.OrimatGameResetSeasonView)
end

return OriMatGameStageView
