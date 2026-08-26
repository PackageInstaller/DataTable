-- chunkname: @modules/logic/weekwalk/view/WeekWalkShallowSettlementView.lua

module("modules.logic.weekwalk.view.WeekWalkShallowSettlementView", package.seeall)

local WeekWalkShallowSettlementView = class("WeekWalkShallowSettlementView", BaseView)

function WeekWalkShallowSettlementView:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "#simage_mask")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg2")
	self._txtlayer = gohelper.findChildText(self.viewGO, "overview/#txt_layer")
	self._txtstarcount = gohelper.findChildText(self.viewGO, "overview/#txt_starcount")
	self._scrollrewards = gohelper.findChildScrollRect(self.viewGO, "rewards/#scroll_rewards")
	self._gorewarditem = gohelper.findChild(self.viewGO, "rewards/#scroll_rewards/Viewport/Content/#go_rewarditem")
	self._btnreceive = gohelper.findChildButtonWithAudio(self.viewGO, "rewards/#btn_receive")
	self._goempty = gohelper.findChild(self.viewGO, "rewards/#go_empty")
	self._gohasreceived = gohelper.findChild(self.viewGO, "rewards/#go_hasreceived")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkShallowSettlementView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreceive:AddClickListener(self._btnreceiveOnClick, self)
end

function WeekWalkShallowSettlementView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreceive:RemoveClickListener()
end

function WeekWalkShallowSettlementView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalkShallowSettlementView:_btnreceiveOnClick()
	TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.WeekWalk, 2)
end

function WeekWalkShallowSettlementView:_editableInitView()
	UIBlockMgrExtend.setNeedCircleMv(false)
	self._simagebg1:LoadImage(ResUrl.getWeekWalkBg("full/beijing_qian.jpg"))
	self._simagebg2:LoadImage(ResUrl.getWeekWalkBg("qianmian_tcdi.png"))
	self._simagemask:LoadImage(ResUrl.getWeekWalkBg("zhezhao.png"))

	self._info = WeekWalkModel.instance:getInfo()

	if self._info.isPopShallowSettle then
		self._info.isPopShallowSettle = false

		WeekwalkRpc.instance:sendMarkPopShallowSettleRequest()
	end

	self:_setLayerProgress()
	self:_setProgress()
end

function WeekWalkShallowSettlementView:_createItemList(list)
	if not self._itemList then
		self._itemList = self:getUserDataTb_()

		for i, reward in ipairs(list) do
			local go = gohelper.cloneInPlace(self._gorewarditem)

			gohelper.setActive(go, true)

			local item = IconMgr.instance:getCommonItemIcon(gohelper.findChild(go, "go_item"))

			item:setMOValue(reward[1], reward[2], reward[3])
			item:isShowCount(true)
			item:setCountFontSize(31)

			self._itemList[i] = go
		end
	end
end

function WeekWalkShallowSettlementView:_setProgress()
	local progress, maxProgress, list = DungeonWeekWalkView.getWeekTaskProgress()
	local tag = {
		progress,
		maxProgress
	}

	self._txtstarcount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_starcount"), tag)

	self:_createItemList(list)

	local hasReward = #list > 0

	gohelper.setActive(self._goempty, not hasReward)

	local getAllTask = self:_isGetAllTask()

	gohelper.setActive(self._gohasreceived, hasReward and getAllTask)
	gohelper.setActive(self._btnreceive, hasReward and not getAllTask)

	for i, go in ipairs(self._itemList) do
		local go_receive = gohelper.findChild(go, "go_receive")

		gohelper.setActive(go_receive, hasReward and getAllTask)
	end
end

function WeekWalkShallowSettlementView:_isGetAllTask()
	local list = WeekWalkTaskListModel.instance:getList()

	for i, v in ipairs(list) do
		local taskMo = WeekWalkTaskListModel.instance:getTaskMo(v.id)

		if taskMo and taskMo.finishCount <= 0 and taskMo.hasFinished then
			return false
		end
	end

	return true
end

function WeekWalkShallowSettlementView:_setLayerProgress()
	local layerConfig, mapInfo = self:_getLastShallowLayer()
	local sceneConfig = lua_weekwalk_scene.configDict[layerConfig.sceneId]
	local battleIndex = mapInfo and mapInfo:getNoStarBattleIndex()
	local tag = {
		sceneConfig.name,
		"0" .. (battleIndex or 1)
	}

	self._txtlayer.text = GameUtil.getSubPlaceholderLuaLang(luaLang("weekwalkshallowsettlementview_layer"), tag)
end

function WeekWalkShallowSettlementView:_getLastShallowLayer()
	local config, mapInfo

	for i, v in ipairs(lua_weekwalk.configList) do
		if WeekWalkModel.isShallowMap(v.id) then
			mapInfo = WeekWalkModel.instance:getMapInfo(v.id)
			config = v

			if not mapInfo or mapInfo.isFinished <= 0 then
				break
			end
		else
			break
		end
	end

	return config, mapInfo
end

function WeekWalkShallowSettlementView:_onWeekwalkTaskUpdate()
	self:_setProgress()
end

function WeekWalkShallowSettlementView:onUpdateParam()
	return
end

function WeekWalkShallowSettlementView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_open)
	self.addEventCb(self, WeekWalkController.instance, WeekWalkEvent.OnWeekwalkTaskUpdate, self._onWeekwalkTaskUpdate, self)
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function WeekWalkShallowSettlementView:onClose()
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_ui_artificial_settlement_close)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function WeekWalkShallowSettlementView:onCloseFinish()
	if self._info.isPopDeepSettle then
		WeekWalkController.instance:checkOpenWeekWalkDeepLayerNoticeView()

		return
	end

	WeekWalk_2Controller.instance:checkOpenWeekWalk_2DeepLayerNoticeView()
end

function WeekWalkShallowSettlementView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simagemask:UnLoadImage()
end

return WeekWalkShallowSettlementView
