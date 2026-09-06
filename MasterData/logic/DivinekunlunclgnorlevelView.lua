-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/view/DivinekunlunclgnorlevelView.lua

module("logic.extensions.divinekunlun.view.DivinekunlunclgnorlevelView", package.seeall)

local DivinekunlunclgnorlevelView = class("DivinekunlunclgnorlevelView", ViewComponent)

function DivinekunlunclgnorlevelView:ctor()
	DivinekunlunclgnorlevelView.super.ctor(self)
end

function DivinekunlunclgnorlevelView:unbindEvents()
	DivinekunlunclgnorlevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivinekunlunclgnorlevelView:bindEvents()
	DivinekunlunclgnorlevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivinekunlunclgnorlevelView:buildUI()
	DivinekunlunclgnorlevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtRule = self:getTxt("desc/txtRule")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tablecell")
	self._txtCount = self:getTxt("progressReward/total/txtCount")
	self._progressBar = self:getSlider("progressReward/rewardtableview/Viewport/Content/progressBar")
	self._rewardCell = self:getGo("progressReward/rewardCell")
	self._rewardtableview = self:getGo("progressReward/rewardtableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._rewardScrollList = ScrollerList.create(self._rewardtableview, self._rewardCell, GameUtil.handler(self._updateRwdCell, self), GameUtil.handler(self._clearRwdCell, self))
end

function DivinekunlunclgnorlevelView:onExit()
	DivinekunlunclgnorlevelView.super.onExit(self)
	self._scrollList:dispose()
	self._rewardScrollList:dispose()
end

function DivinekunlunclgnorlevelView:onEnter()
	DivinekunlunclgnorlevelView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = DivineKunlunController.instance:getDefaultActivityId()
	end

	self._activityCfg = DivineKunlunConfig.instance:getActivityCfgById(self._activityId) or {}
	self._txtRule.text = self._activityCfg.normalDesc

	self.addGEvent(self, GlobalNotify.DIVINE_KUNLUN_INFO_UPDATE, self._onRefreshUI, self)
	DivineKunlunController.instance:sendGetInfo(self._activityId)
	self:_onRefreshUI()
end

function DivinekunlunclgnorlevelView:_onRefreshUI()
	self._info = DivineKunlunModel.instance:getInfo(self._activityId) or {}

	if not self._info.dailyNormalStageInfo then
		local dailyNormalStageInfo = {}

		self._gainProgressPrizeId = self._info.gainNormalPrizeIds or {}
		self._stageProgress = checknumber(self._info.normalTotalScore)

		local norCfg = DivineKunlunConfig.instance:getNormalCfgListById(self._activityId) or {}
		local list = {}

		self._norMap = {}

		for i, v in ipairs(dailyNormalStageInfo) do
			local left = v.left

			self._norMap[left] = v.right

			local cfg = norCfg[left]

			if cfg then
				table.insert(list, cfg)
			end
		end

		self._scrollList:reloadData(list)

		self._txtCount.text = self._stageProgress

		local prizeList = DivineKunlunConfig.instance:getProgressCfgById(self._activityId) or {}
		local idx = -1
		local scoreArr = {}

		for i, v in ipairs(prizeList) do
			table.insert(scoreArr, v.progress)

			local isCanGet = self._stageProgress >= v.progress
			local isGainPrize = table.indexof(self._gainProgressPrizeId, v.prizeId) ~= false

			if isCanGet and not isGainPrize and idx == -1 then
				idx = i - 1
			end
		end

		self._rewardScrollList:reloadData(prizeList)
		self._rewardScrollList:updateUnderSlider(self._progressBar, self._stageProgress, scoreArr)
		self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)
	end
end

function DivinekunlunclgnorlevelView:_updateCell(view, cell, data, tag)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")
	local fmtGo = goutil.findChild(cell, "btnChallenge/fmt")
	local passGo = goutil.findChild(cell, "btnChallenge/pass")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtHitTime = goutil.findChildTextComponent(cell, "txtHitTime")
	local cfg = DivineKunlunConfig.instance:getMonsterCfg(data.creepsMasterId)

	if cfg then
		txtName.text = cfg.name or ""
	end

	local isPass = false

	goutil.setActive(passGo, isPass)

	txtHitTime.text = "连击次数：" .. checknumber(self._norMap[data.stageId])

	GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickFight, self, cell.index, data))

	local map = {}
	local cfgCreeps = DivineKunlunConfig.instance:getCreeps(data.creepsMasterId)

	for i, cfgEnemy in ipairs(cfgCreeps) do
		map[cfgEnemy.posId] = cfgEnemy
	end

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d", i))
		local con = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d/con", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)

		local cfgEnemy = map[i]

		if cfgEnemy then
			goutil.setActive(go, true)
			GameUtil.setLocalScale(con, 0.7, 0.7, 0.7)
			MaterialMgr.setCell(MatType.Pet, cfgEnemy.raceId, con)
		end
	end
end

function DivinekunlunclgnorlevelView:_clearCell(cell)
	local btnChallenge = goutil.findChild(cell, "btnChallenge")

	GameUtil.rmClickHandler(btnChallenge)

	for i = 1, 9 do
		local go = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d", i))
		local con = goutil.findChild(cell, string.format("btnChallenge/fmt/cell_%d/con", i))

		MaterialMgr.resetAll(con)
		goutil.setActive(go, false)
		goutil.setActive(go, false)
	end
end

function DivinekunlunclgnorlevelView:_onClickFight(idx, data)
	DivineKunlunController.instance:openMissionView(self._activityId, idx, data.stageId)
end

function DivinekunlunclgnorlevelView:_updateRwdCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "received")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.progress

	local isCanGet = self._stageProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function DivinekunlunclgnorlevelView:_clearRwdCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function DivinekunlunclgnorlevelView:_onClickGetPrize(data)
	local isCanGet = self._stageProgress >= data.progress
	local isGainPrize = table.indexof(self._gainProgressPrizeId, data.prizeId) ~= false

	if isCanGet and not isGainPrize then
		DivineKunlunController.instance:sendGetNorPrize(self._activityId, data.prizeId)
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function DivinekunlunclgnorlevelView:_playEffect(effGo)
	self:playViewEffectUniGo(effPath, effGo, self:getGo("progressReward/rewardtableview/Viewport").transform)
end

function DivinekunlunclgnorlevelView:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

return DivinekunlunclgnorlevelView
