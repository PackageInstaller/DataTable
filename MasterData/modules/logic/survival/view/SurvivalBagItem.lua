-- chunkname: @modules/logic/survival/view/SurvivalBagItem.lua

module("modules.logic.survival.view.SurvivalBagItem", package.seeall)

local SurvivalBagItem = class("SurvivalBagItem", LuaCompBase)

function SurvivalBagItem:init(go)
	self.go = go
	self.goRoot = gohelper.findChild(go, "root")
	self._animGo = gohelper.findComponentAnim(go)
	self._animHas = gohelper.findChildAnim(go, "root/has")
	self._gonormal = gohelper.findChild(go, "root/has")
	self._goempty = gohelper.findChild(go, "root/empty")
	self._unknown = gohelper.findChild(go, "root/unknown")
	self._btnClick = gohelper.findChildButtonWithAudio(go, "root/btn_Click")
	self._txtnum = gohelper.findChildTextMesh(go, "root/has/collection/#txt_num")
	self._goqulity5 = gohelper.findChild(go, "root/has/collection/#go_qulity")
	self._goselect = gohelper.findChild(go, "root/has/go_select")
	self._goitem = gohelper.findChild(self._gonormal, "collection")
	self._imagerare = gohelper.findChildImage(self._goitem, "image_Rare")
	self._effect6 = gohelper.findChild(self._goitem, "#go_deceffect")
	self._simageitemicon = gohelper.findChildSingleImage(self._goitem, "simage_Icon")
	self._gotagitem = gohelper.findChild(self._goitem, "go_tag/go_item")
	self._gonpc = gohelper.findChild(self._gonormal, "npc")
	self._gotalent = gohelper.findChild(self._gonormal, "Talent")
	self._gosurvivalequiptag = gohelper.findChild(self._gonormal, "go_tag")
	self._simagenpcicon = gohelper.findChildSingleImage(self._gonpc, "simage_Icon")
	self._goadd = gohelper.findChild(self.goRoot, "add")
	self._goput = gohelper.findChild(self.goRoot, "put")
	self._goloading = gohelper.findChild(go, "root/loading")
	self._gosearching = gohelper.findChild(go, "root/searching")
	self._gocompose = gohelper.findChild(self.goRoot, "compose")
	self._goCollectionSelectTips = gohelper.findChild(self._gonormal, "collection/#go_collection_select_Tips")
	self._textName = gohelper.findChildTextMesh(self.goRoot, "has/#textName")
	self._go_rewardinherit = gohelper.findChild(self.goRoot, "#go_rewardinherit")
	self._go_rewardinherit_txt_name = gohelper.findChildTextMesh(self._go_rewardinherit, "#txt_name")
	self._go_rewardinherit_go_Selected = gohelper.findChild(self._go_rewardinherit, "#go_Selected")

	gohelper.setActive(self._go_rewardinherit, false)
	gohelper.setActive(self._gotalent, false)
	gohelper.setActive(self._goCollectionSelectTips, false)

	self.defaultWidth = 172
	self.defaultHeight = 172
	self._goReputationShop = gohelper.findChild(self.goRoot, "reputationShop")
	self._go_canget = gohelper.findChild(self._goReputationShop, "#go_canget")
	self._go_receive = gohelper.findChild(self._goReputationShop, "#go_receive")
	self._go_hasget = gohelper.findChildAnim(self._goReputationShop, "#go_receive/go_hasget")
	self._go_price = gohelper.findChild(self._goReputationShop, "#go_price")
	self._text_price = gohelper.findChildTextMesh(self._goReputationShop, "#go_price/#txt_price")
	self._go_freeReward = gohelper.findChild(self._goReputationShop, "#go_freeReward")
	self.go_shop_price = gohelper.findChild(self.goRoot, "#go_shop_price")
	self.txt_price_shop = gohelper.findChildTextMesh(self.go_shop_price, "#txt_price")
	self.imagePrice = gohelper.findChildImage(self.go_shop_price, "#txt_price/#imagePrice")
	self.itemSubType_npc = gohelper.findChild(self._gonormal, "collection/itemSubType_npc")
	self.recommend = gohelper.findChild(self._gonormal, "recommend")
	self.go_score = gohelper.findChild(self.goRoot, "#go_score")
	self.txt_score = gohelper.findChildTextMesh(self.go_score, "#txt_score")
end

function SurvivalBagItem:onDestroy()
	TaskDispatcher.cancelTask(self._onSublimationAnimEnd, self)
end

function SurvivalBagItem:getItemAnimators()
	return {
		self._animGo
	}
end

function SurvivalBagItem:addEventListeners()
	self._btnClick:AddClickListener(self._onItemClick, self)
end

function SurvivalBagItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function SurvivalBagItem:updateByItemId(itemId, itemNum)
	local mo = SurvivalBagItemMo.New()

	mo:init({
		id = itemId,
		count = itemNum
	})
	self:updateMo(mo)
end

function SurvivalBagItem:updateMo(mo, param)
	param = param or {}

	local isAdd = false
	local jumpAdd = param.jumpAdd

	if not jumpAdd and self._preUid and mo.uid == self._preUid and mo.count > self._preCount then
		isAdd = true
	end

	self._mo = mo
	self._preUid = mo.uid
	self._preCount = mo.count

	local isEmpty = mo:isEmpty() and not param.forceShowIcon
	local isUnknown = mo.isUnknown
	local isHas = not isEmpty and not isUnknown

	gohelper.setActive(self._gonormal, isHas)

	if isHas and param.jumpAnimHas and not param.jumpOpenAnim then
		self._animHas:Play("open", 0, 1)
	end

	if not param.jumpAnimHas and not isEmpty and not isUnknown then
		if mo.co.rare == 5 then
			self._animHas:Play("opensp", 0, 1)
		elseif mo.co.rare == 6 then
			self._animHas:Play("opensp1", 0, 1)
		else
			self._animHas:Play("open", 0, 1)
		end
	end

	gohelper.setActive(self._gocompose, false)
	gohelper.setActive(self._gosearching, false)
	gohelper.setActive(self._goput, false)
	gohelper.setActive(self._goempty, isEmpty)
	gohelper.setActive(self._unknown, isUnknown)
	gohelper.setActive(self._goadd, false)
	gohelper.setActive(self._gosurvivalequiptag, false)
	gohelper.setActive(self._goadd, isAdd)

	if not isEmpty and not isUnknown then
		local isNpc = mo.co.type == SurvivalEnum.ItemType.NPC
		local equipCo = mo.equipCo

		gohelper.setActive(self._gonpc, isNpc)
		gohelper.setActive(self._gosurvivalequiptag, equipCo and mo.bagReason == 1)
		gohelper.setActive(self._goitem, not isNpc)
		gohelper.setActive(self._goqulity5, not isNpc and mo.co.rare == 5)
		gohelper.setActive(self._effect6, not isNpc and mo.co.rare == 6)

		self._txtnum.text = self._mo.count

		local equipTags = {}

		if not isNpc then
			UISpriteSetMgr.instance:setSurvivalSprite(self._imagerare, "survival_bag_itemquality" .. self._mo.co.rare)
			self._simageitemicon:LoadImage(ResUrl.getSurvivalItemIcon(self._mo.co.icon))
		else
			self._simagenpcicon:LoadImage(ResUrl.getSurvivalNpcIcon(self._mo.co.icon))
		end

		if equipCo then
			if equipCo.equipType == 0 then
				local tagIds = string.splitToNumber(equipCo.tag, "#") or {}

				for _, v in ipairs(tagIds) do
					local tagCo = lua_survival_equip_found.configDict[v]

					if tagCo then
						table.insert(equipTags, tagCo.icon4)
					end
				end
			else
				equipTags = {
					"100"
				}
			end
		end

		gohelper.CreateObjList(self, self._createTagItem, equipTags, nil, self._gotagitem)
	end

	self:setIsSelect(false)
	self:setItemSubType_npc(mo:isNPCRecommendItem())
end

function SurvivalBagItem:_createTagItem(obj, data, index)
	local image = gohelper.findChildImage(obj, "#image_tag")

	UISpriteSetMgr.instance:setSurvivalSprite(image, data)
end

function SurvivalBagItem:setShowNum(isShow)
	gohelper.setActive(self._txtnum, isShow)
end

function SurvivalBagItem:setClickCallback(callback, callobj)
	self._callback = callback
	self._callobj = callobj
end

function SurvivalBagItem:setIsSelect(isSelect)
	if isSelect == nil then
		isSelect = false
	end

	gohelper.setActive(self._goselect, isSelect)
end

function SurvivalBagItem:setCanClickEmpty(isCanClick)
	self._canClickEmpty = isCanClick
end

function SurvivalBagItem:_onItemClick()
	if self._mo:isEmpty() and not self._canClickEmpty then
		return
	end

	if self._callback then
		self._callback(self._callobj, self)

		return
	end
end

function SurvivalBagItem:showLoading(isShow)
	gohelper.setActive(self._goloading, isShow)

	if isShow then
		gohelper.setActive(self._goempty, false)
		gohelper.setActive(self._gonormal, false)
	else
		self:updateMo(self._mo)

		if self._mo and self._mo.co and self._mo.co.rare == 5 then
			self._animHas:Play("opensp", 0, 0)
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_sougua_4)
		elseif self._mo and self._mo.co and self._mo.co.rare == 6 then
			self._animHas:Play("opensp1", 0, 0)
			AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_senior)
		else
			self._animHas:Play("open", 0, 0)
		end
	end
end

function SurvivalBagItem:playSearch()
	gohelper.setActive(self._gosearching, false)
	gohelper.setActive(self._gosearching, true)
end

function SurvivalBagItem:playCompose()
	gohelper.setActive(self._gocompose, false)
	gohelper.setActive(self._gocompose, true)
end

function SurvivalBagItem:playPut()
	gohelper.setActive(self._goput, false)
	gohelper.setActive(self._goput, true)
end

function SurvivalBagItem:playSublimationAnim2(t, nextMo)
	AudioMgr.instance:trigger(AudioEnum3_4.Survival.play_ui_bulaochun_tansuo_up)

	self.sublimationAnimnNextMo = nextMo

	self._animHas:Play("up" .. t, 0, 0)
	TaskDispatcher.runDelay(self._onSublimationAnimEnd, self, 0.8)
end

function SurvivalBagItem:_onSublimationAnimEnd()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_sougua_4)
	self:updateMo(self.sublimationAnimnNextMo, {
		jumpAnimHas = true,
		jumpOpenAnim = true
	})

	self.sublimationAnimnNextMo = nil
end

function SurvivalBagItem:playComposeAnim()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_qiutu_teleport)
	self._animHas:Play("compose", 0, 0)
end

function SurvivalBagItem:playGainReputationFreeReward()
	self._go_hasget:Play("go_hasget_in")
end

function SurvivalBagItem:setItemSize(width, height)
	local scaleX = width / self.defaultWidth
	local scaleY = height / self.defaultHeight

	recthelper.setSize(self.go.transform, width, height)
	transformhelper.setLocalScale(self.goRoot.transform, scaleX, scaleY, 1)
end

function SurvivalBagItem:playCloseAnim()
	self._animHas:Play("close", 0, 0)
end

function SurvivalBagItem:setTextName(isShow, textName)
	gohelper.setActive(self._textName, isShow)

	if isShow then
		self._textName.text = textName
	end
end

function SurvivalBagItem:setExtraParam(param)
	self.extraParam = param
end

function SurvivalBagItem:showRewardInherit(textName, isSelect)
	gohelper.setActive(self._go_rewardinherit, true)

	self._go_rewardinherit_txt_name.text = textName

	gohelper.setActive(self._go_rewardinherit_go_Selected, isSelect)
end

function SurvivalBagItem:setReputationShopStyle(param)
	gohelper.setActive(self._goReputationShop, true)
	gohelper.setActive(self._go_canget, param.isCanGet)
	gohelper.setActive(self._go_receive, param.isReceive)
	gohelper.setActive(self._go_price, param.price)

	if param.price then
		self._text_price.text = param.price
	end

	gohelper.setActive(self._go_freeReward, param.isShowFreeReward)
end

function SurvivalBagItem:setShopStyle(param)
	self.shopStyleParam = param

	gohelper.setActive(self.go_shop_price, param.isShow)

	if param.isShow then
		local currencyNum = param.currencyNum

		self.txt_price_shop.text = currencyNum < param.price and string.format("<#BF2E11>%s</color>", param.price) or string.format("<#CAC8C5>%s</color>", param.price)
	end
end

function SurvivalBagItem:setItemSubType_npc(value)
	gohelper.setActive(self.itemSubType_npc, value)
end

function SurvivalBagItem:setRecommend(value)
	gohelper.setActive(self.recommend, value)
end

function SurvivalBagItem:showInheritScore()
	gohelper.setActive(self.go_score, true)

	self.txt_score.text = self._mo:getExtendCost()
end

return SurvivalBagItem
