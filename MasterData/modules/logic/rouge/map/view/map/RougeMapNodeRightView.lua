-- chunkname: @modules/logic/rouge/map/view/map/RougeMapNodeRightView.lua

module("modules.logic.rouge.map.view.map.RougeMapNodeRightView", package.seeall)

local RougeMapNodeRightView = class("RougeMapNodeRightView", BaseView)

function RougeMapNodeRightView:onInitView()
	self._txtChapterName = gohelper.findChildText(self.viewGO, "#go_node_right/Title/#txt_ChapterName")
	self._txtChapterNameEn = gohelper.findChildText(self.viewGO, "#go_node_right/Title/#txt_ChapterNameEn")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_node_right/#txt_Desc")
	self._btnMoveBtn = gohelper.findChildButtonWithAudio(self.viewGO, "#go_node_right/#btn_MoveBtn")
	self._gocareer = gohelper.findChild(self.viewGO, "#go_node_right/#go_career")
	self._gocareeritem = gohelper.findChild(self.viewGO, "#go_node_right/#go_career/bg/go_careeritem")
	self._simageDefaultPic = gohelper.findChildSingleImage(self.viewGO, "#go_node_right/#go_DefaultPic")
	self._simageMonsterMaskPic = gohelper.findChildSingleImage(self.viewGO, "#go_node_right/#go_MonsterMaskPic")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapNodeRightView:addEvents()
	self._btnMoveBtn:AddClickListener(self._btnMoveBtnOnClick, self)
end

function RougeMapNodeRightView:removeEvents()
	self._btnMoveBtn:RemoveClickListener()
end

function RougeMapNodeRightView:_btnMoveBtnOnClick()
	local status = self.nodeMo.arriveStatus

	if status == RougeMapEnum.Arrive.CanArrive then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onBeforeSendMoveRpc)
		RougeRpc.instance:sendRougeRoundMoveRequest(self.nodeMo.nodeId)

		return
	end

	RougeMapChoiceEventHelper.triggerEventHandle(self.nodeMo)
end

function RougeMapNodeRightView:_editableInitView()
	self.goDefaultPic = self._simageDefaultPic.gameObject
	self.goMonsterMaskPic = self._simageMonsterMaskPic.gameObject
	self.goNodeRight = gohelper.findChild(self.viewGO, "#go_node_right")
	self.rightAnimator = self.goNodeRight:GetComponent(gohelper.Type_Animator)
	self.txtBtn = gohelper.findChildText(self.viewGO, "#go_node_right/#btn_MoveBtn/txt_Move")
	self.txtBtnEn = gohelper.findChildText(self.viewGO, "#go_node_right/#btn_MoveBtn/txt_MoveEn")

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onSelectNode, self.onSelectNode, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onNormalActorBeforeMove, self.onNormalActorBeforeMove, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onActorMovingDone, self.onActorMovingDone, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onShowContinueFight, self.onShowContinueFight, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onUpdateMapInfo, self.onUpdateMapInfo, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onPopViewDone, self.onPopViewDone, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onClearInteract, self.onClearInteract, self)

	self.goCareerList = self:getUserDataTb_()
	self.careerList = {}

	table.insert(self.goCareerList, self._gocareeritem)
	self:hideDescContainer()
end

function RougeMapNodeRightView:onOpen()
	self:autoContinueEvent()
end

function RougeMapNodeRightView:autoContinueEvent()
	local curNode = RougeMapModel.instance:getCurNode()

	if curNode and curNode:isStartedEvent() then
		self:_triggerHandle()
	end
end

function RougeMapNodeRightView:onUpdateMapInfo()
	if not self.nodeMo then
		return
	end

	if self.nodeMo.eventId == self.eventId then
		return
	end

	self:updateData(self.nodeMo)
	self:refreshRight()
end

function RougeMapNodeRightView:onChangeMapInfo()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function RougeMapNodeRightView:onSelectNode(nodeMo)
	if not nodeMo then
		self:updateData()
		self:hideDescContainer()

		return
	end

	if nodeMo == self.nodeMo then
		return
	end

	self:updateData(nodeMo)

	local status = self.nodeMo.arriveStatus

	if status == RougeMapEnum.Arrive.CanArrive then
		self:switchNode()
	else
		RougeMapChoiceEventHelper.triggerContinueEventHandle(self.nodeMo)
	end
end

function RougeMapNodeRightView:switchNode()
	self.rightAnimator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.refreshRight, self)
	TaskDispatcher.runDelay(self.refreshRight, self, RougeMapEnum.WaitMapRightRefreshTime)
end

function RougeMapNodeRightView:onShowContinueFight()
	self:refreshRight(true)
end

function RougeMapNodeRightView:updateData(nodeMo)
	if not nodeMo then
		self.nodeMo = nil
		self.eventCo = nil
		self.eventMo = nil
		self.eventId = nil

		return
	end

	self.nodeMo = nodeMo
	self.eventCo = self.nodeMo:getEventCo()
	self.eventMo = self.nodeMo.eventMo
	self.eventId = self.nodeMo.eventId
end

function RougeMapNodeRightView:refreshRight(showContinueFight)
	if not self.eventCo then
		return
	end

	self._txtChapterName.text = self.eventCo.name
	self._txtChapterNameEn.text = self.eventCo.nameEn
	self._txtDesc.text = self.eventCo.desc

	self:showDescContainer()
	self:refreshBtn(showContinueFight)
	self:refreshCareer()
	self:refreshPic()
end

function RougeMapNodeRightView:refreshCareer()
	local eventType = self.eventCo.type

	if not eventType then
		gohelper.setActive(self._gocareer, false)
	end

	local isFight = RougeMapHelper.isFightEvent(eventType)

	gohelper.setActive(self._gocareer, isFight)

	if isFight then
		local careerList = self:getCareerList(self.eventId)

		for i, career in ipairs(careerList) do
			local go = self.goCareerList[i]

			if not go then
				go = gohelper.cloneInPlace(self._gocareeritem)

				table.insert(self.goCareerList, go)
			end

			gohelper.setActive(go, true)

			local image = go:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setRougeSprite(image, "rouge_map_career_" .. career)
		end

		for i = #careerList + 1, #self.goCareerList do
			gohelper.setActive(self.goCareerList[i], false)
		end
	end
end

function RougeMapNodeRightView:getCareerList(eventId)
	tabletool.clear(self.careerList)

	local fightEventCo = RougeMapConfig.instance:getFightEvent(eventId)

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

function RougeMapNodeRightView:refreshPic()
	local eventType = self.eventCo.type
	local showMask = RougeMapEffectHelper.checkHadEffect(RougeMapEnum.EffectType.UnlockShowPassFightMask, eventType)
	local passed = RougeOutsideModel.instance:passedEventId(self.eventId)

	if showMask and passed then
		self:refreshMonsterPic()
	else
		self:refreshDefaultPic()
	end
end

function RougeMapNodeRightView:refreshDefaultPic()
	gohelper.setActive(self.goDefaultPic, true)
	gohelper.setActive(self.goMonsterMaskPic, false)

	local eventType = self.eventCo.type
	local defaultPic = RougeMapEnum.EventDefaultPic[eventType]

	if not defaultPic then
		logError("event type not config default pic " .. tostring(eventType))

		return
	end

	self._simageDefaultPic:LoadImage(string.format(RougeMapEnum.PicFormat, defaultPic))
end

function RougeMapNodeRightView:refreshMonsterPic()
	gohelper.setActive(self.goDefaultPic, false)
	gohelper.setActive(self.goMonsterMaskPic, true)

	local fightEventCo = RougeMapConfig.instance:getFightEvent(self.eventId)
	local monsterMask = fightEventCo and fightEventCo.monsterMask

	if string.nilorempty(monsterMask) then
		self:refreshDefaultPic()

		return
	end

	self._simageMonsterMaskPic:LoadImage(string.format(RougeMapEnum.RougeMapEnum.MonsterMaskFormat, monsterMask))
end

function RougeMapNodeRightView:onNormalActorBeforeMove()
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function RougeMapNodeRightView:onActorMovingDone()
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	self:_triggerHandle()
end

function RougeMapNodeRightView:_triggerHandle()
	if RougePopController.instance:hadPopView() then
		self.waitPopDone = true

		return
	end

	if RougeMapModel.instance:isInteractiving() then
		self.waitInteract = true

		return
	end

	self.waitPopDone = nil
	self.waitInteract = nil

	local nodeMo = RougeMapModel.instance:getCurNode()

	RougeMapChoiceEventHelper.triggerEventHandle(nodeMo)
end

function RougeMapNodeRightView:onClearInteract()
	if not self.waitInteract then
		return
	end

	self:_triggerHandle()
end

function RougeMapNodeRightView:onPopViewDone()
	if not self.waitPopDone then
		return
	end

	self:_triggerHandle()
end

function RougeMapNodeRightView:showDescContainer()
	gohelper.setActive(self.goNodeRight, true)
end

function RougeMapNodeRightView:refreshBtn(showContinueFight)
	local text, textEn

	if showContinueFight then
		text = luaLang("rougemapview_txt_Fight")
		textEn = "FIGHT"
	else
		text = luaLang("rougemapview_txt_Move")
		textEn = "MOVE"
	end

	self.txtBtn.text = text
	self.txtBtnEn.text = textEn
end

function RougeMapNodeRightView:hideDescContainer()
	gohelper.setActive(self.goNodeRight, false)
end

function RougeMapNodeRightView:onClose()
	TaskDispatcher.cancelTask(self.refreshRight, self)
end

function RougeMapNodeRightView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRight, self)
	self._simageDefaultPic:UnLoadImage()
	self._simageMonsterMaskPic:UnLoadImage()
end

return RougeMapNodeRightView
