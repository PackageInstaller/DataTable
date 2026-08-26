-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapNodeRightView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapNodeRightView", package.seeall)

local Rouge2_MapNodeRightView = class("Rouge2_MapNodeRightView", BaseView)

function Rouge2_MapNodeRightView:onInitView()
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "#go_node_right/RightBG/#simage_BG")
	self._txtChapterName = gohelper.findChildText(self.viewGO, "#go_node_right/layout/Title/#txt_ChapterName")
	self._txtDesc1 = gohelper.findChildText(self.viewGO, "#go_node_right/layout/#scroll_View/Viewport/Content/#txt_Desc1")
	self._txtDesc2 = gohelper.findChildText(self.viewGO, "#go_node_right/layout/#scroll_View/Viewport/Content/#txt_Desc2")
	self._btnMoveBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_node_right/#btn_MoveBtn")
	self._goMoveNormal = gohelper.findChild(self.viewGO, "#go_node_right/#btn_MoveBtn/image_normal")
	self._goMoveHard = gohelper.findChild(self.viewGO, "#go_node_right/#btn_MoveBtn/image_hard")
	self._goCareer = gohelper.findChild(self.viewGO, "#go_node_right/#go_Career")
	self._goCareerItem = gohelper.findChild(self.viewGO, "#go_node_right/#go_Career/#go_CareerItem")
	self._goAttrList = gohelper.findChild(self.viewGO, "#go_node_right/#go_AttrList")
	self._goAttrItem = gohelper.findChild(self.viewGO, "#go_node_right/#go_AttrList/#go_AttrItem")
	self._goBoss = gohelper.findChild(self.viewGO, "#go_node_right/#go_Boss")
	self._goElite = gohelper.findChild(self.viewGO, "#go_node_right/layout/#go_Elite")
	self._txtEliteDesc = gohelper.findChildText(self.viewGO, "#go_node_right/layout/#go_Elite/#txt_EliteDesc")
	self._simageEliteHead = gohelper.findChildSingleImage(self.viewGO, "#go_node_right/layout/#go_Elite/#image_EliteHead")
	self._btnEliteDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_node_right/layout/#go_Elite/#image_EliteHead/#btn_EliteDetail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapNodeRightView:addEvents()
	self._btnMoveBtn:AddClickListener(self._btnMoveBtnOnClick, self)
	self._btnEliteDetail:AddClickListener(self._btnEliteDetailOnClick, self)
end

function Rouge2_MapNodeRightView:removeEvents()
	self._btnMoveBtn:RemoveClickListener()
	self._btnEliteDetail:RemoveClickListener()
end

function Rouge2_MapNodeRightView:_btnMoveBtnOnClick()
	local status = self.nodeMo.arriveStatus

	if status == Rouge2_MapEnum.Arrive.CanArrive then
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onBeforeSendMoveRpc)

		local layerId = Rouge2_MapModel.instance:getLayerId()

		Rouge2_Rpc.instance:sendRouge2RoundMoveRequest(layerId, self.nodeMo.nodeId)

		return
	end

	Rouge2_MapChoiceEventHelper.triggerEventHandle(self.nodeMo)
end

function Rouge2_MapNodeRightView:_btnEliteDetailOnClick()
	if not self.eventCo then
		return
	end

	local isFight = Rouge2_MapHelper.isFightEvent(self.eventType)

	if not isFight then
		return
	end

	local fightEventCo = Rouge2_MapConfig.instance:eventId2FightEventCo(self.eventCo.id)

	if fightEventCo then
		::label_5_0::

		local episodeCo = DungeonConfig.instance:getEpisodeCO(fightEventCo.episodeId)
		local battleId = episodeCo and episodeCo.battleId

		if not battleId or battleId == 0 then
			logError(string.format("Rouge2_MapEliteFightView._btndetailOnClick error ! battleId is nil, eventId = %s", self.eventId))

			return
		end

		self._battleId = battleId
		self._nodeId = self.nodeMo.nodeId

		if self._fixHpRate then
			EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))

			return
		end

		Rouge2_Rpc.instance:sendRouge2MonsterFixAttrRequest(self._nodeId, self._onGetFixAttrRequest, self)
	end
end

function Rouge2_MapNodeRightView:_onGetFixAttrRequest(req, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self._fixHpRate = msg.fixHpRate

	EnemyInfoController.instance:openRougeEnemyInfoView(self._battleId, 1 + tonumber(self._fixHpRate))
end

function Rouge2_MapNodeRightView:_editableInitView()
	self.goNodeRight = gohelper.findChild(self.viewGO, "#go_node_right")
	self.rightAnimator = self.goNodeRight:GetComponent(gohelper.Type_Animator)
	self._txtBtn = gohelper.findChildText(self.viewGO, "#go_node_right/#btn_MoveBtn/txt_Move")
	self._goMoveBtnNormalBg = gohelper.findChild(self.viewGO, "#go_node_right/#btn_MoveBtn/image_normal")
	self._goMoveBtnHardBg = gohelper.findChild(self.viewGO, "#go_node_right/#btn_MoveBtn/image_hard")

	SkillHelper.addHyperLinkClick(self._txtDesc1)
	SkillHelper.addHyperLinkClick(self._txtDesc2)
	SkillHelper.addHyperLinkClick(self._txtEliteDesc)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectNode, self.onSelectNode, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onActorMovingDone, self.onActorMovingDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onShowContinueFight, self.onShowContinueFight, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)

	self.careerList = {}

	self:hideDescContainer()
end

function Rouge2_MapNodeRightView:onOpen()
	self:autoContinueEvent()
end

function Rouge2_MapNodeRightView:autoContinueEvent()
	if Rouge2_MapModel.instance:checkManualCloseHeroGroupView() then
		return
	end

	local curNode = Rouge2_MapModel.instance:getCurNode()

	if curNode and curNode:isStartedEvent() then
		self:_triggerHandle()
	end
end

function Rouge2_MapNodeRightView:onUpdateMapInfo()
	if not self.nodeMo then
		return
	end

	if self.nodeMo.eventId == self.eventId then
		return
	end

	self:updateData(self.nodeMo)
	self:refreshRight()
end

function Rouge2_MapNodeRightView:onChangeMapInfo()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectNode, nil)
end

function Rouge2_MapNodeRightView:onSelectNode(nodeMo)
	if not nodeMo then
		self:updateData()
		self:hideDescContainer()

		return
	end

	if nodeMo == self.nodeMo then
		if self.nodeMo.arriveStatus == Rouge2_MapEnum.Arrive.ArrivingNotFinish then
			Rouge2_MapChoiceEventHelper.triggerContinueEventHandle(self.nodeMo)
		end

		return
	end

	self:updateData(nodeMo)

	local status = self.nodeMo.arriveStatus

	if status == Rouge2_MapEnum.Arrive.CanArrive then
		self:switchNode()
	else
		Rouge2_MapChoiceEventHelper.triggerContinueEventHandle(self.nodeMo)
	end
end

function Rouge2_MapNodeRightView:switchNode()
	self.rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.refreshRight, self)
	TaskDispatcher.runDelay(self.refreshRight, self, Rouge2_MapEnum.WaitMapRightRefreshTime)
end

function Rouge2_MapNodeRightView:onShowContinueFight()
	self:refreshRight(true)
end

function Rouge2_MapNodeRightView:updateData(nodeMo)
	if not nodeMo then
		self.nodeMo = nil
		self.eventCo = nil
		self.eventMo = nil
		self.eventId = nil
		self.eventType = nil

		return
	end

	self.nodeMo = nodeMo
	self.eventCo = self.nodeMo:getEventCo()
	self.eventMo = self.nodeMo.eventMo
	self.eventId = self.nodeMo.eventId
	self.eventType = self.eventCo.type
end

function Rouge2_MapNodeRightView:refreshRight(showContinueFight)
	if not self.eventCo then
		return
	end

	self._eventTypeCo = lua_rouge2_event_type.configDict[self.eventCo.type]
	self._txtChapterName.text = self._eventTypeCo and self._eventTypeCo.name
	self._txtDesc1.text = SkillHelper.buildDesc(self.eventCo.desc)

	self:showDescContainer()
	self:refreshBtn(showContinueFight)
	self:refreshEventDesc()
	self:refreshBossDesc()
	self:refreshCareer()
	self:refreshAttribute()
	self:refreshBg()
end

function Rouge2_MapNodeRightView:refreshEventDesc()
	if self._eventTypeCo then
		local eventDesc = self._eventTypeCo.desc
		local hasEventDesc = not string.nilorempty(eventDesc)

		gohelper.setActive(self._txtDesc2.gameObject, hasEventDesc)

		if not hasEventDesc then
			return
		end

		self._txtDesc2.text = SkillHelper.buildDesc(eventDesc)
	end
end

function Rouge2_MapNodeRightView:refreshBossDesc()
	local isEliteFight = Rouge2_MapHelper.isEliteFightEvent(self.eventType)
	local isBossFight = self.eventType == Rouge2_MapEnum.EventType.BossFight

	gohelper.setActive(self._goElite, isEliteFight)
	gohelper.setActive(self._goBoss, isBossFight)

	if not isEliteFight then
		return
	end

	local fightEventCo = Rouge2_MapConfig.instance:eventId2FightEventCo(self.eventId)

	self._txtEliteDesc.text = SkillHelper.buildDesc(fightEventCo.eliteFightDesc)

	local monsterMask = fightEventCo.monsterMask

	if string.nilorempty(monsterMask) then
		logError(string.format("战斗事件表id ： %s， 没有配置Boss剪影", self.eventId))

		return
	end

	self._simageEliteHead:LoadImage(ResUrl.monsterHeadIcon(monsterMask))
end

function Rouge2_MapNodeRightView:refreshCareer()
	if self.eventCo then
		local eventType = self.eventCo.type

		if not eventType then
			gohelper.setActive(self._goCareer, false)
		end

		local isFight = Rouge2_MapHelper.isFightEvent(eventType)

		gohelper.setActive(self._goCareer, isFight)

		if isFight then
			local careerList = self:getCareerList(self.eventId)

			gohelper.CreateObjList(self, self._refreshBossCareer, careerList, self._goCareer, self._goCareerItem)
		end
	end
end

function Rouge2_MapNodeRightView:_refreshBossCareer(obj, careerId, index)
	local image = obj:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setRougeSprite(image, "rouge_map_career_" .. careerId, true)
end

function Rouge2_MapNodeRightView:getCareerList(eventId)
	tabletool.clear(self.careerList)

	local fightEventCo = Rouge2_MapConfig.instance:eventId2FightEventCo(eventId)

	if not fightEventCo then
		return self.careerList
	end

	local episodeCo = DungeonConfig.instance:getEpisodeCO(fightEventCo.episodeId)

	if not episodeCo then
		return self.careerList
	end

	local battleCo = lua_battle.configDict[episodeCo.battleId]

	if not battleCo then
		return self.careerList
	end

	local monsterGroupIdList = string.splitToNumber(battleCo.monsterGroupIds, "#")

	for _, groupId in ipairs(monsterGroupIdList) do
		local groupCo = lua_monster_group.configDict[groupId]
		local monsterIdList = string.splitToNumber(groupCo.monster, "#")

		for _, monsterId in ipairs(monsterIdList) do
			local monsterCo = lua_monster.configDict[monsterId]
			local career = monsterCo.career

			if not tabletool.indexOf(self.careerList, career) then
				table.insert(self.careerList, career)
			end
		end
	end

	return self.careerList
end

function Rouge2_MapNodeRightView:refreshAttribute()
	if self.eventCo then
		local eventType = self.eventCo.type

		if not eventType then
			gohelper.setActive(self._goAttrList, false)
		end

		local isFight = Rouge2_MapHelper.isFightEvent(eventType)

		gohelper.setActive(self._goAttrList, not isFight)

		if isFight then
			return
		end

		local advanceAttributeIds = string.splitToNumber(self.eventCo.advantageAttribute, "#")

		gohelper.CreateObjList(self, self._refreshSingleAdvanceAttribute, advanceAttributeIds, self._goAttrList, self._goAttrItem)
	end
end

function Rouge2_MapNodeRightView:_refreshSingleAdvanceAttribute(obj, attributeId, index)
	local imageIcon = obj:GetComponent(gohelper.Type_Image)

	Rouge2_IconHelper.setAttributeIcon(attributeId, imageIcon, Rouge2_Enum.AttrIconSuffix.Circle)
end

function Rouge2_MapNodeRightView:refreshBg()
	if self.eventCo then
		local eventType = self.eventCo.type
		local defaultPic = Rouge2_MapEnum.EventBg[eventType]

		if not defaultPic then
			logError("event type not config default pic " .. tostring(eventType))

			return
		end

		local isRedBg = defaultPic ~= "rouge2_map_rightbg_1"

		gohelper.setActive(self._goMoveNormal, not isRedBg)
		gohelper.setActive(self._goMoveHard, isRedBg)

		if isRedBg then
			AudioMgr.instance:trigger(AudioEnum.Rouge2.EliteFightEvent)
		end

		self._simageBG:LoadImage(string.format(Rouge2_MapEnum.PicFormat, defaultPic))
	end
end

function Rouge2_MapNodeRightView:onNormalActorBeforeMove()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectNode, nil)
end

function Rouge2_MapNodeRightView:onActorMovingDone()
	if not Rouge2_MapModel.instance:isNormalLayer() then
		return
	end

	self:_triggerHandle()
end

function Rouge2_MapNodeRightView:_triggerHandle()
	if Rouge2_PopController.instance:hadPopView() then
		self.waitPopDone = true

		return
	end

	if Rouge2_MapModel.instance:isInteractiving() then
		self.waitInteract = true

		return
	end

	if Rouge2_MapModel.instance:needPlayMoveToEndAnim() then
		return
	end

	self.waitPopDone = nil
	self.waitInteract = nil

	local nodeMo = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandle(nodeMo)
end

function Rouge2_MapNodeRightView:onClearInteract()
	if not self.waitInteract then
		return
	end

	self:_triggerHandle()
end

function Rouge2_MapNodeRightView:onPopViewDone()
	if not self.waitPopDone then
		return
	end

	self:_triggerHandle()
end

function Rouge2_MapNodeRightView:showDescContainer()
	gohelper.setActive(self.goNodeRight, true)
end

function Rouge2_MapNodeRightView:refreshBtn(showContinueFight)
	self._txtBtn.text = showContinueFight and luaLang("rouge2_mapview_fight") or luaLang("rouge2_mapview_move")

	gohelper.setActive(self._goMoveBtnNormalBg, self.eventType ~= Rouge2_MapEnum.EventType.BossFight)
	gohelper.setActive(self._goMoveBtnHardBg, self.eventType == Rouge2_MapEnum.EventType.BossFight)
end

function Rouge2_MapNodeRightView:hideDescContainer()
	gohelper.setActive(self.goNodeRight, false)
end

function Rouge2_MapNodeRightView:onClose()
	TaskDispatcher.cancelTask(self.refreshRight, self)
end

function Rouge2_MapNodeRightView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRight, self)
	self._simageBG:UnLoadImage()
	self._simageEliteHead:UnLoadImage()
end

return Rouge2_MapNodeRightView
