-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/tsoul/view/TSoulCompoundResultMediator.lua

TSoulCompoundResultMediator = class("TSoulCompoundResultMediator", DmPopupViewMediator, _M)

local skillAttrName = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_SkillAttrName", "content")
local kMaxshowIconCount = 1

function TSoulCompoundResultMediator:initialize()
	super.initialize(self)

	self._allGetSurface = {}
	self._needClick = true
end

function TSoulCompoundResultMediator:dispose()
	super.dispose(self)

	if self._callback then
		self._callback()
	end
end

function TSoulCompoundResultMediator:userInject()
	return
end

function TSoulCompoundResultMediator:onRegister()
	super.onRegister(self)

	self._main = self:getView():getChildByName("main")
	self._iconPanel = self._main:getChildByName("iconpanel")

	self._iconPanel:setLocalZOrder(10)

	self._kIconWidth = self._iconPanel:getContentSize().width / kMaxshowIconCount + 10
end

function TSoulCompoundResultMediator:enterWithData(data)
	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self._tSoulSystem = developSystem:getTSoulSystem()
	self._newStoneData = self._tSoulSystem:getTSoulById(data.stoneId)
	self._callback = data.callback
	self._oldStoneAttr = data.oldStoneAttr or {}
	self._success = data.success
	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)
	self._listView:setContentSize(250, 80)
	self._listView:setClippingEnabled(true)
	self._listView:setDirection(ccui.ScrollViewDir.vertical)
	self._listView:setTouchEnabled(true)

	self._cell = self._main:getChildByName("AttrCell")

	self._cell:setVisible(false)

	self._tips = data.tips or false
	self._title = data.title or nil
	self._title1 = data.title1 or nil
	self._rewardIndex = 1
	self._maxGroupCount = 1
	self._curGroupIndex = 1
	self._delayTime = 0.7
	self._rewards = data.reward or ""

	self:createDelayAction()
	self:showGetRewardAnim()
end

function TSoulCompoundResultMediator:showGetRewardAnim()
	local animNode = self:getView():getChildByFullName("main.animNode")
	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()

		if not self._needClick then
			local close = self:onClickOk()

			if close then
				anim:gotoAndPlay(40)
				self._iconPanel:fadeOut({
					time = 0.4
				})
			else
				self._iconPanel:removeAllChildren(true)
				self:showOneIcon(1)
			end
		end
	end)
	anim:addCallbackAtFrame(55, function()
		anim:stop()
		self:doLevelViewLogic()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")

	if not self._title then
		local t = Strings:get("Get_Reward_Title")
		local title1 = cc.Label:createWithTTF(t, CUSTOM_TTF_FONT_1, 50)

		title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
		title1:addTo(cnText):offset(0, -3)

		if not self._title1 then
			local t1 = Strings:get("UITitle_EN_Gongxihuode")
			local title2 = cc.Label:createWithTTF(t1, TTF_FONT_FZYH_M, 18)

			title2:setColor(cc.c3b(150, 160, 255))
			title2:addTo(enText)
			anim:addCallbackAtFrame(9, function()
				self:showOneIcon(1)
			end)

			self._mainAnim = anim
		end
	end
end

function TSoulCompoundResultMediator:onClickOk()
	if self._curGroupIndex and self._maxGroupCount and self._curGroupIndex < self._maxGroupCount then
		self._curGroupIndex = self._curGroupIndex + 1

		return false
	else
		return true
	end
end

function TSoulCompoundResultMediator:showOneIcon(index)
	if DisposableObject:isDisposed(self) then
		return
	end

	self._rewardIndex = index

	local baseNode = cc.Node:create()

	self._iconPanel:addChild(baseNode)

	local rewardData = self._rewards

	if not rewardData then
		return
	end

	local anim = cc.MovieClip:create("icon_group_gongxihuode")

	self._anim = anim

	anim:setPlaySpeed(1.5)
	anim:setPosition(cc.p(-8, 27))
	baseNode:addChild(anim, 2)
	anim:addCallbackAtFrame(5, function()
		local iconNode = cc.Node:create()

		baseNode:addChild(iconNode)

		local icon

		if self._success == 1 then
			icon = IconFactory:createRewardIcon(rewardData, {
				isWidget = true
			})

			icon:addTo(iconNode, 1):center(iconNode:getContentSize()):offset(-80)
			IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
				swallowTouches = true,
				needDelay = true
			})
		else
			local tSoulId = self._newStoneData:getConfigId()

			icon = IconFactory:createTSoulIcon({
				id = tSoulId
			})

			icon:addTo(iconNode, 1):center(iconNode:getContentSize()):offset(-80)
		end

		local name = self._newStoneData:getName()
		local nameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 24, cc.size(580, 80))

		nameText:setAlignment(1, 0)
		nameText:setAnchorPoint(cc.p(0.5, 1))
		nameText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
		nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(80, 6)
		nameText:setOverflow(cc.LabelOverflow.SHRINK)
		nameText:setDimensions(200, 50)
		GameStyle:setQualityText(nameText, self._newStoneData:getRarity())
		AudioEngine:getInstance():playEffect("Se_Alert_Common_Gain")
	end)
	anim:addEndCallback(function()
		anim:stop()
		anim:setVisible(false)
	end)

	local initX = self._iconPanel:getContentSize().width / 2 - (self:getCurShowRewardCount() - 1) * 0.5 * self._kIconWidth

	baseNode:setPosition(cc.p(initX + (index - 1) * self._kIconWidth, 0))

	local frame = {
		2,
		2,
		3,
		2,
		2
	}

	anim:addCallbackAtFrame(frame[index], function()
		if rewardData.type == RewardType.kHero then
			self:showNewHeroView(rewardData.code, function()
				if DisposableObject:isDisposed(self) then
					return
				end

				if index < self:getCurShowRewardCount() then
					index = index + 1

					self:showOneIcon(index)
				end
			end)
		elseif rewardData.type == RewardType.kSurface then
			self._allGetSurface[#self._allGetSurface + 1] = rewardData.code

			if index < self:getCurShowRewardCount() then
				index = index + 1

				self:showOneIcon(index)
			end
		elseif rewardData.type == RewardType.kItem and rewardData.heroId then
			self:showNewHeroView(rewardData.heroId, function()
				if DisposableObject:isDisposed(self) then
					return
				end

				if index < self:getCurShowRewardCount() then
					index = index + 1

					self:showOneIcon(index)
				end
			end, false, rewardData.amount)
		elseif index < self:getCurShowRewardCount() then
			index = index + 1

			self:showOneIcon(index)
		end

		self:setupView()
	end)
end

function TSoulCompoundResultMediator:getQualityForSort(rewardData)
	local quality = 1

	if rewardData then
		if rewardData.type == RewardType.kEquip or rewardData.type == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", rewardData.code)

			quality = config.Rareity - 9
		elseif rewardData.type == RewardType.kHero then
			local config = ConfigReader:getRecordById("HeroBase", rewardData.code)

			if config and config.Id then
				quality = config.Rareity - 9
			end
		else
			quality = RewardSystem:getQuality(rewardData)
		end

		if quality == nil then
			quality = 1
		end
	end

	return quality
end

function TSoulCompoundResultMediator:getCurShowRewardCount()
	if self._curGroupIndex < self._maxGroupCount or #self._rewards % kMaxshowIconCount == 0 then
		return kMaxshowIconCount
	else
		return #self._rewards % kMaxshowIconCount
	end
end

function TSoulCompoundResultMediator:onTouchMaskLayer()
	if self._delayClick then
		return
	end

	local close = self:onClickOk()

	if not self._needClick or close then
		self._mainAnim:stop()
		self:doLevelViewLogic()
	elseif not close then
		self:createDelayAction()
		self._iconPanel:removeAllChildren(true)
		self:showOneIcon(1)
	end
end

function TSoulCompoundResultMediator:createDelayAction()
	self._delayClick = true

	performWithDelay(self:getView(), function()
		self._delayClick = false
	end, self._delayTime)
end

function TSoulCompoundResultMediator:doLevelViewLogic()
	self:doShowSurfaceLogic()
end

function TSoulCompoundResultMediator:setupView()
	local attrInfo = self._newStoneData:getBaseAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._cell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("newImg"):setVisible(false)
		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		_cell:getChildByFullName("newImg"):setPositionX(_cell:getChildByFullName("attrNum"):getPositionX() + _cell:getChildByFullName("attrNum"):getContentSize().width + 35)
		self._listView:pushBackCustomItem(_cell)
	end

	local attrInfo = self._newStoneData:getAddAttr()

	for attrType, value in pairs(attrInfo) do
		local _cell = self._cell:clone()

		_cell:setVisible(true)

		local name = Strings:get(skillAttrName[attrType])

		if AttributeCategory:getAttNameAttend(attrType) ~= "" then
			value = value * 100 .. "%"
		end

		_cell:getChildByFullName("newImg"):setVisible(self._oldStoneAttr[attrType] == nil)
		_cell:getChildByFullName("attrName"):setString(name)
		_cell:getChildByFullName("attrNum"):setString("+" .. value)
		_cell:getChildByFullName("attrNum"):setPositionX(_cell:getChildByFullName("attrName"):getPositionX() + _cell:getChildByFullName("attrName"):getContentSize().width + 2)
		_cell:getChildByFullName("newImg"):setPositionX(_cell:getChildByFullName("attrNum"):getPositionX() + _cell:getChildByFullName("attrNum"):getContentSize().width + 35)
		self._listView:pushBackCustomItem(_cell)
	end
end

function TSoulCompoundResultMediator:onTouchMaskLayer()
	self:close()
end

function TSoulCompoundResultMediator:doShowSurfaceLogic()
	if #self._allGetSurface > 0 and self._curSurfaceIndex == nil then
		self._curSurfaceIndex = 1
	end

	local surfaceId = self._allGetSurface[self._curSurfaceIndex]

	if surfaceId then
		self:showNewSurfaceView(surfaceId, function()
			self._curSurfaceIndex = self._curSurfaceIndex + 1

			self:doShowSurfaceLogic()
		end)
	else
		self:levelAndClose()
	end
end

function TSoulCompoundResultMediator:levelAndClose()
	local callback = self._callback
	local developSystem = self:getInjector():getInstance("DevelopSystem")

	self:close()
	developSystem:popPlayerLvlUpView()

	if callback then
		callback()
	end
end

function TSoulCompoundResultMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
