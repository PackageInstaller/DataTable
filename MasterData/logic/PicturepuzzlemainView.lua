-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/picturepuzzle/view/PicturepuzzlemainView.lua

module("logic.extensions.picturepuzzle.view.PicturepuzzlemainView", package.seeall)

local PicturepuzzlemainView = class("PicturepuzzlemainView", ViewComponent)

function PicturepuzzlemainView:ctor()
	PicturepuzzlemainView.super.ctor(self)
end

function PicturepuzzlemainView:buildUI()
	PicturepuzzlemainView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._view = ScrollerList.create(self:getGo("view"), self:getGo("cell"), GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._timeText = self:getTxt("time/Text")
	self._roleBtn = self:getBtn("role")
	self._roleBubbleGo = self:getGo("role/bubble")
	self._roleBubble = self:getTxt("role/bubble/Text")
	self._tipBtn = self:getBtn("btnTip")
end

function PicturepuzzlemainView:bindEvents()
	PicturepuzzlemainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._roleBtn:AddClickListener(self._onClickRole, self)
	self._tipBtn:AddClickListener(self._onClickTip, self)
end

function PicturepuzzlemainView:unbindEvents()
	PicturepuzzlemainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._roleBtn:RemoveClickListener()
	self._tipBtn:RemoveClickListener()
end

function PicturepuzzlemainView:onEnter()
	PicturepuzzlemainView.super.onEnter(self)

	self._activityInfo = PicturepuzzleController.instance:getOpenInfo()

	if self._activityInfo == nil then
		self:close()
		print("dengsong 没有开启的拼图活动")

		return
	end

	GlobalDispatcher:addListener(PicturepuzzleController.PM_PuzzleJigsawGetInfoRes, self._handlePM_PuzzleJigsawGetInfoRes, self)
	GlobalDispatcher:addListener(PicturepuzzleController.PM_PuzzleJigsawStartGameRes, self._handlePM_PuzzleJigsawStartGameRes, self)

	self._cellEff = {}

	PuzzleJigsawAgent.instance:sendPM_PuzzleJigsawGetInfoReq(self._activityInfo.id)

	self._timeValue = 0

	goutil.setActive(self._roleBubbleGo, true)

	local startT = os.date("*t", self._activityInfo.startTime + 86400 * (self._activityInfo.gainDay - 1))

	self._roleBubble.text = string.format("成功拼完%d张拼图，即可在%d月%d日 %d:%02d 后领取大奖！", #self._activityInfo, startT.month, startT.day, startT.hour, startT.min)
	self._viewEff = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_xinxiya_jiemianfenwei.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
	end)

	self:_handlePM_PuzzleJigsawGetInfoRes()
end

function PicturepuzzlemainView:onExit()
	PicturepuzzlemainView.super.onExit(self)
	GlobalDispatcher:removeListener(PicturepuzzleController.PM_PuzzleJigsawGetInfoRes, self._handlePM_PuzzleJigsawGetInfoRes, self)
	GlobalDispatcher:removeListener(PicturepuzzleController.PM_PuzzleJigsawStartGameRes, self._handlePM_PuzzleJigsawStartGameRes, self)
	removetimer(self._timer, self)
	self._view:dispose()
	UIEffectManager.instance:stopEffect(self._viewEff)

	for k, v in pairs(self._cellEff) do
		UIEffectManager.instance:stopEffect(v)
	end
end

function PicturepuzzlemainView:_handlePM_PuzzleJigsawGetInfoRes(msg)
	msg = msg or {}
	self._lockTime = {}

	for i, v in ipairs(self._activityInfo) do
		for j, id in ipairs(msg.accomplishIds or {}) do
			if v.planId == id then
				v.state = 1
			end
		end

		for j, id in ipairs(msg.gainJigsawPrizeIds or {}) do
			if v.planId == id then
				v.state = 2
			end
		end
	end

	self._activityInfo.isGainFinalPrize = msg.isGainFinalPrize

	self._view:reloadData(self._activityInfo)
	self:_timer()
	removetimer(self._timer, self)
	settimer(1, self._timer, self, true)
end

function PicturepuzzlemainView:_handlePM_PuzzleJigsawStartGameRes(msg)
	UIStateManager.instance:push(ViewName.PicturepuzzleView, self._opData, self._clientKey, msg.encryptedKey, self._activityInfo.id)
end

function PicturepuzzlemainView:_updateCell(view, cell, data)
	local lock = ServerTime.now() < self._activityInfo.startTime + 86400 * (data.openDay - 1)
	local lockGo, unlockGo = goutil.findChild(cell.gameObject, "lock"), goutil.findChild(cell.gameObject, "unlock")

	goutil.setActive(lockGo, lock)
	goutil.setActive(unlockGo, not lock)

	if lock then
		self:_updateLockCell(lockGo, data, cell)
	else
		self:_updateUnLockCell(unlockGo, data, cell)
	end
end

function PicturepuzzlemainView:_updateLockCell(lockGo, data, cell)
	self._lockTime[lockGo] = self._lockTime[lockGo] or {
		txt = goutil.findChildTextComponent(lockGo, "opTime"),
		opTime = self._activityInfo.startTime + 86400 * (data.openDay - 1)
	}

	local dateT = os.date("*t", self._lockTime[lockGo].opTime)

	self._lockTime[lockGo].txt.text = string.format("%d月%d日 %02d:%02d 后可开启拼图", dateT.month, dateT.day, dateT.hour, dateT.min)

	if self._cellEff[cell] == nil then
		self._cellEff[cell] = UIEffectManager.instance:playEffect(self, "fx_ui_xinxiyamianban/fx_ui_xinxiya_jiemiandaijiesuo.prefab", nil, nil, nil, true, nil, nil, function(_, eff)
			eff:setParent(lockGo.transform)
			eff:setScale(1)
			eff:setLocalPos(1.5, -16.5)
		end)
	end
end

function PicturepuzzlemainView:_updateUnLockCell(unlockGo, data, cell)
	if self._cellEff[cell] then
		UIEffectManager.instance:stopEffect(self._cellEff[cell])

		self._cellEff[cell] = nil
	end

	local imagUrl

	if data.state == 2 then
		Framework.ButtonAdapter.GetFrom(unlockGo, "btn"):RemoveClickListener()

		goutil.findChildTextComponent(unlockGo, "btn/Text").text = "已领奖"
		imagUrl = GameUrl.getBigbgPngUrl("picturepuzzle/" .. data.icon)

		Framework.ButtonAdapter.GetFrom(unlockGo, "icon"):AddClickListener(function()
			UIStateManager.instance:push(ViewName.PicturepuzzleshareView, data.shareIcon, data.shareId)
		end)
	elseif data.state == 1 then
		Framework.ButtonAdapter.GetFrom(unlockGo, "btn"):AddClickListener(function()
			PicturepuzzleController.instance:sendPM_PuzzleJigsawGainPrizeReq(self._activityInfo.id, data.planId)
		end)

		goutil.findChildTextComponent(unlockGo, "btn/Text").text = "领取奖励"
		imagUrl = GameUrl.getBigbgPngUrl("picturepuzzle/" .. data.icon)

		Framework.ButtonAdapter.GetFrom(unlockGo, "icon"):AddClickListener(function()
			UIStateManager.instance:push(ViewName.PicturepuzzleshareView, data.shareIcon, data.shareId)
		end)
	else
		Framework.ButtonAdapter.GetFrom(unlockGo, "btn"):AddClickListener(function()
			math.randomseed(ServerTime.nowMs())

			self._opData = data
			self._clientKey = math.random(0, 16384)

			UIStateManager.instance:push(ViewName.PicturepuzzleView, self._opData, self._clientKey, 1111, self._activityInfo.id)
		end)

		goutil.findChildTextComponent(unlockGo, "btn/Text").text = "前往拼图"
		imagUrl = GameUrl.getBigbgPngUrl("picturepuzzle/" .. data.grayIcon)

		Framework.ButtonAdapter.GetFrom(unlockGo, "icon"):RemoveClickListener()
	end

	goutil.setActive(goutil.findChild(unlockGo, "btn/red"), data.state == 0 or data.state == nil)
	uGuiUtil.setSpriteToImage(goutil.findChild(unlockGo, "icon"), uGuiUtil.SpriteType.BigBg, imagUrl)

	local prizeStr = string.split(data.prize, "#")

	for i = 1, 3 do
		if prizeStr[i] then
			local proxy = MaterialMgr.setCellByCfg(prizeStr[i], goutil.findChild(unlockGo, "item/" .. i))

			Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.8, 0.8, 1)
		else
			goutil.setActive(goutil.findChild(unlockGo, "item/" .. i), false)
		end
	end
end

function PicturepuzzlemainView:_clearCell(cell)
	uGuiUtil.clearImage(goutil.findChild(cell.gameObject, "lock/icon"))
	uGuiUtil.clearImage(goutil.findChild(cell.gameObject, "unlock/icon"))
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "unlock/btn"):RemoveClickListener()

	for i = 1, 3 do
		MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "unlock/item/" .. i))
	end
end

function PicturepuzzlemainView:_onClickRole()
	local flag = true

	for i, v in ipairs(self._activityInfo) do
		if v.state == nil then
			flag = false

			break
		end
	end

	UIStateManager.instance:push(ViewName.PicturepuzzlefinalView, self._activityInfo, flag)
end

function PicturepuzzlemainView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "picturepuzzle")
end

function PicturepuzzlemainView:_timer()
	goutil.setActive(self._roleBubbleGo, self._timeValue <= 4)

	local _timeValue = self._activityInfo.endTime - ServerTime.now()

	self._timeText.text = string.format("剩余时间:%s", GameUtil.FormatTimeSymbol(_timeValue))

	local endKey = {}

	for k, value in pairs(self._lockTime) do
		if value.opTime <= ServerTime.now() then
			table.insert(endKey, k)
		end
	end

	if #endKey > 0 then
		for i, v in ipairs(endKey) do
			self._lockTime[v] = nil

			self._view:reloadData(self._activityInfo)
		end
	end

	self._timeValue = (self._timeValue + 1) % 7

	if _timeValue <= 0 then
		removetimer(self._timer, self)
		UIStateManager.instance:popByName(ViewName.PicturepuzzleView)
		UIStateManager.instance:popByName(ViewName.PicturepuzzleshareView)
		UIStateManager.instance:popByName(ViewName.PicturepuzzlefinalView)
	end
end

return PicturepuzzlemainView
