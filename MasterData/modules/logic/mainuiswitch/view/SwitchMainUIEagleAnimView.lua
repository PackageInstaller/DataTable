-- chunkname: @modules/logic/mainuiswitch/view/SwitchMainUIEagleAnimView.lua

module("modules.logic.mainuiswitch.view.SwitchMainUIEagleAnimView", package.seeall)

local SwitchMainUIEagleAnimView = class("SwitchMainUIEagleAnimView", MainEagleAnimView)

function SwitchMainUIEagleAnimView:onInitView()
	SwitchMainUIEagleAnimView.super.onInitView(self)
end

function SwitchMainUIEagleAnimView:addEvents()
	self._click:AddClickListener(self._onclick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.ClickEagle, self._onclick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self.refreshUI, self)
end

function SwitchMainUIEagleAnimView:removeEvents()
	self._click:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.ClickEagle, self._onclick, self)
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.SwitchMainUI, self.refreshUI, self)
end

function SwitchMainUIEagleAnimView:refreshUI(id)
	TaskDispatcher.cancelTask(self._normalAnimFinish, self)

	id = id or MainUISwitchModel.instance:getCurUseUI()

	if self._showSkinId == id then
		return
	end

	self._showSkinId = id

	local isAnim = id and id == MainUISwitchEnum.Skin.Sp01

	gohelper.setActive(self._gospine, isAnim)

	if not isAnim then
		if self._uiSpine then
			self._loadSpine = false

			gohelper.destroy(self._uiSpine:getSpineGo())

			self._spineSkeleton = nil
		end

		if self._uiBottomSpine then
			self._loadBottomSpine = false

			gohelper.destroy(self._uiBottomSpine:getSpineGo())

			self._bottomSpineSkeleton = nil
		end

		gohelper.setActive(self._goeagleani, false)
	else
		gohelper.setActive(self._goeagleani, self._animName == MainUISwitchEnum.EagleAnim.Hover)
		self:_initBgSpine()
	end
end

function SwitchMainUIEagleAnimView:_editableInitView()
	SwitchMainUIEagleAnimView.super._editableInitView(self)

	self._btnList = self:getUserDataTb_()

	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_quest"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_storage"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_bank"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_mail"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_hide"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_switchrole"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "left_top/playerinfos/info/#btn_playerinfo"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bgm"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "limitedshow/#btn_limitedshow"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_room"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_power"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_role"))
	table.insert(self._btnList, gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_summon"))
	table.insert(self._btnList, SLFramework.UGUI.UIClickListener.Get(gohelper.findChild(self.viewGO, "#go_lightspinecontrol")))
end

function SwitchMainUIEagleAnimView:_btnMainViewOnClick()
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickMainViewBtn)
end

return SwitchMainUIEagleAnimView
