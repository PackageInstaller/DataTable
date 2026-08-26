-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191EnemyInfoView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191EnemyInfoView", package.seeall)

local Act191EnemyInfoView = class("Act191EnemyInfoView", BaseView)

function Act191EnemyInfoView:onInitView()
	self._imageLevel = gohelper.findChildImage(self.viewGO, "left_container/Title/#image_Level")
	self._scrollteam = gohelper.findChildScrollRect(self.viewGO, "left_container/#scroll_team")
	self._goHeroItem = gohelper.findChild(self.viewGO, "left_container/#scroll_team/viewport/content/#go_HeroItem")
	self._goMain = gohelper.findChild(self.viewGO, "left_container/#scroll_team/viewport/content/#go_Main")
	self._goSub = gohelper.findChild(self.viewGO, "left_container/#scroll_team/viewport/content/#go_Sub")
	self._goFetter = gohelper.findChild(self.viewGO, "left_container/#scroll_team/viewport/content/#go_Fetter")
	self._goRightContainer = gohelper.findChild(self.viewGO, "#go_RightContainer")
	self._imageRare = gohelper.findChildImage(self.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Rare")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#go_RightContainer/go_SingleHero/character/#simage_Icon")
	self._imageCareer = gohelper.findChildImage(self.viewGO, "#go_RightContainer/go_SingleHero/character/#image_Career")
	self._imageDmgtype = gohelper.findChildImage(self.viewGO, "#go_RightContainer/go_SingleHero/#image_Dmgtype")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_RightContainer/go_SingleHero/name/#txt_Name")
	self._goFetterIcon = gohelper.findChild(self.viewGO, "#go_RightContainer/go_SingleHero/tag/#go_FetterIcon")
	self._goCEmpty1 = gohelper.findChild(self.viewGO, "#go_RightContainer/Collection1/#go_CEmpty1")
	self._goCollection1 = gohelper.findChild(self.viewGO, "#go_RightContainer/Collection1/#go_Collection1")
	self._imageCRare1 = gohelper.findChildImage(self.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#image_CRare1")
	self._simageCIcon1 = gohelper.findChildSingleImage(self.viewGO, "#go_RightContainer/Collection1/#go_Collection1/#simage_CIcon1")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191EnemyInfoView:onClickModalMask()
	self:closeThis()
end

function Act191EnemyInfoView:_editableInitView()
	local cBtn1 = gohelper.findButtonWithAudio(self._goCollection1)

	self.addClickCb(self, cBtn1, self.onClickCollection, self)

	self._fetterItemList = {}
	self.characterItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goRightContainer, Act191CharacterInfo)
	self._fetterIconItemList = {}
end

function Act191EnemyInfoView:onOpen()
	self.nodeDetailMo = self.viewParam
	self.matchMo = self.nodeDetailMo.matchInfo

	local fightLvl = lua_activity191_match_rank.configDict[self.matchMo.rank].fightLevel

	UISpriteSetMgr.instance:setAct174Sprite(self._imageLevel, "act191_level_" .. string.lower(fightLvl))

	self.heroItemDic = {}

	for index, info in pairs(self.matchMo.heroMap) do
		self.selectMain = self.selectMain or index

		local roleCo = self.matchMo:getRoleCo(info.heroId)
		local parent = gohelper.clone(self._goHeroItem, self._goMain)
		local go = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, parent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191HeroHeadItem)

		item:setData(nil, roleCo.id)
		item:setOverrideClick(self.onClickHero, self, index)

		self.heroItemDic[index] = item
	end

	self.subHeroItemDic = {}

	for index, heroId in pairs(self.matchMo.subHeroMap) do
		local roleCo = self.matchMo:getRoleCo(heroId)
		local parent = gohelper.clone(self._goHeroItem, self._goSub)
		local go = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, parent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191HeroHeadItem)

		item:setData(nil, roleCo.id)
		item:setOverrideClick(self.onClickSubHero, self, index)

		self.subHeroItemDic[index] = item
	end

	gohelper.setActive(self._goHeroItem, false)
	self:onClickHero(self.selectMain, true)
	self:refreshFetter()
end

function Act191EnemyInfoView:refreshCharacter(heroId)
	local roleCo = self.matchMo:getRoleCo(heroId)

	UISpriteSetMgr.instance:setAct174Sprite(self._imageRare, "act174_rolebg_" .. roleCo.quality)
	UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. roleCo.career)

	local path = Activity191Helper.getHeadIconSmall(roleCo)

	self._simageIcon:LoadImage(path)

	self._txtName.text = roleCo.name

	self.characterItem:setData(roleCo)

	local tagList = string.split(roleCo.tag, "#")

	for k, tag in ipairs(tagList) do
		local item = self._fetterIconItemList[k]

		if not item then
			local go = gohelper.cloneInPlace(self._goFetterIcon)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterIconItem)
			self._fetterIconItemList[k] = item
		end

		item:setData(tag)
		item:setEnemyView()
		gohelper.setActive(self._fetterIconItemList[k].go, true)
	end

	for i = #tagList + 1, #self._fetterIconItemList do
		gohelper.setActive(self._fetterIconItemList[i].go, false)
	end

	gohelper.setActive(self._goFetterIcon, false)
end

function Act191EnemyInfoView:refreshFetter()
	for _, item in ipairs(self._fetterItemList) do
		gohelper.setActive(item.go, false)
	end

	local fetterCntDic = self.matchMo:getTeamFetterCntDic()
	local fetterInfoList = Activity191Helper.getActiveFetterInfoList(fetterCntDic)

	for k, info in ipairs(fetterInfoList) do
		local item = self._fetterItemList[k]

		if not item then
			local go = self:getResInst(Activity191Enum.PrefabPath.FetterItem, self._goFetter)

			item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191FetterItem)

			item:setEnemyView()

			self._fetterItemList[k] = item
		end

		item:setData(info.config, info.count)
		gohelper.setActive(item.go, true)
	end
end

function Act191EnemyInfoView:onClickHero(index, noCheck)
	if not noCheck and self.selectMain == index then
		return
	else
		self.selectMain = index
		self.selectSub = 0
	end

	for k, item in pairs(self.heroItemDic) do
		item:setActivation(k == index)
	end

	for _, item in pairs(self.subHeroItemDic) do
		item:setActivation(false)
	end

	local info = self.matchMo.heroMap[index]

	self:refreshCharacter(info.heroId)
	gohelper.setActive(self._goCEmpty1, false)
	gohelper.setActive(self._goCollection1, false)
end

function Act191EnemyInfoView:onClickSubHero(index)
	if self.selectSub == index then
		return
	else
		self.selectSub = index
		self.selectMain = 0

		for _, item in pairs(self.heroItemDic) do
			item:setActivation(false)
		end

		for k, item in pairs(self.subHeroItemDic) do
			item:setActivation(k == index)
		end
	end

	local heroId = self.matchMo.subHeroMap[index]

	self:refreshCharacter(heroId)
	gohelper.setActive(self._goCEmpty1, true)
	gohelper.setActive(self._goCollection1, false)
end

function Act191EnemyInfoView:onClickCollection()
	if self.selectMain then
		local info = self.matchMo.heroMap[self.selectMain]
		local itemUid = info.itemUid1

		if itemUid ~= 0 then
			local itemCo = self.matchMo:getItemCo(itemUid)

			Activity191Controller.instance:openCollectionTipView({
				itemId = itemCo.id
			})
		end
	end
end

return Act191EnemyInfoView
