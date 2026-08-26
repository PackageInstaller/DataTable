-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174RotationView.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationView", package.seeall)

local Act174RotationView = class("Act174RotationView", BaseView)

function Act174RotationView:onInitView()
	self._goroleitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/role/#go_roleitem")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/collection/#go_collectionitem")
	self._gobuffitem = gohelper.findChild(self.viewGO, "right/scroll_rule/Viewport/go_content/buff/#go_buffitem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act174RotationView:addEvents()
	return
end

function Act174RotationView:removeEvents()
	return
end

function Act174RotationView:onClickModalMask()
	self:closeThis()
end

function Act174RotationView:_editableInitView()
	local goAnim = gohelper.findChild(self.viewGO, "right")

	self.anim = goAnim:GetComponent(gohelper.Type_Animator)
	self._txtRule2 = gohelper.findChildText(self.viewGO, "right/simage_rightbg/txt_rule2")
end

function Act174RotationView:onUpdateParam()
	return
end

function Act174RotationView:onOpen()
	self.actId = Activity174Model.instance:getCurActId()
	self.actInfo = Activity174Model.instance:getActInfo()

	self:refreshSeason()
	self:initCharacterItem()
	self:initCollectionItem()
	self:initBuffItem()
end

function Act174RotationView:refreshSeason()
	local seasonConfigDic = {}

	for _, co in ipairs(lua_activity174_season.configList) do
		if co.activityId == self.actId then
			seasonConfigDic[co.season] = co
		end
	end

	local season = self.actInfo.season
	local seasonCo = seasonConfigDic[season + 1]

	if seasonCo and not string.nilorempty(seasonCo.openTime) then
		local leftSec = TimeUtil.stringToTimestamp(seasonCo.openTime) + ServerTime.clientToServerOffset()

		leftSec = leftSec - ServerTime.now()

		local remainDay = TimeUtil.secondsToDDHHMMSS(leftSec)
		local txt = luaLang("act174_rotation_rule2")

		self._txtRule2.text = GameUtil.getSubPlaceholderLuaLangOneParam(txt, GameUtil.getNum2Chinese(remainDay))
	end

	gohelper.setActive(self._txtRule2, seasonConfigDic[season + 1])
end

function Act174RotationView:onClose()
	self:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
end

function Act174RotationView:onDestroyView()
	for _, item in ipairs(self.characterItemList) do
		item.heroIcon:UnLoadImage()
	end

	for _, item in ipairs(self.collectionItemList) do
		item.collectionIcon:UnLoadImage()
	end

	for _, item in ipairs(self.buffItemList) do
		item.buffIcon:UnLoadImage()
	end
end

function Act174RotationView:initCharacterItem()
	self.characterItemList = {}

	local heroCoList = self.actInfo:getRuleHeroCoList()

	table.sort(heroCoList, Activity174Helper.sortActivity174RoleCo)

	for index, heroCo in ipairs(heroCoList) do
		local item = self:getUserDataTb_()

		item.config = heroCo

		local go = gohelper.cloneInPlace(self._goroleitem)
		local btnClick = gohelper.findButtonWithAudio(go)

		self.addClickCb(self, btnClick, self.clickCharacterItem, self, index)

		local imageRare = gohelper.findChildImage(go, "rare")

		item.heroIcon = gohelper.findChildSingleImage(go, "heroicon")
		item.goSelect = gohelper.findChild(go, "go_select")

		item.heroIcon:LoadImage(ResUrl.getHeadIconSmall(heroCo.skinId))
		UISpriteSetMgr.instance:setCommonSprite(imageRare, "bgequip" .. tostring(CharacterEnum.Color[heroCo.rare]))

		self.characterItemList[index] = item
	end

	gohelper.setActive(self._goroleitem, false)
end

function Act174RotationView:clickCharacterItem(index)
	local item = self.characterItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Character
		viewParam.co = item.config
		viewParam.pos = Vector2.New(-470, 0)

		Activity174Controller.instance:openItemTipView(viewParam)
		self:refreshSelect(item)
	end
end

function Act174RotationView:initCollectionItem()
	self.collectionItemList = {}

	local collectionCoList = self.actInfo:getRuleCollectionCoList()

	for index, config in ipairs(collectionCoList) do
		local item = self:getUserDataTb_()

		item.config = config

		local go = gohelper.cloneInPlace(self._gocollectionitem)
		local btnClick = gohelper.findButtonWithAudio(go)

		self.addClickCb(self, btnClick, self.clickCollectionItem, self, index)

		local imageRare = gohelper.findChildImage(go, "rare")

		item.collectionIcon = gohelper.findChildSingleImage(go, "collectionicon")
		item.goSelect = gohelper.findChild(go, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_" .. config.rare)
		item.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(config.icon))

		self.collectionItemList[index] = item
	end

	gohelper.setActive(self._gocollectionitem, false)
end

function Act174RotationView:clickCollectionItem(index)
	local item = self.collectionItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Collection
		viewParam.co = item.config
		viewParam.pos = Vector2.New(-300, 0)

		Activity174Controller.instance:openItemTipView(viewParam)
		self:refreshSelect(item)
	end
end

function Act174RotationView:initBuffItem()
	self.buffItemList = {}

	local buffCoList = self.actInfo:getRuleBuffCoList()

	for index, config in ipairs(buffCoList) do
		local item = self:getUserDataTb_()

		item.config = config

		local go = gohelper.cloneInPlace(self._gobuffitem)
		local btnClick = gohelper.findButtonWithAudio(go)

		self.addClickCb(self, btnClick, self.clickBuffItem, self, index)

		local imageRare = gohelper.findChildImage(go, "rare")

		item.buffIcon = gohelper.findChildSingleImage(go, "bufficon")

		item.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(config.icon))

		item.goSelect = gohelper.findChild(go, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(imageRare, "act174_propitembg_3")

		self.buffItemList[index] = item
	end

	gohelper.setActive(self._gobuffitem, false)
end

function Act174RotationView:clickBuffItem(index)
	local item = self.buffItemList[index]

	if item == self.selectItem then
		self:closeTipView()
		self:refreshSelect()
	else
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Buff
		viewParam.co = item.config
		viewParam.pos = Vector2.New(-300, 0)

		Activity174Controller.instance:openItemTipView(viewParam)
		self:refreshSelect(item)
	end
end

function Act174RotationView:refreshSelect(clickItem)
	if self.selectItem then
		gohelper.setActive(self.selectItem.goSelect, false)
	end

	if clickItem then
		gohelper.setActive(clickItem.goSelect, true)
	end

	self.selectItem = clickItem
end

function Act174RotationView:closeTipView()
	if ViewMgr.instance:isOpen(ViewName.Act174ItemTipView) then
		ViewMgr.instance:closeView(ViewName.Act174ItemTipView, false, true)
	end
end

return Act174RotationView
