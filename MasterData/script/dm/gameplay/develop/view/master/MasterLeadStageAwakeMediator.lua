-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterLeadStageAwakeMediator.lua

MasterLeadStageAwakeMediator = class("MasterLeadStageAwakeMediator", DmAreaViewMediator, _M)

MasterLeadStageAwakeMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function MasterLeadStageAwakeMediator:initialize()
	super.initialize(self)
end

function MasterLeadStageAwakeMediator:dispose()
	super.dispose(self)
end

function MasterLeadStageAwakeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._masterSystem = self._developSystem:getMasterSystem()
end

function MasterLeadStageAwakeMediator:enterWithData(data)
	self._masterId = data.masterId or "Master_XueZhan"
	self._callback = data.callback
	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._leadStageData = self._masterData:getLeadStageData()
	self._leadStageDetailConfig = self._leadStageData:getConfigInfo()
	self._curLeadStageLevel = self._leadStageData:getLeadStageLevel()

	self:setupView()
	self:refreshView()
end

function MasterLeadStageAwakeMediator:setupView()
	self._main = self:getView():getChildByName("main")
	self._touch = self._main:getChildByName("touch")
	self._animNode = self._main:getChildByName("Node_2")

	self._touch:setTouchEnabled(true)
	self._touch:addClickEventListener(function()
		if self._callback then
			self._callback()
		end

		self:close()
	end)
	AudioEngine:getInstance():playEffect("Se_Effect_Awaken", false)
end

function MasterLeadStageAwakeMediator:refreshView()
	local kAttrType = {
		"ATK",
		"HP",
		"DEF"
	}
	local oldAttrData, oldId, oldLevel = self._masterSystem:getMastertAwakeAttr()
	local combat, attrData = self._masterData:getCombat()
	local addAttr = {
		[kAttrType[1]] = attrData.attack - oldAttrData[kAttrType[1]],
		[kAttrType[2]] = attrData.hp - oldAttrData[kAttrType[2]],
		[kAttrType[3]] = attrData.defense - oldAttrData[kAttrType[3]]
	}
	local anim = cc.MovieClip:create("tianqichenggong_tianqichenggong")

	anim:addTo(self._animNode)

	local title = ccui.Text:create(Strings:get("StageLevelUp_PopUp_UI01"), TTF_FONT_FZYH_R, 28)
	local lineGradiantVec2 = {
		{
			ratio = 0.5,
			color = cc.c4b(93, 65, 111, 255)
		},
		{
			ratio = 0.5,
			color = cc.c4b(88, 94, 124, 255)
		}
	}

	title:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 1,
		y = 0
	}))

	local mc_title = anim:getChildByFullName("mc_text.mc_text")

	title:addTo(mc_title)

	local mc_role = anim:getChildByFullName("mc_role")
	local mc_title1 = anim:getChildByFullName("mc_text")

	mc_title1:setPlaySpeed(0.5)

	if oldId == "" then
		anim:addCallbackAtFrame(18, function()
			local iconAnim = cc.MovieClip:create("rongyao0_tianqichenggong")

			iconAnim:addTo(self._animNode):posite(300, 70)
			iconAnim:addEndCallback(function()
				iconAnim:stop()
			end)

			local mc_icon1 = iconAnim:getChildByFullName("mc_icon1.mc_icon1")
			local id, lv = self._masterSystem:getMasterLeadStatgeLevel(self._masterId)
			local icon2 = IconFactory:createLeadStageIconVer(id, lv, {
				needBg = 0
			})

			icon2:addTo(mc_icon1):center(mc_icon1:getContentSize()):offset(-3, 5)
		end)
	else
		anim:addCallbackAtFrame(18, function()
			local iconAnim = cc.MovieClip:create("rongyaoan_tianqichenggong")

			iconAnim:addTo(self._animNode):posite(300, 70)
			iconAnim:addEndCallback(function()
				iconAnim:stop()
			end)

			local mc_icon1 = iconAnim:getChildByFullName("mc_icon1.mc_icon1")
			local mc_icon2 = iconAnim:getChildByFullName("mc_icon2.mc_icon2")
			local id, lv = self._masterSystem:getMasterLeadStatgeLevel(self._masterId)
			local icon1 = IconFactory:createLeadStageIconVer(oldId, oldLevel, {
				needBg = 0
			})

			if icon1 then
				icon1:addTo(mc_icon1):center(mc_icon1:getContentSize()):offset(-3, 5)
			end

			local icon2 = IconFactory:createLeadStageIconVer(id, lv, {
				needBg = 0
			})

			icon2:addTo(mc_icon2):center(mc_icon2:getContentSize()):offset(-3, 5)
		end)
	end

	local mc_attr = {}

	for i = 1, 3 do
		mc_attr[i] = anim:getChildByFullName("mc_attr" .. i)

		mc_attr[i]:addEndCallback(function()
			mc_attr[i]:stop()
		end)
	end

	local mc_skill1 = anim:getChildByFullName("mc_skill1")
	local mc_skill2 = anim:getChildByFullName("mc_skill2")

	mc_skill1:gotoAndStop(1)
	mc_skill2:gotoAndStop(1)

	for i = 1, 3 do
		local mc_di = mc_attr[i]:getChildByFullName("mc_di")
		local mc_attrName = mc_attr[i]:getChildByFullName("mc_attack")
		local mc_attrValue = mc_attr[i]:getChildByFullName("mc_attackValue")
		local mc_attrAdd = mc_attr[i]:getChildByFullName("mc_attackAdd")
		local attrName = ccui.Text:create(getAttrNameByType(kAttrType[i]), TTF_FONT_FZYH_M, 18)
		local attrValue = ccui.Text:create(oldAttrData[kAttrType[i]], TTF_FONT_FZYH_M, 18)
		local attrAdd = ccui.Text:create("+" .. addAttr[kAttrType[i]], TTF_FONT_FZYH_M, 18)

		attrName:setTextColor(cc.c3b(193, 193, 193))
		attrAdd:setTextColor(cc.c3b(224, 224, 9))
		attrName:addTo(mc_attrName)
		attrValue:addTo(mc_attrValue)
		attrAdd:addTo(mc_attrAdd)

		local bg = ccui.Scale9Sprite:createWithSpriteFrameName("zhujue_bg_shuxing_bg.png")

		bg:setCapInsets(cc.rect(10, 10, 5, 5))
		bg:setAnchorPoint(cc.p(0, 0))
		bg:setContentSize(cc.size(315, 23))
		bg:addTo(mc_di):offset(-165, -10)

		local attrTypeImage = AttrTypeImage[kAttrType[i]]
		local image = ccui.ImageView:create(attrTypeImage, 1)

		image:addTo(mc_di):offset(-150, 0)
	end

	local role = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe2_1",
		id = self._masterData:getModel()
	})

	role:addTo(mc_role):offset(-400, -200)

	local info = self._leadStageDetailConfig[self._curLeadStageLevel]
	local allSkills = info.skills
	local total = 0

	for i, v in ipairs(allSkills) do
		local skillId = v

		if allSkills[skillId].state == MasterLeadStageSkillState.KUP or allSkills[skillId].state == MasterLeadStageSkillState.KNew then
			total = total + 1
		end
	end

	local startX = 0
	local space = 130

	if total == 1 then
		startX = 230
	elseif total == 2 then
		startX = 150
	elseif total == 3 then
		startX = 80
	elseif total == 4 then
		startX = 40
		space = 110
	end

	anim:addCallbackAtFrame(50, function()
		local index = 1

		for i, v in ipairs(allSkills) do
			local skillId = v

			if allSkills[skillId].state == MasterLeadStageSkillState.KUP or allSkills[skillId].state == MasterLeadStageSkillState.KNew then
				local skillIcon = IconFactory:createMasterLeadStageSkillIcon({
					isLock = false,
					scale = 0.9,
					id = v
				}, nil, nil)

				skillIcon:setScale(0.6)

				local skillAnim = cc.MovieClip:create("xinjinengjiesuo_tianqichenggong")

				skillAnim:addTo(self._animNode):posite(startX + (index - 1) * space, -200)
				skillAnim:addEndCallback(function()
					skillAnim:stop()
				end)

				local ani = cc.MovieClip:create("xinjinengjiesuoTX_tianqichenggong")

				ani:addTo(self._animNode):posite(startX + (index - 1) * space, -180)
				ani:addEndCallback(function()
					ani:stop()
				end)

				local mc_skillIcon = skillAnim:getChildByFullName("mc_skillIcon")
				local mc_skillDi = skillAnim:getChildByFullName("mc_skilldi")

				skillIcon:addTo(mc_skillIcon):offset(-30, -20)

				local skillText = ""
				local imageName = ""

				if allSkills[skillId].state == MasterLeadStageSkillState.KUP then
					skillText = Strings:get("StageLevelUp_PopUp_UI03")
					imageName = "common_img_UP.png"
				else
					skillText = Strings:get("StageLevelUp_PopUp_UI02")
					imageName = "sd_new.png"
				end

				local pic = ccui.ImageView:create(imageName, ccui.TextureResType.plistType)

				pic:addTo(mc_skillIcon):posite(25, 40)

				local skilldi = ccui.Text:create(skillText, TTF_FONT_FZYH_M, 18)

				skilldi:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
				skilldi:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				skilldi:getVirtualRenderer():setDimensions(space - 10, 35)
				skilldi:addTo(mc_skillDi)

				index = index + 1
			end
		end
	end)

	local mc_title = anim:getChildByFullName("mc_text")

	mc_title:addEndCallback(function()
		mc_title:stop()
	end)
	anim:addEndCallback(function()
		anim:stop()
	end)
end

function MasterLeadStageAwakeMediator:close()
	self:dismiss()
end
