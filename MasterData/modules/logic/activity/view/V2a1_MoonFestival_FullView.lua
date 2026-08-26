-- chunkname: @modules/logic/activity/view/V2a1_MoonFestival_FullView.lua

module("modules.logic.activity.view.V2a1_MoonFestival_FullView", package.seeall)

local V2a1_MoonFestival_FullView = class("V2a1_MoonFestival_FullView", Activity101SignViewBase)

function V2a1_MoonFestival_FullView:onInitView()
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_PanelBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/image_LimitTimeBG/#txt_LimitTime")
	self._txtDec = gohelper.findChildText(self.viewGO, "Root/image_DecBG/#txt_Dec")
	self._goNormalBG = gohelper.findChild(self.viewGO, "Root/Task/#go_NormalBG")
	self._txtdec = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/scroll_desc/Viewport/Content/#txt_dec")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/Task/#go_NormalBG/#txt_num")
	self._simagereward = gohelper.findChildSingleImage(self.viewGO, "Root/Task/#go_NormalBG/#simage_reward")
	self._gocanget = gohelper.findChild(self.viewGO, "Root/Task/#go_canget")
	self._goFinishedBG = gohelper.findChild(self.viewGO, "Root/Task/#go_FinishedBG")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_MoonFestival_FullView:addEvents()
	Activity101SignViewBase.addEvents(self)
end

function V2a1_MoonFestival_FullView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
end

function V2a1_MoonFestival_FullView:_editableInitView()
	self._txtLimitTime.text = ""

	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:_setActive_canget(false)
	self:_setActive_goFinishedBG(false)
end

function V2a1_MoonFestival_FullView:onOpen()
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick")

	self._itemClick = gohelper.getClickWithAudio(self._goNormalBG)

	self._itemClick:AddClickListener(self._onItemClick, self)
	self:internal_onOpen()
	self:_clearTimeTick()
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V2a1_MoonFestival_FullView:onClose()
	GameUtil.onDestroyViewMember_ClickListener(self, "_itemClick")
	self:_clearTimeTick()
end

function V2a1_MoonFestival_FullView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self:_clearTimeTick()
end

function V2a1_MoonFestival_FullView:_clearTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V2a1_MoonFestival_FullView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
	self:_refreshLeftTop()
	self:_refreshRightTop()
end

function V2a1_MoonFestival_FullView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V2a1_MoonFestival_FullView:_refreshLeftTop()
	local CO = self.viewContainer:getCurrentDayCO()

	if not CO then
		self._txtDec.text = ""

		return
	end

	self._txtDec.text = CO.desc
end

function V2a1_MoonFestival_FullView:_refreshRightTop()
	local CO = self.viewContainer:getCurrentTaskCO()

	if not CO then
		self._txtdec.text = ""

		self._simagereward:UnLoadImage()

		self._txtnum.text = ""

		return
	end

	local bonusItems = GameUtil.splitString2(CO.bonus, true)
	local bonusItem = bonusItems[1]
	local itemType = bonusItem[1]
	local itemId = bonusItem[2]
	local _, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)
	local isNone = self.viewContainer:isNone(CO.id)
	local isFinishedTask = self.viewContainer:isFinishedTask(CO.id)
	local isRewardable = self.viewContainer:isRewardable(CO.id)

	self:_setActive_canget(isRewardable)
	self:_setActive_goFinishedBG(isFinishedTask)

	self._txtdec.text = CO.taskDesc

	GameUtil.loadSImage(self._simagereward, iconResUrl)

	self._txtnum.text = isNone and gohelper.getRichColorText("0/1", "#ff9673") or "1/1"
	self._bonusItem = bonusItem
end

function V2a1_MoonFestival_FullView:_onItemClick()
	local ok = self.viewContainer:sendGet101SpBonusRequest(self._onReceiveGet101SpBonusReplySucc, self)

	if not ok and self._bonusItem then
		MaterialTipController.instance:showMaterialInfo(self._bonusItem[1], self._bonusItem[2])
	end
end

function V2a1_MoonFestival_FullView:_setActive_canget(isActive)
	gohelper.setActive(self._gocanget, isActive)
end

function V2a1_MoonFestival_FullView:_setActive_goFinishedBG(isActive)
	gohelper.setActive(self._goFinishedBG, isActive)
end

function V2a1_MoonFestival_FullView:_onReceiveGet101SpBonusReplySucc()
	self:_refreshRightTop()

	if not ActivityType101Model.instance:isType101SpRewardCouldGetAnyOne(self:actId()) then
		RedDotRpc.instance:sendGetRedDotInfosRequest({
			RedDotEnum.DotNode.ActivityNoviceTab
		})
	end
end

return V2a1_MoonFestival_FullView
