-- chunkname: @modules/logic/gm/view/GMSubViewArcade.lua

module("modules.logic.gm.view.GMSubViewArcade", package.seeall)

local GMSubViewArcade = class("GMSubViewArcade", GMSubViewBase)

function GMSubViewArcade:ctor()
	self.tabName = "街机秀"
end

function GMSubViewArcade:addEvents()
	self.addEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._resetPortalList, self)
end

function GMSubViewArcade:removeEvents()
	self.removeEventCb(self, ArcadeGameController.instance, ArcadeEvent.OnChangeArcadeRoomFinish, self._resetPortalList, self)
end

function GMSubViewArcade:initViewContent()
	if self._isInit then
		return
	end

	self._isInit = true

	self:_initL1()
	self:_initL2()
	self:_initL3()
	self:_initL4()
	self:_initL8()
	self:_initL9()
	self:_initL7()
	self:_initL6()
	self:_initL5()
end

function GMSubViewArcade:_initL1()
	local LStr = "L1"

	self:addLabel(LStr, "怪物Id")

	self._addMonsterText = self:addInputText(LStr, nil, "怪物id[#x#y]")

	self.addButton(self, LStr, "添加怪物", self._addMonsterId, self)
	self:addLabel(LStr, "藏品Id")

	self._actCollectionId = self:addInputText(LStr, nil, "藏品Id")

	self.addButton(self, LStr, "添加藏品", self._addCollectionId, self)
end

function GMSubViewArcade:_addCollectionId()
	local collectionId = tonumber(self._actCollectionId:GetText())

	if collectionId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getCollectionCfg(collectionId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在藏品id:[%s]", collectionId))

		return
	end

	local collectionMO = ArcadeGameController.instance:gainCollection(collectionId, Vector3.zero)

	if collectionMO then
		GameFacade.showToast(ToastEnum.IconId, string.format("成功[%s-%s]", cfg.name, collectionId))
	else
		GameFacade.showToast(ToastEnum.IconId, string.format("失败"))
	end
end

function GMSubViewArcade:_addMonsterId()
	local text = self._addMonsterText:GetText()
	local textArr = string.splitToNumber(text, "#")
	local monsterId = textArr[1]

	if monsterId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getMonsterCfg(monsterId)

	if not cfg then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在怪物id:%s", monsterId))

		return
	end

	local isSuccess, gridX, gridY = ArcadeGameSummonController.instance:summonMonster(monsterId, textArr[2], textArr[3])

	if isSuccess then
		GameFacade.showToast(ToastEnum.IconId, string.format("成功[%s-%s](%s,%s)", cfg.name, monsterId, gridX, gridY))
	else
		GameFacade.showToast(ToastEnum.IconId, string.format("没有空位"))
	end
end

function GMSubViewArcade:_initL2()
	local LStr = "L2"

	self:addLabel(LStr, "技能Id")

	self._skillIdInputText = self:addInputText(LStr, nil, "技能Id")

	self.addButton(self, LStr, "使用技能", self._onClickUseSkillOk, self)
	self:addLabel(LStr, "跳转房间")

	self._arcadeRoomInputText = self:addInputText(LStr, nil, "房间Id")

	self.addButton(self, LStr, "跳转", self._changeRoom, self)
end

function GMSubViewArcade:_onClickUseSkillOk()
	local skillId = tonumber(self._skillIdInputText:GetText())

	if not skillId or skillId == 0 then
		GameFacade.showToast(ToastEnum.IconId, "请输入技能ID")

		return
	end

	if self:_isLockClick() then
		return
	end

	local target = ArcadeGameModel.instance:getCharacterMO()
	local context = {
		target = target
	}

	context.hiterList = {}
	context.atker = target

	ArcadeGameSkillController.instance:useSkill(target, skillId, context)
end

function GMSubViewArcade:_isLockClick()
	if self._nextUnLockTime and self._nextUnLockTime > Time.time then
		GameFacade.showToast(ToastEnum.IconId, "点击太快了")

		return true
	end

	self._nextUnLockTime = Time.time + 0.2

	return false
end

function GMSubViewArcade:_initL3()
	local LStr = "L3"

	self:addLabel(LStr, "技能效果")

	self._skillHitInputText = self:addInputText(LStr, nil, "效果配置")

	self.addButton(self, LStr, "确定效果", self._onClickSkillHitOk, self)
	self.addButton(self, LStr, "检查技能配置", self._onClickCheckSkillOk, self)
	self.addButton(self, LStr, "局外GM", self._openGMArcadeView, self)
end

function GMSubViewArcade:_onClickSkillHitOk()
	local hitStr = self._skillHitInputText:GetText()

	if string.nilorempty(hitStr) then
		GameFacade.showToast(ToastEnum.IconId, "请输入技能效果")

		return
	end

	if self:_isLockClick() then
		return
	end

	local hitBase = ArcadeSkillFactory.instance:createSkillHit(hitStr)
	local target = ArcadeGameModel.instance:getCharacterMO()
	local context = {
		target = target
	}

	context.hiterList = {}
	context.atker = target

	hitBase:hit(context)
	GameFacade.showToast(ToastEnum.IconId, "run hitBase: " .. hitBase.__cname)
end

local xpcall = xpcall
local __G__TRACKBACK__ = __G__TRACKBACK__

local function _createSkillFunc(skillId)
	return ArcadeSkillFactory.instance:createSkillById(skillId)
end

function GMSubViewArcade:_onClickCheckSkillOk()
	local configList = lua_arcade_passive_skill.configList

	for _, cfg in ipairs(configList) do
		xpcall(_createSkillFunc, __G__TRACKBACK__, cfg.id)
	end

	GameFacade.showToast(ToastEnum.IconId, "请查看Log输出")
end

function GMSubViewArcade:_openGMArcadeView()
	ArcadeOutSideRpc.instance:sendArcadeGetOutSideInfoRequest(function()
		ViewMgr.instance:openView(ViewName.GM_ArcadeView)
	end)
end

function GMSubViewArcade:_onInitL3Text()
	local list = {}

	for i = 1, 10 do
		list[#list + 1] = i
	end

	RoomHelper.randomArray(list)
	table.sort(list, GMSubViewArcade._sortNum)

	local concatStr = table.concat(list, " ")

	logError("========= > " .. #list)
	logError("msg lock: " .. concatStr .. " len:" .. #list)
end

function GMSubViewArcade._sortNum(a, b)
	local aIdx = a % 2
	local bIdx = b % 2

	if aIdx ~= bIdx then
		return aIdx < bIdx
	end
end

function GMSubViewArcade:_changeRoom()
	local roomId = tonumber(self._arcadeRoomInputText:GetText())

	if not roomId or roomId == 0 then
		return
	end

	local cfg = ArcadeConfig.instance:getRoomCfg(roomId, true)

	if not cfg then
		return
	end

	ArcadeGameController.instance:change2Room(roomId)
	GameFacade.showToast(ToastEnum.IconId, string.format("跳转到房间：%s", roomId))
end

local PREFS_KEY = "GMSubViewArcadeSelectedResIndex"

function GMSubViewArcade:_initL4()
	local LStr = "L4"
	local strList = {
		"选择资源"
	}

	self._resourceList = {}

	local resIdList = {}

	for _, resId in pairs(ArcadeGameEnum.CharacterResource) do
		resIdList[#resIdList + 1] = resId
	end

	table.sort(resIdList, function(a, b)
		return a < b
	end)

	for _, resId in ipairs(resIdList) do
		self._resourceList[#self._resourceList + 1] = resId
		strList[#strList + 1] = ArcadeConfig.instance:getAttributeName(resId)
	end

	local dropDown = self.addDropDown(self, LStr, "添加资源", strList, self._onResSelectChange, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 415
	})
	local index = PlayerPrefsHelper.getNumber(PREFS_KEY, 0)

	dropDown:SetValue(index)

	self._changeResCountText = self:addInputText(LStr, nil, "更改数量")

	self.addButton(self, LStr, "确定", self._onClickResChangeOk, self)
end

function GMSubViewArcade:_onResSelectChange(index)
	PlayerPrefsHelper.setNumber(PREFS_KEY, index)

	self._selectedRes = self._resourceList[index]
end

function GMSubViewArcade:_onClickResChangeOk()
	if not self._selectedRes then
		GameFacade.showToast(ToastEnum.IconId, "未选择资源")

		return
	end

	local changeCount = tonumber(self._changeResCountText:GetText())

	if not changeCount or changeCount == 0 then
		GameFacade.showToast(ToastEnum.IconId, "未填写变更数量")

		return
	end

	ArcadeGameController.instance:changeResCount(self._selectedRes, changeCount, Vector3.zero)

	local name = ArcadeConfig.instance:getAttributeName(self._selectedRes)

	GameFacade.showToast(ToastEnum.IconId, string.format("%s数量更改：%s", name, changeCount))
end

function GMSubViewArcade:_initL5()
	local LStr = "L5"

	self:addLabel(LStr, "地块")

	self._floorIdInputText = self:addInputText(LStr, nil, "地块id")

	self.addButton(self, LStr, "生成", self._onClickCreateFloorOk, self)
	self.addButton(self, LStr, "清除", self._onClickClearFloorOk, self)
	self.addButton(self, LStr, "检查初始交互物配置", self._checkInitInteractiveCfg, self)
	self.addButton(self, LStr, "检查怪物组配置", self._checkMonsterGroupCfg, self)
end

function GMSubViewArcade:_getInputFloorId()
	local floorIdStr = self._floorIdInputText:GetText()

	if string.nilorempty(floorIdStr) then
		GameFacade.showToast(ToastEnum.IconId, "请输入地块id")

		return
	end

	local floorId = tonumber(floorIdStr)

	if not ArcadeConfig.instance:getFloorCfg(floorId) then
		GameFacade.showToast(ToastEnum.IconId, string.format("不存在地块Id:%s", floorIdStr))

		return
	end

	return floorId
end

function GMSubViewArcade:_onClickCreateFloorOk()
	local floorId = self:_getInputFloorId()

	if not floorId or self:_isLockClick() then
		return
	end

	local dataList = {}

	for x = 2, 6 do
		for y = 2, 5 do
			table.insert(dataList, {
				id = floorId,
				x = x,
				y = y
			})
		end
	end

	ArcadeGameFloorController.instance:tryAddFloorByList(dataList)
end

function GMSubViewArcade:_onClickClearFloorOk()
	local floorId = self:_getInputFloorId()

	if not floorId or self:_isLockClick() then
		return
	end

	local floorMOList = {}
	local entityType = ArcadeGameEnum.EntityType.Floor

	tabletool.addValues(floorMOList, ArcadeGameModel.instance:getEntityMOList(entityType))

	for _, floorMO in ipairs(floorMOList) do
		if floorMO and floorMO:getId() == floorId then
			ArcadeGameController.instance:removeEntity(entityType, floorMO:getUid())
		end
	end
end

function GMSubViewArcade:_onClickCurRoom()
	local roomId = ArcadeGameModel.instance:getCurRoomId()

	ZProj.UGUIHelper.CopyText(tostring(roomId))
	GameFacade.showToastString(string.format("已复制当前房间：%s", roomId))
end

function GMSubViewArcade:_initL6()
	local LStr = "L6"

	self:addLabel(LStr, "交互物")

	self._interactIdInputText = self:addInputText(LStr, nil, "交互物id")

	self.addButton(self, LStr, "生成", self._onClickCreateInteractOk, self)
	self:addLabel(LStr, "炸弹")

	self._bombIdInputText = self:addInputText(LStr, nil, "炸弹id")

	self.addButton(self, LStr, "生成", self._onClickCreateBombOk, self)
end

function GMSubViewArcade:_onClickCreateInteractOk()
	local interactIdStr = self._interactIdInputText:GetText()

	if string.nilorempty(interactIdStr) then
		GameFacade.showToast(ToastEnum.IconId, "请输入交互物id")

		return
	end

	local interactId = tonumber(interactIdStr)

	if not ArcadeConfig.instance:getInteractiveCfg(interactId) then
		GameFacade.showToast(ToastEnum.IconId, "不存在交互物id:" .. interactIdStr)

		return
	end

	if self:_isLockClick() then
		return
	end

	ArcadeGameSummonController.instance:summonInteractiveList({
		interactId
	})
end

function GMSubViewArcade:_onClickCreateBombOk()
	local bombIdStr = self._bombIdInputText:GetText()

	if string.nilorempty(bombIdStr) then
		GameFacade.showToast(ToastEnum.IconId, "请输入炸弹id")

		return
	end

	local bombId = tonumber(bombIdStr)

	if not ArcadeConfig.instance:getBombCfg(bombId) then
		GameFacade.showToast(ToastEnum.IconId, "不存在炸弹id:" .. bombIdStr)

		return
	end

	if self:_isLockClick() then
		return
	end

	ArcadeGameSummonController.instance:summonBombList({
		bombId
	})
end

function GMSubViewArcade:_initL7()
	local LStr = "L7"
	local strList = {}

	self._portalIdList = {}

	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()

	if difficulty and curAreaIndex then
		local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()

		for i, portalId in ipairs(portalIdList) do
			self._portalIdList[i - 1] = portalId

			local name = ArcadeConfig.instance:getInteractiveName(portalId)

			strList[i] = string.format("%s-%s", portalId, name)
		end
	end

	self._portalDropDown = self.addDropDown(self, LStr, "传送门", strList, self._onChangeSelectPortal, self, {
		tempH = 450,
		total_w = 650,
		drop_w = 515
	})
	self._selectedPortalId = self._portalIdList[0]

	self.addButton(self, LStr, "确定", self._onClickPortalOk, self)
	self.addButton(self, LStr, "重置传送门", self._resetPortalList, self)
end

function GMSubViewArcade:_resetPortalList()
	self._portalIdList = {}

	local strList = {}
	local difficulty = ArcadeGameModel.instance:getDifficulty()
	local curAreaIndex = ArcadeGameModel.instance:getCurAreaIndex()

	if difficulty and curAreaIndex then
		local portalIdList = ArcadeGameModel.instance:getRoomPortalIdList()

		for i, portalId in ipairs(portalIdList) do
			self._portalIdList[i - 1] = portalId

			local name = ArcadeConfig.instance:getInteractiveName(portalId)

			strList[i] = string.format("%s-%s", portalId, name)
		end
	end

	self._portalDropDown:ClearOptions()
	self._portalDropDown:AddOptions(strList)
	self._portalDropDown:SetValue(0)

	self._selectedPortalId = self._portalIdList[0]
end

function GMSubViewArcade:_onChangeSelectPortal(index)
	self._selectedPortalId = self._portalIdList[index]
end

function GMSubViewArcade:_onClickPortalOk()
	if not self._selectedPortalId then
		GameFacade.showToast(ToastEnum.IconId, "未选择传送门")

		return
	end

	local optionList = ArcadeConfig.instance:getInteractiveOptionList(self._selectedPortalId)

	if not optionList then
		return
	end

	if #optionList > 1 then
		logError(string.format("GMSubViewArcade:_onClickPortalOk error, portal:%s has more than one option", self._selectedPortalId))
	end

	local optionId = optionList[1]
	local optionParam = ArcadeConfig.instance:getEventOptionParam(optionId)

	ArcadeGameController.instance:triggerEventOption(nil, self._selectedPortalId, nil, optionId, optionParam, true, true)
	GameFacade.showToast(ToastEnum.IconId, string.format("触发传送门：%s", self._selectedPortalId))
end

function GMSubViewArcade:_initL8()
	local LStr = "L8"
	local strList = {
		"单位类型"
	}
	local typeEnum = ArcadeGameEnum.EntityType
	local typeDataList = {
		{
			name = "角色",
			entityType = typeEnum.Character
		},
		{
			name = "怪物",
			entityType = typeEnum.Monster
		},
		{
			name = "炸弹",
			entityType = typeEnum.Bomb
		},
		{
			name = "交互物",
			entityType = typeEnum.BaseInteractive
		},
		{
			name = "传送门",
			entityType = typeEnum.Portal
		},
		{
			name = "商品",
			entityType = typeEnum.Goods
		},
		{
			name = "地板",
			entityType = typeEnum.Floor
		},
		{
			name = "格子",
			entityType = typeEnum.Grid
		}
	}

	self._entityTypeList = {}

	for _, typeData in ipairs(typeDataList) do
		self._entityTypeList[#self._entityTypeList + 1] = typeData.entityType
		strList[#strList + 1] = typeData.name
	end

	local dropDown = self.addDropDown(self, LStr, "选择单位", strList, self._onSelectedEntityTypeChange, self, {
		tempH = 450,
		total_w = 550,
		drop_w = 380
	})
	local index = PlayerPrefsHelper.getNumber(PlayerPrefsKey.GMArcadeSelectedEntityTypeIndex, 0)

	if index > #typeDataList then
		index = 0
	end

	dropDown:SetValue(index or 0)

	self._logEntityUidText = self:addInputText(LStr, nil, "uid")
	self._addBuffIdText = self:addInputText(LStr, nil, "buffId", nil, nil, {
		w = 250
	})

	self.addButton(self, LStr, "添加Buff", self._onClickAddBuff, self)
end

function GMSubViewArcade:_onSelectedEntityTypeChange(index)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.GMArcadeSelectedEntityTypeIndex, index)

	self._selectedEntityType = self._entityTypeList[index]
end

function GMSubViewArcade:getLogEntityMO()
	local uid = tonumber(self._logEntityUidText:GetText())
	local mo = ArcadeGameModel.instance:getMOWithType(self._selectedEntityType, uid)

	if not mo then
		GameFacade.showToastString(string.format("单位不存在\n类型：%s\n uid：%s", self._selectedEntityType, uid))
	end

	return mo
end

function GMSubViewArcade:_onClickAddBuff()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local uid = tonumber(self._logEntityUidText:GetText())
	local buffId = tonumber(self._addBuffIdText:GetText())
	local result = ArcadeGameController.instance:addBuff2Entity(buffId, self._selectedEntityType, uid)

	if result then
		GameFacade.showToastString(string.format("添加Buff:%s", buffId))
	else
		GameFacade.showToastString(string.format("Buff:%s添加失败", buffId))
	end
end

function GMSubViewArcade:_initL9()
	local LStr = "L9"

	self.addButton(self, LStr, "输出Buff", self._onClickLogBuff, self)
	self.addButton(self, LStr, "输出被动技能", self._onClickLogPassiveSkill, self)
	self.addButton(self, LStr, "输出玩家属性", self._onClickLogAttr, self)
	self.addButton(self, LStr, "输出技能计数器", self._onClickLogSkillCounter, self)
	self.addButton(self, LStr, "获取当前房间ID", self._onClickCurRoom, self)
end

function GMSubViewArcade:_onClickLogBuff()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local log = string.format("============================%s-%s-BUFF============================", self._selectedEntityType, self._logEntityUidText:GetText())
	local buffSetMO = mo:getBuffSetMO()
	local buffList = buffSetMO and buffSetMO:getBuffList()

	if buffList then
		for _, buffMO in ipairs(buffList) do
			local buffId = buffMO:getId()
			local remainRound = buffMO:getRemainLiveRound()

			log = log .. string.format("\nId:<color=green>%s</color>    剩余回合:<color=green>%s</color>", buffId, remainRound)
		end
	end

	logError(log)
end

function GMSubViewArcade:_onClickLogPassiveSkill()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local log = string.format("============================%s-%s-被动技能============================", self._selectedEntityType, self._logEntityUidText:GetText())
	local skillList = mo:getSkillList()

	if skillList then
		local idList = {}

		for _, skillMO in ipairs(skillList) do
			idList[#idList + 1] = skillMO:getSkillId()
		end

		table.sort(idList, function(a, b)
			return a < b
		end)

		for _, skillId in ipairs(idList) do
			log = log .. string.format("\nId:<color=green>%s</color>", skillId)
		end
	end

	logError(log)
end

function GMSubViewArcade:_onClickLogAttr()
	local log = "============================玩家属性============================"
	local characterMO = ArcadeGameModel.instance:getCharacterMO()

	if characterMO then
		local attrList = {}
		local maxAttrPrefixLen = self:_getAttrList(ArcadeGameEnum.BaseAttr, attrList)

		log = log .. self:_getAttrLog(attrList, maxAttrPrefixLen, characterMO.getAttributeValue, characterMO) .. "\n"

		local attackAttrLog = "\n角色附魔：<color=red>无</color>"
		local attackAttrId = characterMO:getAttackAttrId()

		if attackAttrId and attackAttrId ~= 0 then
			local name = ArcadeConfig.instance:getAttackAttrName(attackAttrId)

			attackAttrLog = string.format("\n角色附魔：<color=green>%s-%s</color>", attackAttrId, name)
		end

		log = log .. attackAttrLog .. "\n"

		local resList = {}
		local maxResPrefixLen = self:_getAttrList(ArcadeGameEnum.CharacterResource, resList)

		log = log .. self:_getAttrLog(resList, maxResPrefixLen, characterMO.getResourceCount, characterMO) .. "\n"
	end

	local gameAttrList = {}
	local maxGameAttrPrefixLen = self:_getAttrList(ArcadeGameEnum.GameAttribute, gameAttrList)

	log = log .. self:_getAttrLog(gameAttrList, maxGameAttrPrefixLen, ArcadeGameModel.getGameAttribute, ArcadeGameModel.instance) .. "\n"

	local gameSwitchList = {}
	local maxGameSwitchPrefixLen = self:_getAttrList(ArcadeGameEnum.GameSwitch, gameSwitchList)

	log = log .. self:_getAttrLog(gameSwitchList, maxGameSwitchPrefixLen, ArcadeGameModel.getGameSwitchIsOn, ArcadeGameModel.instance) .. "\n"

	logError(log)
end

function GMSubViewArcade:_getAttrList(attrDict, refAttrList)
	local maxAttrPrefixLen = 0

	for _, attrId in pairs(attrDict) do
		local name = ArcadeConfig.instance:getAttributeName(attrId)
		local strPrefix = string.format("\n%s-%s", attrId, name)
		local prefixLen = LuaUtil.getStrLen(strPrefix)

		refAttrList[#refAttrList + 1] = {
			id = attrId,
			prefix = strPrefix,
			prefixLen = prefixLen
		}

		if maxAttrPrefixLen < prefixLen then
			maxAttrPrefixLen = prefixLen
		end
	end

	table.sort(refAttrList, function(a, b)
		return a.id < b.id
	end)

	return maxAttrPrefixLen
end

function GMSubViewArcade:_getAttrLog(attrList, maxPrefixLen, getValFunc, getValFuncObj)
	local log = ""

	for _, attr in ipairs(attrList) do
		local val = getValFunc(getValFuncObj, attr.id)
		local strVal = string.format(" <color=%s>%s</color>", (not val or nil) and "red", tostring(val))

		log = log .. attr.prefix .. string.rep(" ", (maxPrefixLen - attr.prefixLen) * 2) .. strVal
	end

	return log
end

function GMSubViewArcade:_onClickLogSkillCounter()
	local mo = self:getLogEntityMO()

	if not mo then
		return
	end

	local log = string.format("============================%s-%s-技能计数器============================", self._selectedEntityType, self._logEntityUidText:GetText())
	local entitySkillSetMO = mo:getSkillSetMO()
	local skillSetMOList = {
		entitySkillSetMO
	}

	if self._selectedEntityType == ArcadeGameEnum.EntityType.Character then
		local collectionDict = mo:getCollectionDict()

		if collectionDict then
			for _, collectionMO in pairs(collectionDict) do
				skillSetMOList[#skillSetMOList + 1] = collectionMO:getSkillSetMO()
			end
		end
	end

	for _, skillSetMO in ipairs(skillSetMOList) do
		local owner = skillSetMO:getOwner()
		local skillCounterDict = skillSetMO:getSkillCounterDict()
		local isCollection = owner:getIsCollection()
		local hasCounter = not not next(skillCounterDict)

		if hasCounter and isCollection then
			local collectionId = owner:getId()

			log = log .. string.format("\n===========藏品:%s==========", collectionId)
		end

		for skillId, counterDict in pairs(skillCounterDict) do
			log = log .. string.format("\n【技能:%s】", skillId)

			for _, counter in pairs(counterDict) do
				local boxList = counter:getSaveCounterBoxList()

				for _, box in ipairs(boxList) do
					log = log .. string.format("\nkey: <color=green>%s</color>  count: <color=green>%s</color>", box.key, box.count)
				end
			end
		end

		if hasCounter then
			log = log .. "\n"
		end
	end

	logError(log)
end

function GMSubViewArcade:_checkInitInteractiveCfg()
	for _, cfg in ipairs(lua_arcade_room.configList) do
		local roomId = cfg.id
		local errorList = {}
		local occupyGridDict = {}
		local interactiveList = ArcadeConfig.instance:getRoomInitInteractiveList(roomId)

		for _, interactive in ipairs(interactiveList) do
			local interactiveId = interactive.id
			local x = interactive.x
			local y = interactive.y
			local interactCfg = ArcadeConfig.instance:getInteractiveCfg(interactiveId)

			if not interactCfg then
				errorList[#errorList + 1] = string.format("无交互物:%s配置", interactiveId)
			end

			local sizeX, sizeY = ArcadeConfig.instance:getInteractiveGrid(interactiveId)

			if x < ArcadeGameEnum.Const.RoomMinCoordinateValue or x + sizeX - 1 > ArcadeGameEnum.Const.RoomSize or y < ArcadeGameEnum.Const.RoomMinCoordinateValue then
				errorList[#errorList + 1] = string.format("交互物:%s坐标错误, x:%s y:%s sizeX:%s sizeY:%s", interactiveId, x, y, sizeX, sizeY)
			end

			local occupyGridList = {}

			for i = x, x + sizeX - 1 do
				for j = y, y + sizeY - 1 do
					local gridId = ArcadeGameHelper.getGridId(i, j)
					local occupyId = occupyGridDict[gridId]

					if occupyId then
						errorList[#errorList + 1] = string.format("交互物:%s %s重叠, x:%s y:%s", interactiveId, occupyId, x, y)
					end

					occupyGridList[#occupyGridList + 1] = gridId
				end
			end

			for _, gridId in ipairs(occupyGridList) do
				occupyGridDict[gridId] = interactiveId
			end
		end

		if #errorList > 0 then
			logError(string.format("============================房间:%s============================", roomId))

			for _, strError in ipairs(errorList) do
				logError(strError)
			end
		end
	end

	GameFacade.showToastString("检查完毕")
end

function GMSubViewArcade:_checkMonsterGroupCfg()
	for _, cfg in ipairs(lua_arcade_monster_group.configList) do
		local groupId = cfg.id
		local errorList = {}
		local occupyGridDict = {}

		for row = 1, ArcadeGameEnum.Const.RoomSize do
			local rowCfg = ArcadeConfig.instance:getMonsterGroupRowCfg(groupId, row)

			if rowCfg then
				for col = 1, ArcadeGameEnum.Const.RoomSize do
					local monsterId = rowCfg[string.format("%s%s", ArcadeGameEnum.Const.MonsterGroupColName, col)]

					if monsterId and monsterId ~= 0 then
						local monsterCfg = ArcadeConfig.instance:getMonsterCfg(monsterId)

						if not monsterCfg then
							errorList[#errorList + 1] = string.format("%s行%s列怪物:%s无配置", row, col, monsterId)
						end

						if monsterCfg then
							if not monsterCfg.shape then
								local strSize = ""
								local sizeX, sizeY = ArcadeConfig.instance:getMonsterSize(monsterId)

								if col < ArcadeGameEnum.Const.RoomMinCoordinateValue or col + sizeX - 1 > ArcadeGameEnum.Const.RoomSize or row < ArcadeGameEnum.Const.RoomMinCoordinateValue then
									errorList[#errorList + 1] = string.format("%s行 %s列怪物:%s越界，体型:%s", row, col, monsterId, strSize)
								end

								local occupyGridList = {}

								for x = col, col + sizeX - 1 do
									for y = row, row + sizeY - 1 do
										local gridId = ArcadeGameHelper.getGridId(x, y)
										local occupyData = occupyGridDict[gridId]

										if occupyData then
											errorList[#errorList + 1] = string.format("%s行%s列怪物:%s，体型体型:%s   %s行%s列怪物:%s，体型:%s 在%s行%s列重叠", row, col, monsterId, strSize, occupyData.row, occupyData.col, occupyData.id, occupyData.size, y, x)
										end

										occupyGridList[#occupyGridList + 1] = gridId
									end
								end

								for _, gridId in ipairs(occupyGridList) do
									occupyGridDict[gridId] = {
										id = monsterId,
										row = row,
										col = col,
										size = strSize
									}
								end
							end
						end
					end
				end
			end
		end

		if #errorList > 0 then
			logError(string.format("============================怪物组:%s============================", groupId))

			for _, strError in ipairs(errorList) do
				logError(strError)
			end
		end
	end

	GameFacade.showToastString("检查完毕")
end

return GMSubViewArcade
