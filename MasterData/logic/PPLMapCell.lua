-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/maintainpowerpilla/view/PPLMapCell.lua

module("logic.extensions.maintainpowerpilla.view.PPLMapCell", package.seeall)

local PPLMapCell = class("PPLMapCell")

PPLMapCell.Empty = 0
PPLMapCell.Obstacle = 1
PPLMapCell.Entrance = 2
PPLMapCell.Exit = 3
PPLMapCell.Battle = 4
PPLMapCell.Box = 5
PPLMapCell.Trap = 6
PPLMapCell.Game = 7
PPLMapCell.Boss = 8
PPLMapCell.Branch = 9

local trapShowTime = 3
local trapSilentTime = 3

function PPLMapCell:ctor(luaComponentContainer)
	self.mainGO = luaComponentContainer.gameObject
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txt")
	self._icon = goutil.findChild(self.mainGO, "icon")
	self._root = goutil.findChild(self.mainGO, "root")
	self._bubble = {}
	self._bubble._mainGo = goutil.findChild(self.mainGO, "bubble")
	self._bubble._txtDesc = goutil.findChildTextComponent(self.mainGO, "bubble/txtDesc")
end

function PPLMapCell:getGo()
	return self.mainGO
end

function PPLMapCell:init(param)
	self._gridType = PPLMapCell.Empty
	self._index = param.index
	self._eventType = param.eventType
	self._cfg = param.cfg
	self._pos = param.pos
	self._row = param.row
	self._scale = param.scale
	self._colomn = param.column
	self._activityId = param.activityId
	self._stage = param.stage
	self._view = param.view
	self._stageCfg = PowerPillaConfig.instance:getStageCfgById(self._activityId, self._stage)
	self._obstacleName = param.obstacleName
	self._isTrapActive = false
	self._trapRecordTime = 0

	Framework.TransformUtil.SetAnchoredPos(self.mainGO:GetComponent(goutil.Type_RectTransform), self._pos[1], self._pos[2])
	GameUtil.setLocalScale(self.mainGO, self._scale.x, self._scale.y, self._scale.z)
	self:updateData()
end

function PPLMapCell:reset()
	uGuiUtil.clearImage(self._icon)
	self:_clearAllBossSpine()
	self:_clearAllNpcSpine()
end

function PPLMapCell:getPos()
	return self._pos
end

function PPLMapCell:getEventType()
	return self._eventType
end

function PPLMapCell:isTriggered()
	local isTriggered = PowerPillaModel.instance:isTriggeredEvent(self._index)

	if self._eventType == PPLMapCell.Battle or self._eventType == PPLMapCell.Box then
		return isTriggered
	else
		return true
	end
end

function PPLMapCell:getEventId()
	return self._cfg.eventId
end

function PPLMapCell:getIconResPath(resName)
	return string.format("%s%s.png", PowerPillaLevelViewPresentor.PrefixPath, resName)
end

function PPLMapCell:_setIcon()
	local isTriggered = PowerPillaModel.instance:isTriggeredEvent(self._index)

	self:_clearBossSpine(self._root)
	self:_clearNpcSpine()

	local isShowIcon = false
	local isTryShowBubble = true
	local npcId = self._cfg.npcId
	local showPath = self._cfg.showPath
	local isShowSpecial = not GameUtil.isEmptyString(showPath)

	if self._eventType == PPLMapCell.Obstacle then
		if npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			isShowIcon = true

			if not isShowSpecial then
				showPath = self._stageCfg.stonePath
			end

			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))
		end
	elseif self._eventType == PPLMapCell.Entrance then
		isShowIcon = true

		if not isShowSpecial then
			showPath = self._stageCfg.entrancePath
		end

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))
	elseif self._eventType == PPLMapCell.Exit then
		if npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			isShowIcon = true

			if not isShowSpecial then
				showPath = self._stageCfg.exitPath
			end

			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))
		end
	elseif self._eventType == PPLMapCell.Battle then
		if isTriggered then
			isTryShowBubble = false
		elseif npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			local monsterData = PowerPillaConfig.instance:getMonsterCfgByEventId(self:getEventId())

			if monsterData then
				isShowIcon = true

				if not isShowSpecial then
					showPath = PowerPillaLevelViewPresentor.PrefixPath .. monsterData.iconPath .. ".png"
				end

				uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, showPath)
			end
		end
	elseif self._eventType == PPLMapCell.Box then
		if isTriggered then
			isTryShowBubble = false
		elseif npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			isShowIcon = true

			if not isShowSpecial then
				showPath = self._stageCfg.boxPath
			end

			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))
		end
	elseif self._eventType == PPLMapCell.Trap then
		if not isShowSpecial then
			showPath = self._stageCfg.trapPath
		end

		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))

		isShowIcon = self._isTrapActive
		isTryShowBubble = self._isTrapActive
	elseif self._eventType == PPLMapCell.Game then
		if npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			isTryShowBubble = false
		end
	elseif self._eventType == PPLMapCell.Boss then
		if npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			local bossData = PowerPillaConfig.instance:getBossData(self:getEventId())
			local monsterData = PowerPillaConfig.instance:getMonsterCfg(bossData.creepsMasterId)

			if not string.nilorempty(bossData.spinePath) then
				self:_loadBossSpine(self._root, bossData.spinePath, bossData.scale)
			elseif not string.nilorempty(monsterData.iconPath) then
				isShowIcon = true

				if not isShowSpecial then
					showPath = PowerPillaLevelViewPresentor.PrefixPath .. monsterData.iconPath .. ".png"
				end

				uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, showPath)
			end
		end
	elseif self._eventType == PPLMapCell.Branch then
		if npcId > 0 then
			self:_loadNpcSpine(self._root, npcId)
		else
			isShowIcon = true

			if not isShowSpecial then
				showPath = self._stageCfg.branchPath
			end

			uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self:getIconResPath(showPath))
		end
	end

	self:_updateBubble(isTryShowBubble)
	goutil.setActive(self._icon, isShowIcon)
end

function PPLMapCell:updateData()
	self:_setIcon()
end

function PPLMapCell:Update()
	if self._eventType == PPLMapCell.Trap then
		self._trapRecordTime = self._trapRecordTime + Time.deltaTime

		if self._isTrapActive then
			if self._trapRecordTime >= trapShowTime then
				self._trapRecordTime = 0

				goutil.setActive(self._icon, false)

				self._isTrapActive = false
			end
		elseif self._trapRecordTime >= trapSilentTime then
			self._trapRecordTime = 0

			goutil.setActive(self._icon, true)

			self._isTrapActive = true

			GlobalDispatcher:dispatch(GlobalNotify.MPPTrapActive, self._index)
		end
	end
end

function PPLMapCell:getTrapActive()
	return self._isTrapActive
end

function PPLMapCell:_loadBossSpine(mainGo, spinePath, scale)
	if self._bossSpineCtrlPool == nil then
		self._bossSpineCtrlPool = {}
	end

	scale = scale or {}

	local x, y, s = checknumber(scale[1]), checknumber(scale[2]), scale[3]

	if not self._bossSpineCtrlPool[mainGo] then
		local ctrl = PPLBossSpineCtrl.New()

		self._bossSpineCtrlPool[mainGo]:onInit(mainGo, self._view, spinePath, s)
		GameUtil.setLocalPos(mainGo, x, y)

		self._bossSpineCtrlPool[mainGo] = self._bossSpineCtrlPool[mainGo]
	end
end

function PPLMapCell:_clearBossSpine(mainGo)
	if self._bossSpineCtrlPool then
		local ctrl = self._bossSpineCtrlPool[mainGo]

		if ctrl then
			ctrl:onClear()
		end
	end
end

function PPLMapCell:_clearAllBossSpine()
	if self._bossSpineCtrlPool then
		for mainGo, ctrl in pairs(self._bossSpineCtrlPool) do
			self:_clearBossSpine(mainGo)
		end
	end
end

function PPLMapCell:_loadNpcSpine(mainGo, npcId)
	self:_clearNpcSpine()

	local npcData = PowerPillaConfig.instance:getNpcData(npcId)
	local skinId = npcData and npcData.skinId

	if skinId > 0 then
		if not npcData.scale then
			if not npcData.scale[3] then
				local x, y, scale = npcData.scale[1] or 1, npcData.scale[2] or 1, 1

				self._roleLoader = RoleObjectPool.instance:addRoleToParent(self._roleLoader, skinId, mainGo, scale, nil, false, x, y)
			end
		end
	end
end

function PPLMapCell:_clearNpcSpine()
	self._roleLoader = RoleObjectPool.instance:removeRole(self._roleLoader)
end

function PPLMapCell:_clearAllNpcSpine()
	self:_clearNpcSpine()
end

function PPLMapCell:_updateBubble(isTryShow)
	local bubbleId = self._cfg.bubbleId
	local isNeedShow = false

	if isTryShow and bubbleId > 0 then
		local bubbleData = PowerPillaConfig.instance:getBubbleData(bubbleId)
		local bubbleType = bubbleData.bubbleType
		local params = bubbleData.params

		if bubbleType == 1 then
			isNeedShow = true
		elseif bubbleType == 2 then
			local curTimes = PowerPillaModel.instance:getFightBossTimesOfStage(self._stage)
			local needTimes = checknumber(params)

			isNeedShow = needTimes <= curTimes
		end

		if isNeedShow then
			self._bubble._txtDesc.text = bubbleData.desc

			if not bubbleData.scale then
				local scale = {}
				local x, y, s = checknumber(scale[1]), checknumber(scale[2]), checknumber(scale[3] or 1)

				GameUtil.setLocalPos(self._bubble._mainGo, x, y)
				GameUtil.setLocalScale(self._bubble._mainGo, s, 1, 1)
				GameUtil.setLocalScale(self._bubble._txtDesc.gameObject, s, 1, 1)
			end
		end
	end

	GameUtil.SetActive(self._bubble._mainGo, isNeedShow)

	if isNeedShow then
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bubble._mainGo:GetComponent(goutil.Type_RectTransform))
	end
end

return PPLMapCell
