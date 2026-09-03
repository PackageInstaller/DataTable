-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/toasts/RewardToast.lua

RewardToast = class("RewardToast", SimpleToast)

local kMaxshowIconCount = 5

function RewardToast:getGroupName()
	return "rewardToast"
end

function RewardToast:setup(parentLayer, parentFrame, options, activeToasts)
	self._rewards = options.rewards or {}
	self._options = options

	local view = self:getView()

	view:setCascadeOpacityEnabled(true)
	parentLayer:addChild(self:getView(), 1001)
	view:setPosition(0, 0)

	return true
end

function RewardToast:startAnimation(endCallback)
	self._endCallback = endCallback

	self:getView():setPosition(-568, -320)

	if table.nums(self._rewards) == 0 then
		self:getView():removeFromParent()
		self:_endCallback()

		return
	end

	self._main = self:getView():getChildByName("main")
	self._iconPanel = self._main:getChildByName("iconpanel")

	self._iconPanel:setLocalZOrder(10)

	self._kIconWidth = self._iconPanel:getContentSize().width / kMaxshowIconCount

	self:initReward()
end

function RewardToast:initReward()
	local rewardsNow = {}
	local filter = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Activity_Point_Hide", "content")

	for i = 1, table.nums(self._rewards) do
		if self._rewards[i] and self._rewards[i].code then
			local code = self._rewards[i].code
			local type = self._rewards[i].type
			local amount = self._rewards[i].amount

			if type == RewardType.kEquip or type == RewardType.kEquipExplore then
				for j = 1, amount do
					rewardsNow[#rewardsNow + 1] = {
						amount = 1,
						code = code,
						type = type
					}
				end
			elseif not table.indexof(filter, code) then
				rewardsNow[#rewardsNow + 1] = self._rewards[i]
			end
		end
	end

	self._rewards = rewardsNow

	if table.nums(self._rewards) == 0 then
		self:getView():removeFromParent()
		self:_endCallback()

		return
	end

	self._rewardIndex = 1
	self._maxGroupCount = math.ceil(#self._rewards / kMaxshowIconCount)
	self._curGroupIndex = 1

	self:setupView()
end

function RewardToast:setupView()
	AudioEngine:getInstance():playEffect("Se_Alert_Reward", false)
	self:showGetRewardAnim()
end

function RewardToast:getCurShowRewardCount()
	if self._curGroupIndex < self._maxGroupCount or #self._rewards % kMaxshowIconCount == 0 then
		return kMaxshowIconCount
	else
		return #self._rewards % kMaxshowIconCount
	end
end

function RewardToast:showGetRewardAnim()
	local animNode = self:getView():getChildByFullName("main.animNode")
	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()

		local close = self:onClickOk()

		if close then
			anim:gotoAndPlay(40)
			self._iconPanel:fadeOut({
				time = 0.4
			})
		else
			self._iconPanel:removeAllChildren(true)
			anim:gotoAndPlay(0)
		end
	end)
	anim:addCallbackAtFrame(55, function()
		self:getView():removeFromParent()

		local dispatcher = DmGame:getInstance()
		local developSystem = dispatcher._injector:getInstance("DevelopSystem")

		developSystem:popPlayerLvlUpView()
		self:_endCallback()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Get_Reward_Title"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Gongxihuode"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(9, function()
		self:showOneIcon(1)
	end)
end

function RewardToast:showOneIcon(index)
	if DisposableObject:isDisposed(self) then
		return
	end

	self._rewardIndex = index + (self._curGroupIndex - 1) * kMaxshowIconCount

	local baseNode = cc.Node:create()

	self._iconPanel:addChild(baseNode)

	local rewardData = self._rewards[self._rewardIndex]
	local anim = cc.MovieClip:create("icon_group_gongxihuode")

	anim:setPlaySpeed(1.5)
	anim:setPosition(cc.p(-8, 27))
	baseNode:addChild(anim, 2)
	anim:addCallbackAtFrame(5, function()
		local iconNode = cc.Node:create()

		baseNode:addChild(iconNode)

		local icon = IconFactory:createRewardIcon(rewardData, {
			isWidget = true
		})

		icon:addTo(iconNode, 1):center(iconNode:getContentSize())
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
		icon:setScaleNotCascade(0.6)

		local name = RewardSystem:getName(rewardData)
		local nameText = cc.Label:createWithTTF(name, TTF_FONT_FZYH_M, 16, cc.size(86, 80))

		nameText:setAlignment(1, 0)
		nameText:setAnchorPoint(cc.p(0.5, 1))
		nameText:enableOutline(cc.c4b(0, 0, 0, 127), 1)
		nameText:addTo(iconNode):center(iconNode:getContentSize()):offset(0, -86)

		if rewardData.type == RewardType.kEquip or rewardData.type == RewardType.kEquipExplore then
			local config = ConfigReader:getRecordById("HeroEquipBase", rewardData.code)

			GameStyle:setRarityText(nameText, config.Rareity)
		else
			GameStyle:setQualityText(nameText, RewardSystem:getQuality(rewardData))
		end

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
		if rewardData.type == 3 then
			self:showNewHeroView(rewardData.code)

			if index < self:getCurShowRewardCount() then
				index = index + 1

				self:showOneIcon(index)
			end
		elseif index < self:getCurShowRewardCount() then
			index = index + 1

			self:showOneIcon(index)
		end
	end)
end

function RewardToast:showNewHeroView(heroId)
	local dispatcher = DmGame:getInstance()
	local view = dispatcher._injector:getInstance("newHeroView")

	dispatcher:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		heroId = heroId
	}))
end

function RewardToast:onClickOk()
	if self._curGroupIndex and self._maxGroupCount and self._curGroupIndex < self._maxGroupCount then
		self._curGroupIndex = self._curGroupIndex + 1

		return false
	else
		return true
	end
end

function ShowRewardTipEvent(args)
	local toastView = cc.CSLoader:createNode("asset/ui/GetReward.csb")
	local toast = RewardToast:new(toastView)

	return ToastEvent:new(EVT_SHOW_REWARD_TOAST, toast, args)
end
