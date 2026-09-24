-- chunkname: @modules/logic/college/view/other/CollegeSceneBubbleView.lua

module("modules.logic.college.view.other.CollegeSceneBubbleView", package.seeall)

local CollegeSceneBubbleView = class("CollegeSceneBubbleView", BaseView)

function CollegeSceneBubbleView:onInitView()
	self._gobubble = gohelper.findChild(self.viewGO, "#go_bubbles/#go_bubble")
	self._gobubbleRoot = gohelper.findChild(self.viewGO, "#go_full/#go_city")

	local sceneView = self.viewContainer:getSceneView()

	self._roleRoot = sceneView:getRoleRoot()
end

function CollegeSceneBubbleView:addEvents()
	CollegeController.instance:registerCallback(CollegeEvent.OnMainViewPlayOpenAnim, self.randomBubble, self)
	CollegeController.instance:registerCallback(CollegeEvent.OnFocusBegin, self.onFocusBegin, self)
end

function CollegeSceneBubbleView:removeEvents()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnMainViewPlayOpenAnim, self.randomBubble, self)
	CollegeController.instance:unregisterCallback(CollegeEvent.OnFocusBegin, self.onFocusBegin, self)
end

function CollegeSceneBubbleView:onOpen()
	self.allCo = {}

	for i, v in ipairs(lua_college_bubble_group.configList) do
		if v.type == 2 then
			table.insert(self.allCo, v)
		end
	end

	local intervalStr = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.OutdoorChessDialogInterval)

	self._minInterval = 0
	self._maxInterval = 0

	if not string.nilorempty(intervalStr) then
		local arr = string.splitToNumber(intervalStr, "#")

		self._minInterval = arr[1] or 0
		self._maxInterval = arr[2] or 0
	end

	self._chessList = {}
end

function CollegeSceneBubbleView:randomBubble()
	if CollegeStoryHelper.instance:getCurStoryType() == "chessDialogue" or CollegeModel.instance.curFocusData then
		self:restartBubble()

		return
	end

	local playedGroup = self:getPlayedGroups()
	local pool = {}
	local weight = 0

	for k, v in pairs(self.allCo) do
		if not playedGroup[v.id] and v.weight > 0 then
			table.insert(pool, v)

			weight = weight + v.weight
		end
	end

	if weight <= 0 then
		logError("气泡组随机失败，没有可选的气泡组")

		return
	end

	local randomWeight = math.random(1, weight)

	for k, v in pairs(pool) do
		randomWeight = randomWeight - v.weight

		if randomWeight <= 0 then
			if v.dailyPlayOnce == 1 then
				self._playedGroups[v.id] = true

				self:savePlayedGroups()
			end

			self:showBubble(v.id)

			return
		end
	end
end

function CollegeSceneBubbleView:showBubble(groupId)
	self._stepList = lua_college_bubble_group_step.configDict[groupId] or {}

	self:loadAllChess()
	TaskDispatcher.runDelay(self._delayPlay, self, 0.5)
end

function CollegeSceneBubbleView:_delayPlay()
	self._curIndex = 0

	self:playNextStep()
end

function CollegeSceneBubbleView:loadAllChess()
	for i, v in ipairs(self._stepList) do
		if not self._chessList[v.actorId] then
			local go = gohelper.create3d(self._roleRoot, string.format("scenebubble_%s_%s", v.groupId, v.step))
			local pos = Vector3.New()

			if not string.nilorempty(v.pos) then
				local arr = string.splitToNumber(v.pos, "#")

				pos:Set(arr[1], arr[2], arr[3])
			end

			transformhelper.setLocalPos(go.transform, pos.x, pos.y, pos.z)

			local role = MonoHelper.addNoUpdateLuaComOnceToGo(go, CollegeRoleItem)

			role:setScale(1)
			role:setScaleX(v.chessPosition)
			role:setActorId(v.actorId)

			self._uiPool = self._uiPool or self:getUserDataTb_()

			local ui = table.remove(self._uiPool) or gohelper.clone(self._gobubble, self._gobubbleRoot)

			role:setUI(ui, self._uiPool)

			self._chessList[v.actorId] = role
		end
	end
end

function CollegeSceneBubbleView:playNextStep()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._stepList then
		self:onFinishBubble()

		return
	end

	local step = self._stepList[self._curIndex]

	self._chessList[step.actorId]:playDialog(step.text, step.position, self.playNextStep, self)
end

function CollegeSceneBubbleView:onFinishBubble()
	if not self._chessList then
		return
	end

	for i, v in pairs(self._chessList) do
		v:playExitAnim()
	end

	self._chessList = {}

	self:restartBubble()
	TaskDispatcher.cancelTask(self._delayPlay, self)
end

function CollegeSceneBubbleView:restartBubble()
	local interval = self._minInterval + math.random(0, self._maxInterval - self._minInterval)

	TaskDispatcher.runDelay(self.randomBubble, self, interval)
end

function CollegeSceneBubbleView:getPlayedGroups()
	local str = TimeUtil.timestampToString1(ServerTime.now() - 18000)
	local saveDay = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayedTime)

	if str ~= saveDay then
		self._playedGroups = nil

		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayed, "")
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayedTime, str)
	end

	if not self._playedGroups then
		self._playedGroups = {}

		local groupStr = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayed, "")

		if not string.nilorempty(groupStr) then
			for k, v in ipairs(string.split(groupStr, "#")) do
				self._playedGroups[v] = true
			end
		end
	end

	return self._playedGroups
end

function CollegeSceneBubbleView:savePlayedGroups()
	local str = ""

	for k, v in pairs(self._playedGroups) do
		str = str .. k .. "#"
	end

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.CollegeSceneBubbleGroupPlayed, str)
end

function CollegeSceneBubbleView:onFocusBegin()
	self:onFinishBubble()
end

function CollegeSceneBubbleView:onClose()
	for i, v in pairs(self._chessList) do
		v:destory()
	end

	self._chessList = {}

	TaskDispatcher.cancelTask(self.randomBubble, self)
	TaskDispatcher.cancelTask(self._delayPlay, self)
end

return CollegeSceneBubbleView
