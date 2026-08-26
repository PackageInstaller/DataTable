-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5ExploreTaskTipView.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5ExploreTaskTipView", package.seeall)

local VersionActivity1_5ExploreTaskTipView = class("VersionActivity1_5ExploreTaskTipView", BaseView)

function VersionActivity1_5ExploreTaskTipView:onInitView()
	self._goTipContainer = gohelper.findChild(self.viewGO, "#go_exploretipcontainer")
	self._goclosetip = gohelper.findChild(self.viewGO, "#go_exploretipcontainer/#go_closetip")
	self._gotips = gohelper.findChild(self.viewGO, "#go_exploretipcontainer/#go_exploretip")
	self._txtTipTitle = gohelper.findChildText(self._gotips, "#txt_title")
	self._txtTipTitleEn = gohelper.findChildText(self._gotips, "#txt_title/#txt_en")
	self._txtTipDesc = gohelper.findChildText(self._gotips, "#txt_dec")
	self._goTipFinish = gohelper.findChild(self._gotips, "layout/#go_finish")
	self._goTipGoTo = gohelper.findChild(self._gotips, "layout/#go_goto")
	self._txtTipStatus = gohelper.findChildText(self._gotips, "layout/#go_goto/#txt_status")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5ExploreTaskTipView:addEvents()
	return
end

function VersionActivity1_5ExploreTaskTipView:removeEvents()
	return
end

function VersionActivity1_5ExploreTaskTipView:_editableInitView()
	gohelper.setActive(self._goTipContainer, false)

	self.goTipRectTr = self._gotips:GetComponent(typeof(UnityEngine.RectTransform))
	self.goTipContainerTr = self._goTipContainer:GetComponent(typeof(UnityEngine.RectTransform))
	self.halfViewWidth = recthelper.getWidth(self.goTipContainerTr) / 2
	self.halfTipWidth = recthelper.getWidth(self.goTipRectTr) / 2
	self.goToClick = gohelper.getClickWithDefaultAudio(self._goTipGoTo)

	self.goToClick:AddClickListener(self.onClickGoToBtn, self)

	self.closeClick = gohelper.getClickWithDefaultAudio(self._goclosetip)

	self.closeClick:AddClickListener(self.onHideTipContainer, self)
end

function VersionActivity1_5ExploreTaskTipView:onHideTipContainer()
	gohelper.setActive(self._goTipContainer, false)
	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.HideExploreTip, self.taskItem)

	self.taskItem = nil
	self.config = nil
end

function VersionActivity1_5ExploreTaskTipView:onClickGoToBtn()
	if self.isGainedReward then
		return
	end

	for _, elementId in ipairs(self.config.elementList) do
		if not DungeonMapModel.instance:elementIsFinished(elementId) then
			if not DungeonMapModel.instance:getElementById(elementId) then
				logError("element not exist or not unlock, element id : " .. elementId)

				return
			end

			self:closeThis()
			VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.FocusElement, elementId)

			return
		end
	end
end

function VersionActivity1_5ExploreTaskTipView:showTip(taskItem, pos)
	gohelper.setActive(self._goTipContainer, true)

	self.taskItem = taskItem
	self.config = taskItem.taskCo

	self:setPos(pos)
	self:refreshUI()
end

function VersionActivity1_5ExploreTaskTipView:setPos(pos)
	local showLeft = pos.x >= self.halfViewWidth
	local anchor = recthelper.screenPosToAnchorPos(pos, self.goTipContainerTr)
	local anchorX, anchorY = anchor.x, anchor.y
	local offsetX = VersionActivity1_5DungeonEnum.ExploreTipOffsetX

	anchorX = showLeft and anchorX - self.halfTipWidth - offsetX or anchorX + self.halfTipWidth + offsetX
	anchorY = math.max(anchorY, VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Min)
	anchorY = math.min(anchorY, VersionActivity1_5DungeonEnum.ExploreTipAnchorY.Max)

	recthelper.setAnchor(self.goTipRectTr, anchorX, anchorY)
end

function VersionActivity1_5ExploreTaskTipView:refreshUI()
	self._txtTipTitle.text = self.config.title
	self._txtTipTitleEn.text = self.config.titleEn
	self._txtTipDesc.text = self.config.desc
	self.status = VersionActivity1_5RevivalTaskModel.instance:getExploreTaskStatus(self.config)
	self.isGainedReward = self.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.GainedReward

	gohelper.setActive(self._goTipFinish, self.isGainedReward)
	gohelper.setActive(self._goTipGoTo, not self.isGainedReward)

	if not self.isGainedReward then
		self._txtTipStatus.text = self.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Finished and luaLang("p_v1a5_dispatch_finish") or self.status == VersionActivity1_5DungeonEnum.ExploreTaskStatus.Running and luaLang("p_v1a5_dispatch_ing") or ""
	end
end

function VersionActivity1_5ExploreTaskTipView:onDestroyView()
	self.goToClick:RemoveClickListener()
	self.closeClick:RemoveClickListener()
end

return VersionActivity1_5ExploreTaskTipView
