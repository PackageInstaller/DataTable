-- chunkname: @modules/logic/resonance/view/CharacterTalentUseLayoutView.lua

module("modules.logic.resonance.view.CharacterTalentUseLayoutView", package.seeall)

local CharacterTalentUseLayoutView = class("CharacterTalentUseLayoutView", BaseView)

function CharacterTalentUseLayoutView:onInitView()
	self._txttip = gohelper.findChildText(self.viewGO, "#txt_tip")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._gocubelayout = gohelper.findChild(self.viewGO, "#go_cubelayout")
	self._gocurlayout = gohelper.findChild(self.viewGO, "#go_cubelayout/#go_curlayout")
	self._gosharelayout = gohelper.findChild(self.viewGO, "#go_cubelayout/#go_sharelayout")
	self._gomeshItem = gohelper.findChild(self.viewGO, "#go_cubelayout/#go_meshItem")
	self._gochessitem = gohelper.findChild(self.viewGO, "#go_cubelayout/#go_chessitem")
	self._goattr = gohelper.findChild(self.viewGO, "#go_attr")
	self._gobg = gohelper.findChild(self.viewGO, "#go_attr/panel/attributeItem/#go_bg")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_attr/panel/attributeItem/#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_attr/panel/attributeItem/#txt_name")
	self._txtcur = gohelper.findChildText(self.viewGO, "#go_attr/panel/attributeItem/#txt_cur")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_attr/panel/attributeItem/#txt_num")
	self._imagechange = gohelper.findChildImage(self.viewGO, "#go_attr/panel/attributeItem/#txt_num/#image_change")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_check")
	self._txtcube = gohelper.findChildText(self.viewGO, "#btn_check/#txt_cube")
	self._txtattr = gohelper.findChildText(self.viewGO, "#btn_check/#txt_attr")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentUseLayoutView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function CharacterTalentUseLayoutView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
	self._btncheck:RemoveClickListener()
end

function CharacterTalentUseLayoutView:_btnyesOnClick()
	if string.nilorempty(self._code) then
		return
	end

	local templateId = self._heroMo.useTalentTemplateId
	local isUnlock = HeroResonaceModel.instance:_isUnlockTalentStyle(self._heroMo.heroId, self._shareStyle)

	if isUnlock then
		if not self._shareStyle then
			local style = 0

			HeroRpc.instance:setPutTalentCubeBatchRequest(self._heroMo.heroId, self._shareDataList, templateId, style)
		end
	end
end

function CharacterTalentUseLayoutView:_btnnoOnClick()
	self:closeThis()
end

function CharacterTalentUseLayoutView:_btncheckOnClick()
	self:_activeAttrPanel(not self._isShowAttrPanel)
end

function CharacterTalentUseLayoutView:_editableInitView()
	return
end

function CharacterTalentUseLayoutView:onUpdateParam()
	return
end

function CharacterTalentUseLayoutView:onClickModalMask()
	self:closeThis()
end

function CharacterTalentUseLayoutView:_addEvents()
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
end

function CharacterTalentUseLayoutView:_removeEvents()
	self.removeEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
end

function CharacterTalentUseLayoutView:_onUseShareCode()
	local typecn = HeroResonaceModel.instance:getSpecialCn(self._heroMo)

	ToastController.instance:showToast(ToastEnum.CharacterTalentShareCodeSuccessPastedUse, typecn)
	self:closeThis()
end

function CharacterTalentUseLayoutView:onOpen()
	self:_addEvents()
	gohelper.setActive(self._txtdesc.gameObject, false)

	self._code = self.viewParam.code
	self._heroMo = self.viewParam.heroMo
	self._defaultWidth = 56.2
	self._defaultSize = 6

	recthelper.setWidth(self._gomeshItem.transform, self._defaultWidth)
	recthelper.setHeight(self._gomeshItem.transform, self._defaultWidth)

	if not string.nilorempty(self._code) then
		self:_showShareLayout()
		self:_showUseLayout()
	end

	self._attrItems = self:getUserDataTb_()
	self._attrItemPrefab = gohelper.findChild(self.viewGO, "#go_attr/panel/attributeItem")

	self:_initAttr()

	local typecn = HeroResonaceModel.instance:getSpecialCn(self._heroMo)
	local lang = luaLang("p_charactertalentuselayoutview_txt_title")

	self._txttip.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, typecn)
end

function CharacterTalentUseLayoutView:_showShareLayout()
	self._shareDataList, self._shareStyle = HeroResonaceModel.instance:decodeLayoutShareCode(self._code)

	if not self._shareDataList then
		return
	end

	self._shareCubeItems = self._shareCubeItems or self:getUserDataTb_()
	self._shareMeshItems = self._shareMeshItems or self:getUserDataTb_()
	self._sharemeshObj = gohelper.findChild(self._gosharelayout, "mesh")
	self._sharecubeObj = gohelper.findChild(self._gosharelayout, "cube")

	self:_setMesh(1)
	gohelper.CreateObjList(self, self._onShareCubeItemShow, self._shareDataList, self._sharecubeObj, self._gochessitem)
	self:_refreshMeshLine(self._shareMeshItems)
end

function CharacterTalentUseLayoutView:_showUseLayout()
	local dataList = self._heroMo.talentCubeInfos.data_list

	if not dataList or not self._heroMo then
		return
	end

	self._usemeshObj = gohelper.findChild(self._gocurlayout, "mesh")
	self._usecubeObj = gohelper.findChild(self._gocurlayout, "cube")
	self._useCubeItems = self._useCubeItems or self:getUserDataTb_()
	self._useMeshItems = self._useMeshItems or self:getUserDataTb_()

	self:_setMesh(2)
	gohelper.CreateObjList(self, self._onUseCubeItemShow, dataList, self._usecubeObj, self._gochessitem)
	self:_refreshMeshLine(self._useMeshItems)
end

function CharacterTalentUseLayoutView:_setMesh(layoutType)
	local x_y = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(self._heroMo.heroId, self._heroMo.talent), ",")
	local sizeX = x_y[1]
	local sizeY = x_y[2]

	if layoutType == 1 then
		if not self._shareMeshItems then
			local itemList = self._useMeshItems

			if layoutType == 1 then
				if not self._sharemeshObj then
					local parent = self._usemeshObj

					if layoutType == 1 then
						if not self._gosharelayout then
							for y = 0, sizeY - 1 do
								itemList[y] = self:getUserDataTb_()

								local meshItemList = itemList[y]

								if not meshItemList then
									meshItemList = self:getUserDataTb_()
									itemList[y] = meshItemList
								end

								for x = 0, sizeX - 1 do
									local meshItem = meshItemList[x]

									if not meshItem then
										meshItem = self:getUserDataTb_()

										local name = string.format("mesh_%s_%s", x, y)
										local go = gohelper.clone(self._gomeshItem, parent, name)

										meshItem.go = go
										meshItem.top = gohelper.findChild(go, "top")
										meshItem.bottom = gohelper.findChild(go, "bottom")
										meshItem.left = gohelper.findChild(go, "left")
										meshItem.right = gohelper.findChild(go, "right")
										meshItemList[x] = meshItem
									end

									local offset_x = x - (sizeX - 1) / 2
									local offset_y = (sizeY - 1) / 2 - y

									recthelper.setAnchor(meshItem.go.transform, offset_x * self._defaultWidth, offset_y * self._defaultWidth)
									gohelper.setActive(meshItem.go, true)
								end
							end
						end
					end
				end
			end
		end
	end
end

function CharacterTalentUseLayoutView:_onShareCubeItemShow(obj, data, index)
	self:_onCubeItemShow(obj, data, index, 1)

	local mainCubeId = self._heroMo.talentCubeInfos.own_main_cube_id

	if mainCubeId == data.cubeId and self._shareStyle and self._shareStyle > 0 then
		local isUnlock, cubeMo = HeroResonaceModel.instance:_isUnlockTalentStyle(self._heroMo.heroId, self._shareStyle)

		if not isUnlock then
			local defaultCubeMo = TalentStyleModel.instance:getCubeMoByStyle(self._heroMo.heroId, 0)
			local styleCubeName = cubeMo and cubeMo:getStyleTag()
			local defaultCubeName = defaultCubeMo and defaultCubeMo:getStyleTag()
			local lang = luaLang("character_copy_talentLayout_use_tip")

			self._txtdesc.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, styleCubeName, defaultCubeName)
		else
			local cubeId = tonumber(data.cubeId .. self._shareStyle)
			local item = self._shareCubeItems[index]

			self:_showMainStyleCube(cubeId, data.cubeId, item)
		end

		gohelper.setActive(self._txtdesc.gameObject, not isUnlock)
	end
end

function CharacterTalentUseLayoutView:_onUseCubeItemShow(obj, data, index)
	self:_onCubeItemShow(obj, data, index, 2)

	local mainCubeId = self._heroMo.talentCubeInfos.own_main_cube_id
	local cubeId = self._heroMo:getHeroUseStyleCubeId()

	if data.cubeId == mainCubeId and cubeId ~= mainCubeId then
		local item = self._useCubeItems[index]

		self:_showMainStyleCube(cubeId, mainCubeId, item)
	end
end

function CharacterTalentUseLayoutView:_showMainStyleCube(cubeId, mainCubeId, item)
	local co = HeroResonanceConfig.instance:getCubeConfig(cubeId)

	if not co then
		return
	end

	local icon = co.icon

	if not string.nilorempty(icon) then
		local iconbg = "ky_" .. icon
		local iconmk = "mk_" .. icon
		local glowIcon = iconmk
		local mainCubeCo = HeroResonanceConfig.instance:getCubeConfig(mainCubeId)

		if item then
			UISpriteSetMgr.instance:setCharacterTalentSprite(item.image, iconbg, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(item.icon, iconmk, true)
			UISpriteSetMgr.instance:setCharacterTalentSprite(item.glow_icon, glowIcon, true)

			local temp_attr = mainCubeCo and string.split(mainCubeCo.icon, "_")

			if temp_attr then
				local cell_bg = "gz_" .. temp_attr[#temp_attr]

				UISpriteSetMgr.instance:setCharacterTalentSprite(item.cell_icon, cell_bg, true)
				gohelper.setActive(item.cell_icon.gameObject, true)
			end
		end
	end
end

function CharacterTalentUseLayoutView:_onCubeItemShow(obj, data, index, layoutType)
	local transform = obj.transform
	local image = transform:GetComponent(gohelper.Type_Image)
	local icon = gohelper.findChildImage(obj, "icon")
	local glow_icon = gohelper.findChildImage(obj, "glow")
	local cell_icon = gohelper.findChildImage(obj, "cell")

	if layoutType == 1 then
		if not self._shareCubeItems then
			local itemList = self._useCubeItems

			if layoutType == 1 then
				if not self._shareMeshItems then
					local itemMeshList = self._useMeshItems
					local cubeId = data.cubeId
					local origin_mat = HeroResonanceConfig.instance:getCubeMatrix(cubeId)
					local iconSprite = HeroResonanceConfig.instance:getCubeConfig(cubeId).icon

					UISpriteSetMgr.instance:setCharacterTalentSprite(image, "ky_" .. iconSprite, true)
					UISpriteSetMgr.instance:setCharacterTalentSprite(icon, iconSprite, true)
					UISpriteSetMgr.instance:setCharacterTalentSprite(glow_icon, "glow_" .. iconSprite, true)
					gohelper.setActive(cell_icon.gameObject, false)

					itemList[index] = itemList[index] or self:getUserDataTb_()

					local item = self:getUserDataTb_()

					item.go = obj
					item.image = image
					item.icon = icon
					item.glow_icon = glow_icon
					item.cell_icon = cell_icon
					itemList[index] = item

					local meshItem = itemMeshList[data.posY][data.posX]

					if meshItem then
						local pos_x = meshItem.go.transform.anchoredPosition.x
						local pos_y = meshItem.go.transform.anchoredPosition.y

						transformhelper.setLocalRotation(transform, 0, 0, -data.direction * 90)

						local temp_width = self._defaultWidth * GameUtil.getTabLen(origin_mat[0])
						local temp_height = self._defaultWidth * GameUtil.getTabLen(origin_mat)
						local not_rotational = data.direction % 2 == 0

						pos_x = pos_x + (not_rotational and temp_width or temp_height) / 2
						pos_y = pos_y + -(not_rotational and temp_height or temp_width) / 2
						pos_x = pos_x - self._defaultWidth / 2
						pos_y = pos_y + self._defaultWidth / 2

						recthelper.setAnchor(transform, pos_x, pos_y)
					end

					local rotationMatrix = HeroResonaceModel.instance:rotationMatrix(origin_mat, data.direction)

					for i, list in pairs(rotationMatrix) do
						for j, v in pairs(list) do
							if v == 1 and itemMeshList[data.posY + i] then
								local _meshItem = itemMeshList[data.posY + i][data.posX + j]

								if _meshItem then
									_meshItem.data = data
								end
							end
						end
					end
				end
			end
		end
	end
end

function CharacterTalentUseLayoutView:_refreshMeshLine(itemMeshList)
	if not itemMeshList then
		return
	end

	for y, items in pairs(itemMeshList) do
		for x, curCell in pairs(items) do
			if not curCell then
				return
			end

			local leftCell = itemMeshList[y][x - 1]

			if leftCell and curCell.data and curCell.data == leftCell.data then
				gohelper.setActive(curCell.left, false)
				gohelper.setActive(leftCell.right, false)
			end

			if itemMeshList[y - 1] then
				local topCell = itemMeshList[y - 1][x]

				if topCell and curCell.data and curCell.data == topCell.data then
					gohelper.setActive(curCell.top, false)
					gohelper.setActive(topCell.bottom, false)
				end

				local rightCell = itemMeshList[y][x + 1]

				if rightCell and curCell.data and curCell.data == rightCell.data then
					gohelper.setActive(curCell.right, false)
					gohelper.setActive(rightCell.left, false)
				end

				if itemMeshList[y + 1] then
					local bottomCell = itemMeshList[y + 1][x]

					if bottomCell and curCell.data and curCell.data == bottomCell.data then
						gohelper.setActive(curCell.bottom, false)
						gohelper.setActive(bottomCell.top, false)
					end
				end
			end
		end
	end
end

function CharacterTalentUseLayoutView:_activeAttrPanel(isActive)
	self._isShowAttrPanel = isActive

	gohelper.setActive(self._gocubelayout, not isActive)
	gohelper.setActive(self._goattr, isActive)
	gohelper.setActive(self._txtcube.gameObject, not isActive)
	gohelper.setActive(self._txtattr.gameObject, isActive)
end

function CharacterTalentUseLayoutView:_initAttr()
	local shareTalentAttrInfos = HeroResonaceModel.instance:getShareTalentAttrInfos(self._heroMo, self._shareDataList, self._shareStyle)
	local line = math.ceil(#shareTalentAttrInfos * 0.5)

	if line > 5 then
		if not (120 + 20 * (line - 5)) then
			local offsetY = 120

			offsetY = math.min(offsetY, 240)

			for i, info in ipairs(shareTalentAttrInfos) do
				local item = self:_getAttrItem(i)
				local co = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(info.key))

				if not info.value then
					local value = 0

					if not info.shareValue then
						local shareValue = 0

						if co.type ~= 1 then
							value = tonumber(string.format("%.3f", value / 10)) .. "%"
							shareValue = tonumber(string.format("%.3f", shareValue / 10)) .. "%"
						else
							value = math.floor(value)
							shareValue = math.floor(shareValue)
						end

						item.txtname.text = co.name
						item.txtcur.text = value
						item.txtnum.text = shareValue

						local changeIndex = 0
						local _value = math.floor(info.value)
						local _shareValue = math.floor(info.shareValue)

						if _shareValue < _value then
							changeIndex = 2
						elseif _value < _shareValue then
							changeIndex = 1
						end

						local change = HeroResonanceEnum.AttrChange[changeIndex]

						item.txtnum.color = GameUtil.parseColor(change.NumColor)

						local isChangeImage = not string.nilorempty(change.ChangeImage)

						if isChangeImage then
							UISpriteSetMgr.instance:setUiCharacterSprite(item.imagechange, change.ChangeImage, true)
						end

						gohelper.setActive(item.imagechange.gameObject, isChangeImage)
						UISpriteSetMgr.instance:setCommonSprite(item.imageicon, "icon_att_" .. co.id, true)

						local temp = (i - 1) % line

						gohelper.setActive(item.goBg, temp % 2 == 1)

						local anchorX = i <= line and -360 or 360
						local anchorY = offsetY - temp * 60

						recthelper.setAnchor(item.go.transform, anchorX, anchorY)
					end
				end
			end

			for i = 1, #self._attrItems do
				gohelper.setActive(self._attrItems[i].go, i <= #shareTalentAttrInfos)
			end

			gohelper.setActive(self._attrItemPrefab, false)
			self:_activeAttrPanel(false)
		end
	end
end

function CharacterTalentUseLayoutView:_getAttrItem(index)
	local item = self._attrItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._attrItemPrefab, "item_" .. index)

		item = self:getUserDataTb_()
		item.go = go
		item.goBg = gohelper.findChild(go, "#go_bg")
		item.imageicon = gohelper.findChildImage(go, "#image_icon")
		item.txtname = gohelper.findChildText(go, "#txt_name")
		item.txtcur = gohelper.findChildText(go, "#txt_cur")
		item.txtnum = gohelper.findChildText(go, "#txt_num")
		item.imagechange = gohelper.findChildImage(go, "#txt_num/#image_change")
		self._attrItems[index] = item
	end

	return item
end

function CharacterTalentUseLayoutView:onClose()
	return
end

function CharacterTalentUseLayoutView:onDestroyView()
	self:_removeEvents()
end

return CharacterTalentUseLayoutView
