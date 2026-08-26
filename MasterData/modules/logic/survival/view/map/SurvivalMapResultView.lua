-- chunkname: @modules/logic/survival/view/map/SurvivalMapResultView.lua

module("modules.logic.survival.view.map.SurvivalMapResultView", package.seeall)

local SurvivalMapResultView = class("SurvivalMapResultView", BaseView)
local currencys = {
	SurvivalEnum.CurrencyType.Gold
}

function SurvivalMapResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "Left/#go_success")
	self._gofail = gohelper.findChild(self.viewGO, "Left/#go_fail")
	self._gonpcitem = gohelper.findChild(self.viewGO, "Left/team/#go_npcitem")
	self._gonpcline1 = gohelper.findChild(self.viewGO, "Left/team/#go_npc/#go_line1")
	self._gonpcline2 = gohelper.findChild(self.viewGO, "Left/team/#go_npc/#go_line2")
	self._goheroitem = gohelper.findChild(self.viewGO, "Left/team/#go_heroitem")
	self._goheroline1 = gohelper.findChild(self.viewGO, "Left/team/#go_hero/#go_line1")
	self._goheroline2 = gohelper.findChild(self.viewGO, "Left/team/#go_hero/#go_line2")
	self._gofail2 = gohelper.findChild(self.viewGO, "Right/#go_fail")
	self._txtTageLoss = gohelper.findChildTextMesh(self.viewGO, "Right/#go_fail/#txt_benifit")
	self._gorightitem = gohelper.findChild(self.viewGO, "Right/scroll_collection/Viewport/Content/go_bagitem")
	self._gorightnpcitem = gohelper.findChild(self.viewGO, "Right/#go_npc/scroll_npc/Viewport/Content/go_npcitem")
	self._currencyroot = gohelper.findChild(self.viewGO, "Right/topright")
	self._gonpcpart = gohelper.findChild(self.viewGO, "Right/#go_npc")
	self._goitemscroll = gohelper.findChild(self.viewGO, "Right/scroll_collection")
	self._txttag1 = gohelper.findChildTextMesh(self._currencyroot, "tag1/#txt_tag1")
	self._txttag2 = gohelper.findChildTextMesh(self._currencyroot, "tag2/#txt_tag2")
	self._btntag1 = gohelper.findChildButtonWithAudio(self._currencyroot, "tag1")
	self._btntag2 = gohelper.findChildButtonWithAudio(self._currencyroot, "tag2")
	self._anim = gohelper.findChildAnim(self.viewGO, "")
end

function SurvivalMapResultView:addEvents()
	self._btnclose:AddClickListener(self.onClickModalMask, self)
	self._btntag1:AddClickListener(self._openCurrencyTips, self, {
		id = currencys[1],
		btn = self._btntag1
	})
	self._btntag2:AddClickListener(self._openCurrencyTips, self, {
		id = currencys[2],
		btn = self._btntag2
	})
end

function SurvivalMapResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btntag1:RemoveClickListener()
	self._btntag2:RemoveClickListener()
end

function SurvivalMapResultView:onOpen()
	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoRoot = gohelper.create2d(self.viewGO, "#go_info")
	local infoGo = self:getResInst(infoViewRes, infoRoot)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setCloseShow(true)
	self._infoPanel:updateMo()

	self._resultMo = SurvivalMapModel.instance.resultData

	local isWin = self.viewParam.isWin

	gohelper.setActive(self._gosuccess, isWin)
	gohelper.setActive(self._gofail, not isWin)
	gohelper.setActive(self._gofail2, not isWin)
	self:refreshPlaceAndTime((isWin or nil) and (self._gosuccess or self._gofail))
	self:refreshHeroAndNpc()
	self:refreshLoss()
	self:refreshItemsAndNpcs()

	if isWin then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_success_2)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_fail_2)
	end
end

function SurvivalMapResultView:refreshPlaceAndTime(go)
	local txtPlace = gohelper.findChildTextMesh(go, "place/#txt_place")
	local txtTime = gohelper.findChildTextMesh(go, "time/#txt_time")
	local copyCo = lua_survival_map_group.configDict[self._resultMo.copyId]

	txtPlace.text = copyCo.name

	local time = self._resultMo.totalGameTime
	local hour = math.floor(time / 60)
	local min = math.fmod(time, 60)

	txtTime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_resultview_time"), hour, min)
end

function SurvivalMapResultView:refreshHeroAndNpc()
	local teamInfoMo = self._resultMo.teamInfo
	local heroLine1Data = {}
	local heroLine2Data = {}
	local npcLine1Data = {}

	for i = 1, 10 do
		local heroMo = teamInfoMo:getHeroMo(teamInfoMo.heros[i]) or true

		table.insert(i <= 5 and heroLine1Data or heroLine2Data, heroMo)
	end

	for i = 1, 4 do
		if not teamInfoMo.npcId[i] then
			local npcId = 0

			table.insert(npcLine1Data, npcId)
		end
	end

	gohelper.CreateObjList(self, self._createHeroItem, heroLine1Data, self._goheroline1, self._goheroitem)
	gohelper.CreateObjList(self, self._createHeroItem, heroLine2Data, self._goheroline2, self._goheroitem)
	gohelper.CreateObjList(self, self._createNpcItem, npcLine1Data, self._gonpcline1, self._gonpcitem)
end

function SurvivalMapResultView:_createHeroItem(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "#image_rolehead")
	local empty = gohelper.findChild(obj, "empty")

	gohelper.setActive(image, data ~= true)
	gohelper.setActive(empty, data == true)

	if data ~= true then
		local skinCO = FightConfig.instance:getSkinCO(data.skin)

		image:LoadImage(ResUrl.getHeadIconSmall(skinCO.headIcon))
	end
end

function SurvivalMapResultView:_createNpcItem(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "#image_rolehead")
	local empty = gohelper.findChild(obj, "empty")

	gohelper.setActive(image, data ~= 0)
	gohelper.setActive(empty, data == 0)

	if data ~= 0 then
		local itemCo = SurvivalConfig.instance.npcIdToItemCo[data]

		if itemCo then
			image:LoadImage(ResUrl.getSurvivalNpcIcon(itemCo.icon))
		end
	end
end

function SurvivalMapResultView:refreshLoss()
	self._txtTageLoss.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_resultview_loss"), self._resultMo.percentageLoss)
end

function SurvivalMapResultView:refreshItemsAndNpcs()
	local haveNpc = #self._resultMo.firstNpcs > 0

	gohelper.setActive(self._gonpcpart, haveNpc)
	recthelper.setHeight(self._goitemscroll.transform, haveNpc and 513.14 or 800)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goitemscroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self._createItem, self, nil, self._gorightitem)
	self._simpleList:setRecycleCallBack(self._recycleItem, self)

	self._allItemComps = {}

	self:refreshCurrency(false)
	self._simpleList:setList(self._resultMo.firstItems)
	gohelper.CreateObjList(self, self._createRightNpcItem, self._resultMo.firstNpcs, nil, self._gorightnpcitem)
	TaskDispatcher.runDelay(self._delayCheckChange, self, 1)
end

function SurvivalMapResultView:_delayCheckChange()
	if self._resultMo.haveChange1 then
		UIBlockHelper.instance:startBlock("SurvivalMapResultView_ItemEffect", 1)
		TaskDispatcher.runDelay(self._delayShowChangeItem, self, 1)

		for k, v in pairs(self._allItemComps) do
			local itemMo = v._mo

			if not itemMo:isEmpty() then
				local changToItemMo = self._resultMo.beforeChanges[itemMo.uid]

				if changToItemMo and changToItemMo:isEmpty() then
					v:playComposeAnim()
				end
			end
		end
	else
		self:showAfterItems()
	end
end

function SurvivalMapResultView:_delayShowChangeItem()
	tabletool.clear(self._allItemComps)
	self._simpleList:setList(self._resultMo.beforeItems)
	gohelper.CreateObjList(self, self._createRightNpcItem, self._resultMo.beforeNpcs, nil, self._gorightnpcitem)
	self:showAfterItems()
end

function SurvivalMapResultView:showAfterItems()
	if self._resultMo.haveChange2 then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_3)
		UIBlockHelper.instance:startBlock("SurvivalMapResultView_ItemEffect", 1)
		TaskDispatcher.runDelay(self._delayShowAfterItem, self, 1)
		self._anim:Play("searching", 0, 0)

		for k, v in pairs(self._allItemComps) do
			local itemMo = v._mo

			if not itemMo:isEmpty() then
				local changToItemMo = self._resultMo.afterChanges[itemMo.uid]

				if changToItemMo then
					if changToItemMo:isEmpty() then
						v:playSearch()
						v:playCompose()
					else
						v:playSearch()
					end
				end
			end
		end
	else
		self:_onFinishShow()
	end
end

function SurvivalMapResultView:_delayShowAfterItem()
	self:refreshCurrency(true)
	tabletool.clear(self._allItemComps)
	self._simpleList:setList(self._resultMo.afterItems)
	gohelper.CreateObjList(self, self._createRightNpcItem, self._resultMo.afterNpcs, nil, self._gorightnpcitem)
	self:_onFinishShow()
end

function SurvivalMapResultView:_onFinishShow()
	return
end

function SurvivalMapResultView:_createItem(obj, data, index)
	if not self.viewContainer._abLoader then
		return
	end

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes
	local go = gohelper.findChild(obj, "inst")

	go = go or self:getResInst(itemRes, obj, "inst")

	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalBagItem)

	item:updateMo(data)
	item:setClickCallback(self._onClickItem, self)

	self._allItemComps[index] = item
end

function SurvivalMapResultView:_recycleItem(go, oldIndex, newIndex)
	self._allItemComps[oldIndex] = nil
end

function SurvivalMapResultView:_onClickItem(item)
	self._infoPanel:updateMo(item._mo)
end

function SurvivalMapResultView:_createRightNpcItem(obj, data, index)
	local image = gohelper.findChildSingleImage(obj, "#simage_chess")
	local btn = gohelper.findChildButtonWithAudio(obj, "")

	SurvivalUnitIconHelper.instance:setNpcIcon(image, data.npcCo.headIcon)
	self:removeClickCb(btn)
	self.addClickCb(self, btn, self._onClickNpc, self, data)
end

function SurvivalMapResultView:_onClickNpc(data)
	self._infoPanel:updateMo(data)
end

function SurvivalMapResultView:refreshCurrency(isAfter)
	if isAfter then
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, self.setCurrItem, nil, self)
	else
		self:setCurrItem(0)
	end
end

function SurvivalMapResultView:setCurrItem(value)
	local preVal = self._resultMo.beforeCurrencyItems
	local afterVal = self._resultMo.afterCurrencyItems

	for i = 1, #currencys do
		local preCount = (preVal[currencys[i]] or 0) + self._resultMo.afterItemWorth
		local afterCount = (afterVal[currencys[i]] or 0) + self._resultMo.afterItemWorth
		local txt = self["_txttag" .. i]

		txt.text = math.floor(preCount + (afterCount - preCount) * value)
	end
end

function SurvivalMapResultView:onClickModalMask()
	self:closeThis()
end

function SurvivalMapResultView:onClose()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	TaskDispatcher.cancelTask(self._delayShowChangeItem, self)
	TaskDispatcher.cancelTask(self._delayShowAfterItem, self)
	TaskDispatcher.cancelTask(self._delayCheckChange, self)
end

function SurvivalMapResultView:_openCurrencyTips(param)
	local trans = param.btn.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x + width / 2 * scale.x
	pos.y = pos.y - height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		id = param.id,
		pos = pos
	})
end

return SurvivalMapResultView
