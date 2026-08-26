-- chunkname: @modules/logic/battlepass/view/BpTaskItem.lua

module("modules.logic.battlepass.view.BpTaskItem", package.seeall)

local BpTaskItem = class("BpTaskItem", ListScrollCell)

function BpTaskItem:init(go)
	self.go = go
	self._txtTaskDesc = gohelper.findChildText(self.go, "#txt_taskdes")
	self._txtTaskTotal = gohelper.findChildText(self.go, "#txt_taskdes/#txt_total")
	self._goNotFinish = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#btn_notfinishbg")
	self._goFinishBg = gohelper.findChildButtonWithAudio(self.go, "#go_notget/#btn_finishbg", AudioEnum.UI.play_ui_permit_receive_button)
	self._simageFinish2 = gohelper.findChildSingleImage(self.go, "#go_notget/#btn_finishbg/#simage_getmask")
	self._goAllFinish = gohelper.findChild(self.go, "#go_notget/#go_allfinish")
	self._simageFinish = gohelper.findChildSingleImage(self.go, "#go_notget/#go_allfinish/#simage_getmask")
	self._gobonus = gohelper.findChild(self.go, "#go_bonus")
	self._simagebg = gohelper.findChildSingleImage(self.go, "#simage_bg")
	self._goremaintime = gohelper.findChild(self.go, "#go_remaintime")
	self._txtremaintime = gohelper.findChildTextMesh(self.go, "#go_remaintime/bg/icon/#txt_remaintime")
	self._goturnback = gohelper.findChild(self.go, "#go_turnback")
	self._gonewbie = gohelper.findChild(self.go, "#go_newbie")

	self._simageFinish:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))
	self._simageFinish2:LoadImage(ResUrl.getTaskBg("dieheiyou_020"))

	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._gobonusItem = gohelper.findChild(self._gobonus, "#go_item")
	self._gobonusExpup = gohelper.findChild(self._gobonus, "#go_expup")
	self._gobonusExpupTxt = gohelper.findChildText(self._gobonusExpup, "#txt_num")
end

function BpTaskItem:addEventListeners()
	self._goNotFinish:AddClickListener(self._goNotFinishOnClick, self)
	self._goFinishBg:AddClickListener(self._goFinishBgOnClick, self)
	self.addEventCb(self, self._view.viewContainer, BpEvent.OnTaskFinishAnim, self.playFinishAnim, self)
	self.addEventCb(self, self._view.viewContainer, BpEvent.TapViewOpenAnimBegin, self.onTabOpen, self)
	self.addEventCb(self, self._view.viewContainer, BpEvent.TapViewCloseAnimBegin, self.onTabClose, self)
end

function BpTaskItem:removeEventListeners()
	self._goNotFinish:RemoveClickListener()
	self._goFinishBg:RemoveClickListener()
	self.removeEventCb(self, self._view.viewContainer, BpEvent.OnTaskFinishAnim, self.playFinishAnim, self)
	self.removeEventCb(self, self._view.viewContainer, BpEvent.TapViewOpenAnimBegin, self.onTabOpen, self)
	self.removeEventCb(self, self._view.viewContainer, BpEvent.TapViewCloseAnimBegin, self.onTabClose, self)
end

function BpTaskItem:onUpdateMO(mo)
	self.mo = mo
	self._txtTaskDesc.text = self.mo.config.desc
	self._txtTaskTotal.text = string.format("%s/%s", self.mo.progress, self.mo.config.maxProgress)

	local p = self.mo.progress
	local maxp = self.mo.config.maxProgress
	local isShowFinish = self.mo.config.loopType <= 2 and BpModel.instance:isWeeklyScoreFull()

	gohelper.setActive(self._goNotFinish.gameObject, not isShowFinish and p < maxp and self.mo.config.jumpId > 0)
	gohelper.setActive(self._goFinishBg.gameObject, not isShowFinish and maxp <= p and self.mo.finishCount == 0)
	gohelper.setActive(self._goAllFinish, isShowFinish or self.mo.finishCount > 0)
	gohelper.setActive(self._goturnback, mo.config.turnbackTask)
	gohelper.setActive(self._gonewbie, mo.config.newbieTask)

	local leftSec = -1

	if not string.nilorempty(self.mo.config.startTime) and not string.nilorempty(self.mo.config.endTime) and self.mo.finishCount <= 0 then
		leftSec = TimeUtil.stringToTimestamp(self.mo.config.endTime) + ServerTime.clientToServerOffset()
		leftSec = leftSec - ServerTime.now()
	end

	if leftSec > 0 then
		gohelper.setActive(self._goremaintime, true)

		if leftSec > 3600 then
			local day = math.floor(leftSec / 86400)
			local hour = math.floor(leftSec % 86400 / 3600)

			self._txtremaintime.text = formatLuaLang("remain", string.format("%d%s%d%s", day, luaLang("time_day"), hour, luaLang("time_hour")))
		else
			self._txtremaintime.text = luaLang("not_enough_one_hour")
		end
	else
		gohelper.setActive(self._goremaintime, false)
	end

	local bonusScore = GameUtil.calcByDeltaRate1000AsInt(self.mo.config.bonusScore, self.mo.config.bonusScoreTimes)

	if not self.bonusItem then
		local itemIcon = IconMgr.instance:getCommonPropItemIcon(self._gobonusItem)

		gohelper.setAsFirstSibling(itemIcon.go)
		itemIcon:setMOValue(1, BpEnum.ScoreItemId, bonusScore, nil, true)
		itemIcon:setCountFontSize(36)
		itemIcon:setScale(0.54)
		itemIcon:SetCountLocalY(42)
		itemIcon:SetCountBgHeight(22)
		itemIcon:showStackableNum2()
		itemIcon:setHideLvAndBreakFlag(true)
		itemIcon:hideEquipLvAndBreak(true)

		self.bonusItem = itemIcon
	else
		self.bonusItem:setMOValue(1, BpEnum.ScoreItemId, bonusScore, nil, true)
	end

	self:_refreshExpup()
end

function BpTaskItem:onTabClose(tabId)
	if tabId == 2 then
		self._animator:Play(UIAnimationName.Close)
	end
end

function BpTaskItem:onTabOpen(tabId)
	if tabId == 2 then
		self._animator:Play(UIAnimationName.Open, 0, 0)
	end
end

function BpTaskItem:_goNotFinishOnClick()
	local jumpId = self.mo.config.jumpId

	if jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function BpTaskItem:_goFinishBgOnClick()
	UIBlockMgr.instance:startBlock("BpTaskItemFinish")
	TaskDispatcher.runDelay(self.finishTask, self, BpEnum.TaskMaskTime)
	self._view.viewContainer:dispatchEvent(BpEvent.OnTaskFinishAnim, self._index)
end

function BpTaskItem:playFinishAnim(index)
	if index and index ~= self._index then
		return
	end

	if not self._goFinishBg.gameObject.activeSelf then
		return
	end

	self._animator:Play("get", 0, 0)
end

function BpTaskItem:finishTask()
	TaskDispatcher.cancelTask(self.finishTask, self)
	UIBlockMgr.instance:endBlock("BpTaskItemFinish")
	TaskRpc.instance:sendFinishTaskRequest(self.mo.id)
end

function BpTaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self.finishTask, self)

	if self.bonusItem then
		self.bonusItem:onDestroy()
	end

	self._simageFinish:UnLoadImage()
	self._simageFinish2:UnLoadImage()
end

function BpTaskItem:_refreshExpup()
	local mo = self.mo
	local config = mo.config
	local bonusScoreTimes = 1000 + (config.bonusScoreTimes or 0)
	local isShow = bonusScoreTimes > 1000

	if isShow then
		self._gobonusExpupTxt.text = GameUtil.convertToPercentStr(bonusScoreTimes)
	end

	gohelper.setActive(self._gobonusExpup, isShow)
end

return BpTaskItem
