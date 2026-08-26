-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/EliminateLevelRewardView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateLevelRewardView", package.seeall)

local EliminateLevelRewardView = class("EliminateLevelRewardView", BaseView)

function EliminateLevelRewardView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnresult = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_result")
	self._goreward = gohelper.findChild(self.viewGO, "#btn_result/#go_reward")
	self._txtClick = gohelper.findChildText(self.viewGO, "#txt_Click")
	self._txtcontinue = gohelper.findChildText(self.viewGO, "#txt_continue")
	self._goTips = gohelper.findChild(self.viewGO, "#go_Tips")
	self._scrollTips = gohelper.findChildScrollRect(self.viewGO, "#go_Tips/#scroll_Tips")
	self._goLayoutGroup = gohelper.findChild(self.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup")
	self._goTipsItem = gohelper.findChild(self.viewGO, "#go_Tips/#scroll_Tips/Viewport/#go_LayoutGroup/#go_TipsItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EliminateLevelRewardView:addEvents()
	self._btnresult:AddClickListener(self._btnresultOnClick, self)
end

function EliminateLevelRewardView:removeEvents()
	self._btnresult:RemoveClickListener()
end

function EliminateLevelRewardView:_btnresultOnClick()
	if self._canClose then
		ViewMgr.instance:closeView(ViewName.EliminateLevelRewardView)
	else
		self:openRewardTip()
	end
end

function EliminateLevelRewardView:_editableInitView()
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.Victory)
end

function EliminateLevelRewardView:onUpdateParam()
	return
end

function EliminateLevelRewardView:onOpen()
	self._resultData = EliminateTeamChessModel.instance:getWarFightResult()

	self:refreshViewByResult()

	self._canClose = false

	gohelper.setActive(self._goTips, self._canClose)
	gohelper.setActive(self._goreward, not self._canClose)
	gohelper.setActive(self._txtClick.gameObject, not self._canClose)
	gohelper.setActive(self._txtcontinue.gameObject, self._canClose)
	gohelper.setActive(self._btnresult, not self._canClose)
end

function EliminateLevelRewardView:refreshViewByResult()
	local result = self._resultData:getResultInfo()

	for key, value in pairs(result) do
		if key == "unlockCharacterIds" then
			self:refreshCharacterResult(value)
		end

		if key == "unlockChessPieceIds" then
			self:refreshPieceResult(value)
		end

		if key == "unlockSlotIds" then
			self:refreshSlotResult(value)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_reward_fall)
end

function EliminateLevelRewardView:refreshCharacterResult(characterIds)
	for _, characterId in ipairs(characterIds) do
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(characterId)

		if characterConfig ~= nil then
			self:refreshTipInfo(characterId, EliminateTeamChessEnum.ResultRewardType.character)
		end
	end
end

function EliminateLevelRewardView:refreshPieceResult(pieceIds)
	for _, pieceId in ipairs(pieceIds) do
		local soldierChessConfig = EliminateConfig.instance:getSoldierChessConfig(pieceId)

		if soldierChessConfig ~= nil then
			self:refreshTipInfo(pieceId, EliminateTeamChessEnum.ResultRewardType.chessPiece)
		end
	end
end

function EliminateLevelRewardView:refreshSlotResult(slots)
	for _, slot in ipairs(slots) do
		self:refreshTipInfo(slot, EliminateTeamChessEnum.ResultRewardType.slot)
	end
end

function EliminateLevelRewardView:refreshTipInfo(id, type)
	if self._rewardItem == nil then
		self._rewardItem = self:getUserDataTb_()
	end

	local item = gohelper.clone(self._goTipsItem, self._goLayoutGroup)
	local haveChess = gohelper.findChild(item, "#go_chessTip/Info/#go_HaveChess")
	local chessImageBg = gohelper.findChildImage(item, "#go_chessTip/Info/#go_HaveChess/image_ChessBG")
	local chessImage = gohelper.findChildSingleImage(item, "#go_chessTip/Info/#go_HaveChess/#image_Chess")
	local addGo = gohelper.findChild(item, "#go_chessTip/Info/#go_Add")
	local roleGo = gohelper.findChild(item, "#go_chessTip/Info/#go_Role")
	local roleHp = gohelper.findChildText(item, "#go_chessTip/Info/#go_Role/Role/image_RoleHPNumBG/#txt_RoleHP")
	local RoleSImage = gohelper.findChildSingleImage(item, "#go_chessTip/Info/#go_Role/Role/#simage_Role")
	local resourceGo = gohelper.findChild(item, "#go_chessTip/Info/#go_Resource")
	local resourceItem = gohelper.findChild(item, "#go_chessTip/Info/#go_Resource/#go_ResourceItem")
	local fireTxt = gohelper.findChildText(item, "#go_chessTip/Info/image_Fire/#txt_FireNum")
	local imageFire = gohelper.findChildImage(item, "#go_chessTip/Info/image_Fire")
	local txt_ChessName = gohelper.findChildText(item, "#go_chessTip/Info/#txt_ChessName")
	local skillGo = gohelper.findChild(item, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill")
	local roleSkillImage = gohelper.findChildImage(item, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillBG/GameObject/#image_RoleSkill")
	local roleSkillCostNum = gohelper.findChildText(item, "#go_chessTip/Scroll View/Viewport/Content/#go_Skill/Skill/image_SkillEnergyBG/#txt_RoleCostNum")
	local txt_Descr = gohelper.findChildText(item, "#go_chessTip/Scroll View/Viewport/Content/#txt_Descr")
	local isSlot = type == EliminateTeamChessEnum.ResultRewardType.slot
	local isCharacter = type == EliminateTeamChessEnum.ResultRewardType.character
	local isChessPiece = type == EliminateTeamChessEnum.ResultRewardType.chessPiece

	gohelper.setActive(haveChess, isChessPiece)
	gohelper.setActive(addGo, isSlot)
	gohelper.setActive(resourceGo, isSlot)
	gohelper.setActive(imageFire.gameObject, isChessPiece)
	gohelper.setActive(roleGo, isCharacter)
	gohelper.setActive(skillGo, isCharacter)

	local desc = ""
	local name = ""

	if isSlot then
		name = luaLang("eliminate_teamchess_new_slot_name")
		desc = luaLang("eliminate_teamchess_new_slot_desc")
	end

	if isCharacter then
		local characterConfig = EliminateConfig.instance:getTeamChessCharacterConfig(id)

		name = characterConfig.name

		local activeSkillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.activeSkillIds)
		local passiveSkillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(characterConfig.passiveSkillIds)

		if not string.nilorempty(activeSkillConfig.desc) then
			desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_activeSkill_desc"), activeSkillConfig.desc) .. "\n"
		end

		if not string.nilorempty(passiveSkillConfig.desc) then
			desc = desc .. GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("eliminate_teamchess_passiveSkill_desc"), passiveSkillConfig.desc)
		end

		if activeSkillConfig then
			if not activeSkillConfig.icon then
				local icon = ""

				if not string.nilorempty(icon) then
					UISpriteSetMgr.instance:setV2a2EliminateSprite(roleSkillImage, icon, false)
				end

				roleSkillCostNum.text = activeSkillConfig.cost

				if not string.nilorempty(characterConfig.resPic) then
					RoleSImage:LoadImage(ResUrl.getHeadIconSmall(characterConfig.resPic))
				end

				roleHp.text = characterConfig.hp
			end
		end
	end

	if isChessPiece then
		local config = EliminateConfig.instance:getSoldierChessConfig(id)

		desc = EliminateConfig.instance:getSoldierChessDesc(id)
		name = config.name
		fireTxt.text = config.defaultPower

		local cost, _ = EliminateConfig.instance:getSoldierChessConfigConst(id)

		self._resourceItem = self:getUserDataTb_()

		for _, cost in ipairs(cost) do
			local resourceId = cost[1]
			local num = cost[2]
			local item = gohelper.clone(resourceItem, resourceGo, resourceId)
			local resourceImage = gohelper.findChildImage(item, "#image_ResourceQuality")
			local resourceNumberText = gohelper.findChildText(item, "#image_ResourceQuality/#txt_ResourceNum")

			UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

			resourceNumberText.text = num

			gohelper.setActive(item, true)
			table.insert(self._resourceItem, item)
		end

		if config and not string.nilorempty(config.resPic) then
			SurvivalUnitIconHelper.instance:setNpcIcon(chessImage, config.resPic)
		end

		UISpriteSetMgr.instance:setV2a2EliminateSprite(chessImageBg, "v2a2_eliminate_infochess_qualitybg_0" .. config.level, false)
	end

	txt_Descr.text = EliminateLevelModel.instance.formatString(desc)
	txt_ChessName.text = name

	gohelper.setActive(item, true)
	table.insert(self._rewardItem, item)
end

function EliminateLevelRewardView:openRewardTip()
	gohelper.setActive(self._goTips, true)
	gohelper.setActive(self._txtClick.gameObject, false)
	gohelper.setActive(self._txtcontinue.gameObject, true)
	gohelper.setActive(self._goreward, false)

	self._canClose = true
end

function EliminateLevelRewardView:onClose()
	return
end

function EliminateLevelRewardView:onDestroyView()
	ViewMgr.instance:openView(ViewName.EliminateLevelResultView)
end

return EliminateLevelRewardView
