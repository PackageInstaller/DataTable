-- chunkname: @modules/logic/rouge/view/RougeRewardNoticeView.lua

module("modules.logic.rouge.view.RougeRewardNoticeView", package.seeall)

local RougeRewardNoticeView = class("RougeRewardNoticeView", BaseView)

function RougeRewardNoticeView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "#scroll_ItemList")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_ItemList/Viewport/Content")
	self._goItem = gohelper.findChild(self.viewGO, "#scroll_ItemList/Viewport/Content/#go_Item")
	self._itemList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeRewardNoticeView:addEvents()
	return
end

function RougeRewardNoticeView:removeEvents()
	return
end

function RougeRewardNoticeView:_editableInitView()
	return
end

function RougeRewardNoticeView:onUpdateParam()
	return
end

function RougeRewardNoticeView:_initView()
	self._season = RougeOutsideModel.instance:season()

	local coList = RougeRewardConfig.instance:getBigRewardToStage()

	for index, co in pairs(coList) do
		local config = co[1]
		local item = self._itemList[index]

		if item == nil then
			item = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._goItem, "rewarditem" .. index)

			item.go = go
			item.co = config
			item.index = index
			item.txtNum = gohelper.findChildText(go, "#txt_Num")
			item.txtItem = gohelper.findChildText(go, "#txt_Item")
			item.goGet = gohelper.findChild(go, "#go_Get")
			item.goUnGetBg = gohelper.findChild(go, "image_ItemIconBG2")
			item.goLockMask = gohelper.findChild(go, "#go_LockMask")
			item.goUnlockItem = gohelper.findChild(go, "#go_UnlockItem")
			item.imageItemIcon = gohelper.findChildImage(go, "#image_ItemIcon")
			item.goNextUnlock = gohelper.findChild(go, "#go_nextUnlock")
			item.btn = gohelper.findChildButton(go, "btn")

			item.btn:AddClickListener(self._btnclickOnClick, self, item)

			item.animator = go:GetComponent(typeof(UnityEngine.Animator))
			item.layoutindex = math.ceil(item.index / 3)

			table.insert(self._itemList, item)
		end

		item.txtNum.text = math.floor(config.bigRewardId / 10) > 0 and config.bigRewardId or string.format("0%d", config.bigRewardId)
		item.txtItem.text = config.name

		if not string.nilorempty(config.icon) then
			UISpriteSetMgr.instance:setRouge5Sprite(item.imageItemIcon, config.icon)
		end

		local isGet = RougeRewardModel.instance:checShowBigRewardGot(config.bigRewardId)

		gohelper.setActive(item.goGet, isGet)
		gohelper.setActive(item.goUnGetBg, not isGet)

		local unlock = RougeRewardModel.instance:isStageOpen(config.stage)

		gohelper.setActive(item.goLockMask, not unlock)
		gohelper.setActive(item.goUnlockItem, not unlock)
		gohelper.setActive(item.imageItemIcon.gameObject, unlock)
		gohelper.setActive(item.btn, unlock)

		if unlock then
			item.txtItem.text = config.name or config.lockName
		end

		local showtag = RougeRewardModel.instance:isShowNextStageTag(config.stage)

		gohelper.setActive(item.goNextUnlock, showtag)
	end
end

function RougeRewardNoticeView:_btnclickOnClick(item)
	self:_jumpToTargetReward(item.index)
end

function RougeRewardNoticeView:_jumpToTargetReward(index)
	self:closeThis()
	RougeController.instance:dispatchEvent(RougeEvent.OnClickBigReward, index)
end

function RougeRewardNoticeView:onOpen()
	RougeRewardModel.instance:setNextUnlockStage()
	self:_initView()
	self:_openAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardNoticeView)
end

function RougeRewardNoticeView:_openAnim()
	function self._playAnim()
		if not self.viewContainer or not self.viewContainer._isVisible then
			return
		end

		TaskDispatcher.cancelTask(self._playAnim, self)

		function self.playfunc(item)
			if not self.viewContainer or not self.viewContainer._isVisible then
				return
			end

			TaskDispatcher.cancelTask(self.playfunc, item)
			gohelper.setActive(item.go, true)
			item.animator:Update(0)
			item.animator:Play("in", 0, 0)
		end

		for _, item in pairs(self._itemList) do
			local delayTime = item.layoutindex * 0.06

			TaskDispatcher.runDelay(self.playfunc, item, delayTime)
		end
	end

	local opentime = 0.1

	TaskDispatcher.runDelay(self._playAnim, self, opentime)
end

function RougeRewardNoticeView:onClose()
	for index, item in ipairs(self._itemList) do
		item.btn:RemoveClickListener()
	end
end

function RougeRewardNoticeView:onDestroyView()
	return
end

return RougeRewardNoticeView
