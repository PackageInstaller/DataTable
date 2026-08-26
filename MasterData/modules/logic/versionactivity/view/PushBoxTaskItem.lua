-- chunkname: @modules/logic/versionactivity/view/PushBoxTaskItem.lua

module("modules.logic.versionactivity.view.PushBoxTaskItem", package.seeall)

local PushBoxTaskItem = class("PushBoxTaskItem", BaseView)

function PushBoxTaskItem:onInitView()
	self.txt_desc = gohelper.findChildTextMesh(self.viewGO, "txt_desc")
	self.txt_curcount = gohelper.findChildText(self.viewGO, "txt_curcount")
	self.txt_totalcount = gohelper.findChildText(self.viewGO, "txt_totalcount")
	self.btn_receive = gohelper.findChildButtonWithAudio(self.viewGO, "btn_receive")
	self.btn_jump = gohelper.findChildButtonWithAudio(self.viewGO, "btn_jump")
	self.go_rewards = gohelper.findChild(self.viewGO, "go_rewards")
	self.go_finish = gohelper.findChild(self.viewGO, "go_finish")
	self.simage_bg = gohelper.findChildSingleImage(self.viewGO, "simage_bg")
	self._go_blackmask = gohelper.findChild(self.viewGO, "go_blackmask")
	self._ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PushBoxTaskItem:addEvents()
	self.btn_jump:AddClickListener(self._onBtnJump, self)
	self.btn_receive:AddClickListener(self._onBtnReceive, self)
end

function PushBoxTaskItem:removeEvents()
	self.btn_jump:RemoveClickListener()
	self.btn_receive:RemoveClickListener()
end

function PushBoxTaskItem:_editableInitView()
	self.simage_bg.curImageUrl = nil

	self.simage_bg:LoadImage(ResUrl.getVersionActivityIcon("pushbox/ing_rwdi"))
end

function PushBoxTaskItem:onOpen()
	return
end

function PushBoxTaskItem:playOpenAni(index)
	self._ani:Play(UIAnimationName.Open, 0, 0)
end

function PushBoxTaskItem:_refreshData(mo)
	self._ani:Play(UIAnimationName.Idle, 0, 0)

	self._task_data = PushBoxModel.instance:getTaskData(mo.id)
	self._config = mo.config
	self.txt_desc.text = self._config.desc
	self.txt_curcount.text = self._task_data.progress
	self.txt_totalcount.text = self._config.maxProgress

	local item_list = ItemModel.instance:getItemDataListByConfigStr(self._config.bonus)

	self.item_list = item_list

	IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self.go_rewards)
	gohelper.setActive(self.btn_receive.gameObject, not self._task_data.hasGetBonus and self._task_data.progress >= self._config.maxProgress)
	gohelper.setActive(self.go_finish, self._task_data.hasGetBonus)
	gohelper.setActive(self.btn_jump.gameObject, not self._task_data.hasGetBonus and self._task_data.progress < self._config.maxProgress)
	gohelper.setActive(self._go_blackmask, self._task_data.hasGetBonus)
end

function PushBoxTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function PushBoxTaskItem:_onBtnReceive()
	if self._task_data.progress < self._config.maxProgress then
		return
	end

	UIBlockMgr.instance:startBlock("PushBoxTaskItemReward")
	gohelper.setActive(self._go_blackmask, true)
	self._ani:Play("finish", 0, 0)
	TaskDispatcher.runDelay(self._taskRewardRequest, self, 0.6)
end

function PushBoxTaskItem:_taskRewardRequest()
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	PushBoxRpc.instance:sendReceiveTaskRewardRequest(nil, self._config.taskId)
end

function PushBoxTaskItem:_onBtnJump()
	local id = tonumber(string.split(self._config.listenerParam, "#")[1])

	if not PushBoxModel.instance:getPassData(id) then
		GameFacade.showToast(ToastEnum.WarmUpGotoOrder)

		return
	end

	ViewMgr.instance:closeView(ViewName.VersionActivityPushBoxTaskView)
end

function PushBoxTaskItem:onClose()
	UIBlockMgr.instance:endBlock("PushBoxTaskItemReward")
	TaskDispatcher.cancelTask(self._showAni, self)
	TaskDispatcher.cancelTask(self._taskRewardRequest, self)
end

function PushBoxTaskItem:onDestroyView()
	self.simage_bg:UnLoadImage()
end

return PushBoxTaskItem
