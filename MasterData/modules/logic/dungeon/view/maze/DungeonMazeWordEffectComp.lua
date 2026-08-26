-- chunkname: @modules/logic/dungeon/view/maze/DungeonMazeWordEffectComp.lua

module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectComp", package.seeall)

local DungeonMazeWordEffectComp = class("DungeonMazeWordEffectComp", LuaCompBase)

function DungeonMazeWordEffectComp:ctor(params)
	self._co = params.co
	self._res = params.res
	self._done = params.done
end

function DungeonMazeWordEffectComp:init(go)
	self.go = go
	self._line1 = gohelper.findChild(go, "item/line1")
	self._line2 = gohelper.findChild(go, "item/line2")
	self._effect = gohelper.findChild(go, "item/effect")
	self._animEffect = self._effect:GetComponent(gohelper.Type_Animator)

	self:createTxt()
end

function DungeonMazeWordEffectComp:createTxt()
	local oneWordTime = Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose

	self._allAnimWork = {}

	local arr = string.split(self._co.desc, "\n")
	local words1 = LuaUtil.getUCharArr(arr[1]) or {}
	local offsetX = 0

	for i = 1, #words1 do
		local txtAnim, txt = self:getRes(self._line1, false)

		txt.text = words1[i]

		transformhelper.setLocalPosXY(txtAnim.transform, offsetX, (i % 2 == 1 or nil) and (-Season166Enum.WordTxtPosYOffset or Season166Enum.WordTxtPosYOffset))

		offsetX = offsetX + txt.preferredWidth + Season166Enum.WordTxtPosXOffset

		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + oneWordTime - Season166Enum.WordTxtClose
		})
	end

	offsetX = 0

	local words2 = LuaUtil.getUCharArr(arr[2]) or {}

	for i = 1, #words2 do
		local txtAnim, txt = self:getRes(self._line2, false)

		txt.text = words2[i]

		transformhelper.setLocalPosXY(txtAnim.transform, offsetX, (i % 2 == 1 or nil) and (-Season166Enum.WordTxtPosYOffset or Season166Enum.WordTxtPosYOffset))

		offsetX = offsetX + txt.preferredWidth + Season166Enum.WordTxtPosXOffset

		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(self._allAnimWork, {
			playAnim = "close",
			anim = txtAnim,
			time = (i - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + oneWordTime - Season166Enum.WordTxtClose
		})
	end

	local line1TotalTime = oneWordTime + Season166Enum.WordTxtInterval * (#words1 - 1)
	local totalTime = math.max(line1TotalTime, (#words2 > 0 or nil) and oneWordTime + Season166Enum.WordTxtInterval * (#words2 - 1))

	table.insert(self._allAnimWork, {
		showEndEffect = true,
		time = totalTime - Season166Enum.WordTxtClose
	})
	table.insert(self._allAnimWork, {
		destroy = false,
		time = totalTime
	})
	table.sort(self._allAnimWork, Season166WordEffectComp.sortAnim)
	self:nextStep()
end

function DungeonMazeWordEffectComp:nextStep()
	TaskDispatcher.cancelTask(self.nextStep, self)

	local work = table.remove(self._allAnimWork, 1)

	if not work then
		return
	end

	if work.destroy then
		gohelper.destroy(self.go)

		return
	elseif work.showEndEffect then
		self._animEffect:Play(UIAnimationName.Close, 0, 0)
	elseif work.playAnim == "open" then
		work.anim.enabled = true
	end

	local nextWork = self._allAnimWork[1]

	if not nextWork then
		return
	end

	TaskDispatcher.runDelay(self.nextStep, self, nextWork.time - work.time)
end

function DungeonMazeWordEffectComp.sortAnim(a, b)
	return a.time < b.time
end

local Type_Animtor = typeof(UnityEngine.Animator)

function DungeonMazeWordEffectComp:getRes(root, isImage)
	local go = gohelper.clone(self._res, root)
	local image = gohelper.findChildSingleImage(go, "img")
	local txt = gohelper.findChildTextMesh(go, "txt")
	local anim = go:GetComponent(Type_Animtor)

	gohelper.setActive(image, isImage)
	gohelper.setActive(txt, not isImage)
	gohelper.setActive(go, true)
	anim:Play("open", 0, 0)
	anim:Update(0)

	anim.enabled = false

	return anim, isImage and image or txt
end

function DungeonMazeWordEffectComp:onDestroy()
	TaskDispatcher.cancelTask(self.nextStep, self)
end

return DungeonMazeWordEffectComp
