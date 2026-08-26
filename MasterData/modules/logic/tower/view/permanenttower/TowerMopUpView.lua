-- chunkname: @modules/logic/tower/view/permanenttower/TowerMopUpView.lua

module("modules.logic.tower.view.permanenttower.TowerMopUpView", package.seeall)

local TowerMopUpView = class("TowerMopUpView", BaseView)

function TowerMopUpView:onInitView()
	self._btncloseFullView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeFullView")
	self._gomopupTip = gohelper.findChild(self.viewGO, "#go_mopupTip")
	self._txttipDesc = gohelper.findChildText(self.viewGO, "#go_mopupTip/#txt_tipDesc")
	self._btncloseMopupTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mopupTip/#btn_closeMopupTip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtcurPassLayer = gohelper.findChildText(self.viewGO, "progress/#txt_curPassLayer")
	self._txtcurAltitude = gohelper.findChildText(self.viewGO, "progress/#txt_curPassLayer/#txt_curAltitude")
	self._txtrewardtip = gohelper.findChildText(self.viewGO, "rewardtip/#txt_rewardtip")
	self._imageprogressBar = gohelper.findChildImage(self.viewGO, "progressbar/#image_progressBar")
	self._imageprogress = gohelper.findChildImage(self.viewGO, "progressbar/#image_progress")
	self._goprogressContent = gohelper.findChild(self.viewGO, "progressbar/#go_progressContent")
	self._goprogressItem = gohelper.findChild(self.viewGO, "progressbar/#go_progressContent/#go_progressItem")
	self._gorewardContent = gohelper.findChild(self.viewGO, "rewardpreview/#go_rewardContent")
	self._gorewardItem = gohelper.findChild(self.viewGO, "rewardpreview/#go_rewardContent/#go_rewardItem")
	self._txtmopupNum = gohelper.findChildText(self.viewGO, "mopuptip/#txt_mopupNum")
	self._imageticket = gohelper.findChildImage(self.viewGO, "mopuptip/#txt_mopupNum/#image_ticket")
	self._btnmopupTip = gohelper.findChildButtonWithAudio(self.viewGO, "mopuptip/#btn_mopupTip")
	self._btnmulti = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_multi")
	self._txtcurMulti = gohelper.findChildText(self.viewGO, "#btn_multi/#txt_curMulti")
	self._goarrow = gohelper.findChild(self.viewGO, "#btn_multi/#go_arrow")
	self._gomultiscroll = gohelper.findChild(self.viewGO, "#go_multiscroll")
	self._gomultiContent = gohelper.findChild(self.viewGO, "#go_multiscroll/Viewport/#go_multiContent")
	self._gomultitem = gohelper.findChild(self.viewGO, "#go_multiscroll/Viewport/#go_multiContent/#go_multitem")
	self._btnmopup = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_mopup")
	self._imagemopupBg = gohelper.findChildImage(self.viewGO, "#btn_mopup/#image_mopupBg")
	self._txtmopup = gohelper.findChildText(self.viewGO, "#btn_mopup/#txt_mopup")
	self._txtmopupCount = gohelper.findChildText(self.viewGO, "#btn_mopup/#txt_mopupCount")
	self._imagecost = gohelper.findChildImage(self.viewGO, "#btn_mopup/#image_cost")
	self._btncloseMultiScroll = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeMultiScroll")
	self._gomultiSelectEffect = gohelper.findChild(self.viewGO, "rewardpreview/vx_eff")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerMopUpView:addEvents()
	self._btncloseMopupTip:AddClickListener(self._btncloseMopupTipOnClick, self)
	self._btncloseFullView:AddClickListener(self._btncloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnmopupTip:AddClickListener(self._btnmopupTipOnClick, self)
	self._btnmulti:AddClickListener(self._btnmultiOnClick, self)
	self._btnmopup:AddClickListener(self._btnmopupOnClick, self)
	self._btncloseMultiScroll:AddClickListener(self._btnmultiOnClick, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.checkReddotShow, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshUI, self)
end

function TowerMopUpView:removeEvents()
	self._btncloseMopupTip:RemoveClickListener()
	self._btncloseFullView:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnmopupTip:RemoveClickListener()
	self._btnmulti:RemoveClickListener()
	self._btnmopup:RemoveClickListener()
	self._btncloseMultiScroll:RemoveClickListener()
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.TowerMopUp, self.refreshUI, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.DailyReresh, self.checkReddotShow, self)
end

TowerMopUpView.progressItemWidth = 157
TowerMopUpView.multiItemHeight = 92

function TowerMopUpView:_btncloseMopupTipOnClick()
	gohelper.setActive(self._gomopupTip, false)
end

function TowerMopUpView:_btncloseOnClick()
	self:closeThis()
end

function TowerMopUpView:_btnmopupTipOnClick()
	gohelper.setActive(self._gomopupTip, true)
end

function TowerMopUpView:_btnmultiOnClick()
	self.isMultiExpand = not self.isMultiExpand

	self:refreshMultiScroll()
end

function TowerMopUpView:onMultiItemClick(index)
	self.curSelectMulti = index

	gohelper.setActive(self._gomultiSelectEffect, false)
	gohelper.setActive(self._gomultiSelectEffect, true)
	self:refreshMultiUI()
	self:refreshRewarwd()
	self:_btnmultiOnClick()
end

function TowerMopUpView:_btnmopupOnClick()
	local curMopUpTimes = TowerModel.instance:getMopUpTimes()

	if curMopUpTimes - self.curSelectMulti < 0 then
		GameFacade.showToast(ToastEnum.TowerMopUpNotEnoughTimes)
	else
		TowerRpc.instance:sendTowerMopUpRequest(self.curSelectMulti)
	end
end

function TowerMopUpView:_editableInitView()
	self.multiItemTab = self:getUserDataTb_()

	gohelper.setActive(self._gomultitem, false)
	gohelper.setActive(self._gomopupTip, false)
	gohelper.setActive(self._gomultiSelectEffect, false)

	self.curSelectMulti = 1
	self.isMultiExpand = false
end

function TowerMopUpView:onUpdateParam()
	return
end

function TowerMopUpView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple_entry)
	self:createMopUpMultiItem()
	self:refreshUI()
	self:checkReddotShow()
end

function TowerMopUpView:createMopUpMultiItem()
	for i = 1, 4 do
		local multiItem = {}

		multiItem.go = gohelper.clone(self._gomultitem, self._gomultiContent, "multi" .. i)
		multiItem.select = gohelper.findChild(multiItem.go, "selecticon")
		multiItem.num = gohelper.findChildText(multiItem.go, "num")
		multiItem.line = gohelper.findChild(multiItem.go, "line")
		multiItem.posY = (i - 1) * TowerMopUpView.multiItemHeight
		multiItem.click = gohelper.getClick(multiItem.go)

		multiItem.click:AddClickListener(self.onMultiItemClick, self, i)
		gohelper.setActive(multiItem.go, true)

		multiItem.num.text = luaLang("multiple") .. i

		recthelper.setAnchorY(multiItem.go.transform, multiItem.posY)
		gohelper.setActive(multiItem.line, i ~= 4)
		table.insert(self.multiItemTab, multiItem)
	end
end

function TowerMopUpView:refreshUI()
	self.curPassLayer = TowerPermanentModel.instance.curPassLayer
	self._txtcurPassLayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_layer"), {
		self.curPassLayer
	})
	self._txtcurAltitude.text = string.format("%sM", self.curPassLayer * 10)
	self.curMaxMopUpConfig = TowerConfig.instance:getMaxMopUpConfigByLayerId(self.curPassLayer)

	if not self.curMaxMopUpConfig then
		logError("未达到扫荡层，不应该打开扫荡界面")

		return
	end

	self:refreshMopUpTimes()
	self:refreshProgress()
	self:refreshRewarwd()
	self:refreshMultiUI()
end

function TowerMopUpView:refreshMopUpTimes()
	local MopUpRecoverTime = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpRecoverTime)
	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	self._txttipDesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_tipdesc"), {
		MopUpRecoverTime,
		maxMopUpTimes,
		curMopUpTimes
	})
	self._txtmopupNum.text = string.format("%s/%s", curMopUpTimes, maxMopUpTimes)

	local ticketId = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MopUpTicketIcon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageticket, ticketId .. "_1", true)
end

function TowerMopUpView:refreshProgress()
	local mopupConfigList = TowerConfig.instance:getTowerMopUpCoList()
	local curMopUpId = self.curMaxMopUpConfig.id
	local nextMopUpId = Mathf.Min(curMopUpId + 1, #mopupConfigList)
	local isMaxMopUpLevel = nextMopUpId == curMopUpId
	local nextMopUpConfig = TowerConfig.instance:getTowerMopUpCo(nextMopUpId)

	self._txtrewardtip.text = isMaxMopUpLevel and luaLang("mopup_rewardtip_max") or GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_rewardtip"), {
		nextMopUpConfig.layerNum
	})

	gohelper.CreateObjList(self, self.progressItemShow, mopupConfigList, self._goprogressContent, self._goprogressItem)

	local totalWidth = (#mopupConfigList - 1) * TowerMopUpView.progressItemWidth

	recthelper.setWidth(self._imageprogressBar.transform, totalWidth)

	local progressWidth = 0

	if not isMaxMopUpLevel then
		local preWidth = (curMopUpId - 1) * TowerMopUpView.progressItemWidth
		local curWidth = (self.curPassLayer - self.curMaxMopUpConfig.layerNum) / (nextMopUpConfig.layerNum - self.curMaxMopUpConfig.layerNum) * TowerMopUpView.progressItemWidth

		progressWidth = preWidth + curWidth
	else
		progressWidth = totalWidth
	end

	recthelper.setWidth(self._imageprogress.transform, progressWidth)
end

function TowerMopUpView:progressItemShow(obj, data, index)
	local goNormal = gohelper.findChild(obj, "go_normal")
	local goGet = gohelper.findChild(obj, "go_get")
	local txtNum = gohelper.findChildText(obj, "txt_num")
	local layerNum = data.layerNum

	gohelper.setActive(goNormal, layerNum > self.curPassLayer)
	gohelper.setActive(goGet, layerNum <= self.curPassLayer)

	txtNum.text = data.layerNum
end

function TowerMopUpView:refreshRewarwd()
	local rewardList = GameUtil.splitString2(self.curMaxMopUpConfig.reward, true)

	gohelper.CreateObjList(self, self.rewardItemShow, rewardList, self._gorewardContent, self._gorewardItem)
end

function TowerMopUpView:rewardItemShow(obj, data, index)
	local itemPos = gohelper.findChild(obj, "go_itempos")
	local item = IconMgr.instance:getCommonPropItemIcon(itemPos)
	local num = data[3] * self.curSelectMulti

	item:setMOValue(data[1], data[2], num)
	item:setHideLvAndBreakFlag(true)
	item:hideEquipLvAndBreak(true)
	item:setCountFontSize(51)
end

function TowerMopUpView:refreshMultiUI()
	for index, multiItem in ipairs(self.multiItemTab) do
		gohelper.setActive(multiItem.select, index == self.curSelectMulti)
	end

	local curMopUpTimes = TowerModel.instance:getMopUpTimes()

	self._txtmopup.text = GameUtil.getSubPlaceholderLuaLang(luaLang("mopup_times"), {
		GameUtil.getNum2Chinese(self.curSelectMulti)
	})
	self._txtmopupCount.text = string.format("-%s", self.curSelectMulti)

	SLFramework.UGUI.GuiHelper.SetColor(self._txtmopupCount, curMopUpTimes - self.curSelectMulti < 0 and "#800015" or "#070706")

	self._txtcurMulti.text = luaLang("multiple") .. self.curSelectMulti

	self:refreshMultiScroll()
end

function TowerMopUpView:refreshMultiScroll()
	transformhelper.setLocalScale(self._goarrow.transform, 1, self.isMultiExpand and -1 or 1, 1)
	gohelper.setActive(self._gomultiscroll, self.isMultiExpand)
	gohelper.setActive(self._btncloseMultiScroll.gameObject, self.isMultiExpand)
end

function TowerMopUpView:checkReddotShow()
	local curMopUpTimes = TowerModel.instance:getMopUpTimes()
	local maxMopUpTimes = TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.MaxMopUpTimes)

	if curMopUpTimes == tonumber(maxMopUpTimes) then
		TimeUtil.setDayFirstLoginRed(TowerEnum.LocalPrefsKey.MopUpDailyRefresh)
	end
end

function TowerMopUpView:onClose()
	for index, multiItem in ipairs(self.multiItemTab) do
		multiItem.click:RemoveClickListener()
	end

	TowerController.instance:checkMopUpReddotShow()
	TowerController.instance:dispatchEvent(TowerEvent.RefreshTowerReddot)
end

function TowerMopUpView:onDestroyView()
	return
end

return TowerMopUpView
