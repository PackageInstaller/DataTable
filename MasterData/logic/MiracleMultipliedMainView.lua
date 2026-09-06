-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclemultiplied/view/MiracleMultipliedMainView.lua

module("logic.extensions.miraclemultiplied.view.MiracleMultipliedMainView", package.seeall)

local MiracleMultipliedMainView = class("MiracleMultipliedMainView", ViewComponent)

function MiracleMultipliedMainView:ctor()
	MiracleMultipliedMainView.super.ctor(self)

	self._prizeScrollListDic = {}
end

function MiracleMultipliedMainView:buildUI()
	MiracleMultipliedMainView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = goutil.findChildTextComponent(self.mainGO, "txtOpenTime/txt")
	self._txtLeftTimes = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtLeftTimes")
	self._txtActCount = goutil.findChildTextComponent(self.mainGO, "ruleCol/txtActCount")

	local petScrView = goutil.findChild(self.mainGO, "ruleCol/petCol/scrView")
	local petScrCell = goutil.findChild(self.mainGO, "ruleCol/petCol/scrCell")

	self._petScrollerList = ScrollerList.create(petScrView, petScrCell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))

	local collectScrView = goutil.findChild(self.mainGO, "collectCol/scrView")
	local collectScrCell = goutil.findChild(self.mainGO, "collectCol/scrCell")

	self._collectScrollerList = ScrollerList.create(collectScrView, collectScrCell, GameUtil.handler(self._updateCollectCell, self), GameUtil.handler(self._clearCollectCell, self))
end

function MiracleMultipliedMainView:bindEvents()
	MiracleMultipliedMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function MiracleMultipliedMainView:unbindEvents()
	MiracleMultipliedMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function MiracleMultipliedMainView:onEnter()
	MiracleMultipliedMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = MiracleMultipliedController.instance:getActivityId()
	end

	self._activityType = MiracleMultipliedController.instance:getActivityType()

	local isInTime = MiracleMultipliedController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._actData = MiracleMultipliedConfig.instance:getActData(self._activityId)
	self._collectCfg = MiracleMultipliedConfig.instance:getCollectCfg(self._activityId)
	self._miracleMultipliedMo = MiracleMultipliedController.instance:getMiracleMultipliedMo(self._activityId)

	if self._txtOpenTime then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	self.addGEvent(self, GlobalNotify.HandlePM_MiracleMultipliedGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MiracleMultipliedUnlockRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_MiracleMultipliedGainPrizeRes, self._onUpdate, self)
	MiracleMultipliedController.instance:sendPM_MiracleMultipliedGetInfoReq(self._activityId)
end

function MiracleMultipliedMainView:onExit()
	MiracleMultipliedMainView.super.onExit(self)
	self:_onClear()
end

function MiracleMultipliedMainView:_onUpdate()
	self._raceActCount = self._miracleMultipliedMo:getRaceActCount()
	self._raceCount = self._miracleMultipliedMo:getRaceCount()
	self._unlockCount = self._miracleMultipliedMo:getUnlockCountInCollect()

	self:_onUpdateRuleCol()
	self:_onUpdateCollectCol()
end

function MiracleMultipliedMainView:_onClear()
	self:_onClearRuleCol()
	self:_onClearCollectCol()
end

function MiracleMultipliedMainView:_onUpdateRuleCol()
	local raceIdList = self._miracleMultipliedMo:getRaceIdList()

	self._petScrollerList:reloadData(raceIdList)

	local left = Mathf.Max(self._raceActCount - self._unlockCount, 0)

	self._txtLeftTimes.text = string.format("当前剩余次数：%s", left)
	self._txtActCount.text = string.format("已累计激活：%s", self._unlockCount)
end

function MiracleMultipliedMainView:_onClearRuleCol()
	self._petScrollerList:dispose()
end

function MiracleMultipliedMainView:_updatePetCell(view, cell, raceId, tag)
	local data = MiracleMultipliedConfig.instance:getRaceData(self._activityId, raceId)
	local isHave = HandbookModel.instance:isHasPet(raceId)
	local skinId = raceId
	local mainGo = cell.gameObject
	local pet = goutil.findChild(mainGo, "pet")
	local con = goutil.findChild(mainGo, "pet/mask/con")

	if raceId > 0 then
		MaterialMgr.setIcon(con, MatType.Pet, skinId, nil, nil)
	else
		MaterialMgr.clearIcon(con)
	end

	GameUtil.SetGray(con, not isHave)
	GameUtil.addClickHandler(pet, function()
		TipsFacade.instance:openItemSourceView(string.format("%s:%s", MatType.Pet, raceId))
	end)
end

function MiracleMultipliedMainView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local con = goutil.findChild(mainGo, "pet/mask/con")

	MaterialMgr.clearIcon(con)
end

function MiracleMultipliedMainView:_onUpdateCollectCol()
	self._collectScrollerList:reloadData(self._collectCfg)
end

function MiracleMultipliedMainView:_onClearCollectCol()
	self._collectScrollerList:dispose()
end

function MiracleMultipliedMainView:_updateCollectCell(view, cell, data, tag)
	local collectId = data.collectId
	local unlockResult, unlockTips = self:getTryUnlockCollectResultAndTips(self._activityId, collectId)
	local prizeResult, prizeTips = self:getTryGainPrizeResultAndTips(self._activityId, collectId)
	local isUnlock = self._miracleMultipliedMo:isUnlockInCollect(collectId)
	local prizeStrArr = self._miracleMultipliedMo:getPrizeArrInCollect(collectId)
	local isHavePrize = #prizeStrArr > 0
	local isCanGainPrize = prizeResult == GameEnum.ResultCode.Success
	local isCanUnlock = unlockResult == GameEnum.ResultCode.Success
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local txtTime = goutil.findChildTextComponent(mainGo, "txtTime")
	local imgPoseter = goutil.findChild(mainGo, "poseter/img")
	local btnGo = goutil.findChild(mainGo, "btnGo")
	local btnGain = goutil.findChild(mainGo, "btnGain")
	local redBtnGain = goutil.findChild(mainGo, "btnGain/redpoint")
	local btnUnlock = goutil.findChild(mainGo, "btnUnlock")
	local redBtnUnlock = goutil.findChild(mainGo, "btnUnlock/redpoint")
	local prizeScrView = goutil.findChild(mainGo, "prizeCol/scrView")
	local prizeScrCell = goutil.findChild(mainGo, "prizeCol/scrCell")
	local imgEmpty = goutil.findChild(mainGo, "prizeCol/imgEmpty")
	local startT = GameUtil.formatTimeString("%m.%d", data.openTime)
	local endT = GameUtil.formatTimeString("%m.%d", data.endTime)

	txtTime.text = string.format("%s-%s", startT, endT)
	txtName.text = data.name

	uGuiUtil.setSpriteToImage(imgPoseter, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(data.poster))

	if not self._prizeScrollListDic[mainGo] then
		local scrollList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))

		self._prizeScrollListDic[mainGo] = self._prizeScrollListDic[mainGo]

		self._prizeScrollListDic[mainGo]:reloadData(prizeStrArr)
		GameUtil.SetActive(btnGo, isUnlock)
		GameUtil.SetActive(btnUnlock, not isUnlock)
		GameUtil.SetActive(imgEmpty, not isHavePrize)
		GameUtil.SetActive(redBtnGain, isCanGainPrize)
		GameUtil.SetActive(redBtnUnlock, isCanUnlock)
		GameUtil.SetGray(btnGain, not isCanGainPrize)
		GameUtil.SetGray(btnUnlock, not isCanUnlock)
		GameUtil.addClickHandler(btnGo, function()
			GotoMgr.gotoByString(data.jumpStr)
		end)
		GameUtil.addClickHandler(btnUnlock, function()
			local result, tips = self:getTryUnlockCollectResultAndTips(self._activityId, collectId)

			if result ~= GameEnum.ResultCode.Success then
				FloatWordMgr.instance:show(tips)

				return
			end

			local tipsContent = "是否确认开启该活动的翻倍奖励？"

			local function okFunc()
				MiracleMultipliedController.instance:sendPM_MiracleMultipliedUnlockReq(self._activityId, collectId)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
		end)
		GameUtil.addClickHandler(btnGain, function()
			local result, tips = self:getTryGainPrizeResultAndTips(self._activityId, collectId)

			if result ~= GameEnum.ResultCode.Success then
				FloatWordMgr.instance:show(tips)

				return
			end

			MiracleMultipliedController.instance:sendPM_MiracleMultipliedGainPrizeReq(self._activityId, collectId)
		end)
	end
end

function MiracleMultipliedMainView:_clearCollectCell(cell)
	local mainGo = cell.gameObject
	local imgPoseter = goutil.findChild(mainGo, "poseter/img")

	uGuiUtil.clearImage(imgPoseter)

	if self._prizeScrollListDic[mainGo] then
		self._prizeScrollListDic[mainGo]:dispose()
	end
end

function MiracleMultipliedMainView:_updatePrizeCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item)
end

function MiracleMultipliedMainView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

function MiracleMultipliedMainView:getTryUnlockCollectResultAndTips(activityId, collectId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = MiracleMultipliedController.instance:getMiracleMultipliedMo(activityId)

	if not MiracleMultipliedController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开启期限内"
	elseif mo:isUnlockInCollect(collectId) then
		result = GameEnum.ResultCode.Error
		tips = "已解锁"
	elseif not mo:isEnoughTimesToUnlockInCollect() then
		result = GameEnum.ResultCode.Error
		tips = "次数不足"
	end

	return result, tips
end

function MiracleMultipliedMainView:getTryGainPrizeResultAndTips(activityId, collectId)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local mo = MiracleMultipliedController.instance:getMiracleMultipliedMo(activityId)

	if not MiracleMultipliedController.instance:isInActivityTime(activityId) then
		result = GameEnum.ResultCode.Error
		tips = "不在开启期限内"
	elseif not mo:isUnlockInCollect(collectId) then
		result = GameEnum.ResultCode.Error
		tips = "未解锁"
	elseif #mo:getPrizeArrInCollect(collectId) <= 0 then
		result = GameEnum.ResultCode.Error
		tips = "没有可领取奖励"
	end

	return result, tips
end

function MiracleMultipliedMainView:_onClickBtnTip()
	local key = self._actData.ruleKey

	TipsFacade.instance:openRulesView(key)
end

return MiracleMultipliedMainView
