-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186SignView.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186SignView", package.seeall)

local Activity186SignView = class("Activity186SignView", BaseView)

function Activity186SignView:onInitView()
	self.signList = {}
	self.signContent = gohelper.findChild(self.viewGO, "root/signList/Content")
	self.btnTaskCanget = gohelper.findChildButtonWithAudio(self.viewGO, "root/avgTask/#go_reward/go_canget")
	self.goTaskReceive = gohelper.findChild(self.viewGO, "root/avgTask/#go_reward/go_receive")
	self.goTaskReward = gohelper.findChild(self.viewGO, "root/avgTask/#go_reward/go_icon")
	self.txtTaskDesc = gohelper.findChildTextMesh(self.viewGO, "root/avgTask/txtDesc")
	self.hasgetHookAnim = gohelper.findChildComponent(self.viewGO, "root/avgTask/#go_reward/go_receive/go_hasget", gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186SignView:addEvents()
	self.addClickCb(self, self.btnTaskCanget, self.onClickBtnTaskCanget, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.onRefreshNorSignActivity, self)
	self.addEventCb(self, Activity186Controller.instance, Activity186Event.SpBonusStageChange, self.onSpBonusStageChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function Activity186SignView:removeEvents()
	return
end

function Activity186SignView:_editableInitView()
	return
end

function Activity186SignView:onCloseView(viewName)
	if viewName == ViewName.CommonPropView then
		if self._waitRefreshList then
			self:refreshSignList()
		end

		if self._waitRefreshTask then
			self:refreshTask()
		end
	end
end

function Activity186SignView:onRefreshNorSignActivity()
	self._waitRefreshList = true
end

function Activity186SignView:onSpBonusStageChange()
	self._waitRefreshTask = true
end

function Activity186SignView:onClickBtnTaskCanget()
	Activity101Rpc.instance:sendAcceptAct186SpBonusRequest(self.signActId, self.actId)
end

function Activity186SignView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function Activity186SignView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function Activity186SignView:refreshParam()
	self.actId = self.viewParam.actId
	self.signActId = ActivityEnum.Activity.V2a5_Act186Sign
	self.actMo = Activity186Model.instance:getById(self.actId)
end

function Activity186SignView:refreshView()
	self:refreshSignList()
	self:refreshTask()
end

function Activity186SignView:refreshSignList()
	self._waitRefresh = false

	local actCos = ActivityConfig.instance:getNorSignActivityCos(self.signActId)

	for i = 1, math.max(#actCos, #self.signList) do
		local signItem = self:getOrCreateItem(i)

		signItem:onUpdateMO(actCos[i])
	end
end

function Activity186SignView:getOrCreateItem(index)
	local signItem = self.signList[index]

	if not signItem then
		local resPath = self.viewContainer:getSetting().otherRes.itemRes
		local go = self.viewContainer:getResInst(resPath, self.signContent, string.format("item%s", index))

		signItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity186SignItem)

		signItem:initActId(self.actId)

		self.signList[index] = signItem
	end

	return signItem
end

function Activity186SignView:refreshTask()
	self._waitRefreshTask = false

	local stage = self.actMo.spBonusStage

	if self.spBonusStage then
		local stageChange = stage ~= self.spBonusStage
		local hasFinishTask = stage ~= 0

		self.txtTaskDesc.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("act186_signview_task_txt"), hasFinishTask and 1 or 0)

		gohelper.setActive(self.goTaskReceive, stage == 2)
		gohelper.setActive(self.btnTaskCanget, stage == 1)

		if stage == 2 then
			if stageChange then
				self.hasgetHookAnim:Play("go_hasget_in")
			else
				self.hasgetHookAnim:Play("go_hasget_idle")
			end
		end

		self.spBonusStage = stage

		local rewardStr = Activity186Config.instance:getConstStr(self.actId, Activity186Enum.ConstId.Act101Reward)
		local rewards = GameUtil.splitString2(rewardStr, true)
		local itemCo = rewards[1]

		self.itemIcon = self.itemIcon or IconMgr.instance:getCommonPropItemIcon(self.goTaskReward)

		self.itemIcon:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self.itemIcon:setScale(0.7)
		self.itemIcon:setCountFontSize(46)
		self.itemIcon:setHideLvAndBreakFlag(true)
		self.itemIcon:hideEquipLvAndBreak(true)
	end
end

function Activity186SignView:onClose()
	return
end

function Activity186SignView:onDestroyView()
	return
end

return Activity186SignView
