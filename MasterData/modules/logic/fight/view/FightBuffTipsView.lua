-- chunkname: @modules/logic/fight/view/FightBuffTipsView.lua

module("modules.logic.fight.view.FightBuffTipsView", package.seeall)

local FightBuffTipsView = class("FightBuffTipsView", BaseView)

function FightBuffTipsView:onInitView()
	self._gobuffinfocontainer = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/buff")
	self._scrollbuff = gohelper.findChildScrollRect(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff")
	self.content = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content")
	self.content.transform.pivot = Vector2.up
	self._gobuffitem = gohelper.findChild(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content/#go_buffitem")
	self._btnclosebuffinfocontainer = gohelper.findChildButton(self.viewGO, "root/#go_buffinfocontainer/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightBuffTipsView:addEvents()
	self._btnclosebuffinfocontainer:AddClickListener(self._onCloseBuffInfoContainer, self)
end

function FightBuffTipsView:removeEvents()
	self._btnclosebuffinfocontainer:RemoveClickListener()
end

function FightBuffTipsView:_editableInitView()
	self.rectTrScrollBuff = self._scrollbuff:GetComponent(gohelper.Type_RectTransform)
	self.rectTrBuffContent = gohelper.findChildComponent(self.viewGO, "root/#go_buffinfocontainer/buff/#scroll_buff/viewport/content", gohelper.Type_RectTransform)

	gohelper.setActive(self._gobuffitem, false)

	self._buffItemList = {}
end

function FightBuffTipsView:_onCloseBuffInfoContainer()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_click)
	self:closeThis()
end

function FightBuffTipsView:onOpen()
	gohelper.setActive(gohelper.findChild(self.viewGO, "root/tips"), true)

	local entityMO = FightDataHelper.entityMgr:getById(self.viewParam.entityId or self.viewParam)

	self:_updateBuffs(entityMO)

	if self.viewParam.viewname and self.viewParam.viewname == "FightView" then
		self:_setPos(entityMO)
	else
		local x = entityMO.side == FightEnum.EntitySide.MySide and 207 or -161

		recthelper.setAnchorX(self._gobuffinfocontainer.transform, x)
	end

	recthelper.setAnchorY(self.content.transform, 0)
end

function FightBuffTipsView:_setPos(entityMO)
	local iconPos = self.viewParam.iconPos
	local offsetX = self.viewParam.offsetX
	local offsetY = self.viewParam.offsetY

	self.enemyBuffTipPosY = 80

	local anchorPos = recthelper.rectToRelativeAnchorPos(iconPos, self._gobuffinfocontainer.transform.parent)
	local scrollW = recthelper.getWidth(self.rectTrScrollBuff)
	local scrollH = recthelper.getHeight(self.rectTrScrollBuff)
	local tipPosX, tipPosY = 0, 0

	if entityMO.side == FightEnum.EntitySide.MySide then
		tipPosX = anchorPos.x - offsetX
		tipPosY = anchorPos.y + offsetY
	else
		tipPosX = anchorPos.x + offsetX
		tipPosY = self.enemyBuffTipPosY
	end

	local hSW = UnityEngine.Screen.width * 0.5
	local padding = 10
	local rangeX = {
		min = -hSW + scrollW + padding,
		max = hSW - scrollW - padding
	}

	tipPosX = GameUtil.clamp(tipPosX, rangeX.min, rangeX.max)

	recthelper.setAnchor(self._gobuffinfocontainer.transform, tipPosX, tipPosY)
end

function FightBuffTipsView:_updateBuffs(entityMo)
	self.updateBuffDesc(self, entityMo, self._buffItemList, self._gobuffitem, self, self.getCommonBuffTipScrollAnchor)
end

FightBuffTipsView.Interval = 10

function FightBuffTipsView:getCommonBuffTipScrollAnchor(rectTrViewGo, rectTrScrollTip)
	local w = GameUtil.getViewSize()
	local halfW = w / 2
	local scrollTr = self.rectTrScrollBuff
	local scrollContentTr = self.rectTrBuffContent
	local screenPosX, screenPosY = recthelper.uiPosToScreenPos2(scrollTr)
	local localPosX, localPosY = SLFramework.UGUI.RectTrHelper.ScreenPosXYToAnchorPosXY(screenPosX, screenPosY, rectTrViewGo, CameraMgr.instance:getUICamera(), nil, nil)
	local halfBuffWidth = recthelper.getWidth(scrollTr) / 2
	local leftRemainWidth = halfW + localPosX - halfBuffWidth - FightBuffTipsView.Interval
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showLeft = scrollTipWidth <= leftRemainWidth

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right

	local anchorX = localPosX

	anchorX = showLeft and anchorX - halfBuffWidth - FightBuffTipsView.Interval or anchorX + halfBuffWidth + FightBuffTipsView.Interval + scrollTipWidth

	local contentHeight = math.min(recthelper.getHeight(scrollTr), recthelper.getHeight(scrollContentTr))
	local halfHeight = recthelper.getHeight(self._gobuffinfocontainer.transform) / 2

	recthelper.setAnchor(rectTrScrollTip, anchorX, recthelper.getAnchorY(self._gobuffinfocontainer.transform) + halfHeight)
end

FightBuffTipsView.filterTypeKey = {
	[2] = true
}

local kScrollMaxWidth = 635
local kMaxTotalWidth = 597
local kDefaultBuffNameWidth = 300
local kDefaultBuffTimeWidth = 141

function FightBuffTipsView:updateBuffDesc(entityMo, buffItemList, goBuffItem, viewClass, getAnchorFunc)
	local buffMOs = entityMo and entityMo:getBuffList() or {}

	buffMOs = tabletool.copy(buffMOs)
	buffMOs = FightBuffHelper.filterBuffType(buffMOs, FightBuffTipsView.filterTypeKey)

	FightSkillBuffMgr.instance:dealStackerBuff(buffMOs)
	table.sort(buffMOs, FightNameUIBuffMgr.sortBuffMo)

	for _, item in ipairs(buffItemList) do
		gohelper.setActive(item.go, false)
	end

	if buffMOs then
		if not #buffMOs then
			local count = 0
			local itemCount = 0
			local lastIndex = -1
			local scrollMaxWidth = kScrollMaxWidth
			local maxTotalWidth = kMaxTotalWidth
			local tempTxtsList = {}

			for i = 1, count do
				local buffMO = buffMOs[i]
				local buffCO = lua_skill_buff.configDict[buffMO.buffId]

				if buffCO and buffCO.isNoShow == 0 then
					local buffTypeCo = lua_skill_bufftype.configDict[buffCO.typeId]
					local buffTagCO = lua_skill_buff_desc.configDict[buffTypeCo.type]

					itemCount = itemCount + 1

					local buffItem = buffItemList[itemCount]

					if not buffItem then
						buffItem = viewClass:getUserDataTb_()
						buffItem.go = gohelper.cloneInPlace(goBuffItem, "buff" .. itemCount)
						buffItem.getAnchorFunc = getAnchorFunc
						buffItem.viewClass = viewClass

						table.insert(buffItemList, buffItem)
					end

					local buffItemGo = buffItem.go

					lastIndex = #buffItemList

					local txtBuffTime = gohelper.findChildText(buffItemGo, "title/txt_time")
					local desctxt = gohelper.findChildText(buffItemGo, "txt_desc")

					SkillHelper.addHyperLinkClick(desctxt, FightBuffTipsView.onClickBuffHyperLink, buffItem)

					local titleName = gohelper.findChildText(buffItemGo, "title/txt_name")

					titleName.text = FightBuffTipsView.getBuffName(buffMO, buffCO)

					local descWidth = titleName.preferredWidth
					local desc = FightBuffGetDescHelper.getBuffDesc(buffMO)
					local descHeight = GameUtil.getTextHeightByLine(desctxt, desc, 52.1) + 62

					recthelper.setHeight(buffItemGo.transform, descHeight)

					desctxt.text = desc

					local buffIcon = gohelper.findChildImage(buffItemGo, "title/simage_icon")

					if buffIcon then
						UISpriteSetMgr.instance:setBuffSprite(buffIcon, buffCO.iconId)
					end

					local goline = gohelper.findChild(buffItemGo, "txt_desc/image_line")
					local gotag = gohelper.findChild(buffItemGo, "title/txt_name/go_tag")
					local tagName = gohelper.findChildText(buffItemGo, "title/txt_name/go_tag/bg/txt_tagname")
					local tagNameTxt = buffTagCO.name

					if not string.nilorempty(tagNameTxt) then
						tagName.text = tagNameTxt
						descWidth = descWidth + tagName.preferredWidth
					end

					gohelper.setActive(gotag, not string.nilorempty(tagNameTxt))
					gohelper.setActive(goline, itemCount ~= count)

					viewClass._scrollbuff.verticalNormalizedPosition = 1

					local descTxtTran = desctxt.transform
					local titleGo = gohelper.findChild(buffItemGo, "title")
					local titleTran = titleGo.transform
					local buffItemTran = buffItemGo.transform

					gohelper.setActive(buffItemGo, true)
					gohelper.setActive(goline, itemCount ~= count)

					tempTxtsList[#tempTxtsList + 1] = descTxtTran
					tempTxtsList[#tempTxtsList + 1] = titleTran
					tempTxtsList[#tempTxtsList + 1] = buffItemTran
					tempTxtsList[#tempTxtsList + 1] = desctxt
					tempTxtsList[#tempTxtsList + 1] = buffMO

					FightBuffTipsView.showBuffTime(txtBuffTime, buffMO, buffCO, entityMo)

					local txtBuffTimeWidth = txtBuffTime.preferredWidth

					if txtBuffTimeWidth > kDefaultBuffTimeWidth then
						local offset = math.max(0, txtBuffTimeWidth - kDefaultBuffTimeWidth)

						descWidth = descWidth + offset
					end

					if descWidth > kDefaultBuffNameWidth then
						local needAddWidth = descWidth - kDefaultBuffNameWidth
						local totalWidth = kMaxTotalWidth + needAddWidth

						scrollMaxWidth = math.max(scrollMaxWidth, totalWidth)
						maxTotalWidth = math.max(maxTotalWidth, totalWidth)
					end
				end
			end

			if #tempTxtsList > 0 then
				for i = 0, #tempTxtsList - 1, 5 do
					local descTxtTran = tempTxtsList[i + 1]
					local titleTran = tempTxtsList[i + 2]
					local buffItemTran = tempTxtsList[i + 3]
					local desctxt = tempTxtsList[i + 4]
					local buffMO = tempTxtsList[i + 5]

					recthelper.setWidth(titleTran, maxTotalWidth - 10)
					recthelper.setWidth(descTxtTran, maxTotalWidth - 46)
					ZProj.UGUIHelper.RebuildLayout(buffItemTran)
					recthelper.setWidth(buffItemTran, maxTotalWidth)

					desctxt.text = FightBuffGetDescHelper.getBuffDesc(buffMO)
					desctxt.text = desctxt.text

					local descHeight = desctxt.preferredHeight + 52.1 + 10

					recthelper.setHeight(buffItemTran, descHeight)
				end
			end

			for key in pairs(tempTxtsList) do
				rawset(tempTxtsList, key, nil)
			end

			tempTxtsList = nil

			if lastIndex ~= -1 then
				local buffItemGo = buffItemList[lastIndex].go
				local goline = gohelper.findChild(buffItemGo, "txt_desc/image_line")

				gohelper.setActive(goline, false)
			end

			if viewClass then
				viewClass._scrollbuff.verticalNormalizedPosition = 1

				recthelper.setWidth(viewClass._scrollbuff.transform, scrollMaxWidth)
			end
		end
	end
end

function FightBuffTipsView.onClickBuffHyperLink(buffItem, effectId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(effectId, buffItem.getAnchorFunc, buffItem.viewClass)
end

function FightBuffTipsView.getBuffName(buffMo, buffCo)
	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffMo.buffId) then
		return FightBuffTipsView.getKSDLBuffName(buffMo, buffCo)
	end

	return buffCo.name
end

function FightBuffTipsView.showBuffTime(txtBuffTime, buffMO, buffCO, entityMo)
	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(buffMO.buffId) then
		txtBuffTime.text = ""

		return
	end

	if FightBuffHelper.isCountContinueChanelBuff(buffMO) then
		txtBuffTime.text = string.format(luaLang("enemytip_buff_time"), buffMO.exInfo)

		return
	end

	if buffMO and FightConfig.instance:hasBuffFeature(buffMO.buffId, FightEnum.BuffFeature.CountUseSelfSkillContinueChannel) then
		txtBuffTime.text = string.format(luaLang("enemytip_buff_time"), buffMO.exInfo)

		return
	end

	if FightBuffHelper.isDuduBoneContinueChannelBuff(buffMO) then
		txtBuffTime.text = string.format(luaLang("buff_tip_duration"), buffMO.exInfo)

		return
	end

	if FightBuffHelper.isDeadlyPoisonBuff(buffMO) then
		local layer = FightSkillBuffMgr.instance:getStackedCount(buffMO.entityId, buffMO)

		txtBuffTime.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("buff_tip_round_and_layer"), buffMO.duration, layer)

		return
	end

	local buffTypeCo = lua_skill_bufftype.configDict[buffCO.typeId]
	local is_stacked, tar_type = FightSkillBuffMgr.instance:buffIsStackerBuff(buffCO)

	if is_stacked then
		local stacked_text = string.format(luaLang("enemytip_buff_stacked_count"), FightSkillBuffMgr.instance:getStackedCount(entityMo.id, buffMO))

		txtBuffTime.text = tar_type == FightEnum.BuffIncludeTypes.Stacked12 and stacked_text .. " " .. string.format(luaLang("enemytip_buff_time"), buffMO.duration) or stacked_text
	elseif buffMO.duration == 0 then
		if buffMO.count == 0 then
			txtBuffTime.text = luaLang("forever")
		else
			local param = buffMO.count
			local langkey = "enemytip_buff_count"

			if buffTypeCo then
				if not buffTypeCo.includeTypes then
					local includeTypes = ""
					local arr = string.split(includeTypes, "#")

					if arr[1] == "11" then
						langkey = "enemytip_buff_stacked_count"
						param = buffMO.layer
					end

					txtBuffTime.text = string.format(luaLang(langkey), param)
				end
			end
		end
	elseif buffMO.count == 0 then
		txtBuffTime.text = string.format(luaLang("enemytip_buff_time"), buffMO.duration)
	else
		local param = buffMO.count
		local langkey = "round_or_times"

		if buffTypeCo then
			if not buffTypeCo.includeTypes then
				local includeTypes = ""
				local arr = string.split(includeTypes, "#")

				if arr[1] == "11" then
					langkey = "round_or_stacked_count"
					param = buffMO.layer
				end

				local tag = {
					buffMO.duration,
					param
				}

				txtBuffTime.text = GameUtil.getSubPlaceholderLuaLang(luaLang(langkey), tag)
			end
		end
	end
end

function FightBuffTipsView.getKSDLBuffName(buffMo, buffCo)
	local buffList = FightBuffHelper.getKSDLSpecialBuffList(buffMo)

	buffMo = buffList[1]

	if not buffList[1] then
		return buffCo.name
	end

	buffCo = buffMo:getCO()

	return buffCo.name
end

return FightBuffTipsView
