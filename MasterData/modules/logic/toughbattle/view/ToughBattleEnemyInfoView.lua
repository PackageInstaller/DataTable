-- chunkname: @modules/logic/toughbattle/view/ToughBattleEnemyInfoView.lua

module("modules.logic.toughbattle.view.ToughBattleEnemyInfoView", package.seeall)

local ToughBattleEnemyInfoView = class("ToughBattleEnemyInfoView", BaseView)

function ToughBattleEnemyInfoView:onInitView()
	self._imgenemy = gohelper.findChildSingleImage(self.viewGO, "root/#simage_enemy")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "root/title/titletxt")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/#txt_desc")
	self._txtrecommend = gohelper.findChildTextMesh(self.viewGO, "root/#go_recommend/recommend_txt")
	self._recommenditem = gohelper.findChild(self.viewGO, "root/#go_recommend/#go_iconlist/#simage_icon")
	self._imgskillicon = gohelper.findChildImage(self.viewGO, "root/role/#simage_rolehead")
	self._btnskill = gohelper.findChildButtonWithAudio(self.viewGO, "root/role/#btn_skill")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_closebtn")
	self._btnchallenge = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_challengebtn")
end

function ToughBattleEnemyInfoView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnchallenge:AddClickListener(self.enterFight, self)
	self._btnskill:AddClickListener(self.onClickSkill, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ToughBattleEnemyInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnchallenge:RemoveClickListener()
	self._btnskill:RemoveClickListener()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function ToughBattleEnemyInfoView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_unlock)

	local co = self.viewParam
	local episodeId = co.episodeId
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	self._txttitle.text = config.name
	self._txtdesc.text = config.desc

	self._imgenemy:LoadImage("singlebg/toughbattle_singlebg/toughbattle_monster" .. co.sort .. ".png")
	UISpriteSetMgr.instance:setToughBattleRoleSprite(self._imgskillicon, "roleheadpic0" .. co.sort)

	local recommendList = self:getRecommendList(episodeId)

	gohelper.CreateObjList(self, self.onCreateItem, recommendList, self._recommenditem.transform.parent.gameObject, self._recommenditem)

	self._txtrecommend.text = #recommendList == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")
end

function ToughBattleEnemyInfoView:onOpenFinish()
	local co = self.viewParam
	local bossIdx = co.id

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideOpenBossInfoView, bossIdx)
end

function ToughBattleEnemyInfoView:onCreateItem(obj, data, index)
	local img = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setFightSprite(img, FightFailView.CareerToImageName[data])
end

function ToughBattleEnemyInfoView:getRecommendList(episodeId)
	local recommended = {}
	local battleId = DungeonConfig.instance:getEpisodeBattleId(episodeId)
	local battleConfig = lua_battle.configDict[battleId]

	if battleConfig and not string.nilorempty(battleConfig.monsterGroupIds) then
		local monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

		recommended = FightHelper.getAttributeCounter(monsterGroupIds, false)
	end

	return recommended
end

function ToughBattleEnemyInfoView:onClickSkill()
	ViewMgr.instance:openView(ViewName.ToughBattleSkillView, {
		isShowList = false,
		showCo = self.viewParam
	})
end

function ToughBattleEnemyInfoView:enterFight()
	local co = self.viewParam
	local episodeId = co.episodeId
	local config = DungeonConfig.instance:getEpisodeCO(episodeId)

	DungeonFightController.instance:enterFight(config.chapterId, episodeId)
end

function ToughBattleEnemyInfoView:onClickModalMask()
	self:closeThis()
end

function ToughBattleEnemyInfoView:_onOpenViewFinish(viewName)
	if viewName == ViewName.ToughBattleSkillView then
		gohelper.setActive(self.viewGO, false)
	end
end

function ToughBattleEnemyInfoView:_onCloseViewFinish(viewName)
	if viewName == ViewName.ToughBattleSkillView then
		gohelper.setActive(self.viewGO, true)
	end
end

function ToughBattleEnemyInfoView:onClose()
	return
end

function ToughBattleEnemyInfoView:onDestroyView()
	self._imgenemy:UnLoadImage()
end

return ToughBattleEnemyInfoView
