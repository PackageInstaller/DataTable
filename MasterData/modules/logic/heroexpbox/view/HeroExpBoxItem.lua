-- chunkname: @modules/logic/heroexpbox/view/HeroExpBoxItem.lua

module("modules.logic.heroexpbox.view.HeroExpBoxItem", package.seeall)

local HeroExpBoxItem = class("HeroExpBoxItem", ListScrollCellExtend)

function HeroExpBoxItem:onInitView()
	self._goexskill = gohelper.findChild(self.viewGO, "heroitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "heroitem/role/#go_exskill/#image_exskill")
	self._gotip = gohelper.findChild(self.viewGO, "heroitem/role/#go_tip")
	self._txttip = gohelper.findChildText(self.viewGO, "heroitem/role/#go_tip/#txt_tip")
	self._goclick = gohelper.findChild(self.viewGO, "heroitem/select/#go_click")
	self._gomask = gohelper.findChild(self.viewGO, "heroitem/role/go_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroExpBoxItem:addEvents()
	self._clickitem:AddClickListener(self._onClickItem, self)
	self._btnLongPress:AddLongPressListener(self._btnLongPressOnClick, self)
end

function HeroExpBoxItem:removeEvents()
	self._clickitem:RemoveClickListener()
	self._btnLongPress:RemoveLongPressListener()
end

function HeroExpBoxItem:_editableInitView()
	local go = gohelper.findChild(self.viewGO, "heroitem")

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
	self._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(self._goclick)

	self._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})
end

function HeroExpBoxItem:_editableAddEvents()
	return
end

function HeroExpBoxItem:_editableRemoveEvents()
	return
end

function HeroExpBoxItem:onUpdateMO(mo)
	self._mo = mo

	local tipStr = ""
	local status = self._mo:getStatus()

	if status == HeroExpBoxEnum.HeroStatus.MAX then
		tipStr = luaLang("HeroExpBoxItem_MaxLv1")
	elseif status == HeroExpBoxEnum.HeroStatus.EnoughHeroItem then
		tipStr = luaLang("HeroExpBoxItem_MaxLv2")
	end

	local isTip = not string.nilorempty(tipStr)

	gohelper.setActive(self._gotip, isTip)
	gohelper.setActive(self._gomask, status ~= HeroExpBoxEnum.HeroStatus.Normal)
	gohelper.setActive(self._goexskill, status ~= HeroExpBoxEnum.HeroStatus.Lock)

	self._txttip.text = tipStr

	self:_refreshIcon()
	self:refreshSelect()
end

function HeroExpBoxItem:_refreshIcon()
	local skinCo = lua_skin.configDict[self._mo:getSkinId()]
	local iconRes = ResUrl.getRoomHeadIcon(skinCo.headIcon)

	self._simageIcon:LoadImage(iconRes)

	self._txtname.text = self._mo.heroConfig.name

	UISpriteSetMgr.instance:setCommonSprite(self._imageCareer, "lssx_" .. tostring(self._mo.heroConfig.career))
	UISpriteSetMgr.instance:setCommonSprite(self._imageRare, "equipbar" .. self._mo.heroConfig.rare + 1)

	local rank = self._mo:getRank()

	gohelper.setActive(self._gorank, rank > 1)

	for i = 1, 3 do
		gohelper.setActive(self._rankGos[i], i == rank - 1)
	end

	self._imageexskill.fillAmount = 0.2 * self._mo:getExSkillLevel()
end

function HeroExpBoxItem:_onClickItem()
	local status = self._mo:getStatus()

	if status == HeroExpBoxEnum.HeroStatus.MAX then
		GameFacade.showToast(ToastEnum.HeroExSkillMaxLevel)

		return
	elseif status == HeroExpBoxEnum.HeroStatus.EnoughHeroItem then
		GameFacade.showToast(ToastEnum.HasUnuseHeroItem)

		return
	elseif status == HeroExpBoxEnum.HeroStatus.Lock then
		GameFacade.showToast(ToastEnum.HeroLock)

		return
	end

	if HeroExpBoxModel.instance:getSelectHeroId() == self._mo.heroId then
		HeroExpBoxModel.instance:setSelectHeroId()
	else
		HeroExpBoxModel.instance:setSelectHeroId(self._mo.heroId)
	end

	HeroExpBoxController.instance:dispatchEvent(HeroExpBoxEvent.SelectHeroItem)
end

function HeroExpBoxItem:_btnLongPressOnClick()
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, self._mo)
end

function HeroExpBoxItem:refreshSelect()
	local isSelect = HeroExpBoxModel.instance:getSelectHeroId() == self._mo.heroId

	gohelper.setActive(self._goselect, isSelect)
end

function HeroExpBoxItem:onDestroyView()
	self._simageIcon:UnLoadImage()
end

return HeroExpBoxItem
