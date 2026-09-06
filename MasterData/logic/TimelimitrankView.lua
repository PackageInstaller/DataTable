-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/view/TimelimitrankView.lua

module("logic.extensions.timelimitrank.view.TimelimitrankView", package.seeall)

local TimelimitrankView = class("TimelimitrankView", ViewComponent)

function TimelimitrankView:ctor()
	TimelimitrankView.super.ctor(self)
end

function TimelimitrankView:buildUI()
	TimelimitrankView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._closeBtn = self:getBtn("close")
	self._typeCell = self:getGo("typeCell")
	self._typeView = ScrollerList.create(self:getGo("typeView"), self._typeCell, GameUtil.handler(self._updateTypeCell, self))
	self._rankCell = self:getGo("right/rankCell")
	self._rankListView = self:getGo("right/rankListView")
	self._rankView = ScrollerList.create(self._rankListView, self._rankCell, GameUtil.handler(self._updateRankCell, self))
	self._txtProgress = goutil.findChildTextComponent(self.mainGO, "right/description/txtProgress")
	self._goEmpty = self:getGo("right/goEmpty")
	self._myRankValue = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyRankTitle/value")
	self._myProgress = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyProgress")
	self._myProgressValue = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtMyProgress/value")
	self._txtRefreshRules = goutil.findChildTextComponent(self.mainGO, "right/myRank/txtTip")
	self._time = goutil.findChildTextComponent(self.mainGO, "reward/time")
	self._rewardCell = self:getGo("reward/rewardCell")
	self._rewardView = ScrollerList.create(self:getGo("reward/rewardView"), self._rewardCell, GameUtil.handler(self._updateRewardCell, self))
	self._ruleBtn = self:getBtn("ruleBtn")
	self._collectRewardBtn = self:getBtn("collectRewardBtn")
	self._collectRewardPoint = self:getGo("collectRewardBtn/imgPoint")
end

function TimelimitrankView:bindEvents()
	TimelimitrankView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._ruleBtn:AddClickListener(self._onClickRule, self)
	self._collectRewardBtn:AddClickListener(self._onClickCollectReward, self)
end

function TimelimitrankView:unbindEvents()
	TimelimitrankView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._ruleBtn:RemoveClickListener()
	self._collectRewardBtn:RemoveClickListener()
end

function TimelimitrankView:destroyUI()
	TimelimitrankView.super.destroyUI(self)
end

function TimelimitrankView:onEnter()
	TimelimitrankView.super.onEnter(self)

	self._selectedTypeCell = {}

	TimeLimitRankAgent.instance:sendPM_TimeLimitRankGetProgressInfoReq(function(msg)
		for i, value in ipairs(msg.progressInfo) do
			TimelimitrankModel.instance:setProgressInfo(value.id, value.progress, value.progressPrize)
		end

		local rankData = TimelimitrankModel.instance:getDefineById(self:getFirstParam() or TimelimitrankModel.instance:getSelectedRankType())

		if rankData and TimelimitrankController.instance:isOpenRank(rankData.startTime) then
			self:_onClickRankType(rankData)
		else
			self:_onClickRankType(TimelimitrankController.instance:isHaveRank())
		end

		if self._id == nil then
			TipsFacade.instance:openTipWindowNoX("提示", "目前无开启的排行榜", function()
				self:close()
			end)

			return
		end

		self._typeView:regReloadFinish(GameUtil.handler(function()
			self._selectedTypeCell[self._id].txtColor:SetState(1)
			goutil.setActive(self._selectedTypeCell[self._id].imgSelected, true)
			goutil.setActive(self._collectRewardPoint, TimelimitrankController.instance:isRedPoint(self._id))
			self._typeView:regReloadFinish(nil)
		end, self))

		local defineList = TimelimitrankController.instance:getDefine()

		self._typeView:reloadData(defineList)
	end)
	GlobalDispatcher:addListener(TimelimitrankController.UPDATE_REDPOINT, self._updateRedPoint, self)
end

function TimelimitrankView:onExit()
	TimelimitrankView.super.onExit(self)
	TimeLimitRankAgent.instance:getDispatcher():removeAllListener(TimeLimitRankAgent.PM_TimeLimitRankGetProgressInfoRes)
	removetimer(self._timer, self)
	RankModel.instance:onReset()
	GlobalDispatcher:removeListener(TimelimitrankController.UPDATE_REDPOINT, self._updateRedPoint, self)

	if self._id and self._selectedTypeCell[self._id] then
		goutil.setActive(self._selectedTypeCell[self._id].imgSelected, false)
		self._selectedTypeCell[self._id].txtColor:SetState(0)
	end

	self._selectedTypeCell = {}

	self._typeView:dispose()
	self._rankView:dispose()
	self._rewardView:dispose()
end

function TimelimitrankView:_updateRedPoint()
	self._typeView:reloadData(TimelimitrankController.instance:getDefine())
	goutil.setActive(self._collectRewardPoint, TimelimitrankController.instance:isRedPoint(self._id))
end

function TimelimitrankView:_updateTypeCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "txtName").text = data.title
	self._selectedTypeCell[data.id] = {}
	self._selectedTypeCell[data.id].txtColor = goutil.findChildComponent(cell.gameObject, "txtName", "UITextColorChange")
	self._selectedTypeCell[data.id].imgSelected = goutil.findChild(cell.gameObject, "imgSelected")

	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(function()
		self:_onClickRankType(data)
	end)
	goutil.setActive(goutil.findChild(cell.gameObject, "imgPoint"), TimelimitrankController.instance:isRedPoint(data.id))
end

function TimelimitrankView:_updateRankCell(view, cell, data)
	HeadItemController.instance:setHeadCellByInfo(goutil.findChild(cell.gameObject, "imgIcon"), data.headInfo)

	local _btnIcon = GameUtil.asBtn(goutil.findChild(cell.gameObject, "btnIcon"))

	if _btnIcon ~= nil then
		_btnIcon:RemoveClickListener()
		_btnIcon:AddClickListener(function()
			TimelimitrankModel.instance:setSelectedRankType(self._id)
			FriendController.instance:showInfoView(tonumber(data.headInfo.userId), _btnIcon)
		end)
	end

	goutil.findChildTextComponent(cell.gameObject, "txtName").text = data.headInfo.userName
	goutil.findChildTextComponent(cell.gameObject, "txtFamily").text = data.familyName and data.familyName ~= "" and data.familyName or "未加入家族"

	if data.rank <= 3 then
		goutil.setActive(goutil.findChild(cell.gameObject, "imgRank"), true)
		goutil.setActive(goutil.findChild(cell.gameObject, "txtRank"), false)
		goutil.findChildComponent(cell.gameObject, "imgRank", "UIImageSpriteChange"):SetState(data.rank - 1)
	else
		goutil.setActive(goutil.findChild(cell.gameObject, "imgRank"), false)
		goutil.setActive(goutil.findChild(cell.gameObject, "txtRank"), true)

		goutil.findChildTextComponent(cell.gameObject, "txtRank").text = data.rank
	end

	goutil.findChildTextComponent(cell.gameObject, "txtProgress").text = string.format(self._progressFormat, data.progressId)
end

function TimelimitrankView:_updateRewardCell(view, cell, data)
	goutil.findChildTextComponent(cell.gameObject, "title").text = data.name

	local rewardItems = string.split(data.prize, "#")

	for i = 1, 4 do
		local item = goutil.findChild(cell.gameObject, "items/item_" .. i)

		if rewardItems[i] then
			goutil.setActive(item, true)

			local proxy = MaterialMgr.setCellByCfg(rewardItems[i], item)

			Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.6, 0.6, 1)
		else
			goutil.setActive(item, false)
			MaterialMgr.resetAll(item)
		end
	end
end

function TimelimitrankView:_updateRankData(msg)
	if not self._isDataReady then
		printError("还没调用_onClickRankType就调用_updateRankData了=" .. debug.traceback())

		return
	end

	local rankInfo = msg.rankInfo

	if rankInfo and #rankInfo > 0 then
		self._rankView:reloadData(rankInfo)
		goutil.setActive(self._goEmpty, false)
	else
		self._rankView:reloadData({})
		goutil.setActive(self._goEmpty, true)
	end

	self._myRankValue.text = msg.myRank > 0 and msg.myRank or "未上榜"

	local progressInfo = TimelimitrankModel.instance:getProgressInfo(self._id)

	self._myProgressValue.text = progressInfo and string.format(self._progressFormat, progressInfo.progress) or "进度信息获取失败"

	goutil.setActive(self._collectRewardPoint, TimelimitrankController.instance:isRedPoint(self._id))
	self:_timer()
	settimer(1, self._timer, self, true)
end

function TimelimitrankView:_onClickRankType(rankTypeData)
	if not TimelimitrankController.instance:isOpenRank(rankTypeData.startTime) then
		TipsFacade.instance:openTipWindow("提示", TimelimitrankConfig.instance:getCommonValue("NOT_OPEN_TIP"))

		return
	end

	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, "ui/bigbg/views/" .. rankTypeData.bg)

	self._progressName = rankTypeData.progressName
	self._progressFormat = rankTypeData.progressFormat
	self._progressPrizeId = rankTypeData.progressPrizeId

	self._rewardView:reloadData(TimelimitrankModel.instance:getTopPrizeById(rankTypeData.rankPrizeId))

	self._type = rankTypeData.type

	if self._selectedTypeCell[self._id] then
		self._selectedTypeCell[self._id].txtColor:SetState(0)
		goutil.setActive(self._selectedTypeCell[self._id].imgSelected, false)
	end

	self._id = rankTypeData.id

	if self._selectedTypeCell[self._id] then
		self._selectedTypeCell[self._id].txtColor:SetState(1)
		goutil.setActive(self._selectedTypeCell[self._id].imgSelected, true)
	end

	self._txtProgress.text = rankTypeData.progressName
	self._endTime = rankTypeData.endTime
	self._promulgateDay = rankTypeData.promulgateDay
	self._rules = rankTypeData.rules
	self._txtRefreshRules.text = rankTypeData.refreshRules
	self._myRankValue.text = "加载中..."
	self._myProgress.text = string.format("我的%s:", rankTypeData.progressName)
	self._myProgressValue.text = "加载中..."

	removetimer(self._timer, self)

	self._time.text = "加载中..."
	self._isDataReady = true

	goutil.setActive(self._collectRewardPoint, false)
	TimelimitrankController.instance:getRankTypeData(self._id, self._updateRankData, self)
end

function TimelimitrankView:_onClickRule()
	if not self._isDataReady then
		return
	end

	local surplusTime = TimelimitrankController.instance:calculatePublicSurplusTime(self._endTime, self._promulgateDay)

	if surplusTime == nil then
		TipsFacade.instance:openTipWindowNoX("提示", TimelimitrankConfig.instance:getCommonValue("PUBLIC_END"), function()
			self:close()
		end)
	end

	UIStateManager.instance:open(ViewName.RulesView, self._rules)
end

function TimelimitrankView:_onClickCollectReward()
	if not self._isDataReady then
		return
	end

	local surplusTime = TimelimitrankController.instance:calculatePublicSurplusTime(self._endTime, self._promulgateDay)

	if surplusTime == nil then
		TipsFacade.instance:openTipWindowNoX("提示", TimelimitrankConfig.instance:getCommonValue("PUBLIC_END"), function()
			self:close()
		end)
	end

	UIStateManager.instance:push(ViewName.TimelimitrankprizeView, self._id)
end

function TimelimitrankView:_timer()
	if not self._isDataReady then
		printError("TimelimitrankView:_timer报错，self._endTime还没初始化")

		return
	end

	local surplusTime = TimelimitrankController.instance:calculateSurplusTime(self._endTime)

	if surplusTime then
		self._time.text = "活动倒计时:" .. surplusTime
	else
		surplusTime = TimelimitrankController.instance:calculatePublicSurplusTime(self._endTime, self._promulgateDay)
		self._time.text = surplusTime and "公示倒计时:" .. surplusTime or "该排行榜已结束"
	end
end

function TimelimitrankView:close()
	TimelimitrankModel.instance:setSelectedRankType(nil)
	TimelimitrankView.super.close(self)
end

return TimelimitrankView
