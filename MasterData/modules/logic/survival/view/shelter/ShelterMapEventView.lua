-- chunkname: @modules/logic/survival/view/shelter/ShelterMapEventView.lua

module("modules.logic.survival.view.shelter.ShelterMapEventView", package.seeall)

local ShelterMapEventView = class("ShelterMapEventView", BaseView)

function ShelterMapEventView:onInitView()
	self._golist = gohelper.findChild(self.viewGO, "Panel/#go_list")
	self._eventItem = gohelper.findChild(self.viewGO, "Panel/#go_list/#go_item")

	gohelper.setActive(self._eventItem, false)

	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "Panel/Title/#txt_Title")
	self._btnNpc = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Title/#txt_Title/#btn_npc")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "Panel/#scroll/viewport/content/#txt_Descr")
	self._gobtn = gohelper.findChild(self.viewGO, "Panel/Btns")
	self._gobtnitem = gohelper.findChild(self.viewGO, "Panel/Btns/#go_btn")

	gohelper.setActive(self._gobtnitem, false)

	self._gopos1 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos2/#go_pos1")
	self._gopos2 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos2")
	self._gopos3 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos4/#go_pos3")
	self._gopos4 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos4")
	self._imageModel = gohelper.findChild(self.viewGO, "Panel/Left/#image_model")

	gohelper.setActive(gohelper.findChild(self.viewGO, "Top"), false)

	self._goinfo = gohelper.findChild(self.viewGO, "Panel/#go_info")
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_clicknext")
	self._click2 = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#scroll/viewport/#btn_clicknext2")
	self._goitemRoot = gohelper.findChild(self.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward")

	gohelper.setActive(self._goitemRoot, false)

	self._btns = {}

	self:initCamera()
end

function ShelterMapEventView:addEvents()
	self._click:AddClickListener(self.nextStep, self)
	self._click2:AddClickListener(self.nextStep, self)
	self._btnNpc:AddClickListener(self.showNpcInfo, self)
end

function ShelterMapEventView:removeEvents()
	self._click:RemoveClickListener()
	self._click2:RemoveClickListener()
	self._btnNpc:RemoveClickListener()
end

function ShelterMapEventView:showNpcInfo()
	ViewMgr.instance:openView(ViewName.SurvivalItemInfoView, {
		itemMo = self.itemMo,
		goPanel = self._goinfo
	})
end

function ShelterMapEventView:onOpen()
	self:refreshParam()
	self:refreshView()

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.SurvivalShelter then
		SurvivalMapHelper.instance:getSceneFogComp():setRainEnable(false)
	elseif sceneType == SceneType.Survival then
		SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(false)
	end
end

function ShelterMapEventView:refreshParam()
	self.title = self.viewParam.title
	self.behaviorConfig = self.viewParam.behaviorConfig
	self.unitResPath = self.viewParam.unitResPath
	self.itemMo = self.viewParam.itemMo
	self.conditionParam = self.viewParam.conditionParam
	self.taskConfig = self.viewParam.taskConfig
	self.moduleId = self.viewParam.moduleId

	if self.taskConfig and self.taskConfig.title then
		self.title = self.taskConfig.title
	end

	self.eventID = self.viewParam.eventID
end

function ShelterMapEventView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function ShelterMapEventView:refreshView()
	gohelper.setActive(self._btnNpc, self.itemMo ~= nil)

	self._txtTitle.text = self.title or ""

	self:refreshCamera()
	self:startDialog()
end

function ShelterMapEventView:startDialog()
	self.stepIndex = 0
	self._curDescIndex = 0
	self._txtDesc.text = ""
	self.curStepData = nil

	self:hideOption()
	self:nextStep()
end

function ShelterMapEventView:nextStep()
	if self.curStepData and self._curDescIndex < self.curStepData.descLen then
		self:finishStep()

		return
	end

	self.stepIndex = self.stepIndex + 1

	local stepCo = self:getStepCo(self.stepIndex)

	if not stepCo then
		self:finishDialog()

		return
	end

	local descArr = GameUtil.getUCharArrWithoutRichTxt(stepCo.content)

	self.curStepData = {
		descArr = descArr,
		descLen = #descArr,
		desc = stepCo.content,
		animType = stepCo.animType
	}

	gohelper.setActive(self._click, true)
	gohelper.setActive(self._click2, true)

	self._curDescIndex = 0

	TaskDispatcher.cancelTask(self._autoShowDesc, self)
	TaskDispatcher.runRepeat(self._autoShowDesc, self, 0.02)

	if not self.curStepData.animType then
		if self._modelComp then
			self._modelComp:playNextAnim(self.curStepData.animType)
		end
	end
end

function ShelterMapEventView:getStepCo(stepIndex)
	if self.taskConfig then
		if stepIndex > 1 then
			return
		end

		local stepCo = {}

		stepCo.content = self.taskConfig.desc
		stepCo.animType = 0

		return stepCo
	end

	local dialogId = self.behaviorConfig.dialogueId
	local dict = lua_survival_talk.configDict[dialogId]

	return dict and dict[stepIndex]
end

function ShelterMapEventView:finishStep()
	TaskDispatcher.cancelTask(self._autoShowDesc, self)

	if self.curStepData then
		self._txtDesc.text = self.curStepData.desc
		self._curDescIndex = self.curStepData.descLen
	end

	local nextStepCo = self:getStepCo(self.stepIndex + 1)

	if not nextStepCo then
		self:finishDialog()
	end
end

function ShelterMapEventView:finishDialog()
	if self.curStepData then
		self._txtDesc.text = self.curStepData.desc or ""
	end

	gohelper.setActive(self._click, false)
	gohelper.setActive(self._click2, false)
	self:showOption()

	self.curStepData = nil
end

function ShelterMapEventView:_autoShowDesc()
	if not self.curStepData then
		return
	end

	self._curDescIndex = self._curDescIndex + 1
	self._txtDesc.text = table.concat(self.curStepData.descArr, "", 1, self._curDescIndex)

	if self._curDescIndex >= self.curStepData.descLen then
		self:finishStep()
	end
end

function ShelterMapEventView:showOption()
	local optionDatas = self:getOptionDataList()

	for i = 1, math.max(#optionDatas, #self._btns) do
		local item = self:getBtnItem(i)

		item:updateData(optionDatas[i])
	end

	gohelper.setActive(self._gobtn, true)
end

function ShelterMapEventView:getOptionDataList()
	local optionDatas = {}
	local optionDescList, eventList

	if self.behaviorConfig then
		optionDescList = string.split(self.behaviorConfig.chooseDesc, "|")
		eventList = string.split(self.behaviorConfig.chooseEvent, "&")
	end

	if self.taskConfig then
		optionDescList = {
			luaLang("ShelterMapEventView_looktask")
		}
		eventList = {
			string.format("jumpTask#%s#%s", self.moduleId, self.taskConfig.id)
		}
	end

	if optionDescList then
		for i, v in ipairs(optionDescList) do
			local data = SurvivalChoiceMo.Create({
				callback = self.onClickOption,
				callobj = self,
				desc = v,
				param = eventList[i]
			})

			table.insert(optionDatas, data)
		end
	end

	return optionDatas
end

function ShelterMapEventView:getBtnItem(index)
	local item = self._btns[index]

	if not item then
		local go = gohelper.clone(self._gobtnitem, self["_gopos" .. index])

		gohelper.setAsFirstSibling(go)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalEventChoiceItem)
		self._btns[index] = item
	end

	return item
end

function ShelterMapEventView:hideOption()
	gohelper.setActive(self._gobtn, false)
end

function ShelterMapEventView:onClose()
	TaskDispatcher.cancelTask(self._autoShowDesc, self)
end

function ShelterMapEventView:onDestroyView()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType == SceneType.SurvivalShelter then
		SurvivalMapHelper.instance:getSceneFogComp():setRainEnable(true)
	elseif sceneType == SceneType.Survival then
		SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(true)
	end
end

function ShelterMapEventView:refreshCamera()
	local survival3DModelMO = Survival3DModelMO.New()

	survival3DModelMO:setDataByEventID(self.eventID, self.unitResPath)
	self._modelComp:setSurvival3DModelMO(survival3DModelMO)
end

function ShelterMapEventView:onClickOption(event)
	self:hideOption()

	self._eventIndex = 0
	self._eventList = GameUtil.splitString2(event, false) or {}

	self:_playNext()
end

function ShelterMapEventView:_playNext()
	self._eventIndex = self._eventIndex + 1

	local param = self._eventList[self._eventIndex]

	if not param then
		self:closeThis()

		return
	end

	local eventName = param[1]

	if eventName == "behavior" then
		self:gotoBehavior(tonumber(param[2]))

		return
	end

	if eventName == "acceptTask" then
		self:acceptTask()

		return
	end

	if eventName == "tipDialog" then
		TipDialogController.instance:openTipDialogView(tonumber(param[2]), self._playNext, self)

		return
	end

	if eventName == "jumpTask" then
		self:jumpTask(tonumber(param[2]), tonumber(param[3]))

		return
	end

	self:closeThis()
end

function ShelterMapEventView:jumpTask(moduleId, taskId)
	ViewMgr.instance:openView(ViewName.ShelterTaskView, {
		moduleId = moduleId,
		taskId = taskId
	})
	self:closeThis()
end

function ShelterMapEventView:gotoBehavior(behaviorId)
	local behaviorConfig = lua_survival_behavior.configDict[behaviorId]

	if not behaviorConfig then
		self:closeThis()

		return
	end

	if not SurvivalMapHelper.instance:isBehaviorMeetCondition(behaviorConfig.condition, self.conditionParam) then
		logError("ShelterMapEvent behavior condition not meet behaviorId = " .. behaviorId)
		self:closeThis()

		return
	end

	self.behaviorConfig = behaviorConfig

	self:startDialog()
end

function ShelterMapEventView:acceptTask()
	if self.itemMo then
		if self.behaviorConfig then
			local behaviorId = self.behaviorConfig.id

			if self.itemMo and behaviorId then
				SurvivalWeekRpc.instance:sendSurvivalNpcAcceptTaskRequest(self.itemMo, behaviorId)
			end

			self:closeThis()
		end
	end
end

function ShelterMapEventView:initCamera()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Survival then
		local mapCo = SurvivalMapModel.instance:getCurMapCo()
		local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(mapCo.exitPos.q, mapCo.exitPos.r)
		local customPos = Vector3(x, -1000, z)

		self._modelComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._imageModel, Survival3DModelComp, {
			customPos = customPos
		})
	else
		self._modelComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._imageModel, Survival3DModelComp)
	end
end

return ShelterMapEventView
