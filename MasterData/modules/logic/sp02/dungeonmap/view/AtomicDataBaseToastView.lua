-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDataBaseToastView.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDataBaseToastView", package.seeall)

local AtomicDataBaseToastView = class("AtomicDataBaseToastView", BaseView)

function AtomicDataBaseToastView:onInitView()
	self._btnfullClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullClose")
	self._simagepicture = gohelper.findChildSingleImage(self.viewGO, "Root/Mask/#simage_picture")
	self._txtName = gohelper.findChildText(self.viewGO, "Root/NameBG/#txt_Name")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._goTips = gohelper.findChild(self.viewGO, "Root/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "Root/#go_Tips/#txt_Tips")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicDataBaseToastView:addEvents()
	self._btnfullClose:AddClickListener(self._btnfullCloseOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AtomicDataBaseToastView:removeEvents()
	self._btnfullClose:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function AtomicDataBaseToastView:_btnfullCloseOnClick()
	self:closeThis()
end

function AtomicDataBaseToastView:_btnCloseOnClick()
	self:closeThis()
end

function AtomicDataBaseToastView:_editableInitView()
	return
end

function AtomicDataBaseToastView:onUpdateParam()
	return
end

function AtomicDataBaseToastView:onOpen()
	self.dataBaseId = self.viewParam.dataBaseId
	self.dataBaseCo = AtomicConfig.instance:getLibraryConfig(self.dataBaseId)

	self:refreshUI()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_mln_unlock)
end

function AtomicDataBaseToastView:refreshUI()
	self._txtName.text = self.dataBaseCo.title
	self._txtDescr.text = self.dataBaseCo.content

	self._simagepicture:LoadImage(ResUrl.getAtomicForyouSingleBg(self.dataBaseCo.detail))
end

function AtomicDataBaseToastView:onClose()
	AtomicDungeonModel.instance:cleanNewUnlockDataBaseList()
	AtomicDungeonController.instance:dispatchEvent(AtomicDungeonEvent.OnCloseDataBaseToast, self.dataBaseId)
end

function AtomicDataBaseToastView:onDestroyView()
	self._simagepicture:UnLoadImage()
end

return AtomicDataBaseToastView
