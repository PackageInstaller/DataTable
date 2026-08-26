-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotUpgradeView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeView", package.seeall)

local V1a6_CachotUpgradeView = class("V1a6_CachotUpgradeView", BaseView)

function V1a6_CachotUpgradeView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "top/#simage_title")
	self._gohope = gohelper.findChild(self.viewGO, "top/#go_hope")
	self._goprogress = gohelper.findChild(self.viewGO, "top/#go_hope/bg/#go_progress")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "top/#go_hope/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "top/#go_hope/#txt_num2")
	self._goshop = gohelper.findChild(self.viewGO, "top/#go_shop")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "top/#go_shop/#simage_icon")
	self._txtshopnum = gohelper.findChildText(self.viewGO, "top/#go_shop/#txt_shopnum")
	self._gopresetcontent = gohelper.findChild(self.viewGO, "scroll_view/Viewport/#go_presetcontent")
	self._gonormal = gohelper.findChild(self.viewGO, "right/#go_normal")
	self._txtorder = gohelper.findChildText(self.viewGO, "right/#go_normal/#txt_order")
	self._goqualityeffect1 = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect1")
	self._imagequality1 = gohelper.findChildImage(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality1")
	self._goqualityeffect2 = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#go_quality_effect2")
	self._imagequality2 = gohelper.findChildImage(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	self._txtlevel1 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1")
	self._txtlevel2 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level2")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch")
	self._btnswitch2 = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#btn_switch2")
	self._godetails = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details")
	self._godetailitem = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/#go_details/#go_detailitem")
	self._txtbreaklevel1 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel1")
	self._txtbreaklevel2 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/3/info/#txt_breaklevel2")
	self._txttalentlevel1 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel1")
	self._txttalentlevel2 = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/4/info/#txt_talentlevel2")
	self._gofull = gohelper.findChild(self.viewGO, "right/#go_full")
	self._goupgrade = gohelper.findChild(self.viewGO, "bottom/#go_upgrade")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_upgrade/#btn_upgrade")
	self._txtupgrade = gohelper.findChildText(self.viewGO, "bottom/#go_upgrade/#btn_upgrade/txt_upgrade")
	self._txtupgradecost = gohelper.findChildText(self.viewGO, "bottom/#go_upgrade/#txt_upgradecost")
	self._gogiveup = gohelper.findChild(self.viewGO, "bottom/#go_giveup")
	self._btngiveup = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#go_giveup/#btn_giveup")
	self._txtgiveupcost = gohelper.findChildText(self.viewGO, "bottom/#go_giveup/#txt_giveupcost")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotUpgradeView:addEvents()
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnswitch2:AddClickListener(self._btnswitch2OnClick, self)
	self._btnupgrade:AddClickListener(self._btnupgradeOnClick, self)
	self._btngiveup:AddClickListener(self._btngiveupOnClick, self)
end

function V1a6_CachotUpgradeView:removeEvents()
	self._btnswitch:RemoveClickListener()
	self._btnswitch2:RemoveClickListener()
	self._btnupgrade:RemoveClickListener()
	self._btngiveup:RemoveClickListener()
end

function V1a6_CachotUpgradeView:_btnswitchOnClick()
	self._detailAnimator:Play("close", 0, 0)
	self:_showUpSwitch(false)
	TaskDispatcher.cancelTask(self._hideDetail, self)
	TaskDispatcher.runDelay(self._hideDetail, self, 0.16)
end

function V1a6_CachotUpgradeView:_hideDetail()
	gohelper.setActive(self._godetails, false)
end

function V1a6_CachotUpgradeView:_btngiveupOnClick()
	if not self._anyCanUpgrade then
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)

		return
	end

	local function yesFunc()
		RogueRpc.instance:sendRogueEventEndRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, self.closeThis, self)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.V1a6CachotMsgBox06, MsgBoxEnum.BoxType.Yes_No, yesFunc)
end

function V1a6_CachotUpgradeView:_btnswitch2OnClick()
	gohelper.setActive(self._godetails, true)
	self:_showUpSwitch(true)
	self._detailAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(self._hideDetail, self)
end

function V1a6_CachotUpgradeView:_showUpSwitch(value)
	gohelper.setActive(self._btnswitch, value)
	gohelper.setActive(self._btnswitch2, not value)
end

function V1a6_CachotUpgradeView:_btnupgradeOnClick()
	if not self._nextConfig then
		GameFacade.showToast(ToastEnum.V1a6CachotToast06)

		return
	end

	if self._nextConfig and self._nextConfig.cost > self._rogueInfo.currency then
		GameFacade.showToast(ToastEnum.V1a6CachotToast05)

		return
	end

	local seatIndex = self._selectedTeamItem:getSeatIndex()

	RogueRpc.instance:sendRogueEventSelectRequest(V1a6_CachotEnum.ActivityId, self.viewParam.eventId, seatIndex, self._onSelectEnd, self)
end

function V1a6_CachotUpgradeView:_onSelectEnd()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnSeatUpgradeSuccess)
end

function V1a6_CachotUpgradeView:_initPresetItemList()
	if self._presetItemList then
		return
	end

	self._presetItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local childGO = self:getResInst(path, self._gopresetcontent, "item" .. tostring(i))
		local presetItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamItem)

		self._presetItemList[i] = presetItem

		presetItem:setSelectEnable(true)
	end
end

function V1a6_CachotUpgradeView:_updatePresetItemList()
	self._anyCanUpgrade = false

	for i, item in ipairs(self._presetItemList) do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)
		local seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(i)

		V1a6_CachotTeamModel.instance:setSeatInfo(i, seatLevel, mo)
		item:onUpdateMO(mo)

		local nextLevel = seatLevel + 1
		local nextSeatConfig = lua_rogue_field.configDict[nextLevel]

		if nextSeatConfig then
			if nextSeatConfig.cost > self._rogueInfo.currency then
				item:setCost(string.format("<color=#D97373>-%s</color>", nextSeatConfig.cost))
			else
				item:setCost("-" .. nextSeatConfig.cost)

				self._anyCanUpgrade = true
			end
		else
			item:setCost()
		end
	end
end

function V1a6_CachotUpgradeView:_selectItem(index, mo)
	for i, item in ipairs(self._presetItemList) do
		local selectByIndex = index and i == index
		local selectByMo = mo and item:getMo() == mo
		local isSelected = selectByIndex or selectByMo

		item:setSelected(isSelected)

		if isSelected then
			self._selectedIndex = i

			self:_showSeatInfo(item)
		end
	end
end

function V1a6_CachotUpgradeView:_setQuality(effectGo, img, level, effectListKey)
	local list = self[effectListKey]

	if not list then
		list = self:getUserDataTb_()
		self[effectListKey] = list

		local transform = effectGo.transform
		local childCount = transform.childCount

		for i = 1, childCount do
			local child = transform:GetChild(i - 1)

			list[child.name] = child

			local imgList = child:GetComponentsInChildren(gohelper.Type_Image, true)

			for j = 0, imgList.Length - 1 do
				local img = imgList[j]

				img.maskable = true
			end
		end
	end

	local targetName = "effect_0" .. level

	for k, v in pairs(list) do
		gohelper.setActive(v, k == targetName)
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(img, "v1a6_cachot_quality_0" .. level)
end

function V1a6_CachotUpgradeView:_showSeatInfo(item)
	gohelper.setActive(self._gonormal, false)
	gohelper.setActive(self._gofull, false)

	local seatIndex = item:getSeatIndex()

	self._selectedTeamItem = item
	self._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(seatIndex))

	local curLevel = V1a6_CachotTeamModel.instance:getSeatLevel(seatIndex)
	local nextLevel = curLevel + 1
	local nextConfig = lua_rogue_field.configDict[nextLevel]

	self._nextConfig = nextConfig

	gohelper.setActive(self._txtupgradecost, nextConfig)
	ZProj.UGUIHelper.SetGrayscale(self._btnupgrade.gameObject, nextConfig == nil)
	ZProj.UGUIHelper.SetGrayscale(self._txtupgrade.gameObject, nextConfig == nil)

	if not nextConfig then
		gohelper.setActive(self._gofull, true)

		return
	end

	gohelper.setActive(self._gonormal, true)

	local curConfig = lua_rogue_field.configDict[curLevel]

	self:_setQuality(self._goqualityeffect1, self._imagequality1, curLevel, "effectListKey1")
	self:_setQuality(self._goqualityeffect2, self._imagequality2, nextLevel, "effectListKey2")

	self._txtbreaklevel1.text = "Lv." .. curConfig.equipLevel
	self._txtbreaklevel2.text = "Lv." .. nextConfig.equipLevel
	self._txttalentlevel1.text = "Lv." .. curConfig.talentLevel
	self._txttalentlevel2.text = "Lv." .. nextConfig.talentLevel

	local heroMo = item:getHeroMo()
	local starNum = 6

	if heroMo then
		starNum = CharacterEnum.Star[heroMo.config.rare]
	end

	self._roleStarNum.text = tostring(starNum)

	for i, v in ipairs(self._roleStarList) do
		gohelper.setActive(v, i <= starNum)
	end

	local roleKey = self:_getLevelKey(starNum)

	self:_showDetailLevel(curConfig[roleKey], self._txtlevel1, self._rankList1)
	self:_showDetailLevel(nextConfig[roleKey], self._txtlevel2, self._rankList2)

	for i, v in ipairs(self._detailItemList) do
		local key = self:_getLevelKey(v.starNum)

		self:_updateDetailItem(v, curConfig, nextConfig, key)
	end

	self._txtupgradecost.text = nextConfig.cost > self._rogueInfo.currency and string.format("<color=#D97373>-%s</color>", nextConfig.cost) or string.format("<color=#E6E5E1>-%s</color>", nextConfig.cost)
end

function V1a6_CachotUpgradeView:_getLevelKey(starNum)
	if starNum >= 5 then
		return "level" .. starNum
	else
		return "level4"
	end
end

function V1a6_CachotUpgradeView:_updateDetailItem(item, curConfig, nextConfig, key)
	self:_showDetailLevel(curConfig[key], item.lv1, item._rankList1)
	self:_showDetailLevel(nextConfig[key], item.lv2, item._rankList2)
end

function V1a6_CachotUpgradeView:_showDetailLevel(level, txt, rankList)
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	txt.text = "Lv." .. showLevel

	for i, go in ipairs(rankList) do
		local visible = i == rank - 1

		gohelper.setActive(go, visible)
	end
end

function V1a6_CachotUpgradeView:_editableInitView()
	self:_initRoleLevelInfo()
	self:_initDetailItemList()
	gohelper.setActive(self._txtgiveupcost, false)

	self._animator = self.viewGO:GetComponent("Animator")
	self._detailAnimator = self._godetails:GetComponent("Animator")
end

function V1a6_CachotUpgradeView:_initRoleLevelInfo()
	self._roleStarList = self:getUserDataTb_()
	self._roleStarNum = gohelper.findChildText(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/#txt_num")

	local go = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/layout/rare")
	local starNum = 1

	for i = 1, starNum do
		self._roleStarList[i] = gohelper.findChild(go, "go_rare" .. i)
	end

	self._rankList1 = self:getUserDataTb_()
	self._rankList2 = self:getUserDataTb_()

	for i = 1, 3 do
		local rank1 = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/#txt_level1/rankobj/rank" .. i)

		table.insert(self._rankList1, rank1)

		local rank2 = gohelper.findChild(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/2/info/rankobj/rank" .. i)

		table.insert(self._rankList2, rank2)
	end
end

function V1a6_CachotUpgradeView:_initDetailItemList()
	self._detailItemList = self:getUserDataTb_()

	local starList = {}

	for i = 6, 1, -1 do
		table.insert(starList, i)
	end

	gohelper.CreateObjList(self, self._initDetailItem, starList, self._godetails, self._godetailitem)
end

function V1a6_CachotUpgradeView:_initDetailItem(obj, data, index)
	local item = self:getUserDataTb_()

	item.starNum = data
	item.lv1 = gohelper.findChildText(obj, "txt_level1")
	item.lv2 = gohelper.findChildText(obj, "txt_level2")
	item.lvnum = gohelper.findChildText(obj, "#txt_num")
	item.lvnum.text = tostring(data)
	item._rankList1 = self:getUserDataTb_()
	item._rankList2 = self:getUserDataTb_()

	for i = 1, 3 do
		local rank1 = gohelper.findChild(obj, "txt_level1/rankobj/rank" .. i)

		table.insert(item._rankList1, rank1)

		local rank2 = gohelper.findChild(obj, "rankobj/rank" .. i)

		table.insert(item._rankList2, rank2)
	end

	local starNum = 1

	for i = 1, starNum do
		local go = gohelper.findChild(obj, "rare/go_rare" .. i)

		gohelper.setActive(go, i <= data)
	end

	gohelper.setActive(obj, true)

	self._detailItemList[index] = item

	if index == 6 then
		gohelper.setActive(obj, false)
	end
end

function V1a6_CachotUpgradeView:onOpen()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	V1a6_CachotTeamModel.instance:clearSeatInfos()
	self:_initPresetItemList()
	self:_updatePresetItemList()
	self:_selectItem(1)
	self:_showUpSwitch(false)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnClickTeamItem, self._onClickTeamItem, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnSeatUpgradeSuccess, self._onSeatUpgradeSuccess, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function V1a6_CachotUpgradeView:_onOpenView(viewName)
	if viewName == ViewName.V1a6_CachotUpgradeResultView then
		self._animator.enabled = true

		self._animator:Play("close", 0, 0)
	end
end

function V1a6_CachotUpgradeView:_onCloseView(viewName)
	if viewName == ViewName.V1a6_CachotUpgradeResultView then
		self._animator.enabled = true

		self._animator:Play("back", 0, 0)
		self:_updatePresetItemList()
		self:_selectItem(self._selectedIndex)
	end
end

function V1a6_CachotUpgradeView:_onSeatUpgradeSuccess()
	for i, item in ipairs(self._presetItemList) do
		local mo = V1a6_CachotHeroSingleGroupModel.instance:getById(i)
		local seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(i)

		V1a6_CachotTeamModel.instance:setSeatInfo(i, seatLevel, mo)
	end

	V1a6_CachotController.instance:openV1a6_CachotUpgradeResultView({
		teamItemMo = self._selectedTeamItem:getMo(),
		seatIndex = self._selectedTeamItem:getSeatIndex()
	})
end

function V1a6_CachotUpgradeView:_onClickTeamItem(mo)
	self._animator.enabled = true

	self._animator:Play("switch", 0, 0)
	self:_showUpSwitch(false)
	gohelper.setActive(self._godetails, false)
	TaskDispatcher.cancelTask(self._hideDetail, self)
	self:_selectItem(nil, mo)
end

function V1a6_CachotUpgradeView:onClose()
	TaskDispatcher.cancelTask(self._hideDetail, self)
end

function V1a6_CachotUpgradeView:onDestroyView()
	return
end

return V1a6_CachotUpgradeView
