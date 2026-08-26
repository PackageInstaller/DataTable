-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotRewardItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRewardItem", package.seeall)

local V1a6_CachotRewardItem = class("V1a6_CachotRewardItem", LuaCompBase)

function V1a6_CachotRewardItem:init(go)
	self._txtnum = gohelper.findChildTextMesh(go, "#txt_num")
	self._txtname = gohelper.findChildTextMesh(go, "#txt_name")
	self._txtdesc = gohelper.findChildTextMesh(go, "scroll_dec/Viewport/Content/#txt_dec")
	self._scrollreward = gohelper.findChild(go, "scroll_dec"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._imagebg = gohelper.findChildImage(go, "#simage_bg")
	self._simagecollection = gohelper.findChildSingleImage(go, "#simage_collection")
	self._imageicon = gohelper.findChildImage(go, "#simage_icon")
	self._btnComfirm = gohelper.findChildButtonWithAudio(go, "#btn_comfirm")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))

	self._anim:Play("open", 0, 0)

	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtdesc.gameObject, FixTmpBreakLine)
	self._goenchantlist = gohelper.findChild(go, "#go_enchantlist")
	self._gohole = gohelper.findChild(go, "#go_enchantlist/#go_hole")
end

function V1a6_CachotRewardItem:addEventListeners()
	self._btnComfirm:AddClickListener(self._getReward, self)
end

function V1a6_CachotRewardItem:removeEventListeners()
	self._btnComfirm:RemoveClickListener()
end

function V1a6_CachotRewardItem:_getReward()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_award_charge)
	self._anim:Play("close", 0, 0)
	UIBlockMgr.instance:startBlock("V1a6_CachotRewardItem_Get")
	TaskDispatcher.runDelay(self._delaySendReq, self, 0.367)
end

function V1a6_CachotRewardItem:_delaySendReq()
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")

	local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not topEventMo then
		return
	end

	if self._collections then
		if #self._collections == 1 then
			RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, topEventMo.eventId, self._mo.idx, 1)
		else
			local viewParam = {}

			viewParam.selectCallback = self.onCollectionSelect
			viewParam.selectCallbackObj = self
			viewParam.collectionList = self._collections

			V1a6_CachotController.instance:openV1a6_CachotCollectionSelectView(viewParam)
		end
	else
		RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, topEventMo.eventId, self._mo.idx)
	end
end

function V1a6_CachotRewardItem:onCollectionSelect(index)
	local topEventMo = V1a6_CachotRoomModel.instance:getNowTopEventMo()

	if not topEventMo or not self._mo then
		return
	end

	RogueRpc.instance:sendRogueEventFightRewardRequest(V1a6_CachotEnum.ActivityId, topEventMo.eventId, self._mo.idx, index)
end

function V1a6_CachotRewardItem:updateMo(mo, parentScroll)
	self._scrollreward.parentGameObject = parentScroll

	if self._mo then
		self._anim:Play("idle", 0, 0)
	end

	self._mo = mo

	local isShowValue = false

	self._collections = nil
	self._imageicon.enabled = false

	self._simagecollection:UnLoadImage()
	gohelper.setActive(self._simagecollection, false)
	gohelper.setActive(self._goenchantlist, false)

	local isSImage = false
	local descCo, desc

	if mo.type == "COIN" then
		if mo.valuePercent and mo.valuePercent > 0 then
			mo.value = math.floor(V1a6_CachotModel.instance:getRogueInfo().coin * mo.valuePercent / 1000)
		end

		descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Coin]
		isShowValue = true

		gohelper.setActive(self._simagecollection, true)
		self._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(descCo.icon))

		isSImage = true
	elseif mo.type == "CURRENCY" then
		descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Currency][V1a6_CachotEnum.DropCurrencyType.Currency]
		isShowValue = true

		gohelper.setActive(self._simagecollection, true)
		self._simagecollection:LoadImage(ResUrl.getCurrencyItemIcon(descCo.icon))

		isSImage = true
	elseif mo.type == "COLLECTION" then
		local list = mo.colletionList

		self._collections = list

		if #list == 1 then
			local collectionCo = lua_rogue_collection.configDict[list[1]]

			if collectionCo then
				gohelper.setActive(self._simagecollection, true)
				gohelper.setActive(self._goenchantlist, true)
				self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCo.icon))

				self._txtname.text = collectionCo.name
				self._txtdesc.text = V1a6_CachotCollectionConfig.instance:getCollectionSkillsContent(collectionCo)

				self._fixTmpBreakLine:refreshTmpContent(self._txtdesc)

				self._txtnum.text = ""

				V1a6_CachotCollectionHelper.createCollectionHoles(collectionCo, self._goenchantlist, self._gohole)
			end

			local descCo2 = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.Collection][1]

			UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagebg, descCo2.iconbg)
		else
			descCo = lua_rogue_event_drop_desc.configDict[V1a6_CachotEnum.DropType.SelectCollection][1]
		end
	elseif mo.type == "EVENT" then
		descCo, desc = V1a6_CachotEventConfig.instance:getDescCoByEventId(mo.value)
	end

	if descCo then
		self._txtname.text = descCo.title
		self._txtdesc.text = HeroSkillModel.instance:skillDesToSpot(desc or descCo.desc)

		self._fixTmpBreakLine:refreshTmpContent(self._txtdesc)

		self._txtnum.text = isShowValue and luaLang("multiple") .. mo.value or ""

		UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagebg, descCo.iconbg)

		if isSImage then
			-- block empty
		else
			self._imageicon.enabled = true

			UISpriteSetMgr.instance:setV1a6CachotSprite(self._imageicon, descCo.icon)
		end
	end
end

function V1a6_CachotRewardItem:onDestroy()
	if self._simagecollection then
		self._simagecollection:UnLoadImage()
	end

	TaskDispatcher.cancelTask(self._delaySendReq, self)
	UIBlockMgr.instance:endBlock("V1a6_CachotRewardItem_Get")
end

return V1a6_CachotRewardItem
