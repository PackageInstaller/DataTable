-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerMasterShowDetailsMediator.lua

TowerMasterShowDetailsMediator = class("TowerMasterShowDetailsMediator", DmAreaViewMediator, _M)

TowerMasterShowDetailsMediator:has("_mainPanel", {
	is = "rw"
})
TowerMasterShowDetailsMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerMasterShowDetailsMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}

function TowerMasterShowDetailsMediator:initialize()
	super.initialize(self)
end

function TowerMasterShowDetailsMediator:dispose()
	super.dispose(self)
end

function TowerMasterShowDetailsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:setupTopInfoWidget()
end

function TowerMasterShowDetailsMediator:enterWithData(data)
	self._master = data.master
	self._towerData = data.towerData
	self._teamMaster = self._towerData:getTeam():getMaster()

	self:initView()
	self:showAnimByType()
end

function TowerMasterShowDetailsMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackBtn, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function TowerMasterShowDetailsMediator:initView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._touchPanel = self:getView():getChildByFullName("touchPanel")

	self._mainPanel:setTouchEnabled(false)

	self._roleNode = self._mainPanel:getChildByName("roleNode")

	local realImage = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe2_5",
		id = self._master:getModel()
	})

	realImage:setPosition(cc.p(-350, -300))
	self._roleNode:addChild(realImage)

	self._image3 = self._mainPanel:getChildByName("image3")
	self._image4 = self._mainPanel:getChildByName("image4")
	self._image5 = self._mainPanel:getChildByName("image5")
	self._image6 = self._mainPanel:getChildByName("image6")
	self._image7 = self._mainPanel:getChildByName("image7")

	local combat = self._teamMaster:getCombat()

	self._namePanel = self._mainPanel:getChildByFullName("namePanel")

	local name = self._master:getName()
	local nameText = self._namePanel:getChildByFullName("nameText")
	local nameBg = self._namePanel:getChildByFullName("nameBg")

	nameText:setString(name)
	nameBg:setScaleX((nameText:getContentSize().width + 30) / nameBg:getContentSize().width)

	self._combatPanel = self._mainPanel:getChildByFullName("combatPanel")

	local combatLabel = self._combatPanel:getChildByFullName("combatLabel")

	combatLabel:setString(combat)

	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 1,
			color = cc.c4b(120, 120, 120, 255)
		}
	}

	combatLabel:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))

	self._attibutePanel = self._mainPanel:getChildByFullName("descPanel")

	self._attibutePanel:getChildByFullName("des_1.text"):setString(self._teamMaster:getAttack())
	self._attibutePanel:getChildByFullName("des_2.text"):setString(self._teamMaster:getDefense())
	self._attibutePanel:getChildByFullName("des_3.text"):setString(self._teamMaster:getHp())
	self._attibutePanel:getChildByFullName("des_4.text"):setString(self._teamMaster:getSpeed())

	self._typePanel = self._mainPanel:getChildByFullName("typePanel")

	self._typePanel:setVisible(true)
	self._typePanel:getChildByFullName("heroType"):setString(self._master:getFeature())

	self._skillPanel = self._mainPanel:getChildByFullName("skillPanel")

	self._skillPanel:addClickEventListener(function()
		self:onClickMasterSkill()
	end)

	self._skillPanel1 = self._mainPanel:getChildByFullName("skillPanel1")

	self:initSkill()
end

function TowerMasterShowDetailsMediator:initSkill()
	local skills = self._master:getSkillList()

	for i = 1, #skills do
		local panel = self._skillPanel:getChildByFullName("skill_" .. i)

		if panel then
			local skill = skills[i]
			local iconNode = panel:getChildByName("node")

			iconNode:removeAllChildren()
			iconNode:setScale(0.7)

			local skillId = skill:getId()
			local info = {
				levelHide = true,
				id = skillId,
				skillType = skill:getSkillType()
			}
			local newSkillNode = IconFactory:createMasterSkillIcon(info)

			newSkillNode:setScale(0.7)
			newSkillNode:addTo(iconNode):posite(15, 15)
			panel:getChildByName("name"):setString(skill:getName())
			panel:getChildByName("level"):setString("")
			iconNode:setTouchEnabled(false)
		end
	end

	local skills = self._master:getActionList()

	for i = 1, #skills do
		local panel = self._skillPanel1:getChildByFullName("skill_" .. i)

		if panel then
			local skill = skills[i]
			local iconNode = panel:getChildByName("node")

			iconNode:removeAllChildren()
			iconNode:setScale(0.7)

			local skillId = skill:getId()
			local info = {
				levelHide = true,
				id = skillId,
				skillType = skill:getSkillType()
			}
			local newSkillNode = IconFactory:createMasterSkillIcon(info)

			newSkillNode:setScale(0.7)
			newSkillNode:addTo(iconNode):posite(15, 15)
			panel:getChildByName("name"):setString(skill:getName())
			panel:getChildByName("level"):setString("")
			iconNode:setTouchEnabled(true)
			iconNode:addClickEventListener(function()
				self:onClickSkill(skill)
			end)
		end
	end
end

function TowerMasterShowDetailsMediator:onClickMasterSkill()
	local params = {
		towerMaster = true,
		master = self._master
	}
	local view = self:getInjector():getInstance("MasterLeaderSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, params))
end

function TowerMasterShowDetailsMediator:onClickSkill(skill)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self
		})))

		self._skillWidget:getView():addTo(self:getView()):posite(819, 117)
	end

	self._skillWidget:refreshInfo(skill, self._master, true)
	self._skillWidget:show()
end

function TowerMasterShowDetailsMediator:showAnimByType()
	self:playAnim1()
end

function TowerMasterShowDetailsMediator:playAnim1()
	self._roleNode:setScale(1)
	self._roleNode:setPosition(cc.p(1573, 300))

	local moveto = cc.MoveTo:create(0.12, cc.p(700, 300))
	local moveto1 = cc.MoveTo:create(0.08, cc.p(750, 300))
	local seq = cc.Sequence:create(moveto, moveto1)

	self._roleNode:runAction(seq)
	self._namePanel:getChildByName("nameText"):setVisible(false)
	self._combatPanel:setPosition(cc.p(434, 495))
	self._combatPanel:setOpacity(0)
	self._attibutePanel:setPosition(cc.p(327, 389))
	self._attibutePanel:setOpacity(0)
	self._typePanel:setPosition(cc.p(112, 396))
	self._typePanel:setOpacity(0)
	self._image3:setPosition(cc.p(840, -532))

	local delaytime = cc.DelayTime:create(0.2)

	moveto = cc.MoveTo:create(0.2, cc.p(389, 327))

	local callfunc = cc.CallFunc:create(function()
		self._namePanel:getChildByName("nameText"):setVisible(true)
		self._combatPanel:fadeIn({
			time = 0.1
		})

		local delaytime1 = cc.DelayTime:create(0.1)
		local fadeIn = cc.FadeIn:create(0.1)

		seq = cc.Sequence:create(delaytime1, fadeIn)

		self._attibutePanel:runAction(seq)

		delaytime1 = cc.DelayTime:create(0.2)
		fadeIn = cc.FadeIn:create(0.1)
		seq = cc.Sequence:create(delaytime1, fadeIn)

		self._typePanel:runAction(seq)
	end)

	seq = cc.Sequence:create(delaytime, moveto, callfunc)

	self._image3:runAction(seq)
	self._namePanel:setPosition(cc.p(-12, 895))

	moveto = cc.MoveTo:create(0.4, cc.p(231, 644))
	seq = cc.Sequence:create(delaytime, moveto)

	self._namePanel:runAction(seq)
	self._image6:setPosition(cc.p(-378, 1068))

	moveto = cc.MoveTo:create(0.2, cc.p(60, 298))
	seq = cc.Sequence:create(delaytime, moveto)

	self._image6:runAction(seq)
	self._image7:setPosition(cc.p(756, -579))

	moveto = cc.MoveTo:create(0.4, cc.p(147, 288))
	seq = cc.Sequence:create(delaytime, moveto)

	self._image7:runAction(seq)

	delaytime = cc.DelayTime:create(0.5)

	self._skillPanel:setOpacity(0)
	self._skillPanel:setPosition(cc.p(86, 138))

	local fadeIn = cc.FadeIn:create(0.1)

	seq = cc.Sequence:create(delaytime, fadeIn)

	self._skillPanel:runAction(seq)

	for i = 1, 6 do
		local panel = self._skillPanel:getChildByFullName("skill_" .. i)

		panel:setScale(0)

		local time = 0.5 + (i - 1) * 0.08

		delaytime = cc.DelayTime:create(time)

		local scale1 = cc.ScaleTo:create(0.1, 1.1)
		local scale2 = cc.ScaleTo:create(0.05, 1)

		seq = cc.Sequence:create(delaytime, scale1, scale2)

		panel:runAction(seq)
	end

	delaytime = cc.DelayTime:create(0.5)

	self._skillPanel1:setOpacity(0)
	self._skillPanel1:setPosition(cc.p(213, -79))

	local fadeIn = cc.FadeIn:create(0.1)

	seq = cc.Sequence:create(delaytime, fadeIn)

	self._skillPanel1:runAction(seq)

	for i = 1, 3 do
		local panel = self._skillPanel1:getChildByFullName("skill_" .. i)

		panel:setScale(0)

		local time = 0.5 + (i - 1) * 0.08

		delaytime = cc.DelayTime:create(time)

		local scale1 = cc.ScaleTo:create(0.1, 1.1)
		local scale2 = cc.ScaleTo:create(0.05, 1)

		seq = cc.Sequence:create(delaytime, scale1, scale2)

		panel:runAction(seq)
	end
end

function TowerMasterShowDetailsMediator:onBackBtn(sender, eventType)
	self._mainPanel:stopAllActions()
	self:dismiss()
end
