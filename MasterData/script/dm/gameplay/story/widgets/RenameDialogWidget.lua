-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/widgets/RenameDialogWidget.lua

RenameDialogWidget = class("RenameDialogWidget", BaseWidget)

function RenameDialogWidget:initialize(view)
	super.initialize(self, view)
end

function RenameDialogWidget:dispose()
	super.dispose(self)
end

function RenameDialogWidget:setupView()
	local view = self:getView()

	AudioEngine:getInstance():playBackgroundMusic("Mus_Story_Mystery")

	local touchLayer = view:getChildByName("touch_layer")

	touchLayer:addTouchEventListener(function(sender, eventType)
		return
	end)

	self._main = self:getView():getChildByName("main")
	self._editBox = self._main:getChildByFullName("editBox.TextField")
	self._reNameBtn = self._main:getChildByFullName("reNameBtn")
	self._btnOkAnim = self._main:getChildByFullName("btn_ok.anim")
	self._btn_dice = self._main:getChildByName("btn_dice")
	self._btn_dice_click = self._main:getChildByName("btn_dice_click")
	self._rolePanel = self._main:getChildByFullName("rolePanel")
	self._animBg = self._main:getChildByFullName("AnimBg.anim")
	self._tzBg = self:getView():getChildByFullName("main.btn_ok.animBg")
	self._wzeffect = self:getView():getChildByFullName("main.btn_ok.wzeffect")

	mapButtonHandlerClick(self, self._reNameBtn, function(sender, eventType)
		self:onClickOk()
	end, view)
	mapButtonHandlerClick(self, self._btn_dice_click, function(sender, eventType)
		self:onClickDice()
	end, view)

	local nameDi = self._main:getChildByName("Image_namedi")
	local pos = nameDi:convertToWorldSpace(cc.p(0, 0))

	nameDi.worldPositionY = pos.y

	nameDi:setTouchEnabled(true)
	nameDi:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			self._editBox:openKeyboard()
		end
	end)

	local maxLength = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Name_MaxWords", "content")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setMaxLength(maxLength)
		self._editBox:setMaxLengthEnabled(true)
	end

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.NAME)

	self._editBox:onEvent(function(eventName, sender)
		if eventName == "began" then
			placeHolder = self._editBox:getPlaceHolder()

			self._editBox:setText("")
		elseif eventName == "ended" then
			-- block empty
		elseif eventName == "return" then
			-- block empty
		elseif eventName == "changed" then
			self._oldStr = self._editBox:getText()
		elseif eventName == "ForbiddenWord" then
			self:showTip(Strings:get("Common_Tip1"))
		elseif eventName == "Exceed" then
			self:showTip(Strings:get("Tips_WordNumber_Limit", {
				number = sender:getMaxLength()
			}))
		end
	end)
	StatisticSystem:send({
		point = "guide_main_rename_1",
		type = "loginpoint"
	})
	self:initMainAnim()
	self:initRoleAnim()
	self:initChallengeAnim()
end

function RenameDialogWidget:updateView(data, onEnd, agent)
	self._onEnd = onEnd
	self._agent = agent

	local view = self:getView()

	self._editBox:setText(self:getNameUntilNotForbid())

	self._isClickFlg = false

	performWithDelay(view, function()
		self._isClickFlg = true
	end, 1)
end

function RenameDialogWidget:onClickOk()
	if not self._isClickFlg then
		return
	end

	local nameStr = self._editBox:getText()

	if nameStr == "" then
		self:showTip(Strings:get("setting_tips3"))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local spaceCount = string.find(nameStr, "%s")

	if spaceCount ~= nil then
		self:showTip(Strings:get("setting_tips1"))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	local direc = self._agent:getDirector()
	local developSystem = direc:getInjector():getInstance(DevelopSystem)
	local settingSystem = developSystem:getInjector():getInstance(SettingSystem)

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)

	local function endCallback()
		local onEnd = self._onEnd

		self._onEnd = nil

		if onEnd ~= nil then
			onEnd()
		end
	end

	StatisticSystem:send({
		point = "guide_main_rename_2",
		type = "loginpoint"
	})

	if SDKHelper and SDKHelper:isEnableSdk() then
		SDKHelper:reportByAD("Toturial_complete")
		SDKHelper:reportByWM("Toturial_complete")
	end

	settingSystem:requestChangePlayerName(nameStr, true, endCallback)
end

function RenameDialogWidget:showTip(str)
	local direc = self._agent:getDirector()
	local developSystem = direc:getInjector():getInstance(DevelopSystem)

	developSystem:dispatch(ShowTipEvent({
		tip = str
	}))
end

function RenameDialogWidget:onClickDice()
	if self._editBox:getkeyboardState() then
		return
	end

	self._editBox:setText(self:getNameUntilNotForbid())
end

function RenameDialogWidget:initRoleAnim()
	local outSelf = self

	if not self._rolePanelAnim then
		self._rolePanel:removeChildByName("MasterAnim")

		self._rolePanelAnim = cc.MovieClip:create("renwu_yinghun")

		self._rolePanelAnim:addTo(self._rolePanel)
		self._rolePanelAnim:setName("MasterAnim")
		self._rolePanelAnim:addCallbackAtFrame(30, function()
			outSelf._rolePanelAnim:stop()
		end)
		self._rolePanelAnim:setPosition(cc.p(300, 275))
		self._rolePanelAnim:setPlaySpeed(1)

		self._heroAnimPanel = self._rolePanelAnim:getChildByName("heroPanel")
		self._showAnim = false
	end

	self._rolePanelAnim:gotoAndPlay(0)

	if self._rolePanelAnim then
		local panel = self._heroAnimPanel

		panel:removeAllChildren()

		local role = IconFactory:createRoleIconSpriteNew({
			id = "Model_Master_XueZhan",
			frameId = "bustframe2_1"
		})

		role:addTo(panel):posite(-500, -300)
		role:setScale(0.9)
		role:setSaturation(0)
	end
end

function RenameDialogWidget:initMainAnim()
	self:getView():stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/RenameDialog.csb")

	self:getView():runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 65, false)
	action:setTimeSpeed(1)
end

function RenameDialogWidget:initGameNameAnim()
	local direc = self._agent:getDirector()
	local loginSystem = direc:getInjector():getInstance(LoginSystem)
	local videoName = loginSystem:getLogoPvName()
	local videoSize = loginSystem:getLogoSize()
	local actionPanel = self._main:getChildByFullName("AnimBg.nameAnim")
	local localSize = actionPanel:getContentSize()
	local scale = 1

	if videoSize.height > localSize.height then
		scale = localSize.height / videoSize.height
	end

	scale = scale * 1.1

	local realVideoSize = cc.size(videoSize.width * scale, videoSize.height * scale)
	local videoPos = cc.p(localSize.width / 2, realVideoSize.height / 2 - 30)
	local video = VideoSprite.create(videoName, function(instance, eventName, index)
		if eventName == "complete" then
			instance:getPlayer():pause(true)
		end
	end)

	video:addTo(actionPanel)
	video:setContentSize(realVideoSize)
	video:setPosition(videoPos)
end

function RenameDialogWidget:initChallengeAnim()
	local qimingyeEffect = cc.MovieClip:create("m_qimingye")

	qimingyeEffect:setScale(1)
	qimingyeEffect:gotoAndPlay(0)
	self._btnOkAnim:addChild(qimingyeEffect)
	qimingyeEffect:addEndCallback(function(cid, mc)
		mc:stop()
	end)

	local lingXingAnim = qimingyeEffect:getChildByFullName("Icon")
	local baoshiEffect = cc.MovieClip:create("baoshi_lingxingbaoshi")

	baoshiEffect:setScale(1)
	baoshiEffect:gotoAndPlay(1)
	lingXingAnim:addChild(baoshiEffect)

	local bgEffect = cc.MovieClip:create("dh_choukachangjing")

	bgEffect:setScale(1)
	bgEffect:gotoAndPlay(0)
	self._animBg:addChild(bgEffect)
end

function RenameDialogWidget:getNameUntilNotForbid()
	local direc = self._agent:getDirector()
	local developSystem = direc:getInjector():getInstance(DevelopSystem)
	local settingSystem = developSystem:getInjector():getInstance(SettingSystem)
	local finalString = "Enter Your Name"

	for i = 1, 100 do
		local var_22_0, var_22_1 = StringChecker.hasForbiddenWords(settingSystem:getStrName(), MaskWordType.NAME)

		finalString = var_22_1

		if not var_22_0 then
			break
		end
	end

	return finalString
end
