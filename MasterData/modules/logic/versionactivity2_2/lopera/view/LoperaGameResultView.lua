-- chunkname: @modules/logic/versionactivity2_2/lopera/view/LoperaGameResultView.lua

module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultView", package.seeall)

local LoperaGameResultView = class("LoperaGameResultView", BaseView)
local loperaActId = VersionActivity2_2Enum.ActivityId.Lopera

function LoperaGameResultView:onInitView()
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtStageNum = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classnum")
	self._txtStageName = gohelper.findChildText(self.viewGO, "txtFbName/#txt_classname")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "#go_fail")
	self._txtEventNum = gohelper.findChildText(self.viewGO, "targets/#go_targetitem/#txt_Num")
	self._txtActionPoint = gohelper.findChildText(self.viewGO, "targets/#go_actionpoint/#txt_Num")
	self._goTips = gohelper.findChild(self.viewGO, "content/Layout/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Tips/#txt_Tips")
	self._scrollItem = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	self._gorewardContent = gohelper.findChild(self.viewGO, "#scroll_List/Viewport/Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LoperaGameResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function LoperaGameResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function LoperaGameResultView:_btncloseOnClick()
	if self:isLockOp() then
		return
	end

	LoperaController.instance:gameResultOver()
end

function LoperaGameResultView:_editableInitView()
	return
end

function LoperaGameResultView:onUpdateParam()
	return
end

function LoperaGameResultView:onOpen()
	self._animator = self.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	self.addEventCb(self, LoperaController.instance, LoperaEvent.ExitGame, self.onExitGame, self)

	if self.viewContainer then
		NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
	end

	self:_setLockOpTime(1)
	self:refreshUI()
end

function LoperaGameResultView:onExitGame()
	self:closeThis()
end

function LoperaGameResultView:onClose()
	return
end

function LoperaGameResultView:onDestroyView()
	return
end

function LoperaGameResultView:playViewAnimator(animName)
	if self._animator then
		self._animator.enabled = true

		self._animator:Play(animName, 0, 0)
	end
end

function LoperaGameResultView:refreshUI()
	local curGameState = Activity168Model.instance:getCurGameState()
	local endLessId = curGameState.endlessId

	self._isEndLess = endLessId > 0

	local curEpisodeId = Activity168Model.instance:getCurEpisodeId()
	local resultParams = self.viewParam
	local resultreason = resultParams.settleReason
	local completed = resultreason == LoperaEnum.ResultEnum.Completed or self._isEndLess
	local powerUsedUp = resultreason == LoperaEnum.ResultEnum.PowerUseup and not self._isEndLess
	local quit = resultreason == LoperaEnum.ResultEnum.Quit
	local isFail = powerUsedUp or quit
	local episodeCfg = Activity168Config.instance:getEpisodeCfg(loperaActId, curEpisodeId)

	self._txtStageName.text = episodeCfg.name
	self._txtStageNum.text = episodeCfg.orderId

	gohelper.setActive(self._gosuccess, completed)
	gohelper.setActive(self._gofail, isFail)
	AudioMgr.instance:trigger((isFail or nil) and (AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva))

	self._txtEventNum.text = resultParams.cellCount

	local curActionPoint = Activity168Model.instance:getCurActionPoint()

	self._txtActionPoint.text = math.max(0, curActionPoint)

	self:refreshAllItems()
end

function LoperaGameResultView:refreshAllItems()
	local resultParams = self.viewParam
	local curEpisodeItems = resultParams.totalItems

	self._items = {}

	for i, item in ipairs(curEpisodeItems) do
		self._items[#self._items + 1] = {
			itemId = item.itemId,
			count = item.count
		}
	end

	gohelper.CreateObjList(self, self._createItem, self._items, self._gorewardContent, self._scrollItem, LoperaGoodsItem)
end

function LoperaGameResultView:_createItem(itemComp, itemData, index)
	local itemId = itemData.itemId
	local itemCfg = Activity168Config.instance:getGameItemCfg(loperaActId, itemId)
	local itemCount = itemData.count

	itemComp:onUpdateData(itemCfg, itemCount, index)
end

function LoperaGameResultView:_setLockOpTime(lockTime)
	self._lockTime = Time.time + lockTime
end

function LoperaGameResultView:isLockOp()
	if self._lockTime and Time.time < self._lockTime then
		return true
	end

	return false
end

return LoperaGameResultView
