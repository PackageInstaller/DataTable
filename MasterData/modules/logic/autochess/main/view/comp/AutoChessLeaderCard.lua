-- chunkname: @modules/logic/autochess/main/view/comp/AutoChessLeaderCard.lua

module("modules.logic.autochess.main.view.comp.AutoChessLeaderCard", package.seeall)

local AutoChessLeaderCard = class("AutoChessLeaderCard", LuaCompBase)

AutoChessLeaderCard.ShowType = {
	HandBook = 1
}

function AutoChessLeaderCard:init(go)
	self.go = go
	self.simageBg = gohelper.findChildSingleImage(go, "bg")
	self._goMesh = gohelper.findChild(go, "Leader/Mesh")
	self._txtName = gohelper.findChildText(go, "Leader/namebg/#txt_Name")
	self._txtHp = gohelper.findChildText(go, "hp/#txt_Hp")
	self._simageSkill = gohelper.findChildSingleImage(go, "#simage_Skill")
	self._goScroll = gohelper.findChildScrollRect(go, "#go_Scroll")
	self._txtSkillDesc = gohelper.findChildText(go, "#go_Scroll/viewport/content/#txt_SkillDesc")
	self._goTip = gohelper.findChild(go, "#go_Tip")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(go, "#go_Tip/#btn_CloseTip")
	self._txtTipTitle = gohelper.findChildText(go, "#go_Tip/#txt_TipTitle")
	self._txtTip = gohelper.findChildText(go, "#go_Tip/scroll_tips/viewport/#txt_Tip")
	self._btnCheck = gohelper.findChildButtonWithAudio(go, "#btn_Check")
	self._goLock = gohelper.findChild(go, "#go_Lock")
	self._txtLock = gohelper.findChildText(go, "#go_Lock/#txt_Lock")
	self._goNew = gohelper.findChild(go, "#go_New")
	self.meshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._goMesh, AutoChessMeshComp)

	SkillHelper.addHyperLinkClick(self._txtSkillDesc, self.clcikHyperLink, self)

	self._limitScroll = self._goScroll:GetComponent(gohelper.Type_LimitedScrollRect)
	self.goChess = gohelper.findChild(go, "Chess")
	self.txtChessSkill = gohelper.findChildText(self.goChess, "scroll_desc/viewport/content/txt_ChessSkill")

	SkillHelper.addHyperLinkClick(self.txtChessSkill, self.clcikHyperLink, self)

	self.imageChessBg = gohelper.findChildImage(self.goChess, "chess/image_ChessBg")
	self.goChessMesh = gohelper.findChild(self.goChess, "chess/Mesh")
	self.txtChessName = gohelper.findChildText(self.goChess, "chess/txt_ChessName")
	self.goChessHp = gohelper.findChild(self.goChess, "go_ChessHp")
	self.txtChessHp = gohelper.findChildText(self.goChess, "go_ChessHp/txt_ChessHp")
	self.goChessAttack = gohelper.findChild(self.goChess, "go_ChessAttack")
	self.txtChessAttack = gohelper.findChildText(self.goChess, "go_ChessAttack/txt_ChessAttack")
	self.chessMeshComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goChessMesh, AutoChessMeshComp)
end

function AutoChessLeaderCard:addEventListeners()
	self.addClickCb(self, self._btnCloseTip, self._btnCloseTipOnClick, self)
	self.addClickCb(self, self._btnCheck, self._btnCheckOnClick, self)
end

function AutoChessLeaderCard:_btnCloseTipOnClick()
	gohelper.setActive(self._goTip, false)
end

function AutoChessLeaderCard:_btnCheckOnClick()
	ViewMgr.instance:openView(ViewName.AutoChessLeaderShowView, {
		leaderId = self.config.id
	})
end

function AutoChessLeaderCard:setData(data)
	self.data = data

	if data.leaderId then
		self.config = AutoChessConfig.instance:getLeaderCfg(data.leaderId)

		self:refreshCommon(false)
		self:refreshSkillDesc()

		if self.config.isSpMaster and data.freshLock then
			local unlockLvl = AutoChessConfig.instance:getLeaderUnlockLevel(self.config.id)
			local actMo = Activity182Model.instance:getActMo()

			self.isLock = unlockLvl > actMo.warnLevel
			self._txtLock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_warnlevel_unlock"), unlockLvl)

			gohelper.setActive(self._goLock, self.isLock)
		else
			gohelper.setActive(self._goLock, false)
		end
	else
		self.sceneMo = AutoChessModel.instance:getSceneMo()

		local masterMo = data.leader

		self.config = masterMo.config

		local isEnemy = masterMo.teamType == AutoChessEnum.TeamType.Enemy

		self:refreshCommon(isEnemy)
		self:refreshSkillDesc2(masterMo)
	end

	if data.tipPos then
		recthelper.setAnchor(self._goTip.transform, data.tipPos.x, data.tipPos.y)
	end

	if data.type == AutoChessLeaderCard.ShowType.HandBook then
		self:refreshHandbook()
	end
end

function AutoChessLeaderCard:refreshCommon(isEnemy)
	if self.config.isSpMaster then
		self.simageBg:LoadImage(ResUrl.getMovingChessIcon("movingchess_handbook_specialbg", "handbook"))
	else
		self.simageBg:LoadImage(ResUrl.getMovingChessIcon("movingchess_handbook_normalbg", "handbook"))
	end

	self.meshComp:setData(self.config.image, isEnemy, true)

	self._txtName.text = self.config.name
	self._txtHp.text = self.config.hp

	self._simageSkill:LoadImage(ResUrl.getAutoChessIcon(self.config.skillIcon, "skillicon"))

	if self.config.spUdimo ~= 0 then
		local chessCfg = AutoChessConfig.instance:getChessCfgAnyway(self.config.spUdimo)

		if chessCfg then
			self.chessMeshComp:setData(chessCfg.image, isEnemy)

			if chessCfg.type ~= AutoChessStrEnum.ChessType.Support then
				self.txtChessAttack.text = chessCfg.attack
				self.txtChessHp.text = chessCfg.hp
			end

			self.txtChessName.text = chessCfg.name
			self.txtChessSkill.text = AutoChessHelper.buildSkillDesc(chessCfg.skillDesc)

			local imageName = AutoChessHelper.getChessQualityBg(chessCfg.type, chessCfg.levelFromMall)

			UISpriteSetMgr.instance:setAutoChessSprite(self.imageChessBg, imageName)
			gohelper.setActive(self.goChessHp, chessCfg.type ~= AutoChessStrEnum.ChessType.Support)
			gohelper.setActive(self.goChessAttack, chessCfg.type ~= AutoChessStrEnum.ChessType.Support)
		end
	end

	gohelper.setActive(self.goChess, self.config.spUdimo ~= 0)
end

function AutoChessLeaderCard:refreshSkillDesc()
	local skillDesc = self.config.skillDesc
	local skillLockDesc = self.config.skillLockDesc
	local params = AutoChessHelper.getLeaderSkillEffect(self.config.skillId)

	if params then
		if params[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
			skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]))
		elseif params[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
			skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]))
		elseif params[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
			skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]))
		end
	end

	self._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(skillDesc) .. skillLockDesc
end

function AutoChessLeaderCard:clcikHyperLink(effId, _)
	if self.data.type == AutoChessLeaderCard.ShowType.HandBook then
		recthelper.setAnchor(self._goTip.transform, 0, 99)
	end

	local descCo = AutoChessConfig.instance:getSkillEffectDesc(tonumber(effId))

	if descCo then
		self._txtTipTitle.text = descCo.name
		self._txtTip.text = descCo.desc

		gohelper.setActive(self._goTip, true)
	end
end

function AutoChessLeaderCard:refreshSkillDesc2(leader)
	local skillDesc = self.config.skillDesc
	local skillProDesc = self.config.skillProgressDesc
	local skillLockDesc = leader.skill.unlock and "" or self.config.skillLockDesc
	local params = AutoChessHelper.getLeaderSkillEffect(leader.skill.id)

	if params then
		if params[1] == AutoChessStrEnum.SkillEffect.GrowUpNow2 then
			local buyCnt = AutoChessHelper.getBuyChessCntByType(self.sceneMo.baseInfo.buyInfos, "Forest")
			local quotient = math.floor(buyCnt / tonumber(params[4]))
			local remainder = buyCnt % tonumber(params[4])

			skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]) + tonumber(params[5]) * quotient)
			skillProDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillProDesc, tonumber(params[4]) - remainder)
		elseif params[1] == AutoChessStrEnum.SkillEffect.RoundAddCoin then
			local round = self.sceneMo.baseInfo.sceneRound

			skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]) + tonumber(params[3]) * (round - 1))
		elseif params[1] == AutoChessStrEnum.SkillEffect.DigTreasure or params[1] == AutoChessStrEnum.SkillEffect.DigTreasureSP then
			local needCnt = 0

			for _, ability in ipairs(leader.skill.abilities) do
				if ability.type == params[1] then
					needCnt = ability.extraInt1

					break
				end
			end

			skillProDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillProDesc, needCnt)
		elseif params[1] == AutoChessStrEnum.SkillEffect.AdditionalDamage then
			local round = self.sceneMo.baseInfo.sceneRound
			local needCnt = tonumber(params[3])

			if round < needCnt then
				skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]))
				skillProDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillProDesc, needCnt - round)
			else
				skillDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillDesc, tonumber(params[2]) + tonumber(params[4]))
				skillProDesc = ""
			end
		elseif params[1] == AutoChessStrEnum.SkillEffect.MasterTransfigurationBuyChess then
			local buyCnt = AutoChessHelper.getBuyChessCnt(self.sceneMo.baseInfo.buyInfos, tonumber(params[3]))

			skillProDesc = GameUtil.getSubPlaceholderLuaLangOneParam(skillProDesc, tonumber(params[4] - buyCnt))
		end
	end

	self._txtSkillDesc.text = AutoChessHelper.buildSkillDesc(skillDesc) .. skillProDesc .. skillLockDesc
end

function AutoChessLeaderCard:setActive(active)
	gohelper.setActive(self.go, active)

	if not active and self._goTip.activeInHierarchy then
		gohelper.setActive(self._goTip, false)
	end
end

function AutoChessLeaderCard:refreshNewTag()
	gohelper.setActive(self._goNew, (not self.isLock or nil) and AutoChessHelper.getUnlockReddot(AutoChessStrEnum.ClientReddotKey.SpecialLeader, self.config.id))
end

function AutoChessLeaderCard:setScrollParentGo(go)
	self._limitScroll.parentGameObject = go
end

function AutoChessLeaderCard:refreshHandbook()
	gohelper.setActive(self._btnCheck.gameObject, true)
	gohelper.setActive(self.goChess, false)
end

return AutoChessLeaderCard
