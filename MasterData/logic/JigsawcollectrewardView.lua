-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/view/JigsawcollectrewardView.lua

module("logic.extensions.jigsawcollect.view.JigsawcollectrewardView", package.seeall)

local JigsawcollectrewardView = class("JigsawcollectrewardView", TableViewComponent)

function JigsawcollectrewardView:ctor()
	JigsawcollectrewardView.super.ctor(self)
end

function JigsawcollectrewardView:buildUI()
	JigsawcollectrewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._progressSlider = self:getGo("tableview/Viewport/Content/progressBar"):GetComponent(typeof(UnityEngine.UI.Slider))
	self._totalText = goutil.findChildTextComponent(self.mainGO, "totalText")
	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
end

function JigsawcollectrewardView:bindEvents()
	JigsawcollectrewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function JigsawcollectrewardView:unbindEvents()
	JigsawcollectrewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function JigsawcollectrewardView:destroyUI()
	JigsawcollectrewardView.super.destroyUI(self)
end

function JigsawcollectrewardView:onEnter()
	JigsawcollectrewardView.super.onEnter(self)
	GlobalDispatcher:addListener(JigsawcollectController.PM_GainJigsawCollectPrizeRes, self._getCollectPrzeRes, self)

	self._effectHandlers = {}

	self:_updateView()
end

function JigsawcollectrewardView:onEnterFinished()
	JigsawcollectrewardView.super.onEnterFinished(self)
end

function JigsawcollectrewardView:onExit()
	JigsawcollectrewardView.super.onExit(self)
	GlobalDispatcher:removeListener(JigsawcollectController.PM_GainJigsawCollectPrizeRes, self._getCollectPrzeRes, self)

	for k, v in pairs(self._effectHandlers) do
		UIEffectManager.instance:stopEffect(v)
	end

	self._effectHandlers = {}
end

function JigsawcollectrewardView:onExitFinished()
	JigsawcollectrewardView.super.onExitFinished(self)
end

function JigsawcollectrewardView:_updateView()
	self._actId = JigsawcollectModel.instance:getActId()

	local cfg = JigsawcollectConfig.instance:getJigsawCfg(self._actId)

	if not cfg then
		return
	end

	local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.JigsawCollect, self._actId)

	self._actEndTime = etime
	self._curViewDatas = JigsawcollectConfig.instance:getCollectPrizePlanCfgs(cfg.collectPrizePlan)
	self._totalChipNum = JigsawcollectModel.instance:getTotalChipNum()

	local len = #self._curViewDatas

	self._totalText.text = string.format("当前进度：%s/%s", self._totalChipNum, self._curViewDatas[len].pieceReq)

	self:reloadData()

	local firstStep = 0.0495
	local step = (1 - firstStep) / (len - 1)
	local firNum = self._curViewDatas[1].pieceReq

	if firNum >= self._totalChipNum then
		self._progressSlider.value = self._totalChipNum / firNum * firstStep
	else
		local value = 0

		for i = 2, #self._curViewDatas do
			if self._curViewDatas[i].pieceReq <= self._totalChipNum then
				value = step + value
			else
				value = value + (self._totalChipNum - self._curViewDatas[i - 1].pieceReq) / (self._curViewDatas[i].pieceReq - self._curViewDatas[i - 1].pieceReq) * step

				break
			end
		end

		self._progressSlider.value = value + firstStep
	end
end

function JigsawcollectrewardView:_onClickbtnClose()
	self:close()
end

function JigsawcollectrewardView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function JigsawcollectrewardView:_cellSize(view, index)
	return 150, 100
end

function JigsawcollectrewardView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell.gameObject, "txtProgress")
	local item = goutil.findChild(cell.gameObject, "item")
	local imgPassed = goutil.findChild(cell.gameObject, "imgPassed")
	local effect = goutil.findChild(cell.gameObject, "effect")
	local dotChange = goutil.findChild(cell.gameObject, "dot"):GetComponent(ComponentType.UIImageSpriteChange)

	dotChange:SetState(data.pieceReq <= self._totalChipNum and 1 or 0)

	txtName.text = MaterialModel.instance:getMaterialsNameByStr(data.prize)
	txtProgress.text = data.pieceReq

	local hasGet = JigsawcollectModel.instance:hasGetCollectReward(self._actId, data.progressId)

	goutil.setActive(imgPassed, hasGet)

	local proxy = MaterialMgr.setCellByCfg(data.prize, item)
	local autoTip = false

	autoTip = not hasGet and not JigsawcollectModel.instance:checkCollectprogressRewardDot(self._actId, data.progressId) or true

	if not self:_isActInTime() then
		autoTip = true
	end

	proxy.binder:setAutoTips(autoTip)

	if autoTip then
		proxy.binder:setCallBack(nil)
	else
		proxy.binder:setCallBack(function()
			if not self:_isActInTime() then
				FloatWordMgr.instance:show("不在活动时间内")
				self:reloadData()

				return
			end

			JigsawAgent.instance:sendPM_GainJigsawCollectPrizeReq(self._actId, data.progressId)
		end)
	end

	local handler = self._effectHandlers[effect]

	if handler then
		UIEffectManager.instance:stopEffect(handler)
	end

	if not autoTip then
		local function loalBack()
			handler:setScrollRectClipping(self._scrollRect)
		end

		handler = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", nil, nil, nil, true, nil, nil, loalBack)

		handler:setParent(effect.transform)
		handler:setScale(1)
		handler:setLocalPos(0, 0, 0)

		self._effectHandlers[effect] = handler
	end
end

function JigsawcollectrewardView:_clearTableview(cell)
	local item = goutil.findChild(cell.gameObject, "item")

	MaterialMgr.resetAll(item)
end

function JigsawcollectrewardView:_getCollectPrzeRes(status)
	if status == 0 then
		self:_updateView()
	end
end

function JigsawcollectrewardView:_isActInTime()
	return self._actEndTime > ServerTime.now()
end

return JigsawcollectrewardView
