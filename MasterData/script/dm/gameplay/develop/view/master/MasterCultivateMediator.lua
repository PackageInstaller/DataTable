-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterCultivateMediator.lua

MasterCultivateMediator = class("MasterCultivateMediator", DmAreaViewMediator, _M)

MasterCultivateMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MasterCultivateMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
MasterCultivateMediator:has("_masterSystem", {
	is = "r"
}):injectWith("MasterSystem")

local kBtnHandlers = {
	["mainpanel.infoPanel.attrPanel.tipBtn.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRoleCardDesc"
	},
	["mainpanel.lockPanel.tipBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onMasterPiecesAdd"
	},
	["mainpanel.leaderSkillPanel.infoButton"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeaderSkill"
	},
	["mainpanel.leadStageSkillPanel.infoButton"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeaderLeadStageSkill"
	},
	["mainpanel.infoPanel.infoNode.btn_leadStage"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeadStageIcon"
	}
}
local MasterStarCountMax = 6
local kAttrType = {
	"ATK",
	"HP",
	"DEF",
	"SPEED"
}

function MasterCultivateMediator:dispose()
	super.dispose(self)
end

function MasterCultivateMediator:onRegister()
	super.onRegister(self)

	self._masterSystem = self._developSystem:getMasterSystem()
	self._player = self._developSystem:getPlayer()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("mainpanel.lockPanel.innerUpBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickSummon, self)
		}
	})
end

function MasterCultivateMediator:setupView(parentMedi, data)
	self._parentMedi = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self:setupClickEnvs()
end

function MasterCultivateMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._infoNode = self._infoPanel:getChildByFullName("infoNode")
	self._levelNode = self._mainPanel:getChildByFullName("levelNode")
	self._rolePanel = self._mainPanel:getChildByFullName("rolePanel")
	self._lockPanel = self._mainPanel:getChildByFullName("lockPanel")
	self._innerUpBtn = self._lockPanel:getChildByFullName("innerUpBtn")
	self._leaderSkillPanel = self._mainPanel:getChildByFullName("leaderSkillPanel")
	self._leaderLeadStageSkillPanel = self._mainPanel:getChildByFullName("leadStageSkillPanel")
	self._starTouchPanel = self._infoPanel:getChildByFullName("starBg.starTouchPanel")

	self._starTouchPanel:addClickEventListener(function()
		return
	end)

	self._attrTouchLayer = self._infoPanel:getChildByFullName("attrPanel.touchLayer")

	self._attrTouchLayer:setTouchEnabled(true)
	self._attrTouchLayer:addClickEventListener(function(sender, eventType)
		self:onClickAttribute()
	end)

	local levelUpBtn = self._levelNode:getChildByFullName("levelUpBtn")

	levelUpBtn:removeChildByName("LevelTimer")

	local barImage = cc.Sprite:createWithSpriteFrameName("yh_jt_lq2.png")

	self._progrLoading = cc.ProgressTimer:create(barImage)

	self._progrLoading:setType(0)
	self._progrLoading:setReverseDirection(false)
	self._progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
	self._progrLoading:setMidpoint(cc.p(0.5, 0.5))
	self._progrLoading:addTo(levelUpBtn, 100)
	self._progrLoading:setPosition(cc.p(58, 59))
	self._progrLoading:setName("LevelTimer")
	self._lockPanel:getChildByFullName("loadingBar"):setScale9Enabled(true)
	self._lockPanel:getChildByFullName("loadingBar"):setCapInsets(cc.rect(1, 1, 1, 1))
	self:setEffect()
end

function MasterCultivateMediator:setEffect()
	GameStyle:setCommonOutlineEffect(self._infoNode:getChildByFullName("sloganLabel.sloganLabel"))

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(130, 120, 110, 255)
		}
	}

	self._lockPanel:getChildByFullName("text1"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	self._lockPanel:getChildByFullName("text2"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
end

function MasterCultivateMediator:refreshData(masterId)
	self._masterId = masterId
	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._masterLeaderSkills = self._masterSystem:getMasterLeaderSkillList(self._masterId)
end

function MasterCultivateMediator:refreshAllView(hideAnim)
	local isLock = self._masterData:getIsLock()

	self._lockPanel:setVisible(isLock)
	self._leaderSkillPanel:setVisible(not isLock)
	self._leaderLeadStageSkillPanel:setVisible(not isLock and CommonUtils.GetSwitch("fn_master_leadStage"))
	self._levelNode:setVisible(not isLock)
	self._infoPanel:getChildByFullName("attrPanel"):setVisible(not isLock)
	self._infoPanel:getChildByFullName("starBg"):setVisible(false)
	self._infoPanel:getChildByFullName("combatNode"):setVisible(not isLock)

	if isLock then
		self:refreshLock()
	else
		AudioEngine:getInstance():playEffect("Se_Effect_Character_Info", false)
		self:refreshInfoPanel()
	end

	self:refreshLeaderSkill()
	self:refreshLeadStageSkill()
	self:refreshName()
	self:initRoleAnim()
	self:refreshRole()
end

function MasterCultivateMediator:refreshLock()
	local iconPanel = self._lockPanel:getChildByFullName("icon")
	local addBtn = self._lockPanel:getChildByFullName("tipBtn")

	iconPanel:removeAllChildren()

	local info = {
		id = self._masterData:getStarUpItemId()
	}
	local icon = IconFactory:createItemIcon(info)

	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(0.6)

	local number = self._bagSystem:getItemCount(info.id)
	local maxnumber = self._masterData:getCompositePay()
	local text1 = self._lockPanel:getChildByFullName("text1")
	local text2 = self._lockPanel:getChildByFullName("text2")

	text1:setString(number)
	text2:setString("/" .. maxnumber)
	text1:setPositionX(text2:getPositionX() - text2:getContentSize().width)
	self._lockPanel:getChildByFullName("loadingBar"):setPercent(number / maxnumber * 100)
	self._innerUpBtn:setGray(number < maxnumber)
	addBtn:setVisible(number < maxnumber)
end

function MasterCultivateMediator:refreshInfoPanel()
	if self._progrLoading then
		local player = self._developSystem:getPlayer()
		local config = ConfigReader:getRecordById("LevelConfig", tostring(player:getLevel()))
		local currentExp = player:getExp()
		local percent = currentExp / config.PlayerExp * 100

		self._progrLoading:setPercentage(percent)
	end

	local levelNode = self._levelNode:getChildByFullName("levelNode")
	local levelStr = levelNode:getChildByName("levelStr")
	local label = levelNode:getChildByName("levelNum")
	local level = self._masterData:getLevel()

	label:setString(level)
	levelStr:setPositionX(-9)
	label:setPositionX(27)
	levelNode:setContentSize(cc.size(levelStr:getContentSize().width + label:getContentSize().width - 20, 50))
	self:refreshAttr()

	local combatNode = self._infoPanel:getChildByFullName("combatNode")

	if combatNode then
		local combat, attrData = self._masterData:getCombat()

		combatNode:getChildByFullName("combat"):setString(combat)
	end
end

function MasterCultivateMediator:refreshAttr()
	local attrPanel = self._infoPanel:getChildByFullName("attrPanel")
	local des_1 = attrPanel:getChildByFullName("des_1")

	if des_1:getChildByFullName("DescNode") then
		local combat, attrData = self._masterData:getCombat()

		if attrData == nil then
			attrData = {
				attack = 0,
				defense = 0,
				hp = 0,
				speed = 0
			}
		end

		local attrNum = {
			[kAttrType[1]] = attrData.attack,
			[kAttrType[2]] = attrData.hp,
			[kAttrType[3]] = attrData.defense,
			[kAttrType[4]] = attrData.speed
		}

		for i = 1, #kAttrType do
			local node = attrPanel:getChildByFullName("des_" .. i)
			local desNode = node:getChildByFullName("DescNode")
			local text = desNode:getChildByFullName("text")

			text:setString(attrNum[kAttrType[i]])
		end
	end
end

function MasterCultivateMediator:refreshInnerAttrPanel()
	self._attrShowWidget:showAttribute(self._masterData, Strings:get("HEROS_UI22"))
end

function MasterCultivateMediator:initRoleAnim()
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
		self._rolePanelAnim:setPlaySpeed(1.5)

		self._heroAnimPanel = self._rolePanelAnim:getChildByName("heroPanel")
		self._showAnim = false
	end
end

function MasterCultivateMediator:refreshRole()
	self._rolePanelAnim:gotoAndPlay(0)
	self:runStartAnim()

	if self._rolePanelAnim then
		local panel = self._heroAnimPanel

		panel:removeAllChildren()

		local role = IconFactory:createRoleIconSpriteNew({
			frameId = "bustframe2_1",
			id = self._masterData:getModel()
		})

		role:addTo(panel):posite(-500, -220)

		if self._masterData:getIsLock() then
			role:setSaturation(-100)
		else
			role:setSaturation(-0)
		end
	end
end

function MasterCultivateMediator:refreshStar()
	local star1 = self._infoPanel:getChildByFullName("starBg.star_1")

	if star1:getChildByFullName("star") then
		for i = 1, MasterStarCountMax do
			local node = self._infoPanel:getChildByFullName("starBg.star_" .. i)
			local star = node:getChildByFullName("star")
			local image = i <= self._masterData:getStar() and "common_icon_star.png" or "common_icon_star2.png"

			star:loadTexture(image, 1)
		end
	end
end

function MasterCultivateMediator:refreshName()
	local nameBg = self._infoNode:getChildByFullName("nameBg.nameBg")
	local name = self._infoNode:getChildByFullName("nameLabel.nameLabel")
	local nameString = self._masterData:getName()

	if getCurrentLanguage() ~= GameLanguageType.CN then
		name:setFontSize(26)
	end

	name:setString(nameString)
	nameBg:setScaleX((name:getContentSize().width + 70) / nameBg:getContentSize().width)

	local sloganLabelBg = self._infoNode:getChildByFullName("sloganLabelBg.sloganLabelBg")
	local sloganLabel = self._infoNode:getChildByFullName("sloganLabel.sloganLabel")
	local str = self._masterData:getFeature()

	sloganLabel:setString(str)
	sloganLabelBg:setScaleX((sloganLabel:getContentSize().width + 60) / sloganLabelBg:getContentSize().width)

	local node = self._infoNode:getChildByFullName("node_leadStage")
	local btn = self._infoNode:getChildByFullName("btn_leadStage")

	node:removeAllChildren()

	local id, lv = self._masterSystem:getMasterLeadStatgeLevel(self._masterId)

	btn:setVisible(lv > 0)

	local icon = IconFactory:createLeadStageIconHor(id, lv, {
		fontSize = 26,
		imgBg = true,
		kind = 1,
		font = CUSTOM_TTF_FONT_1
	})

	if icon then
		icon:addTo(node)
	end
end

function MasterCultivateMediator:onClickAttribute(sender, eventType)
	if not self._attrTipNode then
		self._attrTipNode = cc.CSLoader:createNode("asset/ui/MasterAttrShowTip.csb")

		self._attrTipNode:setVisible(false)
		self._attrTipNode:addTo(self._parentMedi:getView()):posite(450, 45)

		self._attrShowWidget = self:autoManageObject(self:getInjector():injectInto(MasterAttrShowTipWidget:new(self._attrTipNode)))
	end

	if self._attrTipNode:isVisible() then
		self._attrTipNode:setVisible(false)
	else
		self._attrTipNode:setVisible(true)
		self:refreshInnerAttrPanel()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function MasterCultivateMediator:refreshInnerAttrPanel()
	self._attrShowWidget:showAttribute(self._masterData, Strings:get("HEROS_UI22"))
end

function MasterCultivateMediator:onClickRoleCardDesc()
	local view = self:getInjector():getInstance("HeroCardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		type = "card"
	}))
end

function MasterCultivateMediator:onMasterPiecesAdd()
	local id = self._masterData:getStarUpItemId()
	local hasCount = self._bagSystem:getItemCount(id)
	local needCount = self._masterData:getCompositePay()
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = id,
		hasNum = hasCount,
		needNum = needCount
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, delegate, param))
end

function MasterCultivateMediator:onClickStar()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Master_StarUp")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	self._parentMedi._tabController:selectTabByTag(2)
end

function MasterCultivateMediator:onClickSummon()
	local masterConfig = ConfigReader:getRecordById("MasterBase", self._masterData:getId())
	local number = self._bagSystem:getItemCount(masterConfig.StarUpItemId)
	local maxnumber = masterConfig.CompositePay

	if number < maxnumber then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Master_Tips_Fragment_Unenough")
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local function callBack()
		local view = self:getInjector():getInstance("NewMasterView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
			masterId = self._masterData:getId()
		}))
	end

	self._masterSystem:sendApplyComposeMaster(masterConfig.StarUpItemId, callBack)
end

function MasterCultivateMediator:runStartAnim()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterCultivateUI.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 57, false)
	action:setTimeSpeed(1.1)
	self._starTouchPanel:setVisible(false)
	self._attrTouchLayer:setVisible(false)
	self._levelNode:setVisible(false)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "StarTouchAnim" then
			self._starTouchPanel:setVisible(true)

			local attrPanel = self._infoPanel:getChildByFullName("attrPanel")
			local des_1 = attrPanel:getChildByFullName("des_1")

			if not des_1:getChildByFullName("DescNode") then
				for i = 1, #kAttrType do
					local des = attrPanel:getChildByFullName("des_" .. i)

					if not des:getChildByFullName("DescNode") then
						local node = cc.CSLoader:createNode("asset/ui/HeroAttrNode.csb")

						node:addTo(des)
						node:setName("DescNode")

						local text = node:getChildByFullName("text")
						local name = node:getChildByFullName("name")
						local image = node:getChildByFullName("image")

						GameStyle:setCommonOutlineEffect(text, 142.8)
						GameStyle:setCommonOutlineEffect(name)
						name:setString(getAttrNameByType(kAttrType[i]))
						image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
					end
				end

				self:refreshAttr()
			end
		end

		if str == "SpecialTipAnim" then
			local star1 = self._infoPanel:getChildByFullName("starBg.star_1")

			if not star1:getChildByFullName("star") then
				for i = 1, MasterStarCountMax do
					local node = self._infoPanel:getChildByFullName("starBg.star_" .. i)
					local image = i <= self._masterData:getStar() and "common_icon_star.png" or "common_icon_star2.png"
					local star = ccui.ImageView:create(image, 1)

					star:ignoreContentAdaptWithSize(true)
					star:setName("star")
					star:addTo(node)
					star:setScale(0.6)
				end
			end
		end

		if str == "AttrTouchAnim" then
			self._attrTouchLayer:setVisible(true)
		end

		if str == "LevelAnim" then
			local isLock = self._masterData:getIsLock()

			self._levelNode:setVisible(not isLock)
			self._levelNode:setOpacity(0)
			self._levelNode:fadeIn({
				time = 0.2
			})
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function MasterCultivateMediator:runStartAction()
	return
end

function MasterCultivateMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_MasterCultivateMediator")
	end))

	self:getView():runAction(sequence)
end

function MasterCultivateMediator:refreshLeaderSkill()
	self._skillNodes = {}

	local leaderSkillNum = self._masterSystem:getMasterLeaderSkillNum()

	for i = 1, leaderSkillNum do
		local panel = self._mainPanel:getChildByFullName("leaderSkillPanel.skill_" .. i .. ".panel")

		panel:addClickEventListener(function()
			self:onClickSkillIcon(i)
		end)
		panel:removeAllChildren()

		local skill = self._masterLeaderSkills[i]
		local skillId = skill:getId()
		local info = {
			id = skillId,
			quality = skill:getQuality(),
			isLock = not skill:getEnable(),
			skillType = skill:getSkillType(),
			level = skill:getLevel()
		}
		local newSkillNode = IconFactory:createMasterSkillIcon(info, {
			hideLevel = true
		})

		newSkillNode:setScale(0.6)
		panel:addChild(newSkillNode)
		newSkillNode:setPosition(cc.p(9.8, 9.8))

		self._skillNodes[#self._skillNodes + 1] = newSkillNode
	end
end

function MasterCultivateMediator:refreshLeadStageSkill()
	local allSkill = self._leadStageData:getConfigInfo()
	local showLeadStageLevel = self._leadStageData:getLeadStageLevel()
	local isGray = false

	if showLeadStageLevel == 0 then
		showLeadStageLevel = 1
		isGray = true
	end

	local titleName = self._mainPanel:getChildByFullName("leadStageSkillPanel.titleName")
	local stageName = self._mainPanel:getChildByFullName("leadStageSkillPanel.stageName")
	local stageName1 = self._mainPanel:getChildByFullName("leadStageSkillPanel.stageName_0")
	local configInfo_Stage = self._leadStageData:getConfigInfo()

	if configInfo_Stage[showLeadStageLevel] then
		stageName:setString(Strings:get(configInfo_Stage[showLeadStageLevel].RomanNum) .. Strings:get(configInfo_Stage[showLeadStageLevel].StageName))
		stageName1:setString(stageName:getString())
		stageName:setPositionX(titleName:getPositionX() + titleName:getContentSize().width)
		stageName1:setPositionX(titleName:getPositionX() + titleName:getContentSize().width)
		stageName:setVisible(showLeadStageLevel == self._leadStageData:getMaxLeadStageLevel())
		stageName1:setVisible(not stageName:isVisible())
		stageName:setGray(isGray)
		stageName1:setGray(isGray)

		if not isGray then
			stageName:setGray(false)
			stageName1:setGray(false)

			if showLeadStageLevel == self._leadStageData:getMaxLeadStageLevel() then
				local lineGradiantVec2 = {
					{
						ratio = 0.3,
						color = cc.c4b(147, 255, 233, 255)
					},
					{
						ratio = 0.7,
						color = cc.c4b(255, 140, 248, 255)
					}
				}

				stageName:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
					x = 0,
					y = -1
				}))
			else
				stageName1:setTextColor(GameStyle:getLeadStageColor(showLeadStageLevel))
			end
		end
	end

	local stageSkills = allSkill[showLeadStageLevel].skills

	for index = 1, #stageSkills do
		local skillId = stageSkills[index]
		local oneSkill = stageSkills[skillId]
		local skillNode = self._mainPanel:getChildByFullName("leadStageSkillPanel.skill_" .. index .. ".panel")

		skillNode:removeAllChildren()

		local info = {
			id = skillId,
			isLock = self._leadStageData:getLeadStageLevel() == 0 and true or oneSkill.state == MasterLeadStageSkillState.KLOCK
		}
		local newSkillNode = IconFactory:createMasterLeadStageSkillIcon(info, {
			kind = 1
		}, nil)

		newSkillNode:setScale(0.6)
		newSkillNode:setPosition(cc.p(9.8, 9.8))
		newSkillNode:addTo(skillNode)
	end
end

function MasterCultivateMediator:onClickSkillIcon(index)
	if self._curSkillIndex ~= index then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function MasterCultivateMediator:onClickLeaderSkill()
	local params = {
		masterId = self._masterId,
		active = {}
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function MasterCultivateMediator:onClickLeaderLeadStageSkill()
	local systemKeeper = self:getInjector():getInstance("SystemKeeper")
	local result, tip, unLockLevel = systemKeeper:isUnlock("LeadStage")

	if not result then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LeadStage_MainSkillTip02", {
				level = unLockLevel
			})
		}))

		return
	end

	local skills = self._masterSystem:getMasterActiveSkills(self._masterId)

	if #skills == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("LeadStage_MainSkillTip01")
		}))

		return
	end

	local params = {
		index = 2,
		masterId = self._masterId,
		active = {}
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function MasterCultivateMediator:onClickLeadStageIcon()
	self._parentMedi._tabController:selectTabByTag(3)
end
