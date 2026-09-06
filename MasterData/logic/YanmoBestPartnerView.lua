-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yanmobestpartner/view/YanmoBestPartnerView.lua

module("logic.extensions.yanmobestpartner.view.YanmoBestPartnerView", package.seeall)

local YanmoBestPartnerView = class("YanmoBestPartnerView", ViewComponent)

function YanmoBestPartnerView:ctor()
	YanmoBestPartnerView.super.ctor(self)
end

function YanmoBestPartnerView:unbindEvents()
	YanmoBestPartnerView.super.unbindEvents(self)
	self._btnTip:RemoveClickListener()
end

function YanmoBestPartnerView:bindEvents()
	YanmoBestPartnerView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._tipOnClick, self)
end

function YanmoBestPartnerView:onExit()
	YanmoBestPartnerView.super.onExit(self)
	self._tabList:dispose()
	self._rewardScrollList:dispose()
	RoleObjectPool.instance:removeRole(self._roleObj)
	GlobalDispatcher:removeListener(GlobalNotify.YanmoBestPartnerGainPrizeRes, self._updateAll, self)
end

function YanmoBestPartnerView:buildUI()
	YanmoBestPartnerView.super.buildUI(self)

	self._btnTip = self:getBtn("btnTip")
	self._txtScore = self:getTxt("txtScore")
	self._txtBubble = self:getTxt("bubble/txtDesc")
	self._petCon = self:getGo("petCon")
	self._grid = self:getGo("grid")
	self._cell = self:getGo("cell")
	self._tabList = ScrollerList.create(self._grid, self._cell, GameUtil.handler(self._updateList, self), GameUtil.handler(self._clearList, self))
	self._progressBar = self:getSlider("playerRoot/tableview/Viewport/Content/progressBar")
	self._playercell = self:getGo("playerRoot/playercell")
	self._tableview = self:getGo("playerRoot/tableview")
	self._rewardScrollList = ScrollerList.create(self._tableview, self._playercell, GameUtil.handler(self._updateRwdCell, self), GameUtil.handler(self._clearRwdCell, self))
end

function YanmoBestPartnerView:onEnter()
	YanmoBestPartnerView.super.onEnter(self)

	self._activityId = YanmoBestPartnerModel.instance:getActivityId()

	if self._activityId == 0 then
		FloatWordMgr.instance:show("活动已结束")

		return
	end

	self._petCfg = YanmoBestPartnerModel.instance:getPetList()

	local cfg = YanmoBestPartnerConfig.instance:getCfgById(self._activityId)

	self._txtBubble.text = cfg.bubbleText

	self._tabList:reloadData(self._petCfg)
	self:_setPetCon()
	CollectSummoningAgent.instance:sendPM_CollectSummoningGetInfoReq(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.YanmoBestPartnerGainPrizeRes, self._updateAll, self)
end

function YanmoBestPartnerView:_tipOnClick()
	UIStateManager.instance:push(ViewName.RulesView, "yanmobestpartnerview_1")
end

function YanmoBestPartnerView:_updateList(view, cell, data)
	local icon = goutil.findChild(cell, "icon")
	local btn = goutil.findChild(cell, "btn")
	local isNew = goutil.findChild(cell, "isNew")
	local receive = goutil.findChild(cell, "receive")
	local name = goutil.findChildTextComponent(cell, "name")
	local txtBtn = goutil.findChildTextComponent(cell, "btn/txt")

	MaterialMgr.resetAll(icon)
	MaterialMgr.setIcon(icon, MatType.PET_SKIN, data.raceId)

	name.text = data.petName

	goutil.setActive(isNew, data.isNew)
	goutil.setActive(receive, data.isGray)
	goutil.setActive(btn, not data.isGray)
	GameUtil.asBtn(btn):RemoveClickListener()
	GameUtil.asBtn(btn):AddClickListener(function()
		if data.isGray then
			return
		end

		MaterialMgr.openGetSource(MatType.Pet, data.raceId)
	end)
end

function YanmoBestPartnerView:_clearList(cell)
	local btn = goutil.findChild(cell, "btn")

	GameUtil.asBtn(btn):RemoveClickListener()
end

function YanmoBestPartnerView:_updateAll()
	self._stageProgress = YanmoBestPartnerModel.instance:getAllScore()
	self._txtScore.text = self._stageProgress

	local prizeList = YanmoBestPartnerConfig.instance:getRewardById(self._activityId) or {}
	local idx = -1
	local scoreArr = {}

	for i, v in ipairs(prizeList) do
		table.insert(scoreArr, v.score)

		local isCanGet = self._stageProgress >= v.score
		local isGainPrize = YanmoBestPartnerModel.instance:isRewardGeted(v.id)

		if isCanGet and not isGainPrize and idx == -1 then
			idx = i - 1
		end
	end

	self._rewardScrollList:reloadData(prizeList)
	self._rewardScrollList:updateUnderSlider(self._progressBar, self._stageProgress, scoreArr)
	self._rewardScrollList:MoveCellToCenter(idx == -1 and 0 or idx)
end

function YanmoBestPartnerView:_setPetCon()
	local cfg = YanmoBestPartnerConfig.instance:getCfgById(self._activityId)
	local modelCfg = cfg.petPos

	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, cfg.petId, self._petCon, modelCfg[3], nil, true, modelCfg[1], modelCfg[2])
end

function YanmoBestPartnerView:_updateRwdCell(view, cell, data, tag)
	local item = goutil.findChild(cell, "item")
	local received = goutil.findChild(cell, "geted")
	local txtScore = goutil.findChildTextComponent(cell, "txtScore")
	local canGet = goutil.findChild(cell, "canGet")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.setCellByCfg(data.prize, item)

	txtScore.text = data.score

	local isCanGet = self._stageProgress >= data.score
	local isGainPrize = YanmoBestPartnerModel.instance:isRewardGeted(data.id)

	GameUtil.SetActive(canGet, isCanGet)
	GameUtil.SetActive(received, isGainPrize)
	self:_clearEffect(effect)

	if isCanGet and not isGainPrize then
		self:_playEffect(effect)
	end

	GameUtil.addClickHandler(canGet, GameUtil.handler(self._onClickGetPrize, self, data), self)
end

function YanmoBestPartnerView:_clearRwdCell(cell)
	local item = goutil.findChild(cell, "item")
	local effect = goutil.findChild(cell, "effect")

	MaterialMgr.resetAll(item)
	self:_clearEffect(effect)
end

function YanmoBestPartnerView:_onClickGetPrize(data)
	local isCanGet = self._stageProgress >= data.score
	local isGainPrize = YanmoBestPartnerModel.instance:isRewardGeted(data.id)

	if isCanGet and not isGainPrize then
		CollectSummoningAgent.instance:sendPM_CollectSummoningGainPrizeReq(self._activityId, data.id)
	end
end

local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

function YanmoBestPartnerView:_playEffect(effGo)
	self:playViewEffectUniGo(effPath, effGo, self:getGo("playerRoot/tableview/Viewport").transform)
end

function YanmoBestPartnerView:_clearEffect(effGo)
	self:stopViewEffectUniGo(effGo)
end

return YanmoBestPartnerView
