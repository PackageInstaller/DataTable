-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/BuildingLvUpSucMediator.lua

BuildingLvUpSucMediator = class("BuildingLvUpSucMediator", DmPopupViewMediator, _M)

BuildingLvUpSucMediator:has("_buildingSystem", {
	is = "r"
}):injectWith("BuildingSystem")

function BuildingLvUpSucMediator:initialize()
	super.initialize(self)
end

function BuildingLvUpSucMediator:dispose()
	super.dispose(self)
end

function BuildingLvUpSucMediator:onRegister()
	super.onRegister(self)
	self:mapEventListeners()

	self._buildingSystem._buildingLvUpFinishShowSta = true
end

function BuildingLvUpSucMediator:mapEventListeners()
	return
end

function BuildingLvUpSucMediator:onRemove()
	super.onRemove(self)
end

function BuildingLvUpSucMediator:enterWithData(data)
	self._data = data

	self:setupView()
	self:startAnimation()
end

function BuildingLvUpSucMediator:setupView()
	self._touchmask = self:getView():getChildByFullName("touchmask")

	self._touchmask:onTouch(handler(self, self.onTouchMask, true))
	self._touchmask:setSwallowTouches(true)

	local buildName = self:getView():getChildByFullName("node.buildName")
	local text = self:getView():getChildByFullName("node.infoPanel.text")

	buildName:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
	text:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
end

function BuildingLvUpSucMediator:startAnimation()
	local buildingSystem = self._buildingSystem
	local view = self:getView()
	local node = view:getChildByFullName("node")
	local infoPanel = node:getChildByFullName("infoPanel")

	node:setVisible(false)
	node:setOpacity(0)

	local buildName = node:getChildByFullName("buildName")
	local buildLv = node:getChildByFullName("buildLv")
	local text = infoPanel:getChildByFullName("text")
	local comfort = 0
	local buildingData = buildingSystem:getBuildingData(self._data.roomId, self._data.id)
	local config = buildingSystem:getBuildingConfig(self._data.buildingId)
	local str = Strings:get(config.Name)

	buildName:setString(str)
	buildLv:setVisible(false)

	if buildingData then
		buildName:setString(str .. "    LV." .. self._data.level or buildingData._level)

		local skinId = buildingData._skinId
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		comfort = skinConfig.Comfort or 0
	else
		local skinId = config.DefaultSurface
		local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

		comfort = skinConfig.Comfort or 0
	end

	buildName:setPositionX(buildName:getContentSize().width / 2)

	comfort = comfort == 0 and "" or "+" .. comfort

	if config.Type == KBuildingType.kCardAcademy then
		local num = self._data.cardEffectValue

		text:setString(Strings:get(config.BuildDesc, {
			num = num
		}))
	elseif config.Type == KBuildingType.kCamp then
		local num = self._data.costEffectValue

		text:setString(Strings:get(config.BuildDesc, {
			num = num
		}))
	else
		text:setString(Strings:get(config.BuildDesc))
	end

	local animNode = view:getChildByFullName("animNode")
	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(40, function()
		anim:gotoAndStop(40)

		self._canClose = true

		self:setupClickEnvs()
	end)
	anim:setPlaySpeed(2)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title = ""
	local titleEn = ""

	AudioEngine:getInstance():playEffect("Se_Alert_Common", false)

	if self._data.showType == 1 then
		title = Strings:get("Tips_3010021")
		titleEn = Strings:get("UITitle_EN_Shengjichenggong")

		AudioEngine:getInstance():playEffect("Se_Alert_Equip_Levelup", false)
	elseif self._data.showType == 2 then
		title = Strings:get("Build_Finish_Title")
		titleEn = Strings:get("UITitle_EN_Jianzaochenggong")

		AudioEngine:getInstance():playEffect("Se_Alert_Build", false)
	end

	local title1 = cc.Label:createWithTTF(title, CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(titleEn, TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)

	local buildNode = anim:getChildByFullName("icon")
	local iconNode = cc.Node:create()
	local buildingDecorate = self:getInjector():instantiate("BuildingDecorate", {
		view = iconNode
	})

	buildingDecorate:setBuildingInfo(self._data.roomId, self._data.buildingId, self._data.id)
	buildingDecorate:enterWithData()

	local skinId = buildingSystem:getBuildingSkinId(self._data.roomId, self._data.buildingId, self._data.id)
	local skinConfig = ConfigReader:getRecordById("VillageBuildingSurface", skinId)

	if skinConfig then
		iconNode:setScale(skinConfig.PicScale[3] or 1)
	end

	iconNode:addTo(buildNode):offset(0, -30)
	anim:addCallbackAtFrame(9, function()
		local callFunc = cc.CallFunc:create(function()
			node:setVisible(true)
		end)
		local fadeIn = cc.FadeIn:create(0.3)
		local seq = cc.Sequence:create(callFunc, fadeIn)

		node:runAction(seq)
	end)
	anim:addCallbackAtFrame(40, function()
		return
	end)
end

function BuildingLvUpSucMediator:onTouchMask(event)
	if event.name == "began" or event.name == "moved" then
		-- block empty
	elseif (event.name == "ended" or event.name == "cancelled") and self._canClose then
		local buildingSystem = self._buildingSystem
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)

		self:close()
		storyDirector:notifyWaiting("close_BuildingToast_view")

		buildingSystem._buildingLvUpFinishShowSta = false

		buildingSystem:showLvUpSucView()
	end
end

function BuildingLvUpSucMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local animNode = self:getView():getChildByFullName("animNode")

		if animNode then
			storyDirector:setClickEnv("BuildingLvUpSuc.closeBtn", animNode, function(sender, eventType)
				self:onTouchMask({
					name = "ended"
				})
			end)
		end

		storyDirector:notifyWaiting("enter_buildingBuildSuc_view")
	end))

	self:getView():runAction(sequence)
end
