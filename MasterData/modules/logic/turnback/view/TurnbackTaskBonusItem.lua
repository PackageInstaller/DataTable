-- chunkname: @modules/logic/turnback/view/TurnbackTaskBonusItem.lua

module("modules.logic.turnback.view.TurnbackTaskBonusItem", package.seeall)

local TurnbackTaskBonusItem = class("TurnbackTaskBonusItem", LuaCompBase)

function TurnbackTaskBonusItem:ctor(param)
	self.param = param
end

function TurnbackTaskBonusItem:init(go)
	self:__onInit()

	self.go = go
	self.index = self.param.index
	self.goItemContent = gohelper.findChild(self.go, "scroll_item/Viewport/go_itemContent")
	self.goGetState = gohelper.findChild(self.go, "rewardState/go_get")
	self.btnCanGetState = gohelper.findChildButtonWithAudio(self.go, "rewardState/btn_canget")
	self.goDoingState = gohelper.findChild(self.go, "rewardState/go_doing")
	self.goNotGetActiveState = gohelper.findChild(self.go, "activeState/go_notget")
	self.txtNoGetActiveState = gohelper.findChildText(self.go, "activeState/go_notget/txt_notgetNum")
	self.goCanGetActiveState = gohelper.findChild(self.go, "activeState/go_canget")
	self.txtCanGetActiveState = gohelper.findChildText(self.go, "activeState/go_canget/txt_cangetNum")
	self.goRedDot = gohelper.findChild(self.go, "go_reddot")
	self._scrollitem = gohelper.findChild(self.go, "scroll_item"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._scrollitem.parentGameObject = self.param.parentScrollGO
	self._goGetAnim = gohelper.findChild(self.go, "ani")

	self:initItem()
	self:refreshItem()
end

function TurnbackTaskBonusItem:addEventListeners()
	self.btnCanGetState:AddClickListener(self._btnCanGetOnClick, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, self.refreshItem, self)
end

function TurnbackTaskBonusItem:removeEventListeners()
	self.btnCanGetState:RemoveClickListener()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshTaskRewardItem, self.refreshItem, self)
end

function TurnbackTaskBonusItem:initItem()
	self.rewardTab = {}
	self.curTurnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackTaskBonusCo(self.curTurnbackId, self.index)
	self.bonusPointType, self.bonusPointId = TurnbackConfig.instance:getBonusPointCo(self.curTurnbackId)

	local bonuesItemTab = string.split(self.config.bonus, "|")

	for i = 1, #bonuesItemTab do
		local itemCo = string.split(bonuesItemTab[i], "#")
		local reward = IconMgr.instance:getCommonPropItemIcon(self.goItemContent)

		reward:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		reward:setPropItemScale(0.55)
		reward:setHideLvAndBreakFlag(true)
		reward:hideEquipLvAndBreak(true)
		reward:setCountFontSize(50)
		table.insert(self.rewardTab, reward)
	end

	self.txtNoGetActiveState.text = self.config.needPoint
	self.txtCanGetActiveState.text = self.config.needPoint

	gohelper.setActive(self._goGetAnim, false)
end

function TurnbackTaskBonusItem:refreshItem()
	self.hasGetState = false

	local bonusPointMo = CurrencyModel.instance:getCurrency(self.bonusPointId)

	if bonusPointMo then
		if not bonusPointMo.quantity then
			local curActiveCount = 0

			gohelper.setActive(self.goNotGetActiveState, curActiveCount < self.config.needPoint)
			gohelper.setActive(self.goCanGetActiveState, curActiveCount >= self.config.needPoint)

			local HasGetTaskBonus = TurnbackModel.instance:getCurHasGetTaskBonus()

			for _, v in ipairs(HasGetTaskBonus) do
				if v == self.index then
					self.hasGetState = true

					break
				end
			end

			gohelper.setActive(self.goGetState, self.hasGetState)
			gohelper.setActive(self.btnCanGetState.gameObject, not self.hasGetState and curActiveCount >= self.config.needPoint)
			gohelper.setActive(self.goDoingState, not self.hasGetState and curActiveCount < self.config.needPoint)
			gohelper.setActive(self.goRedDot, false)

			for _, reward in ipairs(self.rewardTab) do
				reward:setGetMask(self.hasGetState)
			end
		end
	end
end

function TurnbackTaskBonusItem:_btnCanGetOnClick()
	gohelper.setActive(self._goGetAnim, true)
	UIBlockMgr.instance:startBlock("TurnbackTaskBonusItemFinish")
	TaskDispatcher.runDelay(self._playGetAnimFinish, self, TurnbackEnum.TaskGetBonusAnimTime)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
end

function TurnbackTaskBonusItem:_playGetAnimFinish()
	gohelper.setActive(self._goGetAnim, false)
	UIBlockMgr.instance:endBlock("TurnbackTaskBonusItemFinish")

	local param = {}

	param.id = TurnbackModel.instance:getCurTurnbackId()
	param.bonusPointId = self.index

	TurnbackRpc.instance:sendTurnbackBonusPointRequest(param)
end

function TurnbackTaskBonusItem:destroy()
	self:__onDispose()
	TaskDispatcher.TaskDispatcher.cancelTask(self._playGetAnimFinish, self)
end

return TurnbackTaskBonusItem
