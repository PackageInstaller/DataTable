-- chunkname: @modules/logic/activity/view/V1a6_Spring_PanelSignView.lua

module("modules.logic.activity.view.V1a6_Spring_PanelSignView", package.seeall)

local V1a6_Spring_PanelSignView = class("V1a6_Spring_PanelSignView", Activity101SignViewBase)

function V1a6_Spring_PanelSignView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_Close")
	self._txtDate = gohelper.findChildText(self.viewGO, "Root/#txt_Date")
	self._txtgoodDesc = gohelper.findChildText(self.viewGO, "Root/image_yi/image_Mood/#txt_goodDesc")
	self._txtbadDesc = gohelper.findChildText(self.viewGO, "Root/image_ji/image_Mood/#txt_badDesc")
	self._txtSmallTitle = gohelper.findChildText(self.viewGO, "Root/image_SmallTitle/#txt_SmallTitle")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Root/ScrollView/Viewport/#txt_Desc")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_Spring_PanelSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
end

function V1a6_Spring_PanelSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
end

function V1a6_Spring_PanelSignView:_btnCloseOnClick()
	self:closeThis()
end

function V1a6_Spring_PanelSignView:_btnemptyTopOnClick()
	self:closeThis()
end

function V1a6_Spring_PanelSignView:_btnemptyBottomOnClick()
	self:closeThis()
end

function V1a6_Spring_PanelSignView:_btnemptyLeftOnClick()
	self:closeThis()
end

function V1a6_Spring_PanelSignView:_btnemptyRightOnClick()
	self:closeThis()
end

function V1a6_Spring_PanelSignView:_editableInitView()
	self._anims = self:getUserDataTb_()

	table.insert(self._anims, self:_findAnimCmp("Root/image_yi/image_Mood"))
	table.insert(self._anims, self:_findAnimCmp("Root/image_ji/image_Mood"))
end

function V1a6_Spring_PanelSignView:_findAnimCmp(pathFromViewGO)
	local go = gohelper.findChild(self.viewGO, pathFromViewGO)

	return go:GetComponent(gohelper.Type_Animator)
end

function V1a6_Spring_PanelSignView:onOpen()
	self._txtLimitTime.text = ""
	self._txtDate.text = ""
	self._txtSmallTitle.text = ""
	self._txtDesc.text = ""
	self._txtgoodDesc.text = ""
	self._txtbadDesc.text = ""

	self:internal_set_actId(self.viewParam.actId)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.PaiLian)
	self:internal_onOpen()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

local kplayerPrefsKey = "Key_V1a6_Spring_PanelSignView"

function V1a6_Spring_PanelSignView:onOpenFinish()
	local CO = self:_getCurrentDayCO()

	if not CO then
		return
	end

	local day = CO.day
	local lastDay = GameUtil.playerPrefsGetNumberByUserId(kplayerPrefsKey, -1)

	if lastDay ~= day then
		for _, anim in ipairs(self._anims or {}) do
			anim:Play(UIAnimationName.Open, 0, 0)
		end

		GameUtil.playerPrefsSetNumberByUserId(kplayerPrefsKey, day)
	end
end

function V1a6_Spring_PanelSignView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function V1a6_Spring_PanelSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a6_Spring_PanelSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
	self:_refreshDesc()
end

function V1a6_Spring_PanelSignView:_refreshDesc()
	local CO = self:_getCurrentDayCO()

	if not CO then
		return
	end

	self._txtDate.text = CO.name
	self._txtSmallTitle.text = CO.simpleDesc
	self._txtDesc.text = CO.detailDesc
	self._txtgoodDesc.text = CO.goodDesc
	self._txtbadDesc.text = CO.badDesc
end

function V1a6_Spring_PanelSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V1a6_Spring_PanelSignView:_getCurrentDayCO()
	local actId = self:actId()
	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO then
		return
	end

	local maxDay = ActivityType101Config.instance:getSpringSignMaxDay(actId)

	if not maxDay or maxDay <= 0 then
		return
	end

	local st = actMO.startTime / 1000
	local ed = actMO.endTime / 1000
	local now = ServerTime.now()

	if now < st or ed < now then
		return
	end

	local durationSecondFromSt = now - st
	local durationDay = TimeUtil.secondsToDDHHMMSS(durationSecondFromSt)

	if maxDay <= durationDay then
		durationDay = durationDay % maxDay
	end

	local day = durationDay + 1

	return ActivityType101Config.instance:getSpringSignByDay(actId, day)
end

function V1a6_Spring_PanelSignView:_onDailyRefresh()
	self:_refreshDesc()
end

return V1a6_Spring_PanelSignView
