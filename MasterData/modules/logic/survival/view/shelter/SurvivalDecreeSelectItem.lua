-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeSelectItem.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeSelectItem", package.seeall)

local SurvivalDecreeSelectItem = class("SurvivalDecreeSelectItem", ListScrollCellExtend)

function SurvivalDecreeSelectItem:onInitView()
	self.btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Add")
	self.imageIcon = gohelper.findChildImage(self.viewGO, "Left/image_Icon1")
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "#scroll_Descr/Viewport/Content/goItem/#go_1/#txt_Title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_Descr/Viewport/Content/goItem/#go_1/#txt_Descr")
end

function SurvivalDecreeSelectItem:addEvents()
	self.addClickCb(self, self.btnAdd, self.onClickAdd, self)
end

function SurvivalDecreeSelectItem:removeEvents()
	self:removeClickCb(self.btnAdd)
end

function SurvivalDecreeSelectItem:onClickAdd()
	GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalDecreeSelectTip, MsgBoxEnum.BoxType.Yes_No, self._onSelect, nil, nil, self)
end

function SurvivalDecreeSelectItem:_onSelect()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local panelMo = weekInfo.panel

	if not panelMo then
		self:_closeThis()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalPanelOperationRequest(panelMo.uid, tostring(self.policyIndex - 1), self._closeThis, self)
end

function SurvivalDecreeSelectItem:_closeThis()
	GameFacade.showToastString(GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalDecreeSelectView_1"), {
		self.mo.name
	}))
	ViewMgr.instance:closeView(ViewName.SurvivalDecreeSelectView)
end

function SurvivalDecreeSelectItem:updateItem(index, decreeId)
	self.policyIndex = index

	local decreeCo = lua_survival_decree.configDict[decreeId]

	self:onUpdateMO(decreeCo)
end

function SurvivalDecreeSelectItem:onUpdateMO(mo)
	self.mo = mo

	UISpriteSetMgr.instance:setSurvivalSprite(self.imageIcon, mo.icon, true)

	self.txtTitle.text = mo.name
	self.txtDesc.text = mo.desc
end

return SurvivalDecreeSelectItem
