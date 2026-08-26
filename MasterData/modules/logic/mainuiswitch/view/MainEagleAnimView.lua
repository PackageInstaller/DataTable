-- chunkname: @modules/logic/mainuiswitch/view/MainEagleAnimView.lua

module("modules.logic.mainuiswitch.view.MainEagleAnimView", package.seeall)

local MainEagleAnimView = class("MainEagleAnimView", BaseView)

function MainEagleAnimView:onInitView()
	self._gospine = gohelper.findChild(self.viewGO, "right/#go_eaglespine")
	self._goPointA = gohelper.findChild(self.viewGO, "right/#btn_role/#go_eagleA")
	self._goPointB = gohelper.findChild(self.viewGO, "right/#btn_room/#go_eagleB")
	self._goPointC = gohelper.findChild(self.viewGO, "right/go_fight/#go_eagleC")
	self._gospinebottom = gohelper.findChild(self.viewGO, "right/#go_eaglespine/bottom")
	self._gospinetop = gohelper.findChild(self.viewGO, "right/#go_eaglespine/top")
	self._goeagleani = gohelper.findChild(self.viewGO, "right/#go_eagleani")
	self._goClick = gohelper.findChild(self._gospine, "#go_eagleclick")
	self._click = SLFramework.UGUI.UIClickListener.Get(self._goClick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainEagleAnimView:addEvents()
	self._click:AddClickListener(self._onclick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshUI, self)
end

function MainEagleAnimView:removeEvents()
	self._click:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.UseMainUI, self.refreshUI, self)
end

function MainEagleAnimView:_onclick()
	TaskDispatcher.cancelTask(self._normalAnimFinish, self)

	local stepCo = MainUISwitchConfig.instance:getEagleAnim(self._curAnimStep)

	if not stepCo or stepCo.option_nextstep == 0 then
		return
	end

	self._curAnimStep = stepCo.option_nextstep

	self:_beginAnim()
end

function MainEagleAnimView:_editableInitView()
	self._uiSpine = GuiSpine.Create(self._gospinetop, true)
	self._uiBottomSpine = GuiSpine.Create(self._gospinebottom, true)
	self._locationParant = {
		[MainUISwitchEnum.EagleLocationType.A] = self._goPointA,
		[MainUISwitchEnum.EagleLocationType.B] = self._goPointB,
		[MainUISwitchEnum.EagleLocationType.C] = self._goPointC
	}
	self._animator = self._gospine:GetComponent(typeof(UnityEngine.Animator))
	self._anieagle = self._goeagleani:GetComponent(typeof(UnityEngine.Animator))
end

function MainEagleAnimView:onOpen()
	self._loadSpine = false
	self._loadBottomSpine = false

	if self.viewParam then
		self._animName = nil

		self:refreshUI(self.viewParam)
	end
end

function MainEagleAnimView:refreshUI(id)
	TaskDispatcher.cancelTask(self._normalAnimFinish, self)

	id = id or MainUISwitchModel.instance:getCurUseUI()

	if self._showSkinId == id then
		return
	end

	self._showSkinId = id

	local isAnim = id and id == MainUISwitchEnum.Skin.Sp01

	gohelper.setActive(self._gospine, isAnim)

	if isAnim then
		gohelper.setActive(self._goeagleani, self._animName == MainUISwitchEnum.EagleAnim.Hover)
		self:_initBgSpine()
	else
		gohelper.setActive(self._goeagleani, false)
	end
end

function MainEagleAnimView:_initBgSpine()
	if self._loadSpine then
		self:_startAnim()

		return
	end

	local resPath = ResUrl.getRolesCgStory("scene_eagle_idle1", "s01_scene_eagle_idle1")

	self._uiSpine:setResPath(resPath, self._onSpineLoaded, self)
	self._uiBottomSpine:setResPath(resPath, self._onSpineBpttomLoaded, self)
end

function MainEagleAnimView:_onSpineLoaded()
	local transform = self._uiSpine:getSpineTr()

	transformhelper.setLocalPos(transform, 0, 0, 0)
	transformhelper.setLocalScale(transform, 1, 1, 1)

	self._spineSkeleton = self._uiSpine:getSpineGo():GetComponent(GuiSpine.TypeSkeletonGraphic)

	self._uiSpine:setActionEventCb(self._onAnimEvent, self)

	self._loadSpine = true

	if self._loadBottomSpine then
		self:_startAnim()
	end
end

function MainEagleAnimView:_onSpineBpttomLoaded()
	transformhelper.setLocalPos(self._uiBottomSpine:getSpineTr(), 0, 0, 0)
	transformhelper.setLocalScale(self._uiBottomSpine:getSpineTr(), 1, 1, 1)

	self._bottomSpineSkeleton = self._uiBottomSpine:getSpineGo():GetComponent(GuiSpine.TypeSkeletonGraphic)

	if self._bottomSpineSkeleton then
		self._bottomSpineSkeleton.color = Color.black
	end

	self._loadBottomSpine = true

	if self._loadSpine then
		self:_startAnim()
	end
end

function MainEagleAnimView:_startAnim()
	self._curAnimStep = 1

	self:_beginAnim()
end

function MainEagleAnimView:_beginAnim()
	TaskDispatcher.cancelTask(self._normalAnimFinish, self)

	local nextStepId = self:_getOddNextStepId(self._curAnimStep)

	if nextStepId then
		self:_beginStep(nextStepId)
	end
end

function MainEagleAnimView:_getRandomStep(oddsList, ramdom)
	for _, stepOdds in ipairs(oddsList) do
		if not stepOdds[2] then
			if ramdom <= stepOdds[2] then
				return stepOdds[1]
			end

			ramdom = ramdom - stepOdds[2]
		end
	end
end

function MainEagleAnimView:_beginStep(step)
	if not step then
		return
	end

	SLFramework.SLLogger.Log(string.format("MainEagleAnimView 当前步骤：%s", step))

	local stepCo = MainUISwitchConfig.instance:getEagleAnim(step)

	if not stepCo then
		logError("没有这个步骤" .. step)

		return
	end

	self._curAnimStep = step

	local times = 1

	if not string.nilorempty(stepCo.times) then
		local _times = string.splitToNumber(stepCo.times, "#")

		times = math.random(_times[1], _times[2])
	end

	self._neeedPlayAnimTimes = times
	self._playedAnimTimes = 1

	if not string.nilorempty(stepCo.location) then
		local locations = string.splitToNumber(stepCo.location, "#")
		local location = MainUISwitchEnum.EagleLocationType.A
		local count = #locations

		if count == 1 then
			location = locations
		elseif count > 1 then
			local random = math.random(1, count)

			location = locations[random]
		end

		local parent = self._locationParant[location]

		if parent then
			gohelper.addChildPosStay(parent, self._gospine)
			transformhelper.setLocalPos(self._gospine.transform, 0, 0, 0)
			transformhelper.setLocalScale(self._gospine.transform, 1, 1, 1)
			gohelper.setActive(self._gospine, true)
		else
			gohelper.setActive(self._gospine, false)
		end
	end

	local hover = MainUISwitchEnum.EagleAnim.Hover

	if self._animName then
		if self._animName == hover and stepCo.animName ~= hover then
			gohelper.setActive(self._goeagleani, true)
			self._anieagle:Play(MainUISwitchEnum.AnimName.Out, 0, 0)
		elseif self._animName ~= hover and stepCo.animName == hover then
			gohelper.setActive(self._goeagleani, true)
			self._anieagle:Play(MainUISwitchEnum.AnimName.In, 0, 0)
		end
	elseif stepCo.animName == hover then
		gohelper.setActive(self._goeagleani, true)
		self._anieagle:Play(MainUISwitchEnum.AnimName.In, 0, 0)
	end

	if stepCo.isSpineAnim == 1 then
		if self._uiSpine then
			self._animName = stepCo.animName

			self:_playSpineAnim(self._animName)

			if self._bottomSpineSkeleton then
				self._bottomFadeTweenId = stepCo.isoutline == 1 and ZProj.TweenHelper.DoFade(self._bottomSpineSkeleton, self._bottomSpineSkeleton.color.a, 1, 0.5) or ZProj.TweenHelper.DoFade(self._bottomSpineSkeleton, self._bottomSpineSkeleton.color.a, 0, 0.5)

				SLFramework.SLLogger.Log(string.format("MainEagleAnimView 播放动作：%s", self._animName))
			end
		end
	elseif stepCo.animName == hover then
		self._animName = stepCo.animName

		TaskDispatcher.runDelay(self._normalAnimFinish, self, 4 * self._neeedPlayAnimTimes)
	end

	if self._animator then
		if string.nilorempty(stepCo.playfadeAnim) then
			self._animator:Play(MainUISwitchEnum.AnimName.Idle, 0, 0)
		else
			self._animator:Play(stepCo.playfadeAnim, 0, 0)
		end
	end
end

function MainEagleAnimView:_playSpineAnim(spineAnimName)
	if self._spineSkeleton then
		self._spineSkeleton:PlayAnim(spineAnimName, false, true)
	end

	if self._bottomSpineSkeleton then
		self._bottomSpineSkeleton:PlayAnim(spineAnimName, false, true)
	end
end

function MainEagleAnimView:_normalAnimFinish()
	if not self._curAnimStep then
		return
	end

	local stepId = self:_getOddNextStepId(self._curAnimStep)

	if not stepId then
		return
	end

	self:_beginStep(stepId)
end

function MainEagleAnimView:_getOddNextStepId(stepId)
	local stepCo = MainUISwitchConfig.instance:getEagleAnim(stepId)

	if not stepCo or string.nilorempty(stepCo.odds_nextstep) then
		return
	end

	local stepIds = GameUtil.splitString2(stepCo.odds_nextstep, true)

	if not stepIds then
		return
	end

	local random = math.random(1, 100)

	return (self:_getRandomStep(stepIds, random))
end

function MainEagleAnimView:_onAnimEvent(actionName, eventName)
	if self._showSkinId == 1 or not self._animator then
		return
	end

	if eventName == SpineAnimEvent.ActionComplete then
		if self._playedAnimTimes >= self._neeedPlayAnimTimes then
			self:_beginAnim()
		else
			self._playedAnimTimes = self._playedAnimTimes + 1

			self:_playSpineAnim(self._animName)
		end
	end
end

function MainEagleAnimView:onDestroyView()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end

	if self._uiBottomSpine then
		self._uiBottomSpine:onDestroy()

		self._uiBottomSpine = nil
	end

	if self._bottomFadeTweenId then
		ZProj.TweenHelper.KillById(self._bottomFadeTweenId)

		self._bottomFadeTweenId = nil
	end

	TaskDispatcher.cancelTask(self._normalAnimFinish, self)
end

return MainEagleAnimView
