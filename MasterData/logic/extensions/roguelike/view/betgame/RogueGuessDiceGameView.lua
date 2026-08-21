-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/betgame/RogueGuessDiceGameView.lua

module("logic.extensions.roguelike.view.betgame.RogueGuessDiceGameView", package.seeall)

local PATTERN = RoguelikeConst.DICE_PATTERN
local DiceRewardItem = class("DiceRewardItem")

function DiceRewardItem:ctor(go)
	self._go = go
	self._btn = UIComponentType.ButtonAdapter(goutil.findChild(go, "click"))
	self._goCanTake = goutil.findChild(go, "select")
	self._animCanTake = self._goCanTake.gameObject:GetComponent(ComponentType.Animation)
	self._goReceived = goutil.findChild(go, "cell/backpack_item/imgReceived")
end

function DiceRewardItem:setClickCallback(callback)
	self._clickCallback = callback
end

function DiceRewardItem:bindEvents()
	self._btn:AddClickListener(self._onClick, self)
end

function DiceRewardItem:unbindEvents()
	self._btn:RemoveClickListener()
end

function DiceRewardItem:_onClick()
	if self._isTaken then
		FloatWordMgr.instance:show(lang("tip_reward_get"))

		return
	end

	if self._clickCallback ~= nil then
		self._clickCallback(self._id, self._index)
	end
end

function DiceRewardItem:updateData(data)
	self._id = data.id
	self._index = data.index
	self._isTaken = data.isTaken

	goutil.setActive(self._goCanTake, data.canTake)
	goutil.setActive(self._goReceived, data.isTaken)

	if not self._lastCanTake or self._lastCanTake ~= data.canTake then
		self._animCanTake:Stop()
		self._animCanTake:Play(data.canTake and "guess_dice_game_view_select_open" or "guess_dice_game_view_select_close")
	end

	self._lastCanTake = data.canTake
end

local M = class("RogueGuessDiceGameView", ViewComponent)
local kDefaultCameraPos = Vector3.New(0, 9, 0)
local PatternDevice = {
	{
		PATTERN.POWER,
		PATTERN.AGILE,
		PATTERN.POWER,
		PATTERN.POWER,
		PATTERN.AGILE,
		PATTERN.AGILE
	},
	{
		PATTERN.POWER,
		PATTERN.POWER,
		PATTERN.KNOWLEDGE,
		PATTERN.AGILE,
		PATTERN.KNOWLEDGE,
		PATTERN.AGILE
	},
	{
		PATTERN.POWER,
		PATTERN.AGILE,
		PATTERN.KNOWLEDGE,
		PATTERN.COMMUNICATE,
		PATTERN.INSIGHT,
		PATTERN.LUCKY
	}
}

function M:ctor()
	M.super.ctor(self)

	self._tempGuessRightCount = 0
end

function M:buildUI()
	self._btnClose = self:getBtn("title_view_-878360263")
	self._btnBreak = self:getBtn("guess_dice_game_view_-942940866")
	self._txtBreak = goutil.findChildTextComponent(self._btnBreak.gameObject, "Text")
	self._btnDice1 = self:getBtn("guess_dice_game_view_792440030")
	self._btnDice2 = self:getBtn("guess_dice_game_view_-684099323")
	self._btnDice3 = self:getBtn("guess_dice_game_view_-22602733")
	self._btnDice4 = self:getBtn("guess_dice_game_view_1377201894")
	self._btnDice5 = self:getBtn("guess_dice_game_view_-290361825")
	self._btnDice6 = self:getBtn("guess_dice_game_view_-58250580")
	self._goLeft = self:getGo("guess_dice_game_view_450055049")
	self._goRight = self:getGo("guess_dice_game_view_1038431006")
	self._traCenter = self:getGo("guess_dice_game_view_-773667050").transform
	self._txtGuessRightCount = self:getText("guess_dice_game_view_-1674151667")
	self._txtCoinCount = self:getText("guess_dice_game_view_-1090810206")
	self._btn_clickCost = self:getBtn("guess_dice_game_view_1400235869")
	self._imgCoin2 = self:getImage("guess_dice_game_view_1436248003")
	self._goRewardList = self:getGo("guess_dice_game_view_-1968584150")
	self._goDiceItems = {}

	for i = 1, 6 do
		self._goDiceItems[i] = goutil.findChild(self._goRight, "content1/dice_" .. i)
	end

	self._goSelects = {
		self:getGo("guess_dice_game_view_262088237"),
		self:getGo("guess_dice_game_view_1381707181"),
		self:getGo("guess_dice_game_view_-1626539279"),
		self:getGo("guess_dice_game_view_175483191"),
		self:getGo("guess_dice_game_view_-1133437105"),
		self:getGo("guess_dice_game_view_107686203")
	}
	self._txtRewardCounts = {
		self:getText("guess_dice_game_view_-2119829687"),
		self:getText("guess_dice_game_view_-1026139415"),
		self:getText("guess_dice_game_view_-787388319"),
		self:getText("guess_dice_game_view_-174416627"),
		self:getText("guess_dice_game_view_-1397756628")
	}
	self._diceIcons = {
		self:getImage("guess_dice_game_view_-1069028384"),
		self:getImage("guess_dice_game_view_-313223743"),
		self:getImage("guess_dice_game_view_1766018706"),
		self:getImage("guess_dice_game_view_810709743"),
		self:getImage("guess_dice_game_view_-591819713"),
		self:getImage("guess_dice_game_view_1183179109")
	}
	self._rewardItems = {}
	self._goRewardItems = {}
	self._goPropItems = {}

	for i = 1, 5 do
		local rewardItem = goutil.findChild(self._goRewardList, "reward_" .. i)

		self._goRewardItems[i] = rewardItem

		local btn = UIComponentType.ButtonAdapter(goutil.findChild(rewardItem, "click"))

		self._rewardItems[i] = DiceRewardItem.New(rewardItem)

		self._rewardItems[i]:setClickCallback(function(id, index)
			local diceTimes = RoguelikeConfig.instance:getConstByName("GuessDiceTimes").numValues

			if diceTimes[index] and diceTimes[index] > self._tempGuessRightCount then
				ViewMgr.instance:open(ViewName.RoguePropTips, id)

				return
			end

			RoguelikeAgent.instance:sendGuessDiceGetRewardRequest(index, id)
			RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
		end)

		local backpackItem = goutil.findChild(rewardItem, "cell/backpack_item")
		local item = Astral.LuaComponentContainer.Add(backpackItem, RoguePropItem)

		self._goPropItems[i] = item
	end

	self._goDiceImg = self:getGo("guess_dice_game_view_1309966125")
	self._effect = FullscreenPhotoEffect.Get(self._goDiceImg)

	self._effect:clear()

	self._goStartMask = self:getGo("guess_dice_game_view_1814673072")

	goutil.setActive(self._goStartMask, true)

	self._imgLocalization = self:getUIComponent("guess_dice_game_view_-10033344", ComponentType.ImageLocalization)
	self._goGlow = self:getGo("guess_dice_game_view_2102769019")
	self._aniGlow = self._goGlow:GetComponent(ComponentType.Animation)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnBreak:AddClickListener(self._onClickBreak, self)
	self._btnDice1:AddClickListener(self._onClickDice1, self)
	self._btnDice2:AddClickListener(self._onClickDice2, self)
	self._btnDice3:AddClickListener(self._onClickDice3, self)
	self._btnDice4:AddClickListener(self._onClickDice4, self)
	self._btnDice5:AddClickListener(self._onClickDice5, self)
	self._btnDice6:AddClickListener(self._onClickDice6, self)
	self._btn_clickCost:AddClickListener(self._onClickCost, self)

	for k, v in pairs(self._rewardItems) do
		v:bindEvents()
	end
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnBreak:RemoveClickListener()
	self._btnDice1:RemoveClickListener()
	self._btnDice2:RemoveClickListener()
	self._btnDice3:RemoveClickListener()
	self._btnDice4:RemoveClickListener()
	self._btnDice5:RemoveClickListener()
	self._btnDice6:RemoveClickListener()
	self._btn_clickCost:RemoveClickListener()

	for k, v in pairs(self._rewardItems) do
		v:unbindEvents()
	end
end

function M:onEnter()
	self:setEvent(true)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dice)
	self:updateGuessRightCount()
	self:updateGoldNum()
	self:updateRewardInfos()
	self:loadGuessDice()

	if RogueMgr.instance:getHackToolModel() then
		local msg = RoguelikeModel.instance:getCurHackToolRoomInfo()

		self:updateRoomByMsg(msg)
	end
end

function M:resetLayout(isShow)
	if isShow then
		goutil.setActive(self._goLeft, false)
		goutil.setActive(self._goRight, false)
		Astral.TransformUtil.SetLocalScale(self._traCenter, 1.5, 1.5, 1.5)
	else
		goutil.setActive(self._goLeft, true)
		goutil.setActive(self._goRight, true)
		Astral.TransformUtil.SetLocalScale(self._traCenter, 1, 1, 1)
	end
end

function M:onExit()
	removetimer(self.showDiceAnimation, self)
	removetimer(self.calcGuessingResult, self)
	removetimer(self.checkDiceStop, self)
	self:setEvent(false)

	self._tempGuessRightCount = 0

	self._effect:clear()

	self._inAni = false

	self:resetLayout()
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_GUESS_DICE, self._onShowGuessDice, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_GET_GUESS_DICE_TIME, self._onGetGuessDiceTime, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_BEGIN_SHOW_GUESS_DICE, self._addForceToDice, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_GOLD, self._onRefreshGold, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_GUESS_DICE, self._onShowGuessDice, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_GET_GUESS_DICE_TIME, self._onGetGuessDiceTime, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_ROOM_PRIZES, self._onShowRoomPrizes, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_BEGIN_SHOW_GUESS_DICE, self._addForceToDice, self)
	end
end

function M:loadGuessDice()
	local path = GameUrl.getScenePrefabUrl("common_npc_props/npc_shaizi/prefab/guess_dice_bound")

	self._effect:showEffects(path)
	self._effect:setCameraRotation(90, 45, 0)
	self._effect:setCameraPosition(kDefaultCameraPos.x, kDefaultCameraPos.y, kDefaultCameraPos.z)
	self._effect:setEffectLoadedCallback(self._effectCallback, self)
end

function M:_effectCallback(inst, res)
	self._bgInst = inst

	local dice = goutil.findChild(inst, "guess_dice")
	local trigger = Astral.CollisionLuaComponentContainer.Add(dice, RogueGuessDiceTrigger)

	trigger:setEnterCallback(function(collision)
		if collision.gameObject.name == "wall" then
			self._aniGlow:Play("guess_dice_game_view_imgcenter_glow_open")
		end
	end)

	self._diceRigidbody = dice:GetComponent("Rigidbody")

	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local children = {}

	for i = 1, 6 do
		local child = goutil.findChild(dice, diceMgr:getDiceFaceName(i))

		table.insert(children, i, child)
	end

	self._diceChildren = children

	if RogueMgr.instance:getHackToolModel() then
		self:_setDicePatterns()
	else
		RoguelikeAgent.instance:sendGetGuessNumRequest()
		RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
	end
end

function M:_setDicePatterns()
	local curRightCount = self._tempGuessRightCount

	if curRightCount ~= 0 and curRightCount ~= 2 and curRightCount ~= 4 then
		return
	end

	local pattern = self:_getDicePatternDevice()
	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr

	for i = 1, 6 do
		diceMgr:setDicePattern(self._diceChildren[i], pattern[i])
		IconLoader.setSprite(self._diceIcons[i], IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(pattern[i])))
	end

	for k, v in pairs(self._goDiceItems) do
		goutil.setActive(v, curRightCount < 2 and k <= 2 or curRightCount >= 2)
	end

	self._imgLocalization:SetSprite(curRightCount < 2 and "pt_18" or "xiaoyouxi_31")
end

function M:_getDicePatternDevice()
	if self._tempGuessRightCount < 2 then
		return PatternDevice[1]
	end

	if self._tempGuessRightCount < 4 then
		return PatternDevice[2]
	end

	return PatternDevice[3]
end

function M:_onShowRoomPrizes(sender, msg)
	local curRoomPrize

	for k, v in ipairs(msg.roomPrize) do
		if v.room == RoguelikeModel.instance:getCurRoomMo():getCoordinateStr() then
			curRoomPrize = v
		end
	end

	if #msg.roomPrize > 0 and curRoomPrize == nil then
		printError("没有当前房间奖励信息", RoguelikeModel.instance:getCurRoomMo():getCoordinateStr())

		return
	end

	msg = curRoomPrize

	self:updateRoomByMsg(msg)
end

function M:updateRoomByMsg(msg)
	local prizes = msg.prize or {}

	for k, v in pairs(self._goRewardItems) do
		goutil.setActive(v, false)
	end

	local increment = msg.increment ~= nil and msg.increment or 0
	local initialPrice = RoguelikeConfig.instance:getConstByName("GuessDiceInitialPrice").numValue
	local priceIncrement = RoguelikeConfig.instance:getConstByName("GuessDicePriceIncrement").numValue
	local count = initialPrice + increment * priceIncrement
	local diceTimes = RoguelikeConfig.instance:getConstByName("GuessDiceTimes").numValues

	count = count ~= 0 and count or 1

	local gambleAdd = RoguelikeModel.instance:getGambleAdd()

	self._txtCoinCount.text = count * gambleAdd

	for k, v in ipairs(prizes) do
		local goods = {}

		table.insert(goods, v)

		local data = {}

		data.id = v.id
		data.index = k
		data.isTaken = v.taken
		data.canTake = not v.taken and diceTimes[k] and diceTimes[k] <= self._tempGuessRightCount

		if self._rewardItems[k] == nil then
			print("奖励超出数量", k)

			return
		end

		self._rewardItems[k]:updateData(data)

		local data1 = {}

		data1.propId = v.id

		local id = v.id
		local index = k
		local taken = v.taken

		function data1.callback()
			if taken then
				FloatWordMgr.instance:show(lang("tip_reward_get"))
				ViewMgr.instance:open(ViewName.RoguePropTips, id)

				return
			end

			local diceTimes = RoguelikeConfig.instance:getConstByName("GuessDiceTimes").numValues

			if diceTimes[index] and diceTimes[index] > self._tempGuessRightCount then
				ViewMgr.instance:open(ViewName.RoguePropTips, id)

				return
			end

			RoguelikeAgent.instance:sendGuessDiceGetRewardRequest(index, id)
			RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
		end

		self._goPropItems[k]:updateData(data1)
		goutil.setActive(self._goRewardItems[k], true)
	end
end

function M:_onGetGuessDiceTime(sender, num)
	self._tempGuessRightCount = num

	self:updateGuessRightCount()
	self:_setDicePatterns()
end

function M:_onShowGuessDice(sender, result)
	if result then
		FloatWordMgr.instance:show(lang("tip_r_guess_right"))
	else
		FloatWordMgr.instance:show(lang("tip_r_guess_error"))
	end

	RoguelikeAgent.instance:sendGetGuessNumRequest()

	if RogueMgr.instance:getHackToolModel() then
		return
	end

	RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
end

function M:_onClickClose()
	if self._inAni then
		return
	end

	self:close()
end

function M:_onClickBreak()
	local diceTimes = RoguelikeConfig.instance:getConstByName("GuessDiceTimes").numValues

	if self._tempGuessRightCount >= diceTimes[#diceTimes] then
		FloatWordMgr.instance:show(lang("tip_r_cant_bet"))

		return
	end

	if self._inAni then
		return
	end

	if self._selectIndex == nil then
		FloatWordMgr.instance:show(lang("tip_r_bet_point"))

		return
	end

	RoguelikeAgent.instance:sendGuessDiceRequest(self:_getDicePatternDevice()[self._selectIndex] - 1)
	goutil.setActive(self._goStartMask, false)
end

function M:_addForceToDice()
	self._inAni = true
	self._diceRigidbody.transform.position = self._diceRigidbody.transform.position + Vector3.New(0, 0.2, 0)

	local rigidbody = self._diceRigidbody

	if rigidbody then
		rigidbody:AddRelativeTorque(UnityEngine.Random.onUnitSphere * 200, UnityEngine.ForceMode.Impulse)
		rigidbody:AddRelativeForce(Vector3.New(math.random(15, 30) / 10, 0.5, math.random(15, 30) / 10), UnityEngine.ForceMode.Impulse)
	end

	self:resetLayout(true)
	settimer(0.1, self.checkDiceStop, self, true)
end

function M:checkDiceStop()
	local body = self._diceRigidbody

	if body.velocity.sqrMagnitude < 0.001 then
		local upIndex = self:getDiceUpIndex(body)

		RoguelikeAgent.instance:sendGuessDiceResultRequest(self:_getDicePatternDevice()[upIndex] - 1)
		removetimer(self.checkDiceStop, self)

		self._inAni = false

		self:resetLayout()
		goutil.setActive(self._goStartMask, true)
	end
end

function M:getDiceUpIndex(dice)
	local tra = dice.transform:Find("face")
	local maxY = 0
	local index = 1

	for i = 0, tra.childCount - 1 do
		local tempY = tra:GetChild(i).position.y

		if maxY < tempY or maxY == 0 then
			maxY = tempY
			index = i + 1
		end
	end

	return index
end

function M:startDiceGuessing()
	self._changeTime = math.random(10, 20)
	self._startPoint = math.random(1, 6)

	self:showDiceAnimation()
end

function M:showDiceAnimation()
	if self._changeTime <= 0 then
		self:calcGuessingResult()

		return
	end

	self._changeTime = self._changeTime - 1
	self._startPoint = self._startPoint + 1
	self._startPoint = self._startPoint % 6 + 1

	IconLoader.setSprite(self._imgDice, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(self._startPoint)))
	settimer(0.08, self.showDiceAnimation, self, false)
end

function M:showDiceAniByAnimator()
	if self._animator then
		self._inAni = true

		local aniName = string.format("dice_point%d", self._startPoint)

		self._animator:Play(aniName)
		settimer(1, self.calcGuessingResult, self, false)
	end
end

function M:calcGuessingResult()
	if self._selectIndex == self._startPoint then
		-- block empty
	else
		FloatWordMgr.instance:show(lang("tip_r_guess_error"))
	end

	self._inAni = false

	RoguelikeAgent.instance:sendGetGuessNumRequest()

	if RogueMgr.instance:getHackToolModel() then
		return
	end

	RoguelikeAgent.instance:sendLoadAllRoomPrizesRequest()
end

function M:_onClickDice1()
	self:setSelectDice(1)
end

function M:_onClickDice2()
	self:setSelectDice(2)
end

function M:_onClickDice3()
	self:setSelectDice(3)
end

function M:_onClickDice4()
	self:setSelectDice(4)
end

function M:_onClickDice5()
	self:setSelectDice(5)
end

function M:_onClickDice6()
	self:setSelectDice(6)
end

function M:_onClickCost()
	return
end

function M:setSelectDice(index)
	if self._inAni then
		return
	end

	for k, v in pairs(self._goSelects) do
		goutil.setActive(v, k == index)
	end

	self._selectIndex = index
end

function M:updateGuessRightCount()
	local count = self._tempGuessRightCount

	self._txtGuessRightCount.text = count
end

function M:updateRewardInfos()
	local diceTimes = RoguelikeConfig.instance:getConstByName("GuessDiceTimes").numValues

	for k, v in ipairs(diceTimes) do
		self._txtRewardCounts[k].text = string.format("<color=#ff3e48>%d</color>", v)
	end
end

function M:_onRefreshGold()
	self:updateGoldNum()
end

function M:updateGoldNum()
	return
end

return M
