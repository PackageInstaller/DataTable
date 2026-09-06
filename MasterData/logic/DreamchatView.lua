-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamchat/view/DreamchatView.lua

module("logic.extensions.dreamchat.view.DreamchatView", package.seeall)

local DreamchatView = class("DreamchatView", ViewComponent)

function DreamchatView:ctor()
	DreamchatView.super.ctor(self)

	self._actId = 18003
end

function DreamchatView:buildUI()
	DreamchatView.super.buildUI(self)

	self._close = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._itemList = {}

	for i = 1, 10 do
		local obj = self:getGo(string.format("item%d", i))

		table.insert(self._itemList, obj)
	end
end

function DreamchatView:bindEvents()
	DreamchatView.super.bindEvents(self)
	self._close:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(function()
		self:_clickInTip()
	end)
end

function DreamchatView:unbindEvents()
	DreamchatView.super.unbindEvents(self)
	self._close:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function DreamchatView:destroyUI()
	DreamchatView.super.destroyUI(self)
end

function DreamchatView:onEnter()
	DreamchatView.super.onEnter(self)

	self._icons = {}
	self._effects = {}
	self._loginDay = 0
	self._signList = {}
	self._txtTime.text = self:_getOpenTime()
	self._allCfgs = OperationSignInConfig.instance:getSignInCfgList(self._actId)

	if #self._allCfgs > 1 then
		table.sort(self._allCfgs, function(a, b)
			return a.day < b.day
		end)
	end

	self:_updateInfoData()
	self:_sendOperationCheckInGetInfoReq()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._sendOperationCheckInGetInfoReq, self)

	local effPath = "fx_ui_jiuzhounian/fx_ui_jiemian_jiuzhouniandangao.prefab"

	self._showEff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, nil, nil, nil, self)

	self._showEff:setParent(self.mainGO.transform)
	self._showEff:setLocalPos(-250, 0, 0)
	self._showEff:setScale(1)
end

function DreamchatView:onEnterFinished()
	DreamchatView.super.onEnterFinished(self)
end

function DreamchatView:onExit()
	DreamchatView.super.onExit(self)
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._sendOperationCheckInGetInfoReq, self)

	for k, v in pairs(self._effects or {}) do
		UIEffectManager.instance:stopEffect(v)
	end

	for k, v in pairs(self._icons or {}) do
		MaterialMgr.clearIcon(v)
		MaterialMgr.resetAll(v)
	end

	if self._showEff then
		UIEffectManager.instance:stopEffect(self._showEff)
	end

	if self._flyEff then
		UIEffectManager.instance:stopEffect(self._flyEff)
	end
end

function DreamchatView:onExitFinished()
	DreamchatView.super.onExitFinished(self)
end

function DreamchatView:_sendOperationCheckInGetInfoReq()
	OperationCheckInAgent.instance:sendPM_OperationCheckInGetInfoReq(self._actId, function(msg)
		if checknumber(msg.onlineDay) > 0 then
			self._loginDay = msg.onlineDay
		end

		if msg.hasGainPrizeDays then
			self._signList = msg.hasGainPrizeDays
		end

		self:_updateInfoData()
	end)
end

function DreamchatView:_updateInfoData()
	self._curViewDatas = {}

	for _, cfg in pairs(self._allCfgs or {}) do
		if cfg and not string.nilorempty(cfg.reward) then
			local data = {}

			data.day = cfg.day
			data.goodsList = string.split(cfg.reward, ":")
			data.stageNum = self:_getItemStage(cfg.day)

			table.insert(self._curViewDatas, data)
		end
	end

	for i, v in ipairs(self._itemList) do
		self:_updateCell(i, v, self._curViewDatas[i])
	end
end

function DreamchatView:_updateCell(index, cell, data)
	local iconGo = goutil.findChild(cell, "con")
	local receivedGo = goutil.findChild(cell, "receive")
	local txtNum = goutil.findChildTextComponent(cell, "txtNum")

	receivedGo:SetActive(data.stageNum == 3)

	txtNum.text = "x" .. data.goodsList[3]

	if data.goodsList and #data.goodsList > 2 then
		local itemType, id, num = checknumber(data.goodsList[1]), checknumber(data.goodsList[2]), checknumber(data.goodsList[3])

		MaterialMgr.setIcon(iconGo, itemType, id)

		self._icons[data.day] = iconGo
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		self:_OnClickAwardBtn(data, cell)
	end, self)

	if self._effects[cell] == nil and data.stageNum == 1 then
		self._effects[cell] = self:_creatEffect(cell, index)
	elseif self._effects[cell] and data.stageNum ~= 1 then
		UIEffectManager.instance:stopEffect(self._effects[cell])
	end
end

function DreamchatView:_OnClickAwardBtn(data, cell)
	if data.stageNum == 1 then
		OperationCheckInAgent.instance:sendPM_OperationCheckInGainPrizeReq(self._actId, data.day, function(msg)
			self._signList = self._signList or {}

			table.insert(self._signList, data.day)
			self:_updateInfoData()

			self.curRewardDay = data.day
		end)
	else
		CommonTipsMgr.instance:openTipsByConfStr(cell, table.concat(data.goodsList, ":"))
	end
end

function DreamchatView:_getItemStage(day)
	for k, coun in pairs(self._signList or {}) do
		if k and checknumber(coun) > 0 and day == coun then
			return 3
		end
	end

	if day <= self._loginDay then
		return 1
	end

	return 2
end

function DreamchatView:_creatEffect(cell, index)
	local scaleX = (index == 1 or index == 3) and 1.08 or 0.5
	local effect
	local path = "common/fx_ui_kuang2_common.prefab"

	local function loadCallBack(target, eff)
		eff:setClipping(cell.transform)
	end

	effect = UIEffectManager.instance:playEffect(self, path, cell, 0, 0, true, false, nil, loadCallBack)

	effect:setParent(cell.transform)
	effect:setScaleXYZ(scaleX, 1, 1.15)
	effect:setLocalPos(-3.3, 13)

	return effect
end

function DreamchatView:_clickInTip()
	local ruleCo = RulesConfig.instance:getRuleCo("dreamchatview")

	TipsFacade.instance:openTipWindowNoX(ruleCo.title, ruleCo.rules)
end

function DreamchatView:_getOpenTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.SignIn, self._actId)
	local startDate = os.date("*t", startTime)
	local endDate = os.date("*t", endTime)

	return string.format("活动时间：%02d.%02d %02d:%02d - %02d.%02d %02d:%02d", startDate.month, startDate.day, startDate.hour, startDate.min, endDate.month, endDate.day, endDate.hour, endDate.min)
end

return DreamchatView
