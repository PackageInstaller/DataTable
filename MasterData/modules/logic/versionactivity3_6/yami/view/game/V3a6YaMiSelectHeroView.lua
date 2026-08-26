-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroView", package.seeall)

local V3a6YaMiSelectHeroView = class("V3a6YaMiSelectHeroView", BaseView)

function V3a6YaMiSelectHeroView:onInitView()
	self._gomission = gohelper.findChild(self.viewGO, "root/right/layout/bg_target")
	self._txtmission = gohelper.findChildText(self.viewGO, "root/right/layout/bg_target/#txt_mission")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/right/layout/bg_money/#txt_num")
	self._txttarget = gohelper.findChildText(self.viewGO, "root/right/layout/Attr/#txt_target")
	self._btnpreviousstep = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_previousstep")
	self._btnnext = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_next")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiSelectHeroView:addEvents()
	self._btnpreviousstep:AddClickListener(self._btnpreviousstepOnClick, self)
	self._btnnext:AddClickListener(self._btnnextOnClick, self)
end

function V3a6YaMiSelectHeroView:removeEvents()
	self._btnpreviousstep:RemoveClickListener()
	self._btnnext:RemoveClickListener()
end

function V3a6YaMiSelectHeroView:_btnpreviousstepOnClick()
	V3a6YaMiController.instance:openProductView()
	self:closeThis()
end

function V3a6YaMiSelectHeroView:_btnnextOnClick()
	V3a6YaMiModel.instance:saveSelectHeros()
	V3a6YaMiController.instance:onEnterNextView()
	self:closeThis()
end

function V3a6YaMiSelectHeroView:_editableInitView()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmSelectHeros, self._onConfirmSelectHeros, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self._refreshCurrncy, self)

	self._root = gohelper.findChild(self.viewGO, "root/right/layout/Attr")
	self._attrPanel = MonoHelper.addNoUpdateLuaComOnceToGo(self._root, V3a6YaMiAttrPanel)
	self._gogridroot = gohelper.findChild(self.viewGO, "root/left/#grid_v3a6_dormitorymode_employeeitem")
	self._gridItems = self:getUserDataTb_()

	local prefab = self.viewContainer:getRes(V3a6YaMiEnum.ResPath.v3a6_dormitorymode_employee_ogitem)
	local maxCount = V3a6YaMiModel.instance:getSeatCount()

	for i = 1, maxCount do
		local go = gohelper.clone(prefab, self._gogridroot)

		self._gridItems[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a6YaMiSelectHeroGridItem, i)
		self._gridItems[i].viewContainer = self.viewContainer
	end
end

function V3a6YaMiSelectHeroView:_refreshCurrncy()
	self:_refreshCost()
end

function V3a6YaMiSelectHeroView:_onConfirmSelectHeros()
	self:_refreshView(true, true)
end

function V3a6YaMiSelectHeroView:onUpdateParam()
	return
end

function V3a6YaMiSelectHeroView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)
	V3a6YaMiModel.instance:refreshSelectHeros()
	V3a6YaMiHeroHandbookListModel.instance:setHandbookList()
	V3a6YaMiModel.instance:resetHeroTeamAttrMo()
	self:_refreshView(false, false)
end

function V3a6YaMiSelectHeroView:_refreshView(isAnim, isAudio)
	local count = V3a6YaMiModel.instance:getSelectHeroCount()

	gohelper.setActive(self._btnnext.gameObject, count > 0)

	local attrMo = V3a6YaMiModel.instance:getHeroTeamAttrMo()

	for i, item in ipairs(self._gridItems) do
		item:onRefresh()
	end

	self._attrPanel:onRefresh(attrMo, false, isAnim, isAudio)
	self:_refreshMission()
	self:_refreshCost()
	gohelper.setActive(self._btnnext.gameObject, count > 0)

	local type = V3a6YaMiModel.instance:getProductAdvantage()
	local sprite = V3a6YaMiEnum.AttrInfo[type].TxtSpriteId
	local lang = luaLang("v3a6_yami_recommend_hero_attr")

	self._txttarget.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, sprite)
end

function V3a6YaMiSelectHeroView:_refreshMission()
	local missionMo = V3a6YaMiModel.instance:getCurMissionMo()

	if missionMo then
		local co = missionMo.co

		self._txtmission.text = co.desc
	end

	gohelper.setActive(self._gomission, missionMo ~= nil)
end

function V3a6YaMiSelectHeroView:_refreshCost()
	local curMoney = V3a6YaMiModel.instance:getCurrencyNum()
	local cost = V3a6YaMiModel.instance:getCurSelectMaterialCost()

	self._txtnum.text = curMoney - cost
end

function V3a6YaMiSelectHeroView:onClose()
	return
end

function V3a6YaMiSelectHeroView:onDestroyView()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onConfirmSelectHeros, self._onConfirmSelectHeros, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onRefreshCurrency, self._refreshCurrncy, self)
end

return V3a6YaMiSelectHeroView
