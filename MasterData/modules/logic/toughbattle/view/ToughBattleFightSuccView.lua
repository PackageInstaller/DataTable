-- chunkname: @modules/logic/toughbattle/view/ToughBattleFightSuccView.lua

module("modules.logic.toughbattle.view.ToughBattleFightSuccView", package.seeall)

local ToughBattleFightSuccView = class("ToughBattleFightSuccView", FightSuccView)

function ToughBattleFightSuccView:onInitView()
	self._goalcontent = gohelper.findChild(self.viewGO, "goalcontent")
	self._gotoughbattle = gohelper.findChild(self.viewGO, "#go_toughbattle")
	self._gotoughbattlerole = gohelper.findChild(self.viewGO, "#go_toughbattle_role")
	self._txtdiffcult = gohelper.findChildText(self.viewGO, "#go_toughbattle/info/txt_difficulty/#txt_diff")
	self._txtround = gohelper.findChildText(self.viewGO, "#go_toughbattle/info/txt_order/#txt_num")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#go_toughbattle/desc/#txt_desc")
	self._simagetoughbattlerole = gohelper.findChildImage(self.viewGO, "#go_toughbattle_role/role/#simage_rolehead")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_toughbattle_role/role/#btn_click")

	ToughBattleFightSuccView.super.onInitView(self)
end

function ToughBattleFightSuccView:addEvents()
	self._btnclick:AddClickListener(self.onClickSkill, self)
	ToughBattleFightSuccView.super.addEvents(self)
end

function ToughBattleFightSuccView:removeEvents()
	self._btnclick:RemoveClickListener()
	ToughBattleFightSuccView.super.removeEvents(self)
end

function ToughBattleFightSuccView:onOpen()
	ToughBattleFightSuccView.super.onOpen(self)
	gohelper.setActive(self._gotoughbattle, false)
	gohelper.setActive(self._gotoughbattlerole, false)
	self:setToughInfo()
end

function ToughBattleFightSuccView:setToughInfo()
	if ToughBattleConfig.instance:isActStage2EpisodeId(self._curEpisodeId) then
		gohelper.setActive(self._goalcontent, false)
		gohelper.setActive(self._gotoughbattle, true)

		local co = ToughBattleConfig.instance:getCoByEpisodeId(self._curEpisodeId)

		if co then
			if not co.difficulty then
				local difficult = 1

				self._txtdiffcult.text = luaLang("toughbattle_diffcult_" .. difficult)
				self._txtround.text = FightResultModel.instance.totalRound or 0
				self._txtdesc.text = ToughBattleConfig.instance:getRoundDesc(FightResultModel.instance.totalRound or 0)
			end
		end
	else
		gohelper.setActive(self._gotoughbattlerole, true)

		local co = ToughBattleConfig.instance:getCoByEpisodeId(self._curEpisodeId)

		UISpriteSetMgr.instance:setToughBattleRoleSprite(self._simagetoughbattlerole, "roleheadpic0" .. co.sort)
	end
end

function ToughBattleFightSuccView:onClickSkill()
	local co = ToughBattleConfig.instance:getCoByEpisodeId(self._curEpisodeId)

	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = co
	})
end

function ToughBattleFightSuccView:_addItem(material, ...)
	if material.bonusTag == FightEnum.FightBonusTag.FirstBonus then
		material.bonusTag = FightEnum.FightBonusTag.TimeFirstBonus
	end

	return ToughBattleFightSuccView.super._addItem(self, material, ...)
end

return ToughBattleFightSuccView
