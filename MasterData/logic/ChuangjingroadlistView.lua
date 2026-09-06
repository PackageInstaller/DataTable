-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangjingroad/view/ChuangjingroadlistView.lua

module("logic.extensions.chuangjingroad.view.ChuangjingroadlistView", package.seeall)

local ChuangjingroadlistView = class("ChuangjingroadlistView", ViewComponent)

function ChuangjingroadlistView:ctor()
	ChuangjingroadlistView.super.ctor(self)
end

function ChuangjingroadlistView:unbindEvents()
	ChuangjingroadlistView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnShow)
end

function ChuangjingroadlistView:bindEvents()
	ChuangjingroadlistView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickHelp, self)
	GameUtil.addClickHandler(self._btnShow, self._onClickShow, self)
end

function ChuangjingroadlistView:buildUI()
	ChuangjingroadlistView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._changeBg = self:getGo("changeBg")
	self._noPass = self:getGo("noPass")
	self._txtTitle = self:getTxt("txtTitle")
	self._firstPass = self:getGo("firstPass")
	self._btnShow = self:getGo("firstPass/btnShow")
	self._txtArea = self:getTxt("firstPass/txtArea")
	self._txtName = self:getTxt("firstPass/txtName")
	self._head = self:getGo("firstPass/head")
	self._progressBar = self:getSlider("progressReward/tableview/Viewport/Content/progressBar")
	self._tableview = self:getGo("progressReward/tableview")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._total = self:getGo("progressReward/total")
	self._txtCount = self:getTxt("progressReward/total/txt")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	self._tablecell2 = self:getGo("tablecell")
	self._tableview2 = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview2, self._tablecell2, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function ChuangjingroadlistView:onExit()
	ChuangjingroadlistView.super.onExit(self)
	self._scrollList:dispose()
	self._rewardScrollList:dispose()
	uGuiUtil.clearImage(self._changeBg)
end

function ChuangjingroadlistView:onEnter()
	ChuangjingroadlistView.super.onEnter(self)

	self._activityId = 396001
	self._zoneId = 1

	local params = self:getOpenParam() or {}
	local actId = checknumber(params[1])
	local zoneId = checknumber(params[2])

	if actId > 0 then
		self._activityId = actId
	end

	if zoneId > 0 then
		self._zoneId = zoneId
	end

	self.addGEvent(self, GlobalNotify.CHUANG_JING_ROAD_INFO_UPDATE, self._onRefershUI, self)
	ChuangJingRoadController.instance:sendGetInfo(self._activityId)
	self:_onRefershUI()
end

function ChuangjingroadlistView:_onRefershUI()
	self._stageId = 0

	local info = ChuangJingRoadModel.instance:getInfo(self._activityId) or {}

	if not info.zones then
		local zones = {}

		self._zoneInfo = nil

		for i, v in ipairs(zones) do
			if v.zoneId == self._zoneId then
				self._zoneInfo = v

				break
			end
		end

		self._zoneInfo = self._zoneInfo or {}
		self._stageId = checknumber(self._zoneInfo.stageId)
		self._gainProgressPrizeId = self._zoneInfo.gainProgressPrizeId or {}

		local bossStage = checkbool(self._zoneInfo.isFinishBoss) and 1 or 0

		self._stageProgress = self._stageId + bossStage

		GameUtil.SetActive(self._noPass, self._zoneInfo.first == nil)
		GameUtil.SetActive(self._firstPass, self._zoneInfo.first ~= nil)

		if self._zoneInfo.first then
			self._txtArea.text = self._zoneInfo.first.areaName or "--"
			self._txtName.text = self._zoneInfo.first.userName

			HeadItemController.instance:setHeadCellByInfo(self._head, self._zoneInfo.first, true)
		end

		local zoneCfg = ChuangJingRoadConfig.instance:getZoneCfgById(self._activityId, self._zoneId) or {}

		self._txtTitle.text = zoneCfg.desc

		uGuiUtil.setSpriteToImage(self._changeBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgPngUrl(zoneCfg.imageUrl), function()
			self._changeBg.gameObject:GetComponent("Image"):SetNativeSize()
		end)

		local configList = ChuangJingRoadConfig.instance:getStageListById(self._activityId, self._zoneId) or {}
		local list = {}

		for i, v in ipairs(configList) do
			table.insert(list, v)
		end

		local data = {}

		data.isBoss = true
		data.stageId = #list + 1

		local cfg = ChuangJingRoadConfig.instance:getExtStageById(self._activityId, self._zoneId)

		data.skinId = cfg.skinId
		data.pos = cfg.pos
		data.name = cfg.name

		table.insert(list, data)
		self._scrollList:reloadData(list)
		self._scrollList:MoveCellToCenter(self._stageId)

		local prizeList = ChuangJingRoadConfig.instance:getChallengePorgressById(self._activityId, self._zoneId) or {}
		local idx = -1
		local scoreArr = {}

		for i, v in ipairs(prizeList) do
			table.insert(scoreArr, v.stageNum)

			local isCanGet = self._stageProgress >= v.stageNum
			local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

			if isCanGet and not isGainPrize and idx == -1 then
				idx = i - 1
			end
		end

		self._rewardScrollList:reloadData(prizeList)
		self._rewardScrollList:updateUnderSlider(self._progressBar, self._stageProgress, scoreArr)
		self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)

		self._txtCount.text = self._stageProgress .. "/" .. #list
	end
end

function ChuangjingroadlistView:_updateCell(view, cell, data, tag)
	local btn = goutil.findChild(cell, "root")
	local icon = goutil.findChild(cell, "root/icon")
	local emptyIcon = goutil.findChild(cell, "root/emptyIcon")
	local pass = goutil.findChild(cell, "root/pass")
	local lock = goutil.findChild(cell, "root/lock")
	local txtName = goutil.findChildTextComponent(cell, "root/txtName")

	GameUtil.SetActive(emptyIcon, false)

	if checknumber(data.skinId) > 0 then
		MaterialMgr.setIcon(icon, MatType.Pet, data.skinId)
	else
		GameUtil.SetActive(emptyIcon, true)
		MaterialMgr.clearIcon(icon)
	end

	if not data.pos then
		local pos = {
			0,
			0
		}

		GameUtil.setAnchoredPos(btn, pos[1], pos[2])

		txtName.text = data.name

		goutil.setActive(lock, checknumber(data.stageId) > self._stageId + 1)
		goutil.setActive(pass, checknumber(data.stageId) <= self._stageId)

		if data.isBoss then
			goutil.setActive(pass, checkbool(self._zoneInfo.isFinishBoss))
		end

		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickStage, self, data))
	end
end

function ChuangjingroadlistView:_onClickShow()
	UIStateManager.instance:push(ViewName.ChuangjingroadfirstteamView, self._activityId, self._zoneId)
end

function ChuangjingroadlistView:_onClickHelp()
	return
end

function ChuangjingroadlistView:_clearCell(cell)
	return
end

function ChuangjingroadlistView:_onClickStage(data)
	if checknumber(data.stageId) <= self._stageId then
		TipsFacade.instance:openCommonTips("已通关")

		return
	end

	if checknumber(data.stageId) > self._stageId + 1 then
		TipsFacade.instance:openCommonTips("请通关前置关卡")

		return
	end

	if data.isBoss then
		if checkbool(self._zoneInfo.isFinishBoss) then
			TipsFacade.instance:openCommonTips("已通关")
		else
			ChuangJingRoadController.instance:openBossMissionView(self._activityId, self._zoneId)
		end
	else
		ChuangJingRoadController.instance:openChallengeMissionView(self._activityId, self._zoneId, data.stageId)
	end
end

function ChuangjingroadlistView:_updateRewardCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.stageNum

	local isCanGet = self._stageProgress >= data.stageNum
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function ChuangjingroadlistView:_onClickGetPrize(data)
	local isCanGet = self._stageProgress >= data.stageNum
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		ChuangJingRoadController.instance:sendGetChallengePrize(self._activityId, self._zoneId, data.prizeId)
	end
end

function ChuangjingroadlistView:_clearRewardCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function ChuangjingroadlistView:_playEffect(effGo)
	self:_clearEffect(effGo)

	local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, effPath, effGo.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self:getGo("progressReward/tableview/Viewport").transform)
	end)

	uiEffect:setParent(effGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)

	self._cellEffects = self._cellEffects or {}
	self._cellEffects[effGo] = uiEffect
end

function ChuangjingroadlistView:_clearEffect(effGo)
	if self._cellEffects and self._cellEffects[effGo] then
		UIEffectManager.instance:stopEffect(self._cellEffects[effGo])

		self._cellEffects[effGo] = nil
	end
end

return ChuangjingroadlistView
