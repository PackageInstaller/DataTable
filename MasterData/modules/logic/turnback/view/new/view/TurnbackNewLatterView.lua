-- chunkname: @modules/logic/turnback/view/new/view/TurnbackNewLatterView.lua

module("modules.logic.turnback.view.new.view.TurnbackNewLatterView", package.seeall)

local TurnbackNewLatterView = class("TurnbackNewLatterView", BaseView)

function TurnbackNewLatterView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gofirst = gohelper.findChild(self.viewGO, "first")
	self._gonormal = gohelper.findChild(self.viewGO, "normal")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TurnbackNewLatterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function TurnbackNewLatterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function TurnbackNewLatterView:_btncloseOnClick()
	self:closeThis()
end

function TurnbackNewLatterView:_editableInitView()
	return
end

function TurnbackNewLatterView:onUpdateParam()
	return
end

function TurnbackNewLatterView:onOpen()
	if self.viewParam then
		self.day = self.viewParam.day or 1
	end

	if self.viewParam then
		self._isNormal = self.viewParam.isNormal or false
	end

	if self.viewParam then
		self.notfirst = self.viewParam.notfirst or false
	end

	gohelper.setActive(self._gonormal, self._isNormal)
	gohelper.setActive(self._gofirst, not self._isNormal)

	self.turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self.config = TurnbackConfig.instance:getTurnbackSignInDayCo(self.turnbackId, self.day)

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_letter_expansion)
end

function TurnbackNewLatterView:refreshUI()
	if self._isNormal then
		self:refreshNoraml()
	else
		self:refreshFirst()
	end
end

function TurnbackNewLatterView:refreshNoraml()
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "normal/simage_page2/#simage_role")
	self._txtdec = gohelper.findChildText(self.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "normal/simage_page2/#scroll_desc/Viewport/#txt_dec/#txt_name")
	self._simagesign = gohelper.findChildSingleImage(self.viewGO, "normal/simage_page2/#simage_sign")

	self._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. self.day))

	self._txtdec.text = self.config.content
	self._txtname.text = self.config.name

	local path = "characterget/" .. tostring(self.config.characterId)

	self._simagesign:LoadImage(ResUrl.getSignature(path))
end

function TurnbackNewLatterView:refreshFirst()
	local turnbackco = TurnbackConfig.instance:getTurnbackCo(self.turnbackId)

	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "first/simage_page2/#simage_role")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "first/simage_page2/#scroll_desc")
	self._txtdec = gohelper.findChildText(self.viewGO, "first/simage_page2/#scroll_desc/Viewport/#txt_dec")
	self._gorewardicon = gohelper.findChild(self.viewGO, "first/simage_page2/go_reward/rewardicon")
	self._goallrewardicon = gohelper.findChild(self.viewGO, "first/simage_page3/#scroll_reward/Viewport/Content/rewardicon")
	self._btngoto = gohelper.findChildButton(self.viewGO, "first/simage_page3/#btn_goto")

	self._simagerole:LoadImage(ResUrl.getTurnbackIcon("new/letter/turnback_new_letter_role" .. self.day))

	self._txtdec.text = self.config.content

	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	gohelper.setActive(self._btngoto.gameObject, not self.notfirst)

	self.toprewardList = {}

	local bonusCo = GameUtil.splitString2(turnbackco.onceBonus, true)

	for index, co in ipairs(bonusCo) do
		local rewardItem = self:getUserDataTb_()

		rewardItem.goicon = gohelper.cloneInPlace(self._gorewardicon, "reward" .. index)
		rewardItem.gorewardicon = gohelper.findChild(rewardItem.goicon, "icon")
		rewardItem.goreceive = gohelper.findChild(rewardItem.goicon, "go_receive")

		gohelper.setActive(rewardItem.goicon, true)

		rewardItem.itemIcon = rewardItem.itemIcon or IconMgr.instance:getCommonPropItemIcon(rewardItem.gorewardicon)

		rewardItem.itemIcon:setMOValue(co[1], co[2], co[3], nil, true)
		rewardItem.itemIcon:setScale(0.5)
		rewardItem.itemIcon:setCountFontSize(48)
		table.insert(self.toprewardList, rewardItem)
	end

	self:setRewardReceiveState()

	self.rewardList = {}

	local allRewardCo = turnbackco.bonusList

	if allRewardCo then
		local bonusCo = GameUtil.splitString2(allRewardCo, true)

		for index, co in ipairs(bonusCo) do
			local rewardItem = self:getUserDataTb_()

			rewardItem.goicon = gohelper.cloneInPlace(self._goallrewardicon, "reward" .. index)

			gohelper.setActive(rewardItem.goicon, true)

			rewardItem.itemIcon = rewardItem.itemIcon or IconMgr.instance:getCommonPropItemIcon(rewardItem.goicon)

			rewardItem.itemIcon:setMOValue(co[1], co[2], co[3], nil, true)
			rewardItem.itemIcon:setScale(0.5)
			rewardItem.itemIcon:setCountFontSize(48)
			table.insert(self.rewardList, rewardItem)
		end
	end

	if TurnbackModel.instance:haveOnceBonusReward() then
		TaskDispatcher.runDelay(self.afterAnim, self, 1)
	end
end

function TurnbackNewLatterView:afterAnim()
	TaskDispatcher.cancelTask(self.afterAnim, self)

	local turnbackId = TurnbackModel.instance:getCurTurnbackId()

	TurnbackRpc.instance:sendTurnbackOnceBonusRequest(turnbackId)
end

function TurnbackNewLatterView:_btngotoOnClick()
	local turnbackId = TurnbackModel.instance:getCurTurnbackId()
	local param = {
		turnbackId = turnbackId
	}

	TurnbackController.instance:openTurnbackBeginnerView(param)
	self:closeThis()
end

function TurnbackNewLatterView:onClose()
	if not self._isNormal then
		self._btngoto:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(self.afterAnim, self)
	TaskDispatcher.cancelTask(self.checkScrollEnd, self)
end

function TurnbackNewLatterView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView and not self._isNormal and not self.notfirst then
		for _, node in ipairs(self.toprewardList) do
			gohelper.setActive(node.goreceive, true)
		end
	end
end

function TurnbackNewLatterView:setRewardReceiveState()
	if not self._isNormal and self.notfirst then
		for _, node in ipairs(self.toprewardList) do
			gohelper.setActive(node.goreceive, true)
		end
	end
end

function TurnbackNewLatterView:onDestroyView()
	return
end

return TurnbackNewLatterView
