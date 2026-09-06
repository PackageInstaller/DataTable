-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/planetarium/view/PlanetariumLotteryView.lua

module("logic.extensions.planetarium.view.PlanetariumLotteryView", package.seeall)

local PlanetariumLotteryView = class("PlanetariumLotteryView", ViewComponent)

function PlanetariumLotteryView:ctor()
	PlanetariumLotteryView.super.ctor(self)

	self._numberLoop = NumberLoop.New()
end

function PlanetariumLotteryView:buildUI()
	PlanetariumLotteryView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._cell = self:getGo("cell")

	goutil.setActive(self._cell, false)

	self._rewards = self:getGo("rewards")
	self._cellList = {}

	for i = 1, 9 do
		local go = goutil.cloneAndSetParent(self._cell, self._rewards.transform, "cell" .. i)

		goutil.setActive(go, true)

		local item = {}

		item.icon = goutil.findChild(go, "icon")
		item.txtNum = goutil.findChildTextComponent(go, "txtNum")
		item.mask = goutil.findChild(go, "mask")
		item.spriteChange1 = item.mask:GetComponent(ComponentType.UIImageSpriteChange)
		item.spriteChange2 = goutil.findChild(item.mask, "img"):GetComponent(ComponentType.UIImageSpriteChange)
		item.select = goutil.findChild(go, "select")

		table.insert(self._cellList, item)
	end
end

function PlanetariumLotteryView:bindEvents()
	PlanetariumLotteryView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function PlanetariumLotteryView:unbindEvents()
	PlanetariumLotteryView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function PlanetariumLotteryView:onEnter()
	PlanetariumLotteryView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TunTianHelpLotteryRes, self._onLotteryRes, self)

	self._activityId = self:getFirstParam()
	self._cfgPrizes = TunTianHelpConfig.instance:getTthPrizeDataList(self._activityId)
	self._isAnimEnd = false

	self:_initCells()
	self:_sendReq()
	settimer(0, self._onUpdate, self)
end

function PlanetariumLotteryView:onExit()
	PlanetariumLotteryView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TunTianHelpLotteryRes, self._onLotteryRes, self)
	removetimer(self._onUpdate, self)
	self._numberLoop:stop()
	self:_clearCells()
	GlobalDispatcher:dispatch(GlobalNotify.PlanetariumLotteryEnd)
end

function PlanetariumLotteryView:_onClickClose()
	if self._isAnimEnd then
		self:close()
	end
end

function PlanetariumLotteryView:_onLotteryRes()
	local targetPrizeId = TunTianHelpModel.instance:getPrizeIdOfLottery()

	TweenUtil.DoDelay(1, function()
		self:_playAnim(targetPrizeId)
	end)
end

function PlanetariumLotteryView:_sendReq()
	TunTianHelpAgent.instance:sendPM_TunTianHelpLotteryReq(self._activityId)
end

function PlanetariumLotteryView:_initCells()
	for i, v in ipairs(self._cellList) do
		local cfg = self._cfgPrizes[i]

		if cfg then
			local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)

			v.txtNum.text = matNum

			MaterialMgr.setIcon(v.icon, matType, id)
			v.spriteChange1:SetState(cfg.maskType)
			v.spriteChange2:SetState(cfg.maskType)
		end

		goutil.setActive(v.mask, true)
		goutil.setActive(v.select, false)
	end
end

function PlanetariumLotteryView:_updateCells(index)
	for i, v in ipairs(self._cellList) do
		goutil.setActive(v.select, i == index)
	end
end

function PlanetariumLotteryView:_showCell(targetIndex)
	for i, v in ipairs(self._cellList) do
		goutil.setActive(v.mask, false)
	end
end

function PlanetariumLotteryView:_clearCells()
	for i, v in ipairs(self._cellList) do
		MaterialMgr.clearIcon(v.icon)

		v.txtNum.text = ""
	end
end

function PlanetariumLotteryView:_playAnim(targetNum)
	local param = {}

	param.startNum = 1
	param.endNum = 9
	param.targetNum = targetNum
	param.loopNum = 4
	param.duration = 3

	function param.onCompleteCallback()
		self._isAnimEnd = true

		self:_showCell(targetNum)
		MaterialController.instance:showChangeSetInTemp(TunTianHelpModel.instance:getChangeSetIdOfLottery())
		UIStateManager.instance:popByName(ViewName.PlanetariumLotteryView)
	end

	self._numberLoop:initParam(param)
	self._numberLoop:play()
end

function PlanetariumLotteryView:_onUpdate()
	if self._numberLoop:isPlaying() then
		self:_updateCells(self._numberLoop:getCurNum())
	end
end

return PlanetariumLotteryView
