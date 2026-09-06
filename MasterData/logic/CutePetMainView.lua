-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetMainView.lua

module("logic.extensions.cutepet.view.CutePetMainView", package.seeall)

local CutePetMainView = class("CutePetMainView", ViewComponent)

function CutePetMainView:ctor()
	CutePetMainView.super.ctor(self)
end

function CutePetMainView:buildUI()
	CutePetMainView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnBag = self:getBtn("btnBag")
	self._btnIllusion = self:getBtn("btnIllusion")
	self._btnItemBag = self:getBtn("btnItemBag")
	self._btnIntro = self:getBtn("btnIntro")
	self._btnRule = self:getBtn("btnRule")
	self._goldBarCon = self:getGo("goldBarCon")
	self._goPopupMsg = self:getGo("popupMsg")

	goutil.setActive(self._goPopupMsg, false)

	self._goPopupMsgContainer = goutil.findChild(self._goPopupMsg, "tableview/Viewport/Content")
	self._travelTips = self:getGo("travelTip")
	self._btnPass = self:getGo("PassNode")
end

function CutePetMainView:bindEvents()
	CutePetMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnBag, self._onClickBag, self)
	GameUtil.addClickHandler(self._btnIllusion, self._onClickIllusion, self)
	GameUtil.addClickHandler(self._btnItemBag, self._onClickItemBag, self)
	GameUtil.addClickHandler(self._btnIntro, self._onClickIntro, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnPass, self._onClickPass, self)
end

function CutePetMainView:unbindEvents()
	CutePetMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBag)
	GameUtil.rmClickHandler(self._btnIllusion)
	GameUtil.rmClickHandler(self._btnItemBag)
	GameUtil.rmClickHandler(self._btnIntro)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnPass)
end

function CutePetMainView:onExit()
	CutePetMainView.super.onExit(self)
end

function CutePetMainView:onEnter()
	self.addGEvent(self, "e_cute_pet_guide", self._onBeginGuide, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqAddView, self._onAddPopMsg, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqDelView, self._onDelPopMsg, self)
	self.addGEvent(self, GlobalNotify.PopupMsgReqDestroySelf, self._onDestroyPopMsgCell, self)
	self.addGEvent(self, GlobalNotify.CutePetReadyTravelAnim, self._onReadyTravel, self)
	self.addGEvent(self, GlobalNotify.CutePetTotalTravelEndOnScene, self._onEndTravel, self)
	self:_initPopupMsg()
	self:_setTopGoldBar()
	self:_checkFirstEnter()
	GuideController.instance:setViewVar("cute_pet_enter_end", 1)
	GameUtil.SetActive(self._travelTips, false)
	GameUtil.SetActive(self._btnPass, false)
end

function CutePetMainView:destroyUI()
	CutePetMainView.super.destroyUI(self)
end

function CutePetMainView:_checkFirstEnter()
	if CutePetModel.instance:getFirstEnter() == true then
		local changeSetId = CutePetModel.instance:getTempChangeSetId()

		MaterialController.instance:showChangeSetInTemp(changeSetId)
	end
end

function CutePetMainView:_onClickClose()
	if not self._traveling then
		CutePetController.instance:leaveScene()
	end
end

function CutePetMainView:_onClickBag()
	if not self._traveling then
		UIStateManager.instance:push(ViewName.CutePetBagView)
	end
end

function CutePetMainView:_onClickIllusion()
	if not self._traveling then
		RoleController.instance:openMyInfoCard(cb, ViewName.DressshowView, 3)
	end
end

function CutePetMainView:_onClickItemBag()
	if not self._traveling then
		UIStateManager.instance:push(ViewName.ItemBag)
	end
end

function CutePetMainView:_onClickIntro()
	if not self._traveling then
		UIStateManager.instance:push(ViewName.CutePetIntroduceView)
	end
end

function CutePetMainView:_onClickRule()
	if not self._traveling then
		TipsFacade.instance:openRulesView("cute_pet_garden")
	end
end

function CutePetMainView:_onClickPass()
	if self._traveling == true then
		CutePetController.instance:travelSkipOnScene()
	end
end

function CutePetMainView:_onBeginGuide()
	if CutePetModel.instance:getFirstEnter() == true then
		UIStateManager.instance:push(ViewName.CutePetHexGuideView)
		GuideController.instance:finishGuide()
	end
end

function CutePetMainView:_onReadyTravel()
	local info = {}

	info.callBack = GameUtil.handler(self._onClickTravel, self)
	info.tipsStr = lang("已准备就绪，旅途开始！")
	self._traveling = true

	UIStateManager.instance:push(ViewName.CutePetTravelTriggerView, info)
end

function CutePetMainView:_onClickTravel()
	GameUtil.SetActive(self._goldBarCon, false)
	GameUtil.SetActive(self._travelTips, true)
	GameUtil.SetActive(self._btnPass, true)
	CutePetController.instance:startMoveTravelCutePet()
end

function CutePetMainView:_onEndTravel()
	self._traveling = false

	GameUtil.SetActive(self._goldBarCon, true)
	GameUtil.SetActive(self._btnPass, false)
	GameUtil.SetActive(self._travelTips, false)
end

function CutePetMainView:_initPopupMsg()
	self:_destroyPopMsgs()

	local queue = MainUIPopupMsgController.instance:getQueue()

	self._msgCells = {}

	for i, data in ipairs(queue) do
		self:_addOnePopupMsg(data)
	end

	self:_invalidatePopMsg()
end

function CutePetMainView:_addOnePopupMsg(data)
	trycall(function()
		local cellTemplate = self:getGo(data.info.cellName)

		if cellTemplate and data.info.class then
			if data.info.cd == nil and data.info.showInitCD then
				data.info.cd = data.info.showInitCD + ServerTime.now()
				data.cd = data.info.cd
			end

			if data.info.cd and (data.info.cd <= 0 or data.info.cd - ServerTime.now() > 0) or data.info.showInitCD then
				local cell = goutil.cloneAndSetParent(cellTemplate, self._goPopupMsgContainer.transform)

				goutil.setActive(cell, true)

				local instance = data.info.class.New(cell, data)

				instance:startup()

				self._msgCells[data.key] = instance
			else
				dump(data.info)
			end
		else
			printError("cellTemplate or class is nil")
		end
	end)
end

function CutePetMainView:_destroyPopMsgs()
	if self._msgCells then
		for id, instance in pairs(self._msgCells) do
			instance:dispose()
		end

		self._msgCells = nil
	end

	self:_invalidatePopMsg()
end

function CutePetMainView:_onAddPopMsg(data)
	if not data.info.tag or data.info.tag ~= "cutepetteamtravel" then
		return
	end

	self:_addOnePopupMsg(data)
	self:_invalidatePopMsg()
end

function CutePetMainView:_onDelPopMsg(data)
	if not data.info.tag or data.info.tag ~= "cutepetteamtravel" then
		return
	end

	self:_onDestroyPopMsgCell(data)
end

function CutePetMainView:_onDestroyPopMsgCell(data)
	if not data.info.tag or data.info.tag ~= "cutepetteamtravel" then
		return
	end

	local instance = self._msgCells[data.key]

	if instance then
		instance:dispose()

		self._msgCells[data.key] = nil

		self:_invalidatePopMsg()
		MainUIPopupMsgController.instance:removePopMsg(data.key)
	end
end

function CutePetMainView:_invalidatePopMsg()
	local bEmpty = true

	if self._msgCells then
		for i, v in pairs(self._msgCells) do
			bEmpty = false

			break
		end
	end

	goutil.setActive(self._goPopupMsg, not bEmpty)
end

function CutePetMainView:_setTopGoldBar()
	local btn_list = {}

	table.insert(btn_list, {
		id = "8:37",
		showAdd = true
	})
	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list, false)
end

return CutePetMainView
