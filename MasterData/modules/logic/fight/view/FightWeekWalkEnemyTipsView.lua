-- chunkname: @modules/logic/fight/view/FightWeekWalkEnemyTipsView.lua

module("modules.logic.fight.view.FightWeekWalkEnemyTipsView", package.seeall)

local FightWeekWalkEnemyTipsView = class("FightWeekWalkEnemyTipsView", FightBaseView)

function FightWeekWalkEnemyTipsView:onInitView()
	self.objContent = gohelper.findChild(self.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content")
	self.objItem = gohelper.findChild(self.viewGO, "#go_enemyinfocontainer/enemy/#scroll_enemy/viewport/content/#go_enemyitem")
	self.btnClose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "#go_enemyinfocontainer/#btn_close")
end

function FightWeekWalkEnemyTipsView:addEvents()
	self:com_registClick(self.btnClose, self.onBtnClose)
end

function FightWeekWalkEnemyTipsView:removeEvents()
	return
end

function FightWeekWalkEnemyTipsView:onBtnClose()
	self:closeThis()
end

function FightWeekWalkEnemyTipsView:onConstructor()
	return
end

function FightWeekWalkEnemyTipsView:onOpen()
	local dataList = FightDataHelper.entityMgr:getEnemySubList()

	table.insert(dataList, 1, true)
	gohelper.CreateObjList(self, self._onItemShow, dataList, self.objContent, self.objItem)
end

function FightWeekWalkEnemyTipsView:_onItemShow(obj, entityMO, index)
	if index == 1 then
		return
	end

	local headIcon = gohelper.findChildImage(obj, "head/#simage_icon")
	local careerIcon = gohelper.findChildImage(obj, "head/#image_career")
	local nameText = gohelper.findChildText(obj, "#txt_name")
	local levelText = gohelper.findChildText(obj, "#txt_level")
	local hpText = gohelper.findChildText(obj, "hp/hp_label/image_HPFrame/#txt_hp")
	local multiHpRoot = gohelper.findChild(obj, "hp/hp_label/image_HPFrame/#go_multihp")

	nameText.text = entityMO:getEntityName()
	levelText.text = HeroConfig.instance:getLevelDisplayVariant(entityMO.level)
	hpText.text = entityMO.currentHp

	gohelper.setActive(multiHpRoot, false)
	UISpriteSetMgr.instance:setCommonSprite(careerIcon, "lssx_" .. entityMO.career)

	local skinConfig = entityMO:getSpineSkinCO()

	if skinConfig then
		gohelper.getSingleImage(headIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(skinConfig.headIcon))
	end
end

function FightWeekWalkEnemyTipsView:onClose()
	return
end

function FightWeekWalkEnemyTipsView:onDestroyView()
	return
end

return FightWeekWalkEnemyTipsView
