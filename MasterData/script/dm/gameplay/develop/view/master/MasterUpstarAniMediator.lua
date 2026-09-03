-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterUpstarAniMediator.lua

MasterUpstarAniMediator = class("MasterUpstarAniMediator", DmPopupViewMediator, _M)

MasterUpstarAniMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function MasterUpstarAniMediator:initialize()
	super.initialize(self)
end

function MasterUpstarAniMediator:dispose()
	super.dispose(self)
end

function MasterUpstarAniMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MasterUpstarAniMediator:onRemove()
	super.onRemove(self)
end

function MasterUpstarAniMediator:enterWithData(datas)
	AudioEngine:getInstance():playEffect("Se_Alert_Common", false)
	AudioEngine:getInstance():playEffect("Se_Alert_Shengxing", false)

	self._player = self._developSystem:getPlayer()

	self:showSucAni(datas.preDatas, datas.data, datas.enable)
end

function MasterUpstarAniMediator:checkNewSkill(preskill, newskill, keylist)
	for k, v in pairs(keylist) do
		if preskill[v] ~= newskill[v] then
			return true, v
		end
	end

	return false
end

function MasterUpstarAniMediator:showSucAni(preData, data, oldenable)
	local preEnable = {}
	local newEnable = {}
	local keylist = {}

	for key, value in pairs(oldenable) do
		table.insert(keylist, key)

		preEnable[key] = value
	end

	for key, value in pairs(data.skills) do
		newEnable[value.id] = value.enable
	end

	local havenew, newskillid = self:checkNewSkill(preEnable, newEnable, keylist)

	self._mainpanel = self:getView():getChildByName("mainpanel_0")

	local mastermodel = self._player:getMasterList():getMasterById(data.id)
	local combat, attrData = mastermodel:getCombat()

	self._touchLayer = self:getView():getChildByName("touchLayer")

	self._touchLayer:setVisible(false)
	self._mainpanel:setLocalZOrder(2)

	local attrPanel = self._mainpanel:getChildByName("attrPanel")

	attrPanel:setOpacity(0)

	local skillPanel = self._mainpanel:getChildByFullName("panel1.newPanel")

	skillPanel:setVisible(false)
	self._mainpanel:getChildByFullName("panel1"):setPositionX(466)

	local rarityPanel = self._mainpanel:getChildByFullName("panel2.newPanel")

	rarityPanel:setVisible(false)
	self._mainpanel:getChildByFullName("panel2"):setPositionX(466)

	if data.havenew then
		self._mainpanel:getChildByFullName("panel1"):setPositionX(306)
		self._mainpanel:getChildByFullName("panel2"):setPositionX(630)
	end

	local starPanel = self._mainpanel:getChildByName("starPanel")

	starPanel:setVisible(false)
	starPanel:setOpacity(0)

	local anim = cc.MovieClip:create("dhx_shengxingchenggong")

	anim:addTo(self:getView())
	anim:setPosition(cc.p(568, 320))
	anim:addCallbackAtFrame(60, function()
		anim:stop()
	end)
	anim:addCallbackAtFrame(12, function()
		local titleAnim = cc.MovieClip:create("zitix_shengxingchenggong")

		titleAnim:addCallbackAtFrame(10, function()
			titleAnim:stop()
		end)

		local title = titleAnim:getChildByFullName("title")

		if title then
			local titleImage = ccui.ImageView:create("yh_sxcg.png", 1)

			titleImage:addTo(title)
		end

		titleAnim:addTo(self:getView())
		titleAnim:setPosition(cc.p(380, 396))
	end)
	anim:addCallbackAtFrame(25, function()
		starPanel:setVisible(true)
		starPanel:fadeIn({
			time = 0.2
		})
	end)

	local curStarNode = starPanel:getChildByFullName("star_" .. data.star)

	anim:addCallbackAtFrame(35, function()
		local anim1 = cc.MovieClip:create("aa_yinghunshengxing")

		anim1:addTo(curStarNode)
		anim1:addEndCallback(function()
			anim1:gotoAndPlay(30)
		end)
		anim1:setPosition(cc.p(-10, 13))
		anim1:gotoAndPlay(0)
	end)
	anim:addCallbackAtFrame(38, function()
		attrPanel:fadeIn({
			time = 0.2
		})
	end)
	anim:addCallbackAtFrame(43, function()
		if havenew then
			skillPanel:setVisible(true)
			skillPanel:stopAllActions()

			local action = cc.CSLoader:createTimeline("asset/ui/MasterUpstarAni.csb")

			skillPanel:runAction(action)
			action:gotoFrameAndPlay(0, 16, false)

			local panel1 = skillPanel:getChildByFullName("panel1")
			local panel = skillPanel:getChildByFullName("panel")

			panel1:setPosition(cc.p(panel:getContentSize().width, -5))

			local delay = cc.DelayTime:create(0.2)
			local moveto = cc.MoveTo:create(0.2, cc.p(0, -5))
			local seq = cc.Sequence:create(delay, moveto)

			panel1:runAction(seq)
			panel:setScaleX(0)

			delay = cc.DelayTime:create(0.2)

			local scaleto = cc.ScaleTo:create(0.2, 1, 1)

			seq = cc.Sequence:create(delay, scaleto)

			panel:runAction(seq)
		end
	end)

	for i = 1, 6 do
		local starNode = starPanel:getChildByName("star_" .. i)

		if i < data.star then
			local anim1 = cc.MovieClip:create("aa_yinghunshengxing")

			anim1:addTo(starNode)
			anim1:addEndCallback(function()
				anim1:gotoAndPlay(30)
			end)
			anim1:setPosition(cc.p(-10, 13))
			anim1:gotoAndPlay(30)
		end
	end

	attrPanel:getChildByFullName("des_1.text"):setString(preData.attack)
	attrPanel:getChildByFullName("des_2.text"):setString(preData.hp)
	attrPanel:getChildByFullName("des_3.text"):setString(preData.defense)
	attrPanel:getChildByFullName("des_4.text"):setString(preData.speed)
	attrPanel:getChildByFullName("des_1.extandText"):setString("+" .. attrData.attack - preData.attack)
	attrPanel:getChildByFullName("des_2.extandText"):setString("+" .. attrData.hp - preData.hp)
	attrPanel:getChildByFullName("des_3.extandText"):setString("+" .. attrData.defense - preData.defense)
	attrPanel:getChildByFullName("des_4.extandText"):setString("+" .. attrData.speed - preData.speed)

	if havenew then
		skillPanel:getChildByFullName("panel1.newType"):setString(Strings:get("heroshow_UI20"))

		local skillName = skillPanel:getChildByFullName("name")
		local skillIcon = skillPanel:getChildByFullName("icon")

		skillIcon:removeAllChildren()

		local skillId = newskillid
		local skillConfig = ConfigReader:getRecordById("Skill", tostring(skillId))
		local newSkillNode = IconFactory:createMasterSkillIcon({
			isLock = false,
			id = skillId
		}, {
			hideLevel = true,
			isWidget = true
		})

		skillIcon:addChild(newSkillNode)
		newSkillNode:setPosition(cc.p(-25, -25))
		skillName:setString(tostring(Strings:get(skillConfig.Name)))

		local panel = skillPanel:getChildByFullName("panel")
		local bg = panel:getChildByFullName("bg")
		local gap = skillName:getContentSize().width - 105
		local width = math.max(217, 217 + gap)

		skillPanel:setContentSize(cc.size(width, 68))
		panel:setContentSize(cc.size(width, 68))
		bg:setContentSize(cc.size(width, 68))
		panel:setPositionX(width)
	end
end

function MasterUpstarAniMediator:playUpstarFlash(preData, data)
	local mastermodel = self._player:getMasterList():getMasterById(data.id)
	local combat, attrData = mastermodel:getCombat()

	self._mainpanel = self:getView():getChildByName("mainpanel_0")

	self._mainpanel:getChildByName("title"):setString(Strings:get("MASTER_UI1"))
	GameStyle:setGoldCommonEffect(self._mainpanel:getChildByName("title"))

	local panel = self._mainpanel:getChildByName("icon")
	local roleModel = IconFactory:getRoleModelByKey("MasterBase", data.id)
	local img = IconFactory:createRoleIconSpriteNew({
		iconType = 2,
		id = roleModel
	})

	panel:addChild(img)
	panel:setScale(1.15)
	img:setAnchorPoint(cc.p(0.5, 0.5))
	img:setPosition(cc.p(panel:getContentSize().width / 2 - 50, panel:getContentSize().height / 2 - 125))

	local starPanel = self._mainpanel:getChildByName("starPanel")

	starPanel:setVisible(true)

	local preStars = starPanel:getChildByName("preStars")

	for i = 1, 6 do
		preStars:getChildByName("star_" .. i):setVisible(i <= data.star - 1)
	end

	local curStar = data.star
	local curStars = starPanel:getChildByName("curStars")

	for i = 1, 6 do
		curStars:getChildByName("star_" .. i):setVisible(i <= curStar)
	end

	local attrPanel = self._mainpanel:getChildByName("attrPanel")

	attrPanel:getChildByFullName("des_1.text"):setString(preData.attack)
	attrPanel:getChildByFullName("des_2.text"):setString(preData.hp)
	attrPanel:getChildByFullName("des_3.text"):setString(preData.defense)
	attrPanel:getChildByFullName("des_4.text"):setString(preData.speed)
	attrPanel:getChildByFullName("des_1.extandText"):setString("+" .. attrData.attack - preData.attack)
	attrPanel:getChildByFullName("des_2.extandText"):setString("+" .. attrData.hp - preData.hp)
	attrPanel:getChildByFullName("des_3.extandText"):setString("+" .. attrData.defense - preData.defense)
	attrPanel:getChildByFullName("des_4.extandText"):setString("+" .. attrData.speed - preData.speed)

	local skillPanel = self._mainpanel:getChildByName("newPanel")

	skillPanel:setVisible(false)
end
