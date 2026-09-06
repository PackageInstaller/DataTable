-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xinxiyamirror/view/XinxiyaMirrorView.lua

module("logic.extensions.xinxiyamirror.view.XinxiyaMirrorView", package.seeall)

local XinxiyaMirrorView = class("XinxiyaMirrorView", ViewComponent)

function XinxiyaMirrorView:ctor()
	XinxiyaMirrorView.super.ctor(self)

	self._battleItemList = nil
	self._battleInfoList = nil
	self._matDailyLimit = nil
	self._mirrorBaseInfo = nil
	self._choStageIndex = nil
	self._buffAllCount = nil
	self._planId = nil
	self._isAllPass = nil
	self._isActivityEnd = nil
end

function XinxiyaMirrorView:bindEvents()
	XinxiyaMirrorView.super.bindEvents(self)
	self._closeBtn:AddClickListener(function()
		local mirrorCfg = XinxiyaMirrorConfig.instance:getOpenTimeCfg(self._actId)
		local name = ViewName.ActivityMoYanView

		if mirrorCfg and not string.nilorempty(mirrorCfg.mainView) then
			name = mirrorCfg.mainView
		end

		self:close()
		ViewMgr.instance:open(name)
	end, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "xinxiyamirror")
	end, self)
	self._exchangeBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.XinxiyaShop)
	end, self)
	self._rankBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		UIStateManager.instance:push(ViewName.Rank, GameEnum.RankType.Mirror_Rank)
	end, self)
	self._blessBtn:AddClickListener(self._onClickBlessBtn, self)
	self._prizeBtn:AddClickListener(function()
		if self._isActivityEnd then
			FloatWordMgr.instance:show("活动结束")

			return
		end

		if self._mirrorBaseInfo.isDailyPrize then
			FloatWordMgr.instance:show("今日已领取奖励")

			return
		end

		XinxiyaMirrorController.instance:csGetMirrorDailyPrizeReq()
	end, self)
	self._battleBtn:AddClickListener(self._onClickBattleBtn, self)
end

function XinxiyaMirrorView:unbindEvents()
	XinxiyaMirrorView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._exchangeBtn:RemoveClickListener()
	self._rankBtn:RemoveClickListener()
	self._blessBtn:RemoveClickListener()
	self._prizeBtn:RemoveClickListener()
	self._battleBtn:RemoveClickListener()
end

function XinxiyaMirrorView:onExit()
	XinxiyaMirrorView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMirrorBaseInfo, self._updataBattleMirrorInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMirrorBuffInfo, self._updataMirrorBuffInfo, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMirrorDailyPrize, self._updataMirrorDailyPrize, self)
	removetimer(self._calculationSurplusTime, self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	self._pmEff = nil

	if self._zcEff then
		UIEffectManager.instance:stopEffect(self._zcEff)
	end

	self._zcEff = nil
	self._battleInfoList = nil
	self._mirrorBaseInfo = nil
	self._choStageIndex = nil
	self._buffAllCount = nil
	self._planId = nil
	self._isAllPass = nil
	self._isActivityEnd = nil
end

function XinxiyaMirrorView:destroyUI()
	XinxiyaMirrorView.super.destroyUI(self)

	local giiBig = self._getIconImaGo:GetComponent("ImageBigBG")

	if giiBig then
		giiBig:ClearImage()
	end

	self._battleItemList = nil
	self._matDailyLimit = nil
end

function XinxiyaMirrorView:buildUI()
	XinxiyaMirrorView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._timerTxt = goutil.findChildTextComponent(self.mainGO, "timerTxt")
	self._prizeBtn = self:getBtn("prizeBtn")
	self._prizeRedGo = self:getGo("prizeBtn/prizeRedGo")
	self._rankBtn = self:getBtn("rankBtn")
	self._exchangeBtn = self:getBtn("exchangeBtn")
	self._blessBtn = self:getBtn("blessBtn")
	self._blessRedGo = self:getGo("blessBtn/blessRedGo")
	self._battleBtn = self:getBtn("battleBtn")
	self._supCountTxt = goutil.findChildTextComponent(self.mainGO, "supCountTxt")

	local getGoodsGo = self:getGo("getGoodsGo")

	self._getIconImaGo = goutil.findChild(getGoodsGo, "getIconIma")
	self._getCountTxt = goutil.findChildTextComponent(getGoodsGo, "getCountTxt")

	local battleItemTran = self:getGo("battleItemTran").transform

	self._battleItemList = {}

	if battleItemTran.childCount > 0 then
		for i = 1, battleItemTran.childCount do
			local go = battleItemTran:GetChild(i - 1).gameObject
			local names = string.split(go.name, "_")

			self._battleItemList[tonumber(names[2])] = {
				itemGo = go,
				choisGo = goutil.findChild(go, "choisGo"),
				lockGo = goutil.findChild(go, "lockGo"),
				passGo = goutil.findChild(go, "passGo"),
				indexTxt = goutil.findChildTextComponent(go, "indexTxt"),
				descTxt = goutil.findChildTextComponent(go, "descTxt")
			}
		end
	end

	self._timerTxt.text = ""
	self._getCountTxt.text = ""
	self._supCountTxt.text = ""

	self._blessRedGo:SetActive(false)
	self._prizeRedGo:SetActive(false)
end

function XinxiyaMirrorView:onEnter()
	XinxiyaMirrorView.super.onEnter(self)

	self._actId = XinxiyaMirrorConfig.instance:getOpenActivityId()

	if checknumber(self._actId) <= 0 then
		if checknumber(XinxiyaMirrorModel.instance.lastActivityId) <= 0 then
			printError("sr---镜像 XinxiyaMirrorView:onEnter()   活动结束咋还可以打开界面 = ", self._actId)

			return
		end

		self._actId = XinxiyaMirrorModel.instance.lastActivityId
	end

	local actCfg = ActivityDefineConfig.instance:getCfgById(XinxiyaMirrorModel.instance.activityType, self._actId)

	self._endTime = 0

	if actCfg == nil or string.nilorempty(actCfg.endTime) then
		printError("sr---镜像 XinxiyaMirrorView:onEnter()   活动时间配置读取空 = ", self._actId)
	else
		self._endTime = GameUtil.string2time(actCfg.endTime)
	end

	self._isActivityEnd = false

	local matCfg = MaterialMgr.getMatCfg(MatType.ACTIVITY_ITEM, XinxiyaMirrorModel.instance.activityMatId)

	if matCfg == nil or string.nilorempty(matCfg.icon) then
		self._getCountTxt.text = ""

		GameUtil.SetActive(self._getIconImaGo, false)
	else
		self._matDailyLimit = matCfg.dailyLimit

		GameUtil.SetActive(self._getIconImaGo, true)
		uGuiUtil.setSpriteToImage(self._getIconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(matCfg.icon))
	end

	local mirrorCfg = XinxiyaMirrorConfig.instance:getOpenTimeCfg(self._actId)

	self._buffAllCount = mirrorCfg and checknumber(mirrorCfg.buffTimes) or 0
	self._planId = mirrorCfg and checknumber(mirrorCfg.challengePlanId) or 1
	self._dailyAllTimes = mirrorCfg and checknumber(mirrorCfg.dailyTimesLimit) or 1

	self:_showActivityTimer()
	self:_updataBattleMirrorInfo()

	if not self._isActivityEnd then
		GlobalDispatcher:addListener(GlobalNotify.UpdateMirrorBaseInfo, self._updataBattleMirrorInfo, self)
		GlobalDispatcher:addListener(GlobalNotify.UpdateMirrorBuffInfo, self._updataMirrorBuffInfo, self)
		GlobalDispatcher:addListener(GlobalNotify.UpdateMirrorDailyPrize, self._updataMirrorDailyPrize, self)
		XinxiyaMirrorController.instance:csGetMirrorInfoReq()
	end

	local effPath = "fx_ui_zdsz/fx_ui_zdsz_zhumianban.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

function XinxiyaMirrorView:_showActivityTimer()
	removetimer(self._calculationSurplusTime, self)

	if self._endTime <= 0 or self._endTime <= ServerTime.now() then
		self._timerTxt.text = "活动结束"
		self._isActivityEnd = true

		return
	end

	if self._endTime > ServerTime.now() then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function XinxiyaMirrorView:_calculationSurplusTime()
	local supTime = self._endTime - ServerTime.now()

	if supTime <= 0 then
		removetimer(self._calculationSurplusTime, self)

		self._timerTxt.text = "活动结束"
		self._isActivityEnd = true

		return
	end

	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(supTime)

	self._timerTxt.text = day > 0 and string.format("剩余时间: %s天%s时%s分", day, hour, min) or string.format("剩余时间： %s时%s分%s秒", hour, min, sec)
end

function XinxiyaMirrorView:_updataBattleMirrorInfo()
	self._isAllPass = XinxiyaMirrorModel.instance:isPassAllMirrorStage(self._planId)
	self._mirrorBaseInfo = XinxiyaMirrorModel.instance:getMirrorBaseInfo()

	if self._mirrorBaseInfo.isPlayEff then
		local effPath = "fx_ui_xinxiyamianban/fx_ui_xinxiyajingxiangta.prefab"

		self._zcEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

		self._zcEff:setParent(self.mainGO.transform)
		self._zcEff:setLocalPos(0, 0, 0)
		self._zcEff:setScale(1)
		XinxiyaMirrorModel.instance:setMirrorPlayEff()
	end

	local supCount = self._dailyAllTimes - checknumber(self._mirrorBaseInfo.dailyTimes)

	if supCount < 0 then
		supCount = 0
	end

	self._supCountTxt.text = string.format("镜像挑战次数：%s/%s", supCount, self._dailyAllTimes)

	local count = checknumber(self._mirrorBaseInfo.dailyItemNum)

	self:_updataMirrorDailyPrize(self._mirrorBaseInfo.isDailyPrize, count)

	self._battleInfoList = XinxiyaMirrorModel.instance:getMirrorItemsList(self._planId, self._isAllPass)

	if self._battleInfoList == nil or #self._battleInfoList ~= #self._battleItemList then
		printError("sr---镜像 XinxiyaMirrorView:_updataBattleMirrorInfo()   配置cfg和item数目对不上，不是6个")
	end

	self._choStageIndex = 1

	if checknumber(self._mirrorBaseInfo.maxStageId) > 0 then
		if self._isAllPass then
			self._choStageIndex = #self._battleInfoList
		else
			for i = 1, #self._battleInfoList do
				if self._battleInfoList[i].stageId <= self._mirrorBaseInfo.maxStageId + 1 and not self._battleInfoList[i].isMir then
					self._choStageIndex = i

					break
				end
			end
		end
	end

	for i = 1, #self._battleItemList do
		GameUtil.asBtn(self._battleItemList[i].itemGo):RemoveClickListener()

		if self._battleInfoList[i] then
			GameUtil.SetActive(self._battleItemList[i].itemGo, true)
			GameUtil.SetActive(self._battleItemList[i].choisGo, i == self._choStageIndex)

			self._battleItemList[i].indexTxt.text = tostring(self._battleInfoList[i].stageId)

			if self._battleInfoList[i].stageId > checknumber(self._mirrorBaseInfo.maxStageId) + 1 then
				GameUtil.SetActive(self._battleItemList[i].passGo, false)
				GameUtil.SetActive(self._battleItemList[i].lockGo, true)

				self._battleItemList[i].descTxt.text = "未解锁"
			else
				GameUtil.SetActive(self._battleItemList[i].lockGo, false)
				GameUtil.SetActive(self._battleItemList[i].passGo, self._battleInfoList[i].isMir)

				self._battleItemList[i].descTxt.text = self._battleInfoList[i].isMir and "已通关" or self._battleInfoList[i].isSys and "尚未通关镜像挑战" or "尚未通关守卫挑战"
			end

			GameUtil.asBtn(self._battleItemList[i].itemGo):AddClickListener(function()
				self:_onClickBattleItemBtn(i)
			end, self)
		else
			GameUtil.SetActive(self._battleItemList[i].itemGo, false)
		end
	end

	self:_updataMirrorBuffInfo(checknumber(self._mirrorBaseInfo.usedTimes), self._mirrorBaseInfo.hadBuff)
end

function XinxiyaMirrorView:_updataMirrorBuffInfo(count, isHave)
	if isHaveBuff then
		self._blessRedGo:SetActive(false)
	else
		self._blessRedGo:SetActive(count < self._buffAllCount)
	end
end

function XinxiyaMirrorView:_onClickBattleItemBtn(index)
	if self._battleItemList == nil then
		return
	end

	if self._battleInfoList == nil or self._battleInfoList[index] == nil then
		return
	end

	local info = self._battleInfoList[index]
	local maxStageId = self._mirrorBaseInfo and checknumber(self._mirrorBaseInfo.maxStageId) or 0

	if info.stageId > maxStageId + 1 then
		FloatWordMgr.instance:show("该挑战关卡还未解锁，请先挑战前面关卡哦！")

		return
	end

	if info.stageId == maxStageId + 1 and self._battleInfoList and self._battleInfoList[maxStageId] and not self._battleInfoList[maxStageId].isMir then
		FloatWordMgr.instance:show("该挑战关卡还未解锁，请先挑战前面关卡哦！")

		return
	end

	if self._battleItemList[self._choStageIndex] and self._battleItemList[self._choStageIndex].choisGo then
		GameUtil.SetActive(self._battleItemList[self._choStageIndex].choisGo, false)
	end

	if self._battleItemList[index] and self._battleItemList[index].choisGo then
		GameUtil.SetActive(self._battleItemList[index].choisGo, true)
	end

	self._choStageIndex = index
end

function XinxiyaMirrorView:_updataMirrorDailyPrize(isBool, count)
	count = checknumber(count)

	if count > self._matDailyLimit then
		count = self._matDailyLimit
	end

	self._getCountTxt.text = string.format("今日已获得：%s/%s", count, self._matDailyLimit)
	self._mirrorBaseInfo.isDailyPrize = isBool

	if self._isActivityEnd then
		self._prizeRedGo:SetActive(false)

		return
	end

	self._prizeRedGo:SetActive(not isBool)
end

function XinxiyaMirrorView:_onClickBlessBtn()
	if self._mirrorBaseInfo.hadBuff then
		FloatWordMgr.instance:show("当前已有辛西娅的祝福了哦！")

		return
	end

	if checknumber(self._mirrorBaseInfo.usedTimes) >= self._buffAllCount then
		FloatWordMgr.instance:show("今天无法再获得辛西娅的祝福了哦！")

		return
	end

	local des = string.format("<color=#EB4642FF>辛西娅</color>的祝福每日可使用<color=#EB4642FF>%s次</color>，\n使用后下一关挑战的属性克制效果<color=#EB4642FF>x2</color>", self._buffAllCount)

	TipsFacade.instance:openPopupWindow("辛西娅的祝福", des, function()
		XinxiyaMirrorController.instance:csMirrorUseBuffReq()
	end, nil, "确定", "取消", UnityEngine.TextAnchor.MiddleCenter)
end

function XinxiyaMirrorView:_onClickBattleBtn()
	if self._isActivityEnd then
		FloatWordMgr.instance:show("活动结束")

		return
	end

	if checknumber(self._choStageIndex) <= 0 or checknumber(self._choStageIndex) > 6 then
		printError("sr---镜像  XinxiyaMirrorView:_onClickBattleBtn()  计算的索引值不对 = ", self._choStageIndex)

		return
	end

	if self._battleItemList == nil or self._battleItemList[self._choStageIndex] == nil then
		printError("sr---镜像  XinxiyaMirrorView:_onClickBattleBtn()  挑战Item列表出错 = ", self._choStageIndex)

		return
	end

	if self._battleInfoList == nil or self._battleInfoList[self._choStageIndex] == nil then
		printError("sr---镜像  XinxiyaMirrorView:_onClickBattleBtn()  挑战Info列表出错 = ", self._choStageIndex)

		return
	end

	local info = self._battleInfoList[self._choStageIndex]

	if info.isMir and not self._isAllPass then
		FloatWordMgr.instance:show("完成全部关卡挑战后，才可重复挑战！")

		return
	end

	UIStateManager.instance:push(ViewName.XinxiyaTeam, {
		actyId = self._actId,
		planId = self._planId,
		stageId = info.stageId
	})
end

return XinxiyaMirrorView
