-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/view/UnlockView.lua

module("logic.extensions.unlock.view.UnlockView", package.seeall)

local UnlockView = class("UnlockView", StoryViewBase)
local UnLockCodeFinished = 0
local UnLockCodeUnlock = 1
local UnLockCodeLock = 2

function UnlockView:buildUI()
	UnlockView.super.buildUI(self)

	self._imgDot0 = self:getGo("story/story/shakeNode/types/type0/ImageDot")
	self._imgDot1 = self:getGo("story/story/shakeNode/types/type1/ImageDot")
	self._imgDotShadow0 = self:getGo("story/story/shakeNode/types/type0/ImageDotShadow")
	self._imgDotShadow1 = self:getGo("story/story/shakeNode/types/type1/ImageDotShadow")
	self.npcBtnsPos = self:getGo("story/npcBtnsPos")
	self.btnsGoLayout = goutil.findChildComponent(self.npcBtnsPos, "npcLayout", "UILayoutSingleLine")
	self.npcBtnGo = self:getGo("story/npcBtnGo")

	self.npcBtnsPos:SetActive(false)
	self.npcBtnGo:SetActive(false)

	self._funcBtn = self:getBtn("story/story/funcBtn")
	self._funcBtnTxt = self:getGo("story/story/funcBtn/funcBtnTxt"):GetComponent("Text")

	self._funcBtn.gameObject:SetActive(false)

	local panel = self:getGo("story/story/shakeNode/Panel")

	self._storysTable[StoryConst.Story_Drama]:setClickMask(panel)
end

function UnlockView:onExit()
	removetimer(self._calculationSurplusTime, self)
	self._funcBtn.gameObject:SetActive(true)

	for _, item in pairs(self._npcBtnsItemList or {}) do
		if item then
			if item.npcBtn then
				item.npcBtn:RemoveClickListener()
			end

			item.npcSupTime = nil
			item.npcDesStr = nil
			item.npcClickFunc = nil
		end
	end

	self._funcBtn:RemoveClickListener()
	UnlockView.super.onExit(self)

	self._storyCode = nil
	self._storyCfg = nil
	self._currStoryIndex = nil
end

function UnlockView:destroyUI()
	UnlockView.super.destroyUI(self)

	for _, item in pairs(self._npcBtnsItemList or {}) do
		if item then
			UnityEngine.GameObject.Destroy(item.itemGo)
		end
	end

	self._npcBtnsItemList = nil
	self._currStoryIndex = nil
	self._storyCode = nil
end

function UnlockView:onEnter()
	self._npcId = self._viewPresentor._openParam[1]
	self._paramCfg = self._viewPresentor._openParam[2]

	self.npcBtnsPos:SetActive(false)

	if not self._paramCfg or #self._paramCfg > 1 then
		self:_showDefaultStory()

		if self._paramCfg and #self._paramCfg > 1 then
			self:_createFuncsBtn()
		end
	else
		self:_showByFuncMo(self._paramCfg[1])
	end

	UnlockView.super.onEnter(self)
	GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryStart)
end

function UnlockView:_showByFuncMo(funcMo)
	self:_resetStories()

	self._selectMo = funcMo

	if self._selectMo.taskId then
		self:_finishStory()
		TaskController.instance:onSelectNpc(self._npcId)

		return
	end

	self._currFuncCo = funcMo.funcCo

	if UnlockModel.instance:isFunctionFinished(self._currFuncCo.index) then
		self._storyCode = UnLockCodeFinished
		self._storyCfg = StoryConfig.instance:getStoryUnLock(self._currFuncCo.fStory)
	elseif UnlockModel.instance:isFunctionUnlock(self._currFuncCo.index) then
		self._storyCode = UnLockCodeUnlock

		if self._currFuncCo.ulStory ~= 0 then
			self._storyCfg = StoryConfig.instance:getStoryUnLock(self._currFuncCo.ulStory)
		else
			GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd, self._npcId, self._currFuncCo)

			return
		end
	else
		self._storyCode = UnLockCodeLock

		local storyId = UnlockModel.instance:getUnlockStoryId(self._currFuncCo.index)

		self._storyCfg = StoryConfig.instance:getStoryUnLock(storyId)
	end

	self:_startInitShow()
	StoryConst.handleStoriesBackground(self._storyCfg)

	return true
end

function UnlockView:_resetStories()
	self._clickTimer = 0
	self._coolTimer = 0.5
	self._currStoryIndex = 1
	self._storyCode = nil
	self._selectMo = nil
	self._storyCfg = nil
	self._currFuncCo = nil

	if self._funcBtn and self._funcBtn.gameObject.activeSelf then
		self._funcBtn.gameObject:SetActive(false)
	end

	removetimer(self._calculationSurplusTime, self)

	for _, item in pairs(self._npcBtnsItemList or {}) do
		if item then
			if item.itemGo and item.itemGo.activeSelf then
				item.itemGo:SetActive(false)
			end

			item.npcSupTime = nil
			item.npcDesStr = nil
			item.npcClickFunc = nil
		end
	end
end

function UnlockView:_showDefaultStory()
	self:_resetStories()

	local storyId
	local funcCo = UnlockFacade.instance:getDefalutStoryCo(self._npcId)

	if not funcCo then
		local npcCo = SceneConfig.instance:getNpcCo(self._npcId)

		self._storyCfg = {}

		local storyCfg = {}

		storyCfg.name = npcCo.name
		storyCfg.type = StoryConst.Story_Drama
		storyCfg.bgImg = StoryConst.Story_BG_SceneBlur
		storyCfg.bg = 0
		storyCfg.sign = 0
		storyCfg.shake = 0
		storyCfg.bgEff = ""
		storyCfg.text = "请问需要什么帮助吗？"

		table.insert(self._storyCfg, storyCfg)
	else
		local len = #funcCo.story

		self._storyCfg = StoryConfig.instance:getStoryUnLock(funcCo.story[math.random(1, len)])
	end

	StoryConst.handleStoriesBackground(self._storyCfg)
end

function UnlockView:_startInitShow()
	if self._storyCfg == nil or self._storyCfg[self._currStoryIndex] == nil then
		return
	end

	self:_createAllBtn()
end

function UnlockView:_createFuncsBtn()
	self._currBtnCreateIndex = 1

	local buttonList = {}

	for i = 1, #self._paramCfg do
		local funcMo = self._paramCfg[i]

		if funcMo.taskId then
			local taskCo = TaskConfig.instance:getTaskCo(funcMo.taskId)
			local btnCfg = {}

			btnCfg.buttonId = "Task"
			btnCfg.buttonType = 1
			btnCfg.buttonIcon = 2
			btnCfg.buttonDes = taskCo.name

			table.insert(buttonList, btnCfg)
		else
			local btnCfg = {}

			btnCfg.buttonId = "Function"
			btnCfg.buttonType = 1
			btnCfg.buttonIcon = 3

			local funcType = funcMo.funcCo.funcType

			if funcType == NpcFuncType.OpenFunc then
				local funcOpenCo = FuncOpenConfig.instance:getFunctionOpenById(tonumber(funcMo.funcCo.funcParams[1]))

				btnCfg.buttonDes = funcOpenCo.name
			else
				if funcMo.funcCo.ulStory > 0 then
					local storyCfg = StoryConfig.instance:getStoryUnLock(funcMo.funcCo.ulStory)

					btnCfg.buttonDes = GameUtil.removeRichColor(storyCfg[1].sureText)

					if storyCfg[1].dialogueButton then
						btnCfg.buttonIcon = storyCfg[1].dialogueButton[1] or btnCfg.buttonIcon
					end
				end

				if NpcFuncType.TimeLimitedChallenge == funcType or NpcFuncType.Legend == funcType or NpcFuncType.Challenge == funcType then
					btnCfg.buttonIcon = 7
					btnCfg.buttonDes = "挑战 " .. btnCfg.buttonDes
				end
			end

			table.insert(buttonList, btnCfg)
		end
	end

	local exitConfig = StoryConfig.instance:GetStoryNpcbtns(3)

	self._createButton(self, nil, exitConfig, self._onClickFunc, self)

	for i = 1, #buttonList do
		local btnCfg = buttonList[i]

		if btnCfg then
			self._createButton(self, nil, btnCfg, self._onClickFunc, self, self._paramCfg[i])
		end
	end

	self.npcBtnsPos:SetActive(true)
	self.btnsGoLayout:Layout()
	self:_startCalculationTimer()
end

function UnlockView:_onClickFunc(btnCfg, param)
	if not self:_clickBtnCoolTimer() then
		return
	end

	if not param then
		self._storysTable[StoryConst.Story_Drama]:forceCompleteTypeWriter()
		self._storysTable[StoryConst.Story_Drama]:_onClickMask()

		return
	end

	if self:_showByFuncMo(param) then
		self:showNextStory()
	end
end

function UnlockView:_createAllBtn()
	local cfg = self._storyCfg[self._currStoryIndex]

	if not cfg.dialogueButton then
		if cfg.dialogueButton == nil or #cfg.dialogueButton == 0 then
			return
		end

		local isNpcBtns = false

		self._currBtnCreateIndex = 1

		for i = 1, #cfg.dialogueButton do
			local btnCfg = StoryConfig.instance:GetStoryNpcbtns(cfg.dialogueButton[i] or 0)

			if btnCfg then
				local isNpc = self._createButton(self, cfg, btnCfg, self._onClickSureButton, self)

				isNpcBtns = isNpcBtns or isNpc
			end
		end

		if isNpcBtns then
			self.npcBtnsPos:SetActive(true)
			self.btnsGoLayout:Layout()
		end

		self:_startCalculationTimer()
	end
end

function UnlockView:_createButton(cfg, btnCfg, callback, callbackObj, param)
	self._npcBtnsItemList = self._npcBtnsItemList or {}

	if btnCfg then
		local isNpcBtns

		local function func()
			callback(callbackObj, btnCfg, param)
		end

		if btnCfg.buttonType == 1 then
			self._currBtnCreateIndex = self._currBtnCreateIndex + 1
			index = self._currBtnCreateIndex

			if self._npcBtnsItemList[index] == nil then
				local btnGo = goutil.cloneAndSetParent(self.npcBtnGo, self.btnsGoLayout.gameObject.transform)

				self._npcBtnsItemList[index] = {
					itemGo = btnGo,
					npcBtn = Framework.ButtonAdapter.GetFrom(btnGo, "npcBtn"),
					npcIcon = goutil.findChildComponent(btnGo, "npcBtn/npcIcon", ComponentType.UIImageSpriteChange),
					npcTxt = goutil.findChildTextComponent(btnGo, "npcBtn/npcTxt"),
					npcIconImage = goutil.findChildComponent(btnGo, "npcBtn/npcIcon", goutil.Type_UIImage)
				}
			end

			self._npcBtnsItemList[index].itemGo:SetActive(true)

			isNpcBtns = true
			self._npcBtnsItemList[index].npcTxt.text = btnCfg.buttonDes

			self._npcBtnsItemList[index].npcIcon:SetState(btnCfg.buttonIcon or 0)
			self._npcBtnsItemList[index].npcBtn:AddClickListener(func, self)
			self._npcBtnsItemList[index].npcIconImage:SetNativeSize()

			self._npcBtnsItemList[index].npcSupTime = nil
			self._npcBtnsItemList[index].npcDesStr = nil
			self._npcBtnsItemList[index].npcClickFunc = nil

			if checknumber(btnCfg.timer) > 0 then
				self._npcBtnsItemList[index].npcSupTime = btnCfg.timer + ServerTime.now()
				self._npcBtnsItemList[index].npcDesStr = btnCfg.buttonDes
				self._npcBtnsItemList[index].npcClickFunc = func
			end
		else
			self._funcBtn.gameObject:SetActive(true)

			self._funcBtnTxt.text = string.format(btnCfg.buttonDes, cfg.name)

			self._funcBtn:AddClickListener(func, self)
		end

		return isNpcBtns
	end
end

function UnlockView:showStory(story)
	UnlockView.super.showStory(self, story)

	if self._storyCode == UnLockCodeUnlock and not self:_hasNextStory() then
		self._imgDot0:SetActive(false)
		self._imgDot1:SetActive(false)
		self._imgDotShadow0:SetActive(false)
		self._imgDotShadow1:SetActive(false)
	else
		self._imgDot0:SetActive(true)
		self._imgDot1:SetActive(true)
		self._imgDotShadow0:SetActive(true)
		self._imgDotShadow1:SetActive(true)
	end
end

function UnlockView:_onClickSureButton(btnCfg)
	if btnCfg == nil then
		return
	end

	if not self:_clickBtnCoolTimer() then
		return
	end

	self:_finishStory()

	if btnCfg.buttonId == 7 then
		KingWayController.instance:CSBossShapeChangeReq()

		return
	end

	if btnCfg.buttonId == 4 or btnCfg.buttonId == 5 or btnCfg.buttonId == 6 then
		if not EscortModel.instance:IsPickupEscort() then
			FloatWordMgr.instance:show("护送已超时失败！")

			return
		end

		EscortModel.instance:OnTalkFinishToNPC(self._npcId)

		if btnCfg.buttonId == 6 then
			EscortController.instance:CSFinishConvoyReq()

			return
		end
	end

	if btnCfg.buttonId == 15 then
		if checknumber(HalloweenGuestModel.instance.monsterActId) <= 0 then
			FloatWordMgr.instance:show("活动已结束！")
			GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd)

			return
		end

		if not HalloweenGuestModel.instance:getHalloweenNpsLocation(self._npcId) then
			GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd)
		end

		return
	end

	if btnCfg.buttonId == 3 then
		self._storysTable[StoryConst.Story_Drama]:forceCompleteTypeWriter()
		GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd)

		return
	end

	if string.nilorempty(btnCfg.buttonEvent) then
		GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd, self._npcId, self._currFuncCo, btnCfg)
	else
		GotoMgr.gotoByString(btnCfg.buttonEvent)
	end
end

function UnlockView:_clickBtnCoolTimer()
	if self._clickTimer == 0 then
		self._clickTimer = ServerTime.now()
	else
		local now = ServerTime.now()

		if now - self._clickTimer < self._coolTimer then
			return
		end

		self._clickTimer = now
	end

	return true
end

function UnlockView:finishCurrStory()
	if not self:showNextStory() then
		self:_finishStory()
	end
end

function UnlockView:_hasNextStory()
	return self._storyCfg and self._currStoryIndex <= #self._storyCfg
end

function UnlockView:_getNextStory()
	local story = self._storyCfg[self._currStoryIndex]

	self._currStoryIndex = self._currStoryIndex + 1
	story.extModels = ""

	return story
end

function UnlockView:_getNextStoryOnly()
	return
end

function UnlockView:_endStory()
	GlobalDispatcher:dispatch(GlobalNotify.NPCUnlockStoryEnd)
	self:close()
end

function UnlockView:_delayClose()
	removetimer(self._delayClose, self)
	self:close()
end

function UnlockView:_startCalculationTimer()
	removetimer(self._calculationSurplusTime, self)

	local isTiming = false
	local nowTime = ServerTime.now()

	for _, item in pairs(self._npcBtnsItemList or {}) do
		if item and checknumber(item.npcSupTime) > 0 then
			if nowTime >= checknumber(item.npcSupTime) then
				if item.npcClickFunc then
					item.npcClickFunc()
				end

				return
			else
				isTiming = true
			end
		end
	end

	if isTiming then
		self:_calculationSurplusTime()
		settimer(1, self._calculationSurplusTime, self, true)
	end
end

function UnlockView:_calculationSurplusTime()
	local nowTime = ServerTime.now()

	for _, item in pairs(self._npcBtnsItemList or {}) do
		if item and checknumber(item.npcSupTime) > 0 then
			if item.npcTxt and not string.nilorempty(item.npcDesStr) then
				item.npcTxt.text = string.format("%s(%ss)", item.npcDesStr, math.floor(item.npcSupTime - nowTime))
			end

			if nowTime >= item.npcSupTime then
				removetimer(self._calculationSurplusTime, self)

				if item.npcClickFunc then
					item.npcClickFunc()
				end

				return
			end
		end
	end
end

return UnlockView
