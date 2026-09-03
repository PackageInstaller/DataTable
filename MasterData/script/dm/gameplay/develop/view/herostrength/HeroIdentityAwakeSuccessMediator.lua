-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroIdentityAwakeSuccessMediator.lua

HeroIdentityAwakeSuccessMediator = class("HeroIdentityAwakeSuccessMediator", DmAreaViewMediator, _M)

HeroIdentityAwakeSuccessMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local AWAKEN_STAR_ICON = "jx_img_star.png"
local IDENTITY_AWAKEN_STAR_ICON = "yinghun_img_awake_star.png"
local kBtnHandlers = {}

function HeroIdentityAwakeSuccessMediator:initialize()
	super.initialize(self)
end

function HeroIdentityAwakeSuccessMediator:dispose()
	AudioEngine:getInstance():resumeBackgroundMusic()
	super.dispose(self)
end

function HeroIdentityAwakeSuccessMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroIdentityAwakeSuccessMediator:enterWithData(data)
	self:initData(data)
	self:initNodes()
	self:refreshAttrLab()
	self:showResult()
end

function HeroIdentityAwakeSuccessMediator:initNodes()
	self._main = self:getView():getChildByName("mainpanel")
	self._nodeAnim = self._main:getChildByName("animNode")

	local roleModel = self._heroData:getAwakenStarConfig().ModelId
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe9",
		useAnim = true,
		id = roleModel
	})
	local anim = cc.MovieClip:create("tianqichenggong_tianqichenggong")

	anim:addTo(self._nodeAnim)
	anim:addCallbackAtFrame(17, function()
		anim:stop()
	end)

	local mc_title = anim:getChildByFullName("mc_text")

	anim:addCallbackAtFrame(17, function()
		anim:stop()
	end)

	local mc_title = anim:getChildByFullName("mc_text")

	mc_title:addCallbackAtFrame(3, function()
		mc_title:stop()
	end)

	local mc_role = anim:getChildByFullName("mc_role")

	masterIcon:addTo(mc_role):offset(100, 0)

	local skillImg = self._main:getChildByName("Image_skill")

	skillImg:removeAllChildren()

	if self._data.skillData.attrType == "skill" then
		local image = IconFactory:createHeroSkillIcon({
			levelHide = true,
			id = self._data.skillData.skillId
		})

		image:addTo(skillImg):center(skillImg:getContentSize())
		image:setScale(0.6)
	else
		local image = ccui.ImageView:create(self._data.skillData.path, 1)

		image:addTo(skillImg):center(skillImg:getContentSize())
		skillImg:setScale(1.3)
	end

	local skilldes = self._main:getChildByFullName("skillLab")

	skilldes:setString("")

	local label = ccui.RichText:createWithXML(self._data.skillData.desc, {})

	label:renderContent(232, 0)
	label:setAnchorPoint(cc.p(0, 0.5))
	label:setPosition(cc.p(0, 0))
	label:addTo(skilldes)

	for i = 1, HeroStarCountMax do
		local node = self._main:getChildByFullName("star_" .. i)

		if not node:getChildByName("star") and i <= self._heroData:getStar() then
			if i <= self._heroData:getIdentityAwakenLevel() then
				if not IDENTITY_AWAKEN_STAR_ICON then
					local name = AWAKEN_STAR_ICON
					local star = ccui.ImageView:create(name, 1)

					star:ignoreContentAdaptWithSize(true)
					star:setName("star")
					star:addTo(node)
					star:setScale(0.8)
				end
			end
		end
	end
end

function HeroIdentityAwakeSuccessMediator:initData(data)
	self._heroId = data.heroId
	self._data = data
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
end

function HeroIdentityAwakeSuccessMediator:showResult()
	self._main:getChildByName("Close"):addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/HeroIdentityAwakeSuccess.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 50, false)
	action:setTimeSpeed(1.2)
end

function HeroIdentityAwakeSuccessMediator:close()
	self:dismiss()
end

function HeroIdentityAwakeSuccessMediator:refreshAttrLab()
	local attr1 = self._main:getChildByFullName("attrPanel.attr1")
	local attr2 = self._main:getChildByFullName("attrPanel.attr2")
	local attr3 = self._main:getChildByFullName("attrPanel.attr3")
	local attr4 = self._main:getChildByFullName("attrPanel.attr4")
	local add1 = self._main:getChildByFullName("attrPanel.add1")
	local add2 = self._main:getChildByFullName("attrPanel.add2")
	local add3 = self._main:getChildByFullName("attrPanel.add3")
	local add4 = self._main:getChildByFullName("attrPanel.add4")

	attr1:setString(tostring(self._data.attr.ATK[1]))
	attr2:setString(tostring(self._data.attr.HP[1]))
	attr3:setString(tostring(self._data.attr.DEF[1]))
	add1:setString("+" .. tostring(self._data.attr.ATK[2]))
	add2:setString("+" .. tostring(self._data.attr.HP[2]))
	add3:setString("+" .. tostring(self._data.attr.DEF[2]))
end
