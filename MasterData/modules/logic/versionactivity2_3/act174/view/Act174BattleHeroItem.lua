-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174BattleHeroItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174BattleHeroItem", package.seeall)

local Act174BattleHeroItem = class("Act174BattleHeroItem", LuaCompBase)

function Act174BattleHeroItem:ctor(readyItem)
	self._readyItem = readyItem
end

function Act174BattleHeroItem:init(go)
	self._go = go
	self._goSelect = gohelper.findChild(go, "go_Select")
	self._goEmpty = gohelper.findChild(go, "go_Empty")
	self._goHero = gohelper.findChild(go, "go_Hero")
	self._imageRare = gohelper.findChildImage(go, "go_Hero/rare")
	self._heroIcon = gohelper.findChildSingleImage(go, "go_Hero/image_Hero")
	self._imageCareer = gohelper.findChildImage(go, "go_Hero/image_Career")
	self._skillIcon = gohelper.findChildSingleImage(go, "go_Hero/skill/image_Skill")
	self._collectionQuality = gohelper.findChildImage(go, "go_Hero/collection/image_quality")
	self._collectionIcon = gohelper.findChildSingleImage(go, "go_Hero/collection/image_Collection")
	self._collectionEmpty = gohelper.findChild(go, "go_Hero/collection/empty")
	self._txtIndex = gohelper.findChildText(go, "Index/txt_Index")
	self._goLock = gohelper.findChild(go, "go_Lock")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "")

	self.addClickCb(self, self._btnClick, self.onClick, self)

	if self._readyItem then
		CommonDragHelper.instance:registerDragObj(go, self._readyItem.beginDrag, self._readyItem.onDrag, self._readyItem.endDrag, self._readyItem.checkDrag, self._readyItem, nil, true)
	end
end

function Act174BattleHeroItem:onClick()
	if self._readyItem and self._readyItem.isDraging or not self.info then
		return
	end

	if self.itemId ~= 0 then
		if not self.itemId then
			local itemId

			Activity174Controller.instance:openRoleInfoView(self.info.heroId, itemId)
		end
	end
end

function Act174BattleHeroItem:onDestroy()
	self._heroIcon:UnLoadImage()
	self._skillIcon:UnLoadImage()
	self._collectionIcon:UnLoadImage()

	if self._readyItem then
		CommonDragHelper.instance:unregisterDragObj(self._go)
	end
end

function Act174BattleHeroItem:setIndex(index)
	self._txtIndex.text = index
end

function Act174BattleHeroItem:setData(info, teamIndex, isEnemy)
	self.info = info

	local gameInfo = Activity174Model.instance:getActInfo():getGameInfo()

	if info then
		local roleCo = Activity174Config.instance:getRoleCo(info.heroId)

		self.itemId = info.itemId

		if self.itemId == 0 then
			self.itemId = gameInfo:getTempCollectionId(teamIndex, info.index, isEnemy)
		end

		local collectionCo = lua_activity174_collection.configDict[self.itemId]

		if roleCo then
			UISpriteSetMgr.instance:setAct174Sprite(self._imageRare, "act174_ready_rolebg_" .. roleCo.rare)
			UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. roleCo.career)

			local path = ResUrl.getHeadIconMiddle(roleCo.skinId)

			self._heroIcon:LoadImage(path)

			local skillIdList = Activity174Config.instance:getHeroSkillIdDic(info.heroId, true)
			local skillId = skillIdList[info.priorSkill]
			local skillCo = lua_skill.configDict[skillId]

			if skillCo then
				self._skillIcon:LoadImage(ResUrl.getSkillIcon(skillCo.icon))
			end

			gohelper.setActive(self._skillIcon, skillCo)
		end

		if collectionCo then
			self._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(collectionCo.icon))
			UISpriteSetMgr.instance:setAct174Sprite(self._collectionQuality, "act174_propitembg_" .. collectionCo.rare)
		end

		gohelper.setActive(self._collectionIcon, collectionCo)
		gohelper.setActive(self._collectionEmpty, not collectionCo)
	end

	gohelper.setActive(self._goHero, info)
	gohelper.setActive(self._goEmpty, not info)
end

return Act174BattleHeroItem
