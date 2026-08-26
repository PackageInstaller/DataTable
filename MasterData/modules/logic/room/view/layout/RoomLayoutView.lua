-- chunkname: @modules/logic/room/view/layout/RoomLayoutView.lua

module("modules.logic.room.view.layout.RoomLayoutView", package.seeall)

local RoomLayoutView = class("RoomLayoutView", BaseView)

function RoomLayoutView:onInitView()
	self._simagemaskbg = gohelper.findChildSingleImage(self.viewGO, "go_normalroot/#simage_maskbg")
	self._gotitleLayout = gohelper.findChild(self.viewGO, "go_normalroot/#go_titleLayout")
	self._gotitleCopy = gohelper.findChild(self.viewGO, "go_normalroot/#go_titleCopy")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "go_normalroot/#scroll_ItemList")
	self._gotipsusing = gohelper.findChild(self.viewGO, "go_normalroot/#go_tips_using")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_cancel")
	self._btncover = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_cover")
	self._btnchange = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_change")
	self._btnnew = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_new")
	self._btnvisitcover = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_visitcover")
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/Btn/#btn_save")
	self._btnsharecode = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/#btn_sharecode")
	self._txtshareCount = gohelper.findChildText(self.viewGO, "go_normalroot/rightTop/#txt_shareCount")
	self._btnshareCount = gohelper.findChildButtonWithAudio(self.viewGO, "go_normalroot/rightTop/#txt_shareCount/#btn_shareCount")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomLayoutView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btncover:AddClickListener(self._btncoverOnClick, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnnew:AddClickListener(self._btnnewOnClick, self)
	self._btnvisitcover:AddClickListener(self._btnvisitcoverOnClick, self)
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnsharecode:AddClickListener(self._btnsharecodeOnClick, self)
	self._btnshareCount:AddClickListener(self._btnshareCountOnClick, self)
end

function RoomLayoutView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btncover:RemoveClickListener()
	self._btnchange:RemoveClickListener()
	self._btnnew:RemoveClickListener()
	self._btnvisitcover:RemoveClickListener()
	self._btnsave:RemoveClickListener()
	self._btnsharecode:RemoveClickListener()
	self._btnshareCount:RemoveClickListener()
end

function RoomLayoutView:_btnsaveOnClick()
	self:_onOpenCreateTipsView()
end

function RoomLayoutView:_btnshareCountOnClick()
	ViewMgr.instance:openView(ViewName.RoomTipsView, {
		type = RoomTipsView.ViewType.PlanShare,
		shareCount = RoomLayoutModel.instance:getUseCount()
	})
end

function RoomLayoutView:_btnsharecodeOnClick()
	ViewMgr.instance:openView(ViewName.RoomLayoutFindShareView)
end

function RoomLayoutView:_btnvisitcoverOnClick()
	local titleStr = self:_getCoverTitleStr()

	self:_onOpenCreateTipsView(titleStr)
end

function RoomLayoutView:_btncancelOnClick()
	self:closeThis()
end

function RoomLayoutView:_btncoverOnClick()
	local titleStr = self:_getCoverTitleStr()

	self:_onOpenCreateTipsView(titleStr)
end

function RoomLayoutView:_btnchangeOnClick()
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if not selectMO then
		return
	end

	local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount(selectMO.buildingDegree) or 0
	local characterCount = RoomCharacterModel.instance:getConfirmCharacterCount() or 0
	local needRemoveCount = characterCount - maxCharacterCount
	local switchPlanId = selectMO.id

	if needRemoveCount > 0 then
		ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
			needRemoveCount = needRemoveCount,
			sureCallback = self._confirmSwitchPlanCallback,
			callbackObj = self,
			callbackParam = {
				switchPlanId = switchPlanId
			}
		})
	else
		self:_sendSwitchRoomPlan(switchPlanId)
	end
end

function RoomLayoutView:_btnnewOnClick()
	self:_onOpenCreateTipsView()
end

function RoomLayoutView:_confirmSwitchPlanCallback(param)
	self:_sendSwitchRoomPlan(param.switchPlanId)
end

function RoomLayoutView:_sendSwitchRoomPlan(switchPlanId)
	RoomLayoutController.instance:sendSwitchRoomPlanRequest(switchPlanId)
end

function RoomLayoutView:_editableInitView()
	self._animator = self.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	self._gorightTop = gohelper.findChild(self.viewGO, "go_normalroot/rightTop")
end

function RoomLayoutView:onUpdateParam()
	return
end

function RoomLayoutView:_getCoverTitleStr()
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if selectMO and selectMO:isSharing() then
		return luaLang("room_layoutplan_cover_sharecode_tips")
	end

	return luaLang("room_layoutplan_cover_tips")
end

function RoomLayoutView:_onOpenCreateTipsView(titleStr)
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if selectMO then
		local isShow = selectMO.id ~= RoomEnum.LayoutUsedPlanId and RoomController.instance:isVisitMode()

		RoomLayoutController.instance:openCreateTipsView(titleStr, false, isShow, self._onCreateCallblck, self)
	end
end

function RoomLayoutView:_onCreateCallblck(isSelect)
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if not RoomController.instance:isVisitMode() then
		RoomLayoutController.instance:sendCreateRpc(selectMO, isSelect)

		return
	end

	self._isVisitCopyRpcSelect = isSelect

	if RoomController.instance:isVisitShareMode() then
		local canUseShareCount = RoomLayoutModel.instance:getCanUseShareCount()

		if canUseShareCount <= 0 then
			GameFacade.showToast(RoomEnum.Toast.LayoutPlanUseShareCodeNotNum)

			return
		end

		if canUseShareCount <= CommonConfig.instance:getConstNum(ConstEnum.RoomPlanCanUseShareTipNum) then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomLayoutPlanCanUseShareCount, MsgBoxEnum.BoxType.Yes_No, self._checkVisitCharacterPlaceCount, nil, nil, self, nil, nil, canUseShareCount)

			return
		end
	end

	self:_checkVisitCharacterPlaceCount()
end

function RoomLayoutView:_checkVisitCharacterPlaceCount()
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	if self._isVisitCopyRpcSelect or selectMO and selectMO.id == RoomEnum.LayoutUsedPlanId then
		local xObInfo = RoomModel.instance:getInfoByMode(RoomModel.instance:getGameMode())
		local blockInfos, buildingInfos = RoomLayoutHelper.findHasBlockBuildingInfos(xObInfo and xObInfo.infos, xObInfo and xObInfo.buildingInfos)
		local totalDegree, blockCount = RoomLayoutHelper.sunDegreeInfos(blockInfos, buildingInfos)
		local roomLevel = RoomModel.instance:getRoomLevel()
		local maxCharacterCount = RoomCharacterModel.instance:getMaxCharacterCount(totalDegree, roomLevel) or 0
		local obInfo = RoomModel.instance:getObInfo()
		local roomCharacterMOList = RoomModel.instance:getCharacterList()
		local needRemoveCount = #roomCharacterMOList - maxCharacterCount

		if needRemoveCount > 0 then
			ViewMgr.instance:openView(ViewName.RoomCharacterPlaceInfoView, {
				notUpdateMapModel = true,
				needRemoveCount = needRemoveCount,
				sureCallback = self._sendVisitCopyRpc,
				callbackObj = self,
				roomCharacterMOList = roomCharacterMOList
			})

			return
		end
	end

	self:_sendVisitCopyRpc()
end

function RoomLayoutView:_sendVisitCopyRpc()
	local selectMO = RoomLayoutListModel.instance:getSelectMO()

	RoomLayoutController.instance:sendVisitCopyRpc(selectMO, self._isVisitCopyRpcSelect)
	self:closeThis()
end

function RoomLayoutView:onOpen()
	self.addEventCb(self, RoomLayoutController.instance, RoomEvent.UISelectLayoutPlanItem, self._onUISelectLayoutPlan, self)
	RoomLayoutListModel.instance:initScelect(RoomController.instance:isVisitMode())
	self:_onUISelectLayoutPlan()
	self.viewContainer:movetoSelect()
end

function RoomLayoutView:onClose()
	return
end

function RoomLayoutView:_onUISelectLayoutPlan()
	self:_showButUI()
end

function RoomLayoutView:_showButUI()
	self._isObMode = RoomController.instance:isObMode()
	self._isVisitMode = RoomController.instance:isVisitMode()

	local selectMO = RoomLayoutListModel.instance:getSelectMO()
	local canShowBtn = true

	self._isEmpty = true

	if selectMO == nil or selectMO:isUse() and self._isObMode then
		canShowBtn = false
	else
		self._isEmpty = selectMO:isEmpty()
	end

	gohelper.setActive(self._gotitleLayout, self._isObMode)
	gohelper.setActive(self._gotitleCopy, self._isVisitMode)
	gohelper.setActive(self._gorightTop, self._isObMode)

	local isPlayAnim = self._isLastShowBtn ~= canShowBtn and self._isLastShowBtn ~= nil

	self._isLastShowBtn = canShowBtn

	if isPlayAnim then
		if canShowBtn then
			self:_onShowButUI()
		end

		gohelper.setActive(self._gotipsusing, true)
		self._animator:Play(canShowBtn and "switch_btn" or "switch_tips")
		TaskDispatcher.cancelTask(self._onShowButUI, self)
		TaskDispatcher.runDelay(self._onShowButUI, self, 0.5)
	else
		self:_onShowButUI()
	end

	self._txtshareCount.text = RoomLayoutModel.instance:getUseCount()
end

function RoomLayoutView:_onShowButUI()
	local isObMode = RoomController.instance:isObMode()
	local isVisitMode = RoomController.instance:isVisitMode()
	local canShowBtn = self._isLastShowBtn
	local isEmpty = self._isEmpty

	gohelper.setActive(self._btncancel, canShowBtn and isVisitMode)
	gohelper.setActive(self._btncover, canShowBtn and isObMode and not isEmpty)
	gohelper.setActive(self._btnvisitcover, canShowBtn and isVisitMode and not isEmpty)
	gohelper.setActive(self._btnnew, canShowBtn and isObMode and isEmpty)
	gohelper.setActive(self._btnsave, canShowBtn and isVisitMode and isEmpty)
	gohelper.setActive(self._btnchange, canShowBtn and isObMode and not isEmpty)
	gohelper.setActive(self._gotipsusing, not canShowBtn)
	gohelper.setActive(self._btnsharecode, isObMode)
end

function RoomLayoutView:onDestroyView()
	TaskDispatcher.cancelTask(self._onShowButUI, self)
	RoomMapController.instance:dispatchEvent(RoomEvent.ResumeAtmosphereEffect)
end

return RoomLayoutView
