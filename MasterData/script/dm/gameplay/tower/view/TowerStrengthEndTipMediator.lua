-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tower/view/TowerStrengthEndTipMediator.lua

TowerStrengthEndTipMediator = class("TowerStrengthEndTipMediator", DmPopupViewMediator, _M)

TowerStrengthEndTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
TowerStrengthEndTipMediator:has("_towerSystem", {
	is = "r"
}):injectWith("TowerSystem")

function TowerStrengthEndTipMediator:initialize()
	super.initialize(self)
end

function TowerStrengthEndTipMediator:dispose()
	super.dispose(self)
end

function TowerStrengthEndTipMediator:onRegister()
	super.onRegister(self)
end

function TowerStrengthEndTipMediator:mapEventListeners()
	return
end

function TowerStrengthEndTipMediator:onRemove()
	if self._data.new.expRatio >= 1 then
		local towerSystem = self:getInjector():getInstance()

		self._towerData = self._towerSystem:getTowerDataById(self._towerSystem:getCurTowerId())
		self._curTeam = self._towerData:getTeam()

		local award = self._curTeam:getHeroInfoById(self._data.new.id):getExpAward()
		local baseId = self._curTeam:getHeroInfoById(self._data.new.id):getBaseId()

		award.amount = self._towerSystem:getRewardPiceNum(baseId)

		local rewards = {
			award
		}
		local newTab = {}

		for k, v in pairs(rewards) do
			if v.amount ~= 0 then
				newTab[#newTab + 1] = v
			end
		end

		if #newTab > 0 then
			local view = self:getInjector():getInstance("getRewardView")
			local str = Strings:get("Tower_New_Reward_20")
			local strTab = string.split(str, "\\n")
			local newStr = ""

			for k, v in pairs(strTab) do
				newStr = newStr .. v

				if strTab[k + 1] then
					newStr = newStr .. "\n"
				end
			end

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				maskOpacity = 0
			}, {
				tips = true,
				needClick = true,
				rewards = newTab,
				showStr = newStr,
				offset = cc.p(10, -10)
			}))
		end
	end

	super.onRemove(self)
end

function TowerStrengthEndTipMediator:enterWithData(data)
	self._data = data

	self:createUI(data)
end

function TowerStrengthEndTipMediator:createUI(data)
	local oldInfo = data.old
	local newInfo = data.new

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
	local title1 = cc.Label:createWithTTF(Strings:get("Tower_1_UI_11"), CUSTOM_TTF_FONT_1, 50)

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

	level1:setString(oldInfo.expRatio * 100)
	level2:setString(newInfo.expRatio * 100)

	local atk = oldInfo.atk * oldInfo.rate
	local hp = oldInfo.hp * oldInfo.rate
	local def = oldInfo.def * oldInfo.rate
	local speed = oldInfo.speed * oldInfo.rate
	local atk1 = newInfo.atk * newInfo.rate - atk
	local hp1 = newInfo.hp * newInfo.rate - hp
	local def1 = newInfo.def * newInfo.rate - def
	local speed1 = newInfo.speed * newInfo.rate - speed

	attrPanel:getChildByFullName("des_1.text"):setString(tostring(math.floor(atk)))
	attrPanel:getChildByFullName("des_2.text"):setString(tostring(math.floor(hp)))
	attrPanel:getChildByFullName("des_3.text"):setString(tostring(math.floor(def)))
	attrPanel:getChildByFullName("des_4.text"):setString(tostring(math.floor(speed)))
	attrPanel:getChildByFullName("des_1.extandText"):setString("+" .. tostring(math.floor(atk1)))
	attrPanel:getChildByFullName("des_2.extandText"):setString("+" .. tostring(math.floor(hp1)))
	attrPanel:getChildByFullName("des_3.extandText"):setString("+" .. tostring(math.floor(def1)))
	attrPanel:getChildByFullName("des_4.extandText"):setString("+" .. tostring(math.floor(speed1)))

	local skillPanel = self._mainpanel:getChildByName("content_panel")

	skillPanel:setVisible(false)

	local skillId = newInfo.maxSkillId
	local config = ConfigReader:getRecordById("Skill", tostring(skillId))

	if not config then
		return
	end

	skillPanel:setVisible(true)
	self:addSkill(skillPanel, newInfo.maxSkillId)
end

function TowerStrengthEndTipMediator:addSkill(panel, skillId)
	local imageIcon = panel:getChildByFullName("image_icon")
	local title = panel:getChildByFullName("title")
	local content = panel:getChildByFullName("content")
	local info = {
		id = skillId
	}
	local newSkillNode = IconFactory:createMasterSkillIcon(info, {
		hideLevel = true
	})

	newSkillNode:setScale(0.7)
	newSkillNode:setPosition(cc.p(6, 15))
	newSkillNode:addTo(imageIcon)

	local name = ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Name")

	title:setString(Strings:get(name))

	local text = Strings:get(ConfigReader:getDataByNameIdAndKey("Skill", skillId, "Desc"))

	content:setString(text)
end
