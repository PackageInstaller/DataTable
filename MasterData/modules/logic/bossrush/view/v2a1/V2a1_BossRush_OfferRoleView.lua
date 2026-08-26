-- chunkname: @modules/logic/bossrush/view/v2a1/V2a1_BossRush_OfferRoleView.lua

module("modules.logic.bossrush.view.v2a1.V2a1_BossRush_OfferRoleView", package.seeall)

local V2a1_BossRush_OfferRoleView = class("V2a1_BossRush_OfferRoleView", BaseView)

function V2a1_BossRush_OfferRoleView:onInitView()
	self._scrollChar = gohelper.findChildScrollRect(self.viewGO, "root/Left/#scroll_Char")
	self._scrollEffect = gohelper.findChildScrollRect(self.viewGO, "root/Right/#scroll_Effect")
	self._txtCharEffect = gohelper.findChildText(self.viewGO, "root/Right/#scroll_Effect/Viewport/Content/Title/#txt_CharEffect")
	self._txtEffect = gohelper.findChildText(self.viewGO, "root/Right/#scroll_Effect/Viewport/Content/#txt_Effect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a1_BossRush_OfferRoleView:addEvents()
	self.addEventCb(self, BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, self._OnSelectEnhanceRole, self)
end

function V2a1_BossRush_OfferRoleView:removeEvents()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.OnSelectEnhanceRole, self._OnSelectEnhanceRole, self)
end

function V2a1_BossRush_OfferRoleView:_editableInitView()
	return
end

function V2a1_BossRush_OfferRoleView:onUpdateParam()
	return
end

function V2a1_BossRush_OfferRoleView:onOpen()
	gohelper.setActive(self._txtEffect.gameObject, false)
	BossRushEnhanceRoleViewListModel.instance:setListData()
end

function V2a1_BossRush_OfferRoleView:onClose()
	return
end

function V2a1_BossRush_OfferRoleView:onDestroyView()
	return
end

function V2a1_BossRush_OfferRoleView:_OnSelectEnhanceRole(heroId)
	self:refreshEnhanceEffect(heroId)
end

function V2a1_BossRush_OfferRoleView:onClickModalMask()
	self:closeThis()
end

function V2a1_BossRush_OfferRoleView:refreshEnhanceEffect(heroId)
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local format = luaLang("bossrush_enhance_role_title")

	self._txtCharEffect.text = GameUtil.getSubPlaceholderLuaLangOneParam(format, heroConfig.name)

	local enhanceCo = BossRushConfig.instance:getActRoleEnhanceCoById(heroId)
	local desc = enhanceCo.desc

	if not string.nilorempty(desc) then
		local dataList = string.split(desc, "|")

		for i = 1, #dataList do
			local item = self:_getEffectItem(i)

			item:updateInfo(self, dataList[i], heroId)
			gohelper.setActive(self._effectList[i].viewGO, true)

			local isShowLine = i < #dataList

			item:activeLine(isShowLine)
		end

		for i = #dataList + 1, #self._effectList do
			gohelper.setActive(self._effectList[i].viewGO, false)
		end
	end
end

function V2a1_BossRush_OfferRoleView:_getEffectItem(index)
	self._effectList = self._effectList or self:getUserDataTb_()

	local item = self._effectList[index]

	if not item then
		item = V2a1_BossRush_OfferRoleEffectItem.New()

		local go = gohelper.cloneInPlace(self._txtEffect.gameObject)

		item:initView(go)

		self._effectList[index] = item
	end

	return item
end

return V2a1_BossRush_OfferRoleView
