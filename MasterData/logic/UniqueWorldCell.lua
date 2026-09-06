-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uniqueworld/view/UniqueWorldCell.lua

module("logic.extensions.uniqueworld.view.UniqueWorldCell", package.seeall)

local UniqueWorldCell = class("UniqueWorldCell")

function UniqueWorldCell:ctor(activityId, mapId, levelId, type, eventId, gridId, x, y, bgGo, cellGo)
	self._activityId = activityId
	self._mapId = mapId
	self._levelId = levelId
	self._type = type
	self._eventId = eventId
	self._gridId = gridId
	self._xCoord = x
	self._yCoord = y
	self._bgGo = bgGo
	self._cellGo = cellGo
end

function UniqueWorldCell:init()
	if self._eventId == nil then
		self._gridCfg = UniqueWorldConfig.instance:getMapCfg(self._mapId, self._gridId)
		self._eventId = self._gridCfg.eventId
	end

	self:_initUI()
end

function UniqueWorldCell:_initUI()
	self._btnClick = goutil.findChild(self._bgGo, "btnClick")

	if self._btnClick then
		GameUtil.addClickHandler(self._btnClick, self.trigCell, self)
	end

	self:updateUI()
end

function UniqueWorldCell:updateUI()
	if self._cellGo then
		self._canShowBoss = UniqueWorldController.instance:canShowBoss(self._activityId, self._levelId)
		self._imgEventGo = goutil.findChild(self._cellGo, "imgEvent")
		self._npc = goutil.findChild(self._cellGo, "npc")
		self._imgEventChangeComp = goutil.findChild(self._cellGo, "imgEvent"):GetComponent(ComponentType.UIImageSpriteChange)
		self._bossGo = goutil.findChild(self._cellGo, "boss")
		self._door = goutil.findChild(self._cellGo, "door")

		local isEventType = UniqueWorldController.instance:isEventType(self._type)
		local isNpc = self._type == UniqueWorldEnum.GridType.NPCDialogue
		local isBoss = self._type == UniqueWorldEnum.GridType.BossChallenge
		local isChallenge = self._type == UniqueWorldEnum.GridType.Challenge

		if isNpc then
			local npcCfg = UniqueWorldConfig.instance:getNpcCfg(self._eventId)
			local skinId = npcCfg.skinId

			self._con = goutil.findChild(self._cellGo, "npc")
			self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, false, nil, nil)
		elseif isChallenge or isBoss then
			local bossCfg = UniqueWorldConfig.instance:getFightEventCfg(self._eventId)
			local hpWanPercentRate = UniqueWorldController.instance:getBossWanPercentRate(self._activityId, self._levelId, self._gridId)
			local flagIdx = isChallenge and 0 or 1

			self._imgChallenge = goutil.findChild(self._bossGo, "imgChallenge")
			self._imgBoss = goutil.findChild(self._bossGo, "imgBoss")
			self._txtName = goutil.findChildTextComponent(self._bossGo, "name/txtName")
			self._txtLevel = goutil.findChildTextComponent(self._bossGo, "name/txtLevel")
			self._bloodSlider = goutil.findChild(self._bossGo, "name/slider"):GetComponent(ComponentType.Slider)
			self._imgFlagChangeComp = goutil.findChild(self._bossGo, "name/flag/imgFlag"):GetComponent(ComponentType.UIImageSpriteChange)
			self._bloodSlider.value = hpWanPercentRate
			self._txtName.text = bossCfg.name
			self._txtLevel.text = string.format("%s级", bossCfg.lv)

			self._imgFlagChangeComp:SetState(flagIdx)
			GameUtil.SetActive(self._imgChallenge, isChallenge)
			GameUtil.SetActive(self._imgBoss, isBoss)
		end

		local hasFinish = UniqueWorldModel.instance:gridHasFinish(self._activityId, self._gridId)

		if self._canShowBoss then
			local canShowBoss = isBoss
			local curFloorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)
			local posY = UniqueWorldController.posList[self._type]

			self._imgEventChangeComp:SetState(self._type)
			GameUtil.SetActive(self._imgEventGo, isEventType and not hasFinish)
			GameUtil.SetActive(self._npc, isNpc and not hasFinish)
			GameUtil.SetActive(self._bossGo, (isChallenge or canShowBoss) and not hasFinish)
			GameUtil.SetActive(self._door, canShowBoss and hasFinish)
			self._imgEventGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			GameUtil.setLocalPos(self._imgEventGo, 0, posY, 0)
		end
	end
end

function UniqueWorldCell:trigCell()
	GlobalDispatcher:dispatch(GlobalNotify.UniqueWorldClickGrid, self._gridId)
end

function UniqueWorldCell:updateUIByExtInfo(gridId, eventType, eventId, cellGo)
	if cellGo then
		self._cellGo = cellGo
	end

	if checknumber(eventType) > 0 and checknumber(eventId) > 0 then
		self._type = eventType
		self._eventId = eventId
	end

	self:updateUI()
end

function UniqueWorldCell:afterTrig()
	if self._type == UniqueWorldEnum.GridType.TreasureBox then
		local finishMap = UniqueWorldModel.instance._gridFinishMap[self._activityId]

		if finishMap then
			finishMap[self._gridId] = true
		end

		UniqueWorldController.instance:sendPM_UniqueWorldDoEventReq(self._activityId, self._gridId, "")
		GameUtil.SetActive(self._imgEventGo, false)
		UniqueWorldMapMgr.instance:setGridWalkableState(self._gridId, true)
	elseif self._type == UniqueWorldEnum.GridType.DigMine then
		local function func()
			local finishMap = UniqueWorldModel.instance._gridFinishMap[self._activityId]

			if finishMap then
				finishMap[self._gridId] = true
			end

			GameUtil.SetActive(self._imgEventGo, false)
			UniqueWorldController.instance:sendPM_UniqueWorldDoEventReq(self._activityId, self._gridId, "")
			UniqueWorldMapMgr.instance:setGridWalkableState(self._gridId, true)
			UniqueWorldMapMgr.instance:endWalking()
		end

		UniqueWorldPlayerMgr.instance:playDigMineAnim(func)
	elseif self._type == UniqueWorldEnum.GridType.NPCDialogue then
		UIStateManager.instance:push(ViewName.UniqueWorldNpcView, self._activityId, self._gridId, self._eventId)
	elseif self._type == UniqueWorldEnum.GridType.Shop then
		UIStateManager.instance:push(ViewName.UniqueWorldShopView, self._activityId, self._gridId, self._eventId)
	elseif self._type == UniqueWorldEnum.GridType.Challenge then
		local hasPetToFight = UniqueWorldController.instance:hasPetToFight(self._activityId)

		if not hasPetToFight then
			FloatWordMgr.instance:show("先去寻找商店招募精灵才可挑战劲敌")

			return
		end

		UniqueWorldController.instance:enterBattleClg(self._activityId, self._levelId, self._gridId)
	elseif self._type == UniqueWorldEnum.GridType.BossChallenge then
		local curFloorPercent = UniqueWorldController.instance:getCurFloorPercent(self._activityId, self._levelId)
		local hasFinish = UniqueWorldModel.instance:gridHasFinish(self._activityId, self._gridId)

		if curFloorPercent < 1 and not hasFinish then
			UniqueWorldController.instance:enterBattleClg(self._activityId, self._levelId, self._gridId)
		end
	end
end

function UniqueWorldCell:clearCell()
	return
end

function UniqueWorldCell:isWalkable()
	return self._type == UniqueWorldEnum.GridType.Empty
end

function UniqueWorldCell:getXYCoord()
	return self._xCoord, self._yCoord
end

function UniqueWorldCell:getGridId()
	return self._gridId
end

function UniqueWorldCell:getType()
	return self._type
end

function UniqueWorldCell:hasCellGo()
	return self._cellGo ~= nil
end

function UniqueWorldCell:canShowBoss()
	return self._canShowBoss
end

function UniqueWorldCell:destroy()
	GameUtil.rmClickHandler(self._btnClick)
	RoleObjectPool.instance:removeRole(self._role)

	if self._cellGo then
		self._cellGo.transform:SetParent(nil)
	end

	if self._bgGo then
		self._bgGo.transform:SetParent(nil)
	end

	goutil.destroy(self._cellGo)
	goutil.destroy(self._bgGo)
end

return UniqueWorldCell
