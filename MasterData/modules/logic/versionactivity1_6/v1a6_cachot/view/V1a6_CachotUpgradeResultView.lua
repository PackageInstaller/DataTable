-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotUpgradeResultView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotUpgradeResultView", package.seeall)

local V1a6_CachotUpgradeResultView = class("V1a6_CachotUpgradeResultView", BaseView)

function V1a6_CachotUpgradeResultView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "top/#simage_title")
	self._gohope = gohelper.findChild(self.viewGO, "top/#go_hope")
	self._goprogress = gohelper.findChild(self.viewGO, "top/#go_hope/bg/#go_progress")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "top/#go_hope/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "top/#go_hope/#txt_num2")
	self._goshop = gohelper.findChild(self.viewGO, "top/#go_shop")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "top/#go_shop/#simage_icon")
	self._txtshopnum = gohelper.findChildText(self.viewGO, "top/#go_shop/#txt_shopnum")
	self._goteampresetitem = gohelper.findChild(self.viewGO, "#go_teampresetitem")
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
	self._goupgraded = gohelper.findChild(self.viewGO, "bottom/#go_upgraded")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotUpgradeResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnswitch2:AddClickListener(self._btnswitch2OnClick, self)
end

function V1a6_CachotUpgradeResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnswitch2:RemoveClickListener()
end

function V1a6_CachotUpgradeResultView:_btnswitchOnClick()
	self._detailAnimator:Play("close", 0, 0)
	self:_showUpSwitch(false)
	TaskDispatcher.cancelTask(self._hideDetail, self)
	TaskDispatcher.runDelay(self._hideDetail, self, 0.16)
end

function V1a6_CachotUpgradeResultView:_hideDetail()
	gohelper.setActive(self._godetails, false)
end

function V1a6_CachotUpgradeResultView:_btnswitch2OnClick()
	gohelper.setActive(self._godetails, true)
	self:_showUpSwitch(true)
	self._detailAnimator:Play("open", 0, 0)
	TaskDispatcher.cancelTask(self._hideDetail, self)
end

function V1a6_CachotUpgradeResultView:_showUpSwitch(value)
	gohelper.setActive(self._btnswitch, value)
	gohelper.setActive(self._btnswitch2, not value)
end

function V1a6_CachotUpgradeResultView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotUpgradeResultView:_editableInitView()
	self:_initRoleLevelInfo()
	self:_initDetailItemList()

	self._detailAnimator = self._godetails:GetComponent("Animator")

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_columns_update)
end

function V1a6_CachotUpgradeResultView:_initRoleLevelInfo()
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

function V1a6_CachotUpgradeResultView:_initPresetItem()
	local path = self.viewContainer:getSetting().otherRes[1]
	local childGO = self:getResInst(path, self._goteampresetitem)

	self._presetItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_CachotTeamItem)
end

function V1a6_CachotUpgradeResultView:_initDetailItemList()
	self._detailItemList = self:getUserDataTb_()

	local starList = {}

	for i = 6, 1, -1 do
		table.insert(starList, i)
	end

	gohelper.CreateObjList(self, self._initDetailItem, starList, self._godetails, self._godetailitem)
end

function V1a6_CachotUpgradeResultView:_initDetailItem(obj, data, index)
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

function V1a6_CachotUpgradeResultView:onUpdateParam()
	return
end

function V1a6_CachotUpgradeResultView:onOpen()
	self._teamItemMo = self.viewParam and self.viewParam.teamItemMo
	self._seatIndex = self.viewParam and self.viewParam.seatIndex
	self._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(self._seatIndex))
	self._quality = gohelper.findChildImage(self.viewGO, "right/#go_normal/scroll_view/Viewport/Content/1/#image_quality2")
	self._qualityEffectList = self:getUserDataTb_()

	local transform = self._goqualityeffect2.transform
	local childCount = transform.childCount

	for i = 1, childCount do
		local child = transform:GetChild(i - 1)

		self._qualityEffectList[child.name] = child

		local imgList = child:GetComponentsInChildren(gohelper.Type_Image, true)

		for j = 0, imgList.Length - 1 do
			local img = imgList[j]

			img.maskable = true
		end
	end

	self:_initPresetItem()
	self._presetItem:onUpdateMO(self._teamItemMo)
	self:_showSeatInfo()
	self:_showUpSwitch(false)
end

function V1a6_CachotUpgradeResultView:_showSeatInfo()
	local seatIndex = self._seatIndex

	self._txtorder.text = formatLuaLang("cachot_seat_name", GameUtil.getRomanNums(self._seatIndex))

	local curLevel = V1a6_CachotTeamModel.instance:getSeatLevel(seatIndex)
	local curConfig = lua_rogue_field.configDict[curLevel]

	UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagequality2, "v1a6_cachot_quality_0" .. curLevel)

	local targetName = "effect_0" .. curLevel

	for k, v in pairs(self._qualityEffectList) do
		gohelper.setActive(v, k == targetName)
	end

	self._txtbreaklevel2.text = "Lv." .. curConfig.equipLevel
	self._txttalentlevel2.text = "Lv." .. curConfig.talentLevel

	local heroMo = self._teamItemMo:getHeroMO()
	local starNum = 6

	if heroMo then
		starNum = CharacterEnum.Star[heroMo.config.rare]
	end

	self._roleStarNum.text = tostring(starNum)

	for i, v in ipairs(self._roleStarList) do
		gohelper.setActive(v, i <= starNum)
	end

	local roleKey = self:_getLevelKey(starNum)

	self:_showDetailLevel(curConfig[roleKey], self._txtlevel2, self._rankList2)

	for i, v in ipairs(self._detailItemList) do
		local key = self:_getLevelKey(v.starNum)

		self:_updateDetailItem(v, curConfig, nil, key)
	end
end

function V1a6_CachotUpgradeResultView:_getLevelKey(starNum)
	if starNum >= 5 then
		return "level" .. starNum
	else
		return "level4"
	end
end

function V1a6_CachotUpgradeResultView:_updateDetailItem(item, curConfig, nextConfig, key)
	self:_showDetailLevel(curConfig[key], item.lv2, item._rankList2)
end

function V1a6_CachotUpgradeResultView:_showDetailLevel(level, txt, rankList)
	local showLevel, rank = HeroConfig.instance:getShowLevel(level)

	txt.text = "Lv." .. showLevel

	for i, go in ipairs(rankList) do
		local visible = i == rank - 1

		gohelper.setActive(go, visible)
	end
end

function V1a6_CachotUpgradeResultView:onClose()
	TaskDispatcher.cancelTask(self._hideDetail, self)
end

function V1a6_CachotUpgradeResultView:onDestroyView()
	return
end

return V1a6_CachotUpgradeResultView
