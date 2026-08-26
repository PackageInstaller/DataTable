-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeRefundTipView.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeRefundTipView", package.seeall)

local ArcadeRefundTipView = class("ArcadeRefundTipView", BaseView)

function ArcadeRefundTipView:onInitView()
	self._gointro = gohelper.findChild(self.viewGO, "content/go_Desc")
	self._scrollintro = gohelper.findChildScrollRect(self.viewGO, "content/go_Desc/#scroll_desc")
	self._gointrocontent = gohelper.findChild(self.viewGO, "content/go_Desc/#scroll_desc/viewport/content")
	self._txtintro = gohelper.findChildText(self.viewGO, "content/go_Desc/#scroll_desc/viewport/content/#txt_desc")
	self._btnskipdesc = gohelper.findChildClickWithDefaultAudio(self.viewGO, "content/go_Desc/#btn_skipdesc")
	self._gototal = gohelper.findChild(self.viewGO, "content/go_Total")
	self._goitemcontent = gohelper.findChild(self.viewGO, "content/go_Total/#scroll_total/viewport/content")
	self._godescItem = gohelper.findChild(self.viewGO, "content/go_Total/#scroll_total/viewport/content/#go_descItem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "content/go_Total/#btn_confirm")
	self._txtnum = gohelper.findChildText(self.viewGO, "content/go_Total/#btn_confirm/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeRefundTipView:addEvents()
	self._btnskipdesc:AddClickListener(self._btnskipdescOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function ArcadeRefundTipView:removeEvents()
	self._btnskipdesc:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function ArcadeRefundTipView:_btnskipdescOnClick()
	self._introductionTypingIndex = self._allIntroductionCharCount

	self:_typingIntroduction()
	ZProj.UGUIHelper.RebuildLayout(self._gointrocontent.transform)

	self._scrollintro.verticalNormalizedPosition = 0
end

function ArcadeRefundTipView:_btnconfirmOnClick()
	self:closeThis()
end

function ArcadeRefundTipView:_editableInitView()
	self._transscroll = self._scrollintro.transform
	self._animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._txtintro.text = ""

	local introLang = luaLang("arcade_return_reward_introduction")

	self._introductionCharArr = GameUtil.getUCharArrWithoutRichTxt(introLang) or {}
	self._allIntroductionCharCount = #self._introductionCharArr

	local strReturnReward = ArcadeOutSizeModel.instance:getStrReturnRewardData()

	if string.nilorempty(strReturnReward) then
		logError("ArcadeRefundTipView:_editableInitView strReturnReward is nil or empty")
	end

	local rewardArr = GameUtil.splitString2(strReturnReward, true, "#", ":")

	if not rewardArr then
		logError("ArcadeRefundTipView:_editableInitView rewardArr is nil")
		self:closeThis()

		return
	end

	local totalCoinCount = 0
	local rewardDataList = {}

	for _, rewardData in ipairs(rewardArr) do
		local difficultyId = rewardData[1]
		local passCount = rewardData[2]
		local coinCount = rewardData[3]

		totalCoinCount = totalCoinCount + coinCount

		table.insert(rewardDataList, {
			difficultyId = difficultyId,
			passCount = passCount,
			coinCount = coinCount
		})
	end

	self._rewardItemList = {}

	gohelper.CreateObjList(self, self._onCreateItem, rewardDataList, self._goitemcontent, self._godescItem)

	self._txtnum.text = totalCoinCount

	gohelper.setActive(self._gointro, true)
	gohelper.setActive(self._gototal, false)
end

function ArcadeRefundTipView:_onCreateItem(obj, data, index)
	local difficultyId, coinCount, passCount

	if data then
		difficultyId = data.difficultyId
		coinCount = data.coinCount
		passCount = data.passCount
	end

	local rewardItem = self:getUserDataTb_()

	rewardItem.go = obj
	rewardItem.animator = obj:GetComponent(gohelper.Type_Animator)
	rewardItem.animator.speed = 0

	local actId = ArcadeModel.instance:getAct222Id()
	local desc = ArcadeConfig.instance:getRefundDesc(actId, difficultyId) or ""
	local txtdesc = gohelper.findChildText(obj, "#txt_desc")

	txtdesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(desc, passCount)

	local txtnum = gohelper.findChildText(obj, "#txt_desc/#txt_num")

	txtnum.text = string.format("+%s", coinCount or 0)
	self._rewardItemList[index] = rewardItem
end

function ArcadeRefundTipView:onUpdateParam()
	return
end

function ArcadeRefundTipView:onOpen()
	self._introductionTypingIndex = 1

	if self._allIntroductionCharCount <= 0 then
		self:_delayChangeToTotal()
	else
		local intervalTime = ArcadeConfig.instance:getArcadeConst(ArcadeEnum.ConstId.ReturnRewardIntervalTime, true) / TimeUtil.OneSecondMilliSecond

		TaskDispatcher.runRepeat(self._typingIntroduction, self, intervalTime)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_interface_open)
end

function ArcadeRefundTipView:_typingIntroduction()
	self._txtintro.text = table.concat(self._introductionCharArr, "", 1, self._introductionTypingIndex)
	self._scrollintro.verticalNormalizedPosition = 0

	if self._introductionTypingIndex >= self._allIntroductionCharCount then
		self:_endIntroduction()
	else
		self._introductionTypingIndex = self._introductionTypingIndex + 1
	end
end

function ArcadeRefundTipView:_endIntroduction()
	gohelper.setActive(self._btnskipdesc, false)
	TaskDispatcher.cancelTask(self._typingIntroduction, self)
	TaskDispatcher.cancelTask(self._delayChangeToTotal)
	TaskDispatcher.runDelay(self._delayChangeToTotal, self, TimeUtil.OneSecond)
end

function ArcadeRefundTipView:_delayChangeToTotal()
	if self._animator then
		self._animator.enabled = true

		gohelper.setActive(self._gointro, true)
		gohelper.setActive(self._gototal, true)
		self._animator:Play(UIAnimationName.Switch)
	else
		gohelper.setActive(self._gointro, false)
		gohelper.setActive(self._gototal, true)
	end

	TaskDispatcher.cancelTask(self._beginShowRewardItem)
	TaskDispatcher.runDelay(self._beginShowRewardItem, self, 0.167)
end

function ArcadeRefundTipView:_beginShowRewardItem()
	self._curRewardOpenIndex = nil

	self:_onDelayPlayRewardItemOpen()

	local rewardItemCount = #self._rewardItemList

	if rewardItemCount > 1 then
		TaskDispatcher.runRepeat(self._onDelayPlayRewardItemOpen, self, 0.03, rewardItemCount - 1)
	end
end

function ArcadeRefundTipView:_onDelayPlayRewardItemOpen()
	self._curRewardOpenIndex = not self._curRewardOpenIndex and 1 or self._curRewardOpenIndex + 1

	local rewardItem = self._rewardItemList[self._curRewardOpenIndex]

	if rewardItem and rewardItem.animator then
		rewardItem.animator.speed = 1
	end
end

function ArcadeRefundTipView:onClose()
	ArcadeOutSideRpc.instance:sendArcadeCloseRewardPanelRequest()
end

function ArcadeRefundTipView:onDestroyView()
	TaskDispatcher.cancelTask(self._typingIntroduction, self)
	TaskDispatcher.cancelTask(self._delayChangeToTotal, self)
	TaskDispatcher.cancelTask(self._beginShowRewardItem)
	TaskDispatcher.cancelTask(self._onDelayPlayRewardItemOpen, self)
end

return ArcadeRefundTipView
