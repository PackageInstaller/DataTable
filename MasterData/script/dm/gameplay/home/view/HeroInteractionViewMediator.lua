-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/HeroInteractionViewMediator.lua

HeroInteractionViewMediator = class("HeroInteractionViewMediator", DmAreaViewMediator)

HeroInteractionViewMediator:has("_developSystem", {
	is = "r"
}):injectWith(DevelopSystem)

local kBtnHandlers = {
	["main.mainTouchPanel"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onTouchHero"
	}
}
local zeroPosHeight = 33
local maxPosHeight = 205

function HeroInteractionViewMediator:initialize()
	super.initialize(self)
end

function HeroInteractionViewMediator:dispose()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)
	end

	super.dispose(self)
end

function HeroInteractionViewMediator:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:setupTopInfoWidget()
	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroInteractionViewMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}

	self._topInfoWidget = self:autoManageObject(self:getInjector():injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
	self._topInfoWidget:hideTitle()
end

function HeroInteractionViewMediator:onClickBack()
	self:dismiss()
end

function HeroInteractionViewMediator:enterWithData(data)
	self._heroId = data.heroId
	self._heroPanel = self:getView():getChildByFullName("main.heroPanel")
	self._homeBgPanel = self:getView():getChildByFullName("main.homeBgPanel")
	self._talkPanel = self:getView():getChildByFullName("main.talkPanel")
	self._loveRelation = self:getView():getChildByFullName("main.loveRelation")
	self._loveSp = self._loveRelation:getChildByName("sprite")
	self._hand = self:getView():getChildByFullName("main.hand")

	local text = self._talkPanel:getChildByFullName("clipNode.text")

	text:setLineSpacing(4)
	text:getVirtualRenderer():setMaxLineWidth(330)
	self:initHeroView()
	self:handAnim()
	self:initBg()
	self:initAnim()

	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._heroId)

	self._talkPanel:setVisible(not isHide)

	local soundId = "Voice_" .. self._heroId .. "_49"
	local trueSoundId

	self._soundId, trueSoundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
		self._soundId = nil

		if checkDependInstance(self) then
			self._talkPanel:setVisible(false)
		end
	end)

	local str = ConfigReader:getDataByNameIdAndKey("Sound", trueSoundId, "SoundDesc")
	local text = self._talkPanel:getChildByFullName("clipNode.text")

	text:setString(Strings:get(str))
end

function HeroInteractionViewMediator:initHeroView()
	self._movePos = nil

	self._heroPanel:removeAllChildren()

	local hero = self._heroSystem:getHeroById(self._heroId)
	local heroSp, _, _, picInfo = IconFactory:createRoleIconSpriteNew({
		useAnim = true,
		frameId = "bustframe9",
		id = hero:getModel()
	})

	heroSp:addTo(self._heroPanel)
	heroSp:setPosition(cc.p(80, 200))
	self._loveSp:setContentSize(cc.size(45, zeroPosHeight))

	local surfaceId = hero:getSurfaceId()
	local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
	local _info = surfaceData[1]
	local touchPanel = ccui.Layout:create()

	touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

	local size = heroSp:getContentSize()
	local offSetX = size.width / 2

	touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))

	local posX = _info.point[1] * picInfo.zoom + picInfo.Deviation[1] + offSetX
	local posY = _info.point[2] * picInfo.zoom + picInfo.Deviation[2]

	touchPanel:setPosition(cc.p(posX, posY))
	touchPanel:setTouchEnabled(false)

	if GameConfigs.HERO_TOUCHVIEW_DEBUG then
		touchPanel:setBackGroundColorType(1)
		touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
		touchPanel:setBackGroundColorOpacity(180)
	end

	touchPanel:addTo(heroSp)
	self._hand:changeParent(heroSp)

	self._handPosX = posX
	self._handPosY = posY + _info.range[2] * picInfo.zoom / 2

	self._hand:setPosition(cc.p(self._handPosX, self._handPosY))
end

function HeroInteractionViewMediator:handAnim()
	local hand = self._hand

	hand:setPosition(cc.p(self._handPosX, self._handPosY))
	hand:setVisible(true)
	hand:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(self._handPosX + 50, self._handPosY)), cc.MoveTo:create(0.8, cc.p(self._handPosX - 80, self._handPosY)), cc.MoveTo:create(0.5, cc.p(self._handPosX, self._handPosY))))
	schedule(self:getView(), function()
		hand:runAction(cc.Sequence:create(cc.MoveTo:create(0.5, cc.p(self._handPosX + 50, self._handPosY)), cc.MoveTo:create(0.8, cc.p(self._handPosX - 80, self._handPosY)), cc.MoveTo:create(0.5, cc.p(self._handPosX, self._handPosY))))
	end, 1.8)
end

function HeroInteractionViewMediator:initBg()
	local settingSys = self:getInjector():getInstance(SettingSystem)
	local timeTable = ConfigReader:getDataByNameIdAndKey("HomeBackground", settingSys:getHomeBgId(), "Loop")
	local tabValue

	for k, v in pairs(timeTable) do
		tabValue = v

		break
	end

	local BGBackgroundId = tabValue.BG
	local bgImage = self._homeBgPanel:getChildByName("bgImage")
	local flashPanel = self._homeBgPanel:getChildByName("bgFlashPanel")
	local imageInfo = ConfigReader:getRecordById("BackGroundPicture", BGBackgroundId)
	local winSize = cc.Director:getInstance():getWinSize()

	if imageInfo.Picture and imageInfo.Picture ~= "" then
		bgImage:setVisible(true)
		bgImage:ignoreContentAdaptWithSize(true)
		bgImage:loadTexture("asset/scene/" .. imageInfo.Picture .. ".jpg")

		if winSize.height < 641 then
			bgImage:setScale(winSize.width / 1386)
		end
	end

	local flashId = imageInfo.Flash1

	if flashId and flashId ~= "" then
		local mc = cc.MovieClip:create(flashId)

		mc:addTo(flashPanel):center(flashPanel:getContentSize())

		if winSize.height < 641 then
			mc:setScale(winSize.width / 1386)
		end

		local extFlashId = imageInfo.Flash2

		if extFlashId and extFlashId ~= "" then
			local extMc = cc.MovieClip:create(extFlashId)

			if extMc then
				extMc:addTo(flashPanel):center(flashPanel:getContentSize())
				extMc:setScale(winSize.width / 1386)
			end
		end
	end

	if imageInfo.Extra and imageInfo.Extra ~= "" then
		local extraView = cc.CSLoader:createNode("asset/ui/" .. imageInfo.Extra .. ".csb")

		extraView:addTo(flashPanel):center(flashPanel:getContentSize())

		if winSize.height < 641 then
			extraView:setScale(winSize.width / 1386)
		end
	end
end

function HeroInteractionViewMediator:initAnim()
	local mc1 = cc.MovieClip:create("xin_haogandu")

	mc1:addTo(self._loveRelation):setPosition(cc.p(0, 0))
end

function HeroInteractionViewMediator:onTouchHero(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._talkPanel:setVisible(false)

		if self._soundId then
			AudioEngine:getInstance():stopEffect(self._soundId)

			self._soundId = nil
		end

		self._movePos = sender:getTouchBeganPosition()
	elseif eventType == ccui.TouchEventType.moved then
		if self._touchEventEnd then
			return
		end

		local pos = sender:getTouchMovePosition()

		if pos.x < 480 or pos.x > 730 then
			return
		end

		if self._hand:isVisible() then
			self._hand:setVisible(false)
		end

		if not self._loveRelation:isVisible() then
			self._loveRelation:setVisible(true)
		end

		self._loveSp:stopAllActions()

		self._nowPosHeight = self._loveSp:getContentSize().height

		local distance = cc.pGetDistance(pos, self._movePos)
		local insecHeight = distance / 5

		self._loveSp:setContentSize(cc.size(45, self._nowPosHeight + insecHeight))

		self._movePos = pos

		if self._nowPosHeight >= maxPosHeight then
			self._touchEventEnd = true

			self._loveRelation:setVisible(false)
			self._loveSp:setContentSize(cc.size(45, zeroPosHeight))
			self:showRelationUpView()
		end
	elseif eventType == ccui.TouchEventType.ended then
		self._touchEventEnd = false

		self._loveSp:stopAllActions()

		local baseAct = cc.Sequence:create(cc.DelayTime:create(0.05), cc.CallFunc:create(function()
			local size = self._loveSp:getContentSize()

			if size.height > zeroPosHeight then
				self._loveSp:setContentSize(cc.size(size.width, size.height - 1))
			else
				self._loveRelation:setVisible(false)
				self._hand:setVisible(true)
			end
		end))
		local anim = cc.Repeat:create(baseAct, 210)

		self._loveSp:runAction(anim)
	end
end

function HeroInteractionViewMediator:showRelationUpView()
	local param = {}

	param.heroId = self._heroId
	param.itemId = ""

	local gallerySystem = self:getInjector():getInstance(GallerySystem)

	gallerySystem:requestDoAfkEvent(param, function(response)
		local mainView = self:getView():getChildByName("main")

		mainView:removeChildByTag(1351)

		local num = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroAfkEventLove", "content")
		local developSystem = self:getInjector():getInstance(DevelopSystem)
		local heroSystem = developSystem:getHeroSystem()
		local isLoveLevelMax = heroSystem:isLoveLevelMax(self._heroId)
		local anim = IconFactory:createLoveUpAnim(self._heroId, num, nil, isLoveLevelMax)

		if anim then
			anim:addTo(mainView)
			anim:setPosition(cc.p(750, 500))
			anim:setTag(1351)
		end

		self:getView():getChildByFullName("main.mainTouchPanel"):setVisible(false)
		self._hand:setOpacity(0)
	end)
end
