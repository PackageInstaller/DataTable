-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfaresignView.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfaresignView", package.seeall)

local NewhandwelfaresignView = class("NewhandwelfaresignView", ViewComponent)

function NewhandwelfaresignView:ctor()
	NewhandwelfaresignView.super.ctor(self)
end

function NewhandwelfaresignView:unbindEvents()
	NewhandwelfaresignView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function NewhandwelfaresignView:bindEvents()
	NewhandwelfaresignView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function NewhandwelfaresignView:buildUI()
	NewhandwelfaresignView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._signCellsGo = self:getGo("signCells")

	self:_getRewardItems()

	self._effectHandles = {}
	self._bg2Go = self:getGo("bg2")
	self._item7Go = self:getGo("signCells/signCell7/item")
end

function NewhandwelfaresignView:_getRewardItems()
	self._rewardItems = {}

	for i = 1, 7 do
		local cell = goutil.findChild(self._signCellsGo, "signCell" .. i)

		goutil.setActive(cell, false)

		local goEffect = goutil.findChild(cell, "effect")
		local goItem = goutil.findChild(cell, "item")
		local goReceive = goutil.findChild(cell, "receive")
		local txtDay = goutil.findChildTextComponent(cell, "txtDay")
		local txtNum = goutil.findChildTextComponent(cell, "txtNum")
		local btn7 = Framework.ButtonAdapter.GetFrom(cell, "item")
		local goEffect2 = goutil.findChild(cell, "effect2")

		if txtNum then
			goutil.setActive(txtNum.gameObject, false)
		end

		self._rewardItems[i] = {
			goEffect = goEffect,
			goItem = goItem,
			goReceive = goReceive,
			txtDay = txtDay,
			txtNum = txtNum,
			mainGO = cell,
			btn7 = btn7,
			goEffect2 = goEffect2
		}
	end
end

function NewhandwelfaresignView:onExit()
	NewhandwelfaresignView.super.onExit(self)

	for k, handler in pairs(self._effectHandles) do
		UIEffectManager.instance:stopEffect(handler)
	end

	self._effectHandles = {}

	GlobalDispatcher:removeListener(NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, self._NewHandWelfareGainSignInPrizeRes, self)
	uGuiUtil.clearImage(self._bg2Go)
	uGuiUtil.clearImage(self._item7Go)
end

function NewhandwelfaresignView:onEnter()
	NewhandwelfaresignView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()

	GlobalDispatcher:addListener(NewhandwelfareController.NewHandWelfareGainSignInPrizeRes, self._NewHandWelfareGainSignInPrizeRes, self)
	self:_setReward()
	self:_loadBtn7Icon()
	self:_loadBg2Icon()
end

function NewhandwelfaresignView:_onClickbtnClose()
	self:close()
end

function NewhandwelfaresignView:_setReward()
	local cfgs = NewhandwelfareConfig.instance:getSignInRewardCfgs(self._periodId) or {}

	for i, cfg in ipairs(cfgs) do
		local item = self._rewardItems[i]

		if item == nil then
			break
		end

		goutil.setActive(item.mainGO, true)

		local isReceive = NewhandwelfareModel.instance:isGainSignInPrize(cfg.day)
		local canGain = NewhandwelfareModel.instance:checkCanGainSingInPrize(self._periodId, cfg.day)
		local arr = string.split(cfg.prize, ":")

		goutil.setActive(item.goReceive, isReceive)

		item.txtDay.text = string.format("第%s天", cfg.day)

		local proxy

		if i ~= 7 then
			proxy = MaterialMgr.setCellByCfg(cfg.prize, item.goItem)

			proxy.binder:setAutoTips(not canGain)
		end

		local handler = self._effectHandles[item.goEffect]

		if handler then
			UIEffectManager.instance:stopEffect(handler)
		end

		local handler2 = self._effectHandles[item.goEffect2]

		if handler2 then
			UIEffectManager.instance:stopEffect(handler2)
		end

		if not isReceive and item.goEffect2 then
			local effName = "fx_ui_xinshourenwu/fx_ui_dailingqu_xiaolian2.prefab"

			handler2 = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

			handler2:setParent(item.goEffect2.transform)
			handler2:setLocalPos(0, 0, 0)
			handler2:setLocalEulerAngle(0, 0, 0)
			handler2:setScale(1)

			self._effectHandles[item.goEffect2] = handler2
		end

		if canGain then
			handler = UIEffectManager.instance:playEffect(self, (i == 7 or nil) and "fx_ui_xinshourenwu/fx_ui_dailingqu_changfangxingren.prefab", nil, 0, 0, true)

			handler:setParent(item.goEffect.transform)

			if i ~= 7 then
				handler:setLocalPos(0, 3, 0)
				handler:setLocalEulerAngle(0, 0, 2)
				handler:setScale(1)
			else
				handler:setLocalPos(46, 51, 0)
				handler:setLocalEulerAngle(0, 0, 2)
				handler:setScale(1)
			end

			self._effectHandles[item.goEffect] = handler

			if proxy then
				proxy.binder:setCallBack(function()
					NewHandWelfareAgent.instance:sendNewHandWelfareGainSignInPrizeReq(cfg.day)
				end)
			end
		elseif proxy then
			proxy.binder:setCallBack(nil)
		end

		if item.btn7 then
			item.btn7:AddClickListener(function()
				if not canGain then
					CommonTipsMgr.instance:openTipsByConfStr(item.btn7, cfg.prize)

					return
				end

				NewHandWelfareAgent.instance:sendNewHandWelfareGainSignInPrizeReq(cfg.day)
			end)
		end
	end
end

function NewhandwelfaresignView:_NewHandWelfareGainSignInPrizeRes(status)
	if status == 0 then
		self:_setReward()
	end
end

function NewhandwelfaresignView:_loadBtn7Icon()
	local resPath = NewhandwelfareConfig.instance:getSignInResPath(self._periodId, "7DayIcon")

	if not resPath then
		return
	end

	uGuiUtil.setSpriteToImage(self._item7Go, nil, resPath)
end

function NewhandwelfaresignView:_loadBg2Icon()
	local resPath = NewhandwelfareConfig.instance:getSignInResPath(self._periodId, "leftIcon")

	if not resPath then
		return
	end

	uGuiUtil.setSpriteToImage(self._bg2Go, nil, resPath)
end

return NewhandwelfaresignView
