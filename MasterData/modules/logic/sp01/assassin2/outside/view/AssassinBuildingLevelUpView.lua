-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinBuildingLevelUpView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinBuildingLevelUpView", package.seeall)

local AssassinBuildingLevelUpView = class("AssassinBuildingLevelUpView", BaseViewExtended)

function AssassinBuildingLevelUpView:onInitView()
	self._txtname = gohelper.findChildText(self.viewGO, "root/left/image_namebg/#txt_name")
	self._txtlv = gohelper.findChildText(self.viewGO, "root/left/#txt_lv")
	self._gotopright = gohelper.findChild(self.viewGO, "root/#go_topright")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._gocontent = gohelper.findChild(self.viewGO, "root/#scroll_list/Viewport/Content")
	self._golistitem = gohelper.findChild(self.viewGO, "root/#scroll_list/Viewport/Content/#go_listitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinBuildingLevelUpView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UpdateBuildingInfo, self._onUpdateBuildingInfo, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.UnlockBuildings, self._onUnlockBuildings, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnLevelUpBuilding, self._onLevelUpBuilding, self)
end

function AssassinBuildingLevelUpView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AssassinBuildingLevelUpView:_btncloseOnClick()
	self:closeThis()
end

function AssassinBuildingLevelUpView:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function AssassinBuildingLevelUpView:onUpdateParam()
	return
end

function AssassinBuildingLevelUpView:onOpen()
	AssassinBuildingLevelUpListModel.instance:markNeedPlayOpenAnimItemCount(AssassinEnum.NeedPlayOpenAnimBuildingCount)

	self._buildingType = self.viewParam and self.viewParam.buildingType

	self:openSubView(AssassinCurrencyToolView, nil, self._gotopright)
	self:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)
end

function AssassinBuildingLevelUpView:refresh()
	self._buildingMo = AssassinOutsideModel.instance:getBuildingMo(self._buildingType)
	self._config = self._buildingMo:getConfig()
	self._txtname.text = self._config.title
	self._lv = self._buildingMo:getLv()
	self._txtlv.text = AssassinHelper.formatLv(self._lv)

	self:refreshListItemList()
end

function AssassinBuildingLevelUpView:refreshListItemList()
	AssassinBuildingLevelUpListModel.instance:init(self._buildingType)

	local list = AssassinBuildingLevelUpListModel.instance:getList()

	gohelper.CreateObjList(self, self.refreshLevelUpItem, list, self._gocontent, self._golistitem, AssassinBuildingLevelUpListItem)
end

function AssassinBuildingLevelUpView:refreshLevelUpItem(itemCommp, data, index)
	itemCommp:onUpdateMO(data, index)
end

function AssassinBuildingLevelUpView:_onUpdateBuildingInfo()
	self:refresh()
end

function AssassinBuildingLevelUpView:_onUnlockBuildings()
	self:refresh()
end

function AssassinBuildingLevelUpView:_onLevelUpBuilding()
	self._animator:Play("leveup", 0, 0)
end

function AssassinBuildingLevelUpView:onClose()
	AssassinController.instance:dispatchEvent(AssassinEvent.FocusBuilding, self._buildingType, false)
end

function AssassinBuildingLevelUpView:onDestroyView()
	return
end

return AssassinBuildingLevelUpView
