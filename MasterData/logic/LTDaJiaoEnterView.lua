-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luotiandajiao/view/LTDaJiaoEnterView.lua

module("logic.extensions.luotiandajiao.view.LTDaJiaoEnterView", package.seeall)

local LTDaJiaoEnterView = class("LTDaJiaoEnterView", ViewComponent)

function LTDaJiaoEnterView:ctor()
	LTDaJiaoEnterView.super.ctor(self)
end

function LTDaJiaoEnterView:buildUI()
	LTDaJiaoEnterView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnBuff = self:getBtn("btnBuff")
	self._txtBuff = self:getTxt("btnBuff/txtLevel")
	self._buffRedPoint = self:getGo("btnBuff/redPoint")
	self._btnStart = self:getBtn("btnStart")
	self._rewardItem = self:getGo("rewardItem")

	self._rewardItem:SetActive(false)

	self._rewardParentGo = self:getGo("rewardSlider/parent")
	self._rewardSlider = self:getSlider("rewardSlider")
	self._sliderWidth = self._rewardParentGo:GetComponent(goutil.Type_RectTransform).rect.width
	self._btnTip = self:getBtn("btnTip")
end

function LTDaJiaoEnterView:bindEvents()
	LTDaJiaoEnterView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnBuff:AddClickListener(self._onClickBuff, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function LTDaJiaoEnterView:unbindEvents()
	LTDaJiaoEnterView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnBuff:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function LTDaJiaoEnterView:onEnter()
	LTDaJiaoEnterView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.LuoTianDaJiaoGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LuoTianDaJiaoUpgradeRes, self._onBuffUpgradeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.LuoTianDaJiaoGainPrizeRes, self._onGainPrizeRes, self)

	if not self:_isInActivityTime() then
		return
	end

	self:_initRewardItems()

	self._activityId = LTDaJiaoModel.instance:getActivityId()

	LuoTianDaJiaoAgent.instance:sendPM_LuoTianDaJiaoGetInfoReq(self._activityId)
end

function LTDaJiaoEnterView:onExit()
	LTDaJiaoEnterView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LuoTianDaJiaoGetInfoRes, self._onGetInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuoTianDaJiaoUpgradeRes, self._onBuffUpgradeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.LuoTianDaJiaoGainPrizeRes, self._onGainPrizeRes, self)
	self:_removeRewardEffect()
end

function LTDaJiaoEnterView:_onClickClose()
	self:close()
end

function LTDaJiaoEnterView:_onClickBuff()
	if not self:_isInActivityTime() then
		return
	end

	local level = LTDaJiaoModel.instance:getCurBuffLevel()

	if LTDaJiaoModel.instance:isMaxBuffLevel(level) or LTDaJiaoModel.instance:isUpgradeToday() then
		local buffPlanId = LTDaJiaoModel.instance:curBuffPlanId()
		local cfg = LTDaJiaoConfig.instance:getBuffCfgById(buffPlanId, level)

		if cfg then
			UIStateManager.instance:push(ViewName.LTDaJiaoBuffView, cfg.desc)
		end

		return
	end

	LuoTianDaJiaoAgent.instance:sendPM_LuoTianDaJiaoUpgradeReq(self._activityId)
end

function LTDaJiaoEnterView:_onClickStart()
	if not self:_isInActivityTime() then
		return
	end

	UIStateManager.instance:push(ViewName.LTDaJiaoMainView, self._activityId)
end

function LTDaJiaoEnterView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "luotiandajiaochallenge")
end

function LTDaJiaoEnterView:_isInActivityTime()
	if not LTDaJiaoModel.instance:isInActivityTime() then
		self:_popupCloseTip()

		return false
	end

	return true
end

function LTDaJiaoEnterView:_popupCloseTip()
	UIStateManager.instance:closeAllModalViews()
	TipsFacade.instance:openTipWindowNoX("提示", "罗天大醮未在活动时间内哦", function()
		self:_onClickClose()
	end, "确定")
end

function LTDaJiaoEnterView:_onGetInfoRes(isSuccess)
	if isSuccess then
		self:_updateViewByServerData()
	else
		self:_popupCloseTip()
	end
end

function LTDaJiaoEnterView:_onBuffUpgradeRes()
	self:_updateBuffShow()
	FloatWordMgr.instance:show("成功升级到 " .. self._txtBuff.text)
end

function LTDaJiaoEnterView:_onGainPrizeRes()
	self:_updateRewardItems()
end

function LTDaJiaoEnterView:_updateViewByServerData()
	self:_updateBuffShow()
	self:_updateRewardItems(true)
	self:_updateSlider()
end

function LTDaJiaoEnterView:_updateBuffShow()
	local level = LTDaJiaoModel.instance:getCurBuffLevel()

	self._txtBuff.text = string.format("Lv.%d", level)

	self._buffRedPoint:SetActive(not LTDaJiaoModel.instance:isMaxBuffLevel(level) and not LTDaJiaoModel.instance:isUpgradeToday())
end

function LTDaJiaoEnterView:_initRewardItems()
	self:_clearRewardItems()

	self._goLists = {}
	self._infoLists = {}

	local cfgs = LTDaJiaoConfig.instance:getGroupCfgs(LTDaJiaoModel.instance:curGroupPlanId())

	if cfgs and #cfgs > 0 then
		local count = #cfgs

		for i = 1, count do
			local go = goutil.cloneAndSetParent(self._rewardItem, self._rewardParentGo.transform, "rewardItem" .. i)

			go:SetActive(true)

			local element = {}

			element.go = go
			element.node = goutil.findChild(go, "node")
			element.canGet = goutil.findChild(go, "canGet")
			element.geted = goutil.findChild(go, "geted")
			element.txtDesc = goutil.findChildTextComponent(go, "txtDesc")
			element.txtChampion = goutil.findChild(go, "txtChampion")
			element.btnClick = Framework.ButtonAdapter.GetFrom(go, "canGet")
			element.rangeRect = goutil.findChildRectTransformComponent(go, "range")
			self._goLists[i] = element
			self._infoLists[i] = cfgs[i]

			local cfg = cfgs[i]

			element.btnClick:AddClickListener(function()
				if LTDaJiaoModel.instance:isPass(cfg.group) then
					LuoTianDaJiaoAgent.instance:sendPM_LuoTianDaJiaoGainPrizeReq(self._activityId, cfg.group)
				else
					FloatWordMgr.instance:show(string.format("请先通过第%d组后领取哦", cfg.group))
				end
			end)
			element.canGet:SetActive(false)
			element.geted:SetActive(false)

			if i == count then
				element.txtDesc.gameObject:SetActive(false)
				element.txtChampion:SetActive(true)
			else
				element.txtDesc.gameObject:SetActive(true)
				element.txtChampion:SetActive(false)

				element.txtDesc.text = string.format("%d强", cfg.desc)
			end

			MaterialMgr.setCellByCfg(cfgs[i].prize, element.node)

			local x = (i - 1) / (count - 1) * self._sliderWidth

			Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), x, 19)
		end
	end
end

function LTDaJiaoEnterView:_updateRewardItems(isUpdateEffect)
	for i, v in ipairs(self._goLists) do
		local isGeted = LTDaJiaoModel.instance:isGetedReward(self._infoLists[i].group)
		local isCanGet = LTDaJiaoModel.instance:isPass(self._infoLists[i].group)

		v.canGet:SetActive(isCanGet and not isGeted)
		v.geted:SetActive(isGeted)

		if isUpdateEffect and isCanGet and not isGeted then
			self._uiEffectList = self._uiEffectList or {}

			local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", v.canGet.transform, 0, 0, true, false, nil, function(target, eff)
				if v and not goutil.isNil(v.rangeRect) then
					eff:setClipping(v.rangeRect)
				end
			end)

			effect:setParent(v.canGet.transform)
			effect:setScale(0.8)

			effect.hideEffWhileNotOnTop = false

			table.insert(self._uiEffectList, effect)
		end
	end
end

function LTDaJiaoEnterView:_removeRewardEffect()
	if self._uiEffectList then
		for i, v in ipairs(self._uiEffectList) do
			UIEffectManager.instance:stopEffect(v)
		end

		table.clear(self._uiEffectList)

		self._uiEffectList = nil
	end
end

function LTDaJiaoEnterView:_clearRewardItems()
	if self._goLists then
		for i, v in ipairs(self._goLists) do
			MaterialMgr.resetAll(v.node)
			v.btnClick:RemoveClickListener()
		end

		goutil.clearChildren(self._rewardParentGo)

		self._goLists = nil
	end
end

function LTDaJiaoEnterView:_updateSlider()
	local cfgs = LTDaJiaoConfig.instance:getGroupCfgs(LTDaJiaoModel.instance:curGroupPlanId())

	if cfgs and #cfgs > 0 then
		local curCount = 0

		for i, v in ipairs(cfgs) do
			if LTDaJiaoModel.instance:isPass(v.group) then
				curCount = curCount + 1
			end
		end

		local totalCount = #cfgs - 1

		if curCount > 0 then
			self._rewardSlider:SetValue((curCount - 1) / totalCount)
		else
			self._rewardSlider:SetValue(0)
		end
	end
end

return LTDaJiaoEnterView
