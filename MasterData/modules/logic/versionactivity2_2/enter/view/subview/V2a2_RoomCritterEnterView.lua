-- chunkname: @modules/logic/versionactivity2_2/enter/view/subview/V2a2_RoomCritterEnterView.lua

module("modules.logic.versionactivity2_2.enter.view.subview.V2a2_RoomCritterEnterView", package.seeall)

local V2a2_RoomCritterEnterView = class("V2a2_RoomCritterEnterView", VersionActivityEnterBaseSubView)

function V2a2_RoomCritterEnterView:onInitView()
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_start")
	self._imagereddot = gohelper.findChildImage(self.viewGO, "#btn_start/#image_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a2_RoomCritterEnterView:addEvents()
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function V2a2_RoomCritterEnterView:removeEvents()
	self._btnstart:RemoveClickListener()
end

function V2a2_RoomCritterEnterView:_btnstartOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function V2a2_RoomCritterEnterView:_editableInitView()
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/txt_dec")
	self.actId = VersionActivity2_2Enum.ActivityId.RoomCritter
	self.actCo = ActivityConfig.instance:getActivityCo(self.actId)

	if self.actCo and self._txtdesc then
		self._txtdesc.text = self.actCo.actDesc
	end
end

return V2a2_RoomCritterEnterView
