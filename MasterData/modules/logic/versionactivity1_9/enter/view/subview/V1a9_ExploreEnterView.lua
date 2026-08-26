-- chunkname: @modules/logic/versionactivity1_9/enter/view/subview/V1a9_ExploreEnterView.lua

module("modules.logic.versionactivity1_9.enter.view.subview.V1a9_ExploreEnterView", package.seeall)

local V1a9_ExploreEnterView = class("V1a9_ExploreEnterView", BaseView)

function V1a9_ExploreEnterView:onInitView()
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Right/txt_Des")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a9_ExploreEnterView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
end

function V1a9_ExploreEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
end

function V1a9_ExploreEnterView:_btnEnterOnClick()
	if ExploreSimpleModel.instance:getMapIsUnLock(201) then
		ExploreSimpleModel.instance:setLastSelectMap(1403, 140301)
	end

	if JumpController.instance:jump(440001) then
		ExploreModel.instance.isJumpToExplore = true
	end
end

function V1a9_ExploreEnterView:_editableInitView()
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
	self.config = ActivityConfig.instance:getActivityCo(VersionActivity1_9Enum.ActivityId.Explore3)

	if self.config then
		if not self.config.activityBonus then
			local rewardShow = ""
			local datas = GameUtil.splitString2(rewardShow, true) or {}

			self._items = {}

			for index, arr in ipairs(datas) do
				local go = gohelper.create2d(self._gorewards, "item" .. index)

				recthelper.setSize(go.transform, 250, 250)

				self._items[index] = IconMgr.instance:getCommonPropItemIcon(go)

				self._items[index]:setMOValue(arr[1], arr[2], 1)
				self._items[index]:isShowEquipAndItemCount(false)
			end

			self._txtDescr.text = self.config.actDesc
		end
	end
end

function V1a9_ExploreEnterView:onOpen()
	self.animComp:playOpenAnim()
end

function V1a9_ExploreEnterView:onDestroyView()
	self.animComp:destroy()
end

return V1a9_ExploreEnterView
