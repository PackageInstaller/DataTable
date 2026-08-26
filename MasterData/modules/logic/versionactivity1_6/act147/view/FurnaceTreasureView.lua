-- chunkname: @modules/logic/versionactivity1_6/act147/view/FurnaceTreasureView.lua

module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureView", package.seeall)

local FurnaceTreasureView = class("FurnaceTreasureView", BaseView)

function FurnaceTreasureView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "#go_spine")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Right/LimitTimeBg/#txt_LimitTime")
	self._goDecContent = gohelper.findChild(self.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content")
	self._txtDecItem = gohelper.findChildText(self.viewGO, "Right/DecBg/scroll_Dec/Viewport/Content/#txt_DecItem")
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_goto")
	self._goarrow = gohelper.findChild(self.viewGO, "Right/arrow")
	self._txtlimitbuy = gohelper.findChildText(self.viewGO, "LimitTips/bg/#txt_limitbuy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FurnaceTreasureView:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self.addEventCb(self, FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, self.refreshBuyCount, self)
end

function FurnaceTreasureView:removeEvents()
	self._btngoto:RemoveClickListener()
	self.removeEventCb(self, FurnaceTreasureController.instance, FurnaceTreasureEvent.onFurnaceTreasureGoodsUpdate, self.refreshBuyCount, self)
end

function FurnaceTreasureView:_btngotoOnClick()
	local jumpId = FurnaceTreasureConfig.instance:getJumpId(self.actId)

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function FurnaceTreasureView:_editableInitView()
	self.actId = nil
	self._uiSpine = GuiSpine.Create(self._gospine, false)

	if self._uiSpine then
		self._uiSpine:useRT()
		self._uiSpine:setImgPos(0, 0)
		self._uiSpine:setImgParent(self._gospine.transform)
	end
end

function FurnaceTreasureView:onOpen()
	if self.viewParam then
		local parentGO = self.viewParam.parent

		gohelper.addChild(parentGO, self.viewGO)

		self.actId = self.viewParam.actId
	end

	self:setDescList()
	self:setRewardList()
	self:refreshBuyCount()
	self:refreshLimitTime()
	TaskDispatcher.cancelTask(self.refreshLimitTime, self)
	TaskDispatcher.runRepeat(self.refreshLimitTime, self, TimeUtil.OneMinuteSecond)

	local spineRes = FurnaceTreasureConfig.instance:getSpineRes(self.actId)

	if not self._uiSpine or string.nilorempty(spineRes) then
		return
	end

	self._uiSpine:setResPath(spineRes, self._onSpineLoaded, self)
end

function FurnaceTreasureView:setDescList()
	local descList = FurnaceTreasureConfig.instance:getDescList(self.actId)

	gohelper.CreateObjList(self, self.onSetSingleDesc, descList, self._goDecContent, self._txtDecItem.gameObject)
end

function FurnaceTreasureView:onSetSingleDesc(go, data, index)
	if gohelper.isNil(go) then
		return
	end

	local txtDesc = go:GetComponent(gohelper.Type_TextMesh)

	if txtDesc then
		txtDesc.text = data
	end
end

function FurnaceTreasureView:setRewardList()
	local rewardList = FurnaceTreasureConfig.instance:getRewardList(self.actId)

	IconMgr.instance:getCommonPropItemIconList(self, self.onSetSingleReward, rewardList, self._gorewards)
end

function FurnaceTreasureView:onSetSingleReward(cell_component, data, index)
	data.quantity = data.quantity or 0

	cell_component:onUpdateMO(data)
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:isShowCount(false)
end

function FurnaceTreasureView:_onSpineLoaded()
	if not self._uiSpine then
		return
	end

	self._uiSpine:setImageUIMask(true)

	local co = FurnaceTreasureModel.instance:getSpinePlayData()

	self._uiSpine:playVoice(co)
end

function FurnaceTreasureView:refreshBuyCount()
	local count = FurnaceTreasureModel.instance:getTotalRemainCount(self.actId)

	self._txtlimitbuy.text = formatLuaLang("remain_buy_count", count)
end

function FurnaceTreasureView:refreshLimitTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local timeStr = formatLuaLang("cachotprogressview_remainDay", 0)

	self._txtLimitTime.text = string.format(luaLang("remain"), (actInfoMo or nil) and actInfoMo:getRemainTimeStr3(false, true))
end

function FurnaceTreasureView:onClose()
	TaskDispatcher.cancelTask(self.refreshLimitTime, self)
end

function FurnaceTreasureView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:doClear()
	end

	self._uiSpine = false
end

return FurnaceTreasureView
