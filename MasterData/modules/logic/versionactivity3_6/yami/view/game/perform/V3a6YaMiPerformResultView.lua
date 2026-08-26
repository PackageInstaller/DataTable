-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/perform/V3a6YaMiPerformResultView.lua

module("modules.logic.versionactivity3_6.yami.view.game.perform.V3a6YaMiPerformResultView", package.seeall)

local V3a6YaMiPerformResultView = class("V3a6YaMiPerformResultView", BaseView)

function V3a6YaMiPerformResultView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root/bottom_expand")
	self._goProgressbar1 = gohelper.findChildImage(self.viewGO, "root/bottom_expand/schedule/#go_Progressbar1")
	self._goProgressbar2 = gohelper.findChildImage(self.viewGO, "root/bottom_expand/schedule/#go_Progressbar2")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/bottom_expand/schedule/txt_schedule/#txt_num")
	self._simagecurrentproducts = gohelper.findChildSingleImage(self.viewGO, "root/bottom_expand/Att/#simage_currentproducts")
	self._simageprop1 = gohelper.findChildSingleImage(self.viewGO, "root/bottom_expand/recipe/#simage_prop1")
	self._gomaterialroot = gohelper.findChild(self.viewGO, "root/bottom_expand/recipe/layout")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom_expand/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiPerformResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
end

function V3a6YaMiPerformResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onFinishPerform, self._onFinishPerform, self)
end

function V3a6YaMiPerformResultView:_btncloseOnClick()
	V3a6YaMiController.instance:openV3a6YaMiEvaluationView()
	self:closeThis()
end

function V3a6YaMiPerformResultView:_editableInitView()
	gohelper.setActive(self._goroot, false)

	self._materialItems = self:getUserDataTb_()
	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._goroot, V3a6YaMiAttrPanel)
end

function V3a6YaMiPerformResultView:onUpdateParam()
	return
end

function V3a6YaMiPerformResultView:onOpen()
	self._goProgressbar1.fillAmount = 1
	self._goProgressbar2.fillAmount = 1

	local lang = luaLang("v3a6_yami_percent")

	self._txtnum.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, 100)
end

function V3a6YaMiPerformResultView:_onFinishPerform()
	self:_refreshMaterials()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_win)
	gohelper.setActive(self._goroot, true)

	if ViewMgr.instance:isOpen(ViewName.V3a6YaMiSkillView) then
		ViewMgr.instance:closeView(ViewName.V3a6YaMiSkillView)
	end
end

function V3a6YaMiPerformResultView:_refreshMaterials()
	local count = 0
	local productMo = V3a6YaMiModel.instance:getSelfProductMo()

	if productMo then
		local materials = productMo.materials
		local subType = productMo.subType

		if subType then
			local co = V3a6YaMiConfig.instance:getMaterialCo(subType)

			if co then
				local icon = ResUrl.getV3a6YaMiCollectionSingleBg(co.icon)

				self._simageprop1:LoadImage(icon)
			else
				logError("找不到材料配置：" .. subType)
			end
		end

		for i, id in ipairs(materials) do
			local item = self:_getMaterialItem(i)
			local co = V3a6YaMiConfig.instance:getMaterialCo(id)
			local icon = ResUrl.getV3a6YaMiCollectionSingleBg(co.icon)

			item.simgIcon:LoadImage(icon)

			count = count + 1
		end

		self._attrPanel:onRefresh(productMo:getAttrMo(), false)

		local icon = ResUrl.getV3a6YaMiItemSingleBg(productMo.co.icon)

		self._simagecurrentproducts:LoadImage(icon)
	end

	for i = 1, #self._materialItems do
		gohelper.setActive(self._materialItems[i].go, i <= count)
	end
end

function V3a6YaMiPerformResultView:_getMaterialItem(index)
	local item = self._materialItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._simageprop1.gameObject, self._gomaterialroot)
		item.simgIcon = gohelper.findChildSingleImage(item.go, "")
		self._materialItems[index] = item
	end

	return item
end

function V3a6YaMiPerformResultView:onClose()
	return
end

function V3a6YaMiPerformResultView:onDestroyView()
	self._simagecurrentproducts:UnLoadImage()

	for _, item in ipairs(self._materialItems) do
		item.simgIcon:UnLoadImage()
	end
end

return V3a6YaMiPerformResultView
