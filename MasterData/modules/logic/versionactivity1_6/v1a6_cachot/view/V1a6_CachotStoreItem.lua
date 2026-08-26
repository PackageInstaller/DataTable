-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotStoreItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotStoreItem", package.seeall)

local V1a6_CachotStoreItem = class("V1a6_CachotStoreItem", ListScrollCell)

function V1a6_CachotStoreItem:init(go)
	self._txtname = gohelper.findChildTextMesh(go, "txt_name")
	self._txtcost = gohelper.findChildTextMesh(go, "txt_cost")
	self._gosoldout = gohelper.findChild(go, "go_soldout")
	self._simageicon = gohelper.findChildSingleImage(go, "simage_icon")
	self._imageicon = gohelper.findChildImage(go, "image_icon")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "btn_click")
	self._goenchantlist = gohelper.findChild(go, "go_enchantlist")
	self._gohole = gohelper.findChild(go, "go_enchantlist/go_hole")
end

function V1a6_CachotStoreItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClickItem, self)
end

function V1a6_CachotStoreItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function V1a6_CachotStoreItem:onUpdateMO(mo)
	self._mo = mo

	local co = lua_rogue_goods.configDict[mo.id]

	gohelper.setActive(self._simageicon, false)
	gohelper.setActive(self._goenchantlist, false)

	self._imageicon.enabled = false

	if co.creator ~= 0 then
		gohelper.setActive(self._simageicon, true)

		local creatorCo = lua_rogue_collection.configDict[co.creator]

		if not creatorCo then
			logError("商店出售不存在的藏品" .. co.creator)

			return
		end

		self._txtname.text = creatorCo.name

		self._simageicon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. creatorCo.icon))
		gohelper.setActive(self._goenchantlist, true)
		V1a6_CachotCollectionHelper.createCollectionHoles(creatorCo, self._goenchantlist, self._gohole)
	elseif co.event ~= 0 then
		self._imageicon.enabled = true

		local descCo = V1a6_CachotEventConfig.instance:getDescCoByEventId(co.event)

		if descCo then
			self._txtname.text = descCo.title

			UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageicon, descCo.icon)
		else
			logError("未处理事件 " .. co.event)
		end
	else
		logError("肉鸽商品配置错误 id" .. co.id)
	end

	self._txtcost.text = co.price

	gohelper.setActive(self._gosoldout, mo.buyCount > 0)
end

function V1a6_CachotStoreItem:_onClickItem()
	ViewMgr.instance:openView(ViewName.V1a6_CachotNormalStoreGoodsView, lua_rogue_goods.configDict[self._mo.id])
end

function V1a6_CachotStoreItem:onDestroy()
	if self._simageicon then
		self._simageicon:UnLoadImage()
	end
end

return V1a6_CachotStoreItem
