-- chunkname: @modules/logic/autochess/main/view/game/AutoChessLeaderBuffView.lua

module("modules.logic.autochess.main.view.game.AutoChessLeaderBuffView", package.seeall)

local AutoChessLeaderBuffView = class("AutoChessLeaderBuffView", BaseView)

function AutoChessLeaderBuffView:onInitView()
	self._scrollDetail = gohelper.findChildScrollRect(self.viewGO, "Detail/#scroll_Detail")
	self._goBg = gohelper.findChild(self.viewGO, "Detail/#scroll_Detail/viewport/#go_Bg")
	self._goEnergy = gohelper.findChild(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy")
	self._txtEnergy = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_Energy")
	self._txtEnergyDesc = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Energy/#txt_EnergyDesc")
	self._goFire = gohelper.findChild(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire")
	self._txtFire = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_Fire")
	self._txtFireDesc = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Fire/#txt_FireDesc")
	self._goDebris = gohelper.findChild(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Debris")
	self._txtDebris = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Debris/#txt_Debris")
	self._txtDebrisDesc = gohelper.findChildText(self.viewGO, "Detail/#scroll_Detail/viewport/content/#go_Debris/#txt_DebrisDesc")
	self._goBuff = gohelper.findChild(self.viewGO, "Detail/#go_Buff")
	self._txtBuffName = gohelper.findChildText(self.viewGO, "Detail/#go_Buff/title/#txt_BuffName")
	self._scrollBuff = gohelper.findChildScrollRect(self.viewGO, "Detail/#go_Buff/#scroll_Buff")
	self._txtBuffDesc = gohelper.findChildText(self.viewGO, "Detail/#go_Buff/#scroll_Buff/viewport/content/#txt_BuffDesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessLeaderBuffView:onClickModalMask()
	self:closeThis()
end

function AutoChessLeaderBuffView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtEnergyDesc, self.clickHyperLink, self)
	SkillHelper.addHyperLinkClick(self._txtFireDesc, self.clickHyperLink, self)
	SkillHelper.addHyperLinkClick(self._txtDebrisDesc, self.clickHyperLink, self)
end

function AutoChessLeaderBuffView:onOpen()
	self.chessMo = AutoChessModel.instance:getChessMo()

	local master = self.chessMo.svrFight.mySideMaster
	local energy = AutoChessHelper.getBuffCnt(master.buffContainer.buffs, AutoChessEnum.EnergyBuffIds)

	if energy == 0 then
		gohelper.setActive(self._goEnergy, false)
	else
		self._txtEnergy.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_energy"), 1)

		local cfg = AutoChessConfig.instance:getSkillEffectDesc(2)

		self._txtEnergyDesc.text = AutoChessHelper.buildSkillDesc(cfg.desc)

		gohelper.setActive(self._goEnergy, true)
	end

	local fire = AutoChessHelper.getBuffCnt(master.buffContainer.buffs, AutoChessEnum.FireBuffIds)

	if fire == 0 then
		gohelper.setActive(self._goFire, false)
	else
		self._txtFire.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_fire"), 1)

		local cfg = AutoChessConfig.instance:getSkillEffectDesc(16)

		self._txtFireDesc.text = AutoChessHelper.buildSkillDesc(cfg.desc)

		gohelper.setActive(self._goFire, true)
	end

	local debris = AutoChessHelper.getBuffCnt(master.buffContainer.buffs, AutoChessEnum.DebrisIds)

	if debris == 0 then
		gohelper.setActive(self._goDebris, false)
	else
		self._txtDebris.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("autochess_leaderbuffview_debris"), 1)

		local cfg = AutoChessConfig.instance:getSkillEffectDesc(22)

		self._txtDebrisDesc.text = AutoChessHelper.buildSkillDesc(cfg.desc)

		gohelper.setActive(self._goDebris, true)
	end

	TaskDispatcher.runDelay(self.delaySet, self, 0.05)
end

function AutoChessLeaderBuffView:onDestroyView()
	TaskDispatcher.cancelTask(self.delaySet, self)
end

function AutoChessLeaderBuffView:delaySet()
	local trContent = self._scrollDetail.content.gameObject.transform
	local height = recthelper.getHeight(trContent) + 36

	height = height < 500 and height or 500

	recthelper.setHeight(self._goBg.transform, height)

	local pos = self.viewParam.position

	recthelper.setAnchor(self.viewGO.transform, pos.x + 180, pos.y + height - 80)
end

function AutoChessLeaderBuffView:clickHyperLink(effId, _)
	local descCo = AutoChessConfig.instance:getSkillEffectDesc(tonumber(effId))

	if descCo then
		self._txtBuffName.text = descCo.name
		self._txtBuffDesc.text = descCo.desc

		gohelper.setActive(self._goBuff, true)
	end
end

return AutoChessLeaderBuffView
