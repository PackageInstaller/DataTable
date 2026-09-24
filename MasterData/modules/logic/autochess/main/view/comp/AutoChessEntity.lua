-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessEntity.lua

module("modules.logic.autochess.main.view.comp.AutoChessEntity", package.seeall)

local AutoChessEntity = class("AutoChessEntity", LuaCompBase)

function AutoChessEntity:init(go)
	self.go = go
	self.transform = go.transform
	self.goEntity = gohelper.findChild(go, "ani/Entity")
	self.dirTrs = self.goEntity.transform
	self.goMesh = gohelper.findChild(go, "ani/Entity/Mesh")
	self.goBar = gohelper.findChild(go, "ani/ChessBar")
	self.goAttack = gohelper.findChild(self.goBar, "go_Attack")
	self.txtAttack = gohelper.findChildText(self.goBar, "go_Attack/txt_Attack")
	self.goHp = gohelper.findChild(self.goBar, "go_Hp")
	self.txtHp = gohelper.findChildText(self.goBar, "go_Hp/txt_Hp")
	self.imageLevel = gohelper.findChildImage(self.goBar, "image_Level")
	self.txtLevel = gohelper.findChildText(self.goBar, "Exp/txt_Level")
	self.goStar = gohelper.findChild(self.goBar, "Exp/go_Star")
	self.golvup = gohelper.findChild(self.goBar, "Exp/go_lvup")
	self.goStar1 = gohelper.findChild(self.goBar, "Exp/go_Star/go_Star1")
	self.imageLight1 = gohelper.findChildImage(self.goBar, "Exp/go_Star/go_Star1/image_Light1")
	self.goStar2 = gohelper.findChild(self.goBar, "Exp/go_Star/go_Star2")
	self.imageLight2 = gohelper.findChildImage(self.goBar, "Exp/go_Star/go_Star2/image_Light2")
	self.goStar3 = gohelper.findChild(self.goBar, "Exp/go_Star/go_Star3")
	self.imageLight3 = gohelper.findChildImage(self.goBar, "Exp/go_Star/go_Star3/image_Light3")
	self.anim = gohelper.findChild(go, "ani"):GetComponent(gohelper.Type_Animator)
	self.goHpFloat = gohelper.findChild(self.goBar, "go_HpFloat")
	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goMesh, AutoChessMeshComp)
	self.effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goEntity, AutoChessEffectComp)
	self.goEffLight = gohelper.findChild(go, "ani/go_EffLight")
	self.animStar1 = self.goStar1:GetComponent(gohelper.Type_Animator)
	self.animStar2 = self.goStar2:GetComponent(gohelper.Type_Animator)
	self.animStar3 = self.goStar3:GetComponent(gohelper.Type_Animator)
	self.goFlyStar = gohelper.findChild(go, "ani/go_FlyStar")
	self.goFlyStar1 = gohelper.findChild(go, "ani/go_FlyStar/star1")
	self.goFlyStar2 = gohelper.findChild(go, "ani/go_FlyStar/star2")
	self.goFlyStar3 = gohelper.findChild(go, "ani/go_FlyStar/star3")
	self.goFlyStar4 = gohelper.findChild(go, "ani/go_FlyStar/star4")
	self.goFlyStar5 = gohelper.findChild(go, "ani/go_FlyStar/star5")

	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntity, self.onDragChess, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragChessEntityEnd, self.onDragChessEnd, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItem, self.onDragChess, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.DragMallItemEnd, self.onDragChessEnd, self)

	self.goExp = gohelper.findChild(self.goBar, "Exp")
	self.floatItemList = {}
	self.floatItemCacheList = {}
end

function AutoChessEntity:addEventListeners()
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UsingLeaderSkill, self.onUsingLeaderSkill, self)
	self.addEventCb(self, AutoChessController.instance, AutoChessEvent.UpdateExtInfo, self.onUpdateExtInfo, self)
end

function AutoChessEntity:onUsingLeaderSkill(using)
	if using then
		local types = AutoChessGameModel.instance.targetTypes

		if tabletool.indexOf(types, self.mo.config.type) then
			gohelper.setActive(self.goEffLight, true)

			return
		end
	end

	gohelper.setActive(self.goEffLight, false)
end

function AutoChessEntity:onDragChess(config)
	if self.mo.id == config.id and self.mo.maxExpLimit ~= 0 then
		self.lightIndex = self.mo.exp + 1

		gohelper.setActive(self["imageLight" .. self.lightIndex].gameObject, true)
		self["animStar" .. self.lightIndex]:Play("loop", 0, 0)
	end
end

function AutoChessEntity:onDragChessEnd()
	if self.lightIndex then
		self["animStar" .. self.lightIndex]:Play("idle", 0, 0)
		gohelper.setActive(self["imageLight" .. self.lightIndex].gameObject, false)

		self.lightIndex = nil
	end
end

function AutoChessEntity:onDestroy()
	TaskDispatcher.cancelTask(self.delayFly, self)
	TaskDispatcher.cancelTask(self.checkHpFloat, self)
end

function AutoChessEntity:setData(mo, warZone, pos)
	self.mo = mo
	self.warZone = warZone
	self.index = pos
	self.teamType = self.mo.teamType

	local skillIdsStr = self.mo.config.skillIds

	if not string.nilorempty(skillIdsStr) then
		local skillIds = string.splitToNumber(skillIdsStr, "#")

		self.skillId = skillIds[1]
	end

	local dir = self.teamType == AutoChessEnum.TeamType.Enemy and 1 or -1

	transformhelper.setLocalScale(self.dirTrs, dir, 1, 1)
	self.meshComp:setData(self.mo.config.image, self.teamType == AutoChessEnum.TeamType.Enemy)
	self:refreshUI()
	self:show()

	if self.mo.config.type == AutoChessStrEnum.ChessType.Incubate and self.mo.cd == 0 then
		self.anim:Play("box_loop", 0, 0)
	end

	if self.mo.config.type == AutoChessStrEnum.ChessType.Boss then
		recthelper.setAnchor(self.goAttack.transform, 0, -188)
		recthelper.setAnchor(self.goHp.transform, 0, -188)
	end
end

function AutoChessEntity:updateIndex(warZone, index)
	self.warZone = tonumber(warZone)
	self.index = tonumber(index)

	self:show()
end

function AutoChessEntity:updateLocation()
	local isBoss = self.mo.config.type == AutoChessStrEnum.ChessType.Boss

	self.pos = AutoChessGameModel.instance:getChessLocation(self.warZone, self.index + 1, isBoss)

	recthelper.setAnchor(self.transform, self.pos.x, self.pos.y)
end

function AutoChessEntity:setScale(scale)
	transformhelper.setLocalScale(self.transform, scale, scale, scale)
end

function AutoChessEntity:move(index)
	if self.mo.config.type == AutoChessStrEnum.ChessType.Boss then
		logError("Boss类型的棋子不该移动")

		return
	end

	self.index = tonumber(index)
	self.pos = AutoChessGameModel.instance:getChessLocation(self.warZone, self.index + 1)

	ZProj.TweenHelper.DOAnchorPosX(self.transform, self.pos.x, AutoChessEnum.ChessAniTime.jump)
	AudioMgr.instance:trigger(AudioEnum.AutoChess.play_ui_tangren_chess_move)
	self.anim:Play("jump", 0, 0)
end

function AutoChessEntity:attack()
	self.anim:Play("melee", 0, 0)

	return 0.6
end

function AutoChessEntity:ranged(targetPos, effectId)
	self.anim:Play("attack", 0, 0)

	return (self:playEffect(effectId, targetPos))
end

function AutoChessEntity:skillAnim(animName)
	self.anim:Play(animName, 0, 0)

	return AutoChessEnum.ChessAniTime[animName]
end

function AutoChessEntity:resetPos()
	ZProj.TweenHelper.DOAnchorPosX(self.transform, self.pos.x, 0.5)
end

function AutoChessEntity:initBuffEffect()
	self.effectComp:hideAll()

	for _, buff in ipairs(self.mo.buffContainer.buffs) do
		local buffeffectID = buff.config.buffeffectID

		if buffeffectID ~= 0 then
			local effectCo = AutoChessConfig.instance:getEffectCfg(buffeffectID)

			if effectCo and effectCo.loop == 1 then
				self.effectComp:playEffect(effectCo)
			end
		end
	end

	local effectTag = self.mo.config.tag

	if not string.nilorempty(effectTag) then
		local effectId = AutoChessEnum.Tag2EffectId[effectTag]

		self:playEffect(effectId)
	end

	self:onUpdateExtInfo()
end

function AutoChessEntity:addBuff(buff)
	local buffeffectID = buff.config.buffeffectID

	if buffeffectID ~= 0 then
		self:playEffect(buffeffectID)
	end

	self.mo.buffContainer:addBuff(buff)
end

function AutoChessEntity:updateBuff(buff)
	if buff.layer ~= 0 then
		local buffeffectID = buff.config.buffeffectID

		if buffeffectID ~= 0 then
			self:playEffect(buffeffectID)
		end
	end

	local buffs = self.mo.buffContainer.buffs

	for _, buff1 in ipairs(buffs) do
		if buff1.uid == buff.uid then
			buff1:update(buff)

			break
		end
	end
end

function AutoChessEntity:delBuff(buffUid)
	local buffs = self.mo.buffContainer.buffs
	local index

	for k, buff in ipairs(buffs) do
		if buff.uid == buffUid then
			index = k

			break
		end
	end

	if index then
		local buff = buffs[index]
		local buffeffectID = buff.config.buffeffectID

		if buffeffectID ~= 0 then
			self.effectComp:removeEffect(buffeffectID)
		end

		table.remove(buffs, index)
	else
		logError(string.format("异常:未找到buffUid%s", buffUid))
	end
end

function AutoChessEntity:die(playSkill)
	self.anim:Play("die", 0, 0)

	if playSkill and self.skillId then
		local skillCo = AutoChessConfig.instance:getChessSkillCfg(self.skillId)

		if skillCo.tag == "Die" and skillCo.useeffect ~= 0 then
			self:playEffect(skillCo.useeffect)

			return skillCo.useeffect
		end
	end
end

function AutoChessEntity:activeExpStar(active)
	gohelper.setActive(self.goStar, active)
end

function AutoChessEntity:hide()
	gohelper.setActive(self.go, false)
end

function AutoChessEntity:show()
	self:updateLocation()
	gohelper.setActive(self.go, true)
end

function AutoChessEntity:updateHp(value)
	value = tonumber(value)
	self.mo.hp = self.mo.hp + value

	self:refreshAttr()
end

function AutoChessEntity:floatHp(value, type)
	TaskDispatcher.cancelTask(self.checkHpFloat, self)
	TaskDispatcher.runRepeat(self.checkHpFloat, self, 0.5)

	local floatItem
	local cacheCnt = #self.floatItemCacheList

	if cacheCnt > 0 then
		floatItem = self.floatItemCacheList[cacheCnt]
		self.floatItemCacheList[cacheCnt] = nil
	else
		floatItem = self:getUserDataTb_()
		floatItem.go = gohelper.cloneInPlace(self.goHpFloat)
		floatItem.anim = floatItem.go:GetComponent(gohelper.Type_Animator)
		floatItem.txtHpAdd = gohelper.findChildText(floatItem.go, "txt_HpAdd")
		floatItem.txtHpSub = gohelper.findChildText(floatItem.go, "txt_HpSub")
		floatItem.txtHpPoison = gohelper.findChildText(floatItem.go, "txt_HpPoison")
	end

	floatItem.time = Time.time
	self.floatItemList[#self.floatItemList + 1] = floatItem

	gohelper.setActive(floatItem.go, true)

	value = tonumber(value)

	if tonumber(type) == AutoChessEnum.HpFloatType.Attack then
		floatItem.txtHpSub.text = value

		floatItem.anim:Play("hpsub", 0, 0)
	elseif tonumber(type) == AutoChessEnum.HpFloatType.Poison then
		floatItem.txtHpPoison.text = value

		floatItem.anim:Play("hpposion", 0, 0)
	elseif tonumber(type) == AutoChessEnum.HpFloatType.Cure then
		floatItem.txtHpAdd.text = "+" .. value

		floatItem.anim:Play("hpadd", 0, 0)
	end
end

function AutoChessEntity:updateBattle(value)
	value = tonumber(value)
	self.mo.battle = self.mo.battle + value

	self:refreshAttr()
end

function AutoChessEntity:updateExp(value)
	value = tonumber(value)

	if value > self.mo.maxExpLimit then
		self.mo.exp = self.mo.maxExpLimit or value
	end

	self:refreshExp()
end

function AutoChessEntity:updateStar(mo)
	self.mo = mo

	self:refreshUI()

	return self:playEffect(50001)
end

function AutoChessEntity:refreshUI()
	self:initBuffEffect()
	self:refreshAttr()
	self:refreshStar()
	self:refreshExp()
end

function AutoChessEntity:refreshAttr()
	if self.mo.config.type == AutoChessStrEnum.ChessType.Attack or self.mo.config.type == AutoChessStrEnum.ChessType.Boss then
		self.txtAttack.text = self.mo.battle
		self.txtHp.text = self.mo.hp

		gohelper.setActive(self.goAttack, true)
		gohelper.setActive(self.goHp, true)
	else
		gohelper.setActive(self.goAttack, false)
		gohelper.setActive(self.goHp, false)
	end
end

function AutoChessEntity:refreshExp()
	for i = 1, 3 do
		local imageLight = self["imageLight" .. i]

		gohelper.setActive(imageLight, i <= self.mo.exp)
	end
end

function AutoChessEntity:refreshStar()
	if self.mo.star == 0 then
		gohelper.setActive(self.imageLevel, false)
		gohelper.setActive(self.goExp, false)
	else
		local txt = luaLang("autochess_malllevelupview_level")

		UISpriteSetMgr.instance:setAutoChessSprite(self.imageLevel, "v2a5_autochess_levelbg_" .. self.mo.star)

		self.txtLevel.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, self.mo.star)

		local maxExp = self.mo.maxExpLimit

		if maxExp == 0 then
			gohelper.setActive(self.goStar, false)
		else
			for i = 1, 3 do
				local goStar = self["goStar" .. i]

				gohelper.setActive(goStar, i <= maxExp)
			end

			gohelper.setActive(self.goStar, true)
		end
	end
end

function AutoChessEntity:checkHpFloat()
	local now = Time.time
	local cnt = #self.floatItemList

	for i = cnt, 1, -1 do
		local floatItem = self.floatItemList[i]

		if now - floatItem.time >= 1 then
			gohelper.setActive(floatItem.go, false)

			self.floatItemCacheList[#self.floatItemCacheList + 1] = floatItem

			table.remove(self.floatItemList, i)
		end
	end

	if #self.floatItemList == 0 then
		TaskDispatcher.cancelTask(self.checkHpFloat, self)
	end
end

function AutoChessEntity:flyStar()
	local starCnt = self.mo.config.levelFromMall

	starCnt = starCnt < 5 and starCnt or 5

	for i = 1, starCnt do
		gohelper.setActive(self["goFlyStar" .. i], true)
	end

	gohelper.setActive(self.goFlyStar, true)
	TaskDispatcher.runDelay(self.delayFly, self, 0.6)
end

function AutoChessEntity:delayFly()
	local fightMo = AutoChessModel.instance:getSceneMo().lastFight
	local leaderUid
	local leader = AutoChessEntityMgr.instance:getLeaderEntity(self.teamType == AutoChessEnum.TeamType.Player and fightMo.mySideMaster.uid or fightMo.enemyMaster.uid)

	if leader then
		local x, y, z = transformhelper.getPos(leader.go.transform)
		local targetPos = recthelper.rectToRelativeAnchorPos(Vector3(x, y, z), self.goFlyStar.transform)
		local starCnt = self.mo.config.levelFromMall

		starCnt = starCnt < 5 and starCnt or 5

		for i = 1, starCnt do
			local transform = self["goFlyStar" .. i].transform

			ZProj.TweenHelper.DOAnchorPos(transform, targetPos.x, targetPos.y, 0.5)
		end
	end
end

function AutoChessEntity:playEffect(effectId, param)
	if param and param.flyPos then
		gohelper.setAsLastSibling(self.go)
	end

	local effectCo = AutoChessConfig.instance:getEffectCfg(effectId)

	if effectCo then
		self.effectComp:playEffect(effectCo, param)
	end

	return (effectCo or nil) and (effectCo.duration or 0)
end

function AutoChessEntity:onUpdateExtInfo()
	local sceneMo = AutoChessModel.instance:getSceneMo()
	local extInfo = sceneMo and sceneMo.extInfo

	if extInfo then
		local isBuyChess = self.mo.uid == extInfo.lastBuyChessUid

		if self.lastBuy and not isBuyChess then
			self.effectComp:removeEffect(40008)

			self.lastBuy = false
		elseif not self.lastBuy and isBuyChess then
			self:playEffect(40008)

			self.lastBuy = true
		end

		local isDamageExtra = tabletool.indexOf(extInfo.damageExtraTargetChessUids, self.mo.uid)

		if self.damageExtra and not isDamageExtra then
			self.effectComp:removeEffect(40006)

			self.damageExtra = false
		elseif not self.damageExtra and isDamageExtra then
			self:playEffect(40006)

			self.damageExtra = true
		end
	end
end

return AutoChessEntity
