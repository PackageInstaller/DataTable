-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitMainMediator.lua

require("dm.gameplay.develop.model.hero.Hero")

RecruitMainMediator = class("RecruitMainMediator", DmAreaViewMediator, _M)

RecruitMainMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")
RecruitMainMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RecruitMainMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
RecruitMainMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")
RecruitMainMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")
require("dm.gameplay.recruit.view.RecruitResultMediator")

local kBtnHandlers = {
	recruitSkip = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSkip"
	},
	shopBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickShop"
	},
	tipBtn = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickTip"
	},
	["main.node1.recruitBtn1"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRecruit1Clicked"
	},
	["main.node2.recruitBtn2"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onRecruit2Clicked"
	},
	["moreNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickMore"
	},
	["rewardNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickReward"
	},
	["activityNode.btn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickActivity"
	}
}
local kTipBtnPosX = {
	[RecruitPoolType.kDiamond] = 480
}
local kLeftTopNodePosX = {
	[RecruitPoolType.kDiamond] = 360
}
local kLeftTopNodeText = {
	[RecruitPoolType.kActivity] = "Recruit_Time_Left1",
	[RecruitPoolType.kDiamond] = "Recruit_UI24",
	[RecruitPoolType.kEquip] = "Recruit_UI24"
}
local kLeftTopNodeBgPic = {
	[RecruitPoolType.kActivity] = "ck_xs_bg.png",
	[RecruitPoolType.kDiamond] = "ck_bg_ckxq.png",
	[RecruitPoolType.kEquip] = "ck_bg_ckxq.png"
}
local kLeftTopNodeFontSize = {
	[RecruitPoolType.kActivity] = 28,
	[RecruitPoolType.kDiamond] = 28,
	[RecruitPoolType.kEquip] = 28
}
local actions = {
	"skill3",
	"skill2",
	"skill1"
}
local descBgH = {
	["1UP"] = {
		28,
		25.8,
		25.8
	},
	["2UP"] = {
		58,
		30
	}
}
local descBgW = {
	["1UP"] = {
		100,
		100,
		100
	},
	["2UP"] = {
		60,
		40
	}
}
local descX = {
	["1UP"] = {
		20,
		40,
		60
	},
	["2UP"] = {
		10,
		-10
	}
}
local descScale9 = {
	["1UP"] = {
		cc.rect(220, 18, 1, 1),
		cc.rect(220, 18, 1, 1),
		cc.rect(220, 18, 1, 1)
	},
	["2UP"] = {
		cc.rect(110, 19, 1, 1),
		cc.rect(89, 19, 1, 1)
	}
}

function RecruitMainMediator:initialize()
	super.initialize(self)
end

function RecruitMainMediator:dispose()
	self._roleSpine = nil

	if self._timer then
		self._timer:stop()

		self._timer = nil
	end

	if self._timer2 then
		self._timer2:stop()

		self._timer2 = nil
	end

	if self._tabController then
		self._tabController:dispose()

		self._tabController = nil
	end

	if self._main.timer then
		self._main.timer:stop()

		self._main.timer = nil
	end

	super.dispose(self)
end

function RecruitMainMediator:userInject()
	return
end

function RecruitMainMediator:onRegister()
	super.onRegister(self)

	self._systemKeeper = self:getInjector():getInstance(SystemKeeper)
	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RECRUIT_SUCC, self, self.onRecruitSucc)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.onDiffRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_RESET_DONE, self, self.onResetRefresh)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateResultView)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_CLUB_FORCEDLEVEL, self, self.onForcedLevel)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE_DONE, self, self.createPushBackBoxIcon)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.createPushBackBoxIcon)

	self._recruitBtn1 = self:getView():getChildByFullName("main.node1.recruitBtn1")
	self._recruitBtn2 = self:getView():getChildByFullName("main.node2.recruitBtn2")

	local anim = cc.MovieClip:create("shiciguang_choukarenwu")

	anim:addTo(self._recruitBtn2)
	anim:setPosition(cc.p(130, 42))
	self._recruitBtn1:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 114.75), 2)
	self._recruitBtn2:getChildByFullName("text"):enableOutline(cc.c4b(0, 0, 0, 114.75), 2)
end

function RecruitMainMediator:enterWithData(data)
	self._currencyInfo = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_Resource", "content")
	self._currencyInfos = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_Resource1", "content")

	self:setupTopInfoWidget()
	self:initViewData()
	self:initView()

	if data then
		self._isFromClub = data.isFromClub or false
	end

	self._recruitIndex = 0

	if data then
		self._recruitId = data.recruitId or nil
	end

	self._curTabType = 1

	if self._recruitId then
		for i = 1, #self._recruitData do
			if self._recruitId == self._recruitData[i]:getId() then
				self._curTabType = i

				break
			end
		end
	end

	self:initTabController()
	self:setupClickEnvs()
	self:setupResultClickEnvs()
end

function RecruitMainMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfo = {}

	for i = #self._currencyInfo, 1, -1 do
		currencyInfo[#self._currencyInfo - i + 1] = self._currencyInfo[i]
	end

	local config = {
		style = 1,
		hasAnim = true,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("Recruit_UI1")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)

	self._topInfoNode = topInfoNode
end

function RecruitMainMediator:initView()
	self._heroInfoBtn = self:getView():getChildByFullName("heroInfoBtn")

	self._heroInfoBtn:setVisible(false)

	self._moreNode = self:getView():getChildByFullName("moreNode")

	self._moreNode:setVisible(false)

	self._activityNode = self:getView():getChildByFullName("activityNode")

	self._activityNode:setVisible(false)

	self._rewardNode = self:getView():getChildByFullName("rewardNode")

	self._rewardNode:setVisible(false)

	self._checkBtn = self:getView():getChildByFullName("checkBtn")

	self._checkBtn:setVisible(false)

	self._main = self:getView():getChildByFullName("main")
	self._heroInfoNode = self._main:getChildByFullName("heroInfo")

	self._heroInfoNode:setVisible(false)

	local touchPanel = self._heroInfoNode:getChildByFullName("roleNode.touchPanel")

	touchPanel:addClickEventListener(function()
		self:onClickRoleNode()
	end)

	self._leftCountNode = self:getView():getChildByFullName("leftCountNode")

	self._leftCountNode:setVisible(false)

	self._leftTimeNode = self:getView():getChildByFullName("leftTimeNode")

	self._leftTimeNode:setVisible(false)

	self._middleTimeNode = self._main:getChildByFullName("middleTimeCountNode")

	self._middleTimeNode:setVisible(false)

	self._shopBtn = self:getView():getChildByFullName("shopBtn")

	self._shopBtn:setVisible(false)

	self._tipBtn = self:getView():getChildByFullName("tipBtn")

	self._tipBtn:setVisible(false)

	self._touchLayer = self:getView():getChildByFullName("touchLayer")

	self._touchLayer:setVisible(false)

	self._recruitSkip = self:getView():getChildByFullName("recruitSkip")

	self._recruitSkip:setVisible(false)
	self._recruitSkip:setLocalZOrder(100)

	self._resultMain = self:getView():getChildByFullName("resultMain")

	self._resultMain:setVisible(false)

	self._drawNode = self:getView():getChildByFullName("drawNum")
	self._drawNum = self._drawNode:getChildByFullName("text")
	self._urEquipNode = self._main:getChildByFullName("urequip")

	self._urEquipNode:setVisible(false)

	self._diamondNode = self._main:getChildByFullName("diamond")

	self._diamondNode:setVisible(false)

	local title1 = cc.Label:createWithTTF(Strings:get("Story_Skip"), TTF_FONT_FZYH_R, 24)

	title1:enableOutline(cc.c4b(0, 0, 0, 204), 2)
	title1:addTo(self._recruitSkip):offset(self._recruitSkip:getContentSize().width * 0.5, self._recruitSkip:getContentSize().height * 0.6)

	local lineGradiantVec1 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 231, 252, 255)
		}
	}

	title1:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	local lineGradiantVec1 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(225, 222, 0, 255)
		}
	}

	self._moreNode:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	self._activityNode:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))
	self._rewardNode:getChildByFullName("text"):enablePattern(cc.LinearGradientPattern:create(lineGradiantVec1, {
		x = 0,
		y = -1
	}))

	self._showResult = nil
	self._bestRarity = 11
	self._soundId = nil
	self._linkStr = ""

	self:createVideoSprite()
end

function RecruitMainMediator:showResult()
	if self._showResult then
		self._showResult()

		self._showResult = nil

		self._recruitSkip:setVisible(false)

		if self._videoSprite then
			self._videoSprite:removeFromParent()
			self:createVideoSprite()
		end

		self._bestRarity = 11

		if self._soundId then
			AudioEngine:getInstance():stopEffect(self._soundId)

			self._soundId = nil
		end
	end
end

function RecruitMainMediator:createVideoSprite()
	self._videoSprite = VideoSprite.create("video/recruitAnim.usm", function(sprite, eventName)
		if eventName == ResultAnimOfRarity[self._bestRarity][2] then
			self:showResult()
		end
	end, nil, true)

	self:getView():addChild(self._videoSprite)
	self._videoSprite:setPosition(cc.p(568, 320))
	self._videoSprite:setVisible(false)
	self._videoSprite:getPlayer():pause(true)
end

function RecruitMainMediator:initTabController()
	local config = {
		addCellHeight = 3,
		tabImageScale = 0.6666666666666666,
		onClickTab = function(name, tag)
			self:onClickTab(name, tag)
		end
	}
	local data = {}

	for i = 1, #self._recruitData do
		local recruitData = self._recruitData[i]
		local btnImage = recruitData:getPreview().btn
		local previewType = recruitData:getPreview().type
		local temp
		local type = recruitData:getType()

		temp = (type == RecruitPoolType.kClub or type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.ACTIVITYDRAW) and {
			textOffsety = -33,
			fontSize = 12,
			unEnableOutline = true,
			textOffsetx = -74,
			tabTextTranslate = "",
			tabText = Strings:get("Recruit_Time_Left1"),
			fontName = TTF_FONT_FZYH_R,
			fontColor = cc.c3b(255, 255, 255),
			tabImage = {
				"asset/ui/recruit/" .. btnImage .. "1.png",
				"asset/ui/recruit/" .. btnImage .. "2.png"
			}
		} or {
			tabText = "",
			tabTextTranslate = "",
			tabImage = {
				"asset/ui/recruit/" .. btnImage .. "1.png",
				"asset/ui/recruit/" .. btnImage .. "2.png"
			}
		}

		if previewType and previewType ~= "diamond" then
			temp.tabImage = {
				"asset/ui/recruit/" .. btnImage .. "1.png",
				"asset/ui/recruit/" .. btnImage .. "1.png",
				"asset/ui/recruit/ck_btn_com_1.png"
			}
		end

		if temp then
			function temp.redPointFunc()
				if self._recruitSystem:checkIsShowRedPointByPool(recruitData) then
					return true
				end

				return false
			end

			temp.redPointPosx = 215
			temp.redPointPosy = 78
			data[#data + 1] = temp
		end
	end

	config.btnDatas = data

	local injector = self:getInjector()
	local widget = TabBtnWidget:createWidgetNode()

	self._tabBtnWidget = self:autoManageObject(injector:injectInto(TabBtnWidget:new(widget)))

	self._tabBtnWidget:adjustScrollViewSize(10)
	self._tabBtnWidget:initTabBtn(config, {
		noCenterBtn = true,
		ignoreSound = true,
		hideBtnAnim = true,
		imageType = ccui.TextureResType.localType
	})
	self._tabBtnWidget:selectTabByTag(self._curTabType)

	local view = self._tabBtnWidget:getMainView()
	local tabPanel = self:getView():getChildByFullName("tab_panel")

	view:addTo(tabPanel):posite(0, 0)
	view:setLocalZOrder(1100)
	view:setName("TabWidget")
end

function RecruitMainMediator:refreshTabBtn()
	local tabPanel = self:getView():getChildByFullName("tab_panel")

	tabPanel:removeChildByName("TabWidget")
	self:initTabController()
end

function RecruitMainMediator:onClickTab(name, tag)
	if self._refreshTabBtn then
		return
	end

	self._curTabType = tag

	self:updateData()
	self:updateView()

	local id = self._recruitData[tag]:getType()

	if not self._currencyInfos[id] then
		local currencyInfo = {}
		local costId = self._recruitData[tag]:getCouponId()
		local tag = false
		local goldIdx = 1

		for i = #self._currencyInfos[id], 1, -1 do
			currencyInfo[#self._currencyInfos[id] - i + 1] = self._currencyInfos[id][i]

			if costId == self._currencyInfos[id][i] then
				tag = true
			end

			if self._currencyInfos[id][i] == "IR_Gold" then
				goldIdx = #self._currencyInfos[id] - i + 1
			end
		end

		if not tag then
			if #currencyInfo >= 4 then
				currencyInfo[goldIdx] = costId
			else
				currencyInfo[#currencyInfo + 1] = costId
			end
		end

		local config_ = {
			style = 1,
			currencyInfo = currencyInfo,
			title = Strings:get("Recruit_UI1")
		}

		self._topInfoWidget:updateView(config_)
		self:createPushBackBoxIcon()
	end
end

function RecruitMainMediator:getPoolTagByName(idStr)
	for key, value in pairs(self._recruitData) do
		local id = value:getId()

		if id == idStr then
			return key
		end
	end

	return 1
end

function RecruitMainMediator:initViewData()
	self._recruitData = self._recruitSystem:getShowRecruitPools()
	self._recruitDataShow = {}
	self._recruitDataTemp = {}

	for i = 1, #self._recruitData do
		table.insert(self._recruitDataTemp, self._recruitData[i]:getId())
	end

	self._recruitDataShow = self._recruitData[self._curTabType]
end

function RecruitMainMediator:updateData()
	self._recruitManager = self._recruitSystem:getManager()
	self._recruitDataShow = {}

	if self._recruitData then
		self._recruitDataTemp = {}

		for i = 1, #self._recruitData do
			table.insert(self._recruitDataTemp, self._recruitData[i]:getId())
		end
	end

	self._recruitData = self._recruitSystem:getShowRecruitPools()

	if self._recruitDataTemp then
		if #self._recruitDataTemp ~= #self._recruitData then
			self._curTabType = 1
			self._refreshTabBtn = true
		else
			local refresh = false

			for i = 1, #self._recruitData do
				local id = self._recruitData[i]:getId()

				if not table.indexof(self._recruitDataTemp, id) then
					refresh = true

					break
				end
			end

			if refresh then
				self._curTabType = 1
				self._refreshTabBtn = true
			end
		end
	end

	self._recruitDataShow = self._recruitData[self._curTabType]
end

function RecruitMainMediator:initRoleInfo(heroId, adjustPos)
	local model = IconFactory:getRoleModelByKey("HeroBase", heroId)

	if not model or model == "" then
		return
	end

	model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

	local roleNode = self._heroInfoNode:getChildByFullName("roleNode")
	local skillDescPosX = 464

	if adjustPos then
		skillDescPosX = 600

		self._heroInfoNode:setPosition(cc.p(801.3, 426))
		roleNode:setPosition(cc.p(163.6, -161.3))
	else
		self._heroInfoNode:setPosition(cc.p(274, 146))
		roleNode:setPosition(cc.p(143.6, 101.3))
	end

	local role = RoleFactory:createRoleAnimation(model)

	role:setName("RoleAnim")
	role:addTo(roleNode):setScale(0.8):posite(-5, 5)
	role:registerSpineEventHandler(handler(self, self.spineCompleteHandler), sp.EventType.ANIMATION_COMPLETE)

	local heroData = Hero:new(heroId, self._developSystem:getPlayer())

	heroData:rCreateEffect()

	self._roleSpine = role
	self._heroActionIndex = 0

	local skillIds = heroData:getShowSkillIds()
	local num = math.min(4, #skillIds)
	local skills = {}

	for i = 1, num do
		local skillId = skillIds[i]
		local skill = heroData:getSkillById(skillId)

		table.insert(skills, skill)
	end

	for index = 1, num do
		local panel = self._heroInfoNode:getChildByFullName("node_" .. index)
		local skill = skills[index]
		local skillId = skill:getSkillId()

		skill:setLevel(1)
		skill:setEnable(true)
		panel:setTouchEnabled(true)
		panel:addClickEventListener(function()
			self:onClickSkill(skill, heroData, skillDescPosX)
		end)

		local skillIcon = IconFactory:createHeroSkillIcon({
			levelHide = true,
			hideBg = true,
			id = skillId
		})

		skillIcon:addTo(panel):center(panel:getContentSize())
		skillIcon:setScale(0.68)
		skillIcon:offset(1, 0)
	end
end

function RecruitMainMediator:onClickSkill(skill, heroData, skillDescPosX)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self:getView()):posite(464, 200)
	end

	self._skillWidget:refreshInfo(skill, heroData, false, 440)
	self._skillWidget:show()
	self._skillWidget:getView():setPositionX(skillDescPosX)
end

function RecruitMainMediator:clearRoleInfo()
	self._roleSpine = nil
	self._heroActionIndex = 0

	self._heroInfoNode:getChildByFullName("roleNode"):removeChildByName("RoleAnim")

	for i = 1, 4 do
		self._heroInfoNode:getChildByFullName("node_" .. i):removeAllChildren()
	end
end

function RecruitMainMediator:refreshHeroInfo()
	local type = self._recruitDataShow:getType()
	local nodeShow = type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub
	local hero_text = self._middleTimeNode:getChildByFullName("hero_text")
	local common_text_node = self._middleTimeNode:getChildByFullName("common_text")

	common_text_node:removeAllChildren()
	self._middleTimeNode:setVisible(nodeShow)

	local heroInfo = self._recruitDataShow:getRoleDetail()

	if heroInfo and type ~= RecruitPoolType.kActivityUREquip then
		local showACThero = ""
		local showHeroId = ""

		self._heroInfoBtn:setVisible(true)
		self._heroInfoBtn:removeAllChildren()

		for i = 1, #heroInfo do
			local heroId = heroInfo[i].hero
			local btn = self._checkBtn:clone()

			btn:setVisible(true)
			btn:addTo(self._heroInfoBtn)
			btn:setPosition(cc.p(heroInfo[i].position[1], heroInfo[i].position[2]))
			btn:addClickEventListener(function()
				self:onClickHeroInfo(heroId)
			end)

			if nodeShow and heroId then
				local str = Strings:get("Recruit_Common_UI1", {
					fontName = CUSTOM_TTF_FONT_1
				})
				local common_text = ccui.RichText:createWithXML(str, {})

				common_text:setFontColor("#a9adb5")
				common_text:setFontSize(28)
				common_text:ignoreContentAdaptWithSize(true)
				common_text:rebuildElements()
				common_text:formatText()
				common_text:setAnchorPoint(cc.p(0.5, 1))
				common_text:renderContent()
				common_text:setPosition(92, 190)
				common_text:addTo(common_text_node)

				local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(heroId)
				local descId = heroPrototype:getConfig().Position

				if descId then
					hero_text:setVisible(true)
					hero_text:setString(Strings:get(descId))
				end
			end

			if heroInfo[i].showhero and heroInfo[i].showhero ~= "" then
				showHeroId = heroInfo[i].showhero
			elseif heroInfo[i].showACThero and heroInfo[i].showACThero ~= "" then
				showACThero = heroInfo[i].showACThero
				showHeroId = heroInfo[i].showACThero
			end
		end

		self:clearRoleInfo()

		if showHeroId ~= "" then
			self._heroInfoNode:setVisible(true)
			self:initRoleInfo(showHeroId, showACThero ~= "")
		else
			self._heroInfoNode:setVisible(false)
		end
	else
		self._heroInfoNode:setVisible(false)
		self._heroInfoBtn:setVisible(false)
	end
end

function RecruitMainMediator:refreshRewardNode()
	self._rewardNode:setVisible(self._recruitDataShow:getRebateCanShow())

	if not self._rewardNodeRedPoint then
		self._rewardNodeRedPoint = RedPoint:createDefaultNode()

		self._rewardNodeRedPoint:addTo(self._rewardNode):posite(93, 93)
		self._rewardNodeRedPoint:setLocalZOrder(99)
	end

	self._rewardNodeRedPoint:setVisible(self._recruitSystem:checkIsShowRedPointByPool(self._recruitDataShow))
end

function RecruitMainMediator:refreshMoreNode()
	self._linkStr = self._recruitDataShow:getLink()

	self._moreNode:setVisible(self._linkStr ~= "")

	if self._rewardNode:isVisible() then
		local var_27_0 = self._rewardNode:getPositionX() + 95

		if not var_27_0 then
			var_27_0 = self._rewardNode:getPositionX()

			local px = var_27_0

			self._moreNode:setPositionX(px)
		end
	end
end

function RecruitMainMediator:refreshActivityNode()
	local recruitId = self._recruitDataShow:getId()
	local activity = self._activitySystem:getActivityByType(ActivityType.KDrawCardFeedbackActivity)

	if activity then
		if activity:checkRecruitIdIsInActivity(recruitId) then
			self._activityNode:setVisible(true)
		else
			self._activityNode:setVisible(false)
		end
	else
		self._activityNode:setVisible(false)
	end

	local st = self._rewardNode:isVisible() or self._moreNode:isVisible()

	if st then
		local var_28_0 = self._rewardNode:getPositionX() + 95

		if not var_28_0 then
			var_28_0 = self._rewardNode:getPositionX()

			local px = var_28_0

			self._activityNode:setPositionX(px)
		end
	end
end

function RecruitMainMediator:runNodeActions()
	local recruitBg = self._main:getChildByFullName("recruitBg")

	recruitBg:removeAllChildren()
	self._shopBtn:stopAllActions()
	self._moreNode:stopAllActions()
	self._rewardNode:stopAllActions()
	self._activityNode:stopAllActions()
	self._recruitBtn1:stopAllActions()
	self._recruitBtn2:stopAllActions()
	self._recruitBtn1:setTouchEnabled(false)
	self._recruitBtn2:setTouchEnabled(false)
	self._shopBtn:setOpacity(0)
	self._moreNode:setOpacity(0)
	self._rewardNode:setOpacity(0)
	self._activityNode:setOpacity(0)
	self._recruitBtn1:setOpacity(0)
	self._recruitBtn2:setOpacity(0)

	local bgName = self._recruitDataShow:getPreview().main

	if bgName then
		local function showFunc()
			self._recruitBtn1:setPosition(cc.p(0, -70))
			self._recruitBtn2:setPosition(cc.p(0, -70))

			local moveTo1 = cc.MoveTo:create(0.2, cc.p(0, 15))
			local fadeIn = cc.FadeIn:create(0.2)
			local moveTo2 = cc.MoveTo:create(0.06666666666666667, cc.p(0, 0))
			local spawn = cc.Spawn:create(moveTo1, fadeIn)
			local seq = cc.Sequence:create(spawn, moveTo2)
			local openNormal = cc.CallFunc:create(function()
				local id = self._recruitDataShow:getId()

				if id == "DrawCard_Diamond_1" or id == "DrawCard_NewPlayer" then
					local storyDirector = self:getInjector():getInstance(story.StoryDirector)

					storyDirector:notifyWaiting("enter_recruitMain_view_open_normal")
				end
			end)

			self._recruitBtn1:runAction(seq)

			moveTo1 = cc.MoveTo:create(0.2, cc.p(0, 15))
			fadeIn = cc.FadeIn:create(0.2)
			moveTo2 = cc.MoveTo:create(0.06666666666666667, cc.p(0, 0))
			spawn = cc.Spawn:create(moveTo1, fadeIn)
			seq = cc.Sequence:create(spawn, moveTo2, openNormal)

			self._recruitBtn2:runAction(seq)
			self._recruitBtn1:setTouchEnabled(true)
			self._recruitBtn2:setTouchEnabled(true)
			self._shopBtn:fadeIn({
				time = 0.2
			})
			self._moreNode:fadeIn({
				time = 0.2
			})
			self._rewardNode:fadeIn({
				time = 0.2
			})
			self._activityNode:fadeIn({
				time = 0.2
			})
		end

		local recruitId = self._recruitDataShow:getId()
		local hasAnim = table.keyof(RecruitPoolId, recruitId)

		if hasAnim then
			local anim = cc.MovieClip:create(bgName .. "_choukarenwu")

			anim:addTo(recruitBg)
			anim:setPosition(cc.p(50, 50))
			anim:addEndCallback(function()
				anim:stop()
			end)
			anim:setName(bgName)

			local frame = 23

			anim:addCallbackAtFrame(frame, function()
				showFunc()
			end)

			local bg

			if recruitId == RecruitPoolId.kHeroDiamond then
				bg = cc.MovieClip:create("dh_choukachangjing")

				bg:addEndCallback(function()
					bg:stop()
				end)

				local animPath = "asset/anim/portraitpic_MLYTLSha_CK.skel"

				if cc.FileUtils:getInstance():isFileExist(animPath) then
					local spineNode = sp.SkeletonAnimation:create(animPath)

					spineNode:playAnimation(0, "animation", true)
					spineNode:addTo(bg):posite(55, -660)
					spineNode:setScale(1.15)
				end
			else
				bg = ccui.ImageView:create("asset/scene/" .. bgName .. ".jpg")
			end

			bg:addTo(anim:getChildByFullName("bgPanel"))
			anim:gotoAndPlay(0)
			anim:setVisible(true)
		else
			showFunc()

			local bg = ccui.ImageView:create("asset/scene/" .. bgName .. ".jpg")

			bg:addTo(recruitBg):center(recruitBg:getContentSize())

			local size = bg:getContentSize()

			if size.width > 1512 then
				bg:setScale(0.6666666666666666)
			end

			local previewType = self._recruitDataShow:getPreview().type

			if previewType == "diamond" then
				bg:setOpacity(178.5)
				bg:setFlippedX(true)
			end
		end
	end
end

function RecruitMainMediator:initCostNode(recruitCost, costNode, offCount)
	local icon1 = costNode:getChildByFullName("icon")
	local name1 = costNode:getChildByFullName("name")
	local freeText = costNode:getChildByFullName("freeText")
	local costId = recruitCost.costId
	local costCount = recruitCost.costCount

	if costCount == 0 then
		icon1:setVisible(false)
		name1:setVisible(false)
		freeText:setVisible(true)
	else
		icon1:setVisible(true)
		name1:setVisible(true)
		freeText:setVisible(false)

		local prototype = ItemPrototype:new(costId)
		local item = Item:new(prototype)

		name1:setString(item:getName() .. "  x" .. costCount)
		icon1:removeAllChildren()

		local costIcon = IconFactory:createPic({
			id = costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.45)
		costIcon:addTo(icon1):center(icon1:getContentSize())

		if costId ~= "IM_DiamondDraw" and costId ~= "IM_DiamondDrawEX" then
			icon1:setPositionY(15)
		end

		icon1:setPositionX(name1:getPositionX() - name1:getContentSize().width / 2 - 2)
	end

	local costOffBg = costNode:getChildByFullName("costOffBg")

	if offCount ~= 100 then
		costOffBg:setVisible(true)
		costOffBg:getChildByFullName("costOff"):setString(100 - offCount .. "%")
	else
		costOffBg:setVisible(false)
	end
end

function RecruitMainMediator:refreshLeftTopNode()
	local id = self._recruitDataShow:getId()
	local type = self._recruitDataShow:getType()
	local previewType = self._recruitDataShow:getPreview().type

	if type == RecruitPoolType.kActivity or type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub or type == RecruitPoolType.kActivityUREquip then
		if id == RecruitNewPlayerPool then
			self._leftTimeNode:setVisible(false)
			self._tipBtn:setVisible(false)
		else
			self._leftTimeNode:setVisible(true)
			self._tipBtn:setVisible(true)

			local bgpic = self._leftTimeNode:getChildByFullName("bgpic")
			local text1 = self._leftTimeNode:getChildByFullName("text1")

			bgpic:loadTexture(kLeftTopNodeBgPic[RecruitPoolType.kActivity], ccui.TextureResType.plistType)
			bgpic:ignoreContentAdaptWithSize(true)
			bgpic:setScale(0.66)
			text1:setString(Strings:get(kLeftTopNodeText[RecruitPoolType.kActivity]))
			text1:setFontSize(kLeftTopNodeFontSize[RecruitPoolType.kActivity])

			local function checkTimeFunc()
				local type = self._recruitDataShow:getType()
				local id = self._recruitDataShow:getId()

				if (type == RecruitPoolType.kActivity or type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub or type == RecruitPoolType.kActivityUREquip) and id ~= RecruitNewPlayerPool then
					local text = self._leftTimeNode:getChildByFullName("text")
					local unlock, activityId = self._recruitSystem:getActivityIsOpen(id)

					if not unlock then
						self._recruitSystem:tryEnter()

						return
					end

					local activity = self._activitySystem:getActivityById(activityId)
					local endTime = activity:getEndTime()
					local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimeMillis()
					local remainTime = endTime - remoteTimestamp

					if remainTime <= 0 then
						self._leftTimeNode:setVisible(false)

						return
					end

					local fmtStr = "${d}:${H}:${M}:${S}"
					local timeStr = TimeUtil:formatTime(fmtStr, remainTime * 0.001)
					local parts = string.split(timeStr, ":", nil, true)
					local timeTab = {}

					timeTab.day = tonumber(parts[1])
					timeTab.hour = tonumber(parts[2])
					timeTab.min = tonumber(parts[3])
					timeTab.sec = tonumber(parts[4])

					text:setString(Strings:get("Recruit_Time_Left") .. (timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")))
				end
			end

			if not self._timer then
				self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 0.2, false)

				checkTimeFunc()
			end
		end
	else
		self._leftTimeNode:setVisible(true)
		self._tipBtn:setVisible(true)

		local bgpic = self._leftTimeNode:getChildByFullName("bgpic")
		local text1 = self._leftTimeNode:getChildByFullName("text1")
		local timeLeft = self._leftTimeNode:getChildByFullName("text")

		bgpic:loadTexture(kLeftTopNodeBgPic[type] or kLeftTopNodeBgPic[RecruitPoolType.kEquip], ccui.TextureResType.plistType)
		bgpic:ignoreContentAdaptWithSize(false)
		bgpic:setScaleY(0.66)
		bgpic:setScaleX(0.45)
		timeLeft:setString("")
		text1:setString(Strings:get(kLeftTopNodeText[type] or kLeftTopNodeText[RecruitPoolType.kEquip]))
		text1:setFontSize(kLeftTopNodeFontSize[type] or kLeftTopNodeFontSize[RecruitPoolType.kEquip])
	end

	local tabPanel = self:getView():getChildByFullName("tab_panel")

	self._leftTimeNode:setPositionX(kLeftTopNodePosX[type] or tabPanel:getPositionX() + 220)

	if type == RecruitPoolType.kEquip then
		self._tipBtn:setPositionX(tabPanel:getPositionX() + 340)
	else
		self._tipBtn:setPositionX(kTipBtnPosX[type] or tabPanel:getPositionX() + 629)
	end

	self._drawNode:setVisible(id ~= RecruitNewPlayerPool)

	local drawNum = self._recruitSystem:getDrawTimeById(id)

	if type == RecruitPoolType.kActivity or type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub or type == RecruitPoolType.kActivityUREquip then
		self._drawNode:setPosition(cc.p(900, self._leftTimeNode:getPositionY() - 23))

		if previewType == "diamond" then
			self._drawNode:setPosition(cc.p(1020, self._leftTimeNode:getPositionY() - 23))
		end
	else
		self._drawNode:setPosition(cc.p(self._leftTimeNode:getPositionX(), self._leftTimeNode:getPositionY() - 62))
	end

	local n = self._recruitSystem:getDailyDrawTimeById(id)

	n = n and n or 0

	local m = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "DrawCard_DailyReset", "content")
	local str = Strings:get("DrawCard_Chongzhi", {
		factor1 = n,
		factor2 = m
	})

	self._drawNum:setString(str)

	local imgbg = self._drawNode:getChildByFullName("Image_1")

	imgbg:setContentSize(cc.size(self._drawNum:getAutoRenderSize().width + 100, imgbg:getContentSize().height))

	if id ~= RecruitNewPlayerPool and self._descLabel then
		self._descLabel:removeFromParent()
		self._background:removeFromParent()
	end

	if id ~= RecruitNewPlayerPool then
		self._descLabel = cc.Label:createWithTTF(Strings:get("DrawCard_danchou", {
			factor1 = drawNum["1"] - 10 * drawNum["10"],
			factor2 = drawNum["10"]
		}), TTF_FONT_FZYH_R, 20)

		self._descLabel:addTo(self._main, 99):setPosition(940, 15)
		self._descLabel:setVisible(id ~= RecruitNewPlayerPool)

		self._background = cc.Sprite:createWithSpriteFrameName("bg_huoqu_title_name.png")

		self._background:addTo(self._main):setPosition(cc.p(self._descLabel:getPositionX() - 5, self._descLabel:getPositionY() - 5))
		self._background:setContentSize(self._descLabel:getContentSize())
	end
end

function RecruitMainMediator:refreshMiddleTime()
	local id = self._recruitDataShow:getId()
	local type = self._recruitDataShow:getType()

	local function checkTimeFunc()
		local type = self._recruitDataShow:getType()
		local id = self._recruitDataShow:getId()
		local nodeShow = type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub

		self._middleTimeNode:setVisible(nodeShow)

		if nodeShow then
			local text = self._middleTimeNode:getChildByFullName("text")
			local count = self._middleTimeNode:getChildByFullName("count")
			local unlock, activityId = self._recruitSystem:getActivityIsOpen(id)

			if not unlock then
				self._recruitSystem:tryEnter()

				return
			end

			local activity = self._activitySystem:getActivityById(activityId)
			local endTime = activity:getEndTime()
			local remoteTimestamp = self:getInjector():getInstance("GameServerAgent"):remoteTimeMillis()
			local remainTime = endTime - remoteTimestamp

			if remainTime <= 0 then
				self._middleTimeNode:setVisible(false)

				return
			end

			local str = ""
			local fmtStr = "${d}:${H}:${M}:${S}"
			local timeStr = TimeUtil:formatTime(fmtStr, remainTime * 0.001)
			local parts = string.split(timeStr, ":", nil, true)
			local timeTab = {}

			timeTab.day = tonumber(parts[1])
			timeTab.hour = tonumber(parts[2])
			timeTab.min = tonumber(parts[3])
			timeTab.sec = tonumber(parts[4])
			str = timeTab.day > 0 and timeTab.day .. Strings:get("TimeUtil_Day") .. timeTab.hour .. Strings:get("TimeUtil_Hour2") or timeTab.hour > 0 and timeTab.hour .. Strings:get("TimeUtil_Hour2") .. timeTab.min .. Strings:get("TimeUtil_Min") or timeTab.min .. Strings:get("TimeUtil_Min") .. timeTab.sec .. Strings:get("TimeUtil_Sec")

			text:setString(Strings:get("Recruit_Time_Left3", {
				str = str
			}))

			local timeMap = self._recruitSystem:getDrawTimeById(id)
			local specialTime = self._recruitDataShow:getSpecialRewardTimes()

			if not timeMap["1"] then
				local usedTime = 0
				local leftTime = math.floor(tonumber(usedTime) % specialTime)

				leftTime = specialTime - leftTime
				self._remainTimes = leftTime

				count:setString(leftTime)
			end
		end
	end

	if not self._timer2 then
		self._timer2 = LuaScheduler:getInstance():schedule(checkTimeFunc, 0.2, false)

		checkTimeFunc()
	end
end

function RecruitMainMediator:updateView()
	if self._refreshTabBtn then
		self:refreshTabBtn()
	end

	local type = self._recruitDataShow:getType()

	self._tipBtn:setVisible(type ~= RecruitPoolType.kDiamond and type ~= RecruitPoolType.kEquip and self._recruitDataShow:getId() ~= RecruitNewPlayerPool)
	self._shopBtn:setVisible(self._shopSystem:isShopFragmentOpen() and (type == RecruitPoolType.kDiamond or type == RecruitPoolType.kActivity or type == RecruitPoolType.kActivityUREquip))

	local previewType = self._recruitDataShow:getPreview().type

	if type == RecruitPoolType.kActivityUREquip then
		self._main:getChildByFullName("node1"):setPositionY(85)
		self._main:getChildByFullName("node2"):setPositionY(85)
	elseif previewType == "diamond" then
		self._main:getChildByFullName("node1"):setPositionY(65)
		self._main:getChildByFullName("node2"):setPositionY(65)
	else
		self._main:getChildByFullName("node1"):setPositionY(97)
		self._main:getChildByFullName("node2"):setPositionY(97)
	end

	if self._descLabel then
		self._descLabel:setVisible(false)
		self._background:setVisible(false)
	end

	self:refreshHeroInfo()
	self:refreshRewardNode()
	self:refreshMoreNode()
	self:refreshActivityNode()
	self:refreshLeftTopNode()
	self:refreshMiddleTime()
	self:refreshActivityUpView()
	self:runNodeActions()
	self:refreshUREQuipInfo()
	self:refreshDiamondView()

	local costNode1 = self._main:getChildByFullName("node1.recruitBtn1")
	local costNode2 = self._main:getChildByFullName("node2.recruitBtn2")
	local id = self._recruitDataShow:getId()
	local hasLeft = ""
	local costData

	if self._recruitDataShow:getRealCostIdAndCount()[1] then
		local costCount, offCount = self._recruitDataShow:getRealCostIdAndCount()[1], 100
		local time = self._recruitDataShow:getRecruitTimes()[1]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, costCount, time)
		end

		self:initCostNode(costCount, costNode1, offCount)
		self._recruitBtn1:getChildByFullName("text"):setString(Strings:get(self._recruitDataShow:getShortDesc()[1]))
		self._recruitBtn1:getChildByFullName("text_1"):setString(Strings:get(self._recruitDataShow:getShortDescEn()[1]))

		if self._recruitDataShow:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = self._recruitDataShow:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end
	end

	if self._recruitDataShow:getRealCostIdAndCount()[2] then
		self:getView():getChildByFullName("main.node1"):setPositionX(452)
		self._recruitBtn2:setVisible(true)

		local costCount, offCount = self._recruitDataShow:getRealCostIdAndCount()[2], 100
		local time = self._recruitDataShow:getRecruitTimes()[2]

		if time ~= 1 then
			costCount, offCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, costCount, time)
		end

		if hasLeft == "" and self._recruitDataShow:hasDrawLimit() then
			costData = costCount

			local usedTime = self._recruitSystem:getDrawTimeById(id)
			local timeLimit = self._recruitDataShow:getDrawLimit()

			usedTime = usedTime["1"] or usedTime[tostring(time)]
			usedTime = tonumber(usedTime)
			hasLeft = (timeLimit <= usedTime or time > timeLimit - usedTime) and 0 or math.floor((timeLimit - usedTime) / time)
		end

		self:initCostNode(costCount, costNode2, offCount)
		self._recruitBtn2:getChildByFullName("text"):setString(Strings:get(self._recruitDataShow:getShortDesc()[2]))
		self._recruitBtn2:getChildByFullName("text_1"):setString(Strings:get(self._recruitDataShow:getShortDescEn()[2]))
	else
		self:getView():getChildByFullName("main.node1"):setPositionX(629)
		self._recruitBtn2:setVisible(false)
	end

	if previewType == "diamond" then
		self:getView():getChildByFullName("main.node1.recruitBtn1"):loadTextures("lj_bbtl.png", "lj_bbtl.png", "lj_bbtl.png", 1)
	else
		self:getView():getChildByFullName("main.node1.recruitBtn1"):loadTextures("lj_bbt.png", "lj_bbt.png", "lj_bbt.png", 1)
	end

	local previewType = self._recruitDataShow:getPreview().type

	if hasLeft ~= "" and previewType ~= "diamond" then
		self._leftCountNode:setVisible(true)
		self._leftCountNode:getChildByFullName("text"):setString(hasLeft)

		local icon = self._leftCountNode:getChildByFullName("icon")
		local costIcon = IconFactory:createPic({
			id = costData.costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.5)
		costIcon:addTo(icon)
	else
		self._leftCountNode:setVisible(false)
	end
end

function RecruitMainMediator:onDiffRefresh(event)
	self:updateData()
	self:updateView()
end

function RecruitMainMediator:onResetRefresh(event)
	local data = event:getData()

	if data and (data[ResetId.kRecruitGoldFree] or data[ResetId.kRecruitDiamondFree] or data[ResetId.kRecruitEquipFree] or data[ResetId.kRecruitDiamondTimes]) then
		self:updateData()
		self:updateView()
	end
end

function RecruitMainMediator:onRecruitSucc(event)
	self._touchLayer:setVisible(true)

	local data = event:getData()

	if data == nil then
		self._touchLayer:setVisible(false)

		return
	end

	data.recruitId = self._recruitDataShow:getId()
	self._recruitManager = self._recruitSystem:getManager()

	local recruitPool = self._recruitManager:getRecruitPoolById(data.recruitId)
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() and guideAgent:getCurrentScriptName() == "guide_chapterOne1_4" then
		StatisticSystem:send({
			point = "guide_main_recruit_12",
			type = "loginpoint"
		})
	end

	if recruitPool then
		self:enterResultWithData(data)
	end
end

function RecruitMainMediator:onClickBack()
	self:getView():stopAllActions()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_recruitMain_view")
	self:dismissWithOptions({
		transition = ViewTransitionFactory:create(ViewTransitionType.kCommonAreaView)
	})
end

function RecruitMainMediator:onForcedLevel(event)
	if self._isFromClub then
		self:onClickBack()
	end
end

function RecruitMainMediator:checkHasTimesLimit(recruitDataShow, realTimes)
	local id = recruitDataShow:getId()

	if recruitDataShow:hasDrawLimit() then
		local time = self._recruitSystem:getDrawTimeById(id)
		local timeLimit = recruitDataShow:getDrawLimit()

		time = time["1"] or time[tostring(realTimes)]
		time = tonumber(time)

		if timeLimit <= time or realTimes > timeLimit - time then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Recruit_Times_Out")
			}))

			return true
		end
	end

	return false
end

function RecruitMainMediator:onRecruit1Clicked()
	self._recruitIndex = 1

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitDataShow, times)

	if hasLimit then
		return
	end

	local costId = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costCount

	if times ~= 1 then
		local countData = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex]

		costCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, countData, times)
		costCount = costCount.costCount
	end

	local param = {
		id = id,
		times = times
	}

	if self._bagSystem:checkCostEnough(costId, costCount, {
		notShowTip = true
	}) then
		self._recruitSystem:requestRecruit(param)
	elseif RecruitCurrencyStr.KUserDefault[costId] then
		self:buyCard(costId, costCount, param)
	else
		local ret = self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})

		if not ret then
			local type = self._recruitDataShow:getType()

			if type == RecruitPoolType.kDiamond then
				self._developSystem:requstNotEnoughItem("DRAW", costId)
			end
		end
	end
end

function RecruitMainMediator:onRecruit2Clicked()
	self._recruitIndex = 2

	local id = self._recruitDataShow:getId()
	local times = self._recruitDataShow:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitDataShow, times)

	if hasLimit then
		return
	end

	local costId = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costCount

	if times ~= 1 then
		local countData = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex]

		costCount = self._recruitSystem:getRecruitRealCost(self._recruitDataShow, countData, times)
		costCount = costCount.costCount
	end

	local param = {
		id = id,
		times = times
	}

	if self._bagSystem:checkCostEnough(costId, costCount) then
		self._recruitSystem:requestRecruit(param)
	elseif RecruitCurrencyStr.KUserDefault[costId] then
		self:buyCard(costId, costCount, param)
	else
		local ret = self._bagSystem:checkCostEnough(costId, costCount, {
			type = "popup"
		})

		if not ret then
			local type = self._recruitDataShow:getType()

			if type == RecruitPoolType.kDiamond then
				self._developSystem:requstNotEnoughItem("DRAW", costId)
			end
		end
	end
end

function RecruitMainMediator:buyCard(costId, costCount, param)
	if self._recruitSystem:getCanAutoBuy(costId) then
		self:autoBuy(costId, costCount, param)

		return
	end

	local view = self:getInjector():getInstance("RecruitBuyView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		itemId = costId,
		costCount = costCount,
		param = param
	}))
	self._resultMain:removeAllChildren()
	self._resultMain:setVisible(false)
end

function RecruitMainMediator:autoBuy(costId, costCount, param)
	if param.times == 1 then
		if not RecruitCurrencyStr.KBuyPrice.single[costId] then
			local price = RecruitCurrencyStr.KBuyPrice.ten[costId]
			local hasCount = self._bagSystem:getItemCount(costId)
			local num = costCount - hasCount
			local cost = num * price
			local hasDiamondCount = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)
			local canBuy = cost <= hasDiamondCount

			if not canBuy then
				local data = {
					title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
					content = RecruitCurrencyStr.KGoToShop[costId],
					sureBtn = {},
					cancelBtn = {}
				}
				local outSelf, delegate = self, {}

				function delegate:willClose(popupMediator, data)
					if data.response == "ok" then
						outSelf._shopSystem:tryEnter({
							shopId = "Shop_Mall"
						})
					end
				end

				local view = self:getInjector():getInstance("AlertView")

				self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
					transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
				}, data, delegate))

				local type = self._recruitDataShow:getType()

				if type == RecruitPoolType.kDiamond then
					self._developSystem:requstNotEnoughItem("DRAW", costId)
				end

				return
			else
				self._recruitSystem:requestRecruit(param)
			end
		end
	end
end

function RecruitMainMediator:onClickPreview()
	local type = self._recruitDataShow:getType()
	local heroes

	if type == RecruitPoolType.kActivity then
		local id = self._recruitDataShow:getId()
		local unlock, activityId = self._recruitSystem:getActivityIsOpen(id)
		local activity = self._activitySystem:getActivityById(activityId)
		local activityConfig = activity:getActivityConfig()

		heroes = activityConfig.drawhero
	end

	local function callback(rewards)
		local view = self:getInjector():getInstance("recruitHeroPreviewView")

		self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			recruitPool = self._recruitDataShow,
			rewards = rewards,
			heroes = heroes
		}))
	end

	local showRewards = self._recruitDataShow:getShowRewards()
	local key = next(showRewards)

	if not key or key == "" then
		return
	end

	local params = {
		drawID = self._recruitDataShow:getId(),
		key = key
	}

	self._recruitSystem:requestRewardPreview(params, callback)
end

function RecruitMainMediator:onClickTip()
	local type = self._recruitDataShow:getType()

	if type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub then
		local function callback(rewards)
			local view = self:getInjector():getInstance("RecruitCommonPreviewView")

			self:getEventDispatcher():dispatchEvent(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, {
				recruitPool = self._recruitDataShow,
				rewards = rewards,
				remainTimes = self._remainTimes
			}))
		end

		local showRewards = self._recruitDataShow:getShowRewards()
		local key = next(showRewards)

		if not key or key == "" then
			return
		end

		local params = {
			drawID = self._recruitDataShow:getId(),
			key = key
		}

		self._recruitSystem:requestRewardPreview(params, callback)
	else
		self:onClickPreview()
	end
end

function RecruitMainMediator:onClickSkip()
	self._animSkip = true

	self:showResult()
end

function RecruitMainMediator:onClickShop()
	local shopSystem = self:getInjector():getInstance(ShopSystem)

	shopSystem:tryEnterDebris()
end

function RecruitMainMediator:onClickHeroInfo(heroId)
	local view = self:getInjector():getInstance("HeroInfoView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = heroId
	}))
end

function RecruitMainMediator:onClickMore()
	if self._linkStr == "" then
		return
	end

	local context = self:getInjector():instantiate(URLContext)
	local entry, params = UrlEntryManage.resolveUrlWithUserData(self._linkStr)

	if not entry then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Function_Not_Open")
		}))
	else
		entry:response(context, params)
	end
end

function RecruitMainMediator:onClickReward()
	local view = self:getInjector():getInstance("RecruitRewardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		recruitData = self._recruitDataShow
	}, nil))
end

function RecruitMainMediator:onClickActivity()
	local activity = self._activitySystem:getActivityByType(ActivityType.KDrawCardFeedbackActivity)

	self._activitySystem:tryEnter({
		id = activity:getId()
	})
end

function RecruitMainMediator:onClickRoleNode()
	if not self._roleSpine then
		return
	end

	self._heroActionIndex = self._heroActionIndex + 1

	if self._heroActionIndex > #actions then
		self._heroActionIndex = 1
	end

	local actionName = actions[self._heroActionIndex]

	if actionName then
		self._roleSpine:playAnimation(0, actionName, true)
	end
end

function RecruitMainMediator:spineCompleteHandler(event)
	if event.type == "complete" and event.animation ~= "stand" and self._roleSpine then
		self._roleSpine:playAnimation(0, "stand", true)
	end
end

function RecruitMainMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local guideAgent = storyDirector:getGuideAgent()

	if guideAgent:isGuiding() and guideAgent:getCurrentScriptName() == "guide_chapterOne1_4" then
		local stageSystem = self:getInjector():getInstance(StageSystem)
		local point = stageSystem:getPointById("M01S04")
		local tag

		self:onClickTab(nil, point and point:isPass() and self:getPoolTagByName("DrawCard_NewPlayer") or self:getPoolTagByName("DrawCard_Diamond_1"))

		if self._tabBtnWidget then
			local tabBtn = self._tabBtnWidget._tabBtns

			if tabBtn[1] then
				storyDirector:setClickEnv("recruitMain.friendBtn", tabBtn[1], function(sender, eventType)
					self:onClickTab(nil, 1)
				end)
			end

			if tabBtn[2] then
				storyDirector:setClickEnv("recruitMain.friendBtn", tabBtn[2], function(sender, eventType)
					self:onClickTab(nil, 2)
				end)
			end
		end

		self._tabBtnWidget:selectTabByTag(self._curTabType)

		local btnBack = self:getView():getChildByFullName("topinfo_node.back_btn")

		storyDirector:setClickEnv("recruitMain.btnBack", btnBack, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Close_1", false)
			self:onClickBack()
		end)

		local sequence = cc.Sequence:create(cc.DelayTime:create(0.5), cc.CallFunc:create(function()
			local recruitBtn1 = self:getView():getChildByFullName("main.node1.recruitBtn1")

			storyDirector:setClickEnv("recruitMain.recruitBtn1", recruitBtn1, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onRecruit1Clicked()
			end)

			local recruitBtn2 = self:getView():getChildByFullName("main.node2.recruitBtn2")

			storyDirector:setClickEnv("recruitMain.recruitBtn2", recruitBtn2, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onRecruit2Clicked()
			end)

			local recruitBtn3 = self:getView():getChildByFullName("main.node3")

			storyDirector:setClickEnv("recruitMain.recruitBtn3", recruitBtn3, function(sender, eventType)
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
				self:onRecruit1Clicked()
			end)
			storyDirector:notifyWaiting("enter_recruitMain_view")
		end))

		self:getView():runAction(sequence)

		local __onClickSkip = self.onClickSkip
		local this = self

		function self.onClickSkip()
			__onClickSkip(this)
			StatisticSystem:send({
				point = "guide_main_recruit_13",
				type = "loginpoint"
			})
		end
	end
end

function RecruitMainMediator:setupResultClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local view = self:getView()
	local btn = view:getChildByFullName("guideNode")

	if btn then
		storyDirector:setClickEnv("recruitHeroDiamondResul.okBtn", btn, function(sender, eventType)
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickClose(sender, eventType)
		end)
	end

	storyDirector:notifyWaiting("enter_recruitHeroDiamondResul_view")
end

function RecruitMainMediator:refreshActivityUpView()
	local up1 = self._main:getChildByName("Node_1Up")
	local up2 = self._main:getChildByName("Node_2Up")
	local previewType = self._recruitDataShow:getPreview().type

	if previewType ~= "1UP" and previewType ~= "2UP" then
		up1:setVisible(false)
		up2:setVisible(false)

		return
	end

	local previewImg = self._recruitDataShow:getPreview().imgcolor

	local function setName(node, rect, size)
		local name = node:getChildByName("name")

		name:setString("")
		name:getParent():removeChildByName("richTextName")

		local richTextName = ccui.RichText:createWithXML(self._recruitDataShow:getName(CUSTOM_TTF_FONT_1), {})

		richTextName:setAnchorPoint(name:getAnchorPoint())
		richTextName:setPosition(name:getPosition())
		richTextName:addTo(name:getParent())
		richTextName:renderContent(0, 0, true)
		richTextName:setName("richTextName")

		local namebg = node:getChildByName("namebg")

		namebg:setScale9Enabled(true)

		local color = string.split(previewImg[1], ",")

		namebg:setColor(cc.c3b(color[1], color[2], color[3]))

		if previewType == "1UP" then
			namebg:setCapInsets(cc.rect(80, 10, 1, 1))
			namebg:setContentSize(cc.size(richTextName:getContentSize().width + 60, 38))
		else
			namebg:setCapInsets(cc.rect(1, 1, 1, 1))
			namebg:setContentSize(cc.size(node:getChildByName("name1"):getContentSize().width + 50, 63))
		end
	end

	local function setRole(node)
		local heroInfo = self._recruitDataShow:getRoleDetail()

		for i = 1, #heroInfo do
			local heroId = heroInfo[i].hero
			local config = ConfigReader:getRecordById("HeroBase", tostring(heroId))
			local roleNode = node:getChildByName("roleNode" .. i)
			local rolenamebg = roleNode:getChildByName("rolenamebg")
			local rolerarity = roleNode:getChildByName("rolerarity")
			local rolename = roleNode:getChildByName("rolename")
			local roletag = roleNode:getChildByName("roletag")

			rolerarity:loadTexture(GameStyle:getHeroRarityImage(config.Rareity), ccui.TextureResType.plistType)
			rolename:setString(Strings:get(config.Name))
			roletag:setString(Strings:get(config.Position))
			rolenamebg:setContentSize(cc.size(rolename:getContentSize().width + 50, 48))

			if previewType == "1UP" then
				rolerarity:setPositionX(rolename:getContentSize().width / 2)
			else
				rolerarity:setPositionX(-rolename:getContentSize().width / 2 + 10)
			end
		end
	end

	local function setDesc(node)
		local poolDesc = self._recruitDataShow:getPoolDesc()

		for index, trans in ipairs(poolDesc) do
			local descbg = node:getChildByName("descbg" .. index)

			if descbg then
				if previewType == "2UP" and index == 2 then
					local color = string.split(previewImg[3], ",")

					descbg:setColor(cc.c3b(color[1], color[2], color[3]))
				else
					local color = string.split(previewImg[2], ",")

					descbg:setColor(cc.c3b(color[1], color[2], color[3]))
				end

				descbg:getParent():removeChildByName("descRichText" .. index)

				local desc = ccui.RichText:createWithXML(Strings:get(trans, {
					fontName = CUSTOM_TTF_FONT_1
				}), {})

				desc:setAnchorPoint(descbg:getAnchorPoint())
				desc:addTo(descbg:getParent())
				desc:renderContent(0, 0, true)
				desc:setPosition(cc.p(descbg:getPositionX() - descX[previewType][index], descbg:getPositionY() + 5))
				desc:setName("descRichText" .. index)
				descbg:setScale9Enabled(true)
				descbg:setCapInsets(descScale9[previewType][index])

				if previewType == "1UP" then
					descbg:setContentSize(cc.size(desc:getContentSize().width + descBgW[previewType][index], descBgH[previewType][index]))
				else
					descbg:setContentSize(cc.size(desc:getContentSize().width + descBgW[previewType][index], descBgH[previewType][index]))
				end
			end
		end
	end

	local node

	if previewType == "1UP" then
		up1:setVisible(true)
		up2:setVisible(false)

		node = up1
	else
		up2:setVisible(true)
		up1:setVisible(false)

		node = up2
	end

	setName(node)
	setRole(node)
	setDesc(node)
end

function RecruitMainMediator:refreshUREQuipInfo()
	local type = self._recruitDataShow:getType()
	local nodeShow = type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub
	local common_text_node = self._middleTimeNode:getChildByFullName("common_text")

	common_text_node:removeAllChildren()
	self._middleTimeNode:setVisible(nodeShow)

	local titleText = self._urEquipNode:getChildByName("Text_title")

	titleText:setString(self._recruitDataShow:getName())

	local text = self._urEquipNode:getChildByName("Text_1")
	local pos1 = self._leftTimeNode:convertToWorldSpace(cc.p(0, 0))
	local pos2 = self._urEquipNode:convertToNodeSpace(pos1)

	text:setPosition(cc.p(pos2.x + 7, pos2.y - 60))
	titleText:setPositionY(pos2.y - 100)

	local equipInfo = self._recruitDataShow:getRoleDetail()

	if equipInfo and type == RecruitPoolType.kActivityUREquip then
		self._urEquipNode:setVisible(true)

		for i = 1, #equipInfo do
			local equipId = equipInfo[i].equip
			local equipNode = self._urEquipNode:getChildByName("equip" .. i)

			equipNode:getChildByName("Image_14"):setVisible(false)

			local info = {
				amount = 1,
				code = equipId,
				type = RewardType.kItem
			}
			local btn = equipNode:getChildByName("checkBtn")

			IconFactory:bindClickHander(btn, IconTouchHandler:new(self), info, {
				touchDisappear = true,
				swallowTouches = true
			})

			local nameText = equipNode:getChildByName("Text_name")

			nameText:setString(RewardSystem:getName(info))

			local iconNode = self._urEquipNode:getChildByName("icon" .. i)

			iconNode:removeAllChildren()

			local position = equipInfo[i].urposition
			local iconImg = IconFactory:createPic({
				id = equipInfo[i].showequip
			}, {
				isWidget = true
			})

			iconImg:addTo(iconNode):posite(position[1], position[2])
			iconImg:setScale(1)
		end

		local desc = self._recruitDataShow:getUPDesc()

		if self._urEquipNode:getChildByName("richDesc1") then
			self._urEquipNode:removeChildByName("richDesc1")
		end

		if self._urEquipNode:getChildByName("richDesc2") then
			self._urEquipNode:removeChildByName("richDesc2")
		end

		local rich1 = ccui.RichText:createWithXML(Strings:get(desc[1], {
			fontName = TTF_FONT_FZYH_M
		}), {})

		rich1:setAnchorPoint(0, 0.5)
		rich1:addTo(self._urEquipNode):posite(295, 230):setName("richDesc1")

		local rich1 = ccui.RichText:createWithXML(Strings:get(desc[2], {
			fontName = TTF_FONT_FZYH_M
		}), {})

		rich1:setAnchorPoint(0, 0.5)
		rich1:addTo(self._urEquipNode):posite(430, 180):setName("richDesc2")
	else
		self._urEquipNode:setVisible(false)
	end
end

function RecruitMainMediator:refreshDiamondView()
	self._diamondNode:setVisible(false)

	local previewType = self._recruitDataShow:getPreview().type

	if previewType ~= "diamond" then
		return
	end

	local type = self._recruitDataShow:getType()
	local nodeShow = type == RecruitPoolType.kPve or type == RecruitPoolType.kPvp or type == RecruitPoolType.kClub
	local common_text_node = self._middleTimeNode:getChildByFullName("common_text")

	common_text_node:removeAllChildren()
	self._middleTimeNode:setVisible(nodeShow)
	self._diamondNode:setVisible(true)

	local text1 = self._diamondNode:getChildByName("Text_title")
	local text2 = self._diamondNode:getChildByName("Text_title2")

	text1:enableShadow(cc.c4b(65, 63, 140, 71.4), cc.size(0, -6), 1)
	text2:enableShadow(cc.c4b(65, 63, 140, 71.4), cc.size(0, -6), 1)

	local id = self._recruitDataShow:getId()
	local unlock, activityId = self._recruitSystem:getActivityIsOpen(id)
	local activity = self._activitySystem:getActivityById(activityId)
	local activityConfig = activity:getActivityConfig()
	local bonusShow = activityConfig.BonusShow
	local smallCell = self._diamondNode:getChildByName("Panel_small")

	smallCell:setVisible(false)

	local bigCell = self._diamondNode:getChildByName("Panel_big")

	bigCell:setVisible(false)

	local width = 0

	if not self._diamondNode.hasInit then
		self._diamondNode.bonusList = {}
		self._diamondNode.hasInit = true

		for i, v in pairs(bonusShow) do
			local cell

			if v.type == "rareity" then
				cell = smallCell:clone()

				cell:setVisible(true)

				local rareityImage = ccui.ImageView:create(GameStyle:getHeroRarityImage(tonumber(v.value)), 1)

				rareityImage:setAnchorPoint(cc.p(0.5, 0.5))
				rareityImage:addTo(cell):posite(35, 65):setScale(0.9)
			elseif v.type == "hero" then
				cell = bigCell:clone()

				cell:setVisible(true)

				local heroConfig = ConfigReader:getRecordById("HeroBase", v.value)
				local heroImg = IconFactory:createRoleIconSpriteNew({
					id = heroConfig.RoleModel
				})

				heroImg:addTo(cell):posite(67, 61):setScale(0.3)
			elseif v.type == "item" then
				cell = bigCell:clone()

				cell:setVisible(true)

				local itemPic = IconFactory:createPic({
					id = v.value
				})

				itemPic:addTo(cell):posite(67, 60):setScale(0.5)
			end

			if cell then
				cell:addTo(self._diamondNode):posite(250 + width, 129)

				width = width + cell:getContentSize().width

				local timesText = cell:getChildByName("Text_times")

				timesText:setString(Strings:get("DiamondDrawDesc", {
					num = i
				}))

				local color = i % 2 == 1 and cc.c3b(255, 210, 0) or cc.c3b(255, 255, 255)

				timesText:setTextColor(color)
				timesText:enableOutline(cc.c4b(104, 108, 179, 60), 1)

				local descText = cell:getChildByName("Text_desc")

				descText:setString(Strings:get(v.desc))

				self._diamondNode.bonusList[#self._diamondNode.bonusList + 1] = cell
			end
		end

		local heroNamePanel = self._diamondNode:getChildByName("heroNamePanel")

		heroNamePanel:setVisible(false)

		local heroInfo = self._recruitDataShow:getRoleDetail()

		if heroInfo then
			for i = 1, #heroInfo do
				local heroData = heroInfo[i]
				local heroId = heroData.hero

				if heroId then
					local config = ConfigReader:getRecordById("HeroBase", tostring(heroId))
					local namePanel = heroNamePanel:clone()

					namePanel:setVisible(true)
					namePanel:addTo(self._diamondNode)
					namePanel:setPosition(cc.p(heroData.detail[1], heroData.detail[2]))

					local image_Name_Bg = namePanel:getChildByFullName("Image_109")
					local node_Rareity = namePanel:getChildByFullName("node_Rareity")

					node_Rareity:removeAllChildren()

					local rareityImage = ccui.ImageView:create(GameStyle:getHeroRarityImage(config.Rareity), 1)

					rareityImage:setAnchorPoint(cc.p(0.5, 0))
					rareityImage:setScale(0.61)
					rareityImage:addTo(node_Rareity)

					local nameText = namePanel:getChildByFullName("Text_132")

					nameText:enableShadow(cc.c4b(0, 0, 0, 90), cc.size(0, -3), 3)
					nameText:setString(Strings:get(config.Name))

					if config.Rareity == 15 then
						local width_Name = cc.Label:createWithTTF(Strings:get(config.Name), CUSTOM_TTF_FONT_1, 40)

						width_Name:enableOutline(cc.c4b(0, 0, 0, 255), 1)

						if width_Name:getContentSize().width > 150 then
							image_Name_Bg:setScaleX(1.8)
						end
					end

					local nicheText = namePanel:getChildByFullName("Text_131")

					nicheText:setString(Strings:get(config.Position))

					local Image_bg = namePanel:getChildByFullName("Image_bg")

					Image_bg:setScaleX(nicheText:getContentSize().width / 156)

					local path = self:getHeroImagePath(heroId)
					local role = ccui.ImageView:create(path)

					role:addTo(self._diamondNode, -1 - i)
					role:setPosition(cc.p(heroData.heroposition[1], heroData.heroposition[2]))
					role:setScale(heroData.scale)
				end
			end
		end
	end

	local times = self._recruitSystem:getDrawTimeById(id)

	if self._diamondNode.bonusList then
		for i, cell in pairs(self._diamondNode.bonusList) do
			local doneImg = cell:getChildByName("Image_done")

			doneImg:setVisible(i <= times["10"])
			doneImg:setLocalZOrder(100)
		end
	end
end

function RecruitMainMediator:getHeroImagePath(heroId)
	local roleModel = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "RoleModel")
	local rolePicId = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Bust4")
	local modelID = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "Model")
	local commonResource = ConfigReader:getDataByNameIdAndKey("RoleModel", roleModel, "CommonResource")

	if not commonResource or commonResource == "" then
		commonResource = modelID
	end

	local picInfo = ConfigReader:getRecordById("SpecialPicture", rolePicId)

	return (string.format("%s%s/%s.png", IconFactory.kIconPathCfg[tonumber(picInfo.Path)], commonResource, picInfo.Filename))
end

function RecruitMainMediator:createPushBackBoxIcon(parentNode, pos, sceneId)
	local sceneId = KShopPushPackageScene.KDrawCard
	local type = self._recruitDataShow:getType()

	if type == RecruitPoolType.kDiamond then
		IconFactory:createPushBackBoxIcon(self._main, {
			280,
			90
		}, sceneId)
	else
		self._main:removeChildByName("packageAnim")
	end
end
