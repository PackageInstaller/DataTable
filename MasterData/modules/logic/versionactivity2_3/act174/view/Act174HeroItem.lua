-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174HeroItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174HeroItem", package.seeall)

local Act174HeroItem = class("Act174HeroItem", LuaCompBase)

function Act174HeroItem:ctor(act174TeamView)
	self._teamView = act174TeamView
end

function Act174HeroItem:init(go)
	self._go = go
	self._goHero = gohelper.findChild(go, "go_Hero")
	self._heroIcon = gohelper.findChildSingleImage(go, "go_Hero/image_Hero")
	self._heroQuality = gohelper.findChildImage(go, "go_Hero/image_quality")
	self._heroCareer = gohelper.findChildImage(go, "go_Hero/image_Career")
	self._goEquip = gohelper.findChild(go, "go_Equip")
	self._skillIcon = gohelper.findChildSingleImage(go, "go_Equip/skill/image_Skill")
	self._collectionIcon = gohelper.findChildSingleImage(go, "go_Equip/collection/image_Collection")
	self._goEmptyCollection = gohelper.findChild(go, "go_Equip/collection/empty")
	self._goEmpty = gohelper.findChild(go, "go_Empty")
	self._txtNum = gohelper.findChildText(go, "Index/txt_Num")
	self._goLock = gohelper.findChild(go, "go_Lock")
	self.btnClick = gohelper.findButtonWithAudio(go)

	CommonDragHelper.instance:registerDragObj(go, self.beginDrag, nil, self.endDrag, self.checkDrag, self)
	gohelper.setActive(self._goEmpty, true)
	gohelper.setActive(self._goHero, false)
end

function Act174HeroItem:addEventListeners()
	self.btnClick:AddClickListener(self.onClick, self)
end

function Act174HeroItem:removeEventListeners()
	self.btnClick:RemoveClickListener()
end

function Act174HeroItem:onDestroy()
	self._heroIcon:UnLoadImage()
	self._skillIcon:UnLoadImage()
	self._collectionIcon:UnLoadImage()
	CommonDragHelper.instance:unregisterDragObj(self._go)
end

function Act174HeroItem:onClick()
	if self.tweenId or self.isDraging then
		return
	end

	self._teamView:clickHero(self._index)
end

function Act174HeroItem:setIndex(index)
	self._index = index

	local row, column = Activity174Helper.CalculateRowColumn(index)

	self._txtNum.text = column

	local teamCnt = self._teamView.unLockTeamCnt

	gohelper.setActive(self._goLock, teamCnt < row)
	gohelper.setActive(self._goEquip, row <= teamCnt)
end

function Act174HeroItem:setData(heroId, itemId, skillIndex)
	self._heroId = heroId
	self._itemId = itemId
	self._skillIndex = skillIndex

	if heroId then
		local roleCo = Activity174Config.instance:getRoleCo(heroId)
		local path = ResUrl.getHeadIconMiddle(roleCo.skinId)

		self._heroIcon:LoadImage(path)
		UISpriteSetMgr.instance:setAct174Sprite(self._heroQuality, "act174_ready_rolebg_" .. roleCo.rare)
		UISpriteSetMgr.instance:setCommonSprite(self._heroCareer, "lssx_" .. roleCo.career)
	end

	if itemId then
		local config = lua_activity174_collection.configDict[itemId]

		self._collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))
	end

	if skillIndex then
		local skillIdList = Activity174Config.instance:getHeroSkillIdDic(self._heroId, true)
		local skillId = skillIdList[skillIndex]
		local config = lua_skill.configDict[skillId]

		self._skillIcon:LoadImage(ResUrl.getSkillIcon(config.icon))
	end

	gohelper.setActive(self._goHero, heroId)
	gohelper.setActive(self._collectionIcon, itemId)
	gohelper.setActive(self._goEmptyCollection, not itemId)
	gohelper.setActive(self._skillIcon, skillIndex)
	gohelper.setActive(self._goEmpty, not heroId and not itemId)
end

function Act174HeroItem:activeEquip(isActive)
	gohelper.setActive(self._goEquip, isActive)
end

function Act174HeroItem:beginDrag()
	gohelper.setAsLastSibling(self._go)

	self.isDraging = true
end

function Act174HeroItem:endDrag(_, pointerEventData)
	self.isDraging = false

	local pos = pointerEventData.position
	local targetItem = self:findTarget(pos)

	if not targetItem then
		local targetTr = self._teamView.frameTrList[self._index]
		local x, y = recthelper.getAnchor(targetTr)

		self.setToPos(self, self._go.transform, Vector2(x, y), true, self.tweenCallback, self)
		self._teamView:UnInstallHero(self._index)
	else
		local targetTr = self._teamView.frameTrList[targetItem._index]
		local x, y = recthelper.getAnchor(targetTr)

		self.setToPos(self, self._go.transform, Vector2(x, y), true, self.tweenCallback, self)

		if targetItem ~= self then
			local tr = self._teamView.frameTrList[self._index]
			local i, j = recthelper.getAnchor(tr)

			self.setToPos(self, targetItem._go.transform, Vector2(i, j), true, function()
				self._teamView:exchangeHeroItem(self._index, targetItem._index)
			end, self)
		end
	end
end

function Act174HeroItem:checkDrag()
	if self._heroId and self._heroId ~= 0 then
		return false
	end

	return true
end

function Act174HeroItem:findTarget(position)
	for i = 1, self._teamView.unLockTeamCnt * 4 do
		local framTr = self._teamView.frameTrList[i]
		local heroItem = self._teamView.heroItemList[i]
		local x, y = recthelper.getAnchor(framTr)
		local posTr = framTr.parent
		local anchorPos = recthelper.screenPosToAnchorPos(position, posTr)

		if math.abs(anchorPos.x - x) * 2 < recthelper.getWidth(framTr) and math.abs(anchorPos.y - y) * 2 < recthelper.getHeight(framTr) then
			return heroItem or nil
		end
	end

	return nil
end

function Act174HeroItem:setToPos(transform, anchorPos, tween, callback, callbackObj)
	if tween then
		CommonDragHelper.instance:setGlobalEnabled(false)

		self.tweenId = ZProj.TweenHelper.DOAnchorPos(transform, anchorPos.x, anchorPos.y, 0.2, callback, callbackObj)
	else
		recthelper.setAnchor(transform, anchorPos.x, anchorPos.y)

		if callback then
			callback(callbackObj)
		end
	end
end

function Act174HeroItem:tweenCallback()
	self.tweenId = nil

	CommonDragHelper.instance:setGlobalEnabled(true)
end

return Act174HeroItem
