-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitResultMediator.lua

local DrawCardStiveExReward = ConfigReader:getDataByNameIdAndKey("ConfigValue", "DrawCard_StiveExReward", "content")

function RecruitMainMediator:enterResultWithData(data)
	self:getView():stopAllActions()

	self._showAnimNodes = {}
	self._animSkip = false
	self._canClose = false

	self:initData(data)
	self:initResultView()

	self._refreshTabBtn = false
end

function RecruitMainMediator:initData(data)
	self._heroesArr = {}

	local recruitId = data.recruitId

	self._recruitPool = self._recruitManager:getRecruitPoolById(recruitId)
	self._rewards = data.rewards
	self._extraRewards = data.extraRewards or {}
	self._realRecruitTimes = #self._rewards
end

function RecruitMainMediator:addShare()
	local data = {
		enterType = ShareEnterType.KRecruitTen,
		node = self._resultMain,
		preConfig = function()
			return
		end,
		endConfig = function()
			return
		end
	}

	DmGame:getInstance()._injector:getInstance(ShareSystem):addShare(data)
end

function RecruitMainMediator:initResultView()
	self._resultMain:removeAllChildren()
	self._resultMain:setVisible(false)

	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()
	local showBtnsPanel = true

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip or cardType == RecruitPoolType.kActivityUREquip or cardType == RecruitPoolType.kDiamond or cardType == RecruitPoolType.kActivity then
		local itemResult = cc.CSLoader:createNode("asset/ui/RecruitHeroResult.csb")

		itemResult:addTo(self._resultMain):center(self._resultMain:getContentSize())

		self._itemResult = itemResult:getChildByFullName("diamondResult")

		self._itemResult:setSwallowTouches(false)
		self._itemResult:getChildByFullName("touchLayer"):setVisible(true)

		self._bg = self._itemResult:getChildByFullName("bg")
		self._cloneNode = self._itemResult:getChildByFullName("cloneNode")

		self._cloneNode:setVisible(false)

		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")
		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		self._btnsPanel:setLocalZOrder(100)

		local rebuyBtn = self._itemResult:getChildByFullName("buttons_panel.rebuy_btn")
		local sureBtn = self._itemResult:getChildByFullName("buttons_panel.sure_btn")

		self._rebuyBtn = self:bindWidget(rebuyBtn, OneLevelViceButton, {
			ignoreAddKerning = true,
			handler = {
				clickAudio = "Se_Click_Common_1",
				func = bind1(self.onClickRebuy, self)
			}
		})
		self._sureBtn = self:bindWidget(sureBtn, OneLevelMainButton, {
			handler = {
				clickAudio = "Se_Click_Common_1",
				func = bind1(self.onClickClose, self)
			}
		})
		self._costIconNode = self._btnsPanel:getChildByFullName("rebuy_btn.cost_icon")
		self._costText = self._btnsPanel:getChildByFullName("rebuy_btn.cost_text")
		self._descText = self._itemResult:getChildByFullName("desc_text")

		self._descText:setVisible(cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip or cardType == RecruitPoolType.kActivityUREquip or cardType == RecruitPoolType.kActivity or cardType == RecruitPoolType.kDiamond)

		if self._refreshTabBtn then
			sureBtn:setPositionX(260)
			rebuyBtn:setVisible(false)
		else
			sureBtn:setPositionX(108)
			rebuyBtn:setVisible(true)
		end
	else
		showBtnsPanel = false

		local itemResult = cc.CSLoader:createNode("asset/ui/RecruitHeroResult.csb")

		itemResult:addTo(self._resultMain):center(self._resultMain:getContentSize())

		self._itemResult = itemResult:getChildByFullName("diamondResult")
		self._descText = self._itemResult:getChildByFullName("desc_text")

		GameStyle:setCommonOutlineEffect(self._descText, 219.29999999999998)

		self._bg = self._itemResult:getChildByFullName("bg")

		self._bg:removeAllChildren()
		self._itemResult:setSwallowTouches(false)
		self._itemResult:getChildByFullName("touchLayer"):addClickEventListener(function()
			if self._canClose then
				self:onClickClose()
			end
		end)

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")
		self._cloneNode = self._itemResult:getChildByFullName("cloneNode")

		self._cloneNode:setVisible(false)
	end

	self._showResult = self._showResult or function(videoSprite)
		self._touchLayer:setVisible(false)

		if self._animSkip and #self._heroesArr > 0 then
			local heroes = {}

			for i = 1, #self._heroesArr do
				local data = self._heroesArr[i]

				if data.newHero or data.rarity == 14 then
					table.insert(heroes, data)
				end
			end

			self._heroesArr = heroes
		end

		if #self._heroesArr == 0 then
			self._resultMain:setVisible(true)
			self:showResultAnim(showBtnsPanel)
		else
			self._resultMain:setVisible(false)
			self:showNewHeroView(self._heroesArr)
		end
	end

	local hideAnim = (cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip or cardType == RecruitPoolType.kActivityUREquip) and self._realRecruitTimes == 1 or HIDE_RECRUIT_ANIM

	if self._hideAnim then
		hideAnim = self._hideAnim
		self._animSkip = true
	end

	if not hideAnim then
		self._soundId = AudioEngine:getInstance():playEffect("Se_Effect_Card", false)

		self._videoSprite:setVisible(true)
		self._videoSprite:getPlayer():pause(false)
		self._recruitSkip:setVisible(true)

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]
			local recruitRewardType = self:checkRewardType(rewardData)
			local heroId

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				heroId = itemConfig.TargetId.id
			elseif recruitRewardType == RecruitRewardType.kHero then
				heroId = rewardData.code
			end

			if heroId then
				local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
				local rarity = heroConfig.Rareity

				self._bestRarity = math.max(self._bestRarity, rarity)
			end
		end

		local frame = ResultAnimOfRarity[self._bestRarity][1]
		local callback = ResultAnimOfRarity[self._bestRarity][2]

		self._videoSprite:addFrameEvent(callback, frame)
	end

	if self._realRecruitTimes == 1 then
		self:showOneAnim()
	else
		self:showTenAnim()
	end

	if hideAnim then
		self._showResult()

		self._showResult = nil
	end

	self._hideAnim = false
end

function RecruitMainMediator:refreshBg(heroId)
	local party = ConfigReader:getDataByNameIdAndKey("HeroBase", heroId, "Party")

	if not party then
		local partys = {
			GalleryPartyType.kBSNCT,
			GalleryPartyType.kXD,
			GalleryPartyType.kMNJH,
			GalleryPartyType.kDWH,
			GalleryPartyType.kWNSXJ,
			GalleryPartyType.kSSZS,
			GalleryPartyType.kUNKNOWN
		}
		local num = math.random(1, 6)

		party = partys[num]
	end

	local bgPanel = self._bg

	bgPanel:removeAllChildren()

	local bgAnim = GameStyle:getHeroPartyBg(party)

	bgAnim:addTo(bgPanel):center(bgPanel:getContentSize())
	bgPanel:setScale(1.2)
	bgPanel:runAction(cc.ScaleTo:create(0.2, 1))
end

function RecruitMainMediator:showResultAnim(showBtnsPanel)
	local cardType = self._recruitDataShow:getType()
	local showBtnsPanel = showBtnsPanel
	local length = #self._showAnimNodes

	self._btnsPanel:setVisible(false)
	self._btnsPanel:setOpacity(0)
	self._btnsPanel:setVisible(showBtnsPanel)

	if length == 1 then
		local showAnim = table.remove(self._showAnimNodes, 1)

		if showAnim.tag ~= "HERO" then
			showAnim:setVisible(true)
			showAnim.nameText:fadeIn({
				time = 0.1
			})

			if showAnim.icon.ignoreMoveAction then
				if showAnim.tag == "EQUIP" then
					showAnim.icon:getChildByFullName("EquipAnim"):gotoAndPlay(0)
					showAnim.icon:setPositionY(-40)
				end
			else
				showAnim.icon:runAction(cc.MoveTo:create(0.1, cc.p(0, -40)))
			end
		else
			showAnim:gotoAndPlay(0)
		end

		self._canClose = true

		self._btnsPanel:setVisible(showBtnsPanel)
		self._btnsPanel:fadeIn({
			time = 0.2
		})
	else
		for i = 1, length + 1 do
			local time = 0.06666666666666667
			local delay = cc.DelayTime:create(time * (i - 1))
			local showAnim = table.remove(self._showAnimNodes, 1)

			if showAnim then
				showAnim:setVisible(false)

				local callback = cc.CallFunc:create(function()
					if showAnim.tag ~= "HERO" then
						showAnim:setVisible(true)
						showAnim.nameText:fadeIn({
							time = 0.1
						})

						if showAnim.icon.ignoreMoveAction then
							if showAnim.tag == "EQUIP" then
								showAnim.icon:getChildByFullName("EquipAnim"):gotoAndPlay(0)
								showAnim.icon:setPositionY(-40)
							end
						else
							showAnim.icon:runAction(cc.MoveTo:create(0.1, cc.p(0, -40)))
						end
					else
						showAnim:addCallbackAtFrame(13, function()
							if i >= 6 then
								showAnim:setLocalZOrder(1)
							end
						end)
						showAnim:setVisible(true)
						showAnim:gotoAndPlay(0)
					end
				end)

				self:getView():runAction(cc.Sequence:create(delay, callback))
			else
				delay = cc.DelayTime:create(time * (2 + i))

				local callback = cc.CallFunc:create(function()
					self._canClose = true

					self._btnsPanel:setVisible(showBtnsPanel)
					self._btnsPanel:fadeIn({
						time = 0.2
					})
				end)

				self:getView():runAction(cc.Sequence:create(delay, callback))
			end
		end

		if not showBtnsPanel then
			local callback = cc.CallFunc:create(function()
				self:addShare()
			end)

			self:getView():runAction(cc.Sequence:create(cc.DelayTime:create(0.8), callback))
		end
	end
end

function RecruitMainMediator:checkRewardType(reward)
	local recruitRewardType

	return reward.type == 3 and RecruitRewardType.kHero or reward.type == 2 and reward.heroId and RecruitRewardType.kHeroConvert or RecruitRewardType.kPieceOrItem
end

function RecruitMainMediator:showOneAnim()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kDiamond or cardType == RecruitPoolType.kActivity or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp then
		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")

		self._itemPanel:removeAllChildren()

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		self._btnsPanel:setVisible(true)
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		local heroId
		local rewardData = self._rewards[1]

		if rewardData then
			local recruitRewardType = self:checkRewardType(rewardData)
			local data

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				data = {
					newHero = false,
					heroId = itemConfig.TargetId.id,
					fragmentCount = rewardData.amount
				}
			elseif recruitRewardType == RecruitRewardType.kHero then
				local itemId = rewardData.code

				data = {
					newHero = true,
					heroId = itemId
				}
			end

			if data then
				heroId = data.heroId

				self:createRewardHero(data, cc.p(350, 200), nil, rewardData)
				self:refreshBg(heroId)
			else
				self:createRewardItem(self._rewards[1], cc.p(350, 170), kItemScale[15])
				self:refreshBg()
			end
		end
	elseif cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip or cardType == RecruitPoolType.kActivityUREquip then
		self._itemPanel = self._itemResult:getChildByFullName("itemPanel")

		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)

		self._btnsPanel = self._itemResult:getChildByFullName("buttons_panel")

		self._btnsPanel:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()
		self:createRewardItem(self._rewards[1], cc.p(350, 170), kItemScale[15])
		self:refreshBg()
	else
		self:refreshExtraRewardDesc()
		self._itemResult:getChildByFullName("itemPanel"):removeAllChildren()
		self._itemResult:setVisible(true)

		local heroId
		local rewardData = self._rewards[1]

		if rewardData then
			local recruitRewardType = self:checkRewardType(rewardData)
			local data

			if recruitRewardType == RecruitRewardType.kHeroConvert then
				local itemId = rewardData.code
				local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

				data = {
					newHero = false,
					heroId = itemConfig.TargetId.id,
					fragmentCount = rewardData.amount
				}
			elseif recruitRewardType == RecruitRewardType.kHero then
				local itemId = rewardData.code

				data = {
					newHero = true,
					heroId = itemId
				}
			end

			if data then
				heroId = data.heroId

				self:createRewardHero(data, cc.p(350, 170), nil, rewardData)
			end
		end

		self:refreshBg(heroId)
	end
end

function RecruitMainMediator:showTenAnim()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()

	if cardType == RecruitPoolType.kGold or cardType == RecruitPoolType.kClub or cardType == RecruitPoolType.kDiamond or cardType == RecruitPoolType.kPve or cardType == RecruitPoolType.kPvp or cardType == RecruitPoolType.kActivity then
		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		local itemArr = {}
		local changePos = false
		local heroId, rarity

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]

			if rewardData then
				local recruitRewardType = self:checkRewardType(rewardData)
				local data

				if recruitRewardType == RecruitRewardType.kHeroConvert then
					local itemId = rewardData.code
					local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

					data = {
						newHero = false,
						heroId = itemConfig.TargetId.id,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
						fragmentCount = rewardData.amount
					}
				elseif recruitRewardType == RecruitRewardType.kHero then
					local itemId = rewardData.code

					data = {
						newHero = true,
						heroId = itemId,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
					}
				end

				if data then
					if not rarity then
						heroId = data.heroId
						rarity = data.rarity
					elseif rarity < data.rarity then
						heroId = data.heroId
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
					end

					changePos = true
					itemArr[#itemArr + 1] = self:createRewardHero(data, ItemsPosition2[i], true, rewardData, 0.5)
				else
					itemArr[#itemArr + 1] = self:createRewardItem(rewardData, ItemsPosition2[i], kItemScale[13])
				end
			end
		end

		if changePos then
			for i = 1, #itemArr do
				itemArr[i]:setPosition(ItemsPosition3[i])
			end
		end

		self:refreshBg(heroId)
	elseif cardType == RecruitPoolType.kEquip or cardType == RecruitPoolType.kActivityEquip or cardType == RecruitPoolType.kActivityUREquip then
		self._itemPanel:removeAllChildren()
		self._itemResult:setVisible(true)
		self:setButtonAndDesc()
		self:setupCostView()

		for i = 1, #self._rewards do
			local rewardData = self._rewards[i]
			local item = self:createRewardItem(rewardData, ItemsPosition5[i])

			if i <= 5 then
				item:setLocalZOrder(2)
			else
				item:setLocalZOrder(1)
			end
		end

		self:refreshBg()
	else
		self:refreshExtraRewardDesc()
		self._itemResult:getChildByFullName("itemPanel"):removeAllChildren()
		self._itemResult:setVisible(true)

		local cloneNode = self._itemResult:getChildByFullName("cloneNode")

		cloneNode:setVisible(false)

		local heroId, rarity
		local length = math.min(#self._rewards, 10)

		for i = 1, length do
			local rewardData = self._rewards[i]

			if rewardData then
				local recruitRewardType = self:checkRewardType(rewardData)
				local data

				if recruitRewardType == RecruitRewardType.kHeroConvert then
					local itemId = rewardData.code
					local itemConfig = ConfigReader:getRecordById("ItemConfig", itemId)

					data = {
						newHero = false,
						heroId = itemConfig.TargetId.id,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemConfig.TargetId.id, "Rareity"),
						fragmentCount = rewardData.amount
					}
				elseif recruitRewardType == RecruitRewardType.kHero then
					local itemId = rewardData.code

					data = {
						newHero = true,
						heroId = itemId,
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", itemId, "Rareity")
					}
				end

				if data then
					if not rarity then
						heroId = data.heroId
						rarity = data.rarity
					elseif rarity < data.rarity then
						heroId = data.heroId
						rarity = ConfigReader:getDataByNameIdAndKey("HeroBase", data.heroId, "Rareity")
					end

					self:createRewardHero(data, cc.p(ItemsPosition4[i].x, ItemsPosition4[i].y), true, rewardData)
				end
			end
		end

		self:refreshBg(heroId)
	end
end

function RecruitMainMediator:createRewardItem(reward, pos, scale)
	local resFile = "asset/ui/RecruitItemNode.csb"
	local node = cc.CSLoader:createNode(resFile)
	local itemIconNode = node:getChildByFullName("icon_node")
	local nameText = node:getChildByFullName("name_text")

	nameText:setString(RewardSystem:getName(reward))
	nameText:setOpacity(0)

	node.nameText = nameText

	if reward.type == RewardType.kEquip then
		local config = ConfigReader:getRecordById("HeroEquipBase", reward.code)
		local rarity = config.Rareity
		local info = RewardSystem:parseInfo(reward)
		local icon = ccui.Widget:create()

		icon:setContentSize(cc.size(110, 110))

		local anim = cc.MovieClip:create(kEquipRarityAnim[rarity])

		anim:addEndCallback(function()
			anim:stop()
		end)
		anim:addTo(icon):center(icon:getContentSize())
		anim:setName("EquipAnim")

		local equipNode = anim:getChildByFullName("equipNode")

		if equipNode then
			anim:offset(12, 30)

			local iconNode1 = equipNode:getChildByFullName("icon")
			local iconNode2 = equipNode:getChildByFullName("iconNode")
			local bgFile = GameStyle:getEquipRarityRectFile(rarity)
			local bgImage = IconFactory:createSprite(bgFile)

			bgImage:addTo(iconNode2)

			local equipIcon = IconFactory:createRewardEquipIcon(info, {
				hideLevel = true,
				notShowQulity = true
			})

			equipIcon:addTo(iconNode1):posite(-3.5, -1.5)

			icon.ignoreMoveAction = true
		else
			local iconNode1 = anim:getChildByFullName("iconNode")
			local equipIcon = IconFactory:createRewardEquipIcon(info, {
				hideLevel = true
			})

			equipIcon:addTo(iconNode1)
		end

		icon:addTo(itemIconNode)
		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			swallowTouches = true,
			needDelay = true
		})
		GameStyle:setRarityText(nameText, rarity)
		icon:setAnchorPoint(cc.p(0.5, 0))
		icon:setPositionY(40)

		if not scale then
			icon:setScale(kItemScale[rarity])
		else
			icon:setScale(scale)
		end

		node.icon = icon
		node.tag = "EQUIP"

		table.insert(self._showAnimNodes, node)
	else
		local icon = IconFactory:createRewardIcon(reward, {
			isWidget = true
		})

		icon:setContentSize(cc.size(110, 110))
		GameStyle:setQualityText(nameText, RewardSystem:getQuality(reward))
		icon:setAnchorPoint(cc.p(0.5, 0))

		node.icon = icon
		icon.ignoreMoveAction = true

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), reward, {
			swallowTouches = true,
			needDelay = true
		})

		if RewardSystem:checkIsComposeItem(reward) then
			local iconNode = ccui.Widget:create()

			iconNode:setContentSize(cc.size(110, 110))
			iconNode:setScale(1.3)

			local anim = cc.MovieClip:create(kEquipRarityAnim[15])

			anim:addEndCallback(function()
				anim:stop()
			end)
			anim:addTo(iconNode, -1):center(iconNode:getContentSize())
			anim:offset(9, -3)

			local equipNode = anim:getChildByFullName("equipNode")
			local iconNode1 = equipNode:getChildByFullName("icon")

			icon:addTo(iconNode1):setPositionY(-55)
			iconNode:addTo(itemIconNode)
			iconNode:setAnchorPoint(cc.p(0.5, 0))
			iconNode:setPositionY(0)
		else
			icon:addTo(itemIconNode)
			icon:setPositionY(-40)
		end

		local scale = scale or 1

		icon:setScale(scale)

		node.tag = "ITEM"

		table.insert(self._showAnimNodes, node)
	end

	node:setVisible(false)
	node:addTo(self._itemResult:getChildByFullName("itemPanel"))
	node:setPosition(pos)
	node:setLocalZOrder(2)

	return node
end

function RecruitMainMediator:createRewardHero(data, pos, adjustZoom, rewardData, scale)
	table.insert(self._heroesArr, data)

	local heroId = data.heroId
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local showAnim = cc.MovieClip:create("show_choukajieguokapai")

	showAnim:addTo(self._itemResult:getChildByFullName("itemPanel"))
	showAnim:setPosition(pos)
	showAnim:setLocalZOrder(2)
	showAnim:addEndCallback(function()
		showAnim:stop()
	end)
	showAnim:setPlaySpeed(1.5)

	showAnim.tag = "HERO"

	table.insert(self._showAnimNodes, showAnim)

	local node1 = showAnim:getChildByFullName("node_1")
	local node2 = showAnim:getChildByFullName("node_2")
	local node = self._cloneNode:clone()

	node:setVisible(true)
	node:setScale(1)

	local rarityAnimName = kRoleRarityAnim[heroConfig.Rareity][1]
	local zoom = scale or kRoleRarityAnim[heroConfig.Rareity][2]
	local newImage = kRoleRarityAnim[heroConfig.Rareity][3]
	local anim = cc.MovieClip:create(rarityAnimName)

	anim:addTo(node:getChildByFullName("bg")):center(node:getChildByFullName("bg"):getContentSize()):offset(-3, 88)

	if adjustZoom then
		node:setScale(zoom)
	end

	local nameBg = node:getChildByFullName("nameBg")

	nameBg:loadTexture(kRoleRarityNameBg[heroConfig.Rareity])

	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local roleAnim = anim:getChildByFullName("roleAnim")
	local roleNode = roleAnim:getChildByFullName("roleNode")
	local realImage = IconFactory:createRoleIconSpriteNew({
		frameId = "bustframe7_1",
		id = roleModel
	})

	realImage:addTo(roleNode)

	local starPanel = node:getChildByFullName("starPanel")

	for i = 1, 3 do
		local starIcon = starPanel:getChildByFullName("star" .. i)

		starIcon:setVisible(i <= heroConfig.BaseStar)
	end

	starPanel:setContentSize(cc.size(32 * heroConfig.BaseStar, 67))

	local name = node:getChildByFullName("name")

	name:setString(Strings:get(heroConfig.Name))

	local rarityNode = node:getChildByFullName("rarity")

	rarityNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rarityNode:ignoreContentAdaptWithSize(true)

	local occupationNode = node:getChildByFullName("occupation")
	local occupationName, occupationImg = GameStyle:getHeroOccupation(heroConfig.Type)

	occupationNode:loadTexture(occupationImg)

	local newHero = data.newHero
	local tipImage = node:getChildByFullName("new")

	tipImage:setVisible(newHero)

	local debrisPanel = node:getChildByFullName("debrisPanel")

	debrisPanel:setVisible(not newHero)

	if debrisPanel:isVisible() then
		local text = debrisPanel:getChildByFullName("text")

		text:setString(rewardData.amount)

		local num = DrawCardStiveExReward[tostring(heroConfig.Rareity)]

		if num then
			local rewardNum = debrisPanel:getChildByFullName("rewardNum")

			rewardNum:removeAllChildren()

			num = num * rewardData.amount

			rewardNum:setString(num)

			local icon = IconFactory:createPic({
				id = DrawCardStiveExReward.reward
			})

			icon:addTo(rewardNum):posite(-30, 15):setScale(1.7)
			rewardNum:setPositionX(text:getPositionX() + text:getContentSize().width / 2)
		end
	else
		tipImage:loadTexture(newImage, 1)
	end

	if node1 then
		node:addTo(node1):posite(0, 0)
	end

	if node2 then
		local node3 = node:clone()

		node3:addTo(node2):posite(0, 0)
	end

	return showAnim
end

function RecruitMainMediator:setButtonAndDesc()
	local str = Strings:get("RecruitGoldResult_Text2", {
		recuritTimes = self._recruitPool:getRecruitTimes()[self._recruitIndex]
	})

	self._rebuyBtn:setButtonName(str)
	self:refreshExtraRewardDesc()
end

function RecruitMainMediator:refreshExtraRewardDesc()
	local normalReward = self._recruitPool:getNormalReward()

	if not normalReward or #normalReward <= 0 then
		self._descText:setVisible(false)

		return
	end

	local normalItemName = RewardSystem:getName(normalReward[1])
	local amount = normalReward[1].amount
	local str = ""

	if #self._extraRewards > 0 then
		local at = 0

		for i = 1, #self._extraRewards do
			at = at + self._extraRewards[i].amount
		end

		local reward = self._extraRewards[1]
		local itemName1 = RewardSystem:getName(reward)

		str = Strings:get("RecruitGoldResult_Text4", {
			itemName = normalItemName,
			itemCount = amount * self._realRecruitTimes,
			itemName1 = itemName1,
			itemCount1 = at
		})
	else
		str = Strings:get("RecruitGoldResult_Text3", {
			itemName = normalItemName,
			itemCount = amount * self._realRecruitTimes
		})
	end

	self._descText:setString(str)

	if self._descText:getChildByFullName("image") then
		self._descText:getChildByFullName("image"):setPositionX(self._descText:getContentSize().width / 2)
	end
end

function RecruitMainMediator:showNewHeroView(heroArr, animFrame)
	if DisposableObject:isDisposed(self) then
		return
	end

	if #heroArr > 0 then
		local data = table.remove(heroArr, 1)
		local id = data.heroId
		local newHero = data.newHero

		if id then
			local function callback()
				self:showNewHeroView(heroArr, 5)
			end

			local view = self:getInjector():getInstance("newHeroView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				heroId = id,
				callback = callback,
				newHero = newHero,
				animFrame = animFrame,
				fragmentCount = data.fragmentCount
			}))
		end
	else
		self._resultMain:setVisible(true)
		self:showResultAnim(true)
	end
end

function RecruitMainMediator:updateResultView(event)
	return
end

function RecruitMainMediator:setupCostView()
	local costCount = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex]
	local time = self._recruitPool:getRecruitTimes()[self._recruitIndex]

	if time ~= 1 then
		costCount = self._recruitSystem:getRecruitRealCost(self._recruitPool, costCount, time)
	end

	local costId = costCount.costId
	local count = costCount.costCount

	if count == 0 then
		self._costIconNode:setVisible(false)
		self._costText:setString(Strings:get("Recruit_Free"))
		self._costText:setPositionX(0)
	else
		local text = "x" .. count

		self._costIconNode:setVisible(true)

		local costIcon = self._costIconNode:getChildByFullName("icon_img")

		if costIcon then
			costIcon:removeFromParent()
		end

		costIcon = IconFactory:createPic({
			id = costId
		}, {
			largeIcon = true
		})

		costIcon:setScale(0.46)
		costIcon:addTo(self._costIconNode):setName("icon_img")
		self._costText:setPositionX(20)
		self._costText:setString(text)
		self._costIconNode:setPositionX(-self._costText:getContentSize().width / 2 - 5)
	end
end

function RecruitMainMediator:createHeroNode(heroInfo, recruitRewardType, type)
	local resFile = "asset/ui/RecruitHeroNode.csb"
	local node = cc.CSLoader:createNode(resFile)
	local rareNode = node:getChildByName("rare_icon")
	local roleNode = node:getChildByName("role_node")
	local newImage = node:getChildByFullName("newImage")

	newImage:setVisible(false)

	local covertDescText = node:getChildByFullName("covert_desc")

	covertDescText:setVisible(false)

	local heroId = heroInfo.heroId
	local heroConfig = ConfigReader:getRecordById("HeroBase", heroId)
	local roleModel = IconFactory:getRoleModelByKey("HeroBase", heroId)
	local heroAnim = RoleFactory:createHeroAnimation(roleModel)

	heroAnim:setAnchorPoint(cc.p(0.5, 0))
	heroAnim:addTo(roleNode)
	heroAnim:setScale(0.6)
	heroAnim:setPosition(cc.p(roleNode:getContentSize().width / 2, 40))
	rareNode:loadTexture(GameStyle:getHeroRarityImage(heroConfig.Rareity), 1)
	rareNode:ignoreContentAdaptWithSize(true)
	rareNode:setScale(0.8)

	if recruitRewardType == RecruitRewardType.kHero then
		newImage:setVisible(true)
	elseif recruitRewardType == RecruitRewardType.kHeroConvert then
		local amount = heroInfo.amount

		covertDescText:setVisible(true)
		covertDescText:getChildByName("text"):setString(amount)
	end

	return node
end

function RecruitMainMediator:onClickClose(sender, eventType)
	self:getView():stopAllActions()

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)

	storyDirector:notifyWaiting("exit_recruitHeroDiamondResul_view")
	self._resultMain:removeAllChildren()
	self._resultMain:setVisible(false)

	local type = self._recruitDataShow:getType()

	if type == RecruitPoolType.kDiamond then
		local costId = self._recruitDataShow:getRealCostIdAndCount()[self._recruitIndex].costId
		local bagSystem = self._developSystem:getBagSystem()
		local count = bagSystem:getItemCount(costId)

		if count <= 0 then
			self._developSystem:requstNotEnoughItem("DRAW", costId)
		end
	end
end

function RecruitMainMediator:onClickRebuy(sender, eventType)
	if not self._canClose then
		return
	end

	self._hideAnim = true

	local times = self._recruitPool:getRecruitTimes()[self._recruitIndex]
	local hasLimit = self:checkHasTimesLimit(self._recruitPool, times)

	if hasLimit then
		return
	end

	local costId = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex].costId
	local costCount = self._recruitPool:getRealCostIdAndCount()[self._recruitIndex].costCount
	local bagSystem = self:getInjector():getInstance("DevelopSystem"):getBagSystem()
	local id = self._recruitPool:getId()
	local cardType = self._recruitPool:getType()
	local param = {
		id = id,
		times = times
	}

	if bagSystem:checkCostEnough(costId, costCount) then
		self._recruitSystem:requestRecruit(param)
	elseif costId == CurrencyIdKind.kDiamondDrawItem then
		self:buyCard(costId, costCount, param)
	else
		self._resultMain:removeAllChildren()
		self._resultMain:setVisible(false)
	end
end
