-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroLevelUpTipMediator.lua

HeroLevelUpTipMediator = class("HeroLevelUpTipMediator", DmPopupViewMediator, _M)

HeroLevelUpTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

function HeroLevelUpTipMediator:initialize()
	super.initialize(self)
end

function HeroLevelUpTipMediator:dispose()
	super.dispose(self)
end

function HeroLevelUpTipMediator:onRegister()
	super.onRegister(self)
end

function HeroLevelUpTipMediator:mapEventListeners()
	return
end

function HeroLevelUpTipMediator:onRemove()
	super.onRemove(self)
end

function HeroLevelUpTipMediator:enterWithData(data)
	AudioEngine:getInstance():playRoleEffect("Se_Effect_Levelup", false)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:createUI(data)
end

function HeroLevelUpTipMediator:createUI(data)
	local hero = self._heroSystem:getHeroById(data.heroId)
	local level = hero:getLevel()

	self._touchLayer = self:getView():getChildByName("touchLayer")

	self._touchLayer:setVisible(false)

	self._mainpanel = self:getView():getChildByName("mainpanel")

	self._mainpanel:setLocalZOrder(2)

	local attrPanel = self._mainpanel:getChildByName("attrPanel")

	attrPanel:setOpacity(0)

	local levelPanel = self._mainpanel:getChildByName("levelPanel")

	levelPanel:setVisible(false)
	levelPanel:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(self._mainpanel:getChildByName("animNode")):offset(0, -15)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Heros_LvUp"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Dengjitisheng"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(14, function()
		levelPanel:setVisible(true)
		levelPanel:fadeIn({
			time = 0.2
		})
		attrPanel:fadeIn({
			time = 0.2
		})
	end)

	local level1 = levelPanel:getChildByFullName("level_1")
	local level2 = levelPanel:getChildByFullName("level_2")

	level1:setString(data.level)
	level2:setString(level)

	local desNode1 = attrPanel:getChildByFullName("des_1")
	local desNode2 = attrPanel:getChildByFullName("des_2")
	local desNode3 = attrPanel:getChildByFullName("des_3")
	local desNode4 = attrPanel:getChildByFullName("des_4")
	local desLab1 = attrPanel:getChildByFullName("des_1.text")
	local desLab2 = attrPanel:getChildByFullName("des_2.text")
	local desLab3 = attrPanel:getChildByFullName("des_3.text")
	local desLab4 = attrPanel:getChildByFullName("des_4.text")
	local extandText1 = attrPanel:getChildByFullName("des_1.extandText")
	local extandText2 = attrPanel:getChildByFullName("des_2.extandText")
	local extandText3 = attrPanel:getChildByFullName("des_3.extandText")
	local extandText4 = attrPanel:getChildByFullName("des_4.extandText")
	local attrDi1 = attrPanel:getChildByFullName("des_1.Image_6")
	local attrDi2 = attrPanel:getChildByFullName("des_2.Image_6")
	local attrDi3 = attrPanel:getChildByFullName("des_3.Image_6")
	local attrDi4 = attrPanel:getChildByFullName("des_4.Image_6")

	attrPanel:getChildByFullName("des_4"):setVisible(false)
	attrPanel:setPositionX(637)
	desLab1:setString(data.attr.attack[1])
	desLab2:setString(data.attr.hp[1])
	desLab3:setString(data.attr.defense[1])

	local attack = hero:getAttack()
	local hp = hero:getHp()
	local defense = hero:getDefense()

	if attack - data.attr.attack[1] > 0 then
		if not (attack - data.attr.attack[1]) then
			local addAtk = 0

			if hp - data.attr.hp[1] > 0 then
				if not (hp - data.attr.hp[1]) then
					local addHp = 0

					if defense - data.attr.defense[1] > 0 then
						if not (defense - data.attr.defense[1]) then
							local addDef = 0

							extandText1:setString("+" .. addAtk)
							extandText2:setString("+" .. addHp)
							extandText3:setString("+" .. addDef)
							desLab1:setPositionX(35)
							desLab2:setPositionX(35)
							desLab3:setPositionX(35)
							extandText1:setPositionX(desLab1:getPositionX() + desLab1:getContentSize().width + 5)
							extandText2:setPositionX(desLab2:getPositionX() + desLab2:getContentSize().width + 5)
							extandText3:setPositionX(desLab3:getPositionX() + desLab3:getContentSize().width + 5)
							attrDi1:setContentSize(cc.size(desLab1:getContentSize().width + extandText1:getContentSize().width + 50, 23))
							attrDi2:setContentSize(cc.size(desLab2:getContentSize().width + extandText2:getContentSize().width + 50, 23))
							attrDi3:setContentSize(cc.size(desLab3:getContentSize().width + extandText3:getContentSize().width + 50, 23))

							local starX = (1046 - attrDi1:getContentSize().width - attrDi2:getContentSize().width - attrDi3:getContentSize().width - attrDi4:getContentSize().width) / 2

							desNode1:setPositionX(starX)
							desNode2:setPositionX(desNode1:getPositionX() + attrDi1:getContentSize().width + 30)
							desNode3:setPositionX(desNode2:getPositionX() + attrDi2:getContentSize().width + 30)
						end
					end
				end
			end
		end
	end
end

function HeroLevelUpTipMediator:onTouchMaskLayer()
	self:getEventDispatcher():dispatchEvent(Event:new(EVT_HEROLEVELUP_FINISH))
	AudioEngine:getInstance():playEffect("Se_Click_Close_2", false)
	self:close()
end
