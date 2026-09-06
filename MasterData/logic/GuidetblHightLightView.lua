-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/view/GuidetblHightLightView.lua

module("logic.extensions.guide.view.GuidetblHightLightView", package.seeall)

local GuidetblHightLightView = class("GuidetblHightLightView", GuideUIObjectBase)
local JUMP_TIME = 10

function GuidetblHightLightView:ctor()
	GuidetblHightLightView.super.ctor(self)

	self._count = 0
end

function GuidetblHightLightView:onEnterFinished()
	GuidetblHightLightView.super.onEnterFinished(self)
	GlobalDispatcher:addListener(ThroneController.ON_RESET_THE_CELL, self.onThroneResetCell, self)

	self._count = 0
	self.recordTime = 0

	self:_showGuide()

	local params = self._currGuide:getJsonParams()

	GameUtil.setUIImageSpriteIdx(self.headGo, params.npcIdx or 0)
	removetimer(self.onAutoNextDone, self)

	local autoNextTime = params.autoNextTime

	if autoNextTime and checknumber(autoNextTime) > 0 then
		settimer(checknumber(autoNextTime), self.onAutoNextDone, self)
	end
end

function GuidetblHightLightView:onAutoNextDone(go)
	removetimer(self.onAutoNextDone, self)
	TipsFacade.instance:openCommonTips(lang("别发呆啦~小诺帮你完成这步训练啦~"))
	self:_onClickButton()
end

function GuidetblHightLightView:onThroneResetCell(go)
	if self._startGo and self._startGo:Equals(go) then
		self._startGo = nil

		self:addGoToAttch()
	end
end

function GuidetblHightLightView:addFinger()
	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	local name = "common/fx_ui_zhiyin_quan_03.prefab"
	local light = UIEffectManager.instance:playEffect(self, name, self._finger, 0, 0, true, nil, function()
		return
	end, function(ta, eff)
		return
	end)

	light:setParent(self.mainGO.transform)
	light:setScale(1)

	self._fingerEff = light
end

function GuidetblHightLightView:_showGuide()
	self:_onDisableVerticalLayoutGroup(false)
	self._finger:SetActive(false)

	local center = Vector3.New(100, 100, 0)
	local txt = self._currGuide:getDialogue()

	self._text.text = txt

	GameUtil.SetActive(self._container, true)

	if string.nilorempty(txt) then
		GameUtil.SetActive(self._container, false)
	end

	local lineWidth = math.min(500, self._text.preferredWidth)
	local _endPos = self._currGuide:getEndpos()

	GameUtil.setAnchoredPos(self._container, _endPos.x, _endPos.y)

	if self._currGuide:getIsMask() then
		self._mask:SetActive(true)
	else
		self._mask:SetActive(false)
	end

	if self._currGuide:getUIWidget() then
		self:addGoToAttch()
	end

	GameUtil.SetActive(self.mcTime, false)
	GameUtil.SetActive(self.btnOK, false)

	self._count = 0

	if self._currGuide:autoFinishTime() and self._currGuide:autoFinishTime() > 0 then
		GameUtil.SetActive(self.btnOK, true)
	end

	self.mainGO:GetComponent("Image").enabled = not not self._currGuide:getRaycast()
end

function GuidetblHightLightView:_setGroupEnable(go)
	local vertical = go:GetComponent("VerticalLayoutGroup")

	if vertical then
		self._goGroupEnableMap = self._goGroupEnableMap or {}
		self._goGroupEnableMap[go] = vertical.enabled
		vertical.enabled = false
	end

	local _sizeFitter = go:GetComponent("ContentSizeFitter")

	if _sizeFitter then
		self._goFitterEnableMap = self._goFitterEnableMap or {}
		self._goFitterEnableMap[go] = _sizeFitter.enabled
		_sizeFitter.enabled = false
	end
end

function GuidetblHightLightView:_resetGroupEnable(go)
	local vertical = go:GetComponent("VerticalLayoutGroup")

	if vertical then
		vertical.enabled = self._goGroupEnableMap[go]
	end

	local _sizeFitter = go:GetComponent("ContentSizeFitter")

	if _sizeFitter then
		_sizeFitter.enabled = self._goFitterEnableMap[go]
	end
end

function GuidetblHightLightView:addGoToAttch()
	print(">>>>>>>>>>>>>>>>>>>>              deal    addGoToAttch")
	self._Frame.gameObject:SetActive(true)

	if self._saveCallback and self._saveButton then
		self._saveButton:GetComponent("Framework.ButtonAdapter"):AddClickListener(self._saveCallback, self._saveTarget)

		self._saveCallback = nil
		self._saveButton = nil
	end

	local idx = self:getListIdx()

	self._startGo = self:_getWidgetNeedHandler(self._currGuide:getUINode(), self._currGuide:getUIWidget(), idx)

	if self._startGo then
		local widgetPos = self._currGuide:getJsonParams().widgetPos

		if widgetPos then
			GameUtil.setAnchoredPos(self._startGo, widgetPos[1], widgetPos[2])
		end

		self._saveStartGoP = self._startGo.transform.parent
		self._savaStartSiblingIndex = self._startGo.transform:GetSiblingIndex()

		GoUtil.ForceRebuildLayoutImmediate(self._saveStartGoP.gameObject)
		self:_setGroupEnable(self._saveStartGoP)

		local pos = GameUtil.getPos(self._startGo)

		self._startGo.transform:SetParent((self._attach or nil) and (self._attach.transform or nil), true)
		GameUtil.setPos(self._startGo, pos.x, pos.y, pos.z)

		if self._currGuide:getIsShow() then
			self._finger:SetActive(true)
			self:_handleEvent()
			self:_handleItemPetEvent()

			local startX, startY, startZ = self:_getWidgetCenterPosition(self._startGo)

			GameUtil.setPos(self._finger, startX, startY, startZ)
			GameUtil.setPos(self._Frame, startX, startY, startZ)

			local rotation = self._currGuide:getRotation()

			if rotation then
				Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, rotation[1], rotation[2], rotation[3])
			else
				Framework.TransformUtil.SetLocalRotation(self._finger.gameObject.transform, 0, 0, 0)
			end

			local ofs = self._currGuide:getWidgetOffset()
			local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._finger.transform, nil, nil, nil)

			if ofs then
				posX = posX + (ofs[1] or 0)
				posY = posY + (ofs[2] or 0)
			end

			Framework.TransformUtil.SetLocalPos(self._finger.transform, posX, posY, 0)
			self:addFinger()
		else
			self._finger:SetActive(false)
		end
	elseif self._currGuide:getJsonParams().needQuit == 1 then
		GuideController.instance:forceFinishBranch()
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	if self._currGuide:getJsonParams().hasFrame == 1 then
		self._originStartGo = nil

		self._Frame.transform:SetParent(self.mainGO.transform)

		self._effect = UIEffectManager.instance:playEffect(self, "fx_ui_renwu/fx_ui_renwukuang.prefab", self._Frame:GetComponent("RectTransform"), 0, 0, true, nil, nil, self._onEffectLoaded, self)
		self._effect.hideEffWhileNotOnTop = nil

		self._Frame:SetActive(false)
	end
end

function GuidetblHightLightView:_onTableviewReloadFinish(tableView)
	if self._saveTableview == tableView then
		print(">>>>>>>>>>>>>>>>>>>>              重新    addGoToAttch")
		self:addGoToAttch()
	end
end

function GuidetblHightLightView:_handleWidget(widget, idx)
	local tableView = widget:GetComponent("UITableviewForLua")

	if tableView then
		local go = self:_getObjectInTableView(tableView, idx)

		if self._saveTableview == nil then
			self._saveTableview = tableView
			self._saveTableviewTarget = self._saveTableview:GetReloadFinishTarget()
			self._saveTableviewReloadFinish = self._saveTableview:GetReloadFinishLuaHandle()

			self._saveTableview:RegisterReloadFinishCallback(self._onTableviewReloadFinish, self)
		end

		return go
	else
		self._parentLayout = UGUIToolHelper.FindUILayout(widget)

		if self._parentLayout then
			self._parentLayoutManual = self._parentLayout.manual
			self._parentLayout.manual = true
		end

		return widget
	end
end

function GuidetblHightLightView:getListIdx()
	local idx = 0
	local params = self._currGuide:getJsonParams()
	local ts = params.taskStart

	if ts then
		local taskes = TaskFacade.instance:getCurrentTriggerTaskesShowedOnUI()

		if not taskes or #taskes == 0 then
			print(">>>>>>>任务空")
		else
			local taskId = ts[1]
			local stepId = ts[2]

			for i = 1, #taskes do
				local task = taskes[i].task

				if task.taskCo and task.taskCo.taskId == taskId and task.currStep and stepId == task.currStep:getStepId() then
					idx = i - 1

					break
				end
			end
		end
	end

	local petRaceId = params.petRaceId

	if petRaceId ~= nil then
		local arr = GuideController.instance:getOrCheckVarAndDoOnce("bag_petmo_list")
		local petReg = params.petReg

		idx = BagModel.instance:getPetViewIdxByRaceId(petRaceId, arr, petReg)
	end

	local matIdx = params.matIdx

	if matIdx ~= nil then
		local info = string.split(matIdx, ":")
		local matType = checknumber(info[1])
		local cfgId = checknumber(info[2])
		local _curViewDatas = MaterialFacade.instance:getMaterialInfoByType(matType)

		ArraySort.sortOn(_curViewDatas, {
			function(mo)
				local cfg = MaterialMgr.getMatCfg(mo.type, mo.id)

				if cfg then
					return cfg.order
				end

				return 0
			end,
			"id"
		})

		for i, v in ipairs(_curViewDatas) do
			if v.id == cfgId then
				idx = i - 1
			end
		end
	end

	return (params.forceIdx or nil) and params.forceIdx
end

function GuidetblHightLightView:_handleEvent()
	local trs = self._startGo.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)

		if self:_checkBtn(child) then
			self._childGo = child

			return nil
		end
	end

	self:_checkBtn(self._startGo)
end

function GuidetblHightLightView:_onClickButton()
	if self._clickHandler then
		PointerClickHandler.Get(self._childGo):AddRemoveLuaHandler(self._clickHandler)
	end

	local temFunc = self._saveCallback
	local tar = self._saveTarget

	if self._saveCallback then
		self._saveButton:GetComponent("Framework.ButtonAdapter"):AddClickListener(self._saveCallback, self._saveTarget)

		self._saveCallback = nil
	end

	local params = self._currGuide:getJsonParams()

	if params.preCall and temFunc then
		temFunc(tar)

		temFunc = nil
	end

	GuideController.instance:finishGuide()

	if temFunc then
		temFunc(tar)

		temFunc = nil
	end
end

function GuidetblHightLightView:_onCountTime()
	self._count = self._count - 1
	self._CountTime.text = string.format("%ds", self._count)

	if self._count <= 0 then
		removetimer(self._onCountTime, self)
		GameUtil.SetActive(self.mcTime, false)
		GameUtil.SetActive(self.btnOK, true)
	end
end

function GuidetblHightLightView:_onEffectLoaded()
	print(">>> over")

	self._originStartGo = self._originStartGo or self:_getGuideWidget()

	self._Frame:SetActive(true)
	self._effect:setScrollRectClipping(self._originStartGo:GetComponent(typeof(UnityEngine.UI.ScrollRect)))
	self._effect:setParent(self._originStartGo.transform)

	local scaleFix = self._currGuide:getContentFix()

	if scaleFix then
		local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(self._effect.effGo.gameObject.transform, nil, nil, nil)

		self._effect:setLocalPos(posX + scaleFix[1], posY + scaleFix[2], 0)
		self._effect:setScaleXYZ(scaleFix[3] / 273, scaleFix[4] / 84, 1)
	end

	self._effect:setSortingOrder(501)
end

function GuidetblHightLightView:buildUI()
	GuidetblHightLightView.super.buildUI(self)

	self._text = self:getTxt("board/Img_Bg/Text")
	self._container = self:getGo("board")
	self.headGo = self:getGo("board/Img_Bg/Text/icon")
	self._mask = self:getGo("mask")
	self._finger = self:getGo("finger")
	self._attach = self:getGo("attach")
	self.mcTime = self:getGo("mcTime")
	self._CountTime = self:getTxt("mcTime/CountTime")
	self.btnOK = self:getBtn("btnOK")

	self.btnOK:AddClickListener(function()
		if self._count <= 0 then
			GameUtil.SetActive(self.btnOK, false)
			GameUtil.SetActive(self._mask, false)
			GuideController.instance:_onGuideAutoFinish()
		else
			self._count = 0

			self:_onCountTime()
		end
	end)

	self._longPress = self._mask:GetComponent("UILongPressed")

	if self._longPress then
		self._longPress:AddListener(function(tar, isUp)
			print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>> _longPress Click2222222", isUp)

			if isUp then
				local count = ServerTime.now() - self.recordTime

				self.recordTime = 0

				if count > JUMP_TIME then
					SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_FORCE_JUMP_GUIDE)
					GuideController.instance:forceFinishBranch()
				end
			else
				self.recordTime = ServerTime.now()
			end
		end, self)
	end

	self._Frame = self:getGo("Frame")

	local tweenScale = self._finger:GetComponentInChildren(UnityTweensType.TweenScale)

	tweenScale:AddLoopingListener(self._onTweenSoundStarted, self)
end

function GuidetblHightLightView:_onTweenSoundStarted()
	if not self._lastPlayTime or UnityEngine.Time.time - self._lastPlayTime >= 2 then
		self._lastPlayTime = UnityEngine.Time.time

		AudioPlayerEx.instance:playEffect(30225)
	end
end

function GuidetblHightLightView:_getWidget(presentorName, uiNode, uiWidget)
	if not ViewMgr.instance:isOpen(presentorName) then
		return
	end

	local presentor = ViewMgr.instance._views[presentorName]

	if presentorName == ViewName.AoCoreView or presentorName == ViewName.QiCoreView then
		for i = 1, #presentor._views do
			if presentor._views[i].getGuideGo then
				local go = GameUtil.findChildEx(presentor._views[i]:getGuideGo(), uiWidget)

				if go then
					return go
				end
			end
		end
	else
		for i = 1, #presentor._views do
			if string.find(presentor._views[i].mainGO.name, uiNode) then
				local go = GameUtil.findChildEx(presentor._views[i].mainGO, uiWidget)

				if go then
					return go
				end
			end
		end
	end
end

function GuidetblHightLightView:onExit()
	self._lastPlayTime = nil

	GuidetblHightLightView.super.onExit(self)
	GlobalDispatcher:removeListener(ThroneController.ON_RESET_THE_CELL, self.onThroneResetCell, self)
	removetimer(self._onCountTime, self)
	removetimer(self.onAutoNextDone, self)
end

function GuidetblHightLightView:onExitFinished()
	print(">>>>>>>>>>>>> 退出  GuidetblHightLightView", self._saveCallback)
	GuidetblHightLightView.super.onExitFinished(self)

	if self._startGo then
		self:_resetGroupEnable(self._saveStartGoP)
		self._startGo.transform:SetParent(self._saveStartGoP, true)
		self._startGo.transform:SetSiblingIndex(self._savaStartSiblingIndex)
		print(">>>>>>>>>>>>> 退出  GuidetblHightLightView 还 GO ", self._startGo)

		self._startGo = nil
	end

	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	if self._fingerEff then
		UIEffectManager.instance:stopEffect(self._fingerEff)

		self._fingerEff = nil
	end

	self._loader = RoleObjectPool.instance:removeRole(self._loader)
	self.recordTime = 0
end

function GuidetblHightLightView:_clearItemPetEvent()
	if self._itemPet then
		self._itemPet:removeListener(ItemPet.Events.Click, self._clearItemPetEvent, self)

		self._itemPet = nil

		self:_onClickButton()
	end
end

function GuidetblHightLightView:_handleItemPetEvent()
	if self._itemPet then
		self._itemPet:removeListener(ItemPet.Events.GuideClick, self._clearItemPetEvent, self)

		self._itemPet = nil
	end

	if self._startGo == nil then
		return
	end

	local params = self._currGuide:getJsonParams()
	local petItemType = checknumber(params.petItemType)

	if petItemType == 1 then
		local petItemGo = goutil.findChild(self._startGo, "con")

		if petItemGo == nil then
			return
		end

		self._itemPet = ItemPet.Get(petItemGo)

		if self._itemPet == nil then
			return
		end

		self._itemPet:addListener(ItemPet.Events.GuideClick, self._clearItemPetEvent, self)
	end
end

return GuidetblHightLightView
