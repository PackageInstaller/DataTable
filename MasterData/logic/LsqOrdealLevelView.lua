-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luoshiqiordeal/view/LsqOrdealLevelView.lua

module("logic.extensions.luoshiqiordeal.view.LsqOrdealLevelView", package.seeall)

local LsqOrdealLevelView = class("LsqOrdealLevelView", ViewComponent)

function LsqOrdealLevelView:ctor()
	LsqOrdealLevelView.super.ctor(self)
end

function LsqOrdealLevelView:buildUI()
	LsqOrdealLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._root = self:getGo("root")
	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, true)

	self._cell.name = "cell1"

	goutil.addChildToParent(self._cell, self._root)

	for i = 1, 3 do
		local go = goutil.cloneAndSetParent(self._cell, self._root.transform, "cell" .. i + 1)
	end

	self._cellList = {}

	for i = 1, 4 do
		local element = {}

		element.spriteChange = self:getGo(string.format("root/cell%d/icon", i)):GetComponent(ComponentType.UIImageSpriteChange)
		element.txtName = self:getTxt(string.format("root/cell%d/txtName", i))
		element.txtScore = self:getTxt(string.format("root/cell%d/txtScore", i))
		element.tagGo = self:getGo(string.format("root/cell%d/tag", i))
		element.txtTag = self:getTxt(string.format("root/cell%d/tag/txt", i))
		element.btnEnter = self:getBtn(string.format("root/cell%d/btnEnter", i))
		element.lockGo = self:getGo(string.format("root/cell%d/lockTip", i))
		element.txtLock = self:getTxt(string.format("root/cell%d/lockTip/txt", i))
		element.img = self:getGo(string.format("root/cell%d/img", i))
		element.iconRect = self:getGo(string.format("root/cell%d/iconQuad", i)):GetComponent(goutil.Type_RectTransform)
		element.txtNum = self:getTxt(string.format("root/cell%d/txtNum", i))

		table.insert(self._cellList, element)

		local scale = self:_getScale(i)

		Framework.TransformUtil.SetLocalScale(element.iconRect.transform, scale, scale, scale)

		local sideLength = self:_getSideLength(i)

		goutil.setWidth(element.iconRect, sideLength)
		goutil.setHeight(element.iconRect, sideLength)

		local num = i - 1 + 4

		element.txtNum.text = string.format("%d  x  %d", num, num)
	end

	self._txtRemain = self:getTxt("txtRemain")
	self._btnAdd = self:getBtn("btnAdd")
end

function LsqOrdealLevelView:_getScale(index)
	if index == 1 then
		return 1
	elseif index == 2 then
		return 0.8
	elseif index == 3 then
		return 0.66
	else
		return 0.57
	end
end

function LsqOrdealLevelView:_getSideLength(index)
	if index == 1 then
		return 192
	elseif index == 2 then
		return 240
	elseif index == 3 then
		return 288
	else
		return 336
	end
end

function LsqOrdealLevelView:bindEvents()
	LsqOrdealLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnTip:AddClickListener(self._onClickTip, self)

	for i = 1, 3 do
		local cell = self._cellList[i]

		cell.btnEnter:AddClickListener(function()
			self:_onClickNormalEnter(i)
		end)
	end

	local crazyCell = self._cellList[4]

	crazyCell.btnEnter:AddClickListener(self._onClickCrazyEnter, self)
end

function LsqOrdealLevelView:unbindEvents()
	LsqOrdealLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnTip:RemoveClickListener()

	for i = 1, 3 do
		local cell = self._cellList[i]

		cell.btnEnter:RemoveClickListener()
	end

	local crazyCell = self._cellList[4]

	crazyCell.btnEnter:RemoveClickListener()
end

function LsqOrdealLevelView:onEnter()
	LsqOrdealLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.XiaoNuoBirthdayBuyPlayNumRes, self._onBuyGameNum, self)
	self.addGEvent(self, GlobalNotify.PM_XiaoNuoBirthdaySweepNormalGameRes, self._updateLeftGameNum, self)
	self.addGEvent(self, GlobalNotify.PM_XiaoNuoBirthdaySweepCrazyGameRes, self._updateLeftGameNum, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = LuoShiQiOrdealConfig.instance:getActivityCfg(self._activityId)
	self._maxGameNum = self._cfgActivity.freeNum
	self._maxBuyNum = self._cfgActivity.buyNum
	self._isBelongSweep = AnnuityPrivilegeController.instance:isBelongSweep(self._activityId)

	self:_updateNormalCells()
	self:_updateCrazyCell()
	self:_updateLeftGameNum()
end

function LsqOrdealLevelView:onExit()
	LsqOrdealLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.XiaoNuoBirthdayBuyPlayNumRes, self._onBuyGameNum, self)
end

function LsqOrdealLevelView:_onClickClose()
	self:close()
end

function LsqOrdealLevelView:_onClickAdd()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	if curLeftNum > 0 then
		FloatWordMgr.instance:show(lang("lsqordeal_desc1"))

		return
	end

	local curBoughtNum = LuoShiQiOrdealModel.instance:getBuyGameNum()

	if curBoughtNum < self._maxBuyNum then
		local title = lang("tip")
		local matType, id, matNum = MaterialMgr.getMatParams(self._cfgActivity.buyCost)
		local str = langPara("lsqordeal_desc2", "<quad name=%s:%s|icon size=40 width=1 offsetY=-5/>*%d")
		local text = string.format(str, matType, id, matNum)

		local function okFunc()
			XiaoNuoBirthdayGiftAgent.instance:sendPM_XiaoNuoBirthdayBuyPlayNumReq(self._activityId)
		end

		TipsFacade.instance:openPopupWindow(title, text, okFunc, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
	else
		FloatWordMgr.instance:show(lang("nobuynumber"))
	end
end

function LsqOrdealLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "lsqordealmainview_rule_2")
end

function LsqOrdealLevelView:_onClickNormalEnter(diffLv)
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	if curLeftNum > 0 then
		local isCrazy = false
		local maxScore = LuoShiQiOrdealModel.instance:getMaxScoreNormal(diffLv)
		local isHasPassFirst = maxScore > 0

		if self._isBelongSweep and isHasPassFirst then
			local isInitInfo = YearCardModel.instance:isInitInfo()

			if not isInitInfo then
				FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

				return
			end

			local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, 1)

			if sweepResult == GameEnum.ResultCode.Success then
				local descTxt

				local function sureCallBack(view)
					self:_sweepNormalGame(self._activityId, view:getCurTimes(), diffLv, maxScore)
				end

				local function cancelCallBack(view)
					UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId, diffLv)
				end

				local otherCallBack
				local maxCoinNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

				local function updateCoinTxtCallBack(view)
					view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
				end

				local passGetScore = maxScore

				local function updateDescTxtCallBack(view)
					view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", passGetScore * view:getCurTimes())
				end

				local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

				TipsFacade.instance:openPopupCommonCostPopView(curLeftNum, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
			else
				UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId, diffLv)
			end
		else
			UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId, diffLv)
		end
	else
		FloatWordMgr.instance:show(lang("nogamenumber"))
	end
end

function LsqOrdealLevelView:_onClickCrazyEnter()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	if curLeftNum > 0 then
		local isCrazy = true
		local maxStageNum = LuoShiQiOrdealModel.instance:getMaxNumCrazy()
		local isHasPassFirst = maxStageNum > 0

		if self._isBelongSweep and isHasPassFirst then
			local isInitInfo = YearCardModel.instance:isInitInfo()

			if not isInitInfo then
				FloatWordMgr.instance:show("正在读取年费特权信息，请稍后再试")

				return
			end

			local sweepResult = self:getTrySweepGameResultAndTips(false, self._activityId, 1)

			if sweepResult == GameEnum.ResultCode.Success then
				local descTxt

				local function sureCallBack(view)
					self:_sweepCrazyGame(self._activityId, maxStageNum, view:getCurTimes())
				end

				local function cancelCallBack(view)
					UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId)
				end

				local otherCallBack
				local maxCoinNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

				local function updateCoinTxtCallBack(view)
					view:getTxtCoin().text = string.format("游戏次数：%s/%s", view:getCurCoinNum(), maxCoinNum)
				end

				local passGetScore = LuoShiQiOrdealController.instance:getMaxScoreCrazy(self._activityId)

				local function updateDescTxtCallBack(view)
					view:getTxtDesc().text = string.format("您已首通完毕，是否扫荡获得进度？\n当前可获得积分：<color=#0068b7>%s</color>", passGetScore * view:getCurTimes())
				end

				local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

				TipsFacade.instance:openPopupCommonCostPopView(curLeftNum, 1, "开始游戏", "扫荡", "直接开始", descTxt, sureCallBack, cancelCallBack, otherCallBack, updateCoinTxtCallBack, updateDescTxtCallBack)
			else
				UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId)
			end
		else
			UIStateManager.instance:push(ViewName.OneTouchDrawView, isCrazy, self._activityId)
		end
	else
		FloatWordMgr.instance:show(lang("nogamenumber"))
	end
end

function LsqOrdealLevelView:getTrySweepGameResultAndTips(isNeedTips, activityId, times)
	local result = GameEnum.ResultCode.Success
	local tips = ""

	if result == GameEnum.ResultCode.Success then
		local isCanSweep = AnnuityPrivilegeController.instance:isCanSweep(activityId)

		if not isCanSweep then
			result = GameEnum.ResultCode.Error
		end
	end

	if result == GameEnum.ResultCode.Success then
		local leftTimes = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

		if leftTimes <= 0 or leftTimes < times then
			result = GameEnum.ResultCode.Error
			tips = "次数不足"
		end
	end

	if isNeedTips then
		FloatWordMgr.instance:show(tips)
	end

	return result
end

function LsqOrdealLevelView:_sweepNormalGame(activityId, times, diffLv, score)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	LuoShiQiOrdealController.instance:sendPM_XiaoNuoBirthdaySweepNormalGameReq(activityId, diffLv, score, times)
end

function LsqOrdealLevelView:_sweepCrazyGame(activityId, stageNum, times)
	local result = self:getTrySweepGameResultAndTips(true, activityId, times)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	LuoShiQiOrdealController.instance:sendPM_XiaoNuoBirthdaySweepCrazyGameReq(activityId, stageNum, times)
end

function LsqOrdealLevelView:_onBuyGameNum()
	self:_updateLeftGameNum()
end

function LsqOrdealLevelView:_updateLeftGameNum()
	local curLeftNum = LuoShiQiOrdealModel.instance:getLeftGameNum(self._maxGameNum)

	self._txtRemain.text = langPara("lsqordeal_desc5", curLeftNum, self._maxGameNum)
end

function LsqOrdealLevelView:_updateNormalCells()
	for i = 1, 3 do
		local cfg = LuoShiQiOrdealConfig.instance:getNormalGameCfg(self._activityId, i)
		local element = self._cellList[i]

		element.spriteChange:SetState(i - 1)
		element.lockGo:SetActive(false)

		element.txtName.text = self:_getName(i)
		element.txtScore.text = langPara("lsqordeal_desc8", Mathf.Round(cfg.maxScore / 2))
		element.txtTag.text = langPara("lsqordeal_desc9", cfg.doubleSecond)

		element.tagGo:SetActive(true)
	end
end

function LsqOrdealLevelView:_updateCrazyCell()
	local cfg = LuoShiQiOrdealConfig.instance:getCrazyGameCfg(self._activityId)
	local index = 4
	local element = self._cellList[index]

	element.img:SetActive(false)
	element.spriteChange:SetState(index - 1)

	element.txtName.text = self:_getName(index)
	element.txtScore.text = ""

	element.tagGo:SetActive(false)

	local targetTimestamp = GameUtil.string2time(cfg.startTime)
	local isOpen = targetTimestamp <= ServerTime.now()

	element.lockGo:SetActive(not isOpen)

	if not isOpen then
		local date = GameUtil.time2date(targetTimestamp)

		element.txtLock.text = string.format("%04d.%02d.%02d 5:00 %s", date.year, date.month, date.day, lang("unlock"))
	end
end

function LsqOrdealLevelView:_getName(index)
	if index == 1 then
		return lang("lsqordeal_desc10")
	elseif index == 2 then
		return lang("lsqordeal_desc11")
	elseif index == 3 then
		return lang("lsqordeal_desc12")
	else
		return lang("lsqordeal_desc13")
	end
end

return LsqOrdealLevelView
