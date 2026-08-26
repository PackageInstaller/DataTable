-- chunkname: @modules/logic/tips/view/FightFocusView.lua

module("modules.logic.tips.view.FightFocusView", package.seeall)

local FightFocusView = class("FightFocusView", FightBaseView)

function FightFocusView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "fightinfocontainer/#btn_close")
	self._btnDetailClose = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_detailView/#btn_detailClose")
	self._goinfoView = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView")
	self._goinfoViewContent = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content")
	self._imagecareer = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/content/info/#image_career")
	self.levelRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg")
	self._txtlevel = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level")
	self._txtname = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/content/info/#txt_name")
	self._gostress = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_fightstressitem")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/content/info/levelbg/#txt_level/#image_dmgtype")
	self._goplayerpassive = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive")
	self._scrollenemypassive = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive")
	self._goenemyemptyskill = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/emptyskill")
	self._goenemypassive = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive")
	self._goenemypassiveitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	self._goenemypassiveSkill = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill")
	self._enemypassiveSkillPrefab = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/item")
	self._btnenemypassiveSkill = gohelper.findChildButtonWithAudio(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/enemypassiveskill/passiveSkills/btn_passiveclick")
	self._goresistance = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy/#go_resistance")
	self._txthp = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#txt_hp")
	self._sliderhp = gohelper.findChildSlider(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/#slider_hp")
	self.enemyHpRect = gohelper.findChildComponent(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/#slider_hp/Fill Area/hp", gohelper.Type_RectTransform)
	self.myHpRect = gohelper.findChildComponent(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/#slider_hp/Fill Area/hp2", gohelper.Type_RectTransform)
	self.fictionHp = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/xuxue")
	self.fakeHp = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/#image_fakehp")
	self.reduceHpGo = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_xuetiao/reducehp")
	self.reduceHpImage = self.reduceHpGo:GetComponent(gohelper.Type_Image)
	self._goattributeroot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_attribute_root")
	self._btnattribute = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_attribute_root/#btn_attribute")
	self._scrollbuff = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff")
	self._gobuffitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#scroll_buff/Viewport/Content/buffitem")
	self._godetailView = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_detailView")
	self._goplayer = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player")
	self._goenemy = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/enemy")
	self._scrollplotenemypassive = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive")
	self._goplotenemypassive = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive")
	self._goplotenemypassiveitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#scroll_enemypassive/Viewport/#go_enemypassive/#go_enemypassiveitem")
	self._godetailpassiveitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem")
	self._btnplayerpassive = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/#btn_playerpassive")
	self._scrollcontent = gohelper.findChildScrollRect(self.viewGO, "fightinfocontainer/#go_detailView/bg/#scroll_content")
	self._gobuffpassiveview = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_buffpassiveview")
	self._gobuffpassiveitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_buffpassiveview/#scroll_buff/viewport/content/#go_buffitem")
	self._gotargetframe = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_targetframe")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_Bg")
	self._containerGO = gohelper.findChild(self.viewGO, "fightinfocontainer")
	self._noskill = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/noskill")
	self._skill = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/skill")
	self._goplayerequipinfo = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo")
	self._goequip = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip")
	self._txtequiplv = gohelper.findChildText(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#txt_equiplv")
	self._equipIconImage = gohelper.findChildImage(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equip/#simage_equipicon")
	self._goequipEmpty = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerequipinfo/#go_equipEmpty")
	self._btnclosebuffpassive = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_buffpassiveview/#btn_detailClose")

	gohelper.setActive(self._enemypassiveSkillPrefab, false)

	self._enemypassiveiconGOs = self:getUserDataTb_()
	self._enemybuffpassiveGOs = self:getUserDataTb_()
	self._passiveSkillImgs = self:getUserDataTb_()
	self._passiveiconImgs = self:getUserDataTb_()
	self._bossSkillInfos = {}
	self._isbuffviewopen = false
	self._canClickAttribute = false
	self._multiHpRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/image_HPFrame/image_HPBG")
	self._multiHpItem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/image_HPFrame/image_HPBG/image_HpItem")
	self._btnSwitchEnemy = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_switch/#btn_enemy")
	self._btnSwitchMember = gohelper.findChildButton(self.viewGO, "fightinfocontainer/#go_switch/#btn_member")
	self._switchEnemyNormal = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/normal")
	self._switchEnemySelect = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_enemy/select")
	self._switchMemberNormal = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_member/normal")
	self._switchMemberSelect = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_switch/#btn_member/select")
	self._btnBuffObj = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/#btn_more")
	self._btnBuffMore = gohelper.getClickWithDefaultAudio(self._btnBuffObj)
	self._goAssistBoss = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_assistBoss")
	self._ani = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self.go_fetter = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/go_fetter")
	self.go_quality = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/go_quality")
	self.go_collection = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_collection")
	self.odysseySuitRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_odysseySuit")
	self.aiJiAoSliderRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_azio")
	self.alertRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/#go_alert")
	self.skillTipsRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/skilltipview")

	gohelper.setAsLastSibling(self.skillTipsRoot)

	self.goSurvivalHealth = gohelper.findChild(self.viewGO, "fightinfocontainer/layout/#go_survivalHealth")
	self.rectSurvivalHealth = self.goSurvivalHealth:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(self.goSurvivalHealth, false)

	self.txtHealth = gohelper.findChildText(self.viewGO, "fightinfocontainer/layout/#go_survivalHealth/#txt_survivalHealth")
	self.imageHealth = gohelper.findChildImage(self.viewGO, "fightinfocontainer/layout/#go_survivalHealth/#image_icon")
	self.healthClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "fightinfocontainer/layout/#go_survivalHealth/#btn_click")
	self.go_toughness = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_toughness")
	self.go_toughnessReward = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/toughnessReward")
	self.go_weakness = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/weekness")
	self.yaMiShieldRoot = gohelper.findChild(self.viewGO, "fightinfocontainer/layout/#go_shield")

	gohelper.setActive(self.yaMiShieldRoot, false)

	self.yaMiShieldText = gohelper.findChildText(self.viewGO, "fightinfocontainer/layout/#go_shield/#txt_shield")
	self.yaMiShieldClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "fightinfocontainer/layout/#go_shield/#btn_click")
	self.yaMiShieldTips = gohelper.findChild(self.viewGO, "fightinfocontainer/layout/#go_shield/#go_detailView")

	gohelper.setActive(self.yaMiShieldTips, false)

	self.closeYaMiShieldTipsClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "fightinfocontainer/layout/#go_shield/#go_detailView/#btn_detailClose")
	self.tipsYaMiShieldValueText = gohelper.findChildText(self.viewGO, "fightinfocontainer/layout/#go_shield/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem/shieldTitle/txt_title/#txt_curShield")
	self.yaMiTipsDescText = gohelper.findChildText(self.viewGO, "fightinfocontainer/layout/#go_shield/#go_detailView/#scroll_content/viewport/content/#go_detailpassiveitem/txt_desc")
	self.go_meiLeiEr = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_leimeier")

	gohelper.setActive(self.go_meiLeiEr, false)

	self.meiLeiErSlider1 = gohelper.findChildImage(self.go_meiLeiEr, "#image_progress1")
	self.meiLeiErSlider2 = gohelper.findChildImage(self.go_meiLeiEr, "#image_progress2")
	self.meiLeiErExroundRateText = gohelper.findChildText(self.go_meiLeiEr, "#txt_hp")
	self.goDevicePower = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/info/hp/layout/go_device")
	self.txtDevicePower = gohelper.findChildText(self.goDevicePower, "#txt_hp")
	self.imageDevicePowerProgress = gohelper.findChildImage(self.goDevicePower, "#image_device")
	self.imageStoreDevicePowerProgress = gohelper.findChildImage(self.goDevicePower, "#image_store_device")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightFocusView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnDetailClose:AddClickListener(self._hideDetail, self)
	self._btnplayerpassive:AddClickListener(self._btnplayerpassiveOnClick, self)
	self._btnclosebuffpassive:AddClickListener(self._onCloseBuffPassive, self)
	self._btnattribute:AddClickListener(self._onAttributeClick, self)
	self._btnSwitchEnemy:AddClickListener(self._onSwitchEnemy, self)
	self._btnSwitchMember:AddClickListener(self._onSwitchMember, self)
	self._btnBuffMore:AddClickListener(self._onBtnBuffMore, self)
	self.healthClick:AddClickListener(self.onClickHealth, self)
	self:com_registFightEvent(FightEvent.onReceiveEntityInfoReply, self._onReceiveEntityInfoReply)
	self:com_registClick(self.yaMiShieldClick, self._onClickYaMiShield)
end

function FightFocusView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnDetailClose:RemoveClickListener()
	self._btnplayerpassive:RemoveClickListener()
	self._btnenemypassiveSkill:RemoveClickListener()
	self._btnclosebuffpassive:RemoveClickListener()
	self._btnattribute:RemoveClickListener()
	self._btnSwitchEnemy:RemoveClickListener()
	self._btnSwitchMember:RemoveClickListener()
	self._btnBuffMore:RemoveClickListener()
	self.healthClick:RemoveClickListener()
	self:_releasePassiveSkillGOs()
end

function FightFocusView:_releasePassiveSkillGOs()
	if #self._passiveSkillGOs then
		for key, value in pairs(self._passiveSkillGOs) do
			value.btn:RemoveClickListener()
			gohelper.destroy(value.go)
		end
	end

	self._passiveSkillGOs = {}
end

function FightFocusView:_onSwitchEnemy()
	self:_onClickSwitchBtn(FightEnum.EntitySide.EnemySide)
end

function FightFocusView:_onSwitchMember()
	self:_onClickSwitchBtn(FightEnum.EntitySide.MySide)
end

function FightFocusView:_onClickSwitchBtn(side)
	self:closeAllTips()

	self._curSelectSide = side

	self:_refreshEntityList()

	self._curSelectId = self._entityList[1].id

	self:_refreshUI()
	self._ani:Play("switch", nil, nil)
end

function FightFocusView:_btncloseOnClick()
	if self.openEquipInfoTipView then
		ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)

		self.openEquipInfoTipView = false

		return
	end

	if self.openFightAttributeTipView then
		ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

		self.openFightAttributeTipView = false

		return
	end

	if self._hadPopUp then
		self:_hideDetail()

		self._hadPopUp = false
	else
		self:closeThis()
	end
end

function FightFocusView:_onCloseBuffPassive()
	gohelper.setActive(self._gobuffpassiveview, false)

	self._isbuffviewopen = false
end

function FightFocusView:_btnplayerpassiveOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:_showPassiveDetail()
end

function FightFocusView:_btnenemypassiveOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:_showPassiveDetail()
end

function FightFocusView:initScrollEnemyNode()
	self.enemyItemList = {}
	self.goScrollEnemy = gohelper.findChild(self.viewGO, "fightinfocontainer/#scroll_enemy")
	self._entityScrollHeight = recthelper.getHeight(self.goScrollEnemy.transform)
	self.goScrollEnemyContent = gohelper.findChild(self.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent")
	self.contentSizeFitter = self.goScrollEnemyContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))
	self.contentEnemyItem = gohelper.findChild(self.viewGO, "fightinfocontainer/#scroll_enemy/Viewport/#go_enemycontent/enemyitem")

	gohelper.setActive(self.contentEnemyItem, false)
end

function FightFocusView:_editableInitView()
	self.hpSlider = self._sliderhp.slider
	self._equipIconImage.enabled = false

	gohelper.setActive(self._godetailView, false)
	self:initScrollEnemyNode()
	self._simagebg:LoadImage(ResUrl.getFightImage("fightfocus/full/bg_bossjieshao_mengban.png"))
	gohelper.setActive(self._goenemypassiveitem, false)
	gohelper.setActive(self._goexitem, false)
	gohelper.setActive(self._gobuffitem, false)
	gohelper.setActive(self._godetailpassiveitem, false)

	self._passiveSkillGOs = {}
	self._exItemTables = {}
	self._buffTables = {}
	self._detailPassiveTables = {}
	self._playerpassiveGOList = self:getUserDataTb_()

	for i = 1, 3 do
		local playerpassiveGO = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel" .. i)

		table.insert(self._playerpassiveGOList, playerpassiveGO)
	end

	self._playerpassiveGOList[0] = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/playerpassivelevel/go_playerpassivelevel4")
	self._txttalent = gohelper.findChildTextMesh(self.viewGO, "fightinfocontainer/#go_infoView/content/player/#go_playerpassive/talent/tmp_talent")
	self._gosuperitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_superitem")
	self._goskillitem = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/skill/content/go_skillitem")

	gohelper.setActive(self._gosuperitem, false)
	gohelper.setActive(self._goskillitem, false)

	self._superItemList = {}

	local superItem

	for i = 1, 3 do
		table.insert(self._superItemList, (self:createSuperItem()))
	end

	self._skillGOs = {}

	local skillItem

	for i = 1, 3 do
		table.insert(self._skillGOs, (self:createSkillItem()))
	end

	self._godetailcontent = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_detailView/#scroll_content/viewport/content")
	self._gobg = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_detailView/bg")
	self._onCloseNeedResetCamera = true
	self._hadPopUp = false
	self.openEquipInfoTipView = false
	self.openFightAttributeTipView = false

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)

	local chapterId = DungeonModel.instance.curSendChapterId

	if chapterId then
		local chapterCo = DungeonConfig.instance:getChapterCO(chapterId)

		self.isSimple = chapterCo and chapterCo.type == DungeonEnum.ChapterType.Simple
	end

	self.resistanceComp = FightEntityResistanceComp.New(self._goresistance, self.viewContainer)

	self.resistanceComp:onInitView()

	self._godevice = gohelper.findChild(self.viewGO, "fightinfocontainer/#go_infoView/content/#go_device")
end

function FightFocusView:createSuperItem()
	local superItem = self:getUserDataTb_()

	superItem.go = gohelper.cloneInPlace(self._gosuperitem)
	superItem.icon = gohelper.findChildSingleImage(superItem.go, "lv/imgIcon")
	superItem.btn = gohelper.findChildButtonWithAudio(superItem.go, "btn_click")

	superItem.btn:AddClickListener(function(item)
		self:_showSkillDetail(item.info)
	end, superItem)
	gohelper.setActive(superItem.go, false)

	return superItem
end

function FightFocusView:createSkillItem()
	local skillItem = self:getUserDataTb_()

	skillItem.go = gohelper.cloneInPlace(self._goskillitem)
	skillItem.icon = gohelper.findChildSingleImage(skillItem.go, "lv/imgIcon")
	skillItem.tag = gohelper.findChildSingleImage(skillItem.go, "tag/pos/tag/tagIcon")
	skillItem.btn = gohelper.findChildButtonWithAudio(skillItem.go, "btn_click")

	skillItem.btn:AddClickListener(function(item)
		self:_showSkillDetail(item.info)
	end, skillItem)
	gohelper.setActive(skillItem.go, false)

	return skillItem
end

function FightFocusView:_getEntityList()
	local entityList = FightDataHelper.entityMgr:getNormalList(self._curSelectSide)
	local list = FightDataHelper.entityMgr:getSpList(self._curSelectSide)

	for _, entity in ipairs(list) do
		table.insert(entityList, entity)
	end

	if FightModel.instance:isSeason2() and self._curSelectSide == FightEnum.EntitySide.MySide then
		local subEntityList = FightDataHelper.entityMgr:getSubList(self._curSelectSide)

		for i, v in ipairs(subEntityList) do
			table.insert(entityList, v)
		end
	end

	for i = #entityList, 1, -1 do
		local tarEntity = FightHelper.getEntity(entityList[i].id)

		if tarEntity and tarEntity.spine and tarEntity.spine.detectDisplayInScreen and not tarEntity.spine:detectDisplayInScreen() then
			table.remove(entityList, i)
		end
	end

	for i = #entityList, 1, -1 do
		local localEntityData = FightLocalDataMgr.instance.entityMgr:getById(entityList[i].id)

		if localEntityData and localEntityData:isStatusDead() then
			table.remove(entityList, i)
		end
	end

	self:sortFightEntityList(entityList)

	local assistBoss = FightDataHelper.entityMgr:getAssistBoss()

	if assistBoss and self._curSelectSide == FightEnum.EntitySide.MySide and FightDataHelper.paTaMgr:checkIsNormal() then
		table.insert(entityList, assistBoss)
	end

	return entityList
end

function FightFocusView:sortFightEntityList(entityList)
	self.bossIdDict = {}

	local fightParam = FightModel.instance:getFightParam()

	if not fightParam.monsterGroupIds then
		return
	end

	for _, monsterGroupId in ipairs(fightParam.monsterGroupIds) do
		local bossId = lua_monster_group.configDict[monsterGroupId].bossId

		if not string.nilorempty(bossId) then
			local bossIds = string.splitToNumber(bossId, "#")

			for index, value in ipairs(bossIds) do
				self.bossIdDict[value] = true
			end
		end
	end

	table.sort(entityList, function(entityMoA, entityMoB)
		if self.bossIdDict[entityMoA.modelId] and not self.bossIdDict[entityMoB.modelId] then
			return true
		elseif not self.bossIdDict[entityMoA.modelId] and self.bossIdDict[entityMoB.modelId] then
			return false
		elseif self.bossIdDict[entityMoA.modelId] and self.bossIdDict[entityMoB.modelId] then
			return entityMoA.modelId < entityMoB.modelId
		else
			local isSub1 = FightDataHelper.entityMgr:isSub(entityMoA.id)
			local isSub2 = FightDataHelper.entityMgr:isSub(entityMoB.id)

			if isSub1 and not isSub2 then
				return false
			elseif not isSub1 and isSub2 then
				return true
			elseif not isSub1 and not isSub2 then
				return entityMoA.modelId < entityMoB.modelId
			else
				return entityMoA.position > entityMoB.position
			end
		end
	end)
end

function FightFocusView:onOpen()
	FightMsgMgr.sendMsg(FightMsgId.SetYaMiShieldEffectVisible, false)

	self.subEntityList = {}
	self._attrEntityDic = {}

	if self.viewParam then
		self._group = self.viewParam.group or HeroGroupModel.instance:getCurGroupMO()
	end

	if FightModel.instance:isSeason2() then
		self._group = Season166HeroGroupModel.instance:getCurGroupMO()
	end

	self._setEquipInfo = self.viewParam and self.viewParam.setEquipInfo

	if self.viewParam then
		self._balanceHelper = self.viewParam.balanceHelper or HeroGroupBalanceHelper
	end

	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, false)
	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 0)
	FightController.instance:dispatchEvent(FightEvent.SetIsShowUI, false)
	FightMsgMgr.sendMsg(FightMsgId.CameraFocusChanged, true)
	FightController.instance:dispatchEvent(FightEvent.OnCameraFocusChanged, true)

	if self.viewParam then
		local find = false

		find = self.viewParam.entityId

		if self.viewParam.entityId then
			local tarEntity = FightHelper.getEntity(self.viewParam.entityId)

			self._curSelectSide = tarEntity and tarEntity:getSide() or FightEnum.EntitySide.EnemySide

			self:_refreshEntityList()

			if #self._entityList == 0 then
				self._curSelectSide = FightEnum.EntitySide.MySide

				gohelper.setActive(self._btnSwitchEnemy.gameObject, false)
				self:_refreshEntityList()
			end

			if tarEntity then
				self._curSelectId = tarEntity.id or self._entityList[1].id
			end

			for _, entity in ipairs(self._entityList) do
				if self._curSelectId == entity.id then
					find = true

					break
				end
			end

			if not find then
				self._curSelectId = self._entityList[1].id
			end

			TaskDispatcher.runDelay(self._refreshUI, self, 0.3)
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_fight_roledetails)
			NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._btncloseOnClick, self)
		end
	end
end

function FightFocusView:_refreshEntityList()
	self._entityList = self:_getEntityList()

	gohelper.setActive(self._switchEnemyNormal, self._curSelectSide == FightEnum.EntitySide.MySide)
	gohelper.setActive(self._switchEnemySelect, self._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(self._switchMemberNormal, self._curSelectSide ~= FightEnum.EntitySide.MySide)
	gohelper.setActive(self._switchMemberSelect, self._curSelectSide == FightEnum.EntitySide.MySide)
	self:refreshScrollEnemy()
end

function FightFocusView:_refreshUI()
	local entityMO = FightDataHelper.entityMgr:getById(self._curSelectId)

	if self._entityMO ~= entityMO then
		self:_focusEntity(entityMO)
	end

	self._entityMO = entityMO

	local isAssistBoss = entityMO:isAssistBoss()

	if not isAssistBoss then
		gohelper.setActive(self._gotargetframe, true)
		gohelper.setActive(self._goattributeroot, true)
		gohelper.setActive(self._goinfoView, true)

		if entityMO:isCharacter() then
			self.isCharacter = true

			self:_refreshCharacterInfo(entityMO)
		else
			self.isCharacter = entityMO.side == FightEnum.EntitySide.MySide

			self:_refreshInfo(entityMO:getCO(), entityMO)
		end

		gohelper.setActive(self._goplayer, self.isCharacter)
		gohelper.setActive(self._goenemy, not self.isCharacter)
		self:_refreshMO(entityMO)
		self:_hideDetail()
		self:_detectBossMultiHp(entityMO)
	else
		gohelper.setActive(self._gotargetframe, false)
		gohelper.setActive(self._goattributeroot, false)
		gohelper.setActive(self._goinfoView, false)
	end

	self:setAssistBossStatus(isAssistBoss)
	self:refreshScrollEnemySelectStatus()
	self:refreshDouQuQuFetter()
	self:refreshDouQuQuStar()
	self:refreshDouQuQuCollection()
	self:showOdysseyEquip()
	self:showOdysseyEquipSuit()
	self:showAiJiAoExPointSlider()
	self:showAlert()
end

function FightFocusView:setAssistBossStatus(active, force)
	if active then
		self._assistBossView = self._assistBossView or FightFocusTowerView.New(self._goAssistBoss)
		self._assistBossView.bossId = self._entityMO.modelId

		self._assistBossView:show(force)
	elseif self._assistBossView then
		self._assistBossView:hide(force)
	end
end

function FightFocusView:_refreshInfo(monsterConfig)
	local levelStr = self.isSimple and "levelEasy" or "level"

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(self._entityMO.career))

	self._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(monsterConfig[levelStr])

	local useNewConfig = FightConfig.instance:getNewMonsterConfig(monsterConfig)

	if useNewConfig then
		self._txtname.text = monsterConfig.highPriorityName or monsterConfig.name
	end

	if isDebugBuild then
		logNormal(string.format("monster id=%d template=%d skillTemplate=%d", monsterConfig.id, monsterConfig.template, monsterConfig.skillTemplate))
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(monsterConfig.dmgType))

	local passiveSkillIds

	if self.isCharacter then
		passiveSkillIds = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterConfig.id)

		if next(passiveSkillIds) then
			self:_refreshPassiveSkill(passiveSkillIds, self._goplotenemypassiveitem)
		end

		gohelper.setActive(self._scrollplotenemypassive.gameObject, true)
		gohelper.setActive(self._goplayerpassive, false)
	else
		local bossId = self:_getBossId()

		if FightHelper.isBossId(bossId, monsterConfig.id) then
			passiveSkillIds = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterConfig.id)
			passiveSkillIds = FightConfig.instance:_filterSpeicalSkillIds(passiveSkillIds, false)
		else
			passiveSkillIds = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterConfig.id)
		end

		self:_refreshPassiveSkill(passiveSkillIds, self._goenemypassiveitem)
		gohelper.setActive(self._goplayerpassive, false)
	end

	local skillIds = {}
	local isNotSmallSkill = string.nilorempty(monsterConfig.activeSkill)
	local isNotUniqueSkill = #monsterConfig.uniqueSkill < 1
	local IsNotSkill = isNotSmallSkill and isNotUniqueSkill

	if not isNotSmallSkill then
		skillIds = string.split(monsterConfig.activeSkill, "|")
	end

	gohelper.setActive(self._noskill, IsNotSkill)
	gohelper.setActive(self._skill, not IsNotSkill)

	local skillDict = {}
	local tempSkillIds, key

	for _, skillStr in pairs(skillIds) do
		tempSkillIds = string.splitToNumber(skillStr, "#")
		skillDict[tempSkillIds[1]] = {}

		for i = 2, #tempSkillIds do
			table.insert(skillDict[tempSkillIds[1]], tempSkillIds[i])
		end
	end

	self:_refreshSuper(monsterConfig.uniqueSkill)
	self:_refreshSkill(skillDict)
	self:_refreshAttrList(self:_getMontBaseAttr(monsterConfig))
	self:_refreshResistance()
	self:refreshStress(self._entityMO)
	self:refreshKillLine(self._entityMO)
	gohelper.setActive(self._goplayerequipinfo, false)
	self:refreshHealth(self._entityMO)
end

function FightFocusView:refreshKillLine(entityMo)
	if not self.killLineComp then
		self.killLineComp = FightFocusHpKillLineComp.New(FightHpKillLineComp.KillLineType.FocusHp)

		self.killLineComp:init(self._sliderhp.gameObject)
	end

	self.killLineComp:refreshByEntityMo(entityMo)
end

FightFocusView.StressUiType2Cls = {
	[FightNameUIStressMgr.UiType.Normal] = FightFocusStressComp,
	[FightNameUIStressMgr.UiType.Act183] = FightFocusAct183StressComp
}

function FightFocusView:refreshStress(entityMo)
	if not entityMo or not entityMo:hasStress() then
		self:removeStressComp()

		return
	end

	local uiType = FightStressHelper.getStressUiType(entityMo.id)

	if not self.stressComp then
		self:createStressComp(uiType)
		self.stressComp:refreshStress(entityMo)

		return
	end

	if self.stressComp:getUiType() == uiType then
		self.stressComp:refreshStress(entityMo)

		return
	end

	self:removeStressComp()
	self:createStressComp(uiType)
	self.stressComp:refreshStress(entityMo)
end

function FightFocusView:createStressComp(uiType)
	local cls = FightFocusView.StressUiType2Cls[uiType]

	cls = cls or FightFocusStressCompBase
	self.stressComp = cls.New()

	self.stressComp:init(self._gostress)
end

function FightFocusView:_refreshResistance()
	if self.isCharacter then
		self.resistanceComp:refresh(nil)

		return
	end

	local resistanceDict = self._entityMO:getResistanceDict()

	self.resistanceComp:refresh(resistanceDict)
end

function FightFocusView:_getBossId()
	local monsterGroupId = FightModel.instance:getCurMonsterGroupId()
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

	if monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) then
		if not monsterGroupCO.bossId then
			local bossId

			return bossId
		end
	end
end

local index2attr = {
	"attack",
	"technic",
	"defense",
	"mdefense"
}

function FightFocusView:_onMonsterAttrItemShow(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(data.id)
	local preferrwidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(name, config.name)
	local width = recthelper.getWidth(name.transform)

	if width < preferrwidth then
		name.overflowMode = TMPro.TextOverflowModes.Ellipsis
		self._canClickAttribute = true
	end

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local rate = transform:Find("rate"):GetComponent(gohelper.Type_Image)

	if self.isCharacter then
		gohelper.setActive(num.gameObject, true)
		gohelper.setActive(rate.gameObject, false)

		num.text = self._curAttrMO[index2attr[index]]
	else
		gohelper.setActive(num.gameObject, false)
		gohelper.setActive(rate.gameObject, true)
		UISpriteSetMgr.instance:setCommonSprite(rate, "sx_" .. data.value, true)
	end
end

function FightFocusView:_refreshCharacterInfo(entityMO)
	local trialAttrCo = entityMO:getTrialAttrCo()

	gohelper.setActive(self._scrollplotenemypassive.gameObject, false)

	local heroConfig = entityMO:getCO()

	self:_refreshHeroEquipInfo(entityMO)
	UISpriteSetMgr.instance:setCommonSprite(self._imagecareer, "lssx_" .. tostring(entityMO.career))

	self._txtlevel.text = HeroConfig.instance:getLevelDisplayVariant(entityMO.level)
	self._txtname.text = heroConfig.name

	if trialAttrCo then
		self._txtname.text = trialAttrCo.name
	end

	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(heroConfig.dmgType))
	self:_refreshCharacterPassiveSkill(entityMO)
	gohelper.setActive(self._goenemypassive, false)
	gohelper.setActive(self._noskill, false)
	gohelper.setActive(self._skill, true)

	local exSkillLevel
	local isOtherPlayerHero = not PlayerModel.instance:isPlayerSelf(entityMO.userId)
	local allSkillIdDict = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(heroConfig.id, nil, nil, (tonumber(entityMO.uid) < 0 or isOtherPlayerHero) and entityMO.exSkillLevel)

	if trialAttrCo then
		allSkillIdDict = SkillConfig.instance:getHeroAllSkillIdDictByStr(trialAttrCo.activeSkill, trialAttrCo.uniqueSkill)
	end

	local uniqueSkillId = allSkillIdDict[3][1]

	allSkillIdDict[3] = nil

	if entityMO.exSkill and entityMO.exSkill > 0 then
		uniqueSkillId = entityMO.exSkill
	end

	if #entityMO.skillGroup1 > 0 then
		allSkillIdDict[1] = LuaUtil.deepCopySimple(entityMO.skillGroup1)
	end

	if #entityMO.skillGroup2 > 0 then
		allSkillIdDict[2] = LuaUtil.deepCopySimple(entityMO.skillGroup2)
	end

	self:_refreshSuper({
		uniqueSkillId
	})
	self:_refreshSkill(allSkillIdDict)
	self:_refreshAttrList(self:_getHeroBaseAttr(heroConfig))
	self:refreshStress(self._entityMO)
	self:refreshKillLine(self._entityMO)
	self:refreshHealth(self._entityMO)
end

function FightFocusView:_refreshHeroEquipInfo(entityMO)
	local equipMO, posIndex

	if entityMO.equipRecord then
		equipMO = entityMO:getEquipMo()
	elseif tonumber(entityMO.uid) < 0 then
		if tonumber(entityMO.equipUid) > 0 then
			equipMO = EquipModel.instance:getEquip(entityMO.equipUid)
		elseif tonumber(entityMO.equipUid) < 0 then
			local equipCo = lua_equip_trial.configDict[-tonumber(entityMO.equipUid)]

			if equipCo then
				equipMO = EquipMO.New()

				equipMO:initByTrialEquipCO(equipCo)
			end
		elseif entityMO.trialEquip and entityMO.trialEquip.equipId > 0 then
			equipMO = EquipMO.New()

			local co = {
				equipId = entityMO.trialEquip.equipId,
				equipLv = entityMO.trialEquip.equipLv,
				equipRefine = entityMO.trialEquip.refineLv
			}

			equipMO:initByTrialCO(co)
		end
	else
		local heroUid
		local isOtherPlayerHero = not PlayerModel.instance:isPlayerSelf(entityMO.userId)

		if isOtherPlayerHero then
			heroUid = entityMO.uid
		else
			local heroConfig = entityMO:getCO()
			local heroMO = HeroModel.instance:getByHeroId(heroConfig.id)

			heroUid = heroMO and heroMO.id
		end

		local equipUid

		if self._group then
			for k, v in pairs(self._group.heroList) do
				if heroUid and v == heroUid then
					equipUid = self._group.equips[k - 1].equipUid[1]
					posIndex = k
				end
			end
		end

		local _, assistMo = HeroGroupModel.instance:getAssistMo()

		if assistMo and assistMo.heroUid == heroUid then
			equipUid = self._group.equips[assistMo.id - 1].equipUid[1]
		end

		if tonumber(equipUid) and tonumber(equipUid) < 0 then
			local equipCo = lua_equip_trial.configDict[-tonumber(equipUid)]

			if equipCo then
				equipMO = EquipMO.New()

				equipMO:initByTrialEquipCO(equipCo)
			end
		else
			equipMO = EquipModel.instance:getEquip(equipUid)
		end
	end

	if equipMO and self._balanceHelper.getIsBalanceMode() then
		local _, _, equipLv = self._balanceHelper.getBalanceLv()

		if equipLv > equipMO.level then
			local newEquipMo = EquipMO.New()

			newEquipMo:initByConfig(nil, equipMO.equipId, equipLv, equipMO.refineLv)

			equipMO = newEquipMo
		end
	end

	if equipMO and posIndex and self._setEquipInfo then
		local callback = self._setEquipInfo[1]
		local callbackTarget = self._setEquipInfo[2]

		equipMO = callback(callbackTarget, {
			posIndex = posIndex,
			equipMO = equipMO
		})
	end

	self.equipMO = equipMO

	if self.equipMO then
		self._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.equipMO.config.icon), self._equipIconLoaded, self)

		self._txtequiplv.text = string.format("Lv.%s", self.equipMO.level)
		self.equipClick = gohelper.getClick(self._simageequipicon.gameObject)

		self.equipClick:AddClickListener(self.onEquipClick, self)
	end

	gohelper.setActive(self._goequip, self.equipMO)
	gohelper.setActive(self._goplayerequipinfo, self.equipMO)
end

function FightFocusView:_equipIconLoaded()
	self._equipIconImage.enabled = true
end

function FightFocusView:onEquipClick()
	if self.openEquipInfoTipView then
		return
	end

	self:closeAllTips()
	gohelper.setActive(self._godetailView, false)

	self.openEquipInfoTipView = true

	local otherEquipMos = {}

	if CharacterEnum.TwinssychubeHeroId == self._entityMO.modelId then
		if self.equipMO then
			local otherEquipId = EquipModel.instance:getOtherTwinssychubeEquipId(self.equipMO.equipId)
			local equipMo

			if otherEquipId then
				local trialEquip = self._entityMO.trialEquip

				if trialEquip and trialEquip.equipId > 0 then
					equipMo = EquipMO.New()

					local co = {
						equipId = otherEquipId,
						equipLv = trialEquip.equipLv,
						equipRefine = trialEquip.refineLv
					}

					equipMo:initByTrialCO(co)
				else
					equipMo = EquipModel.instance:getTwinssychubeEquipMo(otherEquipId)
				end

				table.insert(otherEquipMos, equipMo)
			end
		end
	end

	ViewMgr.instance:openView(ViewName.EquipInfoTipsView, {
		notShowLockIcon = true,
		equipMo = self.equipMO,
		heroCo = self._entityMO:getCO(),
		otherEquipMos = otherEquipMos
	})
end

function FightFocusView:_refreshAttrList(dataList)
	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		return
	end

	self._attrDataList = dataList
	self._curAttrMO = self._attrEntityDic[self._entityMO.id]

	if self._curAttrMO then
		gohelper.CreateObjList(self, self._onMonsterAttrItemShow, self._attrDataList, self._goattributeroot)
	else
		FightRpc.instance:sendEntityInfoRequest(self._entityMO.id)
	end
end

function FightFocusView:_onReceiveEntityInfoReply(proto)
	self._attrEntityDic[proto.entityInfo.uid] = proto.entityInfo.attr
	self._curAttrMO = self._attrEntityDic[self._entityMO.id]

	if self._curAttrMO then
		gohelper.CreateObjList(self, self._onMonsterAttrItemShow, self._attrDataList, self._goattributeroot)
	end
end

function FightFocusView:_getHeroBaseAttr(heroConfig)
	local attr_type = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local data = {}

	for i, v in ipairs(attr_type) do
		table.insert(data, {
			id = HeroConfig.instance:getIDByAttrType(attr_type[i]),
			value = HeroConfig.instance:getHeroAttrRate(heroConfig.id, v)
		})
	end

	return data
end

function FightFocusView:_getMontBaseAttr(monsterConfig)
	local attr_template = CharacterDataConfig.instance:getMonsterAttributeScoreList(monsterConfig.id)

	table.insert(attr_template, 2, table.remove(attr_template, 4))

	local attr_type = {
		"atk",
		"technic",
		"def",
		"mdef"
	}
	local data = {}

	for i, v in ipairs(attr_template) do
		table.insert(data, {
			id = HeroConfig.instance:getIDByAttrType(attr_type[i]),
			value = v
		})
	end

	return data
end

function FightFocusView:_onAttributeClick()
	return
end

function FightFocusView:_refreshPassiveSkill(passiveSkillIds, passiveitem)
	self:_releasePassiveSkillGOs()

	for i = 1, #passiveSkillIds do
		local passiveSkillTable = self._passiveSkillGOs[i]

		if not passiveSkillTable then
			local passiveSkillGO = gohelper.cloneInPlace(passiveitem, "item" .. i)

			passiveSkillTable = self:getUserDataTb_()
			passiveSkillTable.go = passiveSkillGO
			passiveSkillTable.name = gohelper.findChildTextMesh(passiveSkillGO, "tmp_talent")
			passiveSkillTable.btn = gohelper.findChildButton(passiveSkillGO, "#btn_enemypassive")

			table.insert(self._passiveSkillGOs, passiveSkillTable)
		end

		local passiveSkillId = tonumber(passiveSkillIds[i])
		local skillConfig = lua_skill.configDict[passiveSkillId]

		passiveSkillTable.btn:AddClickListener(self._btnenemypassiveOnClick, self)

		passiveSkillTable.name.text = skillConfig.name

		gohelper.setActive(passiveSkillTable.go, true)
	end

	for i = #passiveSkillIds + 1, #self._passiveSkillGOs do
		gohelper.setActive(self._passiveSkillGOs[i].go, false)
	end

	gohelper.setActive(self._goenemypassive, #passiveSkillIds > 0)

	self._passiveSkillIds = passiveSkillIds

	local enemypassiveLayoutelement = self._scrollenemypassive.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	local itemHeight = 80
	local line = math.ceil(#passiveSkillIds / 3)

	if line <= 2 then
		enemypassiveLayoutelement.minHeight = itemHeight * line
	end
end

function FightFocusView:_refreshCharacterPassiveSkill(entityMO)
	local heroConfig = entityMO:getCO()
	local passiveLevel, _ = SkillConfig.instance:getHeroExSkillLevelByLevel(heroConfig.id, entityMO.level)
	local passiveSkillIds = {}
	local passiveSkillList = self:getPassiveSkillList(entityMO)
	local isHasPassiveSkill0 = passiveSkillList and passiveSkillList[0]

	HeroDestinyStoneMO.replaceSkillList(passiveSkillList, entityMO.destinyStone, entityMO.destinyRank)

	if passiveSkillList and #passiveSkillList > 0 then
		gohelper.setActive(self._goplayerpassive, true)

		local skillId = passiveSkillList[1]

		self._txttalent.text = lua_skill.configDict[skillId].name

		for i, v in pairs(passiveSkillList) do
			local unlock = i <= passiveLevel

			gohelper.setActive(self._playerpassiveGOList[i], unlock)

			if unlock then
				passiveSkillIds[i] = FightHelper.getPassiveSkill(entityMO.id, v)
			end
		end

		for i = #passiveSkillList + 1, #self._playerpassiveGOList do
			gohelper.setActive(self._playerpassiveGOList[i], false)
		end
	end

	if isHasPassiveSkill0 then
		gohelper.setActive(self._playerpassiveGOList[0], true)
	else
		gohelper.setActive(self._playerpassiveGOList[0], false)
	end

	gohelper.setActive(self._goplayerpassive, #passiveSkillIds > 0 or isHasPassiveSkill0)

	self._passiveSkillIds = passiveSkillIds
end

function FightFocusView:getPassiveSkillList(entityMO)
	local pskills = {}
	local heroId
	local trialAttrCo = entityMO:getTrialAttrCo()

	if trialAttrCo then
		heroId = entityMO.modelId

		local arr = string.splitToNumber(trialAttrCo.passiveSkill, "|")

		for _, skillId in ipairs(arr) do
			table.insert(pskills, skillId)
		end
	else
		local heroConfig = entityMO:getCO()

		heroId = heroConfig.id

		local exSkillLevel = entityMO.exSkillLevel
		local pskillCoList = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(heroId, exSkillLevel)

		if pskillCoList[0] then
			pskills[0] = pskillCoList[0].skillPassive
		end

		for _, passiveCo in ipairs(pskillCoList) do
			table.insert(pskills, passiveCo.skillPassive)
		end
	end

	local fightParam = FightModel.instance:getFightParam()
	local episodeCo = fightParam and fightParam:getCurEpisodeConfig()

	if episodeCo and episodeCo.type == DungeonEnum.EpisodeType.BossRush then
		local episode128Co = BossRushConfig.instance:getEpisodeCoByEpisodeId(episodeCo.id)

		if episode128Co and episode128Co.enhanceRole == 1 then
			pskills = self:exchangeHeroPassiveSkill(pskills, heroId)
		end
	end

	return pskills
end

function FightFocusView:exchangeHeroPassiveSkill(pskills, heroId)
	if not pskills then
		return pskills
	end

	if not heroId then
		return pskills
	end

	for _, co in ipairs(lua_activity128_enhance.configList) do
		if co.characterId == heroId then
			local replaceList = FightStrUtil.splitString2(co.exchangeSkills, true)

			if replaceList then
				for index, skillId in ipairs(pskills) do
					for _, replace in ipairs(replaceList) do
						if replace[1] == skillId then
							pskills[index] = replace[2]
						end
					end
				end
			end

			return pskills
		end
	end

	return pskills
end

function FightFocusView:_refreshSkill(skillIdDict)
	local skillItem, skillId, skillConfig

	for i = 1, #skillIdDict do
		if i > #self._skillGOs then
			logError("技能超过支持显示数量")

			break
		end

		skillItem = self._skillGOs[i]

		if not lua_skill.configDict[skillIdDict[i][1]] then
			logError("技能表找不到id:" .. skillIdDict[i][1])

			return
		end

		skillItem.icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[skillIdDict[i][1]].icon))
		skillItem.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. lua_skill.configDict[skillIdDict[i][1]].showTag))

		local info = {}

		info.super = false
		info.skillIdList = skillIdDict[i]
		info.skillIndex = i
		skillItem.info = info

		gohelper.setActive(skillItem.go, true)
	end

	for i = #skillIdDict + 1, #self._skillGOs do
		gohelper.setActive(self._skillGOs[i].go, false)
	end

	self:_checkDevice()
end

function FightFocusView:_refreshSuper(uniqueSkillList)
	if uniqueSkillList and #uniqueSkillList > 0 then
		local superItem, skillId, skillConfig

		for index = 1, #uniqueSkillList do
			superItem = self._superItemList[index]

			if not self._superItemList[index] then
				logError("技能超过支持显示数量 : " .. table.concat(uniqueSkillList, "|"))

				return
			end

			skillId = uniqueSkillList[index]

			if uniqueSkillList[index] ~= 0 then
				superItem.icon:LoadImage(ResUrl.getSkillIcon(lua_skill.configDict[skillId].icon))

				local info = {}

				info.super = true
				info.skillIdList = {
					skillId
				}
				info.skillIndex = CharacterEnum.skillIndex.SkillEx
				superItem.info = info
			end

			gohelper.setActive(superItem.go, skillId ~= 0)
		end
	end

	for index = #uniqueSkillList + 1, #self._superItemList do
		gohelper.setActive(self._superItemList[index].go, false)
	end
end

function FightFocusView:_refreshMO(entityMO)
	self:_refreshHp(entityMO)
	self:_refreshBuff(entityMO)

	if entityMO:isMonster() then
		local monsterCO = entityMO:getCO()

		if FightHelper.isBossId(self:_getBossId(), monsterCO.id) then
			self:_refreshEnemyPassiveSkill(monsterCO)
		else
			gohelper.setActive(self._goenemypassiveSkill, false)
		end
	end

	local hasToughness = self:refreshToughness(entityMO)

	self:refreshToughnessReward(entityMO)
	self:refreshWeakness(entityMO, hasToughness)
	self:refreshYaMiShield(entityMO)
	self:refreshMeiLeiEr(entityMO)
	self:refreshDevicePower(entityMO)
end

function FightFocusView:_refreshEnemyPassiveSkill(monsterCO)
	self._bossSkillInfos = {}

	local skills = FightConfig.instance:getPassiveSkillsAfterUIFilter(monsterCO.id)

	skills = FightConfig.instance:_filterSpeicalSkillIds(skills, true)

	for i = 1, #skills do
		local skillId = skills[i]
		local specialco = lua_skill_specialbuff.configDict[skillId]

		if specialco then
			local specialSkillTable = self._enemypassiveiconGOs[i]

			if not specialSkillTable then
				specialSkillTable = self:getUserDataTb_()
				specialSkillTable.go = gohelper.cloneInPlace(self._enemypassiveSkillPrefab, "item" .. i)
				specialSkillTable._gotag = gohelper.findChild(specialSkillTable.go, "tag")
				specialSkillTable._txttag = gohelper.findChildText(specialSkillTable.go, "tag/#txt_tag")

				table.insert(self._enemypassiveiconGOs, specialSkillTable)

				local img = gohelper.findChildImage(specialSkillTable.go, "icon")

				table.insert(self._passiveiconImgs, img)
				gohelper.setActive(specialSkillTable.go, true)
			else
				gohelper.setActive(specialSkillTable.go, true)
			end

			local info = self._bossSkillInfos[i]

			if info == nil then
				self._bossSkillInfos[i] = {
					skillId = skillId,
					icon = specialco.icon
				}
			end

			if not string.nilorempty(specialco.lv) then
				gohelper.setActive(specialSkillTable._gotag, true)

				specialSkillTable._txttag.text = specialco.lv
			else
				gohelper.setActive(specialSkillTable._gotag, false)
			end

			if string.nilorempty(specialco.icon) then
				logError("boss抗性表的icon字段没有配置,技能ID:" .. specialco.id)
			end

			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveiconImgs[i], specialco.icon)
		end
	end

	if #skills < #self._enemypassiveiconGOs then
		for i = #skills + 1, #self._enemypassiveiconGOs do
			gohelper.setActive(self._enemypassiveiconGOs[i].go, false)
		end
	end

	if #self._bossSkillInfos > 0 then
		gohelper.setActive(self._goenemypassiveSkill, true)
	else
		gohelper.setActive(self._goenemypassiveSkill, false)
	end

	gohelper.setAsLastSibling(self._btnenemypassiveSkill.gameObject)
	self._btnenemypassiveSkill:AddClickListener(self._onBuffPassiveSkillClick, self)
end

function FightFocusView:_onBuffPassiveSkillClick()
	if self._isbuffviewopen then
		return
	end

	self:closeAllTips()
	self:_hideDetail()

	local skillId

	if self._bossSkillInfos then
		for i, skillInfo in pairs(self._bossSkillInfos) do
			skillId = skillInfo.skillId

			local specialSkillTable = self._enemybuffpassiveGOs[i]

			if not specialSkillTable then
				specialSkillTable = self:getUserDataTb_()
				specialSkillTable.go = gohelper.cloneInPlace(self._gobuffpassiveitem, "item" .. i)

				table.insert(self._enemybuffpassiveGOs, specialSkillTable)

				local img = gohelper.findChildImage(specialSkillTable.go, "title/simage_icon")

				table.insert(self._passiveSkillImgs, img)
				gohelper.setActive(specialSkillTable.go, true)
			else
				gohelper.setActive(specialSkillTable.go, true)
			end

			local line = gohelper.findChild(specialSkillTable.go, "txt_desc/image_line")

			gohelper.setActive(line, true)
			self:_setPassiveSkillTip(specialSkillTable.go, skillInfo)
			UISpriteSetMgr.instance:setFightPassiveSprite(self._passiveSkillImgs[i], skillInfo.icon)
		end

		if #self._bossSkillInfos < #self._enemybuffpassiveGOs then
			for i = #self._bossSkillInfos + 1, #self._enemybuffpassiveGOs do
				gohelper.setActive(self._enemybuffpassiveGOs[i], false)
			end
		end

		local line = gohelper.findChild(self._enemybuffpassiveGOs[#self._bossSkillInfos].go, "txt_desc/image_line")

		gohelper.setActive(line, false)
		gohelper.setActive(self._gobuffpassiveview, true)

		self._isbuffviewopen = true
	end
end

function FightFocusView:_setPassiveSkillTip(skillgo, skillInfo)
	local name = gohelper.findChildText(skillgo, "title/txt_name")
	local descComp = gohelper.findChildText(skillgo, "txt_desc")

	SkillHelper.addHyperLinkClick(descComp, self.onClickHyperLink, self)

	local skillCO = lua_skill.configDict[skillInfo.skillId]

	name.text = skillCO.name
	descComp.text = SkillHelper.getEntityDescBySkillCo(self._curSelectId, skillCO, "#CC492F", "#485E92")
end

function FightFocusView:onClickPassiveHyperLink(effectId, clickPosition)
	self.commonBuffTipAnchorPos = self.commonBuffTipAnchorPos or Vector2(-387.28, 168.6)

	local entityName = FightConfig.instance:getEntityName(self._curSelectId)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, self.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right, entityName)
end

function FightFocusView:_refreshHp(entityMO)
	local rate = entityMO:getLockMaxHpRate()
	local hp = math.max(entityMO.currentHp, 0)

	if entityMO.attrMO then
		local maxHp = math.max(entityMO.attrMO.hp, 0)

		maxHp = maxHp * rate

		local fictionHp = entityMO:getFictionHp()

		self._txthp.text = fictionHp < 0 and string.format("%d/%d", hp, maxHp) or fictionHp == hp and string.format("%d/%d", hp, maxHp) or string.format("%d<color=#B2D3B2>(+%d)</color>/%d", fictionHp, hp - fictionHp, maxHp)

		local hpPercent = hp / maxHp * rate

		if entityMO:isMySide() then
			if not self.myHpRect then
				self.hpSlider.fillRect = self.enemyHpRect

				gohelper.setActive(self.myHpRect.gameObject, entityMO:isMySide())
				gohelper.setActive(self.enemyHpRect.gameObject, not entityMO:isMySide())

				local realHpPercent, fictionHpPercent = entityMO:getHpPercentAndFictionHpPercent(hpPercent, hp)

				self._sliderhp:SetValue(realHpPercent)

				self.fictionHp.fillAmount = fictionHpPercent

				local fakeHp = entityMO:getFakeHp()

				if fakeHp <= 0 then
					self.fakeHp.fillAmount = 0
				else
					local fakeHpPercent = Mathf.Clamp01(fakeHp / maxHp)

					self.fakeHp.fillAmount = fakeHpPercent + realHpPercent
				end

				local showReduceHp = rate < 1

				gohelper.setActive(self.reduceHpGo, showReduceHp)

				if showReduceHp then
					self.reduceHpImage.fillAmount = Mathf.Clamp01(1 - rate)
				end
			end
		end
	end
end

function FightFocusView:_refreshBuff(entityMO)
	local buffMOs = entityMO:getBuffList()

	buffMOs = FightBuffHelper.filterBuffType(buffMOs, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(buffMOs)
	table.sort(buffMOs, function(buffMO1, buffMO2)
		if buffMO1.time ~= buffMO2.time then
			return buffMO1.time < buffMO2.time
		end

		return buffMO1.id < buffMO2.id
	end)

	if buffMOs then
		if not #buffMOs then
			local count = 0
			local itemCount = 0

			for i = 1, count do
				local buffMO = buffMOs[i]
				local buffCO = lua_skill_buff.configDict[buffMO.buffId]

				if buffCO and buffCO.isNoShow == 0 then
					itemCount = itemCount + 1

					local buffItem = self._buffTables[itemCount]

					if not buffItem then
						local buffGO = gohelper.cloneInPlace(self._gobuffitem, "item" .. itemCount)

						buffItem = MonoHelper.addNoUpdateLuaComOnceToGo(buffGO, FightBuffItem)
						self._buffTables[itemCount] = buffItem
					end

					buffItem:updateBuffMO(buffMO)
					buffItem:setClickCallback(self._onClickBuff, self)
					gohelper.setActive(self._buffTables[itemCount].go, true)
				end
			end

			for i = itemCount + 1, #self._buffTables do
				gohelper.setActive(self._buffTables[i].go, false)
			end

			gohelper.setActive(self._scrollbuff.gameObject, itemCount > 0)
			gohelper.setActive(self._btnBuffMore, itemCount > 6)
		end
	end
end

function FightFocusView:_onClickBuff(entityId)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)

	entityId = entityId or self._entityMO.id

	self:closeAllTips()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, entityId)

	if self._hadPopUp then
		self:_hideDetail()

		self._hadPopUp = false
	end
end

function FightFocusView:_showPassiveDetail()
	self:closeAllTips()

	if not self._passiveSkillIds then
		return
	end

	local isHasPassiveSkill0 = self._passiveSkillIds[0]

	if #self._passiveSkillIds > 0 or isHasPassiveSkill0 then
		gohelper.setActive(self._godetailView, true)
		self:_refreshPassiveDetail()

		self._hadPopUp = true
	end
end

function FightFocusView:refreshScrollEnemy()
	self:_releaseHeadItemList()

	self.enemyItemList = {}

	gohelper.setActive(self.goScrollEnemy, true)

	local enemyItem

	for index, entityMo in ipairs(self._entityList) do
		enemyItem = self.enemyItemList[index] or self:createEnemyItem()

		gohelper.setActive(enemyItem.go, true)

		enemyItem.entityMo = entityMo

		local config = entityMo:getCO()

		if config then
			UISpriteSetMgr.instance:setEnemyInfoSprite(enemyItem.imageCareer, "sxy_" .. tostring(entityMo.career))
		end

		local headIcon = self:getHeadIcon(entityMo)

		gohelper.getSingleImage(enemyItem.imageIcon.gameObject):LoadImage(ResUrl.monsterHeadIcon(headIcon))

		if config and config.heartVariantId and config.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPathWithRound(config.heartVariantId), enemyItem.imageIcon)
		end

		gohelper.setActive(enemyItem.goBossTag, self.bossIdDict[config.id])

		if entityMo.side ~= FightEnum.EntitySide.MySide then
			transformhelper.setLocalRotation(enemyItem.imageIcon.transform, 0, 180, 0)
		else
			transformhelper.setLocalRotation(enemyItem.imageIcon.transform, 0, 0, 0)
		end

		local health = FightHelper.getSurvivalEntityHealth(entityMo.id)

		gohelper.setActive(enemyItem.healthGo, health ~= nil)

		if health then
			local icon = FightNameUIHealthComp.getHealthIcon(health)

			UISpriteSetMgr.instance:setFightSprite(enemyItem.healthTag, icon, true)
		end

		local obj = gohelper.findChild(enemyItem.go, "item/toughnessReward")
		local monsterConfig = lua_monster.configDict[entityMo.modelId]

		if monsterConfig and not string.nilorempty(monsterConfig.toughness) then
			local entity = FightGameMgr.entityMgr:getById(entityMo.id)

			if entity then
				self:newClass(FightNameUIToughnessIconMgr, entity, obj, monsterConfig)
			end
		else
			gohelper.setActive(obj, false)
		end
	end

	for i = #self._entityList + 1, #self.enemyItemList do
		gohelper.setActive(self.enemyItemList[i].go, false)
	end
end

function FightFocusView:getHeadIcon(entityMo)
	if not entityMo then
		return
	end

	local modelId = entityMo.modelId
	local boss500mCo = lua_fight_sp_500m_model.configDict[modelId]

	if boss500mCo then
		return boss500mCo.headIconName
	end

	local skinConfig = entityMo:getSpineSkinCO()

	return skinConfig.headIcon
end

function FightFocusView:refreshScrollEnemySelectStatus()
	if self.enemyItemList then
		for index, enemyItem in ipairs(self.enemyItemList) do
			local isSelect = self._entityMO.uid == enemyItem.entityMo.uid

			gohelper.setActive(enemyItem.goSelectFrame, isSelect)

			local colorIcon = self._entityMO.uid == enemyItem.entityMo.uid and "#ffffff" or "#8C8C8C"
			local colorCareer = self._entityMO.uid == enemyItem.entityMo.uid and "#ffffff" or "#828282"

			SLFramework.UGUI.GuiHelper.SetColor(enemyItem.imageIcon, colorIcon)
			SLFramework.UGUI.GuiHelper.SetColor(enemyItem.imageCareer, colorCareer)

			if isSelect then
				local relativePosY = -106 - 193 * (index - 1) + recthelper.getAnchorY(self.goScrollEnemyContent.transform) + self._entityScrollHeight / 2
				local itemHeight = recthelper.getHeight(enemyItem.go.transform)
				local minY = relativePosY - itemHeight
				local maxY = relativePosY + itemHeight
				local half = self._entityScrollHeight / 2

				if minY < -half then
					local offset = minY + half

					recthelper.setAnchorY(self.goScrollEnemyContent.transform, recthelper.getAnchorY(self.goScrollEnemyContent.transform) - offset - 54)
				end

				if half < maxY then
					local offset = maxY - half

					recthelper.setAnchorY(self.goScrollEnemyContent.transform, recthelper.getAnchorY(self.goScrollEnemyContent.transform) - offset + 54)
				end
			end

			gohelper.setActive(enemyItem.subTag, FightDataHelper.entityMgr:isSub(enemyItem.entityMo.uid))
		end
	end
end

function FightFocusView:createEnemyItem()
	local enemyItem = self:getUserDataTb_()

	enemyItem.go = gohelper.cloneInPlace(self.contentEnemyItem)
	enemyItem.imageIcon = gohelper.findChildImage(enemyItem.go, "item/icon")
	enemyItem.goBossTag = gohelper.findChild(enemyItem.go, "item/bosstag")
	enemyItem.imageCareer = gohelper.findChildImage(enemyItem.go, "item/career")
	enemyItem.healthTag = gohelper.findChildImage(enemyItem.go, "item/healthTag")
	enemyItem.healthGo = enemyItem.healthTag.gameObject
	enemyItem.goSelectFrame = gohelper.findChild(enemyItem.go, "item/go_selectframe")
	enemyItem.subTag = gohelper.findChild(enemyItem.go, "item/#go_SubTag")
	enemyItem.btnClick = gohelper.findChildButtonWithAudio(enemyItem.go, "item/btn_click")

	enemyItem.btnClick:AddClickListener(self.onClickEnemyItem, self, enemyItem)
	gohelper.setActive(enemyItem.healthGo, false)
	table.insert(self.enemyItemList, enemyItem)

	return enemyItem
end

function FightFocusView:onClickEnemyItem(enemyItem)
	if enemyItem.entityMo.uid == self._entityMO.uid then
		return
	end

	self._curSelectId = enemyItem.entityMo.id

	self:closeAllTips()
	self:_refreshUI()
	self._ani:Play("switch", nil, nil)
end

function FightFocusView:closeAllTips()
	self.viewContainer:hideSkillTipView()
	gohelper.setActive(self._godetailView, false)
	gohelper.setActive(self._gobuffpassiveview, false)

	self._isbuffviewopen = false

	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	ViewMgr.instance:closeView(ViewName.FightAttributeTipView)

	self.openEquipInfoTipView = false
	self.openFightAttributeTipView = false
end

function FightFocusView:_showSkillDetail(info)
	self:closeAllTips()
	self.viewContainer:showSkillTipView(info, self.isCharacter, self._curSelectId)

	self._hadPopUp = true
end

function FightFocusView:_hideDetail()
	self.viewContainer:hideSkillTipView()
	gohelper.setActive(self._godetailView, false)
	gohelper.setActive(self._gobuffpassiveview, false)

	self._isbuffviewopen = false
end

function FightFocusView:_refreshPassiveDetail()
	local passiveSkillIds = {}

	if self._passiveSkillIds[0] then
		table.insert(passiveSkillIds, self._passiveSkillIds[0])
	end

	for i = 1, #self._passiveSkillIds do
		table.insert(passiveSkillIds, self._passiveSkillIds[i])
	end

	local passiveSkillCount = #passiveSkillIds

	passiveSkillIds = self:_checkReplaceSkill(passiveSkillIds)

	for i = 1, passiveSkillCount do
		local passiveSkillId = tonumber(passiveSkillIds[i])
		local skillConfig = lua_skill.configDict[passiveSkillId]

		if skillConfig then
			local detailPassiveTable = self._detailPassiveTables[i]

			if not detailPassiveTable then
				local detailPassiveGO = gohelper.cloneInPlace(self._godetailpassiveitem, "item" .. i)

				detailPassiveTable = self:getUserDataTb_()
				detailPassiveTable.go = detailPassiveGO
				detailPassiveTable.name = gohelper.findChildText(detailPassiveGO, "title/txt_name")
				detailPassiveTable.icon = gohelper.findChildSingleImage(detailPassiveGO, "title/simage_icon")
				detailPassiveTable.desc = gohelper.findChildText(detailPassiveGO, "txt_desc")

				SkillHelper.addHyperLinkClick(detailPassiveTable.desc, self.onClickHyperLink, self)

				detailPassiveTable.line = gohelper.findChild(detailPassiveGO, "txt_desc/image_line")

				table.insert(self._detailPassiveTables, detailPassiveTable)
			end

			detailPassiveTable.name.text = skillConfig.name
			detailPassiveTable.desc.text = SkillHelper.getEntityDescBySkillCo(self._curSelectId, skillConfig, "#CC492F", "#485E92")

			gohelper.setActive(detailPassiveTable.go, true)
			gohelper.setActive(detailPassiveTable.line, i < passiveSkillCount)
		else
			logError(string.format("被动技能配置没找到, id: %d", passiveSkillId))
		end
	end

	for i = passiveSkillCount + 1, #self._detailPassiveTables do
		gohelper.setActive(self._detailPassiveTables[i].go, false)
	end
end

function FightFocusView:_checkReplaceSkill(skillIdList)
	if skillIdList and self._entityMO then
		skillIdList = self._entityMO:checkReplaceSkill(skillIdList)
	end

	return skillIdList
end

function FightFocusView:onClickHyperLink(effectId, clickPosition)
	self.commonBuffTipAnchorPos = self.commonBuffTipAnchorPos or Vector2(-389.14, 168.4)

	local entityName = FightConfig.instance:getEntityName(self._curSelectId)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(effectId, self.commonBuffTipAnchorPos, CommonBuffTipEnum.Pivot.Right, entityName)
end

function FightFocusView:_detectBossMultiHp(entityMO)
	local bossRushEntityMO = BossRushModel.instance:getBossEntityMO()

	self._isBossRush = BossRushController.instance:isInBossRushInfiniteFight(true) and bossRushEntityMO and bossRushEntityMO.id == entityMO.id

	local multiHpNum = entityMO.attrMO.multiHpNum

	if self._isBossRush then
		local info = BossRushModel.instance:getMultiHpInfo()

		multiHpNum = info.multiHpNum
	end

	gohelper.setActive(self._multiHpRoot, multiHpNum > 1)

	if multiHpNum > 1 then
		self:com_createObjList(self._onMultiHpItemShow, multiHpNum, self._multiHpRoot, self._multiHpItem)
	end
end

function FightFocusView:_onMultiHpItemShow(obj, data, index)
	local multiHpNum = self._entityMO.attrMO.multiHpNum
	local multiHpIdx = self._entityMO.attrMO:getCurMultiHpIndex()

	if self._isBossRush then
		local info = BossRushModel.instance:getMultiHpInfo()

		multiHpNum = info.multiHpNum
		multiHpIdx = info.multiHpIdx
	end

	local image_HPFG1 = gohelper.findChild(obj, "hp")

	gohelper.setActive(image_HPFG1, index <= multiHpNum - multiHpIdx)

	if index == 1 and self._isBossRush then
		gohelper.setActive(image_HPFG1, true)
	end
end

function FightFocusView:_onCloseView(viewName)
	if viewName == ViewName.EquipInfoTipsView then
		self.openEquipInfoTipView = false
	end

	if viewName == ViewName.FightAttributeTipView then
		self.openFightAttributeTipView = false
	end
end

function FightFocusView:onClose()
	FightMsgMgr.sendMsg(FightMsgId.SetYaMiShieldEffectVisible, true)
	gohelper.setActive(self.odysseySuitRoot, false)
	gohelper.setActive(self.yaMiShieldRoot, false)
	TaskDispatcher.cancelTask(self._refreshUI, self)
	self:_releaseTween()

	if self._focusFlow then
		self._focusFlow:stop()

		self._focusFlow = nil
	end

	if self.subEntityList then
		for i, v in ipairs(self.subEntityList) do
			local entityMgr = FightGameMgr.entityMgr

			entityMgr:delEntity(v.id)
		end
	end

	FightController.instance:dispatchEvent(FightEvent.OnHideSkillEditorUIEvent, 1)
	FightController.instance:dispatchEvent(FightEvent.SetSkillEditorViewVisible, true)
	self:setAssistBossStatus(false, true)
end

function FightFocusView:onDestroyView()
	FightWorkFocusMonster.setVirtualCameDamping(1, 1, 1)
	self._simagebg:UnLoadImage()

	for i = 1, #self._skillGOs do
		local skillTable = self._skillGOs[i]

		skillTable.icon:UnLoadImage()
		skillTable.btn:RemoveClickListener()
	end

	for _, superItem in ipairs(self._superItemList) do
		superItem.icon:UnLoadImage()
		superItem.btn:RemoveClickListener()
	end

	self._superItemList = nil

	self._simageequipicon:UnLoadImage()

	if self.equipClick then
		self.equipClick:RemoveClickListener()
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	self:_releaseHeadItemList()
	self.resistanceComp:destroy()

	self.resistanceComp = nil

	self:removeStressComp()

	if self.killLineComp then
		self.killLineComp:destroy()

		self.killLineComp = nil
	end

	if self._assistBossView then
		self._assistBossView:destory()

		self._assistBossView = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightFocusView:removeStressComp()
	if self.stressComp then
		self.stressComp:destroy()

		self.stressComp = nil
	end
end

function FightFocusView:_releaseHeadItemList()
	if self.enemyItemList then
		for _, enemyItem in ipairs(self.enemyItemList) do
			enemyItem.btnClick:RemoveClickListener()
			gohelper.destroy(enemyItem.go)
		end

		self.enemyItemList = nil
	end
end

function FightFocusView:_setVirtualCameDamping()
	FightWorkFocusMonster.setVirtualCameDamping(0, 0, 0)
end

function FightFocusView:_setEntityPosAndActive(entityMO)
	local entityId = entityMO.id
	local combinative = false
	local tar_entity = FightHelper.getEntity(entityId)

	if tar_entity then
		local entity_mo = tar_entity:getMO()

		if entity_mo then
			local skin_config = FightConfig.instance:getSkinCO(entity_mo.skin)

			if skin_config and skin_config.canHide == 1 then
				combinative = true
			end
		end
	end

	local entityList = FightHelper.getAllEntitys()

	for _, oneEntity in ipairs(entityList) do
		if not FightHelper.isAssembledMonster(oneEntity) then
			oneEntity:setVisibleByPos(combinative or entityId == oneEntity.id)
		elseif entityMO.side ~= oneEntity:getSide() then
			oneEntity:setVisibleByPos(combinative or entityId == oneEntity.id)
		else
			oneEntity:setVisibleByPos(true)
		end

		if oneEntity.buff then
			if entityId ~= oneEntity.id then
				oneEntity.buff:hideBuffEffects()
			else
				oneEntity.buff:showBuffEffects()
			end
		end

		if oneEntity.nameUI then
			oneEntity.nameUI:setActive(entityId == oneEntity.id)
		end
	end

	local fightScene = GameSceneMgr.instance:getScene(SceneType.Fight)

	FightGameMgr.sceneLevelMgr:setFrontVisible(false)

	local tempPos

	if entityMO.side == FightEnum.EntitySide.MySide then
		local entityList = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide)
		local stanceId = FightHelper.getEntityStanceId(entityMO, FightModel.instance:getCurWaveId())
		local stanceConfig = lua_stance.configDict[stanceId]
		local pos = stanceConfig.pos1

		tempPos = pos

		for i, entity in ipairs(entityList) do
			if entity.id == entityMO.id then
				transformhelper.setLocalPos(entity.go.transform, pos[1], pos[2], pos[3])

				if entity.buff then
					entity.buff:hideBuffEffects()
					entity.buff:showBuffEffects()
				end
			else
				entity:setVisibleByPos(false)
			end
		end

		for i, v in ipairs(self.subEntityList) do
			transformhelper.setLocalPos(v.go.transform, 20000, 20000, 20000)
		end
	end

	local entity = FightHelper.getEntity(entityId)
	local isSub = FightDataHelper.entityMgr:isSub(entityId)

	if isSub then
		entity = nil

		for i, v in ipairs(self.subEntityList) do
			if v.id == entityId .. "focusSub" then
				local youtimu = FightHelper.getEntity(entityId)

				if youtimu then
					youtimu:setVisibleByPos(false)
				end

				entity = v

				transformhelper.setLocalPos(v.go.transform, tempPos[1], tempPos[2], tempPos[3])
			end
		end
	end

	if entity then
		local mountMiddleGo = entity:getHangPoint(ModuleEnum.SpineHangPoint.mountmiddle)
		local x, y, z = transformhelper.getPos(mountMiddleGo.transform)

		x = x + 2.7
		y = y - 2
		z = z + 5.4

		local skinCo
		local focusOffset = (isSub and FightConfig.instance:getSkinCO(FightDataHelper.entityMgr:getById(entityId).skin) or FightConfig.instance:getSkinCO(entity:getMO().skin)).focusOffset

		if #focusOffset == 3 then
			x = x + focusOffset[1]
			y = y + focusOffset[2]
			z = z + focusOffset[3]
		end

		self:_releaseTween()

		local cameraTrs = CameraMgr.instance:getVirtualCameraTrs()

		transformhelper.setPos(cameraTrs, x + 0.2, y, z)
	end
end

function FightFocusView:_releaseTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end
end

function FightFocusView:_playCameraTween()
	local cameraTrs = CameraMgr.instance:getVirtualCameraTrs()
	local x, y, z = transformhelper.getPos(cameraTrs)

	self._tweenId = ZProj.TweenHelper.DOMove(cameraTrs, x - 0.6, y, z, 0.5)
end

function FightFocusView:_focusEntity(entityMO)
	if self._focusFlow then
		self._focusFlow:stop()

		self._focusFlow = nil
	end

	self._focusFlow = FlowSequence.New()

	self._focusFlow:addWork(FunctionWork.New(self._setVirtualCameDamping, self))
	self._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	self._focusFlow:addWork(FightWorkFocusSubEntity.New(entityMO))
	self._focusFlow:addWork(FunctionWork.New(self._setEntityPosAndActive, self, entityMO))
	self._focusFlow:addWork(WorkWaitSeconds.New(0.01))
	self._focusFlow:addWork(FunctionWork.New(self._playCameraTween, self))
	self._focusFlow:addWork(WorkWaitSeconds.New(0.5))

	local context = {}

	context.subEntityList = self.subEntityList

	self._focusFlow:start(context)
end

function FightFocusView:_onBtnBuffMore()
	ViewMgr.instance:openView(ViewName.FightBuffTipsView, self._curSelectId)
end

function FightFocusView:refreshDouQuQuFetter()
	local customData = FightDataHelper.fieldMgr.customData

	if not customData then
		return
	end

	customData = customData[FightCustomData.CustomDataType.Act191]

	if customData then
		if self.douQuQuFetterView then
			self.douQuQuFetterView:refreshEntityMO(self._entityMO)
		else
			self.douQuQuFetterView = self:com_openSubView(FightDouQuQuFetterView, "ui/viewres/fight/fight_act191fetterview.prefab", self.go_fetter, self._entityMO)
		end
	end
end

function FightFocusView:refreshDouQuQuStar()
	local customData = FightDataHelper.fieldMgr.customData

	if not customData then
		return
	end

	customData = customData[FightCustomData.CustomDataType.Act191]

	if customData then
		gohelper.setActive(self.levelRoot, false)
	end
end

function FightFocusView:refreshDouQuQuCollection()
	local customData = FightDataHelper.fieldMgr.customData

	if not customData then
		return
	end

	customData = customData[FightCustomData.CustomDataType.Act191]

	if customData then
		gohelper.setActive(self.go_collection, true)

		if self.douQuQuCollectionView then
			self.douQuQuCollectionView:refreshEntityMO(self._entityMO)
		else
			self.douQuQuCollectionView = self:com_openSubView(FightDouQuQuCollectionView, "ui/viewres/fight/fight_act191collectionview.prefab", self.go_collection, self._entityMO)
		end
	end
end

function FightFocusView:showOdysseyEquip()
	local customData = FightDataHelper.fieldMgr.customData

	if not customData then
		return
	end

	customData = customData[FightCustomData.CustomDataType.Odyssey] or customData[FightCustomData.CustomDataType.Act128Sp]

	if customData then
		gohelper.setActive(self.go_collection, true)

		if self.odysseyEquipView then
			self.odysseyEquipView:refreshEntityMO(self._entityMO)
		else
			self.odysseyEquipView = self:com_openSubView(FightFocusOdysseyEquipView, "ui/viewres/fight/fight_odysseycollectionview.prefab", self.go_collection, self._entityMO)
		end
	end
end

function FightFocusView:showOdysseyEquipSuit()
	local customData = FightDataHelper.fieldMgr.customData

	if not customData then
		return
	end

	customData = customData[FightCustomData.CustomDataType.Odyssey] or customData[FightCustomData.CustomDataType.Act128Sp]

	if customData then
		gohelper.setActive(self.go_collection, true)

		if self.odysseyEquipSuitView then
			self.odysseyEquipSuitView:refreshEntityMO(self._entityMO)
		else
			self.odysseyEquipSuitView = self:com_openSubView(FightFocusOdysseyEquipSuitView, "ui/viewres/fight/fight_odysseysuitview.prefab", self.odysseySuitRoot, self._entityMO)
		end
	end
end

function FightFocusView:showAiJiAoExPointSlider()
	if self._entityMO.exPointType == FightEnum.ExPointType.Synchronization then
		gohelper.setActive(self.aiJiAoSliderRoot, true)

		if self.aiJiAoExPointSliderView then
			self.aiJiAoExPointSliderView:refreshEntityMO(self._entityMO)
		else
			self.aiJiAoExPointSliderView = self:com_openSubView(FightFocusAiJiAoExPointSliderView, "ui/viewres/fight/fightaijiaoenergysliderview.prefab", self.aiJiAoSliderRoot, self._entityMO)
		end
	else
		gohelper.setActive(self.aiJiAoSliderRoot, false)
	end
end

function FightFocusView:showAlert()
	gohelper.setActive(self.alertRoot, false)

	local powerInfoDic = self._entityMO._powerInfos

	if powerInfoDic then
		for powerId, powerInfo in pairs(powerInfoDic) do
			if powerId == FightEnum.PowerType.Alert then
				gohelper.setActive(self.alertRoot, true)

				if self.alertView then
					self.alertView:refreshData(self._entityMO.id, powerInfo)
				else
					local url = "ui/viewres/fight/fightalertview.prefab"

					self.alertView = self:com_openSubView(FightNamePowerInfoView6, url, self.alertRoot, self._entityMO.id, powerInfo, true)
				end
			end
		end
	end
end

FightFocusView.HealthInterval = -50

function FightFocusView:onClickHealth()
	if self._entityMO then
		local health = FightHelper.getSurvivalEntityHealth(self._entityMO.id)

		if not health then
			return
		end

		local healthStatus = FightNameUIHealthComp.getCurHealthStatus(health)
		local title = FightNameUIHealthComp.getHealthTitle(healthStatus)
		local desc = FightNameUIHealthComp.getHealthDesc(healthStatus)
		local width = recthelper.getWidth(self.rectSurvivalHealth)
		local height = recthelper.getHeight(self.rectSurvivalHealth)
		local screenPos = recthelper.uiPosToScreenPos(self.rectSurvivalHealth)

		screenPos.x = screenPos.x + width / 2 + FightFocusView.HealthInterval
		screenPos.y = screenPos.y + height / 2

		FightCommonTipController.instance:openCommonView(title, desc, screenPos)
	end
end

function FightFocusView:refreshHealth(entityMo)
	local health = entityMo and FightHelper.getSurvivalEntityHealth(entityMo.id)

	if not health then
		gohelper.setActive(self.goSurvivalHealth, false)

		return
	end

	gohelper.setActive(self.goSurvivalHealth, true)

	self.txtHealth.text = string.format("%d/%d", health, FightHelper.getSurvivalMaxHealth() or 120)

	local icon = FightNameUIHealthComp.getHealthIcon(health)

	UISpriteSetMgr.instance:setFightSprite(self.imageHealth, icon, true)
end

function FightFocusView:refreshToughness(entityMO)
	if not entityMO then
		gohelper.setActive(self.go_toughness, false)
		recthelper.setAnchorY(self._txthp.transform, 6.2)

		return false
	end

	local monsterConfig = lua_monster.configDict[entityMO.modelId]

	if not monsterConfig then
		gohelper.setActive(self.go_toughness, false)
		recthelper.setAnchorY(self._txthp.transform, 6.2)

		return false
	end

	if string.nilorempty(monsterConfig.toughness) then
		gohelper.setActive(self.go_toughness, false)
		recthelper.setAnchorY(self._txthp.transform, 6.2)

		return false
	end

	gohelper.setActive(self.go_toughness, true)
	recthelper.setAnchorY(self._txthp.transform, -53)

	local fill = gohelper.findChildImage(self.go_toughness, "fill")

	self.toughnessFillWidth = recthelper.getWidth(fill.transform)

	local lineObj = gohelper.findChild(self.go_toughness, "fill/line")
	local arr = string.splitToNumber(monsterConfig.toughness, "#")
	local lineCount = arr[2] - 1

	self.toughnessLineCount = lineCount

	local dataList = {}

	for i = 1, lineCount do
		dataList[i] = i
	end

	gohelper.CreateObjList(self, self.onToughLineItemShow, dataList, fill.gameObject, lineObj)

	local showType = arr[3]

	if showType == 0 then
		local oneNum = arr[1]
		local maxNum = oneNum * arr[2]

		fill.fillAmount = ((entityMO.toughnessPoint - 1) * oneNum + entityMO.toughnessValue) / maxNum
	elseif showType == 1 then
		local oneNum = entityMO.attrMO.hp * arr[1] / 1000
		local maxNum = oneNum * arr[2]

		fill.fillAmount = ((entityMO.toughnessPoint - 1) * oneNum + entityMO.toughnessValue) / maxNum
	end

	return true
end

function FightFocusView:onToughLineItemShow(obj, data, index)
	local posX = 0 - self.toughnessFillWidth / 2 + self.toughnessFillWidth / (self.toughnessLineCount + 1) * index

	recthelper.setAnchorX(obj.transform, posX)
end

function FightFocusView:refreshToughnessReward(entityMO)
	if not entityMO then
		gohelper.setActive(self.go_toughnessReward, false)

		return
	end

	local monsterConfig = lua_monster.configDict[entityMO.modelId]

	if not monsterConfig then
		gohelper.setActive(self.go_toughnessReward, false)

		return
	end

	if string.nilorempty(monsterConfig.toughness) then
		gohelper.setActive(self.go_toughnessReward, false)

		return
	end

	local toughnessConfig = lua_toughnessskill.configDict[monsterConfig.toughnessSkill]

	if not toughnessConfig then
		gohelper.setActive(self.go_toughnessReward, false)

		return
	end

	local buffId = toughnessConfig.cdBuff
	local empty = gohelper.findChild(self.go_toughnessReward, "empty")
	local has = gohelper.findChild(self.go_toughnessReward, "has")
	local icon = gohelper.findChildImage(self.go_toughnessReward, "has/#image_reward")
	local cd = gohelper.findChild(self.go_toughnessReward, "cd")
	local cdText = gohelper.findChildText(self.go_toughnessReward, "cd/#txt_cd")
	local isBroken = entityMO.isBroken

	if not isBroken then
		gohelper.setActive(empty, false)
		gohelper.setActive(has, true)
		gohelper.setActive(cd, false)
		UISpriteSetMgr.instance:setFightSprite(icon, toughnessConfig.iconNormal, true)
	else
		local hasBuff
		local buffData = entityMO:getBuffDataByBuffId(buffId)

		if buffData and buffData.actInfo then
			for i, v in ipairs(buffData.actInfo) do
				if v.actId == 1102 and v.param[1] > 0 then
					hasBuff = v.param[1]
				end
			end

			if hasBuff then
				gohelper.setActive(empty, false)
				gohelper.setActive(has, false)
				gohelper.setActive(cd, true)

				cdText.text = hasBuff
			else
				gohelper.setActive(empty, true)
				gohelper.setActive(has, false)
				gohelper.setActive(cd, false)
			end
		else
			gohelper.setActive(empty, true)
			gohelper.setActive(has, false)
			gohelper.setActive(cd, false)
		end
	end
end

function FightFocusView:refreshWeakness(entityMO, hasToughness)
	if not entityMO then
		return
	end

	local weaknessList = {}

	for i, v in ipairs(entityMO.weakCareers) do
		table.insert(weaknessList, v)
	end

	local hasWeakness = #weaknessList > 0

	gohelper.setActive(self.go_weakness, hasWeakness)

	if hasWeakness then
		local weaknessItem = gohelper.findChild(self.go_weakness, "#image_icon")

		gohelper.CreateObjList(self, self.onWeaknessItemShow, weaknessList, self.go_weakness, weaknessItem)

		if not hasToughness then
			recthelper.setAnchorY(self._txthp.transform, -42)
		end
	end
end

function FightFocusView:onWeaknessItemShow(obj, data, index)
	local image = gohelper.onceAddComponent(obj, gohelper.Type_Image)

	UISpriteSetMgr.instance:setFightSprite(image, "fight_toughness_fighticon_" .. data)
end

function FightFocusView:refreshYaMiShield(entityMO)
	gohelper.setActive(self.yaMiShieldTips, false)

	if not entityMO then
		gohelper.setActive(self.yaMiShieldRoot, false)

		return
	end

	local shieldData = FightMsgMgr.sendMsg(FightMsgId.GetYaMiShieldData, entityMO.id)

	if not shieldData then
		gohelper.setActive(self.yaMiShieldRoot, false)

		return
	end

	gohelper.setActive(self.yaMiShieldRoot, true)

	local shieldValue = shieldData.actInfo.param[1]

	self.yaMiShieldText.text = shieldValue
	self.tipsYaMiShieldValueText.text = shieldValue
	self.yaMiTipsDescText.text = FightBuffGetDescHelper.getBuffDesc(shieldData.buffData)
end

function FightFocusView:_onClickYaMiShield()
	gohelper.setActive(self.yaMiShieldTips, true)
end

function FightFocusView:_onCloseYaMiShieldTips()
	gohelper.setActive(self.yaMiShieldTips, false)
end

function FightFocusView:_checkDevice()
	if not self._godevice then
		return
	end

	self._deviceMo = SkillConfig.instance:getHeroDeviceMO(self._entityMO.modelId, self._entityMO)

	if self._deviceMo then
		if self._deviceView then
			self:_refreshDevice()
		else
			self._deviceViewPath = "ui/viewres/character/characterdeviceview_1.prefab"
			self._loader = MultiAbLoader.New()

			self._loader:addPath(self._deviceViewPath)
			self._loader:startLoad(self._onLoadFinish, self)
		end
	else
		gohelper.setActive(self._godevice, false)
		gohelper.setActive(self._skill, true)
	end
end

function FightFocusView:_refreshDevice()
	if not self._deviceView then
		return
	end

	self._deviceView:onUpdateMO(self._entityMO.modelId, self._entityMO)

	self._deviceMo = SkillConfig.instance:getHeroDeviceMO(self._entityMO.modelId, self._entityMO)

	local isDevice = self._deviceMo ~= nil

	gohelper.setActive(self._godevice, isDevice)
	gohelper.setActive(self._skill, not isDevice)
end

function FightFocusView:_onLoadFinish()
	if not self._deviceView then
		local assetItem = self._loader:getAssetItem(self._deviceViewPath)
		local viewPrefab = assetItem:GetResource(self._deviceViewPath)
		local go = gohelper.clone(viewPrefab, self._godevice)

		self._deviceView = MonoHelper.addNoUpdateLuaComOnceToGo(go, CharacterDeviceView)
	end

	self:_refreshDevice()
end

function FightFocusView:refreshMeiLeiEr(entityMO)
	local hasAct, buffData = entityMO:hasBuffActId(1139)

	if not hasAct then
		gohelper.setActive(self.go_meiLeiEr, false)

		return
	end

	gohelper.setActive(self.go_meiLeiEr, true)

	local trigger = 100
	local limit = 100
	local featuresSplit = entityMO:getFeaturesSplitInfoByBuffId(buffData.buffId)

	if featuresSplit then
		for _, oneFeature in ipairs(featuresSplit) do
			if oneFeature[1] == 1139 then
				trigger = oneFeature[2]
				limit = oneFeature[3]
			end
		end
	end

	local actInfo
	local actInfos = buffData.actInfo

	if actInfos then
		for _, buffActInfo in pairs(actInfos) do
			if buffActInfo.actId == 1139 then
				actInfo = buffActInfo

				break
			end
		end
	end

	if actInfo then
		self.meiLeiErSlider1.fillAmount = (actInfo.param[1] or 0) / trigger
		self.meiLeiErSlider2.fillAmount = ((actInfo.param[1] or 0) - trigger) / (limit - trigger)
	else
		self.meiLeiErSlider1.fillAmount = 0
		self.meiLeiErSlider2.fillAmount = 0
	end

	self.meiLeiErExroundRateText.text = (actInfo.param[1] or 0) / trigger * 100 .. "%"
end

function FightFocusView:refreshDevicePower(entityMo)
	if not entityMo then
		gohelper.setActive(self.goDevicePower, false)

		return
	end

	if entityMo.exPointType ~= FightEnum.ExPointType.DevicePower then
		gohelper.setActive(self.goDevicePower, false)

		return
	end

	gohelper.setActive(self.goDevicePower, true)

	local curPower = entityMo:getExPoint()
	local maxPower = entityMo:getMaxExPoint()
	local storeExPoint = entityMo:getStoredDeviceExPoint()

	self.txtDevicePower.text = storeExPoint > 0 and string.format("%s<color=#E99B56>(+%s)</color>/%s", curPower, storeExPoint, maxPower) or string.format("%s/%s", curPower, maxPower)

	if maxPower > 0 then
		self.imageDevicePowerProgress.fillAmount = curPower / maxPower or 1
	end

	local storePoint = entityMo:getStoredDeviceExPoint()

	if maxPower > 0 then
		self.imageStoreDevicePowerProgress.fillAmount = storePoint / maxPower or 1
	end
end

return FightFocusView
