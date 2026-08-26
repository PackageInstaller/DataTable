-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessTaskItem.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessTaskItem", package.seeall)

local Activity1_3ChessTaskItem = class("Activity1_3ChessTaskItem", ListScrollCellExtend)

function Activity1_3ChessTaskItem:onInitView()
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._simagenormalbg = gohelper.findChildSingleImage(self.viewGO, "#go_normal/#simage_normalbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num")
	self._txttotal = gohelper.findChildText(self.viewGO, "#go_normal/progress/#txt_num/#txt_total")
	self._txttaskdes = gohelper.findChildText(self.viewGO, "#go_normal/#txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards/Viewport/Content")
	self.scrollReward = gohelper.findChild(self.viewGO, "#go_normal/#scroll_rewards"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_notfinishbg")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "#go_normal/#btn_finishbg")
	self._goallfinish = gohelper.findChild(self.viewGO, "#go_normal/#go_allfinish")
	self._gogetall = gohelper.findChild(self.viewGO, "#go_getall")
	self._simagegetallbg = gohelper.findChildSingleImage(self.viewGO, "#go_getall/#simage_getallbg")
	self._btngetall = gohelper.findChildButtonWithAudio(self.viewGO, "#go_getall/#btn_getall")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessTaskItem:addEvents()
	Activity1_3ChessController.instance:registerCallback(Activity1_3ChessEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btngetall:AddClickListener(self._btngetallOnClick, self)
end

function Activity1_3ChessTaskItem:removeEvents()
	Activity1_3ChessController.instance:unregisterCallback(Activity1_3ChessEvent.OneClickClaimReward, self._onOneClickClaimReward, self)
	self._btnnotfinishbg:RemoveClickListener()
	self._btnfinishbg:RemoveClickListener()
	self._btngetall:RemoveClickListener()
end

function Activity1_3ChessTaskItem:_btnnotfinishbgOnClick()
	if not self._taskMO then
		return
	end

	local episodeId = self._taskMO.config.episodeId

	if Activity1_3ChessController.instance:isEpisodeOpen(episodeId) then
		Activity1_3ChessController.instance:dispatchEvent(Activity1_3ChessEvent.ClickEpisode, episodeId)
	else
		Activity1_3ChessController.instance:showToastByEpsodeId(episodeId)
	end
end

function Activity1_3ChessTaskItem:_btnfinishbgOnClick()
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, self._taskMO)
	self:_onOneClickClaimReward()
end

function Activity1_3ChessTaskItem:_btngetallOnClick()
	Activity1_3ChessController.instance:delayRequestGetReward(0.2, self._taskMO)
	Activity1_3ChessController.instance:dispatchAllTaskItemGotReward()
end

function Activity1_3ChessTaskItem:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function Activity1_3ChessTaskItem:_onOneClickClaimReward()
	if self._taskMO:haveRewardToGet() then
		self._playFinishAnin = true

		self._animator:Play("finish", 0, 0)
	end
end

function Activity1_3ChessTaskItem:getAnimator()
	return self._animator
end

function Activity1_3ChessTaskItem:onUpdateMO(mo)
	self._taskMO = mo
	self.scrollReward.parentGameObject = self._view._csListScroll.gameObject

	self:_refreshUI()
end

function Activity1_3ChessTaskItem:onSelect(isSelect)
	return
end

local TaskMOAllFinishId = -100

function Activity1_3ChessTaskItem:_refreshUI()
	local taskMO = self._taskMO

	if not taskMO then
		return
	end

	local isNormal = taskMO.id ~= TaskMOAllFinishId

	gohelper.setActive(self._gogetall, not isNormal)
	gohelper.setActive(self._gonormal, isNormal)

	if isNormal then
		if self._playFinishAnin then
			self._playFinishAnin = false

			self._animator:Play("idle", 0, 1)
		end

		gohelper.setActive(self._goallfinish, false)
		gohelper.setActive(self._btnnotfinishbg, false)
		gohelper.setActive(self._btnfinishbg, false)

		if taskMO:isFinished() then
			gohelper.setActive(self._btnfinishbg, true)
		elseif taskMO:alreadyGotReward() then
			gohelper.setActive(self._goallfinish, true)
		else
			gohelper.setActive(self._btnnotfinishbg, true)
		end

		if taskMO.config then
			if not taskMO.config.offestProgress then
				local offestPro = 0

				self._txtnum.text = math.max(taskMO:getProgress() + offestPro, 0)
				self._txttotal.text = math.max(taskMO:getMaxProgress() + offestPro, 0)

				if taskMO.config then
					self._txttaskdes.text = taskMO.config.desc or ""
				end

				local item_list = ItemModel.instance:getItemDataListByConfigStr(taskMO.config.bonus)

				self.item_list = item_list

				IconMgr.instance:getCommonPropItemIconList(self, self._onItemShow, item_list, self._gorewards)
			end
		end
	end
end

function Activity1_3ChessTaskItem:_onItemShow(cell_component, data, index)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)
end

function Activity1_3ChessTaskItem:onDestroyView()
	return
end

Activity1_3ChessTaskItem.prefabPath = "ui/viewres/versionactivity_1_3/v1a3_role2/v1a3_role2_taskitem.prefab"

return Activity1_3ChessTaskItem
