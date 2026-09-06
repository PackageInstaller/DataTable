-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/linkagelottery/view/LinkageLotteryView.lua

module("logic.extensions.linkagelottery.view.LinkageLotteryView", package.seeall)

local LinkageLotteryView = class("LinkageLotteryView", ViewComponent)

function LinkageLotteryView:ctor()
	LinkageLotteryView.super.ctor(self)

	self._numberLoop = NumberLoop.New()
end

function LinkageLotteryView:buildUI()
	LinkageLotteryView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtNum = self:getTxt("cost/txtNum")
	self._iconGo = self:getGo("cost/txtNum/icon")
	self._txtTime = self:getTxt("time/txtTime")
	self._btnAdd = self:getBtn("cost/txtNum/btnAdd")
	self._btnStart = self:getBtn("btnStart")
	self._btnTask = self:getBtn("btnTask")
	self._btnGo = self:getBtn("btnGo")
	self._rootGo = self:getGo("rewardRoot/root")
	self._recordPos = self._rootGo:GetComponent(typeof(TestRecordPos))
	self._cell = self:getGo("rewardRoot/cell")
	self._cellBig = self:getGo("rewardRoot/cellBig")
	self._maskGo = self:getGo("mask")

	goutil.setActive(self._cell, false)
	goutil.setActive(self._cellBig, false)

	self._cellGoList = {}
	self._btnGo2 = self:getBtn("btnGo2")
	self._headIcon = self:getGo("btnGo2/img")
	self._tipPos = self:getGo("pos")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._rare = self:getGo("petInfo/rare")
	self._txtName = self:getTxt("petInfo/txtName")
end

function LinkageLotteryView:bindEvents()
	LinkageLotteryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnTask:AddClickListener(self._onClickTask, self)
	self._btnGo:AddClickListener(self._onClickGo, self)
	self._btnGo2:AddClickListener(self._onClickGo2, self)
	self._btnInfo:AddClickListener(self._onClickInfo, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function LinkageLotteryView:unbindEvents()
	LinkageLotteryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnTask:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self._btnGo2:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function LinkageLotteryView:onEnter()
	LinkageLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LinkageLotterygetInfoRes, self._onLinkageLotterygetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LinkageLotteryRandRes, self._onLinkageLotteryRandRes, self)
	LinkageLotteryModel.instance:resetTemp()
	self:_initBtnGo()

	self._activityId = LinkageLotteryModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.LINKAGE_LOTTERY, self._activityId)

	if not isInTime then
		self:_showPopupView()

		return
	end

	self._cfgActivity = LinkageLotteryConfig.instance:getActivityCfg(self._activityId)
	self._raceId = 14001
	self._skinId = 1400101

	self:_initView()
	settimer(0, self._onUpdate, self)
	LinkageLotteryAgent.instance:sendPM_LinkageLotterygetInfoReq(self._activityId)
end

function LinkageLotteryView:onExit()
	LinkageLotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LinkageLotterygetInfoRes, self._onLinkageLotterygetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LinkageLotteryRandRes, self._onLinkageLotteryRandRes, self)
	self:_recycleGos()
	removetimer(self._onUpdate, self)
	self._numberLoop:stop()
	MaterialMgr.clearIcon(self._headIcon)
	MaterialMgr.resetAll(self._rare)
end

function LinkageLotteryView:_onClickClose()
	self:close()
end

function LinkageLotteryView:_onClickAdd()
	local targetMat = self._cfgActivity.randDec
	local costMat = LinkageLotteryController.instance:getCostItemForBuy(self._cfgActivity.buyPlanId)
	local maxNum = LinkageLotteryController.instance:getMaxPrizeCount(self._cfgActivity.lotteryPlanId)
	local getNum = LinkageLotteryModel.instance:hasGetPrizeCount()
	local curNum = MaterialMgr.getMatCount(self._cfgActivity.randDec)
	local leftNum = maxNum - getNum - curNum

	printInfo("test _onClickAdd", maxNum, getNum, curNum, leftNum)

	if leftNum > 0 then
		local maxBuyNumTxt = langPara("最多可购买%s个", leftNum)

		TipsFacade.instance:openPopupCostManyView(targetMat, costMat, leftNum, maxBuyNumTxt, nil, function(count)
			LinkageLotteryAgent.instance:sendPM_LinkageLotteryBuyLotteryReq(self._activityId, count)
		end)
	else
		FloatWordMgr.instance:show("抽奖券充足，无需购买")
	end
end

function LinkageLotteryView:_onClickStart()
	local maxNum = LinkageLotteryController.instance:getMaxPrizeCount(self._cfgActivity.lotteryPlanId)
	local getedNum = LinkageLotteryModel.instance:hasGetPrizeCount()

	if maxNum <= getedNum then
		FloatWordMgr.instance:show("全部抽取完成")

		return
	end

	local curNum = MaterialMgr.getMatCount(self._cfgActivity.randDec)

	if curNum == 0 then
		FloatWordMgr.instance:show("无抽奖券")

		return
	end

	self._lotteryIdList = LinkageLotteryController.instance:getNotHaveLotteryIdList(self._cfgActivity.lotteryPlanId)

	LinkageLotteryAgent.instance:sendPM_LinkageLotteryRandReq(self._activityId)
end

function LinkageLotteryView:_onClickTask()
	UIStateManager.instance:push(ViewName.LinkageLotteryTaskView, self._activityId)
end

function LinkageLotteryView:_onClickGo()
	local textList = self._cfgActivity.text
	local nameList = self._cfgActivity.caption

	if #textList < #nameList then
		if not #textList then
			local count = #nameList
			local list = {}

			for i = 1, count do
				local item = {}

				item.url = string.format("ui/bigbg/bonus/%s.png", nameList[i])
				item.desc = textList[i]

				table.insert(list, item)
			end

			TipsFacade.instance:openImageRuleView(list)
		end
	end
end

function LinkageLotteryView:_onClickGo2()
	GotoMgr.gotoByString(self._cfgActivity.jumpTo)
end

function LinkageLotteryView:_onClickInfo()
	if self._skinId then
		PetbookController.instance:openSkinViewNoSetAttr(self._skinId)

		return
	end

	if self._raceId then
		PetbookController.instance:openPetinfoView(self._raceId)
	end
end

function LinkageLotteryView:_onClickSkill()
	if self._raceId and self._skinId then
		PetbookController.instance:previewBattle(self._raceId, self._skinId)
	end
end

function LinkageLotteryView:_onLinkageLotterygetInfoRes()
	self:_updateRewardCells()
end

function LinkageLotteryView:_onLinkageLotteryRandRes()
	self:_playRewardAnimation()
end

function LinkageLotteryView:_showPopupView()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function LinkageLotteryView:_initView()
	self:_initTime()
	self:_initPetInfo()
	self:_initHeadIcon()
	self:_setGoldBarCon(self._cfgActivity.randDec)
	self:_initCost()
	self:_initRewardCells()
	goutil.setActive(self._maskGo, false)
end

function LinkageLotteryView:_setGoldBarCon(cost)
	local matMo = string.splitToNumber(cost, ":")
	local name = matMo[1] .. ":" .. matMo[2]
	local objList = {
		{
			showAdd = true,
			id = name,
			showAddCallBack = function()
				CommonTipsMgr.instance:openMaterialTips(self._tipPos, matMo[1], matMo[2], 0)
			end
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
end

function LinkageLotteryView:_initTime()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.LINKAGE_LOTTERY, self._activityId)
	local startDate = GameUtil.time2date(startTimestamp)
	local endDate = GameUtil.time2date(endTimestamp)

	self._txtTime.text = string.format(lang("activitytime") .. "：%04d.%02d.%02d - %04d.%02d.%02d", startDate.year, startDate.month, startDate.day, endDate.year, endDate.month, endDate.day)
end

function LinkageLotteryView:_initCost()
	local list = string.splitToNumber(self._cfgActivity.randDec, ":")
	local matType = list[1]
	local id = list[2]

	MaterialMgr.setIcon(self._iconGo, matType, id)

	self._txtNum.text = "x" .. self._cfgActivity.randDecNum
end

function LinkageLotteryView:_getCellGo()
	if #self._cellGoList > 0 then
		return table.remove(self._cellGoList)
	else
		return (goutil.cloneAndSetParent(self._cell, self._rootGo.transform, "cell"))
	end
end

function LinkageLotteryView:_recycleGos()
	if self._cellList then
		for i, v in ipairs(self._cellList) do
			if not v:isBigPrize() then
				local go = v:getMainGo()

				goutil.setActive(go, false)
				table.insert(self._cellGoList, go)
			end

			v:reset()
		end

		table.clear(self._cellList)
	end
end

function LinkageLotteryView:_initRewardCells()
	local cfgList = LinkageLotteryConfig.instance:getLotteryCfgList(self._cfgActivity.lotteryPlanId)
	local count = #cfgList

	self._cellList = {}

	for i = 1, count do
		local go

		if cfgList[i].isBigPrize == 1 then
			go = self._cellBig
			go.name = "cellBig" .. i

			goutil.addChildToParent(go, self._rootGo)
		else
			go = self:_getCellGo()
			go.name = "cell" .. i
		end

		goutil.setActive(go, true)
		go.transform:SetAsLastSibling()

		local cls = GameUtil.AddLuaOnce(go, LinkageLotteryCell)
		local data = {}

		data.lotteryId = cfgList[i].lotteryId
		data.prize = cfgList[i].prize
		data.isGeted = LinkageLotteryModel.instance:isGetedReward(cfgList.lotteryId)
		data.isBigPrize = cfgList[i].isBigPrize

		cls:updateCell(data)
		table.insert(self._cellList, cls)
	end

	self._recordPos:LoadPlan(0)
end

function LinkageLotteryView:_updateRewardCells()
	for i, v in ipairs(self._cellList) do
		local isGeted = LinkageLotteryModel.instance:isGetedReward(v:getLotteryId())

		v:updateGetState(isGeted)
	end
end

function LinkageLotteryView:_showPopupReward()
	local lotteryId = LinkageLotteryModel.instance:getRandomLotteryId()
	local changeSetId = LinkageLotteryModel.instance:getChangeSetId()

	MaterialController.instance:showChangeSetInTemp(changeSetId)
end

function LinkageLotteryView:_updateSelectPos(lotteryId)
	for i, v in ipairs(self._cellList) do
		v:setSelect(lotteryId)
	end
end

function LinkageLotteryView:_onUpdate()
	if self._numberLoop:isPlaying() then
		self:_updateSelectPos(self:_getLotteryIdByCurNum(self._numberLoop:getCurNum()))
	end
end

function LinkageLotteryView:_playRewardAnimation()
	math.randomseed(os.time())

	local lotteryIdCount = #self._lotteryIdList

	if lotteryIdCount == 0 then
		printInfo("抽奖完成")

		return
	end

	local count = #self._cellList
	local param = {}

	param.startNum = 1
	param.endNum = lotteryIdCount
	param.targetNum = self:_getNumByLotteryId(LinkageLotteryModel.instance:getRandomLotteryId())
	param.loopNum = 6 + (count - lotteryIdCount)
	param.duration = lotteryIdCount > 1 and 5 or 0.5

	function param.onCompleteCallback()
		self:_updateRewardCells()
		self:_showPopupReward()
		goutil.setActive(self._maskGo, false)
	end

	self._numberLoop:initParam(param)
	self._numberLoop:play()
	goutil.setActive(self._maskGo, true)
	self:_updateSelectPos(self:_getLotteryIdByCurNum(self._numberLoop:getCurNum()))
end

function LinkageLotteryView:_getLotteryIdByCurNum(curNum)
	return self._lotteryIdList[curNum]
end

function LinkageLotteryView:_getNumByLotteryId(lotteryId)
	local num = 1

	for i, v in ipairs(self._lotteryIdList) do
		if v == lotteryId then
			num = i

			break
		end
	end

	return num
end

function LinkageLotteryView:_initHeadIcon()
	MaterialMgr.setIcon(self._headIcon, MatType.PET_SKIN, self._skinId)
end

function LinkageLotteryView:_initPetInfo()
	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, self._skinId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, self._skinId, self._rare)
end

function LinkageLotteryView:_initBtnGo()
	goutil.setActive(self._btnGo.gameObject, SDKManager.isOfficial())
end

return LinkageLotteryView
