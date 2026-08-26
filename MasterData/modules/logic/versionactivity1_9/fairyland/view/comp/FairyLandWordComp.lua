-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/comp/FairyLandWordComp.lua

module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandWordComp", package.seeall)

local FairyLandWordComp = class("FairyLandWordComp", LuaCompBase)

FairyLandWordComp.WordInterval = 3.5
FairyLandWordComp.WordTxtPosYOffset = 5
FairyLandWordComp.WordTxtPosXOffset = 2
FairyLandWordComp.WordTxtInterval = 0.1
FairyLandWordComp.WordTxtOpen = 0.5
FairyLandWordComp.WordTxtIdle = 1.1
FairyLandWordComp.WordTxtClose = 0.5
FairyLandWordComp.WordLine2Delay = 1

function FairyLandWordComp:ctor(params)
	self._co = params.co
	self._res1 = params.res1
	self._res2 = params.res2
end

function FairyLandWordComp:init(go)
	self.go = go

	self:createTxt()
end

function FairyLandWordComp:createTxt()
	local oneWordTime = FairyLandWordComp.WordTxtOpen + FairyLandWordComp.WordTxtIdle + FairyLandWordComp.WordTxtClose

	self._allAnimWork = {}

	local text1 = self._co.question
	local text2 = string.format("——%s", self._co.answer)
	local words1 = LuaUtil.getUCharArr(text1) or {}
	local offsetX = 0
	local index = 1

	for i = 1, #words1 do
		local txtAnim, txt = self:getRes(self.go, self._res1)

		txt.text = words1[i]

		transformhelper.setLocalPosXY(txtAnim.transform, offsetX, (index % 2 == 1 or nil) and (-FairyLandWordComp.WordTxtPosYOffset or FairyLandWordComp.WordTxtPosYOffset))

		offsetX = offsetX + txt.preferredWidth + FairyLandWordComp.WordTxtPosXOffset

		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (index - 1) * FairyLandWordComp.WordTxtInterval
		})

		index = index + 1
	end

	local words2 = LuaUtil.getUCharArr(text2) or {}

	for i = 1, #words2 do
		local txtAnim, txt = self:getRes(self.go, self._res2)

		txt.text = words2[i]

		transformhelper.setLocalPosXY(txtAnim.transform, offsetX, (index % 2 == 1 or nil) and (-FairyLandWordComp.WordTxtPosYOffset or FairyLandWordComp.WordTxtPosYOffset))

		offsetX = offsetX + txt.preferredWidth + FairyLandWordComp.WordTxtPosXOffset

		table.insert(self._allAnimWork, {
			playAnim = "open",
			anim = txtAnim,
			time = (index - 1) * FairyLandWordComp.WordTxtInterval
		})

		index = index + 1
	end

	local line1TotalTime = oneWordTime + FairyLandWordComp.WordTxtInterval * (#words1 - 1)
	local totalTime = math.max(line1TotalTime, (#words2 > 0 or nil) and oneWordTime + FairyLandWordComp.WordTxtInterval * (#words2 - 1))

	table.sort(self._allAnimWork, FairyLandWordComp.sortAnim)
	recthelper.setAnchor(self.go.transform, -offsetX + 40, 0)
	self:nextStep()
end

function FairyLandWordComp:nextStep()
	TaskDispatcher.cancelTask(self.nextStep, self)

	local work = table.remove(self._allAnimWork, 1)

	if not work then
		return
	end

	if work.destroy then
		gohelper.destroy(self.go)

		return
	elseif work.playAnim == "open" then
		work.anim.enabled = true
	else
		work.anim:Play(work.playAnim, 0, 0)
	end

	local nextWork = self._allAnimWork[1]

	if not nextWork then
		return
	end

	TaskDispatcher.runDelay(self.nextStep, self, nextWork.time - work.time)
end

function FairyLandWordComp.sortAnim(a, b)
	return a.time < b.time
end

local Type_Animtor = typeof(UnityEngine.Animator)

function FairyLandWordComp:getRes(root, res)
	local go = gohelper.clone(res, root)
	local txt = gohelper.findChildTextMesh(go, "txt")
	local anim = go:GetComponent(Type_Animtor)

	gohelper.setActive(go, true)
	anim:Play("open", 0, 0)
	anim:Update(0)

	anim.enabled = false

	return anim, txt
end

function FairyLandWordComp:onDestroy()
	TaskDispatcher.cancelTask(self.nextStep, self)
end

return FairyLandWordComp
