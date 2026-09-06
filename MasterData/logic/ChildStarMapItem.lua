-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/view/ChildStarMapItem.lua

module("logic.extensions.dragondishitian.view.ChildChildStarMapItem", package.seeall)

local ChildStarMapItem = class("ChildChildStarMapItem")

function ChildStarMapItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._lines = goutil.findChild(go, "lines")
	self._stars = goutil.findChild(go, "stars")
	self._lineRecordPos = self._lines:GetComponent("TestRecordPos")
	self._starRecordPos = self._stars:GetComponent("TestRecordPos")
	self._starGo = goutil.findChild(go, "baseGos/starGo")
	self._lineGo = goutil.findChild(go, "baseGos/lineGo")

	goutil.setActive(self._starGo, false)
	goutil.setActive(self._lineGo, false)

	self._starList = {}
	self._lineList = {}
end

function ChildStarMapItem:init(activityId, chapterId, stageId, conditionId)
	self._activityId = activityId
	self._chapterId = chapterId
	self._stageId = stageId
	self._conditionId = conditionId

	self:_refreshStars()
end

function ChildStarMapItem:reset()
	return
end

function ChildStarMapItem:_refreshStars()
	local cfgStage = DragonDishitianConfig.instance:getStageCfg(self._activityId, self._chapterId, self._stageId)

	for indexNum, conditionId in ipairs(cfgStage.conditionIds) do
		if conditionId == self._conditionId then
			local starIds = cfgStage.starIds[indexNum]
			local starNum = #starIds

			if starNum > #self._starList then
				local addNum = starNum - #self._starList
				local count = #self._starList

				for i = 1, addNum do
					local cell = {}
					local index = count + i

					cell.go = goutil.cloneAndSetParent(self._starGo, self._stars.transform, "star_" .. index)
					cell.effectGo = goutil.findChild(cell.go, "effect")

					GameUtil.SetActive(cell.effectGo, false)

					self._starList[index] = cell
				end
			end

			for i, v in ipairs(self._starList) do
				goutil.setActive(v.go, i <= starNum)
			end

			local lineNum = starNum - 1

			if lineNum > #self._lineList then
				local addNum = lineNum - #self._lineList
				local count = #self._lineList

				for i = 1, addNum do
					local index = count + i
					local cell = {}

					cell.go = goutil.cloneAndSetParent(self._lineGo, self._lines.transform, "line_" .. index)
					self._lineList[index] = cell
				end
			end

			for i, v in ipairs(self._lineList) do
				goutil.setActive(v.go, i <= lineNum)
			end

			self._lineRecordPos:LoadPlan(cfgStage.childStarMapIds[indexNum])
			self._starRecordPos:LoadPlan(cfgStage.childStarMapIds[indexNum])

			break
		end
	end
end

return ChildStarMapItem
