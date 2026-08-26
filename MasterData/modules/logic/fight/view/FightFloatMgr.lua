-- chunkname: @modules/logic/fight/view/FightFloatMgr.lua

module("modules.logic.fight.view.FightFloatMgr", package.seeall)

local FightFloatMgr = class("FightFloatMgr")
local idCounter = 1
local DataParamCount = 5
local FrameProcessCount = 10
local SingleEntityInterval = 0.3
local EnttiyMaxPlayingCount = 3
local BuffType = {
	[FightEnum.FloatType.buff] = true
}

FightFloatMgr.SkinId = {
	Default = 0,
	Duck_3_9 = 682804
}

function FightFloatMgr:ctor()
	self._loader = nil
	self._id2PlayingItem = {}
	self._type2ItemPool = {}
	self._entityTimeDict = {}
	self._dataQueue4 = {}
	self._floatParent = nil
	self._entityId2PlayingItems = {}
	self.canShowFightNumUI = PlayerPrefsHelper.getNumber(PlayerPrefsKey.FightShowFightNum, 1) == 1
end

function FightFloatMgr:removeInterval()
	SingleEntityInterval = 0
end

function FightFloatMgr:resetInterval()
	SingleEntityInterval = 0.3 / FightModel.instance:getUISpeed()
end

function FightFloatMgr:init()
	self._classEnabled = true
	self._loader = MultiAbLoader.New()

	self._loader:addPath(self:getFloatPrefab())
	self._loader:startLoad(self._onLoadCallback, self)
end

function FightFloatMgr:getFloatPrefab()
	local curStyleId = FightUISwitchModel.instance:getCurUseFightUIFloatStyleId()
	local co = curStyleId and lua_fight_ui_style.configDict[curStyleId]

	if not co then
		self.skinId = FightFloatMgr.SkinId.Default

		return ResUrl.getSceneUIPrefab("fight", "fightfloat")
	end

	local itemId = co.itemId
	local floatCo = itemId and lua_fight_float_effect.configDict[itemId]

	if not floatCo then
		self.skinId = FightFloatMgr.SkinId.Default

		logError(string.format("lua_fight_float_effect 战斗飘字表没找到 道具id : '%s' 对应的配置", itemId))

		return ResUrl.getSceneUIPrefab("fight", "fightfloat")
	end

	self.skinId = floatCo.id

	return ResUrl.getSceneUIPrefab("fight", floatCo.prefabPath)
end

function FightFloatMgr:getCurSkinId()
	return self.skinId
end

function FightFloatMgr:_onLoadCallback()
	local assetItem = self._loader:getFirstAssetItem()
	local prefab = assetItem:GetResource()
	local hudLayer = ViewMgr.instance:getUILayer(UILayerName.Hud)

	self._floatParent = gohelper.create2d(hudLayer, "Float")
	self._floatParentRectTr = self._floatParent:GetComponent(gohelper.Type_RectTransform)

	local rect = self._floatParent.transform
	local vector2Zero = Vector2.zero

	rect.anchorMin = vector2Zero
	rect.anchorMax = Vector2.one
	rect.offsetMin = vector2Zero
	rect.offsetMax = vector2Zero

	self:_initPrefab(FightEnum.FloatType.equipeffect, gohelper.findChild(prefab, "equipeffect"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_restrain, gohelper.findChild(prefab, "crit_restrain"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_berestrain, gohelper.findChild(prefab, "crit_berestrain"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_heal, gohelper.findChild(prefab, "crit_heal"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_damage, gohelper.findChild(prefab, "crit_damage"), 0)
	self:_initPrefab(FightEnum.FloatType.restrain, gohelper.findChild(prefab, "restrain"), 0)
	self:_initPrefab(FightEnum.FloatType.berestrain, gohelper.findChild(prefab, "berestrain"), 0)
	self:_initPrefab(FightEnum.FloatType.heal, gohelper.findChild(prefab, "heal"), 0)
	self:_initPrefab(FightEnum.FloatType.damage, gohelper.findChild(prefab, "damage"), 0)
	self:_initPrefab(FightEnum.FloatType.buff, gohelper.findChild(prefab, "buff"), 0)
	self:_initPrefab(FightEnum.FloatType.miss, gohelper.findChild(prefab, "miss"), 0)
	self:_initPrefab(FightEnum.FloatType.total, gohelper.findChild(prefab, "total_damage"), 0)
	self:_initPrefab(FightEnum.FloatType.damage_origin, gohelper.findChild(prefab, "damage_origin"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_damage_origin, gohelper.findChild(prefab, "crit_damage_origin"), 0)
	self:_initPrefab(FightEnum.FloatType.total_origin, gohelper.findChild(prefab, "total_damage_origin"), 0)
	self:_initPrefab(FightEnum.FloatType.stress, gohelper.findChild(prefab, "stress"), 0)
	self:_initPrefab(FightEnum.FloatType.additional_damage, gohelper.findChild(prefab, "additional_damage"), 0)
	self:_initPrefab(FightEnum.FloatType.crit_additional_damage, gohelper.findChild(prefab, "crit_additional_damage"), 0)
	self:_initPrefab(FightEnum.FloatType.addShield, gohelper.findChild(prefab, "shield"), 0)
	self:_initPrefab(FightEnum.FloatType.secret_key, gohelper.findChild(prefab, "secret_key"), 0)
end

function FightFloatMgr:dispose()
	for _, item in pairs(self._id2PlayingItem) do
		item:stopFloat()
		self._type2ItemPool[item.type]:putObject(item)
	end

	for _, pool in pairs(self._type2ItemPool) do
		pool:dispose()
	end

	self._id2PlayingItem = {}
	self._type2ItemPool = {}
	self._dataQueue4 = {}

	if self._floatParent then
		gohelper.destroy(self._floatParent)

		self._floatParent = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._classEnabled = false
end

function FightFloatMgr:clearFloatItem()
	TaskDispatcher.cancelTask(self._onTick, self)

	for _, item in pairs(self._id2PlayingItem) do
		item:stopFloat()
		self._type2ItemPool[item.type]:putObject(item)
	end

	self._dataQueue4 = {}
end

function FightFloatMgr:float(entityId, type, content, param, isAssassinate)
	if isDebugBuild and GMController.instance.hideFloat then
		return
	end

	if FightDataHelper.entityMgr:isAssistBoss(entityId) then
		return
	end

	if FightDataHelper.entityMgr:isAct191Boss(entityId) then
		return
	end

	if not self._classEnabled then
		return
	end

	if param == nil then
		param = 0
	end

	if not self.canShowFightNumUI and type ~= FightEnum.FloatType.buff and type ~= FightEnum.FloatType.miss then
		return
	end

	local entityMO = FightDataHelper.entityMgr:getById(entityId)

	if entityMO and entityMO:hasBuffFeature(FightEnum.BuffType_HideLife) then
		return
	end

	table.insert(self._dataQueue4, entityId)
	table.insert(self._dataQueue4, type)
	table.insert(self._dataQueue4, content)
	table.insert(self._dataQueue4, param)
	table.insert(self._dataQueue4, isAssassinate or false)
	TaskDispatcher.runRepeat(self._onTick, self, 0.1 / FightModel.instance:getUISpeed())
end

function FightFloatMgr:floatEnd(fightFloatItem)
	self._id2PlayingItem[fightFloatItem.id] = nil

	self._type2ItemPool[fightFloatItem.type]:putObject(fightFloatItem)

	local entityFloatItems = self._entityId2PlayingItems[fightFloatItem.entityId]

	if entityFloatItems then
		tabletool.removeValue(entityFloatItems, fightFloatItem)
	end
end

function FightFloatMgr:nameUIBeforeDestroy(nameUIGO)
	if not nameUIGO then
		return
	end

	local nameUITr = nameUIGO.transform

	for i = nameUITr.childCount, 1, -1 do
		local childTr = nameUITr:GetChild(i - 1)

		if string.find(childTr.name, "float") then
			if self._floatParent then
				gohelper.addChild(self._floatParent, childTr.gameObject)
				gohelper.setActive(childTr.gameObject, false)
			else
				gohelper.destroy(childTr.gameObject)
			end
		end
	end
end

function FightFloatMgr:_initPrefab(type, typePrefab, randomXRange)
	local floatParent = self._floatParent

	self._type2ItemPool[type] = LuaObjPool.New(20, function()
		local prefab = gohelper.clone(typePrefab, floatParent, "float" .. type)
		local skinId = FightFloatMgr.instance:getCurSkinId()

		return (FightFloatItem.New(type, prefab, randomXRange, skinId))
	end, function(obj)
		obj:onDestroy()
	end, function(obj)
		obj:reset()
	end)
end

function FightFloatMgr:_onTick()
	local processCount = 0
	local now = Time.time
	local delayData

	for i = 1, #self._dataQueue4, DataParamCount do
		local entityId = self._dataQueue4[i]
		local type = self._dataQueue4[i + 1]
		local content = self._dataQueue4[i + 2]
		local param = self._dataQueue4[i + 3]
		local isAssassinate = self._dataQueue4[i + 4]
		local lastTime = self._entityTimeDict[entityId]

		if not BuffType[type] and lastTime and now - lastTime < SingleEntityInterval then
			delayData = delayData or {}

			table.insert(delayData, entityId)
			table.insert(delayData, type)
			table.insert(delayData, content)
			table.insert(delayData, param)
			table.insert(delayData, isAssassinate)
		else
			self._entityTimeDict[entityId] = now

			self:_doShowTip(entityId, type, content, param, isAssassinate)

			processCount = processCount + 1
		end

		if processCount == FrameProcessCount then
			break
		end
	end

	if delayData then
		if not #delayData then
			local delayDataLen = 0

			for i = 1, delayDataLen do
				self._dataQueue4[i] = delayData[i]
			end

			local offset = processCount * DataParamCount

			for i = delayDataLen + 1, #self._dataQueue4 do
				self._dataQueue4[i] = self._dataQueue4[i + offset]
			end

			if #self._dataQueue4 == 0 then
				TaskDispatcher.cancelTask(self._onTick, self)
			end
		end
	end
end

function FightFloatMgr:_doShowTip(entityId, type, content, param, isAssassinate)
	local entityPlayingItems = self._entityId2PlayingItems[entityId]

	if not entityPlayingItems then
		entityPlayingItems = {}
		self._entityId2PlayingItems[entityId] = entityPlayingItems
	end

	if #entityPlayingItems >= EnttiyMaxPlayingCount then
		local firstPlayingItem = table.remove(entityPlayingItems, #entityPlayingItems)

		firstPlayingItem:stopFloat()
	end

	local entity = FightHelper.getEntity(entityId)
	local item = self._type2ItemPool[type]:getObject()

	item.id = idCounter
	idCounter = idCounter + 1
	self._id2PlayingItem[item.id] = item

	table.insert(entityPlayingItems, 1, item)

	if FightDataHelper.entityMgr:isAssistBoss(entityId) then
		gohelper.addChild(self._floatParent, item:getGO())
	elseif FightDataHelper.entityMgr:isAct191Boss(entityId) then
		gohelper.addChild(self._floatParent, item:getGO())
	elseif entity and entity.nameUI then
		gohelper.addChild(entity.nameUI:getFloatContainerGO(), item:getGO())
	end

	item:startFloat(entityId, content, param, isAssassinate)

	local offset_x = 0
	local offset_y = entity and entity.nameUI and entity.nameUI:getFloatItemStartY() or 0

	item:setPos(offset_x, offset_y)

	if entity then
		local entity_mo = entity:getMO()

		if entity_mo then
			local monster_skin_config = lua_monster_skin.configDict[entity_mo.skin]

			if monster_skin_config then
				local pos_arr = FightStrUtil.instance:getSplitToNumberCache(monster_skin_config.floatOffset, "#")

				if #pos_arr > 0 then
					item:setPos(pos_arr[1], pos_arr[2])

					offset_x = pos_arr[1]
					offset_y = pos_arr[2]
				end
			end
		end
	end

	if param and _G.type(param) == "table" then
		if param.pos_x then
			local temp_pos = recthelper.rectToRelativeAnchorPos(Vector3.New(param.pos_x, param.pos_y, 0), self._floatParent.transform)

			offset_x = temp_pos.x
			offset_y = temp_pos.y

			item:setPos(temp_pos.x, temp_pos.y)
			gohelper.addChild(self._floatParent, item:getGO())
		end

		if param.offset_x then
			offset_x = offset_x + param.offset_x
			offset_y = offset_y + param.offset_y

			item:setPos(offset_x, offset_y)
		end
	end

	local tweenY = offset_y

	if FightDataHelper.entityMgr:isAssistBoss(entityId) or FightDataHelper.entityMgr:isAct191Boss(entityId) then
		local hangPointGO = entity:getHangPoint(ModuleEnum.SpineHangPoint.mounttop)

		hangPointGO = hangPointGO or entity:getHangPoint(ModuleEnum.SpineHangPointRoot)

		local anchorX, anchorY = recthelper.worldPosToAnchorPos2(hangPointGO.transform.position, self._floatParentRectTr, nil, CameraMgr.instance:getUnitCamera())

		item:setPos(anchorX, anchorY)

		tweenY = anchorY
	end

	for i, item in ipairs(entityPlayingItems) do
		tweenY = 50 + tweenY

		item:tweenPosY(tweenY)

		if item.type == FightEnum.FloatType.total or item.type == FightEnum.FloatType.total_origin then
			tweenY = tweenY + 50
		end

		gohelper.setAsFirstSibling(item:getGO())
	end
end

function FightFloatMgr:hideEntityEquipFloat(entityId)
	local entityPlayingItems = self._entityId2PlayingItems[entityId]

	if entityPlayingItems then
		for i, v in ipairs(entityPlayingItems) do
			v:hideEquipFloat()
		end
	end
end

function FightFloatMgr:setCanShowFightNumUI(isShow)
	self.canShowFightNumUI = isShow
end

FightFloatMgr.instance = FightFloatMgr.New()

return FightFloatMgr
