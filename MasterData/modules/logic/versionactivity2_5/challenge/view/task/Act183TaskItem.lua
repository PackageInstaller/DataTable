-- chunkname: @modules/logic/versionactivity2_5/challenge/view/task/Act183TaskItem.lua

module("modules.logic.versionactivity2_5.challenge.view.task.Act183TaskItem", package.seeall)

local Act183TaskItem = class("Act183TaskItem", Act183TaskBaseItem)

function Act183TaskItem:init(go)
	Act183TaskItem.super.init(self, go)

	self._txtdesc = gohelper.findChildText(self.go, "txt_desc")
	self._imagepoint = gohelper.findChildImage(self.go, "image_point")
	self._btncanget = gohelper.findChildButtonWithAudio(self.go, "btn_canget")
	self._gohasget = gohelper.findChild(self.go, "go_hasget")
	self._btnjump = gohelper.findChildButtonWithAudio(self.go, "btn_jump")
	self._goscrollcontent = gohelper.findChild(self.go, "scroll_reward/Viewport/Content")
	self._gorewarditem = gohelper.findChild(self.go, "scroll_reward/Viewport/Content/go_rewarditem")
end

function Act183TaskItem:addEventListeners()
	Act183TaskItem.super.addEventListeners(self)
	self._btncanget:AddClickListener(self._btncangetOnClick, self)
	self._btnjump:AddClickListener(self._btnjumpOnClick, self)
	self.addEventCb(self, Act183Controller.instance, Act183Event.ClickToGetReward, self._onReceiveGetRewardInfo, self)
end

function Act183TaskItem:removeEventListeners()
	Act183TaskItem.super.removeEventListeners(self)
	self._btncanget:RemoveClickListener()
	self._btnjump:RemoveClickListener()
end

function Act183TaskItem:_btncangetOnClick()
	if not self._canGet then
		return
	end

	self:setBlock(true)
	self._animatorPlayer:Play("finish", self._sendRpcToFinishTask, self)
end

function Act183TaskItem:_sendRpcToFinishTask()
	local taskId = self._taskId

	TaskRpc.instance:sendFinishTaskRequest(self._taskId, function(__, resultCode)
		if resultCode ~= 0 then
			return
		end

		Act183Helper.showToastWhileGetTaskRewards({
			taskId
		})
	end)
	self:setBlock(false)
end

function Act183TaskItem:_btnjumpOnClick()
	GameFacade.jump(self._config.jumpId)
end

function Act183TaskItem:onUpdateMO(mo, mixType, param)
	Act183TaskItem.super.onUpdateMO(self, mo, mixType, param)

	self._taskMo = mo.data
	self._config = mo.data and mo.data.config
	self._taskId = mo.data and mo.data.id
	self._canGet = Act183Helper.isTaskCanGetReward(self._taskId)
	self._hasGet = Act183Helper.isTaskHasGetReward(self._taskId)

	self:refresh()
end

function Act183TaskItem:refresh()
	self._txtdesc.text = self._config.desc

	gohelper.setActive(self._btncanget.gameObject, self._canGet)
	gohelper.setActive(self._btnjump.gameObject, not self._canGet and not self._hasGet)
	gohelper.setActive(self._gohasget, self._hasGet)

	if not string.nilorempty(self._config.bonus) then
		local list = DungeonConfig.instance:getRewardItems(tonumber(self._config.bonus))
		local item_list = {}
		local badgeItemCo = self:_generateBadgeItemConfig()

		table.insert(item_list, badgeItemCo)

		for _, v in ipairs(list) do
			table.insert(item_list, {
				isIcon = true,
				materilType = v[1],
				materilId = v[2],
				quantity = v[3]
			})
		end

		IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._goscrollcontent)
	else
		logError(string.format("任务缺少奖励配置 taskId = %s", self._config.id))
	end
end

function Act183TaskItem:_generateBadgeItemConfig()
	if self._config.badgeNum > 0 then
		local materilType, materilId = Act183Helper.getBadgeItemConfig()

		if materilType and materilId then
			self._badgeMaterilType = materilType
			self._badgeMaterilId = materilId

			return {
				isIcon = true,
				materilType = materilType,
				materilId = materilId,
				quantity = self._config.badgeNum
			}
		end
	end
end

function Act183TaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:isShowQuality(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
	cell_component:customOnClickCallback(function()
		if data.materilType == self._badgeMaterilType and data.materilId == self._badgeMaterilId then
			return
		end

		MaterialTipController.instance:showMaterialInfo(tonumber(data.materilType), data.materilId)
	end)
end

function Act183TaskItem:_onReceiveGetRewardInfo(taskId)
	if self._taskId ~= taskId or not self.go.activeInHierarchy then
		return
	end

	self._animatorPlayer:Play("finish", function()
		return
	end, self)
end

return Act183TaskItem
