-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackhonorView.lua

module("logic.extensions.recap2021.view.Recap2021lookbackhonorView", package.seeall)

local Recap2021lookbackhonorView = class("Recap2021lookbackhonorView", ViewComponent)

function Recap2021lookbackhonorView:ctor()
	Recap2021lookbackhonorView.super.ctor(self)
end

function Recap2021lookbackhonorView:unbindEvents()
	Recap2021lookbackhonorView.super.unbindEvents(self)
end

function Recap2021lookbackhonorView:bindEvents()
	Recap2021lookbackhonorView.super.bindEvents(self)
end

function Recap2021lookbackhonorView:buildUI()
	Recap2021lookbackhonorView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txt2 = goutil.findChildTextComponent(self.mainGO, "root/desc2/txt")
	self._txt3 = goutil.findChildTextComponent(self.mainGO, "root/desc3/txt")
	self._txt5 = goutil.findChildTextComponent(self.mainGO, "root/desc5/txt")
	self._txt6 = goutil.findChildTextComponent(self.mainGO, "root/desc6/txt")
	self._txt1 = goutil.findChildTextComponent(self.mainGO, "root/desc1/txt")
	self._txt4 = goutil.findChildTextComponent(self.mainGO, "root/desc4/txt")
	self._txtTag = goutil.findChildTextComponent(self.mainGO, "txt")
	self._desc1Go = self:getGo("root/desc1")
	self._desc4Go = self:getGo("root/desc4")
	self._desc5Go = self:getGo("root/desc5")
	self._desc2Go = self:getGo("root/desc2")
	self._desc3Go = self:getGo("root/desc3")
	self._desc6Go = self:getGo("root/desc6")
end

function Recap2021lookbackhonorView:onExit()
	Recap2021lookbackhonorView.super.onExit(self)
	removetimer(self._updateItemsPos, self)
end

function Recap2021lookbackhonorView:onEnter()
	Recap2021lookbackhonorView.super.onEnter(self)

	self._personLookbackMo = self:getFirstParam()
	self._txtTitle.text = self._personLookbackMo:getTitleName()

	local cfgs = self._personLookbackMo:getCfgs()

	for i = 1, 6 do
		self["_txt" .. i].text = ""
	end

	for i, v in ipairs(cfgs) do
		local value = Recap2021Model.instance:getDescByDataId(v.dataId)

		value = checkint(value)

		local baseStr = ""

		baseStr = value <= 0 and v.noDataDesc or string.format(v.desc, value)

		if v.overPlanId > 0 then
			local ocfgs = Recap2021Config.instance:getOverPlanCfgs(v.overPlanId)

			for _, ocfg in ipairs(ocfgs) do
				local nums = string.split(ocfg.verifyStr, ",")
				local num1 = checkint(nums[1])
				local num2 = checkint(nums[2])

				if num2 == -1 or num1 <= value and value <= num2 then
					baseStr = string.format("%s (%s)", baseStr, ocfg.desc)

					break
				end
			end
		end

		self["_txt" .. i].text = baseStr
	end

	self:_setTag()
	self:_onMoveItmes()
end

function Recap2021lookbackhonorView:_onMoveItmes()
	local moveDistance = 300

	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)

	for i = 1, 6 do
		local go = self["_desc" .. i .. "Go"]
		local canvasGroup = go:GetComponent(typeof(UnityEngine.CanvasGroup))
		local transform = go.transform

		canvasGroup.alpha = 0

		local x, y = Framework.TransformUtil.GetAnchoredPos(transform, 0, 0)

		Framework.TransformUtil.SetAnchoredPos(transform, moveDistance + (i - 1) * 80, y)

		self._needMoveItems[go] = {
			currPosX = 0,
			isFinish = false,
			endPosX = 0,
			runTime = 0,
			transform = transform,
			canvasGroup = canvasGroup,
			startTime = self._duration * 0.8 * (i - 1),
			startPosX = moveDistance + (i - 1) * 80,
			posY = y
		}
	end
end

function Recap2021lookbackhonorView:_updateItemsPos()
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

function Recap2021lookbackhonorView:_setTag()
	local tagPlanId = self._personLookbackMo:getTagPlanId()

	self._txtTag.text = Recap2021Model.instance:getBestTagDesc(tagPlanId, 3)
end

return Recap2021lookbackhonorView
