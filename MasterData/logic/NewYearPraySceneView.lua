-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPraySceneView.lua

module("logic.extensions.newyearpray.view.NewYearPraySceneView", package.seeall)

local NewYearPraySceneView = class("NewYearPraySceneView", ViewComponent)

function NewYearPraySceneView:buildUI()
	NewYearPraySceneView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "leftTop/txtTitle")
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._con = goutil.findChild(self.mainGO, "role/con")
	self._bubble = goutil.findChild(self.mainGO, "role/bubble")
	self._bubble_txt = goutil.findChildTextComponent(self.mainGO, "role/bubble/txt")
end

function NewYearPraySceneView:bindEvents()
	NewYearPraySceneView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
end

function NewYearPraySceneView:unbindEvents()
	NewYearPraySceneView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function NewYearPraySceneView:onEnter()
	NewYearPraySceneView.super.onEnter(self)

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

	self._playerMo = NewYearPrayController.instance:getNypPlayerMo(self._activityId)
	self._actData = NewYearPrayConfig.instance:getNypActData(self._activityId)

	self._playerMo:onReset()
	self.addGEvent(self, GlobalNotify.NewYearPraySceneViewOfNextScene, self._nextStep, self)
	self.addGEvent(self, GlobalNotify.NewYearPraySceneViewOfClose, self.close, self)
	self.addGEvent(self, GlobalNotify.NewYearPraySceneViewOfSpineAnim, self._playAnimSpine, self)
	self.addGEvent(self, GlobalNotify.NewYearPraySceneViewOfBubble, self._showBubble, self)
	self:_onSetUI()
	self:_onUpdate()
end

function NewYearPraySceneView:onExit()
	NewYearPraySceneView.super.onExit(self)
	self:_onClear()
end

function NewYearPraySceneView:_nextStep()
	local stepId = self._playerMo:getCurStepId()

	self._playerMo:setCurStepId(stepId + 1)
	self:_onUpdate()
end

function NewYearPraySceneView:_onSetUI()
	self:_loadSpine()
	self:_showBubble(0)
end

function NewYearPraySceneView:_onUpdate()
	local curStepId = self._playerMo:getCurStepId()

	if curStepId == NypEnum.PrayStep.Wishing then
		self:_showTabAt(ViewName.NewYearPrayWishingLanternView, self._activityId, NypEnum.PrayStep.Wishing)
	elseif curStepId == NypEnum.PrayStep.Lantern then
		self:_showTabAt(ViewName.NewYearPrayBurnLanternView, self._activityId, NypEnum.PrayStep.Lantern)
	elseif curStepId == NypEnum.PrayStep.Evaluate then
		local list = {}
		local cfgs = NewYearPrayConfig.instance:getNypStepCfgs(self._activityId)

		for stepId, cfg in ipairs(cfgs) do
			local info = {}

			info.stepId = stepId
			info.choiceId = self._playerMo:getChoiceId(stepId)

			table.insert(list, info)
		end

		NewYearPrayController.instance:sendPM_NewYearPrayDoPrayReq(self._activityId, list)
		UIStateManager.instance:push(ViewName.NewYearPrayEvaluateView, self._activityId, NypEnum.PrayStep.Evaluate)
	else
		self:close()
	end
end

function NewYearPraySceneView:_onClear()
	self:_onClearTabAt()
end

function NewYearPraySceneView:_showTabAt(viewName, ...)
	self:_onClearTabAt()

	local params = {
		...
	}

	if #params > 0 then
		self:showTabAt(self._contentCol, viewName, unpack(params))
	else
		self:showTabAt(self._contentCol, viewName)
	end
end

function NewYearPraySceneView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")
end

function NewYearPraySceneView:_loadSpine()
	local spineRoot = self._con
	local view = self
	local spinePath = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "spineUrl")
	local pos = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "spinePos")
	local scale = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "spineScale")

	pos = pos or {}

	local posX, posY = checknumber(pos[1]), checknumber(pos[2])

	GameUtil.setLocalPos(self._con, posX, posY)

	scale = scale or {}

	if not scale[2] then
		local scaleX, scaleY = scale[1] or 1, 1

		GameUtil.setLocalScale(self._con, scaleX, scaleY)

		self._spineCtrl = self._spineCtrl or NewYearPraySpineCtrl.New()

		self._spineCtrl:onInit(spineRoot, view, spinePath)
	end
end

function NewYearPraySceneView:_unloadSpine()
	self._spineCtrl = self._spineCtrl or NewYearPraySpineCtrl.New()

	self._spineCtrl:onInit(spineRoot, view, spinePath)
end

function NewYearPraySceneView:_playAnimSpine(animName)
	if self._spineCtrl and not string.nilorempty(animName) then
		self._spineCtrl:_playAnim(animName, true)
	end
end

function NewYearPraySceneView:_showBubble(bubbleId)
	if bubbleId <= 0 then
		GameUtil.SetActive(self._bubble, false)
	else
		local data = NewYearPrayConfig.instance:getNypBubbleData(bubbleId)

		self._bubble_txt.text = data.desc

		GameUtil.SetActive(self._bubble, true)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(self._bubble:GetComponent(goutil.Type_RectTransform))
	end
end

function NewYearPraySceneView:_onClickBtnTip()
	local key = NewYearPrayConfig.instance:getNypCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

return NewYearPraySceneView
