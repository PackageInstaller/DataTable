-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/CharacterSkillTipView.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipView", package.seeall)

local CharacterSkillTipView = class("CharacterSkillTipView", BaseView)

function CharacterSkillTipView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._gochessTip = gohelper.findChild(self.viewGO, "#go_chessTip")
	self._imageRoleSkill = gohelper.findChildImage(self.viewGO, "#go_chessTip/Info/image/#image_RoleSkill")
	self._simageRoleSkill = gohelper.findChildSingleImage(self.viewGO, "#go_chessTip/Info/image/#image_RoleSkill")
	self._goSkillEnergyBG = gohelper.findChild(self.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG")
	self._txtRoleCostNum = gohelper.findChildText(self.viewGO, "#go_chessTip/Info/#go_SkillEnergyBG/#txt_RoleCostNum")
	self._txtSkillName = gohelper.findChildText(self.viewGO, "#go_chessTip/Info/#txt_SkillName")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_chessTip/Scroll View/Viewport/#txt_Descr")
	self._btnclick2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click_2")
	self._gochessTip2 = gohelper.findChild(self.viewGO, "#go_chessTip_2")
	self._imageChessQualityBG = gohelper.findChildImage(self.viewGO, "#go_chessTip_2/Info/#image_ChessQualityBG")
	self._imageChess = gohelper.findChildSingleImage(self.viewGO, "#go_chessTip_2/Info/#image_Chess")
	self._goResource = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/#go_Resource")
	self._goResourceItem = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem")
	self._imageResourceQuality = gohelper.findChildImage(self.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	self._txtResourceNum = gohelper.findChildText(self.viewGO, "#go_chessTip_2/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	self._txtFireNum = gohelper.findChildText(self.viewGO, "#go_chessTip_2/Info/image_Fire/#txt_FireNum")
	self._goStar1 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star1")
	self._goStar2 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star2")
	self._goStar3 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star3")
	self._goStar4 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star4")
	self._goStar5 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star5")
	self._goStar6 = gohelper.findChild(self.viewGO, "#go_chessTip_2/Info/Stars/#go_Star6")
	self._txtChessName = gohelper.findChildText(self.viewGO, "#go_chessTip_2/Info/#txt_ChessName")
	self._txtchessDescr = gohelper.findChildText(self.viewGO, "#go_chessTip_2/Scroll View/Viewport/#txt_chess_Descr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterSkillTipView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnclick2:AddClickListener(self._btnclick2OnClick, self)
end

function CharacterSkillTipView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnclick2:RemoveClickListener()
end

function CharacterSkillTipView:_btnclick2OnClick()
	self:hideSoliderInfo()
end

function CharacterSkillTipView:_btnclickOnClick()
	if self._clickBgCb then
		self._clickBgCb(self._clickBgCbTarget)
	end

	self:hideView()
end

function CharacterSkillTipView:_editableInitView()
	self._chessTipAni = self._gochessTip:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterSkillTipView:onUpdateParam()
	return
end

function CharacterSkillTipView:onOpen()
	local param = self.viewParam

	self._showType = param.showType

	local skillId = param.skillId
	local forecastChess = param.forecastChess
	local parent = param.point

	if self._showType == EliminateLevelEnum.skillShowType.skill then
		self:setSkillId(skillId)
	end

	if self._showType == EliminateLevelEnum.skillShowType.forecast then
		self:setForecastChess(forecastChess)
	end

	self:setChessTip2Active(false)
	self:setPoint(parent)
end

function CharacterSkillTipView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function CharacterSkillTipView:setSkillId(skillId)
	self._skillId = skillId

	local skillConfig = EliminateConfig.instance:getMainCharacterSkillConfig(skillId)

	if skillConfig then
		self._txtSkillName.text = skillConfig.name or ""
	end

	self._txtDescr.text = skillConfig and EliminateLevelModel.instance.formatString(skillConfig.desc) or ""

	if skillConfig then
		self._txtRoleCostNum.text = skillConfig.cost or ""
	end

	if skillConfig then
		if not skillConfig.icon then
			local icon = ""

			if not string.nilorempty(icon) then
				UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageRoleSkill, icon, false)
			end

			self:refreshShowByType()
		end
	end
end

function CharacterSkillTipView:setForecastChess(forecastChess)
	local forecastData = forecastChess[1]
	local chessId = forecastData.chessId
	local config = EliminateConfig.instance:getSoldierChessConfig(chessId)

	if config then
		if not config.resPic then
			local icon = ""

			if not string.nilorempty(icon) then
				SurvivalUnitIconHelper.instance:setNpcIcon(self._simageRoleSkill, icon)
				gohelper.setActive(self._goEnemySkill, true)
			end

			local curRound = EliminateLevelModel.instance:getRoundNumber()
			local desc = ""
			local tempDesc = lua_eliminate_cost.configDict[39].value

			for i = 1, #forecastChess do
				local data = forecastChess[i]
				local chessId = data.chessId

				config = EliminateConfig.instance:getSoldierChessConfig(chessId)

				local round = forecastData.round
				local residueRound = round - curRound
				local name = string.format("<color=#4e6698>【<u><link=%s>%s</link></u>】", chessId, config.name)

				desc = GameUtil.getSubPlaceholderLuaLangTwoParam(tempDesc, residueRound, name) .. "\n"
			end

			self._txtDescr.text = desc

			local hyperLinkClick = gohelper.onceAddComponent(self._txtDescr.gameObject, typeof(ZProj.TMPHyperLinkClick))

			hyperLinkClick:SetClickListener(self.txtClick, self)
			self:refreshShowByType()
		end
	end
end

function CharacterSkillTipView:txtClick(data, clickPosition)
	if self._showType == EliminateLevelEnum.skillShowType.skill then
		return
	end

	self:showSoliderInfo(tonumber(data))
end

function CharacterSkillTipView:refreshShowByType()
	gohelper.setActive(self._txtSkillName.gameObject, self._showType == EliminateLevelEnum.skillShowType.skill)
	gohelper.setActive(self._goSkillEnergyBG, self._showType == EliminateLevelEnum.skillShowType.skill)
end

function CharacterSkillTipView:showSoliderInfo(soliderId)
	self:showSoliderInfoByClick(soliderId)
end

function CharacterSkillTipView:hideSoliderInfo()
	self:setChessTip2Active(false)
end

function CharacterSkillTipView:setChessTip2Active(active)
	gohelper.setActive(self._btnclick2, active)
	gohelper.setActive(self._gochessTip2, active)
end

function CharacterSkillTipView:showSoliderInfoByClick(soliderId)
	local config = EliminateConfig.instance:getSoldierChessConfig(soliderId)

	if config == nil then
		return
	end

	SurvivalUnitIconHelper.instance:setNpcIcon(self._imageChess, config.resPic)
	UISpriteSetMgr.instance:setV2a2EliminateSprite(self._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. config.level, false)

	self._txtFireNum.text = config.defaultPower
	self._txtChessName.text = config.name

	local desc = EliminateConfig.instance:getSoldierChessDesc(soliderId)

	self._txtchessDescr.text = EliminateLevelModel.instance.formatString(desc)

	local costs, _ = EliminateConfig.instance:getSoldierChessConfigConst(soliderId)

	if self._resourceItem then
		for i = 1, #self._resourceItem do
			local item = self._resourceItem[i]

			gohelper.setActive(item, false)
			gohelper.destroy(item)
		end

		tabletool.clear(self._resourceItem)
	else
		self._resourceItem = self:getUserDataTb_()
	end

	if not costs then
		return
	end

	for _, cost in ipairs(costs) do
		local resourceId = cost[1]
		local num = cost[2]
		local item = gohelper.clone(self._goResourceItem, self._goResource, resourceId)
		local resourceImage = gohelper.findChildImage(item, "#image_ResourceQuality")
		local resourceNumberText = gohelper.findChildText(item, "#image_ResourceQuality/#txt_ResourceNum")

		UISpriteSetMgr.instance:setV2a2EliminateSprite(resourceImage, EliminateTeamChessEnum.ResourceTypeToImagePath[resourceId], false)

		resourceNumberText.text = num

		gohelper.setActive(item, true)
		table.insert(self._resourceItem, item)
	end

	self:setChessTip2Active(true)
end

function CharacterSkillTipView:setClickBgCb(cb, cbTarget)
	self._clickBgCb = cb
	self._clickBgCbTarget = cbTarget
end

function CharacterSkillTipView:setPoint(point)
	if not gohelper.isNil(point) then
		local posX, posY, posZ = transformhelper.getPos(point.transform)
		local rectPosX, rectPosY = recthelper.worldPosToAnchorPosXYZ(posX, posY, posZ, self.viewGO.transform)

		recthelper.setAnchor(self._gochessTip.transform, rectPosX, rectPosY)
		gohelper.setActive(self._gochessTip, true)
	end
end

function CharacterSkillTipView:hideView()
	if self._chessTipAni then
		self._chessTipAni:Play("close")
		TaskDispatcher.runDelay(self.closeThis, self, 0.33)
	end
end

function CharacterSkillTipView:onDestroyView()
	return
end

return CharacterSkillTipView
