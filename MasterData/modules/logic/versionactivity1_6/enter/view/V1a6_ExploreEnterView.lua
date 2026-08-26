-- chunkname: @modules/logic/versionactivity1_6/enter/view/V1a6_ExploreEnterView.lua

module("modules.logic.versionactivity1_6.enter.view.V1a6_ExploreEnterView", package.seeall)

local V1a6_ExploreEnterView = class("V1a6_ExploreEnterView", VersionActivityEnterBaseSubView)

function V1a6_ExploreEnterView:onInitView()
	self._gorewards = gohelper.findChild(self.viewGO, "Right/scroll_Reward/Viewport/#go_rewards")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Enter")
	self._btnLocked = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Locked")
	self._txtLockTxt = gohelper.findChildTextMesh(self.viewGO, "Right/#btn_Locked/#txt_UnLocked")
	self._txtDescr = gohelper.findChildTextMesh(self.viewGO, "Right/txt_Des")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_ExploreEnterView:addEvents()
	self._btnEnter:AddClickListener(self._onEnterClick, self)
	self._btnLocked:AddClickListener(self._onEnterClick, self)
end

function V1a6_ExploreEnterView:removeEvents()
	self._btnEnter:RemoveClickListener()
	self._btnLocked:RemoveClickListener()
end

function V1a6_ExploreEnterView:onOpen()
	V1a6_ExploreEnterView.super.onOpen(self)

	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Explore)

	gohelper.setActive(self._btnEnter, isOpen)
	gohelper.setActive(self._btnLocked, not isOpen)

	if not isOpen then
		local actCo = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore)
		local openId = actCo.openId
		local episodeId = OpenConfig.instance:getOpenCo(openId).episodeId
		local episodetxt = DungeonConfig.instance:getEpisodeDisplay(episodeId)

		self._txtLockTxt.text = string.format(luaLang("dungeon_unlock_episode_mode_sp"), episodetxt)
	end
end

function V1a6_ExploreEnterView:onClose()
	V1a6_ExploreEnterView.super.onClose(self)
end

function V1a6_ExploreEnterView:_editableInitView()
	self.config = ActivityConfig.instance:getActivityCo(VersionActivity1_6Enum.ActivityId.Explore)

	if self.config then
		if not self.config.activityBonus then
			local rewardShow = -1
			local datas = GameUtil.splitString2(rewardShow, true)

			self._items = {}

			for index, arr in ipairs(datas) do
				local go = gohelper.create2d(self._gorewards, "item" .. index)

				recthelper.setSize(go.transform, 200, 200)

				self._items[index] = IconMgr.instance:getCommonPropItemIcon(go)

				self._items[index]:setMOValue(arr[1], arr[2], 1)
				self._items[index]:isShowEquipAndItemCount(false)
			end

			self._txtDescr.text = self.config.actDesc
		end
	end
end

function V1a6_ExploreEnterView:_onEnterClick()
	if ExploreSimpleModel.instance:getMapIsUnLock(301) then
		ExploreSimpleModel.instance:setLastSelectMap(1402, 140201)
	end

	JumpController.instance:jump(440001)
end

return V1a6_ExploreEnterView
