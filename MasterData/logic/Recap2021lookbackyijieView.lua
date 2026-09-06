-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackyijieView.lua

module("logic.extensions.recap2021.view.Recap2021lookbackyijieView", package.seeall)

local Recap2021lookbackyijieView = class("Recap2021lookbackyijieView", ViewComponent)

function Recap2021lookbackyijieView:ctor()
	Recap2021lookbackyijieView.super.ctor(self)
end

function Recap2021lookbackyijieView:unbindEvents()
	Recap2021lookbackyijieView.super.unbindEvents(self)
end

function Recap2021lookbackyijieView:bindEvents()
	Recap2021lookbackyijieView.super.bindEvents(self)
end

function Recap2021lookbackyijieView:buildUI()
	Recap2021lookbackyijieView.super.buildUI(self)

	self._txtPart1_1 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc1/txt")
	self._txtPart1_2 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc2/txt")
	self._txtPart1_3 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc3/txt")
	self._txtPart1_4 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc4/txt")
	self._txtPart1_5 = goutil.findChildTextComponent(self.mainGO, "part1/root/desc5/txt")
	self._part1Go = self:getGo("part1")
	self._goEmoj = self:getGo("emoj")
	self._p1_descGo1 = self:getGo("part1/root/desc1")
	self._p1_descGo2 = self:getGo("part1/root/desc2")
	self._p1_descGo3 = self:getGo("part1/root/desc3")
end

function Recap2021lookbackyijieView:onExit()
	Recap2021lookbackyijieView.super.onExit(self)
	MaterialMgr.resetAll(self._goEmoj)
	removetimer(self._updateItemsPos, self)
end

function Recap2021lookbackyijieView:onEnter()
	Recap2021lookbackyijieView.super.onEnter(self)

	self._personLookbackMo = self:getFirstParam()

	self:_perMoveItmes()
	self:_updatePart1()
end

function Recap2021lookbackyijieView:_updatePart1()
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
			self["_txtPart1_" .. i].text = v.noDataDesc or string.format(v.desc, value)
		end
	end
end

function Recap2021lookbackyijieView:_perMoveItmes()
	self._moveDistance = 300
	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)
end

function Recap2021lookbackyijieView:_updateItemsPos()
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

return Recap2021lookbackyijieView
