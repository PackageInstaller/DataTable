-- chunkname: @modules/logic/survival/view/map/SurvivalMapEventView.lua

module("modules.logic.survival.view.map.SurvivalMapEventView", package.seeall)

local SurvivalMapEventView = class("SurvivalMapEventView", BaseView)

function SurvivalMapEventView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._golist = gohelper.findChild(self.viewGO, "Panel/#go_list")
	self._eventItem = gohelper.findChild(self.viewGO, "Panel/#go_list/#go_item")
	self._txtTitle = gohelper.findChildTextMesh(self.viewGO, "Panel/Title/#txt_Title")
	self._btnNpc = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Title/#txt_Title/#btn_npc")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "Panel/#scroll/viewport/content/#txt_Descr")
	self._gobtn = gohelper.findChild(self.viewGO, "Panel/Btns")
	self._gobtnitem = gohelper.findChild(self.viewGO, "Panel/Btns/#go_btn")
	self._gopos1 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos2/#go_pos1")
	self._gopos2 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos2")
	self._gopos3 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos4/#go_pos3")
	self._gopos4 = gohelper.findChild(self.viewGO, "Panel/Btns/#go_pos4")
	self._imageModel = gohelper.findChild(self.viewGO, "Panel/Left/#image_model")
	self._goinfo = gohelper.findChild(self.viewGO, "Panel/#go_info")
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_clicknext")
	self._click2 = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#scroll/viewport/#btn_clicknext2")
	self._goitemRoot = gohelper.findChild(self.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward")
	self._goitem = gohelper.findChild(self.viewGO, "Panel/#scroll/viewport/content/#scroll_Reward/Viewport/Content/#go_rewarditem")
end

function SurvivalMapEventView:addEvents()
	self._click:AddClickListener(self.nextStep, self)
	self._click2:AddClickListener(self.nextStep, self)
	self._btnNpc:AddClickListener(self.showNpcInfo, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEventViewSelectChange, self.onEventSelectChange, self)
end

function SurvivalMapEventView:removeEvents()
	self._click:RemoveClickListener()
	self._click2:RemoveClickListener()
	self._btnNpc:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapUnitDel, self._onUnitDel, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEventViewSelectChange, self.onEventSelectChange, self)
end

function SurvivalMapEventView:onOpen()
	local isFirst = true

	if not self._infoPanel then
		local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
		local infoGo = self:getResInst(infoViewRes, self._goinfo)

		self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

		self._infoPanel:updateMo()
		self._infoPanel:setCloseShow(true)
		gohelper.setActive(self._goitemRoot, false)
		gohelper.setActive(self._gobtnitem, true)

		self._btns = {}

		for i = 1, 4 do
			local go = gohelper.clone(self._gobtnitem, self["_gopos" .. i])

			gohelper.setAsFirstSibling(go)

			self._btns[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalEventChoiceItem)
		end

		gohelper.setActive(self._gobtnitem, false)
		self:initCamera()
	else
		isFirst = false
	end

	SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(false)
	self:_refreshView()

	if isFirst and self._panelUnitMo then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	end
end

function SurvivalMapEventView:onUpdateParam()
	self:_refreshView()
end

function SurvivalMapEventView:_refreshView()
	if self.viewParam.panel then
		self._curMo = nil

		gohelper.setActive(self._golist, false)
		self:updateChoiceByServer()
	else
		gohelper.setActive(self._golist, true)
		gohelper.setActive(self._click, false)
		gohelper.setActive(self._click2, false)
		gohelper.setActive(self._gobtn, true)
		gohelper.setActive(self._goitemRoot, false)
		gohelper.CreateObjList(self, self._createEventItem, self.viewParam.allUnitMo, nil, self._eventItem, SurvivalEventViewItem)
		self:onEventSelectChange(1)
	end
end

function SurvivalMapEventView:_createEventItem(obj, data, index)
	obj:initData(data, index)
end

function SurvivalMapEventView:onEventSelectChange(index)
	if self._curMo and self._curMo ~= self.viewParam.allUnitMo[index] then
		self._curMo = self.viewParam.allUnitMo[index]
		self._anim.enabled = true

		self._anim:Play("switch", 0, 0)
		UIBlockHelper.instance:startBlock("SurvivalMapEventView_onEventSelectChange", 0.167)
		TaskDispatcher.runDelay(self.refreshView, self, 0.167)
	else
		self._curMo = self.viewParam.allUnitMo[index]

		self:refreshView()
	end
end

function SurvivalMapEventView:_onUnitDel(unitMo)
	local curUnitId

	if (self.viewParam.panel and self.viewParam.panel.unitId or self._curMo.id) == unitMo.id then
		self:closeThis()
	end
end

function SurvivalMapEventView:refreshView()
	if self._curMo and self._curMo.co then
		self:setUnitMo(self._curMo)

		self._txtTitle.text = self._curMo.co.name
		self._txtDesc.text = self._curMo.co.desc

		if not self["getChoiceData" .. SurvivalEnum.UnitTypeToName[self._curMo.unitType]] then
			-- block empty
		end
	end

	::label_10_2::
end

function SurvivalMapEventView:getChoiceDataSearch()
	local isSearched = self._curMo:isSearched()
	local datas = self:getChoiceDataDefault()

	if datas[1] then
		if isSearched then
			datas[1].conditionStr = nil
			datas[1].resultStr = nil
		end

		datas[1].icon = SurvivalEnum.EventChoiceIcon.Search

		datas[1]:refreshData()
	end

	return datas
end

function SurvivalMapEventView:getChoiceDataDefault()
	local datas = {}

	if not string.nilorempty(self._curMo.co.choiceText) then
		local desc = string.split(self._curMo.co.choiceText, "#")
		local consume = string.splitToNumber(self._curMo.co.consume, "#") or {}

		if consume[1] then
			local isCostTime = consume[1] > 0
			local conditionStr, resultStr

			datas[1] = SurvivalChoiceMo.Create({
				callback = self.onClickOption,
				callobj = self,
				desc = desc[1],
				conditionStr = conditionStr,
				resultStr = (isCostTime or nil) and "CostGameTime|" .. consume[1]
			})
			datas[2] = SurvivalChoiceMo.Create({
				callback = self.closeThis,
				callobj = self,
				desc = desc[2]
			})
		end
	end

	return datas
end

function SurvivalMapEventView:setBtnDatas(datas)
	for i = 1, 4 do
		self._btns[i]:updateData(datas[i])
	end
end

function SurvivalMapEventView:onClickOption()
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.TriggerEvent, tostring(self._curMo.id))
	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", self._curMo.id, 1, 0)
end

function SurvivalMapEventView:updateChoiceByServer(isByClient)
	local panel = self.viewParam.panel
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local unitId = panel.unitId
	local unitMo = sceneMo.unitsById[unitId]

	self._panelUnitMo = unitMo

	if not unitMo then
		logError("元件数据不存在" .. tostring(unitId))

		return
	end

	local dialogId = panel.dialogueId
	local talkCo = lua_survival_talk.configDict[dialogId]

	if not talkCo then
		logError("对话不存在" .. tostring(dialogId))

		return
	end

	self:setUnitMo(unitMo)

	self._stepList = {}
	self._curDescIndex = 0
	self._curStepCo = nil

	if isByClient then
		local stepCo = talkCo[#talkCo]

		table.insert(self._stepList, {
			descArr = GameUtil.getUCharArrWithoutRichTxt(stepCo.content),
			animType = stepCo.animType
		})
	else
		for _, stepCo in ipairs(talkCo) do
			table.insert(self._stepList, {
				descArr = GameUtil.getUCharArrWithoutRichTxt(stepCo.content),
				animType = stepCo.animType
			})
		end
	end

	self._txtTitle.text = unitMo.co.name
	self._txtDesc.text = ""

	local datas = {}

	for index, param in ipairs(panel.param) do
		local arr = string.split(param, "|") or {}
		local id = tonumber(arr[1]) or 0
		local otherParam = arr[2] and table.concat(arr, "|", 2) or ""
		local optionCo = lua_survival_tree_desc.configDict[panel.treeId][id]
		local desc = optionCo and optionCo.desc

		datas[index] = SurvivalChoiceMo.Create({
			callback = self.onClickServerChoice,
			callobj = self,
			desc = desc,
			param = id,
			icon = optionCo.icon,
			conditionStr = optionCo.condition,
			resultStr = optionCo.result,
			unitId = unitId,
			treeId = panel.treeId,
			otherParam = otherParam
		})

		if datas[index].isShowBogusBtn then
			datas[index].callback = self.onClickBogusBtn
			datas[index].exStr_bogus = datas[index].exStr
			datas[index].isValid_bogus = datas[index].isValid
			datas[index].exStr = nil
			datas[index].isValid = true
		elseif datas[index].exStepDesc then
			local lastStep = self._stepList[#self._stepList]

			if lastStep then
				table.insert(lastStep.descArr, "\n")
				tabletool.addValues(lastStep.descArr, GameUtil.getUCharArrWithoutRichTxt(datas[index].exStepDesc))

				lastStep.items = datas[index].exShowItemMos
			else
				table.insert(self._stepList, {
					descArr = GameUtil.getUCharArrWithoutRichTxt(datas[index].exStepDesc),
					items = datas[index].exShowItemMos
				})
			end
		end
	end

	gohelper.setActive(self._gobtn, false)
	self:setBtnDatas(datas)
	self:nextStep()
end

function SurvivalMapEventView:nextStep()
	if not self._stepList then
		return
	end

	if self._curStepCo then
		self:finishStep()

		return
	end

	gohelper.setActive(self._click, true)
	gohelper.setActive(self._click2, true)

	self._curStepCo = table.remove(self._stepList, 1)

	if self._curStepCo then
		gohelper.setActive(self._goitemRoot, false)

		self._curDescIndex = 0

		TaskDispatcher.runRepeat(self._autoShowDesc, self, 0.02)
	else
		gohelper.setActive(self._click, false)
		gohelper.setActive(self._click2, false)
		gohelper.setActive(self._gobtn, true)
	end

	if self._curStepCo then
		if not self._curStepCo.animType then
			local animType = 0

			if self._modelComp then
				self._modelComp:playNextAnim(animType)
			end
		end
	end
end

function SurvivalMapEventView:_autoShowDesc()
	if not self._curStepCo then
		return
	end

	self._curDescIndex = self._curDescIndex + 1
	self._txtDesc.text = table.concat(self._curStepCo.descArr, "", 1, self._curDescIndex)

	if self._curDescIndex >= #self._curStepCo.descArr then
		self:finishStep()
	end
end

function SurvivalMapEventView:finishStep()
	self._txtDesc.text = table.concat(self._curStepCo.descArr, "")

	TaskDispatcher.cancelTask(self._autoShowDesc, self)

	if not self._stepList[1] then
		gohelper.setActive(self._click, false)
		gohelper.setActive(self._click2, false)
		gohelper.setActive(self._gobtn, true)
	end

	if self._curStepCo.items then
		gohelper.setActive(self._goitemRoot, true)
		gohelper.CreateObjList(self, self._createItem, self._curStepCo.items, nil, self._goitem)
	else
		gohelper.setActive(self._goitemRoot, false)
	end

	self._curStepCo = nil
end

function SurvivalMapEventView:_createItem(obj, data, index)
	local itemGo = gohelper.findChild(obj, "go_icon/inst")
	local txtNum = gohelper.findChildTextMesh(obj, "#txt_Num")
	local gogray = gohelper.findChild(obj, "#go_gray")
	local bagItem

	if not itemGo then
		local itemRes = self.viewContainer:getSetting().otherRes.itemRes

		itemGo = self:getResInst(itemRes, gohelper.findChild(obj, "go_icon"), "inst")
		bagItem = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SurvivalBagItem)
	else
		bagItem = MonoHelper.getLuaComFromGo(itemGo, SurvivalBagItem)
	end

	bagItem:updateMo(data)
	bagItem:setShowNum(false)
	bagItem:setClickCallback(self._onClickItem, self)

	local count = SurvivalMapHelper.instance:getBagMo():getItemCountPlus(data.id)

	gohelper.setActive(gogray, count < data.count)

	local countTxt = self:numberDisplay(count)

	txtNum.text = count >= data.count and countTxt .. "/" .. data.count or "<color=#D74242>" .. countTxt .. "</color>/" .. data.count
end

function SurvivalMapEventView:numberDisplay(number)
	local num = tonumber(number)

	if num >= 1000000 then
		return math.floor(num / 100000) / 10 .. "M"
	elseif num >= 1000 then
		return math.floor(num / 100) / 10 .. "K"
	else
		return num
	end
end

function SurvivalMapEventView:_onClickItem(item)
	local newMo = item._mo:clone()

	newMo.count = 1

	self._infoPanel:updateMo(newMo)
end

function SurvivalMapEventView:showNpcInfo()
	self._infoPanel:updateMo(self._npcItemMo)
end

function SurvivalMapEventView:onClose()
	TaskDispatcher.cancelTask(self._autoShowDesc, self)
	TaskDispatcher.cancelTask(self.refreshView, self)

	if self.searchAudioId then
		AudioMgr.instance:stopPlayingID(self.searchAudioId)

		self.searchAudioId = nil
	end
end

function SurvivalMapEventView:onCloseFinish()
	SurvivalMapHelper.instance:getSceneFogComp():setFogEnable(true)
end

function SurvivalMapEventView:onClickServerChoice(id, data)
	if data and data.npcWorthCheck then
		ViewMgr.instance:openView(ViewName.SurvivalCommitItemView, data)

		return
	end

	if data and data.openFogRange then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnTreeOpenFog, data)
		self:closeThis()

		return
	end

	if SurvivalMapHelper.instance:isInFlow() then
		return
	end

	SurvivalStatHelper.instance:statSurvivalMapUnit("SelectOption", data.unitId, id, data.treeId)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.SelectOption, tostring(id))
end

function SurvivalMapEventView:onClickBogusBtn(id, data)
	self._stepList = {}
	self._curDescIndex = 0
	self._curStepCo = nil
	self._txtDesc.text = ""

	local datas = {}

	datas[1] = data

	if data.exBogusData then
		data.exStr_bogus = data.exBogusData.exStr
		data.isValid_bogus = data.exBogusData.isValid
		data.exShowItemMos_bogus = data.exBogusData.exShowItemMos
		data.exStepDesc_bogus = data.exBogusData.exStepDesc
		data.exBogusData = nil
		data.useExBogusData = true
	else
		data.exStr = data.exStr_bogus
		data.isValid = data.isValid_bogus

		if data.useExBogusData then
			data.exShowItemMos = data.exShowItemMos_bogus
			data.exStepDesc = data.exStepDesc_bogus
			data.useExBogusData = nil
		end

		data.callback = self.onClickServerChoice
	end

	datas[2] = SurvivalChoiceMo.Create({
		param = true,
		callback = self.updateChoiceByServer,
		callobj = self,
		desc = luaLang("survival_eventview_leave"),
		icon = SurvivalEnum.EventChoiceIcon.Return
	})

	table.insert(self._stepList, {
		descArr = GameUtil.getUCharArrWithoutRichTxt(data.exStepDesc),
		items = data.exShowItemMos
	})
	gohelper.setActive(self._gobtn, false)
	self:setBtnDatas(datas)
	self:nextStep()
end

function SurvivalMapEventView:initCamera()
	local mapCo = SurvivalMapModel.instance:getCurMapCo()
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(mapCo.exitPos.q, mapCo.exitPos.r)
	local customPos = Vector3(x, -1000, z)

	self._modelComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._imageModel, Survival3DModelComp, {
		customPos = customPos
	})
end

function SurvivalMapEventView:setUnitMo(unitMo)
	gohelper.setActive(self._btnNpc, unitMo.unitType == SurvivalEnum.UnitType.NPC)

	if unitMo.unitType == SurvivalEnum.UnitType.NPC then
		self._npcItemMo = SurvivalBagItemMo.New()

		local itemCo = SurvivalConfig.instance.npcIdToItemCo[unitMo.cfgId]
		local var_28_0 = {
			count = 1
		}

		if itemCo then
			var_28_0.id = itemCo.id or 0
		end

		self._npcItemMo:init(var_28_0)
	end

	local survival3DModelMO = Survival3DModelMO.New()

	survival3DModelMO:setDataByUnitMo(unitMo)
	self._modelComp:setSurvival3DModelMO(survival3DModelMO)
end

return SurvivalMapEventView
