-- chunkname: @modules/logic/abyss/view/AbyssMainView.lua

module("modules.logic.abyss.view.AbyssMainView", package.seeall)

local AbyssMainView = class("AbyssMainView", BaseView)

function AbyssMainView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._goclipNode = gohelper.findChild(self.viewGO, "#go_clipNode")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssMainView:addEvents()
	self._btnRecommend:AddClickListener(self._btnRecommendOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.refreshEpisode, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self.refreshEpisode, self)
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupAfterEnterEpisode, self._onUseRecommendGroup, self)
end

function AbyssMainView:removeEvents()
	self._btnRecommend:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.refreshEpisode, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self.refreshEpisode, self)
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroupAfterEnterEpisode, self._onUseRecommendGroup, self)
end

function AbyssMainView:_btnRecommendOnClick()
	local stageConfigList = AbyssConfig.instance:getStageConfigListByActId(AbyssModel.instance:getCurActId())

	if not stageConfigList or next(stageConfigList) == nil then
		return
	end

	local episodeId = stageConfigList[1].episodeId

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(episodeId, self._receiveRecommend, self)
end

function AbyssMainView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local stageConfigList = AbyssConfig.instance:getStageConfigListByActId(AbyssModel.instance:getCurActId())
	local episodeIdList = {}

	for _, stageConfig in ipairs(stageConfigList) do
		table.insert(episodeIdList, stageConfig.episodeId)
	end

	local param = {}

	param.msg = msg
	param.episodeId = episodeIdList[1]
	param.episodeIdList = episodeIdList

	HeroGroupModel.instance:setAfterUpdateRecommendState(true)
	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, param)
end

function AbyssMainView:_onUseRecommendGroup(episodeId)
	if not AbyssModel.instance:isCurActOpen(true) then
		return
	end

	local actId = AbyssModel.instance:getCurActId()
	local stageId = not episodeId and AbyssModel.instance:getCurStageId() or AbyssConfig.instance:getStageIdByEpisodeId(actId, episodeId)

	AbyssModel.instance:setCurStageId(stageId)
	AbyssController.instance:startFight(actId, stageId)
end

function AbyssMainView:_editableInitView()
	self._episodeItemList = {}

	local parent = self._goclipNode.transform
	local childCount = parent.childCount

	for i = 1, childCount do
		local childNode = parent:GetChild(i - 1).gameObject
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(childNode, AbyssStageItem)

		table.insert(self._episodeItemList, item)
	end

	local rewardGo = gohelper.findChild(self.viewGO, "rewardPreview")

	self.rewardItem = MonoHelper.addNoUpdateLuaComOnceToGo(rewardGo, AbyssRewardItem)
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._btnRecommend = gohelper.findChildButton(self.viewGO, "#btn_tuijian")
end

function AbyssMainView:onUpdateParam()
	return
end

AbyssMainView.RefreshTimeDuration = 1

function AbyssMainView:onOpen()
	self:checkParam()
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, AbyssMainView.RefreshTimeDuration)
	self._animator:Play("in", 0, 0)
	self:refreshUI()
	AbyssController.instance:requestAbyssSnapshot()

	if not ViewMgr.instance:isOpen(ViewName.LoadingView) then
		self:playAnim()
	else
		self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self, LuaEventSystem.Low)
	end
end

function AbyssMainView:_onCloseView(viewName)
	if viewName == ViewName.LoadingView then
		self:playAnim()
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	end
end

function AbyssMainView:playAnim()
	if not self.episodeList then
		return
	end

	for index, _ in ipairs(self.episodeList) do
		local item = self._episodeItemList[index]

		if not item then
			logError("新深渊 关卡索引越界 index: " .. tostring(index))
		elseif item.isPreviousChallenged then
			item:playAnim()
		end
	end
end

function AbyssMainView:refreshUI()
	self:refreshEpisode()
end

function AbyssMainView:checkParam()
	local actId = AbyssModel.instance:getCurActId()

	if not actId then
		logError("新深渊 没有活动数据")

		return
	end

	self.actId = actId

	local episodeList = AbyssConfig.instance:getStageConfigListByActId(self.actId)

	if not episodeList or next(episodeList) == nil then
		logError("新深渊 没有关卡数据 actId:" .. tostring(self.actId))

		return
	end

	self.episodeList = episodeList

	self.rewardItem:setInfo(self.actId)
	AbyssModel.instance:setCurActId(self.actId)
end

function AbyssMainView:refreshTime()
	if not self.actId then
		self._txttime.text = luaLang("ended")

		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		self._txttime.text = luaLang("ended")

		return
	end

	local endTime = ActivityModel.instance:getActEndTime(self.actId) / TimeUtil.OneSecondMilliSecond
	local nowTime = ServerTime.now()

	self._txttime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function AbyssMainView:refreshEpisode()
	if not self.episodeList then
		return
	end

	for index, stageConfig in ipairs(self.episodeList) do
		local item = self._episodeItemList[index]

		if not item then
			logError("新深渊 关卡索引越界 index: " .. tostring(index))
		else
			item:setInfo(stageConfig)
		end
	end

	AbyssModel.instance:clearFightResultParam()
end

function AbyssMainView:onClickClose()
	self._animator:Play("out", 0, 0)

	local time = AbyssEnum.ViewOutTime.MainView

	UIBlockHelper.instance:startBlock(AbyssEnum.UIBlockKey.MainView, time, self.viewName)
	TaskDispatcher.runDelay(self.onOutTimePlayEnd, self, time)
end

function AbyssMainView:onOutTimePlayEnd()
	TaskDispatcher.cancelTask(self.onOutTimePlayEnd, self)
	UIBlockHelper.instance:endBlock(AbyssEnum.UIBlockKey.MainView)
	AbyssController.instance:dispatchEvent(AbyssEvent.OnAbyssMainViewClose)
	self:closeThis()
end

function AbyssMainView:onClose()
	return
end

function AbyssMainView:onDestroyView()
	TaskDispatcher.cancelTask(self.onOutTimePlayEnd, self)
	UIBlockHelper.instance:endBlock(AbyssEnum.UIBlockKey.MainView)
	TaskDispatcher.cancelTask(self.refreshTime, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

return AbyssMainView
