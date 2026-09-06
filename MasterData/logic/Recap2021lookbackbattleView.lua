-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackbattleView.lua

module("logic.extensions.recap2021.view.Recap2021lookbackbattleView", package.seeall)

local Recap2021lookbackbattleView = class("Recap2021lookbackbattleView", ViewComponent)

function Recap2021lookbackbattleView:ctor()
	Recap2021lookbackbattleView.super.ctor(self)
end

function Recap2021lookbackbattleView:unbindEvents()
	Recap2021lookbackbattleView.super.unbindEvents(self)
end

function Recap2021lookbackbattleView:bindEvents()
	Recap2021lookbackbattleView.super.bindEvents(self)
end

function Recap2021lookbackbattleView:buildUI()
	Recap2021lookbackbattleView.super.buildUI(self)

	self._txt1 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc1/txt")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txt2 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc2/txt")
	self._txt3 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc3/txt")
	self._txt6 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc6/txt")
	self._txt5 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc5/txt")
	self._txt4 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc4/txt")
	self._txtOver = goutil.findChildTextComponent(self.mainGO, "part2/bg1/root/txtOver")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "part2/bg1/root/txtDesc")
	self._txtTag = goutil.findChildTextComponent(self.mainGO, "part2/bg2/root/txtTag")
	self._p1_descGo1 = self:getGo("part1/root/desc1")
	self._p1_descGo2 = self:getGo("part1/root/desc2")
	self._p1_descGo4 = self:getGo("part1/root/desc4")
	self._p1_descGo3 = self:getGo("part1/root/desc3")
	self._p2_rootGo1 = self:getGo("part2/bg1/root")
	self._p2_rootGo2 = self:getGo("part2/bg2/root")
	self._part2Go = self:getGo("part2")
	self._part1Go = self:getGo("part1")
end

function Recap2021lookbackbattleView:onExit()
	Recap2021lookbackbattleView.super.onExit(self)
	removetimer(self._updateItemsPos, self)
end

function Recap2021lookbackbattleView:onEnter()
	Recap2021lookbackbattleView.super.onEnter(self)

	self._personLookbackMo = self:getFirstParam()

	local partNum = checkint(self._personLookbackMo:getParam())

	goutil.setActive(self._part1Go, partNum == 1)
	goutil.setActive(self._part2Go, partNum == 2)
	self:_perMoveItmes()

	if partNum == 1 then
		self:_updatePart1()
	elseif partNum == 2 then
		self:_updatePart2()
	end

	self._txtTitle.text = self._personLookbackMo:getTitleName()
end

function Recap2021lookbackbattleView:_updatePart1()
	local cfgs = self._personLookbackMo:getCfgs()

	for i, v in ipairs(cfgs) do
		local value = Recap2021Model.instance:getDescByDataId(v.dataId)
		local go = self["_p1_descGo" .. i]
		local canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 0

		local transform = go.transform
		local startPosX = self._moveDistance + (i - 1) * 80
		local x, y = Framework.TransformUtil.GetAnchoredPos(transform, 0, 0)

		Framework.TransformUtil.SetAnchoredPos(transform, startPosX, y)

		self._needMoveItems[go] = {
			currPosX = 0,
			isFinish = false,
			endPosX = 0,
			runTime = 0,
			transform = transform,
			canvasGroup = canvasGroup,
			startTime = self._duration * 0.8 * (i - 1),
			startPosX = startPosX,
			posY = y
		}

		if (Recap2021Model.instance:isNumberValueByDataId(v.dataId) and checknumber(value) < 0 or nil) and true then
			self["_txt" .. i].text = v.noDataDesc or string.format(v.desc, value)
		end
	end
end

function Recap2021lookbackbattleView:_updatePart2()
	local cfgs = self._personLookbackMo:getCfgs()
	local value = Recap2021Model.instance:getDescByDataId(cfgs[1].dataId)
	local vnum = checknumber(value)

	self._txtDesc.text = vnum <= 0 and cfgs[1].noDataDesc or string.format(cfgs[1].desc, value)
	self._txtOver.text = "超过全服<color=#657CB2FF><size=26>0%</size></color>的玩家"

	if vnum ~= -1 and cfgs[1].overPlanId > 0 then
		local ocfgs = Recap2021Config.instance:getOverPlanCfgs(cfgs[1].overPlanId)

		value = checkint(value)

		for _, ocfg in ipairs(ocfgs) do
			local nums = string.split(ocfg.verifyStr, ",")
			local num1 = checkint(nums[1])
			local num2 = checkint(nums[2])

			if num2 == -1 or num1 <= value and value <= num2 then
				self._txtOver.text = ocfg.desc

				break
			end
		end
	end

	for i = 1, 2 do
		local go = self["_p2_rootGo" .. i]
		local canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))

		canvasGroup.alpha = 0

		local transform = go.transform
		local startPosX = self._moveDistance * (i == 1 and -1 or 1)
		local x, y = Framework.TransformUtil.GetAnchoredPos(transform, 0, 0)

		Framework.TransformUtil.SetAnchoredPos(transform, startPosX, y)

		self._needMoveItems[go] = {
			currPosX = 0,
			isFinish = false,
			endPosX = 0,
			runTime = 0,
			transform = transform,
			canvasGroup = canvasGroup,
			startTime = self._duration * 0.8 * (i - 1),
			startPosX = startPosX,
			posY = y
		}
	end

	self:_setTag()
end

function Recap2021lookbackbattleView:_setTag()
	local tagPlanId = self._personLookbackMo:getTagPlanId()
	local tagCfgs = Recap2021Config.instance:getPersonLookBackTagCfgs(tagPlanId)

	self._txtTag.text = tagCfgs and tagCfgs[1] and tagCfgs[1].isBattleTag and Recap2021Model.instance:getBattleTagDesc(tagPlanId) or Recap2021Model.instance:getBestTagDesc(tagPlanId, 1)
end

function Recap2021lookbackbattleView:_perMoveItmes()
	self._moveDistance = 300
	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)
end

function Recap2021lookbackbattleView:_updateItemsPos()
	self._runTime = self._runTime + Time.deltaTime

	local isMove = false

	for k, v in pairs(self._needMoveItems) do
		if not v.isFinish then
			isMove = true

			if self._runTime >= v.startTime then
				if v.runTime < self._duration then
					local percent = v.runTime / self._duration

					v.runTime = v.runTime + Time.deltaTime
					v.canvasGroup.alpha = percent
					v.currPosX = v.startPosX - (v.startPosX - v.endPosX) * percent
				else
					v.currPosX = v.endPosX
					v.canvasGroup.alpha = 1
					v.isFinish = true
				end

				Framework.TransformUtil.SetAnchoredPos(v.transform, v.currPosX, v.posY)
			end
		end
	end

	if not isMove then
		removetimer(self._updateItemsPos, self)
	end
end

return Recap2021lookbackbattleView
