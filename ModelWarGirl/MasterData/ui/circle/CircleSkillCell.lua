-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleSkillCell.lua

local strClassName = "CircleSkillCell"
local CircleSkillCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function CircleSkillCell:ctor()
	self:initUI()
end

function CircleSkillCell:initUI()
	self.imgIcon = UIControls.Image(self, "Icon")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtType = UIControls.Label(self, "TextType")
	self.txtDes = UIControls.Label(self, "TextDes")
	self.panelLimit = UIControls.Panel(self, "LimitPanel")
	self.txtLimit = UIControls.Label(self, "LimitPanel/TextNum")
	self.btnBuy = UIControls.Button(self, "BtnBuy")

	self.btnBuy:addEventClick(self.onBtnBuyClick)

	self.imgContribute = UIControls.Image(self, "BtnBuy/Icon")
	self.txtPrice = UIControls.Label(self, "BtnBuy/TextNum")
	self.btnUse = UIControls.Button(self, "BtnUse")

	self.btnUse:addEventClick(self.onBtnUseClick)

	self.txtRemainTimes = UIControls.Label(self, "BtnUse/Text")
	self.panelPassiveState = UIControls.Panel(self, "StatePanel1")
	self.panelSkillUseUp = UIControls.Panel(self, "StatePanel2")
	self.imgIconSp = UIControls.Image(self, "IconSp")
end

function CircleSkillCell:setCircleSkill(circleSkill)
	self.circleSkill = circleSkill

	local contributeIconPath = UIConst.CIRCLE_BATTLE_CONTRIBUTE_PATH

	if contributeIconPath then
		self.imgContribute:setImage(contributeIconPath[1], contributeIconPath[2])
	end

	self:setCellGray(false)

	if self.circleSkill.heroId then
		local headPath = self.circleSkill:getHeroHeadPath()

		if headPath then
			self.imgIcon:setImage(headPath[1], headPath[2])
		end
	else
		local iconPath = self.circleSkill:getIconPath()

		if iconPath then
			self.imgIcon:setImage(iconPath[1], iconPath[2])
		end
	end

	self.txtName:setText(self.circleSkill.name)
	self.txtType:setText(Const.CIRCLE_BATTLE_SKILL_TYPE_NAME[self.circleSkill.type])
	self.txtDes:setText(self.circleSkill.desc)

	local remainTimes, totalTimes = self.circleSkill:getUseTimes()

	if not self.circleSkill.isHave and self.circleSkill.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE then
		self.panelLimit:setVisible(true)

		if self.circleSkill.resData.effect then
			self.txtLimit:setText(utils.format(Lang.get(40575), totalTimes))
		end
	else
		self.panelLimit:setVisible(false)
	end

	if self.circleSkill.isHave then
		self.btnBuy:setVisible(false)
		self.btnUse:setVisible(false)
		self.panelSkillUseUp:setVisible(false)

		if remainTimes > 0 and self.circleSkill.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE then
			self.btnUse:setVisible(true)
			self.txtRemainTimes:setText(utils.format(Lang.get(36311), remainTimes, totalTimes))
		elseif self.circleSkill.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE then
			self.panelSkillUseUp:setVisible(true)
			self:setCellGray(true)
		end

		self.panelPassiveState:setVisible(self.circleSkill.type ~= Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE)
	else
		self.panelPassiveState:setVisible(false)
		self.panelSkillUseUp:setVisible(false)
		self.btnUse:setVisible(false)
		self.btnBuy:setVisible(true)
		self.imgIconSp:setImage("Atlas/StoreAtlas/StoreAtlas", "TxtRec")
		self.imgIconSp:setVisible(self.circleSkill.resData.rec_flag and self.circleSkill.resData.rec_flag == 1)
		self.txtPrice:setText(ClientUtils.getNumShortStr(self.circleSkill.contribution))

		if CurAvatar.myCircle then
			local priceColor = self.circleSkill.contribution <= CurAvatar.myCircle:getCircleContribution() and ResColor.WHITE or ResColor.RED

			self.txtPrice:setFontColor(priceColor)
		end
	end
end

function CircleSkillCell:setCellGray(isGray)
	if self.imgIcon and self.imgIcon:getVisible() then
		self.imgIcon:setImageGray(isGray)
	end

	if self.btnUse and self.btnUse:getVisible() then
		self.btnUse:setObjGray(isGray)
	end
end

function CircleSkillCell:onBtnUseClick()
	if CurAvatar and CurAvatar.myCircle then
		local permission = CurAvatar:getMyDutyPermission()

		if not permission.battle_use_skill then
			MsgManager.clientNotice(557)

			return
		end

		local remainTimes, totalTimes = self.circleSkill:getUseTimes()

		if remainTimes <= 0 then
			MsgManager.clientNotice(558)

			return
		end

		local findAllBoss, findAllRune, findAllBox = CurAvatar.myCircle:isNeedUseSkill()

		if findAllBoss and self.circleSkill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_BOSS then
			local noticeStr = utils.format(ClientUtils.getClientNotice(591), Lang.get(37171))

			MsgManager.notice(noticeStr)

			return
		end

		if findAllBox and self.circleSkill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_BOX then
			local noticeStr = utils.format(ClientUtils.getClientNotice(591), Lang.get(6576))

			MsgManager.notice(noticeStr)

			return
		end

		if findAllRune and self.circleSkill.id == Const.CIRCLE_BATTLE_SKILL_ID.SHOW_RUNE then
			local noticeStr = utils.format(ClientUtils.getClientNotice(591), Lang.get(33222))

			MsgManager.notice(noticeStr)

			return
		end

		local function cbYes()
			CurAvatar:tryCallCircleBattleRpc("clanBattleUseSkill", CurAvatar.myCircle:getCurBattleLayer(), self.circleSkill.id)
		end

		UIManager.showConfirmWithId(1052, cbYes)
	end
end

function CircleSkillCell:onBtnBuyClick()
	if CurAvatar.myCircle then
		local permission = CurAvatar:getMyDutyPermission()

		if not permission.battle_buy_skill then
			MsgManager.clientNotice(559)

			return
		end

		if CurAvatar.myCircle:getCircleContribution() >= self.circleSkill.contribution then
			local function cbYes()
				CurAvatar:tryCallCircleBattleRpc("clanBattleBuySkill", self.circleSkill.id)
			end

			UIManager.showConfirmWithId(1051, cbYes)
		else
			MsgManager.clientNotice(560)
		end
	end
end

return CircleSkillCell
