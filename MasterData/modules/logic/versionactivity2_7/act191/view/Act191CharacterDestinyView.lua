-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191CharacterDestinyView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191CharacterDestinyView", package.seeall)

local Act191CharacterDestinyView = class("Act191CharacterDestinyView", BaseView)

function Act191CharacterDestinyView:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/#image_icon")
	self._txtstonename = gohelper.findChildText(self.viewGO, "root/#txt_stonename")
	self._goEffectItem = gohelper.findChild(self.viewGO, "root/EffectItems/#go_EffectItem")
	self._simagestone = gohelper.findChildSingleImage(self.viewGO, "root/go_stone/#simage_stone")
	self._goprestone = gohelper.findChild(self.viewGO, "root/#go_prestone")
	self._btnprestone = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_prestone/#btn_prestone")
	self._gonextstone = gohelper.findChild(self.viewGO, "root/#go_nextstone")
	self._btnnextstone = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_nextstone/#btn_nextstone")
	self._goselect = gohelper.findChild(self.viewGO, "root/btn/#go_select")
	self._btnselect = gohelper.findChildButtonWithAudio(self.viewGO, "root/btn/#go_select/#btn_select")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191CharacterDestinyView:addEvents()
	self._btnprestone:AddClickListener(self._btnprestoneOnClick, self)
	self._btnnextstone:AddClickListener(self._btnnextstoneOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
end

function Act191CharacterDestinyView:removeEvents()
	self._btnprestone:RemoveClickListener()
	self._btnnextstone:RemoveClickListener()
	self._btnselect:RemoveClickListener()
end

function Act191CharacterDestinyView:_btnprestoneOnClick()
	if self.selectIndex > 1 then
		self.selectIndex = self.selectIndex - 1

		self:refreshUI()
	end
end

function Act191CharacterDestinyView:_btnnextstoneOnClick()
	if self.selectIndex < #self.stoneIds then
		self.selectIndex = self.selectIndex + 1

		self:refreshUI()
	end
end

function Act191CharacterDestinyView:_btnselectOnClick()
	Activity191Rpc.instance:sendSelect191UseHeroFacetsIdRequest(self.actId, self.config.roleId, self.stoneId, self.onSwitchStone, self)
end

function Act191CharacterDestinyView:_editableInitView()
	self.actId = Activity191Model.instance:getCurActId()

	self:buildEffectItem()
end

function Act191CharacterDestinyView:onOpen()
	self.config = self.viewParam
	self.stoneIds = string.splitToNumber(self.config.facetsId, "#")
	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()
	self.equippingStoneId = self.gameInfo:getStoneId(self.config)
	self.selectIndex = tabletool.indexOf(self.stoneIds, self.equippingStoneId)

	self:refreshUI()
end

function Act191CharacterDestinyView:refreshUI()
	self.stoneId = self.stoneIds[self.selectIndex]

	gohelper.setActive(self._goprestone, self.selectIndex > 1)
	gohelper.setActive(self._gonextstone, self.selectIndex < #self.stoneIds)
	gohelper.setActive(self._goselect, self.stoneId ~= self.equippingStoneId)

	self._levelCos = CharacterDestinyConfig.instance:getDestinyFacetCo(self.stoneId)
	self.conusmeCo = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(self.stoneId)

	self:_refreshStoneItem()
end

function Act191CharacterDestinyView:_refreshStoneItem()
	for i, item in ipairs(self._effectItems) do
		local co = self._levelCos[i]

		if co then
			local descComp = item.descComp

			descComp:updateInfo(item.txt, co.desc, self.config)
		end

		gohelper.setActive(item.go, co)
	end

	self._txtstonename.text = self.conusmeCo.name

	local iconPath = ResUrl.getDestinyIcon(self.conusmeCo.icon)

	self._simagestone:LoadImage(iconPath)

	local tenp = CharacterDestinyEnum.SlotTend[self.conusmeCo.tend]
	local tendIcon = tenp.TitleIconName

	UISpriteSetMgr.instance:setUiCharacterSprite(self._imageicon, tendIcon)

	self._txtstonename.color = GameUtil.parseColor(tenp.TitleColor)
end

function Act191CharacterDestinyView:onSwitchStone()
	self.equippingStoneId = self.gameInfo:getStoneId(self.config)

	self:refreshUI()
end

function Act191CharacterDestinyView:buildEffectItem()
	self._goeffect = gohelper.findChild(self.viewGO, "root/EffectItems")
	self._effectItems = self:getUserDataTb_()

	for i = 1, CharacterDestinyEnum.EffectItemCount do
		local item = self:getUserDataTb_()
		local go = gohelper.findChild(self._goeffect, i)

		item.go = go
		item.root = gohelper.clone(self._goEffectItem, go)
		item.txt = gohelper.findChildText(item.root, "Viewport/Content/go_DescItem/txt_desc")
		item.descComp = MonoHelper.addNoUpdateLuaComOnceToGo(item.txt.gameObject, Act191SkillDescComp)

		item.descComp:setTipParam(0, Vector2(300, 100))

		self._effectItems[i] = item
	end

	gohelper.setActive(self._goEffectItem, false)
end

return Act191CharacterDestinyView
