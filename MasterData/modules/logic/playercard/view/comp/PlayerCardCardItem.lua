-- chunkname: @modules/logic/playercard/view/comp/PlayerCardCardItem.lua

module("modules.logic.playercard.view.comp.PlayerCardCardItem", package.seeall)

local PlayerCardCardItem = class("PlayerCardCardItem", ListScrollCell)

function PlayerCardCardItem:ctor(param)
	PlayerCardCardItem.super.ctor(self)

	self.compType = param and param.compType
	self.cardIndex = param and param.index
end

function PlayerCardCardItem:init(go)
	self.viewGO = go
	self.imageBg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self.goEmpty = gohelper.findChild(self.viewGO, "empty")
	self.goEmptyAdd = gohelper.findChild(self.goEmpty, "#btn_add")
	self.goEmptyImg = gohelper.findChild(self.goEmpty, "img_empty")
	self.goNormal = gohelper.findChild(self.viewGO, "normal")
	self.txtCardName = gohelper.findChildTextMesh(self.goNormal, "#txt_cardname")
	self.txtEnName = gohelper.findChildTextMesh(self.goNormal, "#txt_en")
	self.txtDesc = gohelper.findChildTextMesh(self.goNormal, "#txt_dec")
	self.goNormalChange = gohelper.findChild(self.goNormal, "#btn_change")
	self.goSelect = gohelper.findChild(self.viewGO, "select")
	self.txtIndex = gohelper.findChildTextMesh(self.goSelect, "#txt_order")
	self.btnChange = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_change")
	self.goSelectedEff = gohelper.findChild(self.viewGO, "selected_eff")

	self:initCard()
	self:setVisible(true)
end

function PlayerCardCardItem:setVisible(isVisible)
	if self.isVisible == isVisible then
		return
	end

	self.isVisible = isVisible

	gohelper.setActive(self.viewGO, isVisible)
end

function PlayerCardCardItem:playSelelctEffect()
	gohelper.setActive(self.goSelectedEff, false)
	gohelper.setActive(self.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function PlayerCardCardItem:initCard()
	for k, v in pairs(PlayerCardEnum.CardKey) do
		local funcName = string.format("_initCard" .. v)
		local func = self[funcName]

		if func then
			func(self)
		end
	end
end

function PlayerCardCardItem:_initCard3()
	self.goRole = gohelper.findChild(self.goNormal, "#go_role")
	self._collectionFulls = self:getUserDataTb_()

	for i = 1, 5 do
		self._collectionFulls[i] = gohelper.findChildImage(self.goRole, string.format("collection/collection%s/#image_full", i))
	end
end

function PlayerCardCardItem:_initCard4()
	self.goRoom = gohelper.findChild(self.goNormal, "#go_room")
	self.txtLand = gohelper.findChildTextMesh(self.goRoom, "#txt_num1")
	self.txtBuilding = gohelper.findChildTextMesh(self.goRoom, "#txt_num2")
end

function PlayerCardCardItem:_initCard6()
	self.goExplore = gohelper.findChild(self.goNormal, "#go_explore")
	self.exportItem = {}

	for i = 1, 3 do
		local item = self:getUserDataTb_()

		item.txtExplore = gohelper.findChildTextMesh(self.goExplore, "#txt_num" .. tostring(i))
		item.image = gohelper.findChildImage(self.goExplore, string.format("#txt_num%s/icon", i))
		self.exportItem[i] = item
	end
end

function PlayerCardCardItem:refreshView(info, config)
	if self.notIsFirst and self.cardConfig ~= config then
		self:playSelelctEffect()
	end

	self.notIsFirst = true
	self.cardInfo = info
	self.cardConfig = config

	if self.cardConfig then
		UISpriteSetMgr.instance:setPlayerInfoSprite(self.imageBg, "player_card_" .. config.id, true)
		gohelper.setActive(self.goEmpty, false)
		gohelper.setActive(self.goNormal, true)

		local canChange = self:isPlayerSelf() and self.compType == PlayerCardEnum.CompType.Normal and self.cardIndex == 4

		gohelper.setActive(self.goNormalChange, canChange)

		self.txtCardName.text = config.name
		self.txtEnName.text = config.nameEn

		self:refreshCard()
	else
		gohelper.setActive(self.goEmpty, true)
		gohelper.setActive(self.goNormal, false)

		local canAdd = self:isPlayerSelf() and self.compType == PlayerCardEnum.CompType.Normal

		gohelper.setActive(self.goEmptyAdd, canAdd)
		gohelper.setActive(self.goEmptyImg, not canAdd)
		UISpriteSetMgr.instance:setPlayerInfoSprite(self.imageBg, "player_card_0", true)
	end
end

function PlayerCardCardItem:onUpdateMO(mo)
	self:refreshView(mo.info, mo.config)

	local index = PlayerCardProgressModel.instance:getSelectIndex(mo.id)

	if index then
		gohelper.setActive(self.goSelect, true)

		self.txtIndex.text = tostring(index)
	else
		gohelper.setActive(self.goSelect, false)
	end
end

function PlayerCardCardItem:getConfig()
	return self.cardConfig
end

function PlayerCardCardItem:isPlayerSelf()
	return self.cardInfo and self.cardInfo:isSelf()
end

function PlayerCardCardItem:getPlayerInfo()
	return self.cardInfo and self.cardInfo:getPlayerInfo()
end

function PlayerCardCardItem:refreshCard()
	self:resetCard()

	local funcName = string.format("_refreshCard" .. self.cardConfig.id)
	local func = self[funcName]

	if func then
		func(self)
	end
end

function PlayerCardCardItem:resetCard()
	gohelper.setActive(self.goRole, false)
	gohelper.setActive(self.goRoom, false)
	gohelper.setActive(self.goExplore, false)

	self.txtDesc.text = ""
end

function PlayerCardCardItem:_refreshCard1()
	local info = self:getPlayerInfo()

	self.txtDesc.text = TimeUtil.timestampToString3(ServerTime.timeInLocal(info.registerTime / 1000))
end

function PlayerCardCardItem:_refreshCard2()
	local info = self:getPlayerInfo()

	self.txtDesc.text = formatLuaLang("cachotprogressview_remainDay", info.totalLoginDays)
end

function PlayerCardCardItem:_refreshCard3()
	gohelper.setActive(self.goRole, true)

	local info = self:getPlayerInfo()
	local AllRareNNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local AllRareNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local AllRareRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local AllRareSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local AllRareSSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)

	if AllRareNNHeroCount > 0 then
		local heroRareNNPercent = math.min(info.heroRareNNCount / AllRareNNHeroCount or 1, 1)

		if AllRareNHeroCount > 0 then
			local heroRareNPercent = math.min(info.heroRareNCount / AllRareNHeroCount or 1, 1)

			if AllRareRHeroCount > 0 then
				local heroRareRPercent = math.min(info.heroRareRCount / AllRareRHeroCount or 1, 1)

				if AllRareSRHeroCount > 0 then
					local heroRareSRPercent = math.min(info.heroRareSRCount / AllRareSRHeroCount or 1, 1)

					if AllRareSSRHeroCount > 0 then
						self._collectionFulls[1].fillAmount = heroRareNNPercent
						self._collectionFulls[2].fillAmount = heroRareNPercent
						self._collectionFulls[3].fillAmount = heroRareRPercent
						self._collectionFulls[4].fillAmount = heroRareSRPercent
						self._collectionFulls[5].fillAmount = math.min(info.heroRareSSRCount / AllRareSSRHeroCount or 1, 1)
					end
				end
			end
		end
	end
end

function PlayerCardCardItem:_refreshCard4()
	gohelper.setActive(self.goRoom, true)

	local roomCollection = self.cardInfo.roomCollection
	local arr = string.splitToNumber(roomCollection, "#")
	local landNum = arr and arr[1]

	self.txtLand.text = landNum and landNum or PlayerCardEnum.EmptyString

	local buildingNum = arr and arr[2]

	self.txtBuilding.text = buildingNum and buildingNum or PlayerCardEnum.EmptyString
end

function PlayerCardCardItem:_refreshCard5()
	local layerId = self.cardInfo.weekwalkDeepLayerId

	if layerId == -1 then
		self.txtDesc.text = PlayerCardEnum.EmptyString2
	else
		local mapConfig = WeekWalkConfig.instance:getMapConfig(layerId)
		local sceneConfig = lua_weekwalk_scene.configDict[mapConfig and mapConfig.sceneId]

		self.txtDesc.text = sceneConfig and sceneConfig.battleName or PlayerCardEnum.EmptyString2
	end
end

function PlayerCardCardItem:_refreshCard6()
	gohelper.setActive(self.goExplore, true)

	local exploreCollection = self.cardInfo.exploreCollection
	local arr = GameUtil.splitString2(exploreCollection, true) or {}

	self:_refreshExportItem(1, arr[3], "dungeon_secretroom_btn_triangle")
	self:_refreshExportItem(2, arr[2], "dungeon_secretroom_btn_sandglass")
	self:_refreshExportItem(3, arr[1], "dungeon_secretroom_btn_box")
end

function PlayerCardCardItem:_refreshCard7()
	local rougeDifficulty = self.cardInfo.rougeDifficulty

	self.txtDesc.text = rougeDifficulty == -1 and PlayerCardEnum.EmptyString2 or formatLuaLang("playercard_rougedesc", rougeDifficulty)
end

function PlayerCardCardItem:_refreshCard8()
	local act128SSSCount = self.cardInfo.act128SSSCount

	self.txtDesc.text = act128SSSCount == -1 and PlayerCardEnum.EmptyString2 or formatLuaLang("times2", act128SSSCount)
end

function PlayerCardCardItem:_refreshExportItem(index, data, imageKey)
	local num = data and data[1]
	local fullNum = data and data[2]
	local item = self.exportItem[index]

	item.txtExplore.text = num and num or PlayerCardEnum.EmptyString

	local isFull = num and fullNum and fullNum <= num

	if isFull then
		UISpriteSetMgr.instance:setExploreSprite(item.image, imageKey .. "1", true)
	else
		UISpriteSetMgr.instance:setExploreSprite(item.image, imageKey .. "2", true)
	end
end

function PlayerCardCardItem:addEventListeners()
	self.btnChange:AddClickListener(self.btnChangeOnClick, self)
end

function PlayerCardCardItem:removeEventListeners()
	self.btnChange:RemoveClickListener()
end

function PlayerCardCardItem:btnChangeOnClick()
	if not self:isPlayerSelf() then
		return
	end

	if self.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.PlayerCardShowView)
	elseif self.cardConfig then
		PlayerCardProgressModel.instance:clickItem(self.cardConfig.id)
	end
end

function PlayerCardCardItem:onDestroy()
	return
end

return PlayerCardCardItem
