-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pingame/view/PinGameRewardView.lua

module("logic.extensions.pingame.view.PinGameRewardView", package.seeall)

local PinGameRewardView = class("PinGameRewardView", ViewComponent)

function PinGameRewardView:ctor()
	PinGameRewardView.super.ctor(self)
end

function PinGameRewardView:buildUI()
	PinGameRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self.scrollerGo = self:getGo("tableview")
	self.cellGo = self:getGo("tablecell")
	self._scrollList = ScrollerList.create(self.scrollerGo, self.cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._mainRect = self.scrollerGo:GetComponent(goutil.Type_RectTransform)
	self._txtScore = self:getTxt("score/txt")
end

function PinGameRewardView:bindEvents()
	PinGameRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function PinGameRewardView:unbindEvents()
	PinGameRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PinGameRewardView:onEnter()
	PinGameRewardView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PinGameGainPrizeRes, self._onPinGameGainPrizeRes, self)

	self._activityId = self:getFirstParam()
	self._curCanGetRewardIndex = nil
	self._scrollerListDic = {}
	self._uiEffectList = {}

	local cfgs = PinGameConfig.instance:getScorePrizeList(self._activityId)

	self._scrollList:reloadData(cfgs)

	self._txtScore.text = string.format("个人累计积分：%d", PinGameModel.instance:getScore(self._activityId))
end

function PinGameRewardView:onExit()
	PinGameRewardView.super.onExit(self)
	self._scrollList:dispose()

	for k, v in pairs(self._scrollerListDic) do
		v:dispose()
	end

	for i, v in ipairs(self._uiEffectList) do
		UIEffectManager.instance:stopEffect(v)
	end

	table.clear(self._uiEffectList)
end

function PinGameRewardView:_onPinGameGainPrizeRes()
	self._scrollList:refresh()
end

function PinGameRewardView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "tableview1/viewport/txtDesc")
	local icon = goutil.findChild(cell, "icon")
	local cellGo = goutil.findChild(cell, "cell")
	local lock = goutil.findChild(cell, "lock")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txtLock")
	local curScore = PinGameModel.instance:getScore(self._activityId)
	local isUnlock = curScore >= data.needScore

	txtName.text = data.name

	if isUnlock then
		txtDesc.text = data.desc or ""
	end

	goutil.setActive(lock, not isUnlock)

	txtLock.text = not isUnlock and string.format("个人累计获得%d积分解锁", data.needScore) or ""

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, data.iconPath)

	local arr = MaterialMgr.changeItemStrArr(data.prize)
	local scrollerGo = goutil.findChild(cell, "tableview")

	if not self._scrollerListDic[cell] then
		local cellGo = goutil.findChild(cell, "tablecell")

		self._scrollerListDic[cell] = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
	end

	local num = #arr
	local pos = GameUtil.getAnchoredPos(scrollerGo)

	pos.x = num == 1 and 110 or num == 2 and 60 or 18

	GameUtil.setAnchoredPos(scrollerGo, pos.x, pos.y)

	local list = {}

	for i, v in ipairs(arr) do
		local info = {}

		info.str = v
		info.needScore = data.needScore
		info.prizeId = data.prizeId

		table.insert(list, info)
	end

	self._scrollerListDic[cell]:reloadData(list)

	if not self._curCanGetRewardIndex then
		local isCanGet = PinGameModel.instance:isCanGetPrize(self._activityId, data.needScore)
		local isGeted = PinGameModel.instance:isGetedPrize(self._activityId, data.prizeId)

		if isCanGet and not isGeted then
			self._curCanGetRewardIndex = cell.index
		end
	end
end

function PinGameRewardView:_clearCell(cell)
	local reward = goutil.findChild(cell, "reward")
	local icon = goutil.findChild(cell, "icon")

	uGuiUtil.clearImage(icon)
	MaterialMgr.resetAll(reward)

	if self._scrollerListDic[cell] then
		self._scrollerListDic[cell]:dispose()
	end
end

function PinGameRewardView:_updateRewardCell(view, cell, data, tag)
	local node = goutil.findChild(cell, "node")
	local canGet = goutil.findChild(cell, "canGet")
	local geted = goutil.findChild(cell, "geted")
	local proxy = MaterialMgr.setCellByCfg(data.str, node)
	local isCanGet = PinGameModel.instance:isCanGetPrize(self._activityId, data.needScore)
	local isGeted = PinGameModel.instance:isGetedPrize(self._activityId, data.prizeId)

	goutil.setActive(canGet, isCanGet and not isGeted)
	goutil.setActive(geted, isGeted)

	local matType, id = MaterialMgr.getMatParams(data.str)

	proxy.binder:setAutoTips(false)
	proxy:setCallBack(function()
		if isCanGet and not isGeted then
			PinGameAgent.instance:sendPM_PinGameGainPrizeReq(self._activityId, data.prizeId)
		elseif not goutil.isNil(node) then
			CommonTipsMgr.instance:openMaterialTips(node, matType, id, 0)
		end
	end)

	if not self._uiEffectList[cell] then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local uiEffect = UIEffectManager.instance:playEffect(self, effPath, canGet.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._mainRect) then
				eff:setClipping(self._mainRect)
			end
		end)

		uiEffect:setParent(canGet.transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)

		self._uiEffectList[cell] = uiEffect
	end
end

function PinGameRewardView:_clearRewardCell(cell)
	local node = goutil.findChild(cell, "node")

	MaterialMgr.resetAll(node)
end

function PinGameRewardView:_onReloadFinish()
	printInfo("test PinGameRewardView:_onReloadFinish", self._curCanGetRewardIndex)

	if self._curCanGetRewardIndex then
		self._scrollList:MoveCellToBegin(self._curCanGetRewardIndex - 1)
	end
end

return PinGameRewardView
