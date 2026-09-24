-- chunkname: @modules/logic/college/view/other/CollegeBuildingBubbleView.lua

module("modules.logic.college.view.other.CollegeBuildingBubbleView", package.seeall)

local CollegeBuildingBubbleView = class("CollegeBuildingBubbleView", BaseView)

function CollegeBuildingBubbleView:onInitView()
	self._gobubble = gohelper.findChild(self.viewGO, "#go_bubbles/#go_bubble")

	gohelper.setActive(self._gobubble, false)

	self._allRoles = {}

	local sceneView = self.viewContainer:getSceneView()

	self._roleRoot = sceneView:getRoleRoot()
	self._sceneMo = CollegeModel.instance:getSceneMo()
	self._intervalTime = CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.BubbleDialogIntervalTime)
	self._bubbleEggs = {}
	self._curBubbleEgg = nil
end

function CollegeBuildingBubbleView:addEvents()
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusEnd, self.onFocusEnd, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
	CollegeController.instance:registerCallback(CollegeEvent.UpdateBuilding, self._refreshView, self)
end

function CollegeBuildingBubbleView:removeEvents()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusEnd, self.onFocusEnd, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusCancel, self.onFocusCancel, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.UpdateBuilding, self._refreshView, self)
end

function CollegeBuildingBubbleView:onFocusEnd()
	local curFocusData = CollegeModel.instance.curFocusData

	if curFocusData and curFocusData.type == CollegeEnum.SceneType.City then
		if not self._bubbleEggs[curFocusData.id] then
			local cls = _G["CollegeBuildingBubbleEgg_" .. curFocusData.id]

			if cls then
				self._bubbleEggs[curFocusData.id] = cls.New()

				self._bubbleEggs[curFocusData.id]:setRoot(self._gobubble, self._roleRoot)
			end
		end

		if self._bubbleEggs[curFocusData.id] and self._bubbleEggs[curFocusData.id]:canTrigger() then
			self._curBubbleEgg = self._bubbleEggs[curFocusData.id]

			self._curBubbleEgg:beginTrigger()
		else
			self._curForcusData = curFocusData
			self._randomPos = {}
			self._usedPos = {}

			local posStr = curFocusData.co.chessPos

			if not string.nilorempty(posStr) then
				local arr = GameUtil.splitString2(posStr, true)

				for i, v in ipairs(arr) do
					table.insert(self._randomPos, Vector3.New(v[1], v[2], v[3]))
				end
			end
		end

		self:_refreshView()
	end
end

function CollegeBuildingBubbleView:onFocusCancel()
	if self._curForcusData then
		self._curForcusData = nil

		self:_refreshView()
	end

	if self._curBubbleEgg then
		self._curBubbleEgg:endTrigger()

		self._curBubbleEgg = nil
	end
end

function CollegeBuildingBubbleView:_refreshView()
	if not self._curForcusData or #self._curForcusData.slotCharacterUid == 0 or self._curBubbleEgg then
		self:cancelBubble()
	else
		self:beginBubble(self._curForcusData.characterUidIndex)
	end
end

function CollegeBuildingBubbleView:beginBubble(characterUidIndex)
	local noUse = {}

	for uid, v in pairs(self._allRoles) do
		if not characterUidIndex[uid] then
			table.insert(noUse, v)

			self._allRoles[uid] = nil
		end
	end

	for uid in pairs(characterUidIndex) do
		self._allRoles[uid] = self._allRoles[uid] or self:createRoleByUid(uid, table.remove(noUse))
	end

	for i, v in ipairs(noUse) do
		table.insert(self._randomPos, self._usedPos[v.data.uid])
		v:destory()
	end

	if not self._isRunning then
		self._isRunning = true

		TaskDispatcher.runRepeat(self._randomBubble, self, self._intervalTime, -1)
		self:_randomBubble()
	end
end

function CollegeBuildingBubbleView:createRoleByUid(uid, role)
	local characterMo = self._sceneMo.characterBox:getCharacterMo(uid)

	if not characterMo then
		return
	end

	if not role then
		local randomIndex = math.random(1, #self._randomPos)
		local pos = table.remove(self._randomPos, randomIndex)

		if not pos then
			return
		end

		self._usedPos[uid] = pos

		local go = gohelper.create3d(self._roleRoot, "character" .. characterMo.id)

		transformhelper.setLocalPos(go.transform, pos.x, pos.y, pos.z)

		role = MonoHelper.addNoUpdateLuaComOnceToGo(go, CollegeRoleItem)
		self._uiPool = self._uiPool or self:getUserDataTb_()

		local ui = table.remove(self._uiPool) or gohelper.cloneInPlace(self._gobubble)

		role:setUI(ui, self._uiPool)
	else
		role.go.name = "character" .. characterMo.id
	end

	role:setData(characterMo)

	return role
end

function CollegeBuildingBubbleView:cancelBubble()
	for uid in pairs(self._allRoles) do
		table.insert(self._randomPos, self._usedPos[uid])
		self._allRoles[uid]:destory()

		self._allRoles[uid] = nil
	end

	self._isRunning = false

	TaskDispatcher.cancelTask(self._randomBubble, self)
end

function CollegeBuildingBubbleView:_randomBubble()
	if CollegeStoryHelper.instance:isPlayingStory() then
		return
	end

	local list = CollegeConfig.instance:getBubbleByBuildingId(self._curForcusData.id)
	local allCharacterId = {}
	local all = {}

	for k, v in pairs(self._allRoles) do
		allCharacterId[v.data.id] = v

		table.insert(all, v)
	end

	local played = self:getPlayedGroups()
	local useNewGroups = {}
	local pool = {}
	local weight = 0

	for k, v in pairs(list) do
		if (v.actorId == 0 or allCharacterId[v.actorId]) and not played[v.dailyPlayOnce] and v.weight > 0 then
			table.insert(pool, v)

			weight = weight + v.weight
		end
	end

	local count = math.min(#pool, #self._curForcusData.slotCharacterUid)

	if count <= 0 then
		return
	end

	count = 1

	local select = {}
	local select_custom = {}

	if isDebugBuild then
		logWarn("抽取数量:" .. count)

		local ids = ""

		for i, v in ipairs(pool) do
			ids = ids .. v.id .. ","
		end

		logWarn("抽取范围:" .. ids)
	end

	for i = 1, count do
		if #pool <= 0 then
			break
		end

		local random = math.random(weight)
		local index = 0

		for k, v in ipairs(pool) do
			index = index + v.weight

			if random <= index then
				if v.actorId == 0 then
					table.insert(select, v)
				else
					table.insert(select_custom, v)
				end

				table.remove(pool, k)

				if isDebugBuild then
					logWarn("抽取ID:" .. v.id)
				end

				if v.dailyPlayOnce > 0 then
					played[v.dailyPlayOnce] = true
					useNewGroups[v.dailyPlayOnce] = true

					for idx = #pool, 1, -1 do
						if pool[idx].dailyPlayOnce == v.dailyPlayOnce then
							weight = weight - pool[idx].weight

							table.remove(pool, idx)
						end
					end
				end

				weight = weight - v.weight

				break
			end
		end
	end

	for i, v in ipairs(select_custom) do
		local comp = allCharacterId[v.actorId]

		if comp then
			comp:playDialog(v.text, v.position)
			tabletool.removeValue(all, comp)
		end
	end

	for i, v in ipairs(select) do
		if #all <= 0 then
			break
		end

		local random = math.random(#all)
		local comp = all[random]

		comp:playDialog(v.text, v.position)
		table.remove(all, random)
	end

	if next(useNewGroups) then
		self:savePlayedGroups()
	end

	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.Bubble)
end

function CollegeBuildingBubbleView:getPlayedGroups()
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)
	local saveDay = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayedTime)

	if str ~= saveDay then
		self._playedGroups = nil

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayed, "")
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayedTime, str)
	end

	if not self._playedGroups then
		self._playedGroups = {}

		local groupStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayed, "")

		if not string.nilorempty(groupStr) then
			for k, v in ipairs(string.split(groupStr, "#")) do
				self._playedGroups[v] = true
			end
		end
	end

	return self._playedGroups
end

function CollegeBuildingBubbleView:savePlayedGroups()
	local str = ""

	for k, v in pairs(self._playedGroups) do
		str = str .. k .. "#"
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeBubbleGroupPlayed, str)
end

function CollegeBuildingBubbleView:onClose()
	TaskDispatcher.cancelTask(self._randomBubble, self)

	for i, v in pairs(self._bubbleEggs) do
		v:clear()
	end
end

return CollegeBuildingBubbleView
