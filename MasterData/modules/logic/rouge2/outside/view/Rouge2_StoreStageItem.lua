-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_StoreStageItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_StoreStageItem", package.seeall)

local Rouge2_StoreStageItem = class("Rouge2_StoreStageItem", LuaCompBase)

function Rouge2_StoreStageItem:init(go)
	self.go = go
	self._goNormal = gohelper.findChild(self.go, "#go_Normal")
	self._txtNormalTitle = gohelper.findChildText(self.go, "#go_Normal/#txt_NormalTitle")
	self._goSelect = gohelper.findChild(self.go, "#go_Select")
	self._txtSelectTitle = gohelper.findChildText(self.go, "#go_Select/#txt_SelectTitle")
	self._goLocked = gohelper.findChild(self.go, "#go_Locked")
	self._btnselectTag = gohelper.findChildButtonWithAudio(self.go, "#btn_selectTag")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_StoreStageItem:addEventListeners()
	self._btnselectTag:AddClickListener(self._btnselectTagOnClick, self)
end

function Rouge2_StoreStageItem:removeEventListeners()
	self._btnselectTag:RemoveClickListener()
end

function Rouge2_StoreStageItem:_btnselectTagOnClick()
	local curStageId = Rouge2_StoreModel.instance:getCurStageId()

	if curStageId == self.config.id then
		return
	end

	if self.isOpen == false then
		GameFacade.showToast(ToastEnum.Rouge2StoreNotOpen)

		return
	end

	Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnSelectStoreStage, self.id)
end

function Rouge2_StoreStageItem:_editableInitView()
	self._goNormalClaimed = gohelper.findChild(self._goNormal, "#go_Claimed")
	self._goSelectClaimed = gohelper.findChild(self._goSelect, "#go_Claimed")
	self._imageTimeNormal = gohelper.findChild(self._goNormal, "#txt_NormalTitle/image")
	self._imageTimeSelect = gohelper.findChild(self._goSelect, "#txt_SelectTitle/image")
	self._goreddot = gohelper.findChild(self.go, "#go_reddot")
end

function Rouge2_StoreStageItem:setActive(active)
	gohelper.setActive(self.go, active)
end

function Rouge2_StoreStageItem:setInfo(stageId)
	self.id = stageId

	local config = Rouge2_OutSideConfig.instance:getRewardStageConfigById(stageId)

	if config == nil then
		logError("Rouge2 Store stageConfig is nil stageId" .. stageId)
		self:setActive(false)

		return
	end

	self.config = config

	self:refreshUI()
end

function Rouge2_StoreStageItem:setSelect(selectStageId)
	local isSelect = selectStageId == self.config.id

	gohelper.setActive(self._goNormal, not isSelect)
	gohelper.setActive(self._goSelect, isSelect)

	if isSelect and self._reddot and self._reddot.show then
		Rouge2_OutsideController.instance:addShowRedDot(Rouge2_OutsideEnum.LocalData.Store, self.config.id)
	end
end

function Rouge2_StoreStageItem:refreshUI()
	local openTime = TimeUtil.stringToTimestamp(self.config.startTime)
	local endTime = TimeUtil.stringToTimestamp(self.config.endTime)
	local nowTime = ServerTime.now()
	local isStart = openTime <= nowTime
	local isOpen = isStart and nowTime < endTime

	gohelper.setActive(self._goLocked, not isOpen)
	gohelper.setActive(self._imageTimeNormal, not isStart)
	gohelper.setActive(self._imageTimeSelect, not isStart)

	local isClaimAll = Rouge2_StoreModel.instance:isStoreAllClaimed(self.config.id)

	gohelper.setActive(self._goNormalClaimed, isClaimAll)
	gohelper.setActive(self._goSelectClaimed, isClaimAll)

	self._reddot = RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.V3a2_Rouge_Store_Tab, self.config.id)

	if isStart then
		self._txtNormalTitle.text = self.config.shopTitle
		self._txtSelectTitle.text = self.config.shopTitle
	else
		local duration = math.max(0, openTime - nowTime)
		local time, format = TimeUtil.secondToRoughTime2(duration, true)
		local timeStr = time .. format

		self._txtNormalTitle.text = timeStr
		self._txtSelectTitle.text = timeStr
	end

	self.isOpen = isOpen
end

function Rouge2_StoreStageItem:onDestroy()
	return
end

return Rouge2_StoreStageItem
