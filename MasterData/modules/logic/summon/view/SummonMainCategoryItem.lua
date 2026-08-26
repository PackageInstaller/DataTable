-- chunkname: @modules/logic/summon/view/SummonMainCategoryItem.lua

module("modules.logic.summon.view.SummonMainCategoryItem", package.seeall)

local SummonMainCategoryItem = class("SummonMainCategoryItem", LuaCompBase)

function SummonMainCategoryItem:onInitView()
	self._btnself = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_self")
	self._summonSelectFreeTagList = self:getUserDataTb_()
	self._summonUnselectFreeTagList = self:getUserDataTb_()
	self._goSelectFreeTipsRoot = gohelper.findChild(self.viewGO, "#go_select_role/#go_freetipsRoot")
	self._goUnselectFreeTipsRoot = gohelper.findChild(self.viewGO, "#go_normal_role/#go_freetipsRoot")

	local childCount = self._goSelectFreeTipsRoot.transform.childCount

	for i = 1, childCount do
		local freeTag = self._goSelectFreeTipsRoot.transform:GetChild(i - 1)

		table.insert(self._summonSelectFreeTagList, freeTag.gameObject)
	end

	childCount = self._goUnselectFreeTipsRoot.transform.childCount

	for i = 1, self._goUnselectFreeTipsRoot.transform.childCount do
		local freeTag = self._goUnselectFreeTipsRoot.transform:GetChild(i - 1)

		table.insert(self._summonUnselectFreeTagList, freeTag.gameObject)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonMainCategoryItem:addEvents()
	self._btnself:AddClickListener(self._btnselfOnClick, self)
end

function SummonMainCategoryItem:removeEvents()
	self._btnself:RemoveClickListener()
end

function SummonMainCategoryItem:_editableInitView()
	self._imagenormalquan = gohelper.findChildImage(self.viewGO, "#go_normal/#go_normaltips/quan/#circle")
	self._imageselectquan = gohelper.findChildImage(self.viewGO, "#go_select/#go_selecttips/quan/#circle")
	self._animRoot = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._goSelectRole = gohelper.findChild(self.viewGO, "#go_select_role")
	self._goUnSelectRole = gohelper.findChild(self.viewGO, "#go_normal_role")
	self._goSelectEquip = gohelper.findChild(self.viewGO, "#go_select_equip")
	self._goUnSelectEquip = gohelper.findChild(self.viewGO, "#go_normal_equip")
	self._goSelectImageMask = gohelper.findChildImage(self.viewGO, "#go_select_role/#image_mask")
	self.tipsList = self:getUserDataTb_()
end

function SummonMainCategoryItem:onDestroyView()
	if not self._isDisposed then
		self._simageiconnormal:UnLoadImage()
		self._simageiconselect:UnLoadImage()
		self._simageiconnormalmask:UnLoadImage()
		self._simageline:UnLoadImage()
		self:removeEvents()
		self:customRemoveEvent()
		tabletool.clear(self._summonSelectFreeTagList)

		self._summonSelectFreeTagList = nil

		tabletool.clear(self._summonUnselectFreeTagList)

		self._summonUnselectFreeTagList = nil
		self._isDisposed = true
	end
end

function SummonMainCategoryItem:onDestroy()
	self:onDestroyView()
end

function SummonMainCategoryItem:customAddEvent()
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._refreshSelected, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._refreshNewFlag, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonProgressRewards, self._refreshNewFlag, self)
	self.addEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._refreshNewFlag, self)
end

function SummonMainCategoryItem:customRemoveEvent()
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonTabSet, self._refreshSelected, self)
	self.removeEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._refreshNewFlag, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonProgressRewards, self._refreshNewFlag, self)
	self.removeEventCb(self, SummonController.instance, SummonEvent.onSummonOptionalProgressRewards, self._refreshNewFlag, self)
end

function SummonMainCategoryItem:_btnselfOnClick()
	if not self._mo then
		return
	end

	local poolId = self._mo.originConf.id

	if SummonMainModel.instance:getCurId() ~= poolId then
		SummonMainModel.instance:trySetSelectPoolId(poolId)

		if SummonMainModel.instance.flagModel then
			SummonMainModel.instance.flagModel:cleanFlag(poolId)
		end

		SummonController.instance:dispatchEvent(SummonEvent.onSummonTabSet)
	end
end

function SummonMainCategoryItem:onUpdateMO(mo)
	if self._mo ~= nil or not SummonMainCategoryListModel.instance:canPlayEnterAnim() then
		self._animRoot:Play("summonmaincategoryitem_in", 0, 1)

		self._animRoot.speed = 0
	end

	self._mo = mo

	self:_refreshUI()
end

function SummonMainCategoryItem:_refreshUI()
	if self._mo then
		local poolCfg = self._mo.originConf
		local isSelect = SummonMainModel.instance:getCurId() == poolCfg.id

		self:_initCurrentComponents()
		self:_refreshFree(isSelect)
		self:_refreshSelected()
		self:_refreshFlag(isSelect)
		self:_refreshNewFlag()
		self:_refreshTipsPosition(isSelect)
		self:_refreshSpecVfx(isSelect)
	end
end

local kPoolIdWithoutTxtDict = {}

function SummonMainCategoryItem:_initCurrentComponents()
	local poolCfg = self._mo.originConf
	local poolType = SummonMainModel.instance.getResultTypeById(poolCfg.id)

	if SummonEnum.ResultType.Equip == poolType then
		self._goSelected = self._goSelectEquip
		self._goUnselected = self._goUnSelectEquip

		gohelper.setActive(self._goSelectRole, false)
		gohelper.setActive(self._goUnSelectRole, false)
	else
		self._goSelected = self._goSelectRole
		self._goUnselected = self._goUnSelectRole

		gohelper.setActive(self._goSelectEquip, false)
		gohelper.setActive(self._goUnSelectEquip, false)
	end

	self._simageiconselect = gohelper.findChildSingleImage(self._goSelected, "#simage_icon_select")
	self._simageiconnormal = gohelper.findChildSingleImage(self._goUnselected, "#simage_icon_normal")
	self._simageline = gohelper.findChildSingleImage(self._goSelected, "#simage_icon_select/#simage_line")
	self._simageiconnormalmask = gohelper.findChildSingleImage(self._goUnselected, "#simage_icon_normalmask")
	self._simageiconnormalmaskGo = self._simageiconnormalmask.gameObject
	self._goUnselectFlag = gohelper.findChild(self._goUnselected, "#go_normaltips")
	self._imagenormalquan = gohelper.findChildImage(self._goUnselectFlag, "quan/#circle")
	self._imagenormalbg = gohelper.findChildImage(self._goUnselectFlag, "#image_normalbg")
	self._txtnormaltips = gohelper.findChildText(self._goUnselectFlag, "#txt_normaltips")
	self._txtname = gohelper.findChildText(self._goUnselected, "#txt_name")
	self._txtnameen = gohelper.findChildText(self._goUnselected, "#txt_nameen")
	self._goSelectFlag = gohelper.findChild(self._goSelected, "#go_selecttips")
	self._imageselectquan = gohelper.findChildImage(self._goSelectFlag, "quan/#circle")
	self._imageselectbg = gohelper.findChildImage(self._goSelectFlag, "#image_selectbg")
	self._txtselecttips = gohelper.findChildText(self._goSelectFlag, "#txt_selecttips")
	self._txtnameselect = gohelper.findChildText(self._goSelected, "#txt_name")
	self._txtnameenselect = gohelper.findChildText(self._goSelected, "#txt_nameen")
	self._imagenew = gohelper.findChildImage(self._goUnselected, "#image_new")
	self._imagereddot = gohelper.findChildImage(self._goUnselected, "#image_reddot")
	self._imagereddotselect = gohelper.findChildImage(self._goSelected, "#image_reddot")

	self:_refreshName()
	self:_refreshBannerLine()
	self:_refreshMask()
end

function SummonMainCategoryItem:_refreshSelected_overseas()
	if self._mo then
		local poolCfg = self._mo.originConf
		local isSelect = SummonMainModel.instance:getCurId() == poolCfg.id

		self._goSelected:SetActive(isSelect)
		self._goUnselected:SetActive(not isSelect)

		if not string.nilorempty(poolCfg.banner) then
			local bannerPath = poolCfg.banner
			local isWithoutTxt = self:_isWithoutTxt(poolCfg.id)

			if isWithoutTxt then
				bannerPath = isSelect and bannerPath .. "_1" or bannerPath .. "_0"
			end

			local bannerIconPath = ResUrl.getSummonBanner(bannerPath)

			self._simageiconnormal:LoadImage(bannerIconPath)
			self._simageiconselect:LoadImage(bannerIconPath)
			self._simageiconnormalmask:LoadImage(bannerIconPath)
			gohelper.setActive(self._simageiconnormalmaskGo, not isWithoutTxt)
		end
	end
end

function SummonMainCategoryItem:_refreshFlag(isSelect)
	if isSelect then
		self:_refreshSingleFlag(self._goSelectFlag, self._imageselectquan, self._imageselectbg, self._txtselecttips, isSelect)
	else
		self:_refreshSingleFlag(self._goUnselectFlag, self._imagenormalquan, self._imagenormalbg, self._txtnormaltips, isSelect)
	end
end

SummonMainCategoryItem._BannerFlag_DataDict = {
	[SummonEnum.BannerFlagType.Newbie] = {
		langKey = "p_summonmaincategoryitem_invite",
		imageBg = "bg_lx"
	},
	[SummonEnum.BannerFlagType.Activity] = {
		langKey = "summon_category_flag_activity",
		imageBg = "bg123123"
	},
	[SummonEnum.BannerFlagType.Limit] = {
		imageBg = "v1a6_quniang_summon_tag",
		langKey = "summon_limit_banner_flag",
		isTxtCororFormat = true
	},
	[SummonEnum.BannerFlagType.Reprint] = {
		imageBg = "v1a6_quniang_summon_tag",
		langKey = "summon_reprint_banner_flag",
		isTxtCororFormat = true
	},
	[SummonEnum.BannerFlagType.Cobrand] = {
		langKey = "summon_cobrand_banner_flag",
		imageBg = "bg_lx"
	},
	[SummonEnum.BannerFlagType.LimitReprint] = {
		imageBg = "v1a6_quniang_summon_tag",
		langKey = "summon_limitreprint_banner_flag",
		isTxtCororFormat = true
	}
}

function SummonMainCategoryItem:_refreshSingleFlag(goTips, imageCircle, imageBg, txtTips, isSelect)
	local poolCfg = self._mo.originConf
	local poolMO = SummonMainModel.instance:getPoolServerMO(poolCfg.id)
	local needShowFlag = false
	local colorAlpha = 0.5

	if poolMO ~= nil and SummonMainCategoryItem._BannerFlag_DataDict[poolCfg.bannerFlag] then
		needShowFlag = true

		local flagData = SummonMainCategoryItem._BannerFlag_DataDict[poolCfg.bannerFlag]
		local str = luaLang(flagData.langKey)

		UISpriteSetMgr.instance:setSummonSprite(imageBg, flagData.imageBg, true)
		SLFramework.UGUI.GuiHelper.SetColor(imageCircle, "#808080")

		if flagData.isTxtCororFormat then
			if isSelect then
				str = string.format("<color=#fefefe>%s</color>", str)
			else
				str = string.format("<color=#c5c6c7>%s</color>", str)
				colorAlpha = 1
			end
		end

		txtTips.text = str
	else
		txtTips.text = ""
	end

	if not isSelect then
		ZProj.UGUIHelper.SetColorAlpha(txtTips, colorAlpha)
	end

	if needShowFlag then
		table.insert(self.tipsList, goTips)
	end

	gohelper.setActive(goTips, needShowFlag)
end

function SummonMainCategoryItem:_refreshNewFlag()
	local isShowNew = false

	if not self._mo then
		return
	end

	local poolCfg = self._mo.originConf

	if poolCfg and self._imagenew then
		local hasNew = SummonMainModel.instance:categoryHasNew(poolCfg.id)

		gohelper.setActive(self._imagenew, hasNew)

		isShowNew = hasNew
	end

	local summonMO = SummonMainModel.instance:getPoolServerMO(poolCfg.id)
	local showReddot = false

	if summonMO then
		showReddot = SummonMainModel.needShowReddot(summonMO)
	end

	if isShowNew then
		gohelper.setActive(self._imagereddot, false)
	else
		gohelper.setActive(self._imagereddot, showReddot)
	end

	gohelper.setActive(self._imagereddotselect, showReddot)
end

function SummonMainCategoryItem:_refreshFree(isSelect)
	local poolCfg = self._mo.originConf
	local summonMO = SummonMainModel.instance:getPoolServerMO(poolCfg.id)
	local haveFree = summonMO.haveFree
	local havefree10Count = summonMO.havefree10Count > 0

	if isSelect then
		if not self._summonSelectFreeTagList then
			local freeTipsList = self._summonUnselectFreeTagList

			if isSelect then
				if not self._goSelectFreeTipsRoot then
					local freeTipRoot = self._goUnselectFreeTipsRoot
					local goFreeStyleTipGo
					local showSingle = haveFree and not havefree10Count
					local tagStyleParam = string.splitToNumber(poolCfg.freeTagStyle, "#")

					if showSingle then
						if not tagStyleParam[1] then
							local styleId = tagStyleParam[2]

							styleId = styleId or SummonEnum.DefaultTagStyle

							for index, itemGo in ipairs(freeTipsList) do
								gohelper.setActive(itemGo, index == styleId)

								if index == styleId then
									goFreeStyleTipGo = itemGo
								end
							end

							local txttips = isSelect and gohelper.findChildText(goFreeStyleTipGo, "#txt_selecttips") or gohelper.findChildText(goFreeStyleTipGo, "#txt_normaltips")

							if summonMO and (haveFree or havefree10Count) then
								table.insert(self.tipsList, freeTipRoot)
								gohelper.setActive(freeTipRoot, true)

								txttips.text = havefree10Count and luaLang("havefree10Count") or luaLang("p_summon_timelimit_flag_free")
							else
								gohelper.setActive(freeTipRoot, false)
							end
						end
					end
				end
			end
		end
	end
end

SummonMainCategoryItem.Tips_Selected_StartY = 45
SummonMainCategoryItem.Tips_NoSelected_StartY = 35
SummonMainCategoryItem.Tips_IntervalY = -35

function SummonMainCategoryItem:_refreshTipsPosition(isSelect)
	if isSelect then
		if not SummonMainCategoryItem.Tips_Selected_StartY then
			local startY = SummonMainCategoryItem.Tips_NoSelected_StartY
			local len = #self.tipsList

			for i = 1, len do
				local go = self.tipsList[i]

				recthelper.setAnchorY(go.transform, startY + SummonMainCategoryItem.Tips_IntervalY * (i - 1))

				self.tipsList[i] = nil
			end
		end
	end
end

function SummonMainCategoryItem:_refreshSpecVfx(isSelect)
	local poolCfg = self._mo.originConf

	if SummonEnum.PoolId.QuNiang == poolCfg.id then
		gohelper.setActive(self._vfxEffect5, true)
	else
		gohelper.setActive(self._vfxEffect5, false)
	end
end

function SummonMainCategoryItem:getData()
	return self._mo
end

function SummonMainCategoryItem:cleanData()
	self._mo = nil
end

function SummonMainCategoryItem:_refreshMask()
	if not self._goSelectImageMask then
		return
	end

	local poolCfg = self._mo.originConf
	local maskParam = string.split(poolCfg.maskColor, "|")
	local maskColor = self._goSelectImageMask.color

	if not maskParam[1] then
		maskColor = GameUtil.parseColor(maskParam[1])
		maskColor.a = maskParam[2] and tonumber(maskParam[2]) or 1
		self._goSelectImageMask.color = maskColor
	end
end

function SummonMainCategoryItem:_refreshName()
	local poolCfg = self._mo.originConf

	if self:_isWithoutTxt(poolCfg.id) then
		self._txtnameselect.text = ""
		self._txtname.text = ""
		self._txtnameen.text = ""
		self._txtnameenselect.text = ""
	else
		self._txtnameselect.text = poolCfg.nameCn
		self._txtname.text = poolCfg.nameCn
		self._txtnameen.text = poolCfg.ornamentName or ""
		self._txtnameenselect.text = poolCfg.ornamentName or ""

		local nameUnderlayColor = poolCfg.nameUnderlayColor
		local underlayColor
		local nameCnColorStr = "#FFFFFF"
		local nameCnAlpha = 1

		if not string.nilorempty(nameUnderlayColor) then
			local strList = string.split(nameUnderlayColor, "|")

			underlayColor = GameUtil.parseColor(strList[1] or "#000000")
			underlayColor.a = tonumber(strList[2]) or 0
			nameCnColorStr = strList[3] or "#FFFFFF"
			nameCnAlpha = tonumber(strList[4]) or 1
		end

		self:_addUnderlayColor(self._txtnameselect, underlayColor)
		self:_addUnderlayColor(self._txtname, underlayColor)
		self:_addNameCnColor(self._txtnameselect, nameCnColorStr, nameCnAlpha)
		self:_addNameCnColor(self._txtname, nameCnColorStr, nameCnAlpha)
	end
end

function SummonMainCategoryItem:_refreshBannerLine()
	local poolCfg = self._mo.originConf

	if not self:_isWithoutTxt(poolCfg.id) then
		local bannerLineName = poolCfg.bannerLineName

		if not string.nilorempty(bannerLineName) then
			self._simageline:LoadImage(ResUrl.getSummonBannerLine(bannerLineName))
		else
			self._simageline:UnLoadImage()
		end
	end
end

function SummonMainCategoryItem:_addUnderlayColor(txtCmp, csColor)
	if not txtCmp then
		return
	end

	local mat = txtCmp.fontMaterial

	if not mat then
		return
	end

	if not csColor then
		mat:DisableKeyword("UNDERLAY_ON")

		return
	end

	mat:EnableKeyword("UNDERLAY_ON")
	mat:SetColor("_UnderlayColor", csColor)
	mat:SetFloat("_UnderlayOffsetX", 0)
	mat:SetFloat("_UnderlayOffsetY", 0)
	mat:SetFloat("_UnderlayDilate", 0.3)
	mat:SetFloat("_UnderlaySoftness", 1)
end

function SummonMainCategoryItem:_addNameCnColor(txtCmp, colorStr, alpha)
	if not txtCmp then
		return
	end

	SLFramework.UGUI.GuiHelper.SetColor(txtCmp, colorStr)
	ZProj.UGUIHelper.SetColorAlpha(txtCmp, alpha)
end

function SummonMainCategoryItem:_isWithoutTxt(id)
	return kPoolIdWithoutTxtDict[id]
end

function SummonMainCategoryItem:_refreshSelected_local()
	if not self._mo then
		return
	end

	local poolCfg = self._mo.originConf
	local isSelect = SummonMainModel.instance:getCurId() == poolCfg.id

	self._goSelected:SetActive(isSelect)
	self._goUnselected:SetActive(not isSelect)

	if not string.nilorempty(poolCfg.banner) then
		local bannerPath = poolCfg.banner
		local bannerIconPath = ResUrl.getSummonBanner(bannerPath)

		self._simageiconnormal:LoadImage(bannerIconPath)
		self._simageiconselect:LoadImage(bannerIconPath)
		self._simageiconnormalmask:LoadImage(bannerIconPath)
	end
end

function SummonMainCategoryItem:_refreshSelected()
	self:_refreshSelected_local()
end

return SummonMainCategoryItem
