-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191StageView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191StageView", package.seeall)

local Act191StageView = class("Act191StageView", BaseView)

function Act191StageView:onInitView()
	self._goNodeList = gohelper.findChild(self.viewGO, "#go_NodeList")
	self._goNormalStage = gohelper.findChild(self.viewGO, "#go_NormalStage")
	self._goFightStage = gohelper.findChild(self.viewGO, "#go_FightStage")
	self._goTeam = gohelper.findChild(self.viewGO, "#go_Team")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._txtCoin = gohelper.findChildText(self.viewGO, "go_topright/Coin/#txt_Coin")
	self._txtScore = gohelper.findChildText(self.viewGO, "go_topright/Score/#txt_Score")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191StageView:addEvents()
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function Act191StageView:removeEvents()
	self._btnEnter:RemoveClickListener()
end

function Act191StageView:_btnEnterOnClick()
	if not self.selectIndex then
		return
	end

	GameUtil.setActiveUIBlock("Act191StageViewBlock", true, false)
	Activity191Rpc.instance:sendSelect191NodeRequest(self.actId, self.selectIndex - 1, self.onSelectNode, self)
end

function Act191StageView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()

	gohelper.setActive(self._btnEnter, false)

	local teamPrefab = self:getResInst(Activity191Enum.PrefabPath.TeamComp, self._goTeam)

	MonoHelper.addNoUpdateLuaComOnceToGo(teamPrefab, Act191TeamComp, self)

	local nodeListGo = self:getResInst(Activity191Enum.PrefabPath.NodeListItem, self._goNodeList)

	self.nodeListComp = MonoHelper.addNoUpdateLuaComOnceToGo(nodeListGo, Act191NodeListItem, self)
end

function Act191StageView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_pmgressbar_unfold)

	local gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	self._txtScore.text = gameInfo.score
	self._txtCoin.text = gameInfo.coin

	local nodeInfo = Activity191Helper.matchKeyInArray(gameInfo.nodeInfo, gameInfo.curNode, "nodeId")

	if not nodeInfo then
		logError("nodeInfos中不存在节点ID: " .. gameInfo.curNode)

		return
	end

	local stageNum = #nodeInfo.selectNodeStr

	self.stageItemList = {}
	self.nodeDetailMoList = self:getUserDataTb_()

	for i = 1, 3 do
		local parentIndex = stageNum == 1 and 2 or i
		local rootGo = gohelper.findChild(self.viewGO, "stageList/StageItem" .. parentIndex)

		if i <= stageNum then
			if stageNum == 2 then
				local x = i == 1 and -350 or 350

				recthelper.setAnchor(rootGo.transform, x, 170)
			end

			local mo = Act191NodeDetailMO.New()
			local selectStr = nodeInfo.selectNodeStr[i]

			if selectStr ~= "null" then
				mo:init(selectStr)

				self.nodeDetailMoList[i] = mo

				local stageItem = self:getUserDataTb_()
				local isPve = Activity191Helper.isPveBattle(mo.type)
				local isPvp = Activity191Helper.isPvpBattle(mo.type)

				if isPve or isPvp then
					local go = gohelper.clone(self._goFightStage, rootGo)

					stageItem.canvasGroup = go:GetComponent(gohelper.Type_CanvasGroup)

					local btnClick = gohelper.findChildButton(go, "")

					self.addClickCb(self, btnClick, self.clickStage, self, i)

					local btnCheck = gohelper.findChildButtonWithAudio(go, "btn_Check")

					self.addClickCb(self, btnCheck, self.clickCheck, self, i)
					gohelper.setActive(btnCheck, isPve)

					local goSpine = gohelper.findChild(go, "stage/go_Spine")

					stageItem.goMask = gohelper.findChild(go, "stage/go_mask")

					local goUnknown = gohelper.findChild(go, "stage/go_Unknown")

					stageItem.goSelect = gohelper.findChild(go, "go_Select")

					local imageNodeNum = gohelper.findChildImage(go, "image_NodeNum")
					local imageLevel = gohelper.findChildImage(go, "info/image_Level")
					local goAttr = gohelper.findChild(go, "info/go_attribute")

					gohelper.setActive(goSpine, isPve)
					gohelper.setActive(goUnknown, isPvp)
					UISpriteSetMgr.instance:setAct174Sprite(imageNodeNum, "act174_stage_num_0" .. i)

					local rewardList

					if isPve then
						local eventCo = lua_activity191_fight_event.configDict[mo.fightEventId]
						local fightLvl = eventCo.fightLevel

						UISpriteSetMgr.instance:setAct174Sprite(imageLevel, "act191_level_" .. string.lower(fightLvl))
						self:createSpine(goSpine, eventCo)

						rewardList = GameUtil.splitString2(eventCo.rewardView, true)

						gohelper.setActive(goAttr, false)
					else
						local fightLvl = lua_activity191_match_rank.configDict[mo.matchInfo.rank].fightLevel

						UISpriteSetMgr.instance:setAct174Sprite(imageLevel, "act191_level_" .. string.lower(fightLvl))

						local typeKey = Activity191Enum.NodeType2Key[mo.type]
						local matchCo = lua_activity191_pvp_match.configDict[typeKey]

						rewardList = GameUtil.splitString2(matchCo.rewardView, true)

						local attrFixList = GameUtil.splitString2(matchCo.attribute, true)

						if attrFixList then
							for j = 1, 2 do
								local fixGo = gohelper.findChild(goAttr, j)

								if attrFixList[j] then
									local attrId = attrFixList[j][1]
									local value = attrFixList[j][2]

									value = value > 0 and string.format("+%s%%", value / 10) or string.format("%s%%", value / 10)

									local icon = gohelper.findChildImage(fixGo, "icon")

									UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. attrId)

									local txtAttr = gohelper.findChildText(fixGo, "txt_attribute")

									txtAttr.text = value
								end

								gohelper.setActive(fixGo, attrFixList[j])
							end
						end

						gohelper.setActive(goAttr, attrFixList)
					end

					local data = rewardList[1]

					if data then
						local txtCoin = gohelper.findChildText(go, "reward/txt_Coin")

						txtCoin.text = data[2] or ""

						local config = lua_activity191_item.configDict[data[1]]

						if config then
							local imageCoin = gohelper.findChildImage(go, "reward/image_Coin")

							UISpriteSetMgr.instance:setAct174Sprite(imageCoin, config.icon)
						end
					end
				else
					local go = gohelper.clone(self._goNormalStage, rootGo)

					stageItem.canvasGroup = go:GetComponent(gohelper.Type_CanvasGroup)

					local btnClick = gohelper.findChildButton(go, "")

					self.addClickCb(self, btnClick, self.clickStage, self, i)

					local simageStage = gohelper.findChildSingleImage(go, "stage/simage_Stage")

					stageItem.goSelect = gohelper.findChild(go, "go_Select")

					local imageNodeNum = gohelper.findChildImage(go, "image_NodeNum")
					local txtName = gohelper.findChildText(go, "info/txt_Name")
					local txtDesc = gohelper.findChildText(go, "detail/scroll_desc/Viewport/Content/txt_Desc")
					local goTag = gohelper.findChild(go, "tag")
					local txtTag = gohelper.findChildText(go, "tag/txt_Tag")
					local goAfterGlow = gohelper.findChild(go, "go_AfterGlow")

					UISpriteSetMgr.instance:setAct174Sprite(imageNodeNum, "act174_stage_num_0" .. i)

					local isShop = Activity191Helper.isShopNode(mo.type)
					local resPath

					if isShop then
						local shopCo = lua_activity191_shop.configDict[self.actId][mo.shopId]

						if mo.type == Activity191Enum.NodeType.RoleShop then
							txtTag.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.RoleTag].value2
						elseif mo.type == Activity191Enum.NodeType.CollectionShop then
							txtTag.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.CollectionTag].value2
						elseif mo.type == Activity191Enum.NodeType.TagShop then
							txtTag.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.FetterTag].value2
						end

						txtName.text = shopCo.name
						txtDesc.text = shopCo.desc
						resPath = ResUrl.getAct191SingleBg("stage/act191_stage_mode_3")
					elseif mo.type == Activity191Enum.NodeType.Enhance then
						txtName.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceTitle].value2
						txtDesc.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.EnhanceDesc].value2
						resPath = ResUrl.getAct191SingleBg("stage/act191_stage_mode_2")
					elseif mo.type == Activity191Enum.NodeType.BattleEvent or mo.type == Activity191Enum.NodeType.RewardEvent then
						local eventCo = lua_activity191_event.configDict[mo.eventId]

						txtName.text = eventCo.title
						txtDesc.text = eventCo.outDesc
						resPath = ResUrl.getAct191SingleBg("stage/act191_stage_mode_1")
					elseif mo.type == Activity191Enum.NodeType.ReplaceEvent then
						txtTag.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceTag].value2
						txtName.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceTitle].value2
						txtDesc.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.ReplaceDesc].value2
						resPath = ResUrl.getAct191SingleBg("stage/act191_stage_mode_4")
					elseif mo.type == Activity191Enum.NodeType.UpgradeEvent then
						txtTag.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeTag].value2
						txtName.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeTitle].value2
						txtDesc.text = lua_activity191_const.configDict[Activity191Enum.ConstKey.UpgradeDesc].value2
						resPath = ResUrl.getAct191SingleBg("stage/act191_stage_mode_4")
					end

					local showTag = isShop and mo.type ~= Activity191Enum.NodeType.MixStore or mo.type == Activity191Enum.NodeType.ReplaceEvent or mo.type == Activity191Enum.NodeType.UpgradeEvent

					gohelper.setActive(goTag, showTag)
					gohelper.setActive(goAfterGlow, mo.type == Activity191Enum.NodeType.AfterGlowShop)

					if resPath then
						simageStage:LoadImage(resPath)
					end
				end

				gohelper.setActive(rootGo, true)

				self.stageItemList[i] = stageItem
			end
		end
	end

	gohelper.setActive(self._goFightStage, false)
	gohelper.setActive(self._goNormalStage, false)

	for _, mo in ipairs(self.nodeDetailMoList) do
		self.eventTypeStr = self.eventTypeStr and string.format("%s#%s", self.eventTypeStr, tostring(mo.type)) or tostring(mo.type)
	end

	self.statViewName = string.format("%s_%s", self.viewName, self.eventTypeStr)

	Act191StatController.instance:onViewOpen(self.statViewName)
end

function Act191StageView:onClose()
	local isManual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.statViewName, isManual)
end

function Act191StageView:onDestroyView()
	TaskDispatcher.cancelTask(self.playSalaryAnim, self)
	TaskDispatcher.cancelTask(self.delayClose, self)
	GameUtil.setActiveUIBlock("Act191StageViewBlock", false, true)
end

function Act191StageView:clickStage(index)
	if not self.selectIndex then
		gohelper.setActive(self._btnEnter, true)
	end

	if self.selectIndex == index then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_fire_interface)

	self.selectIndex = index

	for k, stageItem in ipairs(self.stageItemList) do
		stageItem.canvasGroup.alpha = k == index and 1 or 0.5

		gohelper.setActive(stageItem.goSelect, k == index)
		gohelper.setActive(stageItem.goMask, k ~= index)
	end
end

function Act191StageView:clickCheck(index)
	local mo = self.nodeDetailMoList[index]

	if mo then
		local episodeId = lua_activity191_fight_event.configDict[mo.fightEventId].episodeId
		local episodeCo = DungeonConfig.instance:getEpisodeCO(episodeId)

		EnemyInfoController.instance:openAct191EnemyInfoView(episodeCo.battleId)
		Act191StatController.instance:statButtonClick(self.viewName, string.format("clickCheck_%s_%s", index, mo.fightEventId))
	end
end

function Act191StageView:onSelectNode(_, resultCode)
	if resultCode == 0 then
		Activity191Controller.instance:nextStep()
		TaskDispatcher.runDelay(self.delayClose, self, 0.35)
	else
		GameUtil.setActiveUIBlock("Act191StageViewBlock", false, true)
	end
end

function Act191StageView:delayClose()
	ViewMgr.instance:closeView(self.viewName)
end

function Act191StageView:createSpine(parentGo, config)
	local uiSpine = GuiSpine.Create(parentGo, false)
	local skinCo = FightConfig.instance:getSkinCO(config.skinId)

	uiSpine:setResPath(ResUrl.getSpineUIPrefab(skinCo.spine), nil, nil, true)

	if not string.nilorempty(config.offset) then
		local offsetArr = string.splitToNumber(config.offset, "#")

		recthelper.setAnchor(parentGo.transform, offsetArr[1], offsetArr[2])

		if offsetArr[3] then
			transformhelper.setLocalScale(parentGo.transform, offsetArr[3], offsetArr[3], 1)
		end
	end
end

function Act191StageView:onCloseView(viewName)
	if viewName == ViewName.Act191SwitchView and self.nodeListComp.firstNode then
		self.nodeListComp:showSalary()
		TaskDispatcher.runDelay(self.playSalaryAnim, self, 0.5)
	end
end

function Act191StageView:playSalaryAnim()
	self.nodeListComp:playSalaryAnim(self._txtCoin.gameObject, self._txtScore.gameObject)
end

return Act191StageView
