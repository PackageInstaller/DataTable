-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/judgesystem/RogueMonsterJudgeView.lua

module("logic.extensions.roguelike.view.judgesystem.RogueMonsterJudgeView", package.seeall)

local MonsterHeadItem = class("MonsterHeadItem")

function MonsterHeadItem:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildComponent(go, "headMask/headIcon", UIComponentType.Image)
	self._txtHp = goutil.findChildComponent(go, "diceNum/txtDiceNum", UIComponentType.Text)
end

function MonsterHeadItem:updateData(data)
	local headIcon = data.headIcon
	local hp = data.hp

	self._txtHp.text = hp

	IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, headIcon)
end

function MonsterHeadItem:setHp(hp)
	self._txtHp.text = hp
end

local MonsterDiceItem = class("MonsterDiceItem")

function MonsterDiceItem:ctor(go)
	self._go = go
	self._imgIcon = goutil.findChildComponent(go, "attributeIcon", UIComponentType.Image)
end

function MonsterDiceItem:updateData(data)
	local pattern = data.pattern

	IconLoader.setSprite(self._imgIcon, IconType.DynSpriteAtlas_Dice, string.format("dice_%d", RoguelikeConst.GetPatterIcon(pattern)))
	goutil.setActive(self._go, true)
end

function MonsterDiceItem:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

local M = class("RogueMonsterJudgeView", RogueJudgeView)

function M:buildUI()
	M.super.buildUI(self)

	self._goReminder = self:getGo("rungroup_dice_view_-1042577388")
	self._txtEnemyHp.text = "x0"

	goutil.setActive(self._goReminder, false)
end

function M:onEnter()
	self:setEvent(true)

	local monsterId = self:getFirstParam()

	RogueMgr.instance:enterFight(monsterId)
	M.super.onEnter(self)
	self:showEventStartTips()

	local result = RogueMgr.instance:getModel():setFirstActiveRoleIndex()

	if result == 0 then
		self:close()

		return
	end
end

function M:onExit()
	M.super.onExit(self)
	removetimer(self.onShowEventStartFinish, self)
	removetimer(self.onShowEventEndFinish, self)
end

function M:setGoActive()
	local roleMos = RogueMgr.instance:getModel():getAllRoleMos()

	for k, v in pairs(roleMos) do
		v.transform:setActive(not v.roleProp:getIsDeath())
		v.infoBar:setVisible(not v.roleProp:getIsDeath())
	end

	local mapMgr = RogueMgr.instance:getMapMgr()

	if mapMgr then
		mapMgr:setActive(false)
	end
end

function M:showEventStartTips()
	if self._goStateTips == nil then
		self._goStateTips = self:getResInstance(ResName.Rungroupother_judgement_state_view)

		goutil.addChildToParent(self._goStateTips, self.mainGO)

		self._aniStateTips = goutil.addComponentOnce(self._goStateTips, typeof(Astral.GUITimelineAniLua))
	end

	goutil.setActive(self._goStateTips, true)

	local type1 = goutil.findChild(self._goStateTips, "type1")
	local type1Text = goutil.findChildTextComponent(self._goStateTips, "type1/text")

	type1Text.text = lang("战斗开始")

	goutil.setActive(type1, true)
	self._aniStateTips:StopTimelineAni()
	self._aniStateTips:PlayAniByName("open")
	settimer(1, self.onShowEventStartFinish, self, false)
end

function M:onShowEventStartFinish()
	goutil.setActive(self._goStateTips, false)
end

function M:showEnterBroadCast()
	local msg2, isTitle2 = RoguelikeConfig.getBroadCast("Broadcast_Start_Fight")

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg2, isTitle2)

	local allRoles = RogueMgr.instance:getModel():getAllRoleMos()
	local meetMsg = ""

	for k, v in pairs(allRoles) do
		local prop = v.roleProp

		if not prop:getIsDeath() then
			local heroCO = PastInfoConfig.instance:getCharacterInfo(prop:getRoleId())

			meetMsg = meetMsg .. " " .. heroCO.name .. " [head" .. prop:getModelId() .. "|32] "
		end
	end

	local prop = RogueMgr.instance:getModel():getCurMonster().monsterProp
	local monsterCo = RoguelikeConfig.instance:getRoguelikeMonsterById(prop:getId())
	local format, isTitle = RoguelikeConfig.getBroadCast("Broadcast_Meet_Monster")
	local msg = string.format(format, meetMsg, monsterCo.name .. " [" .. monsterCo.head .. "|32] ")

	GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg, isTitle)

	local extraPattern = RogueMgr.instance:getStateMgr():getTotalExtraFaces()

	if #extraPattern > 0 then
		local format1, isTitle1 = RoguelikeConfig.getBroadCast("Broadcast_Extra_Face_Num")
		local msg1 = string.format(format1, #extraPattern)

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg1, isTitle1)
	end
end

function M:setEvent(add)
	M.super.setEvent(self, add)

	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_MONSTER_ANI, self._onPlayMonsterAni, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, self._createDiceTailEffect, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_MONSTER_ANI, self._onPlayMonsterAni, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FEATURES_ROLL_RESULT, self._onFeatureRollResult, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_REFRESH_MONSTER_HP, self._onMonsterHpRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ROGUE_SHOW_CREATE_DICE_TAIL, self._createDiceTailEffect, self)
	end
end

function M:_onResultFinish(sender, isWin)
	self:showEventEndFinish(isWin)
end

function M:showEventEndFinish(isWin)
	if not self then
		return
	end

	goutil.setActive(self._goStateTips, true)

	local type1 = goutil.findChild(self._goStateTips, "type1")
	local type1Text = goutil.findChildTextComponent(self._goStateTips, "type1/text")

	type1Text.text = isWin and lang("击溃梦魇") or lang("战斗失败")

	goutil.setActive(type1, true)
	self._aniStateTips:StopTimelineAni()
	self._aniStateTips:PlayAniByName("open")
	settimer(1.5, self.onShowEventEndFinish, self, false)
end

function M:onShowEventEndFinish()
	goutil.setActive(self._goStateTips, false)
end

function M:onShowResultFinish()
	goutil.setActive(self._goResult, false)
	self:_onClickClose()
end

function M:showRoleStateChangeTips(roleId, changeHp, changeSan)
	return
end

function M:_onFeatureRollResult(sender, featurePattern, isNew)
	local feature = RogueMgr.instance:getRogueFlow().judgeMgr:getCombatDiceFeatures()

	self:showSixInfoHighLight(feature)
end

function M:_onRoleChange(sender, roleId, roleIndex)
	self:updateExtraPattern()
end

function M:_onMonsterHpRefresh(sender, id, hp)
	return
end

local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

function M:_createDiceTailEffect(sender, type, worldPos, callback)
	if type == -1 then
		return
	end

	self._tailEffects = self._tailEffects or {}

	local tailEffectIns

	if tailEffectIns == nil then
		tailEffectIns = self:getResInstance(ResName.Rungroupother_card_effect_tail)

		goutil.addChildToParent(tailEffectIns, self._bottomBtn)
		TransformUtils.SetLocalPosition(tailEffectIns.transform, 0, 130, 0)
		table.insert(self._tailEffects, tailEffectIns)
	else
		table.remove(self._tailEffects, 1)
	end

	goutil.setActive(tailEffectIns, true)

	local screenPos

	if type == 1 then
		screenPos = self._btnExtraHint.transform.position
	elseif worldPos then
		screenPos = RectTransformUtils.WorldTo2DCameraPoint(worldPos, kMainCamera, kUICamera, self._bottomBtn.transform)
	end

	tailEffectIns.transform:DOMove(screenPos, 0.7):OnComplete(function()
		local boomEffectIns = self:getResInstance(RogueMonsterJudgeViewPresentor.Url_Card_Effect_Boom)

		goutil.addChildToParent(boomEffectIns, self._bottomBtn)

		boomEffectIns.transform.position = tailEffectIns.transform.position

		goutil.destroy(tailEffectIns)

		if callback then
			callback()
		end

		settimer(0.2, function()
			goutil.destroy(boomEffectIns)
		end, self, false)
	end, self)
end

function M:_createPatternTailEffect(sender, pos, callback)
	local tailEffectIns

	if tailEffectIns == nil then
		tailEffectIns = self:getResInstance(RogueMonsterJudgeViewPresentor.Url_Pattern_Effect_Tail)

		goutil.addChildToParent(tailEffectIns, self._bottomBtn)
	end

	tailEffectIns.transform.position = self._btnExtraHint.transform.position

	goutil.setActive(tailEffectIns, true)

	local screenPos = RectTransformUtils.WorldTo2DCameraPoint(pos, kMainCamera, kUICamera, self._bottomBtn.transform)

	tailEffectIns.transform:DOMove(screenPos, 0.7):OnComplete(function()
		if callback then
			callback()
		end

		goutil.destroy(tailEffectIns)
	end, self)
end

function M:_updateCombatDice(sender, dices)
	if dices then
		self._txtEnemyHp.text = "x" .. #dices
		self._combatDiceCount = #dices

		goutil.setActive(self._goEnemyHp, #dices > 0)

		local originCount = self._lastWallCount or 0

		DoTweenUtil.ToInt(originCount, #dices, 0.5, 0, DG.Tweening.Ease.Linear, 0, DG.Tweening.LoopType.Incremental, nil, function(value)
			self._txtEnemyHp.text = "x" .. value
		end, function()
			self._txtEnemyHp.text = "x" .. #dices
		end, nil)

		self._lastWallCount = self._combatDiceCount
	end
end

function M:_changeCombatDice(sender, changeCount)
	local dices = RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() or {}

	if changeCount then
		self._combatDiceCount = self._combatDiceCount - changeCount
	else
		self._combatDiceCount = #dices
	end

	if self._combatDiceCount < 0 then
		self._combatDiceCount = 0
	end

	if self._combatDiceCount == 0 then
		RogueMgr.instance:getRogueFlow().shieldMgr:showDestroyMonsterShieldAni()
	end

	self._txtEnemyHp.text = "x" .. self._combatDiceCount

	goutil.setActive(self._goEnemyHp, self._combatDiceCount > 0)
end

function M:_onPlayMonsterAni(sender, aniName, changeIdleTime)
	removetimer(self._onMonsterAniFinish, self)

	local monsterMo = RogueMgr.instance:getModel():getCurMonster()

	monsterMo.meshModel:play(aniName, false, true)

	self._curMonsterMo = monsterMo

	if changeIdleTime then
		settimer(changeIdleTime, self._onMonsterAniFinish, self, false)
	end
end

function M:_onMonsterAniFinish()
	self._curMonsterMo.meshModel:play(RoguelikeConst.ROGUE_MONSTER_ANI.IDLE, true, true)
end

return M
