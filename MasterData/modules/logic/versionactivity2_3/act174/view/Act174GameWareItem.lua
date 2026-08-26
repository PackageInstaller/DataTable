-- chunkname: @modules/logic/versionactivity2_3/act174/view/Act174GameWareItem.lua

module("modules.logic.versionactivity2_3.act174.view.Act174GameWareItem", package.seeall)

local Act174GameWareItem = class("Act174GameWareItem", LuaCompBase)

function Act174GameWareItem:ctor(wareHouseView)
	self.wareHouseView = wareHouseView
end

function Act174GameWareItem:init(go)
	self.go = go
	self.goRole = gohelper.findChild(go, "role")
	self.heroRare = gohelper.findChildImage(go, "role/rare")
	self.heroIcon = gohelper.findChildSingleImage(go, "role/heroicon")
	self.heroCareer = gohelper.findChildImage(go, "role/career")
	self.txtName = gohelper.findChildText(go, "role/name")
	self.goNewRole = gohelper.findChild(go, "role/#new")
	self.goCollection = gohelper.findChild(go, "collection")
	self.collectionRare = gohelper.findChildImage(go, "collection/rare")
	self.collectionIcon = gohelper.findChildSingleImage(go, "collection/collectionicon")
	self.goNewCollection = gohelper.findChild(go, "collection/#new")
	self.goSelect = gohelper.findChild(go, "go_select")
	self.goHeroTip = gohelper.findChild(go, "go_select/txt_equiprole")
	self.goCollectionTip = gohelper.findChild(go, "go_select/txt_equipcollection")
	self.goNew = gohelper.findChild(go, "go_new")
	self.click = gohelper.findChildClickWithAudio(go, "btn_click", AudioEnum.Act174.play_artificial_ui_carddisappear)

	local clickGo = gohelper.findChild(go, "btn_click")

	self.longClick = SLFramework.UGUI.UILongPressListener.Get(clickGo)

	self.longClick:SetLongPressTime({
		0.5,
		99999
	})
end

function Act174GameWareItem:addEventListeners()
	self.click:AddClickListener(self.clickItem, self)
	self.click:AddClickDownListener(self.onClickDown, self)
	self.longClick:AddLongPressListener(self.onLongPress, self)
end

function Act174GameWareItem:removeEventListeners()
	self.click:RemoveClickListener()
	self.click:RemoveClickDownListener()
	self.longClick:RemoveLongPressListener()
end

function Act174GameWareItem:onDestroy()
	self.heroIcon:UnLoadImage()
	self.collectionIcon:UnLoadImage()
	TaskDispatcher.cancelTask(self.newAnimEnd, self)
end

function Act174GameWareItem:setIndex(index)
	self.index = index
end

function Act174GameWareItem:setData(wareData, wareType)
	if not wareData then
		gohelper.setActive(self.go, false)

		return
	end

	self.gameInfo = Activity174Model.instance:getActInfo():getGameInfo()
	self.wareData = wareData
	self.wareType = wareType

	local wareId = wareData.id

	if self.wareType == Activity174Enum.WareType.Hero then
		self.config = lua_activity174_role.configDict[wareId]

		self.heroIcon:LoadImage(ResUrl.getHeadIconSmall(self.config.skinId))
		UISpriteSetMgr.instance:setCommonSprite(self.heroRare, "bgequip" .. tostring(CharacterEnum.Color[self.config.rare]))
		UISpriteSetMgr.instance:setCommonSprite(self.heroCareer, "lssx_" .. self.config.career)

		self.txtName.text = self.config.name
	elseif self.wareType == Activity174Enum.WareType.Collection then
		self.config = lua_activity174_collection.configDict[wareId]

		self.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(self.config.icon))
		UISpriteSetMgr.instance:setAct174Sprite(self.collectionRare, "act174_propitembg_" .. self.config.rare)
	end

	gohelper.setActive(self.goRole, self.wareType == Activity174Enum.WareType.Hero)
	gohelper.setActive(self.goCollection, self.wareType == Activity174Enum.WareType.Collection)
	self:refreshSelect()
	gohelper.setActive(self.go, true)
	self.addEventCb(self, Activity174Controller.instance, Activity174Event.SwitchShopTeam, self.refreshSelect, self)
	self:setNew(false)
end

function Act174GameWareItem:refreshSelect()
	if self.wareHouseView._goEditTeam.activeInHierarchy then
		gohelper.setActive(self.goSelect, self.wareData.isEquip == 1)
		gohelper.setActive(self.goHeroTip, self.wareType == Activity174Enum.WareType.Hero)
		gohelper.setActive(self.goCollectionTip, self.wareType == Activity174Enum.WareType.Collection)
	else
		gohelper.setActive(self.goSelect, false)
	end
end

function Act174GameWareItem:setNew(isNew)
	gohelper.setActive(self.goNew, isNew)
end

function Act174GameWareItem:playNew()
	if self.wareType == Activity174Enum.WareType.Hero then
		gohelper.setActive(self.goNewRole, true)
	else
		gohelper.setActive(self.goNewCollection, true)
	end

	TaskDispatcher.runDelay(self.newAnimEnd, self, 0.5)
end

function Act174GameWareItem:newAnimEnd()
	gohelper.setActive(self.goNewRole, false)
	gohelper.setActive(self.goNewCollection, false)
end

function Act174GameWareItem:clickItem()
	if self.wareHouseView._goEditTeam.activeInHierarchy then
		self:deleteNewSign()

		if self.wareData.isEquip == 0 then
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemInstall, self.wareData.id)
		else
			Activity174Controller.instance:dispatchEvent(Activity174Event.WareItemRemove, self.wareData.id)
		end
	end
end

function Act174GameWareItem:onClickDown()
	if self.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	self:deleteNewSign()

	local viewParam = {}

	viewParam.type = self.wareType
	viewParam.co = self.config
	viewParam.pos = Vector2.New(-300, 0)
	viewParam.showMask = true

	Activity174Controller.instance:openItemTipView(viewParam)
	AudioMgr.instance:trigger(AudioEnum.Act174.play_artificial_ui_carddisappear)
end

function Act174GameWareItem:onLongPress()
	if not self.wareHouseView._goEditTeam.activeInHierarchy then
		return
	end

	self:deleteNewSign()

	local viewParam = {}

	viewParam.type = self.wareType
	viewParam.co = self.config
	viewParam.pos = Vector2.New(-300, 0)
	viewParam.showMask = true

	Activity174Controller.instance:openItemTipView(viewParam)
end

function Act174GameWareItem:deleteNewSign()
	if self.goNew.activeInHierarchy then
		self:setNew(false)
		self.wareHouseView.wareHouseMo:deleteNewSign(self.wareType, self.wareData.id)
	end
end

return Act174GameWareItem
