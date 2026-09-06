-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/theater/view/DreamTheaterView.lua

module("logic.extensions.theater.view.DreamTheaterView", package.seeall)

local DreamTheaterView = class("DreamTheaterView", ViewComponent)

function DreamTheaterView:ctor()
	DreamTheaterView.super.ctor(self)
end

function DreamTheaterView:buildUI()
	DreamTheaterView.super.buildUI(self)

	self._closeBtn = self:getBtn("bg/close")
	self._ruleA = self:getGo("bg/A")
	self._ruleB = self:getGo("bg/B")
	self._cells = {}
	self._gains = {}
	self._itemNums = {}
	self._effs = {}
	self._effGos = {}
	self._btns = {}

	for i = 1, 10 do
		self._cells[i] = self:getGo("reward/cell_" .. i)
		self._gains[i] = goutil.findChild(self._cells[i], "gain")
		self._itemNums[i] = goutil.findChildTextComponent(self._cells[i], "txtNum")
		self._effGos[i] = goutil.findChild(self._cells[i], "eff")
		self._btns[i] = Framework.ButtonAdapter.GetFrom(self._cells[i], "btn")
	end

	self._time = self:getTxt("txtBg/time")
	self._playbackBtn = self:getBtn("playbackBtn")
end

function DreamTheaterView:bindEvents()
	DreamTheaterView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)

	for i = 1, 10 do
		self._btns[i]:AddClickListener(function()
			self:_onClickReward(i)
		end)
	end

	self._playbackBtn:AddClickListener(self._onClickPlayBack, self)
end

function DreamTheaterView:unbindEvents()
	DreamTheaterView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()

	for i = 1, 10 do
		self._btns[i]:RemoveClickListener()
	end

	self._playbackBtn:RemoveClickListener()
end

function DreamTheaterView:destroyUI()
	DreamTheaterView.super.destroyUI(self)
end

function DreamTheaterView:onEnter()
	DreamTheaterView.super.onEnter(self)

	self._onExit = false

	local activityId = tonumber(TheaterConfig.instance:getConfigValueByKey("DREAM_ACTIVE_ID"))

	OperationSignInModel.instance:setActivityId(activityId)

	self._prizeList = OperationSignInConfig.instance:getSignInCfgList(activityId)

	table.sort(self._prizeList, function(a, b)
		return a.day < b.day
	end)

	for i = 1, 10 do
		local proxy = MaterialMgr.setCellByCfg(self._prizeList[i].reward, goutil.findChild(self._cells[i], "item"))

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setBgActive(false)

			local sp = string.split(self._prizeList[i].reward, ":")

			self._itemNums[i].text = "x" .. sp[3]

			proxy.binder:setNum(0)

			if i == 2 then
				proxy.binder:setEffStatus(false)
			end
		end

		Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.8, 0.8, 1)
	end

	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(activityId, function(msg)
		if self._onExit then
			return
		end

		for i = 1, 10 do
			local gainFlag = false

			for ii, v in ipairs(msg.hasGainPrizeDays) do
				if v == i then
					gainFlag = true

					break
				end
			end

			goutil.setActive(self._gains[i], gainFlag)

			if not gainFlag and i <= msg.onlineDay then
				self._effs[i] = UIEffectManager.instance:playEffect(self, "common/fx_ui_kuang2_common.prefab", nil, 0, 0, true, false, nil, function(target, eff)
					eff.effGo.transform:SetParent(self._effGos[i].transform)
					GameUtil.setAnchoredPos(eff.effGo, -2.86, 0)

					if i == 2 or i == 9 then
						GameUtil.setLocalScale(eff.effGo, 0.83, 1, 0.8)
					else
						GameUtil.setLocalScale(eff.effGo, 0.37, 1, 0.8)
					end
				end)
			end
		end
	end)

	self._stopExpressionParam = {}
	self._stopDialogParam = {}
	self._waitQueue = {}

	local activityId, theaterId = tonumber(TheaterConfig.instance:getConfigValueByKey("DREAM_ACTIVE_ID")), 0
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn, activityId)
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(ServerTime.now() - startTime)

	day = day + 1

	if day < 1 then
		day = 1
	end

	local dreamTheater = TheaterConfig.instance:getDreamTheater()

	for i, v in ipairs(dreamTheater) do
		if v.activityId == activityId and v.day == day then
			theaterId = v.theaterId
			self._todayCfg = v

			break
		end
	end

	for i = 1, 14 do
		self._modelA = TheaterController.instance:registerRule(i, "ruleA", self._ruleA)
		self._modelB = TheaterController.instance:registerRule(i, "ruleB", self._ruleB)
	end

	self._theaterId = theaterId

	if self._todayCfg.before == 1 then
		TheaterController.instance:play(theaterId, 1, self._theaterStop, self)
	end

	if endTime > ServerTime.now() then
		local date = os.date("*t", endTime - ServerTime.now())

		self._endTime = endTime
		self._time.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(self._endTime - ServerTime.now()))

		settimer(1, self._timer, self, true)
	else
		self._time.text = "活动已结束"
	end
end

function DreamTheaterView:onEnterFinished()
	DreamTheaterView.super.onEnterFinished(self)
end

function DreamTheaterView:onExit()
	DreamTheaterView.super.onExit(self)

	self._onExit = true

	OperationSignInModel.instance:setActivityId()
	TheaterController.instance:stop()
	TheaterController.instance:clearExpressionRes()

	for i = 1, 10 do
		if self._effs[i] then
			UIEffectManager.instance:stopEffect(self._effs[i])

			self._effs[i] = nil
		end
	end

	removetimer(self._timer, self)

	for i = 1, 10 do
		if i ~= 2 and i ~= 9 then
			MaterialMgr.resetAll(goutil.findChild(self._cells[i], "item"))
		end
	end
end

function DreamTheaterView:onExitFinished()
	DreamTheaterView.super.onExitFinished(self)
end

function DreamTheaterView:_onClickReward(index)
	if self._effs[index] then
		OperationSignInController.instance:gainPrize(index, function()
			UIEffectManager.instance:stopEffect(self._effs[index])

			self._effs[index] = nil

			goutil.setActive(self._gains[index], true)

			if self._todayCfg.after == 1 then
				if self._todayCfg.before == 1 then
					TheaterController.instance:play(self._theaterId, 2, self._theaterStop, self)
				else
					TheaterController.instance:play(self._theaterId, 1, self._theaterStop, self)
				end
			end
		end)
	else
		local sp = string.split(self._prizeList[index].reward, ":")

		CommonTipsMgr.instance:openMaterialTips(self._cells[index], tonumber(sp[1]), tonumber(sp[2]), 0)
	end
end

function DreamTheaterView:_timer()
	self._time.text = string.format("剩余时间:%s", GameUtil.FormatTimeWordsNoSec(self._endTime - ServerTime.now()))
end

function DreamTheaterView:_onClickPlayBack()
	if TheaterController.instance:isPlayComplete() then
		if self._todayCfg.before == 1 then
			TheaterController.instance:play(self._theaterId, 1, self._theaterStop, self)

			if self._gains[self._theaterId].activeSelf and self._todayCfg.after == 1 then
				TheaterController.instance:play(self._theaterId, 2, self._theaterStop, self)
			end
		elseif self._todayCfg.after == 1 then
			TheaterController.instance:play(self._theaterId, 1, self._theaterStop, self)
		end
	end
end

function DreamTheaterView:_theaterStop()
	uGuiUtil.setSpriteToImage(self._modelA.face, uGuiUtil.SpriteType.BigBg, GameUrl.getTheaterUrl(self._modelA.defaultFace.url), function()
		goutil.setActive(self._modelA.face, true)
	end)
	uGuiUtil.setSpriteToImage(self._modelB.face, uGuiUtil.SpriteType.BigBg, GameUrl.getTheaterUrl(self._modelB.defaultFace.url), function()
		goutil.setActive(self._modelA.face, true)
	end)
end

return DreamTheaterView
