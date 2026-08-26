-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191AdventureView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191AdventureView", package.seeall)

local Act191AdventureView = class("Act191AdventureView", BaseView)

function Act191AdventureView:onInitView()
	self._goLive2d = gohelper.findChild(self.viewGO, "live2dcontainer/#go_Live2d")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._btnEnemyInfo = gohelper.findChildButtonWithAudio(self.viewGO, "#txt_Title/#btn_EnemyInfo")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#txt_Desc")
	self._txtTarget = gohelper.findChildText(self.viewGO, "#txt_Target")
	self._goReward = gohelper.findChild(self.viewGO, "#go_Reward")
	self._btnNext = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Next")
	self._txtNext = gohelper.findChildText(self.viewGO, "#btn_Next/#txt_Next")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191AdventureView:addEvents()
	self._btnEnemyInfo:AddClickListener(self._btnEnemyInfoOnClick, self)
	self._btnNext:AddClickListener(self._btnNextOnClick, self)
end

function Act191AdventureView:removeEvents()
	self._btnEnemyInfo:RemoveClickListener()
	self._btnNext:RemoveClickListener()
end

function Act191AdventureView:_btnEnemyInfoOnClick()
	if self.battleId then
		EnemyInfoController.instance:openAct191EnemyInfoView(self.battleId)
	end
end

function Act191AdventureView:_btnNextOnClick()
	if self.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		local actId = Activity191Model.instance:getCurActId()

		Activity191Rpc.instance:sendGain191RewardEventRequest(actId, self.onGainRewardReply, self)
	elseif self.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		Activity191Controller.instance:enterFightScene(self.nodeDetailMo)
	end
end

function Act191AdventureView:onOpen()
	self.addEventCb(self, Activity191Controller.instance, Activity191Event.GameInfoUpdatePush, self.onGameInfoUpdatePush, self)
	Act191StatController.instance:onViewOpen(self.viewName)

	self.nodeDetailMo = self.viewParam
	self.eventCo = lua_activity191_event.configDict[self.nodeDetailMo.eventId]
	self._txtTitle.text = GameUtil.setFirstStrSize(self.eventCo.title, 62)
	self._txtDesc.text = self.eventCo.desc
	self._txtTarget.text = self.eventCo.task

	if self.nodeDetailMo.type == Activity191Enum.NodeType.RewardEvent then
		self._txtNext.text = luaLang("act191adventureview_gainreward")

		gohelper.setActive(self._btnEnemyInfo, false)
	elseif self.nodeDetailMo.type == Activity191Enum.NodeType.BattleEvent then
		self._txtNext.text = luaLang("act191adventureview_start")

		gohelper.setActive(self._btnEnemyInfo, true)

		local eventId = self.nodeDetailMo.fightEventId
		local episodeId = lua_activity191_fight_event.configDict[eventId].episodeId
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		self.battleId = episodeCo and episodeCo.battleId
	end

	self._uiSpine = GuiModelAgent.Create(self._goLive2d, true)

	local skinCO = FightConfig.instance:getSkinCO(self.eventCo.skinId)

	if skinCO then
		self._uiSpine:setResPath(skinCO, function()
			self._uiSpine:setLayer(UnityLayer.Unit)
		end, self)

		if not string.nilorempty(self.eventCo.offset) then
			local offsetArr = string.splitToNumber(self.eventCo.offset, "#")

			recthelper.setAnchor(self._goLive2d.transform, offsetArr[1], offsetArr[2])

			local scale = offsetArr[3]

			if scale then
				transformhelper.setLocalScale(self._goLive2d.transform, scale, scale, 1)
			end
		end
	end

	local rewardList = GameUtil.splitString2(self.eventCo.rewardView, true)

	for _, v in ipairs(rewardList) do
		local go = self:getResInst(Activity191Enum.PrefabPath.RewardItem, self._goReward)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191RewardItem)

		item:setData(v[1], v[2])
	end
end

function Act191AdventureView:onClose()
	local isManual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, isManual)
end

function Act191AdventureView:onGainRewardReply(_, resultCode)
	if resultCode == 0 then
		local needOpen = Activity191Controller.instance:checkOpenGetView()

		if needOpen then
			ViewMgr.instance:openView(ViewName.Act191GetView, self.cacheInfo)
		else
			Activity191Controller.instance:nextStep()
		end

		ViewMgr.instance:closeView(self.viewName)
	end
end

function Act191AdventureView:onGameInfoUpdatePush(gameInfo)
	self.cacheInfo = Act191GameMO.New()

	self.cacheInfo:init(gameInfo)
end

return Act191AdventureView
