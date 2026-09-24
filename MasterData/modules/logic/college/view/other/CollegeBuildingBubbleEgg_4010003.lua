-- chunkname: @modules/logic/college/view/other/CollegeBuildingBubbleEgg_4010003.lua

module("modules.logic.college.view.other.CollegeBuildingBubbleEgg_4010003", package.seeall)

local CollegeBuildingBubbleEgg_4010003 = class("CollegeBuildingBubbleEgg_4010003", CollegeBuildingBubbleEggBase)

function CollegeBuildingBubbleEgg_4010003:canTrigger()
	local rate = CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.GreenhouseEggProbability)

	if rate >= math.random() * 100 then
		return true
	end

	return false
end

function CollegeBuildingBubbleEgg_4010003:beginTrigger()
	self.allCo = {}

	local weight = 0

	for i, v in ipairs(lua_college_bubble_group.configList) do
		if v.type == 3 then
			table.insert(self.allCo, v)

			weight = weight + v.weight
		end
	end

	if weight <= 0 then
		logError("气泡组随机失败，没有可选的气泡组")

		return
	end

	local selectBubbleId
	local randomWeight = math.random(1, weight)

	for k, v in pairs(self.allCo) do
		randomWeight = randomWeight - v.weight

		if randomWeight <= 0 then
			selectBubbleId = v.id

			break
		end
	end

	self._stepList = lua_college_bubble_group_step.configDict[selectBubbleId]

	if not self._stepList then
		logError("气泡组没有配对应的步骤" .. tostring(selectBubbleId))

		return
	end

	local intervalStr = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.GreenhouseEggInterval)

	self._minInterval = 0
	self._maxInterval = 0

	if not string.nilorempty(intervalStr) then
		local arr = string.splitToNumber(intervalStr, "#")

		self._minInterval = arr[1] or 0
		self._maxInterval = arr[2] or 0
	end

	self._chessList = {}

	self:loadAllChess()
	TaskDispatcher.runDelay(self.beginPlay, self, 0.5)
end

function CollegeBuildingBubbleEgg_4010003:beginPlay()
	self._curIndex = 0

	self:playNextStep()
end

function CollegeBuildingBubbleEgg_4010003:loadAllChess()
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

			role:setScaleX(v.chessPosition)

			if v.actorId > 0 then
				role:setActorId(v.actorId)
			else
				local path = CollegeConfig.instance:getConstVal(CollegeEnum.ConstId.GreenhouseEggChessModel)

				role:setPath(path)
			end

			local ui = gohelper.cloneInPlace(self._bubbleUI)

			role:setUI(ui)

			self._chessList[v.actorId] = role
		end
	end
end

function CollegeBuildingBubbleEgg_4010003:playNextStep()
	if CollegeStoryHelper.instance:isPlayingStory() then
		return
	end

	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._stepList then
		self:onFinishBubble()

		return
	end

	local step = self._stepList[self._curIndex]
	local name = step.name
	local role = self._chessList[step.actorId]

	if not string.nilorempty(name) then
		role:setName(name)
	end

	role:playDialog(step.text, step.position, self.playNextStep, self)
end

function CollegeBuildingBubbleEgg_4010003:onFinishBubble()
	local interval = self._minInterval + math.random(0, self._maxInterval - self._minInterval)

	TaskDispatcher.runDelay(self.beginPlay, self, interval)
end

function CollegeBuildingBubbleEgg_4010003:endTrigger()
	self:releaseRes()
end

function CollegeBuildingBubbleEgg_4010003:releaseRes()
	if self._chessList then
		for k, v in pairs(self._chessList) do
			v:destory()
		end

		self._chessList = {}
	end

	TaskDispatcher.cancelTask(self.beginPlay, self)
end

function CollegeBuildingBubbleEgg_4010003:clear()
	self:releaseRes()
	CollegeBuildingBubbleEgg_4010003.super.clear(self)
end

return CollegeBuildingBubbleEgg_4010003
