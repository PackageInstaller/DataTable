-- chunkname: @modules/logic/item/view/ItemTalentHeroUpView.lua

module("modules.logic.item.view.ItemTalentHeroUpView", package.seeall)

local ItemTalentHeroUpView = class("ItemTalentHeroUpView", BaseView)

function ItemTalentHeroUpView:onInitView()
	self._goclickmask = gohelper.findChild(self.viewGO, "clickmask")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._scrollup = gohelper.findChildScrollRect(self.viewGO, "#scroll_up")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content")
	self._gocapacity = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")
	self._txtleveluptip = gohelper.findChildText(self.viewGO, "leveluptip/tip")
	self._txtlevelup = gohelper.findChildText(self.viewGO, "leveluptip/tip/#txt_levelup")
	self._goeasoning = gohelper.findChild(self.viewGO, "esonan/#go_easoning")
	self._goesonan = gohelper.findChild(self.viewGO, "esonan/#go_esonan")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ItemTalentHeroUpView:addEvents()
	self.addClickCb(self, gohelper.getClick(self._goclickmask), self._closeSelf, self)
end

function ItemTalentHeroUpView:removeEvents()
	return
end

function ItemTalentHeroUpView:_editableInitView()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_success)
end

function ItemTalentHeroUpView:onUpdateParam()
	return
end

function ItemTalentHeroUpView:_closeSelf()
	if ServerTime.now() - self._openTime < 2 then
		return
	end

	self:closeThis()
end

ItemTalentHeroUpView.DebrisType = {
	Chess = 0,
	UnlockStyle = 5,
	Exclusive = 1,
	DebrisLevel = 3,
	DebrisCount = 2,
	DebrisCountAndLevel = 4
}

function ItemTalentHeroUpView:onOpen()
	self._openTime = ServerTime.now()
	self._heroId = self.viewParam
	self._heroMO = HeroModel.instance:getByHeroId(self._heroId)
	self._mainCubeId = self._heroMO.talentCubeInfos.own_main_cube_id

	self:_bootLogic(self._heroMO.talent, self._heroMO.talent - 1)
	TaskDispatcher.runDelay(self._playScrollTween, self, 1.2)
	TaskDispatcher.runDelay(self._playAttrAni, self, 1.2)

	local type = self._heroMO and self._heroMO:getTalentTxtByHeroType() or 1

	self._txtleveluptip.text = string.format(luaLang("herotalent_levelupresult_tip" .. type), self._heroMO.config.name)

	gohelper.setActive(self._goeasoning, self._heroMO.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(self._goesonan, self._heroMO.config.heroType ~= CharacterEnum.HumanHeroType)
end

function ItemTalentHeroUpView:_bootLogic(targetLv, lastLv)
	self._targetLv = targetLv
	self._lastLv = lastLv

	local lastTalentCo = HeroResonanceConfig.instance:getTalentConfig(self._heroMO.heroId, lastLv) or {}
	local targetTalentCo = HeroResonanceConfig.instance:getTalentConfig(self._heroMO.heroId, targetLv)

	self._lastModelCo = HeroResonanceConfig.instance:getTalentModelConfig(self._heroMO.heroId, lastLv) or {}
	self._targetModelCo = HeroResonanceConfig.instance:getTalentModelConfig(self._heroMO.heroId, targetLv)

	gohelper.setActive(self._goContent, self._targetModelCo ~= nil)

	if not self._targetModelCo then
		return
	end

	local dataList = {}
	local _isUnlockStyle = TalentStyleModel.instance:getLevelUnlockStyle(self._mainCubeId, targetLv)

	if _isUnlockStyle then
		table.insert(dataList, {
			upType = ItemTalentHeroUpView.DebrisType.UnlockStyle
		})
	end

	if self._targetModelCo.allShape ~= self._lastModelCo.allShape then
		table.insert(dataList, {
			upType = ItemTalentHeroUpView.DebrisType.Chess,
			value = self._targetModelCo.allShape
		})
	end

	if targetTalentCo.exclusive ~= lastTalentCo.exclusive then
		local gainTab = {}
		local targetValueTab = {}
		local lastValueTab = {}
		local lastArr = string.splitToNumber(lastTalentCo.exclusive, "#") or {}
		local targetArr = string.splitToNumber(targetTalentCo.exclusive, "#") or {}

		for index, value in ipairs(targetArr) do
			if value ~= lastArr[index] then
				gainTab[index] = value - (lastArr[index] or 0)
			end

			targetValueTab[index] = value
			lastValueTab[index] = lastArr[index]
		end

		if not string.nilorempty(targetTalentCo.exclusive) then
			table.insert(dataList, {
				cubeId = targetArr[1],
				upType = ItemTalentHeroUpView.DebrisType.Exclusive,
				newDebris = #lastArr == 0,
				value = gainTab,
				targetValueTab = targetValueTab,
				lastValueTab = lastValueTab
			})
		end
	end

	for i = 10, 20 do
		local tempType = "type" .. i
		local lastValue = self._lastModelCo[tempType]
		local targetValue = self._targetModelCo[tempType]

		if lastValue ~= targetValue and not string.nilorempty(targetValue) then
			local gainTab = {}
			local targetValueTab = {}
			local lastValueTab = {}
			local lastArr = string.splitToNumber(lastValue, "#") or {}
			local targetArr = string.splitToNumber(targetValue, "#") or {}

			for index, value in ipairs(targetArr) do
				if value ~= lastArr[index] then
					gainTab[index] = value - (lastArr[index] or 0)
				end

				targetValueTab[index] = value
				lastValueTab[index] = lastArr[index]
			end

			local upType

			if gainTab[1] then
				upType = gainTab[2] and ItemTalentHeroUpView.DebrisType.DebrisCountAndLevel or ItemTalentHeroUpView.DebrisType.DebrisCount
			elseif gainTab[2] then
				upType = ItemTalentHeroUpView.DebrisType.DebrisLevel
			end

			table.insert(dataList, {
				cubeId = i,
				upType = upType,
				newDebris = #lastArr == 0,
				value = gainTab,
				targetValueTab = targetValueTab,
				lastValueTab = lastValueTab
			})
		end
	end

	self._objList = self:getUserDataTb_()
	self._attrAnimTab = self:getUserDataTb_()
	self._burstEffAttrTab = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onItemShow, dataList, self._goContent, self._gocapacity)

	self._txtlevelup.text = string.format("LV.<size=80>%s", self._targetLv)
end

function ItemTalentHeroUpView:_playScrollTween()
	self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
	self._parallelSeq = self._parallelSeq or FlowParallel.New()

	for i, v in ipairs(self._objList) do
		local posY = recthelper.getAnchorY(v)

		recthelper.setAnchorY(v, posY - 200)

		local tweenSeq = FlowSequence.New()

		tweenSeq:addWork(WorkWaitSeconds.New(0.03 * (i - 1)))

		local paraller = FlowParallel.New()

		paraller:addWork(TweenWork.New({
			type = "DOAnchorPosY",
			t = 0.33,
			tr = v,
			to = posY,
			ease = EaseType.OutQuart
		}))
		paraller:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.6,
			go = v.gameObject
		}))
		tweenSeq:addWork(paraller)

		if i == #self._objList then
			tweenSeq:addWork(FunctionWork.New(function()
				self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
			end))
		end

		self._parallelSeq:addWork(tweenSeq)
	end

	self._parallelSeq:start({})
end

function ItemTalentHeroUpView:_playAttrAni()
	self._parallelAttrSeq = self._parallelAttrSeq or FlowParallel.New()

	for i = 1, #self._attrAnimTab do
		local flow = FlowParallel.New()

		for index, attr in ipairs(self._attrAnimTab[i]) do
			local tweenSeq = FlowSequence.New()

			tweenSeq:addWork(WorkWaitSeconds.New(0.06 * (index - 1)))

			local paraller = FlowParallel.New()

			paraller:addWork(FunctionWork.New(function()
				gohelper.findChildComponent(attr, "", gohelper.Type_CanvasGroup).alpha = 1
				gohelper.findChildComponent(attr, "", typeof(UnityEngine.Animator)).enabled = true

				gohelper.setActive(gohelper.findChild(attr, "#new"), self._burstEffAttrTab[i][index])
			end))
			tweenSeq:addWork(paraller)
			flow:addWork(tweenSeq)
		end

		self._parallelAttrSeq:addWork(flow)
	end

	self._parallelAttrSeq:start({})
end

local specialType = {
	ItemTalentHeroUpView.DebrisType.Chess,
	ItemTalentHeroUpView.DebrisType.UnlockStyle
}

function ItemTalentHeroUpView:_onItemShow(obj, data, index)
	self._attrAnimTab[index] = self:getUserDataTb_()
	self._burstEffAttrTab[index] = self:getUserDataTb_()
	obj.name = data.cubeId or "shape"

	local transform = obj.transform
	local icon = transform:Find("cell/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	local iconBg = transform:Find("cell/cell_bg"):GetComponent(gohelper.Type_Image)
	local goStyle = transform:Find("info/go_style").gameObject
	local txtStyle = transform:Find("info/go_style/txt_unlocked"):GetComponent(gohelper.Type_TextMesh)
	local goCapacityTip = transform:Find("info/go_capacityTip").gameObject
	local goNumTip = transform:Find("info/go_numTip").gameObject
	local goNew = transform:Find("cell/go_new").gameObject
	local attr = transform:Find("info/attr").gameObject
	local goLevel = transform:Find("info/go_level").gameObject
	local txtCubeLevel = transform:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh)
	local txtCubeAddLevel = transform:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh)
	local isNormal = not LuaUtil.tableContains(specialType, data.upType)

	gohelper.setActive(goCapacityTip, data.upType == ItemTalentHeroUpView.DebrisType.Chess)
	gohelper.setActive(goNumTip, isNormal and data.upType == ItemTalentHeroUpView.DebrisType.DebrisCount)
	gohelper.setActive(goNew, isNormal and data.newDebris)
	gohelper.setActive(attr, isNormal)
	gohelper.setActive(goStyle, data.upType == ItemTalentHeroUpView.DebrisType.UnlockStyle)

	local talentStr = luaLang("talent_style_title_cn_" .. self._heroMO:getTalentTxtByHeroType())

	txtStyle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", talentStr)

	if data.upType == ItemTalentHeroUpView.DebrisType.Exclusive then
		gohelper.setActive(goLevel, true)

		txtCubeLevel.text = "LV." .. data.targetValueTab[2]
		txtCubeAddLevel.text = "+" .. data.value[2]
	elseif data.upType == ItemTalentHeroUpView.DebrisType.DebrisLevel then
		gohelper.setActive(goLevel, true)

		txtCubeLevel.text = "LV." .. data.targetValueTab[2]
		txtCubeAddLevel.text = "+" .. data.value[2]
	elseif data.upType == ItemTalentHeroUpView.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(goLevel, true)

		txtCubeLevel.text = "LV." .. data.targetValueTab[2]
		txtCubeAddLevel.text = "+" .. data.value[2]
	else
		gohelper.setActive(goLevel, false)
	end

	if data.newDebris then
		txtCubeAddLevel.text = ""
	end

	if goLevel.activeInHierarchy then
		table.insert(self._attrAnimTab[index], goLevel)
		table.insert(self._burstEffAttrTab[index], false)
	end

	if goCapacityTip.activeInHierarchy then
		table.insert(self._attrAnimTab[index], goCapacityTip)
		table.insert(self._burstEffAttrTab[index], false)
	end

	if goNumTip.activeInHierarchy then
		table.insert(self._attrAnimTab[index], goNumTip)
		table.insert(self._burstEffAttrTab[index], false)
	end

	for i, v in ipairs(self._attrAnimTab[index]) do
		gohelper.findChildComponent(v, "", typeof(UnityEngine.Animator)).enabled = false
		gohelper.findChildComponent(v, "", gohelper.Type_CanvasGroup).alpha = 0
	end

	if data.upType == ItemTalentHeroUpView.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, "icon_danao", true)

		iconBg.enabled = false
		goCapacityTip.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		goCapacityTip.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(self._lastModelCo.allShape, ",", luaLang("multiple"))
		goCapacityTip.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(data.value, ",", luaLang("multiple"))

		local starData = {}
		local maxShapeLv = HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(self._heroMO.heroId)
		local targetShapeLv = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(self._heroMO.heroId, self._targetLv)

		for i = 1, maxShapeLv do
			starData[i] = {}
			starData[i].cur_level = targetShapeLv
		end
	elseif data.upType == ItemTalentHeroUpView.DebrisType.UnlockStyle then
		-- block empty
	else
		local targetAttrCo = HeroConfig.instance:getTalentCubeAttrConfig(data.cubeId, data.targetValueTab[2])

		if not targetAttrCo then
			logError(data.cubeId, data.targetValueTab[2])
		end

		local starData = {}

		for i = 1, HeroConfig.instance:getTalentCubeMaxLevel(data.cubeId) do
			starData[i] = {}
			starData[i].cur_level = targetAttrCo.level
		end

		if data.upType == ItemTalentHeroUpView.DebrisType.DebrisCount or data.upType == ItemTalentHeroUpView.DebrisType.DebrisCountAndLevel then
			goNumTip.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			goNumTip.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = data.targetValueTab[1]
			goNumTip.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. data.value[1]
		end

		local attrTargetTab = {}

		self._heroMO:getTalentStyleCubeAttr(data.cubeId, attrTargetTab, nil, nil, data.targetValueTab[2])

		local attrLastTab = {}

		if (data.upType == ItemTalentHeroUpView.DebrisType.Exclusive or data.upType == ItemTalentHeroUpView.DebrisType.DebrisCountAndLevel or data.upType == ItemTalentHeroUpView.DebrisType.DebrisLevel) and data.lastValueTab[2] then
			self._heroMO:getTalentStyleCubeAttr(data.cubeId, attrLastTab, nil, nil, data.lastValueTab[2] or 0)
		end

		local tempList = {}
		local lastAttrCo = HeroConfig.instance:getTalentCubeAttrConfig(data.cubeId, data.lastValueTab[2])

		lastAttrCo = lastAttrCo or targetAttrCo

		for k, v in pairs(attrTargetTab) do
			local addValue = 0
			local isNewAttr = false

			if attrLastTab[k] then
				addValue = v - attrLastTab[k]
			else
				isNewAttr = true
			end

			table.insert(tempList, {
				isNewAttr = isNewAttr,
				debrisIndex = index,
				key = k,
				value = v,
				addValue = addValue,
				isSp = targetAttrCo.calculateType == 1,
				config = targetAttrCo,
				lastAttrCo = lastAttrCo
			})
		end

		table.sort(tempList, function(item1, item2)
			return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
		end)
		gohelper.CreateObjList(self, self._onShowSingleCubeAttr, tempList, attr, attr.transform:Find("go_attrItem").gameObject)

		local spName = HeroResonanceConfig.instance:getCubeConfig(data.cubeId).icon
		local tempAttr = string.split(spName, "_")
		local cubeBg = "gz_" .. tempAttr[#tempAttr]

		if self._mainCubeId == data.cubeId then
			local cubeId = self._heroMO:getHeroUseStyleCubeId()

			if cubeId ~= self._mainCubeId then
				local co = HeroResonanceConfig.instance:getCubeConfig(cubeId)

				if co then
					local icon = co.icon

					if not string.nilorempty(icon) then
						spName = "mk_" .. icon
						cubeBg = cubeBg .. "_2"
					end
				end
			end
		end

		iconBg.enabled = true

		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, spName, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(iconBg, cubeBg, true)
	end

	table.insert(self._objList, transform)

	if data.upType ~= ItemTalentHeroUpView.DebrisType.Chess and data.newDebris then
		self:_setNewTipPos(goNew, data.cubeId)
	end
end

function ItemTalentHeroUpView:_setNewTipPos(goNew, cubeId)
	local shapeConfig = HeroResonanceConfig.instance:getCubeConfig(cubeId).shape

	if shapeConfig == nil then
		return
	end

	local firtLineConfig = string.split(shapeConfig, "#")[1]
	local singleCubeConfig = string.splitToNumber(firtLineConfig, ",")
	local isRightEmpty = singleCubeConfig[#singleCubeConfig] == 0

	recthelper.setAnchorY(goNew.transform, isRightEmpty and 1.4 or 13.3)
end

function ItemTalentHeroUpView:_onShowSingleCubeAttr(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local value = transform:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local addvalue = transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	local tempAddValue = data.addValue

	if config.type ~= 1 then
		data.value = data.value / 10 .. "%"
		data.addValue = data.addValue / 10 .. "%"
	elseif not data.isSp then
		data.value = data.config[data.key] / 10 .. "%"
		data.addValue = (data.config[data.key] - data.lastAttrCo[data.key]) / 10 .. "%"
	else
		data.value = math.floor(data.value)
		data.addValue = math.floor(data.addValue)
	end

	value.text = data.value
	addvalue.text = tempAddValue == 0 and "" or "+" .. data.addValue
	gohelper.findChildComponent(obj, "", typeof(UnityEngine.Animator)).enabled = false
	gohelper.findChildComponent(obj, "", gohelper.Type_CanvasGroup).alpha = 0

	table.insert(self._attrAnimTab[data.debrisIndex], obj)
	table.insert(self._burstEffAttrTab[data.debrisIndex], data.isNewAttr)
end

function ItemTalentHeroUpView:onClose()
	if self._parallelSeq then
		self._parallelSeq:destroy()
	end

	if self._parallelAttrSeq then
		self._parallelAttrSeq:destroy()
	end

	TaskDispatcher.cancelTask(self._playScrollTween, self)
	TaskDispatcher.cancelTask(self._playAttrAni, self)
end

function ItemTalentHeroUpView:onDestroyView()
	return
end

return ItemTalentHeroUpView
