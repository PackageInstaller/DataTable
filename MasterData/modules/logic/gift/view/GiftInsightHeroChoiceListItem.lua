-- chunkname: @modules/logic/gift/view/GiftInsightHeroChoiceListItem.lua

module("modules.logic.gift.view.GiftInsightHeroChoiceListItem", package.seeall)

local GiftInsightHeroChoiceListItem = class("GiftInsightHeroChoiceListItem")

function GiftInsightHeroChoiceListItem:init(go)
	self._go = go
	self._gorole = gohelper.findChild(go, "role")
	self._imageRare = gohelper.findChildImage(go, "role/rare")
	self._simageIcon = gohelper.findChildSingleImage(go, "role/heroicon")
	self._imageCareer = gohelper.findChildImage(go, "role/career")
	self._txtname = gohelper.findChildText(go, "role/name")
	self._goexskill = gohelper.findChild(go, "role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(go, "role/#go_exskill/#image_exskill")
	self._gorank = gohelper.findChild(go, "role/Rank")
	self._rankGos = {}

	for i = 1, 3 do
		self._rankGos[i] = gohelper.findChild(self._gorank, "rank" .. i)
	end

	self._goselect = gohelper.findChild(go, "select")
	self._goclick = gohelper.findChild(go, "go_click")
	self._clickitem = gohelper.getClick(self._goclick)
	self._showUp = true

	self:_addEvents()
end

function GiftInsightHeroChoiceListItem:_addEvents()
	self._clickitem:AddClickListener(self._onClickItem, self)
	GiftController.instance:registerCallback(GiftEvent.InsightHeroChoose, self._refresh, self)
end

function GiftInsightHeroChoiceListItem:_removeEvents()
	self._clickitem:RemoveClickListener()
	GiftController.instance:unregisterCallback(GiftEvent.InsightHeroChoose, self._refresh, self)
end

function GiftInsightHeroChoiceListItem:hide()
	gohelper.setActive(self._go, false)
end

function GiftInsightHeroChoiceListItem:refreshItem(heroMO)
	gohelper.setActive(self._go, true)

	self._heroMO = heroMO

	self:_refresh()
end

function GiftInsightHeroChoiceListItem:_onClickItem()
	if not self._showUp then
		return
	end

	GiftInsightHeroChoiceModel.instance:setCurHeroId(self._heroMO.heroId)
	GiftController.instance:dispatchEvent(GiftEvent.InsightHeroChoose)
end

function GiftInsightHeroChoiceListItem:_refresh()
	local curHeroId = GiftInsightHeroChoiceModel.instance:getCurHeroId()

	gohelper.setActive(self._goselect, curHeroId == self._heroMO.heroId)

	if self._heroMO then
		local skinId = self._heroMO.skin
		local skinCo = skinId and lua_skin.configDict[skinId]
		local iconRes = ResUrl.getRoomHeadIcon(skinCo.headIcon)

		self._simageIcon:LoadImage(iconRes)

		self._txtname.text = self._heroMO.config.name

		UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. tostring(self._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(self._imageRare, "equipbar" .. self._heroMO.config.rare + 1)
		gohelper.setActive(self._gorank, self._heroMO.rank > 1)

		for i = 1, 3 do
			gohelper.setActive(self._rankGos[i], i == self._heroMO.rank - 1)
		end

		self._imageexskill.fillAmount = 0.2 * self._heroMO.exSkillLevel
	end
end

function GiftInsightHeroChoiceListItem:showUp(show)
	self._showUp = show

	gohelper.setActive(self._goneed, show)
end

function GiftInsightHeroChoiceListItem:destroy()
	self._simageIcon:UnLoadImage()
	self:_removeEvents()
end

return GiftInsightHeroChoiceListItem
