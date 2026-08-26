-- chunkname: @modules/logic/versionactivity1_4/dungeon/view/VersionActivity1_4DungeonView.lua

module("modules.logic.versionactivity1_4.dungeon.view.VersionActivity1_4DungeonView", package.seeall)

local VersionActivity1_4DungeonView = class("VersionActivity1_4DungeonView", BaseView)

function VersionActivity1_4DungeonView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._gopath = gohelper.findChild(self.viewGO, "root/#go_path")
	self._gostages = gohelper.findChild(self.viewGO, "root/#go_path/#go_stages")
	self._gotitle = gohelper.findChild(self.viewGO, "root/#go_title")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/#go_title/#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "root/#go_title/#go_time")
	self._txtlimittime = gohelper.findChildText(self.viewGO, "root/#go_title/#go_time/#txt_limittime")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_task")
	self._txttasknum = gohelper.findChildTextMesh(self.viewGO, "root/#btn_task/#txt_TaskNum")
	self._goreddotreward = gohelper.findChild(self.viewGO, "root/#btn_task/#go_reddotreward")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._stageItemList = {}
	self._animPath = gohelper.findChildComponent(self.viewGO, "root/#go_path", typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_4DungeonView:addEvents()
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, self.onSelect, self)
end

function VersionActivity1_4DungeonView:removeEvents()
	self._btntask:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, VersionActivity1_4DungeonController.instance, VersionActivity1_4DungeonEvent.OnSelectEpisodeId, self.onSelect, self)
end

function VersionActivity1_4DungeonView:_btntaskOnClick()
	ViewMgr.instance:openView(ViewName.Activity129View, {
		actId = VersionActivity1_4Enum.ActivityId.DungeonStore
	})
end

function VersionActivity1_4DungeonView:_editableInitView()
	self._simagebg:LoadImage("singlebg/v1a4_role37_singlebg/v1a4_dungeon_fullbg.png")
end

function VersionActivity1_4DungeonView:onSelect()
	local episodeId = VersionActivity1_4DungeonModel.instance:getSelectEpisodeId()

	if episodeId then
		gohelper.setActive(self._goroot, false)
		gohelper.setActive(self._gobtns, false)
	else
		gohelper.setActive(self._goroot, true)
		gohelper.setActive(self._gobtns, true)
		self:refreshStages()
	end
end

function VersionActivity1_4DungeonView:onUpdateParam()
	ViewMgr.instance:closeView(ViewName.VersionActivity1_4DungeonEpisodeView)
end

function VersionActivity1_4DungeonView:_onCurrencyChange(changeIds)
	local currencyId = Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)

	if not changeIds[currencyId] then
		return
	end

	local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

	self._txttasknum.text = tostring(quantity)
end

function VersionActivity1_4DungeonView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_qiutu_revelation_open)

	self.actId = self.viewParam.actId

	ActivityEnterMgr.instance:enterActivity(self.actId)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		self.actId
	})
	self:refreshStages()
	TaskDispatcher.runRepeat(self._showLeftTime, self, 60)
	self:_showLeftTime()

	local currencyId = Activity129Config.instance:getConstValue1(VersionActivity1_4Enum.ActivityId.DungeonStore, Activity129Enum.ConstEnum.CostId)
	local quantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, currencyId)

	self._txttasknum.text = tostring(quantity)
end

function VersionActivity1_4DungeonView:refreshStages()
	local prefabPath = self.viewContainer:getSetting().otherRes[1]
	local unlockIndex, openIndex
	local list = DungeonConfig.instance:getChapterEpisodeCOList(14101)

	for i = 1, math.max(#self._stageItemList, #list) do
		local item = self._stageItemList[i]

		if not item then
			local stageGo = gohelper.findChild(self._gostages, "stage" .. i)
			local cloneGo = self:getResInst(prefabPath, stageGo)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(cloneGo, VersionActivity1_4DungeonItem, self, i)
			self._stageItemList[i] = item
		end

		local isUnlock, isOpen = item:refreshItem(list[i], i)

		if isOpen then
			openIndex = i
		end

		if isUnlock then
			unlockIndex = i
		end
	end

	TaskDispatcher.cancelTask(self.playAnim, self)

	if unlockIndex then
		self.animName = "go_0" .. tostring(unlockIndex - 1)

		TaskDispatcher.runDelay(self.playAnim, self, 1)
	else
		openIndex = openIndex or 1
		self.animName = "idle_0" .. tostring(openIndex - 1)

		self:playAnim()
	end
end

function VersionActivity1_4DungeonView:playAnim()
	self._animPath:Play(self.animName)
end

function VersionActivity1_4DungeonView:_showLeftTime()
	local actMO = ActivityModel.instance:getActMO(self.actId)

	if not actMO then
		return
	end

	self._txtlimittime.text = string.format(luaLang("activity_warmup_remain_time"), actMO:getRemainTimeStr2ByEndTime())
end

function VersionActivity1_4DungeonView:onClose()
	TaskDispatcher.cancelTask(self._showLeftTime, self)
	TaskDispatcher.cancelTask(self.playAnim, self)
end

function VersionActivity1_4DungeonView:onDestroyView()
	self._simagebg:UnLoadImage()
end

return VersionActivity1_4DungeonView
