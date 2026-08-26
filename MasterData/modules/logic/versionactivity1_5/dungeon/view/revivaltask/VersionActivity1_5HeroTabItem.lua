-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5HeroTabItem.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5HeroTabItem", package.seeall)

local VersionActivity1_5HeroTabItem = class("VersionActivity1_5HeroTabItem", UserDataDispose)

function VersionActivity1_5HeroTabItem.createItem(go, heroTaskMo)
	local item = VersionActivity1_5HeroTabItem.New()

	item:init(go, heroTaskMo)

	return item
end

function VersionActivity1_5HeroTabItem:init(go, heroTaskMo)
	self:__onInit()

	self.go = go
	self.id = heroTaskMo.id
	self.heroTaskMo = heroTaskMo
	self.config = heroTaskMo.config
	self.isUnlock = self.heroTaskMo:isUnlock()
	self.imageheroicon = gohelper.findChildImage(self.go, "#image_heroicon")
	self.goLocked = gohelper.findChild(self.go, "#go_Locked")
	self.txtLocked = gohelper.findChildText(self.go, "#go_Locked/#txt_lock")
	self.goClickArea = gohelper.findChild(self.go, "#go_clickarea")
	self.goRedDot = gohelper.findChild(self.go, "redPoint")
	self.goRedDotRectTr = self.goRedDot:GetComponent(gohelper.Type_RectTransform)
	self.click = gohelper.getClickWithDefaultAudio(self.goClickArea)

	self.click:AddClickListener(self.onClickSelf, self)
	gohelper.setActive(self.go, true)
	gohelper.setActive(self.goRedDot, true)
	self.addEventCb(self, VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.SelectHeroTaskTabChange, self.refreshHeroIcon, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self.refreshRedDot, self)
	self:refreshUI()
end

function VersionActivity1_5HeroTabItem:onClickSelf()
	if not self.isUnlock then
		GameFacade.showToast(self.config.toastId)

		return
	end

	VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(self.id)
end

function VersionActivity1_5HeroTabItem:refreshUI()
	self:refreshLockUI()
	self:refreshHeroIcon()
end

function VersionActivity1_5HeroTabItem:refreshLockUI()
	gohelper.setActive(self.goLocked, not self.isUnlock)

	if not self.isUnlock then
		self.txtLocked.text = luaLang("rolestoryrewardstate_1")
	end
end

function VersionActivity1_5HeroTabItem:refreshHeroIcon()
	gohelper.setActive(self.imageheroicon.gameObject, self.isUnlock)

	if not self.isUnlock then
		return
	end

	local imageName = ""

	imageName = self:isExploreTask() and (self:isSelect() and VersionActivity1_5DungeonEnum.ExploreTabImageSelect or VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect) or self:isSelect() and self.config.heroTabIcon .. "_" .. 1 or self.config.heroTabIcon .. "_" .. 2

	UISpriteSetMgr.instance:setV1a5RevivalTaskSprite(self.imageheroicon, imageName)
	self:refreshRedDot()
end

function VersionActivity1_5HeroTabItem:isExploreTask()
	return self.id == VersionActivity1_5DungeonEnum.ExploreTaskId
end

function VersionActivity1_5HeroTabItem:refreshRedDot()
	if self:isExploreTask() then
		RedDotController.instance:addRedDot(self.goRedDot, RedDotEnum.DotNode.V1a5DungeonExploreTask, nil, self.refreshExploreRedDot, self)
	else
		self:createRedDot()

		local redDotInfoMo = self:getHeroTaskRedDotMo()

		gohelper.setActive(self.goRedDotIcon, redDotInfoMo and redDotInfoMo.value > 0)
	end

	if self:isSelect() then
		if not VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Normal then
			local anchor = VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor.Lock

			recthelper.setAnchor(self.goRedDotRectTr, anchor.x, anchor.y)
		end
	end
end

function VersionActivity1_5HeroTabItem:getHeroTaskRedDotMo()
	if self:isExploreTask() then
		return
	end

	local redDotGroupMo = RedDotModel.instance:getRedDotInfo(RedDotEnum.DotNode.V1a5DungeonHeroTask)

	if not redDotGroupMo then
		logWarn("not found red dot group mo, id = " .. RedDotEnum.DotNode.V1a5DungeonHeroTask)

		return
	end

	for _, redDotInfoMo in pairs(redDotGroupMo.infos) do
		if redDotInfoMo.uid == self.id then
			return redDotInfoMo
		end
	end
end

function VersionActivity1_5HeroTabItem:createRedDot()
	if self:isExploreTask() then
		return
	end

	if self.goRedDotIcon then
		return
	end

	local redDotGo = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, self.goRedDot)

	for _, v in pairs(RedDotEnum.Style) do
		local go = gohelper.findChild(redDotGo, "type" .. v)

		gohelper.setActive(go, false)

		if v == RedDotEnum.Style.Normal then
			self.goRedDotIcon = go
		end
	end
end

function VersionActivity1_5HeroTabItem:refreshExploreRedDot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		redDotIcon.show = VersionActivity1_5RevivalTaskModel.instance:checkNeedShowElementRedDot()

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function VersionActivity1_5HeroTabItem:isSelect()
	return VersionActivity1_5RevivalTaskModel.instance:getSelectHeroTaskId() == self.id
end

function VersionActivity1_5HeroTabItem:destroy()
	self.click:RemoveClickListener()
	self:__onDispose()
end

return VersionActivity1_5HeroTabItem
