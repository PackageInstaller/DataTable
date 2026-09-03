-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipSkillUpMediator.lua

EquipSkillUpMediator = class("EquipSkillUpMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}
local kTitleImage = {
	{
		Strings:get("HEROS_UI66"),
		Strings:get("UITitle_EN_Jinengjihuo")
	},
	{
		Strings:get("Equip_UI38"),
		Strings:get("UITitle_EN_Jinengshengji")
	}
}

function EquipSkillUpMediator:initialize()
	super.initialize(self)
end

function EquipSkillUpMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function EquipSkillUpMediator:onRemove()
	super.onRemove(self)
end

function EquipSkillUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function EquipSkillUpMediator:userInject()
	self._equipSystem = self:getInjector():getInstance(DevelopSystem):getEquipSystem()
end

function EquipSkillUpMediator:enterWithData(data)
	self._oldSkillLevel = data.oldSkillLevel
	self._equipId = data.equipId
	self._equipData = self._equipSystem:getEquipById(self._equipId)
	self._skill = self._equipData:getSkill()

	self:setupView()
end

function EquipSkillUpMediator:setupView()
	local main = self:getView():getChildByName("main")
	local animNode = main:getChildByName("animNode")
	local descNode = main:getChildByName("descNode")

	descNode:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:setPlaySpeed(1.5)
	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local isLevelUp = true
	local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")
	local arr = {}
	local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._equipId, "URUPSkillLV")

	if URUPSkillLV then
		HeroEquipSkillLevel = URUPSkillLV
	end

	for i = 1, #HeroEquipSkillLevel do
		if self._oldSkillLevel < HeroEquipSkillLevel[i] and self._equipData:getLevel() >= HeroEquipSkillLevel[i] then
			arr[HeroEquipSkillLevel[i]] = true
		end
	end

	if self._oldSkillLevel < HeroEquipSkillLevel[1] and table.nums(arr) == 1 then
		isLevelUp = false
	end

	if isLevelUp then
		if not kTitleImage[2] then
			local titleImage = kTitleImage[1]
			local audio = isLevelUp and "Se_Effect_Levelup" or "Se_Alert_Skill_Active"

			AudioEngine:getInstance():playRoleEffect(audio, false)

			local title1 = cc.Label:createWithTTF(titleImage[1], CUSTOM_TTF_FONT_1, 50)

			title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			title1:addTo(cnText):offset(0, -3)

			local title2 = cc.Label:createWithTTF(titleImage[2], TTF_FONT_FZYH_M, 18)

			title2:setColor(cc.c3b(150, 160, 255))
			title2:addTo(enText)
			anim:addCallbackAtFrame(14, function()
				descNode:fadeIn({
					time = 0.2
				})
			end)

			local equipNode = descNode:getChildByName("equipNode")
			local rarity = self._equipData:getRarity()
			local level = self._equipData:getLevel()
			local star = self._equipData:getStar()
			local param = {
				id = self._equipData:getEquipId(),
				level = level,
				star = star,
				rarity = rarity
			}
			local equipIcon = IconFactory:createEquipIcon(param)

			equipIcon:addTo(equipNode):center(equipNode:getContentSize())
			equipIcon:setScale(0.8)

			local skillName = self._skill:getName()
			local skillLevel = self._skill:getLevel()
			local panel = descNode:getChildByName("panel")
			local nameLabel = panel:getChildByName("name")

			nameLabel:setString(skillName)

			local currentLvl = panel:getChildByName("currentLvl")
			local currentLvl1 = panel:getChildByName("currentLvl_1")

			currentLvl:setString(Strings:get("HEROS_UI66"))
			nameLabel:setString(skillName)
			currentLvl:setString(Strings:get("Strenghten_Text78", {
				level = self._oldSkillLevel
			}))
			currentLvl1:setString(Strings:get("Strenghten_Text78", {
				level = skillLevel
			}))

			local arrowNode = panel:getChildByName("arrowNode")
			local arrowAnim = cc.MovieClip:create("jiantoudonghua_jiantoudonghua")

			arrowAnim:addCallbackAtFrame(50, function()
				arrowAnim:stop()
			end)
			arrowAnim:addTo(arrowNode)
			arrowAnim:setScale(0.6)

			local desc = descNode:getChildByName("desc")

			desc:setString("")

			local fontSize = 20
			local descText
			local changeSize = false

			repeat
				local content = self._skill:getSkillDesc({
					fontSize = fontSize,
					fontName = TTF_FONT_FZYH_M
				})

				descText = ccui.RichText:createWithXML(content, {})

				descText:renderContent(800, 0, true)

				if fontSize < 20 then
					changeSize = true
				end

				fontSize = fontSize - 2
			until descText:getContentSize().height < 57 or fontSize < 2

			local contentLen = descText:getContentLength()
			local realWidth = math.min(contentLen * fontSize, 800)
			local localLanguage = getCurrentLanguage()

			if localLanguage ~= GameLanguageType.CN then
				realWidth = math.min(contentLen * fontSize / 2, 800)
			end

			descText:setAnchorPoint(cc.p(0.5, 0))
			descText:addTo(desc)
			descText:setPosition(cc.p((800 - realWidth) / 2, -19))
			descText:renderContent()

			if changeSize then
				descText:setPosition(cc.p(0, -19))
				descText:renderContent()
			end
		end
	end
end
