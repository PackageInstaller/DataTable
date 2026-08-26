-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewTaskView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewTaskView", package.seeall)

local TurnbackNewTaskView = class("TurnbackNewTaskView", BaseView)

function TurnbackNewTaskView:onInitView()
	self._btnreplay = gohelper.findChildButton(self.viewGO, "top/#btn_replay")
	self._btnreplay2 = gohelper.findChildButton(self.viewGO, "top/#btn_replay2")
	self._btntips = gohelper.findChildButton(self.viewGO, "top/tips/#btn_tips")
	self._btnclosetips = gohelper.findChildButton(self.viewGO, "top/tips/go_tips/#btn_close")
	self._gotips = gohelper.findChild(self.viewGO, "top/tips/go_tips")
	self._btnbuy = gohelper.findChildButton(self.viewGO, "top/normalbg/#btn_buy")
	self._gotop = gohelper.findChild(self.viewGO, "top")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._gonormal = gohelper.findChild(self.viewGO, "top/normalbg")
	self._godouble = gohelper.findChild(self.viewGO, "top/doublebg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "top/#scroll_view")
	self._scrolltask = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_task")
	self._gorewardviewport = gohelper.findChild(self.viewGO, "top/#scroll_view/Viewport")
	self._gorewardContent = gohelper.findChild(self.viewGO, "top/#scroll_view/Viewport/Content")
	self._gorewardItem = gohelper.findChild(self.viewGO, "top/#scroll_view/Viewport/Content/#go_rewarditem")
	self._gobigrewardItem = gohelper.findChild(self.viewGO, "top/#go_special")
	self._imgFill = gohelper.findChildImage(self.viewGO, "top/#scroll_view/Viewport/Content/progressbg/fill")
	self._txtActiveNum = gohelper.findChildText(self.viewGO, "top/#txt_activeNum")
	self._btnleft = gohelper.findChildButton(self.viewGO, "right/simage_rightbg/#btn_last")
	self._btnright = gohelper.findChildButton(self.viewGO, "right/simage_rightbg/#btn_next")
	self._txtnum = gohelper.findChildText(self.viewGO, "right/simage_rightbg/numbg/#txt_num")
	self._gonumbg = gohelper.findChild(self.viewGO, "right/simage_rightbg/numbg")
	self._gotitlebg = gohelper.findChild(self.viewGO, "right/simage_rightbg/titlebg")
	self._gounfinish = gohelper.findChild(self.viewGO, "right/unfinish")
	self._gofinished = gohelper.findChild(self.viewGO, "right/finished")
	self._simageHero = gohelper.findChildSingleImage(self.viewGO, "right/unfinish/simage_role")
	self._goscrolldesc = gohelper.findChild(self.viewGO, "right/unfinish/#scroll_desc")
	self._txtHeroDesc = gohelper.findChildText(self.viewGO, "right/unfinish/#scroll_desc/Viewport/#txt_dec")
	self._btnexchange = gohelper.findChildButton(self.viewGO, "right/unfinish/#btn_exchange")
	self._rewardNodeList = {}
	self._heroIndex = 1
	self._isreverse = false
	self._isfinish = false
	self._isopentips = false
	self._topAnimator = self._gotop:GetComponent(typeof(UnityEngine.Animator))
	self._rightAnimator = self._goright:GetComponent(typeof(UnityEngine.Animator))
	self._rightTextAnim = self._goscrolldesc:GetComponent(typeof(UnityEngine.Animation))
	self.fullscrollWidth = 780
	self.normalscrollWidth = 604

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewTaskView:addEvents()
	self._btnreplay:AddClickListener(self.onClickReplay, self)
	self._btnreplay2:AddClickListener(self.onClickReplay2, self)
	self._btntips:AddClickListener(self.onClickBtnTips, self)
	self._btnclosetips:AddClickListener(self.onClickBtnCloseTips, self)
	self._btnbuy:AddClickListener(self.onClickBuy, self)
	self._btnleft:AddClickListener(self.onClickLeft, self)
	self._btnright:AddClickListener(self.onClickRight, self)
	self._btnexchange:AddClickListener(self.onCilckReverse, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
	self._scrollreward:AddOnValueChanged(self._onScrollRectValueChanged, self)
end

function TurnbackNewTaskView:removeEvents()
	self._btnreplay:RemoveClickListener()
	self._btnreplay2:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btnclosetips:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	self._btnexchange:RemoveClickListener()
	self._scrollreward:RemoveOnValueChanged()
	self._scrolltask:RemoveOnValueChanged()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.OnTaskRewardGetFinish, self._playGetRewardFinishAnim, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshUI, self)
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.AfterBuyDoubleReward, self.succbuydoublereward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	for index, node in ipairs(self._rewardNodeList) do
		node.btnclick:RemoveClickListener()
	end
end

function TurnbackNewTaskView:_editableInitView()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()

	self:_initRewardNode()
	self:_initBigRewardNode()
	self:_refreshFill()
	self:refreshTopBg()

	local isAllReceive = TurnbackModel.instance:checkHasGetAllTaskReward()

	gohelper.setActive(self._btnreplay2.gameObject, isAllReceive)

	local list = TurnbackModel.instance:getUnlockHeroList()

	self._heroIndex = #list
	self._maxUnlockHeroIndex = #list

	self:_refreshHero()

	self._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(self.viewContainer._scrollView)

	self._taskAnimRemoveItem:setMoveInterval(0)
	self._taskAnimRemoveItem:setMoveAnimationTime(TurnbackEnum.TaskMaskTime - TurnbackEnum.TaskGetAnimTime)
end

function TurnbackNewTaskView:_onScrollRectValueChanged(scrollX, scrollY)
	self:checkNeedHideReward(scrollX)

	if not self._scrollTime then
		self._scrollTime = 0
		self._scrollX = scrollX

		TaskDispatcher.runRepeat(self.checkScrollEnd, self, 0)
	end

	if self._scrollTime and math.abs(self._scrollX - scrollX) > 0.05 then
		self._scrollTime = 0
		self._scrollX = scrollX
	end
end

function TurnbackNewTaskView:checkScrollEnd()
	self._scrollTime = self._scrollTime + UnityEngine.Time.deltaTime

	if self._scrollTime > 0.05 then
		self._scrollTime = nil

		TaskDispatcher.cancelTask(self.checkScrollEnd, self)
	end
end

function TurnbackNewTaskView:checkNeedHideReward(percent)
	if not percent then
		return
	end

	if percent > 0.8 then
		recthelper.setWidth(self._scrollreward.transform, self.fullscrollWidth)
		gohelper.setActive(self._gobigrewardItem, false)
	else
		recthelper.setWidth(self._scrollreward.transform, self.normalscrollWidth)
		gohelper.setActive(self._gobigrewardItem, true)
	end
end

function TurnbackNewTaskView:_refreshUI()
	self:refreshTopBg()
	self:_refreshFill()
	self:_refreshHero()
	self:refreshBigRewardNode()

	for index, node in ipairs(self._rewardNodeList) do
		self:refreshRewardNode(node)
	end

	local isAllReceive = TurnbackModel.instance:checkHasGetAllTaskReward()

	gohelper.setActive(self._btnreplay2.gameObject, isAllReceive)

	if isAllReceive then
		local config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)

		if config then
			::label_8_0::

			local canPlay = not StoryModel.instance:isStoryFinished(config.endStory)

			if canPlay then
				local storyId = config.endStory

				if storyId then
					StoryController.instance:playStory(storyId)
				else
					logError(string.format("TurnbackTaskView endStoryId is nil", storyId))
				end
			end
		end
	end
end

function TurnbackNewTaskView:_refreshHero()
	self._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	local rewardColist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)
	local canleft = self._heroIndex > 1
	local canright = self._heroIndex < #self._unlockHeroCoList

	gohelper.setActive(self._btnleft.gameObject, canleft)
	gohelper.setActive(self._btnright.gameObject, canright)

	if self._heroIndex == #rewardColist then
		gohelper.setActive(self._btnright.gameObject, true)
	end

	local heroco = self._unlockHeroCoList[self._heroIndex]

	if not heroco then
		return
	end

	self._txtHeroDesc.text = heroco.content

	self._simageHero:LoadImage(ResUrl.getTurnbackIcon("new/task/turnback_new_task_role" .. self._heroIndex))

	local cangetlist = TurnbackModel.instance:getCanGetRewardList()

	if self._heroIndex > 1 then
		local co = self._unlockHeroCoList[self._heroIndex - 1]

		self._txtnum.text = co.needPoint

		gohelper.setActive(self._gonumbg, true)
	else
		gohelper.setActive(self._gonumbg, false)
	end
end

function TurnbackNewTaskView:getSchedule()
	local firstFillAmount = 0.06
	local maxFillAmount = 1
	local rewardColist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)
	local rewardCount = #rewardColist
	local firstNum = rewardColist[1].needPoint
	local havenum = TurnbackModel.instance:getCurrentPointId(self._turnbackId)
	local currentIndex = 0
	local currentIndexNum = 0
	local nextIndexNum = 0

	for index, rewardco in ipairs(rewardColist) do
		local indexNum = rewardco.needPoint

		if indexNum <= havenum then
			currentIndex = index
			currentIndexNum = rewardco.needPoint
		else
			nextIndexNum = rewardco.needPoint

			break
		end
	end

	local per = (maxFillAmount - firstFillAmount) / (rewardCount - 1)
	local progress = (havenum - currentIndexNum) / (nextIndexNum - currentIndexNum)

	return currentIndex == rewardCount and 1 or currentIndex - 1 + progress <= 0 and havenum / firstNum * firstFillAmount or firstFillAmount + per * (currentIndex - 1 + progress)
end

function TurnbackNewTaskView:refreshTopBg()
	local buyDouble = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(self._gonormal, not buyDouble)
	gohelper.setActive(self._godouble, buyDouble)

	local startSpace = 50
	local endSpace = 50
	local itemspace = 100
	local itemWidth = 100
	local index = TurnbackModel.instance:getNextUnlockReward()
	local contentwidth = TurnbackModel.instance:getContentWidth()
	local allwidth = contentwidth - self.normalscrollWidth

	if TurnbackModel.instance:checkHasGetAllTaskReward() then
		self._scrollreward.horizontalNormalizedPosition = 1
	elseif index > 1 then
		index = index - 2

		local currentWitdh = itemWidth * index + itemspace * (index - 1) + startSpace + endSpace

		self._scrollreward.horizontalNormalizedPosition = currentWitdh / allwidth >= 1 and 1 or currentWitdh / allwidth
	else
		self._scrollreward.horizontalNormalizedPosition = 0
	end
end

function TurnbackNewTaskView:onCurrencyChange()
	self:_refreshFill()

	self._unlockHeroCoList = TurnbackModel.instance:getUnlockHeroList()

	local index = #self._unlockHeroCoList

	if index > self._maxUnlockHeroIndex then
		self._maxUnlockHeroIndex = index
		self._heroIndex = index

		if self._isreverse then
			self._isreverse = not self._isreverse

			gohelper.setActive(self._simageHero.gameObject, not self._isreverse)
			gohelper.setActive(self._goscrolldesc, self._isreverse)
		end
	end

	self:_refreshHero()
	self:refreshTopBg()
end

function TurnbackNewTaskView:_refreshFill()
	local lastPoint = TurnbackConfig.instance:getTurnbackLastBounsPoint(self._turnbackId)
	local currentPoint = TurnbackModel.instance:getCurrentPointId(self._turnbackId)

	self._txtActiveNum.text = currentPoint .. "/" .. lastPoint
	self._imgFill.fillAmount = self:getSchedule()
end

function TurnbackNewTaskView:_initRewardNode()
	local rewardCoList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)

	for index, co in ipairs(rewardCoList) do
		local node = self:getUserDataTb_()

		node.co = co
		node.go = gohelper.cloneInPlace(self._gorewardItem, "node" .. index)
		node.imgquality = gohelper.findChildImage(node.go, "#image_quality")
		node.imgCircle = gohelper.findChildImage(node.go, "#image_circle")
		node.goicon = gohelper.findChild(node.go, "go_icon")
		node.txtNum = gohelper.findChildText(node.go, "#txt_num")
		node.gocanget = gohelper.findChild(node.go, "go_canget")
		node.goreceive = gohelper.findChild(node.go, "go_receive")
		node.txtPoint = gohelper.findChildText(node.go, "point/#txt_point")
		node.golight = gohelper.findChild(node.go, "point/light")
		node.gogrey = gohelper.findChild(node.go, "point/grey")
		node.btnclick = gohelper.findChildButton(node.go, "go_canget/btn_click")

		local function func()
			local param = {}

			param.id = TurnbackModel.instance:getCurTurnbackId()
			param.bonusPointId = node.co.id

			TurnbackRpc.instance:sendTurnbackBonusPointRequest(param)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_replay_buttonegg)
		end

		node.btnclick:AddClickListener(func, self)
		gohelper.setActive(node.go, true)
		table.insert(self._rewardNodeList, node)

		local rewardco = string.splitToNumber(co.bonus, "#")
		local type, id, num = rewardco[1], rewardco[2], rewardco[3]
		local itemco = ItemConfig.instance:getItemConfig(type, id)

		UISpriteSetMgr.instance:setUiFBSprite(node.imgquality, "bg2_pinjidi_" .. itemco.rare)
		UISpriteSetMgr.instance:setUiFBSprite(node.imgCircle, "bg_pinjidi_lanse_" .. itemco.rare)

		if rewardco then
			node.itemIcon = node.itemIcon or IconMgr.instance:getCommonPropItemIcon(node.goicon)

			node.itemIcon:setMOValue(rewardco[1], rewardco[2], rewardco[3], nil, true)
			node.itemIcon:isShowQuality(false)
			node.itemIcon:isShowCount(false)
		end

		node.txtNum.text = num
		node.txtPoint.text = co.needPoint

		self:refreshRewardNode(node)
	end
end

function TurnbackNewTaskView:refreshRewardNode(node)
	local id = node.co.id
	local canget = TurnbackModel.instance:checkBonusCanGetById(id)
	local hadget = TurnbackModel.instance:checkBonusGetById(id)

	gohelper.setActive(node.gocanget, canget)
	gohelper.setActive(node.goreceive, hadget)

	if canget or hadget then
		gohelper.setActive(node.golight, true)
		gohelper.setActive(node.gogrey, false)
	else
		gohelper.setActive(node.golight, false)
		gohelper.setActive(node.gogrey, true)
	end
end

function TurnbackNewTaskView:_initBigRewardNode()
	self.bignode = self:getUserDataTb_()

	local go = self._gobigrewardItem

	self.bignode.go = go
	self.bignode.imgquality = gohelper.findChildImage(go, "#image_quality")
	self.bignode.imgCircle = gohelper.findChildImage(go, "#image_circle")
	self.bignode.goicon = gohelper.findChild(go, "go_icon")
	self.bignode.txtNum = gohelper.findChildText(go, "#txt_num")
	self.bignode.gocanget = gohelper.findChild(go, "go_canget")
	self.bignode.goreceive = gohelper.findChild(go, "go_receive")
	self.bignode.txtPoint = gohelper.findChildText(go, "point/#txt_point")
	self.bignode.golight = gohelper.findChild(go, "point/light")
	self.bignode.gogrey = gohelper.findChild(go, "point/grey")

	local rewardCoList = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)
	local config = rewardCoList[#rewardCoList]

	self.bignode.config = config

	local rewardco = string.splitToNumber(config.bonus, "#")
	local type, id, num = rewardco[1], rewardco[2], rewardco[3]
	local itemco = ItemConfig.instance:getItemConfig(type, id)

	UISpriteSetMgr.instance:setUiFBSprite(self.bignode.imgquality, "bg2_pinjidi_" .. itemco.rare)
	UISpriteSetMgr.instance:setUiFBSprite(self.bignode.imgCircle, "bg_pinjidi_lanse_" .. itemco.rare)

	if rewardco then
		self.bignode.itemIcon = self.bignode.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.bignode.goicon)

		self.bignode.itemIcon:setMOValue(rewardco[1], rewardco[2], rewardco[3], nil, true)
		self.bignode.itemIcon:isShowQuality(false)
		self.bignode.itemIcon:isShowCount(false)
	end

	self.bignode.txtNum.text = num
	self.bignode.txtPoint.text = config.needPoint

	self:refreshBigRewardNode()
end

function TurnbackNewTaskView:refreshBigRewardNode()
	local hadget = TurnbackModel.instance:checkBonusGetById(self.bignode.config.id)

	gohelper.setActive(self.bignode.goreceive, hadget)
	gohelper.setActive(self.bignode.golight, hadget)
	gohelper.setActive(self.bignode.gogrey, not hadget)
end

function TurnbackNewTaskView:onClickReplay()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_19_0::

		local var_19_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.startStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackRewardShowView startStoryId is nil", storyId))
			end
		end
	end
end

function TurnbackNewTaskView:onClickReplay2()
	local TurnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if TurnbackMo then
		::label_20_0::

		local var_20_0 = TurnbackMo.config

		if TurnbackMo.config then
			local storyId = TurnbackMo.config.endStory

			if storyId then
				StoryController.instance:playStory(storyId)
			else
				logError(string.format("TurnbackRewardShowView startStoryId is nil", storyId))
			end
		end
	end
end

function TurnbackNewTaskView:onClickBtnTips()
	self._isopentips = not self._isopentips

	gohelper.setActive(self._gotips, self._isopentips)
end

function TurnbackNewTaskView:onClickBtnCloseTips()
	self._isopentips = false

	gohelper.setActive(self._gotips, self._isopentips)
end

function TurnbackNewTaskView:onClickBuy()
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
		StatController.instance:track(StatEnum.EventName.ClickReflowDoubleClaim, {})
	end
end

function TurnbackNewTaskView:onClickLeft()
	if self._heroIndex > 1 then
		self._rightAnimator:Update(0)
		self._rightAnimator:Play("leftout")
		TaskDispatcher.runDelay(self._afterleftout, self, 0.3)
		AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
	end
end

function TurnbackNewTaskView:_afterleftout()
	TaskDispatcher.cancelTask(self._afterleftout, self)
	self._rightAnimator:Update(0)
	self._rightAnimator:Play("leftin")

	local colist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)

	if self._heroIndex == #colist and self._isfinish then
		self._isfinish = false

		gohelper.setActive(self._gofinished, self._isfinish)
		gohelper.setActive(self._gounfinish, not self._isfinish)
		gohelper.setActive(self._gonumbg, not self._isfinish)
		gohelper.setActive(self._gotitlebg, not self._isfinish)
		gohelper.setActive(self._btnright.gameObject, not self._isfinish)
	else
		self._heroIndex = self._heroIndex - 1

		self:_refreshHero()
	end

	TaskDispatcher.runDelay(self._afterleftin, self, 0.3)
end

function TurnbackNewTaskView:_afterleftin()
	TaskDispatcher.cancelTask(self._afterleftin, self)
end

function TurnbackNewTaskView:_afterrightout()
	TaskDispatcher.cancelTask(self._afterrightout, self)
	self._rightAnimator:Update(0)
	self._rightAnimator:Play("rightin")

	local colist = TurnbackConfig.instance:getAllTurnbackTaskBonusCo(self._turnbackId)

	if self._heroIndex < #colist then
		self._heroIndex = self._heroIndex + 1

		self:_refreshHero()
	else
		self._isfinish = true

		gohelper.setActive(self._gofinished, self._isfinish)
		gohelper.setActive(self._gounfinish, not self._isfinish)
		gohelper.setActive(self._gonumbg, not self._isfinish)
		gohelper.setActive(self._gotitlebg, not self._isfinish)
		gohelper.setActive(self._btnright.gameObject, not self._isfinish)
	end

	TaskDispatcher.runDelay(self._afterrightin, self, 0.3)
end

function TurnbackNewTaskView:_afterrightin()
	TaskDispatcher.cancelTask(self._afterrightin, self)
end

function TurnbackNewTaskView:onClickRight()
	self._rightAnimator:Update(0)
	self._rightAnimator:Play("rightout")
	TaskDispatcher.runDelay(self._afterrightout, self, 0.3)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)
end

function TurnbackNewTaskView:onCilckReverse()
	self._isreverse = not self._isreverse

	gohelper.setActive(self._simageHero.gameObject, not self._isreverse)
	gohelper.setActive(self._goscrolldesc, self._isreverse)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_nameplate_switch)

	if self._isreverse then
		self._rightTextAnim:Play()
	end
end

function TurnbackNewTaskView:_playGetRewardFinishAnim(index)
	if index then
		self.removeIndexTab = {
			index
		}
	end

	TaskDispatcher.runDelay(self.delayPlayFinishAnim, self, TurnbackEnum.TaskGetAnimTime)
end

function TurnbackNewTaskView:delayPlayFinishAnim()
	self._taskAnimRemoveItem:removeByIndexs(self.removeIndexTab)
end

function TurnbackNewTaskView:succbuydoublereward()
	self._needPlayAnim = true
end

function TurnbackNewTaskView:_afterbuyanim()
	self._needPlayAnim = false

	TaskDispatcher.cancelTask(self._afterbuyanim, self)
	gohelper.setActive(self._gonormal, true)
	gohelper.setActive(self._godouble, true)
	self._topAnimator:Play("unlock")
	TaskDispatcher.runDelay(self._afterunlockanim, self, 0.6)
end

function TurnbackNewTaskView:_afterunlockanim()
	TaskDispatcher.cancelTask(self._afterunlockanim, self)
	self:refreshTopBg()
end

function TurnbackNewTaskView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		self:_refreshUI()
	end

	if self._needPlayAnim then
		TaskDispatcher.runDelay(self._afterbuyanim, self, 0.3)
	end
end

function TurnbackNewTaskView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_01)
	self:refreshTopBg()
end

function TurnbackNewTaskView:onClose()
	TaskDispatcher.cancelTask(self._afterbuyanim, self)
	TaskDispatcher.cancelTask(self._afterunlockanim, self)
	TaskDispatcher.cancelTask(self._afterleftin, self)
	TaskDispatcher.cancelTask(self._afterleftout, self)
	TaskDispatcher.cancelTask(self._afterrightin, self)
	TaskDispatcher.cancelTask(self._afterrightout, self)
	TaskDispatcher.cancelTask(self.checkScrollEnd, self)
	TaskDispatcher.cancelTask(self.checkTaskScrollEnd, self)
	self._simageHero:UnLoadImage()
end

function TurnbackNewTaskView:onDestroyView()
	TaskDispatcher.cancelTask(self.delayPlayFinishAnim, self)
end

return TurnbackNewTaskView
