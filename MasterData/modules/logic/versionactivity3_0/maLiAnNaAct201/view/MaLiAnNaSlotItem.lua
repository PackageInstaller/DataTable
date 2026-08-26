-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/view/MaLiAnNaSlotItem.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.MaLiAnNaSlotItem", package.seeall)

local MaLiAnNaSlotItem = class("MaLiAnNaSlotItem", ListScrollCellExtend)

function MaLiAnNaSlotItem:onInitView()
	self._imageShieldskill = gohelper.findChildImage(self.viewGO, "#image_Shield_skill")
	self._imageShieldskillBG = gohelper.findChildImage(self.viewGO, "#image_Shield_skillBG")
	self._imageFlagenemy = gohelper.findChildImage(self.viewGO, "#image_Flag_enemy")
	self._imageFlagenemy1 = gohelper.findChildImage(self.viewGO, "#image_Flag_enemy/#image_Flag_enemy1")
	self._imageframeenemy = gohelper.findChildImage(self.viewGO, "#image_Flag_enemy/#image_frame_enemy")
	self._imageframeenemy1 = gohelper.findChildImage(self.viewGO, "#image_Flag_enemy/#image_frame_enemy1")
	self._imageFlagmiddle = gohelper.findChildImage(self.viewGO, "#image_Flag_middle")
	self._imageframemiddle = gohelper.findChildImage(self.viewGO, "#image_Flag_middle/#image_frame_middle")
	self._imageframemiddle1 = gohelper.findChildImage(self.viewGO, "#image_Flag_middle/#image_frame_middle1")
	self._imageFlagmy = gohelper.findChildImage(self.viewGO, "#image_Flag_my")
	self._imageFlagmy1 = gohelper.findChildImage(self.viewGO, "#image_Flag_my/#image_Flag_my1")
	self._imageframemy = gohelper.findChildImage(self.viewGO, "#image_Flag_my/#image_frame_my")
	self._imageframemy1 = gohelper.findChildImage(self.viewGO, "#image_Flag_my/#image_frame_my1")
	self._gowhite = gohelper.findChild(self.viewGO, "Name/#go_white")
	self._txtnamemy = gohelper.findChildText(self.viewGO, "Name/#go_white/#txt_name_my")
	self._goblue = gohelper.findChild(self.viewGO, "Name/#go_blue")
	self._txtnameenemy = gohelper.findChildText(self.viewGO, "Name/#go_blue/#txt_name_enemy")
	self._gocrossPoint = gohelper.findChild(self.viewGO, "#go_crossPoint")
	self._imageIcon1 = gohelper.findChildImage(self.viewGO, "#image_Icon1")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#image_Icon")
	self._imageIcon2 = gohelper.findChildImage(self.viewGO, "#image_Icon2")
	self._imageIcon3 = gohelper.findChildImage(self.viewGO, "#image_Icon3")
	self._goRole = gohelper.findChild(self.viewGO, "RoleList/#go_Role")
	self._txthp = gohelper.findChildText(self.viewGO, "RoleList/#go_Role/hp/#txt_hp")
	self._goSolider = gohelper.findChild(self.viewGO, "RoleList/#go_Solider")
	self._imageBG = gohelper.findChildImage(self.viewGO, "RoleList/#go_Solider/#image_BG")
	self._txtRoleHP = gohelper.findChildText(self.viewGO, "RoleList/#go_Solider/image_RoleHPNumBG/#txt_RoleHP")
	self._txtaddHP = gohelper.findChildText(self.viewGO, "RoleList/#go_Solider/#txt_addHP")
	self._govxboom = gohelper.findChild(self.viewGO, "vx_eff/#go_vx_boom")
	self._govxheal = gohelper.findChild(self.viewGO, "vx_eff/#go_vx_heal")
	self._govxglitch = gohelper.findChild(self.viewGO, "vx_eff/#go_vx_glitch")
	self._govxflash = gohelper.findChild(self.viewGO, "vx_eff/#go_vx_flash")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaLiAnNaSlotItem:addEvents()
	return
end

function MaLiAnNaSlotItem:removeEvents()
	return
end

function MaLiAnNaSlotItem:_editableInitView()
	self._tr = self.viewGO.transform
	self._parent = self._tr.parent
	self._playerCanvasGroup = self._imageFlagmy:GetComponent(gohelper.Type_CanvasGroup)
	self._enemyCanvasGroup = self._imageFlagenemy:GetComponent(gohelper.Type_CanvasGroup)
	self._middleCanvasGroup = self._imageFlagmiddle:GetComponent(gohelper.Type_CanvasGroup)
	self._middleFrameCanvasGroup = self._imageframemiddle:GetComponent(gohelper.Type_CanvasGroup)

	CommonDragHelper.instance:registerDragObj(self.viewGO, self._beginDrag, self._onDrag, self._endDrag, self._checkDrag, self, nil, true)

	self._click = gohelper.getClickWithDefaultAudio(self.viewGO)

	self._click:AddClickListener(self.onClick, self)

	self._goShieldskill = self._imageShieldskill.gameObject

	gohelper.setActive(self._goShieldskill, false)
	gohelper.setActive(self._imageShieldskillBG.gameObject, false)

	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._crossPointCanvasGroup = self._gocrossPoint:GetComponent(gohelper.Type_CanvasGroup)
	self._crossPointCanvasGroup.alpha = 0
end

function MaLiAnNaSlotItem:_editableAddEvents()
	return
end

function MaLiAnNaSlotItem:_editableRemoveEvents()
	return
end

function MaLiAnNaSlotItem:onClick()
	if self._slotData == nil then
		return
	end

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnClickSlot, self._slotData:getId())
end

function MaLiAnNaSlotItem:_beginDrag(_, pointerEventData)
	local position = pointerEventData.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragBeginSlot, self._slotData:getId(), position.x, position.y)
end

function MaLiAnNaSlotItem:_onDrag(_, pointerEventData)
	local position = pointerEventData.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragSlot, self._slotData:getId(), position.x, position.y)
end

function MaLiAnNaSlotItem:_endDrag(_, pointerEventData)
	local position = pointerEventData.position

	Activity201MaLiAnNaGameController.instance:dispatchEvent(Activity201MaLiAnNaEvent.OnDragEndSlot, self._slotData:getId(), position.x, position.y)
end

function MaLiAnNaSlotItem:_checkDrag()
	if self._slotData == nil then
		return true
	end

	return self._slotData:getSlotCamp() ~= Activity201MaLiAnNaEnum.CampType.Player or not not Activity201MaLiAnNaGameController.instance:getPause()
end

function MaLiAnNaSlotItem:initData(data)
	self._slotData = data
	self._lastCamp = nil
	self._soliderCount = nil
	self._heroCount = nil

	local config = self._slotData:getConfig()
	local picture = config.picture

	UISpriteSetMgr.instance:setMaliAnNaSprite(self._imageIcon, picture)

	local name = string.gsub(picture, "_0", "_1")

	UISpriteSetMgr.instance:setMaliAnNaSprite(self._imageIcon1, name)
	UISpriteSetMgr.instance:setMaliAnNaSprite(self._imageIcon2, name)
	UISpriteSetMgr.instance:setMaliAnNaSprite(self._imageIcon3, name)

	local x, y = self._slotData:getPosXY()

	self:initPos(x, y)

	if self._goSoliderItem == nil then
		self._goSoliderItem = self:getSoliderItemClone()
	end

	if self._heroItemList == nil then
		self._heroItemList = self:getUserDataTb_()
	end

	for _, item in pairs(self._heroItemList) do
		item.canvasGroup.alpha = 0
	end

	self:_initSkill()

	local config = self._slotData:getConfig()
	local showWhite = Activity201MaLiAnNaGameModel.instance:isMyCampBase(config.baseId)
	local showBlue = Activity201MaLiAnNaGameModel.instance:isEnemyBase(config.baseId)

	gohelper.setActive(self._gowhite, showWhite)
	gohelper.setActive(self._goblue, showBlue)
end

function MaLiAnNaSlotItem:getCamp()
	return self._slotData:getSlotCamp()
end

function MaLiAnNaSlotItem:_initSkill()
	local skill = self._slotData:getSkill()

	if skill ~= nil and isTypeOf(skill, MaLiAnNaSlotShieldPassiveSkill) and skill:getAngleAndRange() ~= nil then
		gohelper.setActive(self._goShieldskill, true)

		local startAngle, range = skill:getAngleAndRange()

		transformhelper.setLocalRotation(self._goShieldskill.transform, 0, 0, startAngle)

		self._imageShieldskill.fillAmount = range / 360
	end

	if skill and isTypeOf(skill, MaLiAnNaSlotKillSoliderPassiveSkill) then
		gohelper.setActive(self._imageShieldskillBG.gameObject, true)

		local effect = skill:getEffect()
		local range = effect[2]

		if range then
			local scale = range / 178

			transformhelper.setLocalScale(self._imageShieldskillBG.transform, scale, scale, scale)
		end
	end
end

function MaLiAnNaSlotItem:getRoleItemClone()
	local data = {}
	local go = gohelper.cloneInPlace(self._goRole, "soliderItem")

	gohelper.setActive(go, true)

	data.go = go
	data.tr = go.transform
	data.goSelf = gohelper.findChild(go, "go_Self")
	data.goEnemy = gohelper.findChild(go, "go_Enemy")
	data.goDead = gohelper.findChild(go, "go_Dead")
	data.goHp = gohelper.findChild(go, "hp")
	data.txtHp = gohelper.findChildText(go, "hp/#txt_hp")
	data.simage = gohelper.findChildSingleImage(go, "image/simage_Role")

	return data
end

function MaLiAnNaSlotItem:getSoliderItemClone()
	local data = {}
	local go = gohelper.cloneInPlace(self._goSolider, "soliderItem")

	data.go = go
	data.goAddHp = gohelper.findChild(go, "#txt_addHP")
	data.txtAddHp = gohelper.findChildText(go, "#txt_addHP")
	data.canvasGroup = go:GetComponent(gohelper.Type_CanvasGroup)
	data.txtNum = gohelper.findChildText(go, "image_RoleHPNumBG/#txt_RoleHP")
	data.imageBg = gohelper.findChildImage(go, "#image_BG")
	data.goDead = gohelper.findChild(go, "go_Dead")
	data.simage = gohelper.findChildSingleImage(go, "image/simage_solider")

	gohelper.setActive(data.goAddHp, false)
	gohelper.setActive(go, true)

	return data
end

function MaLiAnNaSlotItem:updateInfo(data)
	self._slotData = data

	local camp = self._slotData:getSlotCamp()
	local soliderCount, herCount = self._slotData:getSoliderCount()
	local campChange = false
	local soliderCountChange = false

	if self._lastCamp == nil or camp ~= self._lastCamp then
		campChange = true
		self._lastCamp = camp

		self:_updateCamp()
		self:reset()
	end

	if self._soliderCount == nil or soliderCount ~= self._soliderCount then
		soliderCountChange = true
		self._soliderCount = soliderCount

		self:_updateSoliderItem()
	end

	self._heroCount = herCount

	self:_updateSoliderHeroItem()

	if campChange then
		local name = ""

		if self._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy then
			name = Activity201MaLiAnNaEnum.slotAnimName.enemy
		end

		if self._lastCamp == Activity201MaLiAnNaEnum.CampType.Player then
			name = Activity201MaLiAnNaEnum.slotAnimName.my
		end

		self:playAnim((self._lastCamp == Activity201MaLiAnNaEnum.CampType.Middle or nil) and Activity201MaLiAnNaEnum.slotAnimName.middle)
		self:_updateSoliderItem()
	end
end

function MaLiAnNaSlotItem:_updateCamp()
	local isPlayer = self._lastCamp == Activity201MaLiAnNaEnum.CampType.Player
	local isEnemy = self._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy
	local isMiddle = self._lastCamp == Activity201MaLiAnNaEnum.CampType.Middle

	self._enemyCanvasGroup.alpha = isEnemy and 1 or 0
	self._playerCanvasGroup.alpha = isPlayer and 1 or 0
	self._middleCanvasGroup.alpha = isMiddle and 1 or 0
	self._middleFrameCanvasGroup.alpha = isMiddle and 1 or 0

	if self._goSoliderItem then
		UISpriteSetMgr.instance:setMaliAnNaSprite(self._goSoliderItem.imageBg, Activity201MaLiAnNaEnum.CampImageName[self._lastCamp])
	end
end

function MaLiAnNaSlotItem:_updateSoliderItem()
	if self._goSoliderItem then
		self._goSoliderItem.canvasGroup.alpha = self._soliderCount > 0 and 1 or 0
		self._goSoliderItem.txtNum.text = self._soliderCount

		gohelper.setActive(self._goSoliderItem.goDead, false)

		local solider = self._slotData:getNormalSolider()

		if solider then
			local config = solider:getConfig()
			local icon = config.icon

			if self._goSoliderItem.sImageIcon == nil or self._goSoliderItem.sImageIcon ~= icon then
				self._goSoliderItem.simage:LoadImage(solider:getSmallIcon())

				self._goSoliderItem.sImageIcon = icon
			end
		end
	end
end

function MaLiAnNaSlotItem:_updateSoliderHeroItem()
	local isPlayer = self._lastCamp == Activity201MaLiAnNaEnum.CampType.Player
	local isEnemy = self._lastCamp == Activity201MaLiAnNaEnum.CampType.Enemy

	if self._heroItemList then
		local maxCount = math.max(self._heroCount, tabletool.len(self._heroItemList))
		local heroList = self._slotData:getHeroSoliderList()

		for i = 1, maxCount do
			local item = self._heroItemList[i]

			if item == nil then
				item = self:getRoleItemClone()
				self._heroItemList[i] = item
			end

			local needShow = i <= self._heroCount

			if needShow and not item.go.activeSelf then
				gohelper.setActive(item.go, true)
			end

			if not needShow and item.go.activeSelf then
				gohelper.setActive(item.go, false)
			end

			if needShow then
				gohelper.setActive(item.goSelf, isPlayer)
				gohelper.setActive(item.goEnemy, isEnemy)
				gohelper.setActive(item.goDead, false)

				local heroData = heroList[i]
				local config = heroData:getConfig()
				local icon = config.icon

				if item.sImageIcon == nil or item.sImageIcon ~= icon then
					item.simage:LoadImage(heroData:getSmallIcon())

					item.sImageIcon = icon
				end

				local hp = heroData:getHp()

				if item.hp == nil or item.hp ~= hp then
					gohelper.setActive(item.goHp, hp > 0)

					item.txtHp.text = hp
					item.hp = hp
				end

				local x, y = transformhelper.getPos(item.tr)

				if item.x == nil or item.y == nil or item.x ~= x or item.y ~= y then
					local pos = self._parent:InverseTransformPoint(item.tr.position)

					heroData:setCurViewPos(pos.x, pos.y)

					item.x = x
					item.y = y
				end
			end
		end
	end
end

function MaLiAnNaSlotItem:playAnim(name)
	if self._anim and not string.nilorempty(name) and self._curAnimName ~= name then
		self._anim:Play(name, 0, 0)

		self._curAnimName = name
	end
end

function MaLiAnNaSlotItem:getAnimName()
	return self._curAnimName
end

function MaLiAnNaSlotItem:onDestroyView()
	self:_hideAdd()
	TaskDispatcher.cancelTask(self._hideAdd, self)
	TaskDispatcher.cancelTask(self._playVx, self)
	CommonDragHelper.instance:unregisterDragObj(self.viewGO)

	if self._click then
		self._click:RemoveClickListener()

		self._click = nil
	end
end

function MaLiAnNaSlotItem:initPos(posX, posY)
	self._localPosX = posX
	self._localPosY = posY

	transformhelper.setLocalPosXY(self._tr, posX, posY)
end

function MaLiAnNaSlotItem:showVxBySkill(skillAction, delayTime)
	self._needPlayGo = nil
	self._needPlayAudioId = nil

	if skillAction == Activity201MaLiAnNaEnum.SkillAction.addSlotSolider then
		self._needPlayGo = self._govxheal
		self._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_lushang_reinforce
	end

	if skillAction == Activity201MaLiAnNaEnum.SkillAction.removeSlotSolider then
		self._needPlayGo = self._govxboom
		self._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_youyu_attack_3
	end

	if skillAction == Activity201MaLiAnNaEnum.SkillAction.moveSlotSolider then
		self._needPlayGo = self._govxflash
		self._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_youyu_front_buff
	end

	if skillAction == Activity201MaLiAnNaEnum.SkillAction.pauseSlotGenerateSolider then
		self._needPlayGo = self._govxglitch
		self._needPlayAudioId = AudioEnum3_0.MaLiAnNa.play_ui_lushang_interference
	end

	if delayTime == nil or delayTime == 0 then
		self:_playVx()
	else
		TaskDispatcher.runDelay(self._playVx, self, delayTime)
	end
end

function MaLiAnNaSlotItem:_playVx()
	if self._needPlayGo ~= nil then
		if self._needPlayGo.activeSelf then
			gohelper.setActive(self._needPlayGo, false)
		end

		if self._needPlayAudioId ~= nil then
			AudioMgr.instance:trigger(self._needPlayAudioId)
		end

		gohelper.setActive(self._needPlayGo, true)

		self._needPlayGo = nil
	end
end

function MaLiAnNaSlotItem:reset()
	self._needPlayGo = nil
	self._needPlayAudioId = nil

	gohelper.setActive(self._govxheal, false)
	gohelper.setActive(self._govxflash, false)
	gohelper.setActive(self._govxglitch, false)

	if self._heroItemList then
		for _, item in pairs(self._heroItemList) do
			item.x = nil
			item.y = nil
			item.hp = nil
		end
	end
end

function MaLiAnNaSlotItem:setMiddlePointActive(active)
	self._crossPointCanvasGroup.alpha = active and 1 or 0
end

function MaLiAnNaSlotItem:showAddSolider(addValue)
	if self._goSoliderItem == nil then
		return
	end

	if self._goSoliderItem == nil or self._goSoliderItem.goAddHp.activeSelf then
		gohelper.setActive(self._goSoliderItem.goAddHp, false)
	end

	self._goSoliderItem.txtAddHp.text = "+" .. addValue

	gohelper.setActive(self._goSoliderItem.goAddHp, true)
	TaskDispatcher.runDelay(self._hideAdd, self, 1)
end

function MaLiAnNaSlotItem:_hideAdd()
	if self._goSoliderItem == nil then
		return
	end

	gohelper.setActive(self._goSoliderItem.goAddHp, false)
end

return MaLiAnNaSlotItem
