-- chunkname: @modules/logic/gm/view/GMGuideStatusView.lua

module("modules.logic.gm.view.GMGuideStatusView", package.seeall)

local GMGuideStatusView = class("GMGuideStatusView", BaseView)
local StateShow = 1
local StateHide = 2
local StateTweening = 3

function GMGuideStatusView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnClose")
	self._btnShow = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnShow")
	self._btnHide = gohelper.findChildButtonWithAudio(self.viewGO, "view/btnHide")
	self._rect = gohelper.findChild(self.viewGO, "view").transform
	self._btnOp = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnOp")
	self._btnScroll = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnScroll")
	self._btnDelete = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnDelete")
	self._btnFinish = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnFinish")
	self._btnReverse = gohelper.findChildButtonWithAudio(self.viewGO, "view/title/btnReverse")
	self._textBtnReverse = gohelper.findChildText(self.viewGO, "view/title/btnReverse/Text")
	self._inputSearch = gohelper.findChildTextMeshInputField(self.viewGO, "view/title/btnOp/InputField")
end

function GMGuideStatusView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnHide:AddClickListener(self._onClickHide, self)
	self._btnOp:AddClickListener(self._onClickOp, self)
	self._btnScroll:AddClickListener(self._onClickScroll, self)
	self._btnDelete:AddClickListener(self._onClickDelete, self)
	self._btnFinish:AddClickListener(self._onClickFinish, self)
	self._btnReverse:AddClickListener(self._onClicReverse, self)
end

function GMGuideStatusView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnHide:RemoveClickListener()
	self._btnOp:RemoveClickListener()
	self._btnScroll:RemoveClickListener()
	self._btnDelete:RemoveClickListener()
	self._btnFinish:RemoveClickListener()
	self._btnReverse:RemoveClickListener()

	if self._inputSearch then
		self._inputSearch:RemoveOnValueChanged()
		self._inputSearch:RemoveOnEndEdit()
	end
end

function GMGuideStatusView:onOpen()
	self._state = StateShow

	self:_updateBtns()
	TaskDispatcher.runRepeat(self._updateUI, self, 0.5)
	self:_updateBtnReverseText()
end

function GMGuideStatusView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	TaskDispatcher.cancelTask(self._updateUI, self)
	TaskDispatcher.cancelTask(self._delayCancelForbid, self)
	TaskDispatcher.cancelTask(self._dealFinishSecond, self)
	TaskDispatcher.cancelTask(self._onFrameDeleteGuides, self)
	UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, self._onStartGuide, self)
	self:_delayCancelForbid()
end

function GMGuideStatusView:_updateUI()
	GMGuideStatusModel.instance:updateModel()
end

function GMGuideStatusView:_onClickShow()
	if self._state == StateHide then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, 0, 0.2, self._onShow, self)
	end
end

function GMGuideStatusView:_onShow()
	self._tweenId = nil
	self._state = StateShow

	self:_updateBtns()
end

function GMGuideStatusView:_onClickHide()
	if self._state == StateShow then
		self._state = StateTweening
		self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._rect, -800, 0.2, self._onHide, self)
	end
end

function GMGuideStatusView:_onClickOp()
	if self._inputSearch then
		self._inputSearch:SetText(GMGuideStatusModel.instance:getSearch())
		gohelper.setActive(self._inputSearch.gameObject, true)
		self._inputSearch:AddOnValueChanged(self._onSearchValueChanged, self)
		self._inputSearch:AddOnEndEdit(self._onSearchEndEdit, self)
	end
end

function GMGuideStatusView:_onSearchValueChanged(value)
	GMGuideStatusModel.instance:setSearch(value)
end

function GMGuideStatusView:_onSearchEndEdit(value)
	gohelper.setActive(self._inputSearch.gameObject, false)
end

function GMGuideStatusView:_onClickScroll()
	local scrollCG = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "view/scroll"), typeof(UnityEngine.CanvasGroup))

	scrollCG.blocksRaycasts = not scrollCG.blocksRaycasts

	GMGuideStatusModel.instance:onClickShowOpBtn()

	local btnText = gohelper.findChildText(self._btnScroll.gameObject, "Text")

	btnText.text = scrollCG.blocksRaycasts and "点击穿透" or "允许操作"
end

function GMGuideStatusView:_onClickDelete()
	local all = GuideModel.instance:getList()

	self._toDeleteGuides = {}

	for _, guideMO in ipairs(all) do
		table.insert(self._toDeleteGuides, guideMO.id)
	end

	TaskDispatcher.runRepeat(self._onFrameDeleteGuides, self, 0.033)
end

function GMGuideStatusView:_onFrameDeleteGuides()
	if self._toDeleteGuides and #self._toDeleteGuides > 0 then
		local guideId = table.remove(self._toDeleteGuides, 1)

		GMRpc.instance:sendGMRequest("delete guide " .. guideId)
		GuideStepController.instance:clearFlow(guideId)
		GuideModel.instance:remove(GuideModel.instance:getById(guideId))

		if #self._toDeleteGuides % 30 == 0 and #self._toDeleteGuides > 0 then
			GameFacade.showToast(ToastEnum.IconId, "left:" .. #self._toDeleteGuides)
		end
	end

	if not self._toDeleteGuides or #self._toDeleteGuides == 0 then
		GameFacade.showToast(ToastEnum.IconId, "finish")

		self._toDeleteGuides = nil

		TaskDispatcher.cancelTask(self._onFrameDeleteGuides, self)
	end
end

function GMGuideStatusView:_onClickFinish()
	self._needFinishGuides = {}
	self._needDelayFinishGuides = {}

	local guideCOList = GuideConfig.instance:getGuideList()

	for _, guideCO in ipairs(guideCOList) do
		local guideId = guideCO.id
		local guideMO = GuideModel.instance:getById(guideId)

		if guideMO then
			if not guideMO.isFinish then
				GuideStepController.instance:clearFlow(guideId)
				table.insert(self._needFinishGuides, guideId)
			end
		else
			table.insert(self._needDelayFinishGuides, guideId)
		end
	end

	if #self._needDelayFinishGuides > 0 then
		self._prevForbidStatus = GuideController.instance:isForbidGuides()

		if not self._prevForbidStatus then
			GuideController.instance:tempForbidGuides(true)
		end

		GuideController.instance:registerCallback(GuideEvent.StartGuide, self._onStartGuide, self)
	end

	if #self._needFinishGuides > 0 or #self._needDelayFinishGuides > 0 then
		self:_dealFinishSecond()
		TaskDispatcher.runRepeat(self._dealFinishSecond, self, 0.01)
	end
end

local DealCountEverySecond = 60

function GMGuideStatusView:_dealFinishSecond()
	self._hasSendGuideTimes = self._hasSendGuideTimes or {}

	local now = Time.realtimeSinceStartup
	local count = #self._hasSendGuideTimes

	for i = 1, count do
		if now - self._hasSendGuideTimes[1] > 1 then
			table.remove(self._hasSendGuideTimes, 1)
		end
	end

	if #self._hasSendGuideTimes < DealCountEverySecond then
		if #self._needFinishGuides > 0 then
			local guideId = table.remove(self._needFinishGuides, 1)

			self:_sendFinishGuide(guideId)
		elseif #self._needDelayFinishGuides > 0 then
			local guideId = table.remove(self._needDelayFinishGuides, 1)

			GuideController.instance:startGudie(guideId)
			table.insert(self._hasSendGuideTimes, now)
		end
	end

	if self._needFinishGuides then
		if self._needDelayFinishGuides then
			local left = (#self._needFinishGuides or 0) + (#self._needDelayFinishGuides or 0)

			if left > 0 then
				if left % 20 == 0 then
					GameFacade.showToast(ToastEnum.IconId, "left: " .. left)
				end

				UIBlockMgr.instance:startBlock("GMGuideStatusOneKeyFinish")
			else
				UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
				GameFacade.showToast(ToastEnum.IconId, "finish")
				TaskDispatcher.runDelay(self._delayCancelForbid, self, 1)
				TaskDispatcher.cancelTask(self._dealFinishSecond, self)
			end
		end
	end
end

function GMGuideStatusView:_onClicReverse()
	GMGuideStatusModel.instance:onClickReverse()
	self:_updateBtnReverseText()
end

function GMGuideStatusView:_delayCancelForbid()
	if not self._prevForbidStatus then
		GuideController.instance:tempForbidGuides(false)
	end

	self._prevForbidStatus = nil

	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, self._onStartGuide, self)
end

function GMGuideStatusView:_onStartGuide(guideId)
	GuideStepController.instance:clearFlow(guideId)
	self:_sendFinishGuide(guideId)
end

function GMGuideStatusView:_sendFinishGuide(guideId)
	local guideMO = GuideModel.instance:getById(guideId)

	if not guideMO then
		return
	end

	local stepList = GuideConfig.instance:getStepList(guideId)

	for j = #stepList, 1, -1 do
		local stepCO = stepList[j]

		if stepCO.keyStep == 1 then
			self._hasSendGuideTimes = self._hasSendGuideTimes or {}

			table.insert(self._hasSendGuideTimes, Time.realtimeSinceStartup)
			GuideRpc.instance:sendFinishGuideRequest(guideId, stepCO.stepId)

			break
		end
	end
end

function GMGuideStatusView:_updateBtnReverseText()
	self._textBtnReverse.text = GMGuideStatusModel.instance.idReverse and luaLang("p_roombuildingfilterview_raredown") or luaLang("p_roombuildingfilterview_rareup")
end

function GMGuideStatusView:_onHide()
	self._tweenId = nil
	self._state = StateHide

	self:_updateBtns()
end

function GMGuideStatusView:_updateBtns()
	gohelper.setActive(self._btnShow.gameObject, self._state == StateHide)
	gohelper.setActive(self._btnHide.gameObject, self._state == StateShow)
end

return GMGuideStatusView
