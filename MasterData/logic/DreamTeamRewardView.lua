-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamteam/view/DreamTeamRewardView.lua

module("logic.extensions.dreamteam.view.DreamTeamRewardView", package.seeall)

local DreamTeamRewardView = class("DreamTeamRewardView", ViewComponent)
local EnumState = {
	CanGet = 2,
	Not = 1,
	Geted = 3
}

function DreamTeamRewardView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._slider = self:getSlider("progress/slider")
	self._txtProgress = self:getTxt("progress/txtProgress")
	self._items = {}

	for i = 1, 2 do
		local item = {}

		item.btn = Framework.ButtonAdapter.GetFrom(self.mainGO, "item" .. i)
		item.iconGo = goutil.findChild(self.mainGO, string.format("item%d/icon", i))
		item.raycastGo = goutil.findChild(self.mainGO, string.format("item%d/raycastGo", i))
		item.rectTrans = item.raycastGo:GetComponent(goutil.Type_RectTransform)
		item.canGet = goutil.findChild(self.mainGO, string.format("item%d/canGet", i))
		item.geted = goutil.findChild(self.mainGO, string.format("item%d/geted", i))
		item.txtNum = goutil.findChildTextComponent(self.mainGO, string.format("item%d/txtNum", i))
		self._items[i] = item
	end
end

function DreamTeamRewardView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function DreamTeamRewardView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function DreamTeamRewardView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.FlipTouchGainGlobalPrize, self._onGainGlobalPrize, self)

	local param = self:getOpenParam()

	self._curNum = param[1]
	self._planId = param[2]
	self._activityId = param[3]
	self._txtProgress.text = self._curNum or 0

	self:_setRewards(self._planId, self._curNum)
	self:_setState(self._planId, self._curNum)
	self:_setSlider(self._planId, self._curNum)
end

function DreamTeamRewardView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.FlipTouchGainGlobalPrize, self._onGainGlobalPrize, self)
	self:_removeRewards()
	self:_removeEffect()
	self:_removeListener()
end

function DreamTeamRewardView:_onClickClose()
	self:close()
end

function DreamTeamRewardView:_onGainGlobalPrize()
	self:_setState(self._planId, self._curNum)
	self:_setSlider(self._planId, self._curNum)
	self:_onClickClose()
end

function DreamTeamRewardView:_setRewards(planId, curNum)
	local cfgPrizes = DreamTeamConfig.instance:getGlobalPrizeCfgs(planId)

	for i = 1, 2 do
		MaterialMgr.setCellByCfg(cfgPrizes[i].prize, self._items[i].iconGo)
		self:_setUIEffect(self._items[i].canGet, self._items[i].rectTrans)

		local id = cfgPrizes[i].id
		local activityId = self._activityId

		self._items[i].btn:AddClickListener(function()
			if DreamTeamModel.instance:isGetedGlobalPrize(cfgPrizes[i].id) then
				FloatWordMgr.instance:show("奖励已领取")
			elseif curNum >= cfgPrizes[i].globalGainNum then
				DreamTeamController.instance:sendFlipTouchGainGlobalPrizeReq(activityId, id)
			end
		end)
	end
end

function DreamTeamRewardView:_removeListener()
	for i = 1, 2 do
		self._items[i].btn:RemoveClickListener()
	end
end

function DreamTeamRewardView:_setState(planId, curNum)
	local cfgPrizes = DreamTeamConfig.instance:getGlobalPrizeCfgs(planId)

	for i = 1, 2 do
		self._items[i].txtNum.text = cfgPrizes[i].globalGainNum

		local state = EnumState.Not

		if DreamTeamModel.instance:isGetedGlobalPrize(cfgPrizes[i].id) then
			state = EnumState.Geted

			goutil.setActive(self._items[i].canGet, false)
			goutil.setActive(self._items[i].geted, true)
			goutil.setActive(self._items[i].raycastGo, true)
		elseif curNum >= cfgPrizes[i].globalGainNum then
			state = EnumState.CanGet

			goutil.setActive(self._items[i].canGet, true)
			goutil.setActive(self._items[i].geted, false)
			goutil.setActive(self._items[i].raycastGo, true)
		else
			goutil.setActive(self._items[i].canGet, false)
			goutil.setActive(self._items[i].geted, false)
			goutil.setActive(self._items[i].raycastGo, false)
		end
	end
end

function DreamTeamRewardView:_removeRewards()
	for i = 1, 2 do
		MaterialMgr.resetAll(self._items[i].iconGo)
	end
end

function DreamTeamRewardView:_setUIEffect(parent, rectTrans)
	self._effects = self._effects or {}

	local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", parent.transform, 0, 0, true, false, nil, function(target, eff)
		if rectTrans then
			eff:setClipping(rectTrans)
		end
	end)

	effect:setParent(parent.transform)
	effect:setScale(1)
	table.insert(self._effects, effect)
end

function DreamTeamRewardView:_removeEffect()
	if self._effects then
		for i, v in ipairs(self._effects) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._effects)

		self._effects = nil
	end
end

function DreamTeamRewardView:_setSlider(planId, curNum)
	local cfgPrizes = DreamTeamConfig.instance:getGlobalPrizeCfgs(planId)
	local sliderNum = 0
	local unitLength = 0.4
	local globalGainNum1 = cfgPrizes[1].globalGainNum
	local globalGainNum2 = cfgPrizes[2].globalGainNum

	if curNum <= globalGainNum1 then
		sliderNum = unitLength * (curNum / globalGainNum1)
	elseif curNum <= globalGainNum2 then
		sliderNum = unitLength
		sliderNum = unitLength + unitLength * ((curNum - globalGainNum1) / (globalGainNum2 - globalGainNum1))
	else
		sliderNum = 1
	end

	self._slider:SetValue(sliderNum)
end

return DreamTeamRewardView
