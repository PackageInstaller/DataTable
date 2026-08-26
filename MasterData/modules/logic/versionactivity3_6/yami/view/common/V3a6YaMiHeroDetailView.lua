-- chunkname: @modules/logic/versionactivity3_6/yami/view/common/V3a6YaMiHeroDetailView.lua

module("modules.logic.versionactivity3_6.yami.view.common.V3a6YaMiHeroDetailView", package.seeall)

local V3a6YaMiHeroDetailView = class("V3a6YaMiHeroDetailView", BaseView)

function V3a6YaMiHeroDetailView:onInitView()
	self._goemploy = gohelper.findChild(self.viewGO, "root/#go_employ")
	self._simagechessicon = gohelper.findChildSingleImage(self.viewGO, "root/#go_employ/#simage_chessicon")
	self._txtname = gohelper.findChildText(self.viewGO, "root/#go_employ/#txt_name")
	self._txtskilldesc = gohelper.findChildText(self.viewGO, "root/#go_employ/scroll_skilldesc/viewport/content/#txt_skilldesc")
	self._txtnoskill = gohelper.findChildText(self.viewGO, "root/#go_employ/scroll_skilldesc/viewport/content/#txt_noskill")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._btnhirenotenough = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_lock/#btn_hirenotenough")
	self._txtfunding1 = gohelper.findChildText(self.viewGO, "root/#go_lock/#btn_hirenotenough/#txt_funding")
	self._txtlock = gohelper.findChildText(self.viewGO, "root/#go_lock/#btn_hirenotenough/#txt_lock")
	self._btnhirenormal = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_lock/#btn_hirenormal")
	self._txtfunding2 = gohelper.findChildText(self.viewGO, "root/#go_lock/#btn_hirenormal/#txt_funding")
	self._goempty = gohelper.findChild(self.viewGO, "root/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiHeroDetailView:addEvents()
	self._btnhirenotenough:AddClickListener(self._btnhirenotenoughOnClick, self)
	self._btnhirenormal:AddClickListener(self._btnhirenormalOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroDetailView:removeEvents()
	self._btnhirenotenough:RemoveClickListener()
	self._btnhirenormal:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroDetailView:_btnhirenotenoughOnClick()
	local isCanUnlock, toast = self.mo:isCanUnlock()

	if not isCanUnlock then
		GameFacade.showToast(toast)
	end
end

function V3a6YaMiHeroDetailView:_btnhirenormalOnClick()
	local isCanUnlock, toast = self.mo:isCanUnlock()

	if not isCanUnlock then
		GameFacade.showToast(toast)
	end

	V3a6YaMiRpc.instance:sendAct231BuyResearcherRequest(self.mo.id)
end

function V3a6YaMiHeroDetailView:_onUnlockHero(heroIds)
	self:_refreshLock()
end

function V3a6YaMiHeroDetailView:_editableInitView()
	self._godescroot = gohelper.findChild(self.viewGO, "root/#go_employ/scroll_skilldesc")
	self._descItems = self:getUserDataTb_()

	gohelper.setActive(self.viewGO, false)

	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._goemploy, V3a6YaMiAttrPanel)
end

function V3a6YaMiHeroDetailView:onUpdateParam()
	return
end

function V3a6YaMiHeroDetailView:onOpen()
	return
end

function V3a6YaMiHeroDetailView:refreshDetail(mo)
	self.mo = mo

	gohelper.setActive(self.viewGO, true)
	gohelper.setActive(self._goempty.gameObject, mo == nil)
	gohelper.setActive(self._golock.gameObject, mo ~= nil)
	gohelper.setActive(self._goemploy.gameObject, mo ~= nil)

	if not self.mo then
		return
	end

	self._attrPanel:onRefresh(mo:getAttrMo(), true)

	self._txtname.text = mo.co.name
	self._txtname.color = GameUtil.parseColor(mo:getNameColor())

	self:_refreshLock()

	local icon = ResUrl.getV3a6YaMiHeroHandbookSingleBg(mo.co.icon)

	self._simagechessicon:LoadImage(icon)
	self:_refreshSkill(mo)
	self:showUnlockBtn()
end

function V3a6YaMiHeroDetailView:showUnlockBtn()
	local isCanUnlock, toast = self.mo:isCanUnlock()
	local isForceHideBtn = false

	if self.viewContainer and self.viewContainer.isForceHideUnlockBtn then
		isForceHideBtn = self.viewContainer:isForceHideUnlockBtn()
	end

	if not self.mo.co.cost then
		local cost = 0

		if not isForceHideBtn then
			if isCanUnlock then
				self._txtfunding2.text = self.mo.co.cost
			else
				local curCost = V3a6YaMiModel.instance:getCurSelectMaterialCost()
				local isEnoughCurrency = V3a6YaMiModel.instance:isEnoughCurrency(cost + curCost)
				local color = isEnoughCurrency and "#C6C5C5" or "#C36363"

				self._txtfunding1.color = GameUtil.parseColor(color)
				self._txtfunding1.text = cost

				local _, level, _ = V3a6YaMiModel.instance:getLevelExp()
				local unlockLevel = self.mo:getUnlockLevel()
				local isShowLockLevel = level < unlockLevel

				if isShowLockLevel then
					local lang = luaLang("v3a6_yami_material_unlock")

					self._txtlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, unlockLevel)
				end

				gohelper.setActive(self._txtlock.gameObject, isShowLockLevel)
				gohelper.setActive(self._txtfunding1.gameObject, not isShowLockLevel and not isEnoughCurrency)
			end
		end

		gohelper.setActive(self._btnhirenotenough.gameObject, not isForceHideBtn and not isCanUnlock)
		gohelper.setActive(self._btnhirenormal.gameObject, not isForceHideBtn and isCanUnlock)
	end
end

function V3a6YaMiHeroDetailView:_refreshSkill(heroMo)
	local count = 0

	if heroMo and not string.nilorempty(heroMo.co.skillIds) then
		local skillIds = string.splitToNumber(heroMo.co.skillIds)

		for i, id in ipairs(skillIds) do
			local co = V3a6YaMiConfig.instance:getSkillCo(id)
			local item = self:_getDescItem(i)

			item.txt.text = co.desc
			count = count + 1
		end
	end

	for i = 1, #self._descItems do
		gohelper.setActive(self._descItems[i].go, i <= count)
	end

	gohelper.setActive(self._txtnoskill.gameObject, count == 0)
end

function V3a6YaMiHeroDetailView:_getDescItem(index)
	local item = self._descItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._txtskilldesc.gameObject)

		item = self:getUserDataTb_()
		item.go = go
		item.txt = go:GetComponent(gohelper.Type_TextMesh)
		self._descItems[index] = item
	end

	return item
end

function V3a6YaMiHeroDetailView:_refreshLock()
	if self.mo then
		gohelper.setActive(self._golock.gameObject, self.mo)
		recthelper.setHeight(self._godescroot.transform, self.mo and 250 or 400)
	end
end

function V3a6YaMiHeroDetailView:onClose()
	return
end

function V3a6YaMiHeroDetailView:onDestroyView()
	self._simagechessicon:UnLoadImage()
end

return V3a6YaMiHeroDetailView
