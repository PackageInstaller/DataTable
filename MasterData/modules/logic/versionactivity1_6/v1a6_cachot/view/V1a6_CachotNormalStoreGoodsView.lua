-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotNormalStoreGoodsView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotNormalStoreGoodsView", package.seeall)

local V1a6_CachotNormalStoreGoodsView = class("V1a6_CachotNormalStoreGoodsView", BaseView)

function V1a6_CachotNormalStoreGoodsView:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/propinfo/#simage_icon")
	self._imageiconbg = gohelper.findChildImage(self.viewGO, "root/propinfo/#image_iconbg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "root/propinfo/#image_icon")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "root/propinfo/scroll_info/Viewport/Content/#txt_goodsUseDesc")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "root/propinfo/#txt_goodsNameCn")
	self._txtorginalcost = gohelper.findChildTextMesh(self.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._goenchantlist = gohelper.findChild(self.viewGO, "root/propinfo/#go_enchantlist")
	self._gohole = gohelper.findChild(self.viewGO, "root/propinfo/#go_enchantlist/#go_hole")
end

function V1a6_CachotNormalStoreGoodsView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnBuy:AddClickListener(self.onBuyClick, self)
end

function V1a6_CachotNormalStoreGoodsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

local percentColorParam = "#6F3C0F"
local bracketColorParam = "#2B4E6C"

function V1a6_CachotNormalStoreGoodsView:onOpen()
	local co = self.viewParam
	local coinNum = V1a6_CachotModel.instance:getRogueInfo().coin

	self._enoughCoin = coinNum >= co.price
	self._txtorginalcost.text = coinNum < co.price and string.format("<color=#BF2E11>%s</color>", co.price) or co.price

	gohelper.setActive(self._simageicon, false)
	gohelper.setActive(self._goenchantlist, false)

	self._imageicon.enabled = false

	if co.creator ~= 0 then
		gohelper.setActive(self._simageicon, true)
		gohelper.setActive(self._goenchantlist, true)

		local creatorCo = lua_rogue_collection.configDict[co.creator]

		self._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(creatorCo, nil, percentColorParam, bracketColorParam)
		self._txtname.text = creatorCo.name

		self._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. creatorCo.icon))

		local descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1]

		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageiconbg, descCo.iconbg)
		V1a6_CachotCollectionHelper.createCollectionHoles(creatorCo, self._goenchantlist, self._gohole)
	elseif co.event ~= 0 then
		self._imageicon.enabled = true

		local descCo, desc = V1a6_CachotEventConfig.instance:getDescCoByEventId(co.event)

		if descCo then
			self._txtname.text = descCo.title
			self._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(desc or descCo.desc, percentColorParam, bracketColorParam)

			UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageicon, descCo.icon)
			UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageiconbg, descCo.iconbg)
		else
			logError("未处理事件 " .. co.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. co.id)
	end
end

function V1a6_CachotNormalStoreGoodsView:onBuyClick()
	if not self._enoughCoin then
		GameFacade.showToast(ToastEnum.V1a6CachotToast09)

		return
	end

	RogueRpc.instance:sendBuyRogueGoodsRequest(V1a6_CachotEnum.ActivityId, self.viewParam.id, 1, self.closeThis, self)
end

function V1a6_CachotNormalStoreGoodsView:onClickModalMask()
	self:closeThis()
end

function V1a6_CachotNormalStoreGoodsView:onDestroyView()
	self._simageicon:UnLoadImage()
end

return V1a6_CachotNormalStoreGoodsView
