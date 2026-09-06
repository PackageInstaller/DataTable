-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayEvaluateView.lua

module("logic.extensions.newyearpray.view.NewYearPrayEvaluateView", package.seeall)

local NewYearPrayEvaluateView = class("NewYearPrayEvaluateView", ViewComponent)

function NewYearPrayEvaluateView:buildUI()
	NewYearPrayEvaluateView.super.buildUI(self)

	self._txtTitle = goutil.findChild(self.mainGO, "txtTitle")
	self._descView = goutil.findChild(self.mainGO, "descView")
	self._customInput = UICustomInput.Get(self.mainGO)
	self._txtTipGo = goutil.findChild(self.mainGO, "txtTip")

	GameUtil.SetActive(self._descCell, false)
end

function NewYearPrayEvaluateView:bindEvents()
	NewYearPrayEvaluateView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function NewYearPrayEvaluateView:unbindEvents()
	NewYearPrayEvaluateView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function NewYearPrayEvaluateView:onEnter()
	NewYearPrayEvaluateView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._curStepId = checknumber(params[2])
	self._activityType = NewYearPrayController.instance:getActivityType()

	local isInTime = NewYearPrayController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	if self._curStepId <= 0 then
		self:close()

		return
	end

	self._actData = NewYearPrayConfig.instance:getNypActData(self._activityId)
	self._isCanExit = false

	self.addGEvent(self, GlobalNotify.handlePM_NewYearPrayDoPrayRes, self._onUpdate, self)
	self:_onUpdate()
	GameUtil.SetActive(self._txtTipGo, false)
	settimer(2, self._canExit, self)
end

function NewYearPrayEvaluateView:onExit()
	NewYearPrayEvaluateView.super.onExit(self)
	removetimer(self._canExit, self)
	self:_onClearDescCol()
end

function NewYearPrayEvaluateView:_onUpdate()
	self:_onUpdateDescColUI()
end

function NewYearPrayEvaluateView:_onUpdateDescColUI()
	local parentTran = self._descView.transform
	local children = GameUtil.getChildren(parentTran)
	local cfgs = NewYearPrayConfig.instance:getNypStepCfgs(self._activityId)
	local cfg = {}

	for stepId, v in ipairs(cfgs) do
		table.insert(cfg, stepId)
	end

	if cfg then
		if not #cfg then
			local length = 0

			if cfg then
				for idx, stepId in ipairs(cfg) do
					local mainGo = children[idx]

					self:_updateDescCell(mainGo, idx, stepId)
				end
			end

			for idx = 1, parentTran.childCount do
				local mainGo = parentTran:GetChild(idx - 1)

				if idx <= length then
					GameUtil.SetActive(mainGo, true)
				else
					self:_clearGridCell(mainGo)
					GameUtil.SetActive(mainGo, false)
				end
			end
		end
	end
end

function NewYearPrayEvaluateView:_onClearDescCol()
	local parentTran = self._descView.transform
	local children = GameUtil.getChildren(parentTran)

	for _, mainGo in pairs(children) do
		self:_clearDescCell(mainGo)
	end
end

function NewYearPrayEvaluateView:_updateDescCell(mainGo, idx, stepId)
	local score = NewYearPrayController.instance:getScoreOfStep(self._activityId, stepId)
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")
	local goodView = goutil.findChild(mainGo, "goodView")
	local children = GameUtil.getChildren(goodView)

	for idx, childGo in ipairs(children) do
		local blackMask = goutil.findChild(childGo, "blackMask")

		GameUtil.SetActive(blackMask, score < idx)
	end
end

function NewYearPrayEvaluateView:_clearDescCell(mainGo)
	return
end

function NewYearPrayEvaluateView:_onCustomInputCallback(hover)
	if self._isCanExit and not hover then
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.NewYearPraySceneViewOfNextScene)
	end
end

function NewYearPrayEvaluateView:_canExit()
	self._isCanExit = true

	GameUtil.SetActive(self._txtTipGo, true)
end

return NewYearPrayEvaluateView
