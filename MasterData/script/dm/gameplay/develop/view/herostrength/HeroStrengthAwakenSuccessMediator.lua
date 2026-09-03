-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthAwakenSuccessMediator.lua

HeroStrengthAwakenSuccessMediator = class("HeroStrengthAwakenSuccessMediator", DmAreaViewMediator, _M)

HeroStrengthAwakenSuccessMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function HeroStrengthAwakenSuccessMediator:initialize()
	super.initialize(self)
end

function HeroStrengthAwakenSuccessMediator:dispose()
	AudioEngine:getInstance():resumeBackgroundMusic()
	super.dispose(self)
end

function HeroStrengthAwakenSuccessMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroStrengthAwakenSuccessMediator:enterWithData(data)
	self:initData(data.heroId, data.oldStarId)
	self:initNodes()
	self:playVideo(data.close)
end

function HeroStrengthAwakenSuccessMediator:initNodes()
	self._main = self:getView():getChildByName("mainpanel")

	self._main:getChildByName("BG"):loadTexture("asset/scene/denglu_bg.jpg")

	self._nodeAnim = self._main:getChildByName("animNode")
	self._awakeRoleNode = self._main:getChildByFullName("heropanel")

	local roleModel = self._heroData:getAwakenStarConfig().ModelId
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		useAnim = true,
		id = roleModel
	})

	self._awakeRoleNode:removeAllChildren()
	masterIcon:addTo(self._awakeRoleNode):setPosition(0, 0)
end

function HeroStrengthAwakenSuccessMediator:initData(heroId, oldStarId)
	self._heroId = heroId
	self._oldStarId = oldStarId
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
end

function HeroStrengthAwakenSuccessMediator:playVideo(close)
	local function callback()
		if close then
			self:close()

			return
		end

		AudioEngine:getInstance():playEffect("Se_Effect_Awaken", false)
		self:showResult()
	end

	local hasAnim = self._heroData:hasAwakenAnimation()

	if not hasAnim then
		callback()

		return
	end

	AudioEngine:getInstance():pauseBackgroundMusic()

	local videoSprite = VideoSprite.create("video/hero/" .. self._heroData:getAwakenStarConfig().Animation .. ".usm", function(sprite, eventName)
		if eventName == "complete" then
			sprite:removeFromParent()
			callback()
		end
	end)

	self:getView():addChild(videoSprite)
	videoSprite:setPosition(cc.p(568, 320))

	local animSound = self._heroData:getAwakenStarConfig().AnimSound

	if animSound and animSound ~= "" then
		AudioEngine:getInstance():playEffect(animSound, false)
	end
end

function HeroStrengthAwakenSuccessMediator:showResult()
	self._awakeAreaRoleNode = self._main:getChildByName("role")

	local heroId = self._heroData:getAwakenStarConfig().ShowHero
	local model = IconFactory:getRoleModelByKey("HeroBase", heroId)

	if not model or model == "" then
		return
	end

	model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

	local role = RoleFactory:createRoleAnimation(model)

	self._roleSpine = role

	role:setName("RoleAnim")
	role:addTo(self._awakeAreaRoleNode):setScale(0.6):posite(70, 35)
	role:registerSpineEventHandler(handler(self, self.spineCompleteHandler), sp.EventType.ANIMATION_COMPLETE)

	self._awakeSkillNode = self._main:getChildByName("skill")

	local specialEffect = ConfigReader:getDataByNameIdAndKey("HeroStarEffect", self._heroData:getStarId(), "SpecialEffect") or {}
	local skillId = ConfigReader:getDataByNameIdAndKey("SkillSpecialEffect", specialEffect[1], "Parameter").after
	local skillNode = IconFactory:createHeroSkillIcon({
		id = skillId
	}, {
		hideLevel = true
	})

	skillNode:addTo(self._awakeSkillNode):setScale(0.8):posite(80, 75)

	local lvLabel = cc.Label:createWithTTF("EX", TTF_FONT_FZYH_R, 24)

	lvLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	lvLabel:addTo(self._awakeSkillNode):posite(78, 55)
	self:refreshAttrLab()
	self._main:getChildByName("Close"):addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end)

	if self._heroEffect then
		AudioEngine:getInstance():stopEffect(self._heroPickUpEffect)
	end

	local audioName = "Voice_" .. self._heroId .. "_65"

	self._heroEffect = AudioEngine:getInstance():playRoleEffect(audioName, false)

	local animAwaken = cc.MovieClip:create("juexingchenggong_juexingchenggong")

	animAwaken:addTo(self._nodeAnim)
	animAwaken:gotoAndPlay(0)

	local role = animAwaken:getChildByFullName("role")
	local ren = animAwaken:getChildByFullName("ren")
	local skill = animAwaken:getChildByFullName("skill")
	local renLab = animAwaken:getChildByFullName("renLab")
	local skillLab = animAwaken:getChildByFullName("skillLab")
	local touch = animAwaken:getChildByFullName("touch")
	local roleNode = self._main:getChildByFullName("heropanel")
	local renNode = self._main:getChildByFullName("role")
	local skillNode = self._main:getChildByFullName("skill")
	local renLabNode = self._main:getChildByFullName("renLab")
	local skillLabNode = self._main:getChildByFullName("skillLab")
	local touchNode = self._main:getChildByFullName("Close.skip")
	local nodeToActionMap = {}

	nodeToActionMap[roleNode] = role
	nodeToActionMap[renNode] = ren
	nodeToActionMap[skillNode] = skill
	nodeToActionMap[renLabNode] = renLab
	nodeToActionMap[skillLabNode] = skillLab
	nodeToActionMap[touchNode] = touch

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._nodeAnim)

	startFunc()
	animAwaken:addEndCallback(function()
		animAwaken:stop()
		stopFunc()
	end)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenAwakenSuccess.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 50, false)
	action:setTimeSpeed(1.2)
end

function HeroStrengthAwakenSuccessMediator:close()
	self:dismiss()
end

function HeroStrengthAwakenSuccessMediator:spineCompleteHandler(event)
	if event.type == "complete" and event.animation ~= "stand1" and self._roleSpine then
		self._roleSpine:playAnimation(0, "stand1", true)
	end
end

function HeroStrengthAwakenSuccessMediator:refreshAttrLab()
	local attr1 = self._main:getChildByFullName("attrPanel.attr1")
	local attr2 = self._main:getChildByFullName("attrPanel.attr2")
	local attr3 = self._main:getChildByFullName("attrPanel.attr3")
	local attr4 = self._main:getChildByFullName("attrPanel.attr4")
	local add1 = self._main:getChildByFullName("attrPanel.add1")
	local add2 = self._main:getChildByFullName("attrPanel.add2")
	local add3 = self._main:getChildByFullName("attrPanel.add3")
	local add4 = self._main:getChildByFullName("attrPanel.add4")
	local starId = self._heroData:getStarId()
	local a, b, c, d, e = self._heroData:getNextStarEffect({
		starId = self._oldStarId
	})
	local atkAdd = self._heroData:getAttack() - a
	local hpAdd = self._heroData:getHp() - c
	local defAdd = self._heroData:getDefense() - b
	local speedAdd = self._heroData:getSpeed() - d

	attr1:setString(tostring(self._heroData:getAttack() - atkAdd))
	attr2:setString(tostring(self._heroData:getHp() - hpAdd))
	attr3:setString(tostring(self._heroData:getDefense() - defAdd))
	attr4:setString(tostring(self._heroData:getSpeed() - speedAdd))
	add1:setString("+" .. tostring(atkAdd))
	add2:setString("+" .. tostring(hpAdd))
	add3:setString("+" .. tostring(defAdd))
	add4:setString("+" .. tostring(speedAdd))
end
