-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/actbp/Anniversary3ActBpTaskItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.actbp.Anniversary3ActBpTaskItem", package.seeall)

local Anniversary3ActBpTaskItem = class("Anniversary3ActBpTaskItem", LuaCompBase)

function Anniversary3ActBpTaskItem:init(go)
	self.go = go
	self._txttaskdes = gohelper.findChildText(self.go, "txt_taskdes")
	self._txttotal = gohelper.findChildText(self.go, "txt_taskdes/txt_total")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.go, "go_notget/btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.go, "go_notget/btn_finishbg", AudioEnum.UI.play_ui_permit_receive_button)
	self._goallfinish = gohelper.findChild(self.go, "go_notget/go_allfinish")
	self._gobonus = gohelper.findChild(self.go, "go_bonus")
	self._goremaintime = gohelper.findChild(self.go, "go_remaintime")
	self._txtremaintime = gohelper.findChildText(self.go, "go_remaintime/bg/icon/txt_remaintime")
	self._gobonusitem = gohelper.findChild(self._gobonus, "go_item")

	gohelper.setActive(self._goremaintime, false)

	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))

	self:_addEvents()
end

function Anniversary3ActBpTaskItem:_addEvents()
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	Anniversary3ActBpController.instance:registerCallback(Anniversary3ActBpEvent.OnSelectTaskTab, self._onSelectTaskTab, self)
end

function Anniversary3ActBpTaskItem:_removeEvents()
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	Anniversary3ActBpController.instance:unregisterCallback(Anniversary3ActBpEvent.OnSelectTaskTab, self._onSelectTaskTab, self)
end

function Anniversary3ActBpTaskItem:_btnnotfinishbgOnClick()
	local jumpId = self._mo.config.jumpId

	if not jumpId or jumpId <= 0 then
		return
	end

	GameFacade.jump(jumpId)
end

function Anniversary3ActBpTaskItem:_btnfinishbgOnClick()
	self._animator:Play("get", 0, 0)
	TaskDispatcher.runDelay(self._realFinishTask, self, 0.6)
end

function Anniversary3ActBpTaskItem:_realFinishTask()
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function Anniversary3ActBpTaskItem:_onSelectTaskTab()
	self._animator:Play("open", 0, 0)
end

function Anniversary3ActBpTaskItem:refresh(mo)
	self._mo = mo

	self:_refreshContent()
	self:_refreshBonus()
end

function Anniversary3ActBpTaskItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function Anniversary3ActBpTaskItem:_refreshContent()
	self._txttaskdes.text = self._mo.config.desc
	self._txttotal.text = string.format("%s/%s", self._mo.progress, self._mo.config.maxProgress)

	gohelper.setActive(self._goallfinish, false)
	gohelper.setActive(self._btnnotfinishbg.gameObject, false)
	gohelper.setActive(self._btnfinishbg.gameObject, false)

	if self._mo.finishCount > 0 then
		gohelper.setActive(self._goallfinish, true)
	elseif self._mo.progress >= self._mo.config.maxProgress then
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	else
		gohelper.setActive(self._btnnotfinishbg.gameObject, self._mo.config.jumpId ~= 0)
	end
end

function Anniversary3ActBpTaskItem:_refreshBonus()
	local bonusScore = GameUtil.calcByDeltaRate1000AsInt(self._mo.config.bonusScore, self._mo.config.bonusScoreTimes)

	if not self._bonusItem then
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gobonusitem)

		gohelper.setAsFirstSibling(itemIcon.go)
		itemIcon:setMOValue(1, Anniversary3ActBpEnum.ScoreItemId, bonusScore, nil, true)
		itemIcon:setCountFontSize(36)
		itemIcon:setScale(0.54)
		itemIcon:SetCountLocalY(42)
		itemIcon:SetCountBgHeight(22)
		itemIcon:showStackableNum2()
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)

		self._bonusItem = itemIcon
	else
		self._bonusItem:setMOValue(1, Anniversary3ActBpEnum.ScoreItemId, bonusScore, nil, true)
	end
end

function Anniversary3ActBpTaskItem:destroy()
	self:_removeEvents()

	if self._bonusItem then
		self._bonusItem:onDestroy()
	end
end

return Anniversary3ActBpTaskItem
