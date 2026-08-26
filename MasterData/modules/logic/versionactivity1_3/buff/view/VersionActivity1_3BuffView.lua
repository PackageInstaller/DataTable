-- chunkname: @modules/logic/versionactivity1_3/buff/view/VersionActivity1_3BuffView.lua

module("modules.logic.versionactivity1_3.buff.view.VersionActivity1_3BuffView", package.seeall)

local VersionActivity1_3BuffView = class("VersionActivity1_3BuffView", BaseView)

function VersionActivity1_3BuffView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtDesc = gohelper.findChildText(self.viewGO, "Left/Desc/image_DescBG/#txt_Desc")
	self._simageWhiteCirclePath = gohelper.findChildSingleImage(self.viewGO, "Path/#simage_WhiteCirclePath")
	self._simageMainPath = gohelper.findChildSingleImage(self.viewGO, "Path/#simage_MainPath")
	self._simageBranchPath1 = gohelper.findChildSingleImage(self.viewGO, "Path/#simage_BranchPath1")
	self._simageBranchPath2 = gohelper.findChildSingleImage(self.viewGO, "Path/#simage_BranchPath2")
	self._gopath101 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path101")
	self._gopath102 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path102")
	self._gopath103 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path103")
	self._gopath104 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path104")
	self._gopath105 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path105")
	self._gopath201 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path201")
	self._gopath202 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path202")
	self._gopath203 = gohelper.findChild(self.viewGO, "Path/LightPath/#go_path203")
	self._simagePropIcon = gohelper.findChildSingleImage(self.viewGO, "Path/Prop/#simage_PropIcon")
	self._goBuff101 = gohelper.findChild(self.viewGO, "Path/#go_Buff101")
	self._goBuff102 = gohelper.findChild(self.viewGO, "Path/#go_Buff102")
	self._goBuff103 = gohelper.findChild(self.viewGO, "Path/#go_Buff103")
	self._goBuff104 = gohelper.findChild(self.viewGO, "Path/#go_Buff104")
	self._goBuff105 = gohelper.findChild(self.viewGO, "Path/#go_Buff105")
	self._goBuff201 = gohelper.findChild(self.viewGO, "Path/#go_Buff201")
	self._goBuff202 = gohelper.findChild(self.viewGO, "Path/#go_Buff202")
	self._goBuff203 = gohelper.findChild(self.viewGO, "Path/#go_Buff203")
	self._goBackBtns = gohelper.findChild(self.viewGO, "#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_3BuffView:addEvents()
	return
end

function VersionActivity1_3BuffView:removeEvents()
	return
end

function VersionActivity1_3BuffView:_editableInitView()
	self._simageFullBG:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_fullbg"))
	self._simageWhiteCirclePath:LoadImage(ResUrl.getActivity1_3BuffIcon("v1a3_buffview_whitecirclepath"))

	local _, iconPath = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Currency, Activity126Enum.buffCurrencyId)

	if not string.nilorempty(iconPath) then
		self._simagePropIcon:LoadImage(iconPath)
	end

	self:_addAllBuff()
end

function VersionActivity1_3BuffView:onOpen()
	self.addEventCb(self, Activity126Controller.instance, Activity126Event.onUnlockBuffReply, self._onUnlockBuffReply, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_sky_open)
end

function VersionActivity1_3BuffView:_onCurrencyChange()
	for i, buffItem in ipairs(self._buffList) do
		buffItem:updateStatus()
	end
end

function VersionActivity1_3BuffView:_onUnlockBuffReply()
	for i, v in ipairs(self._buffList) do
		v:onUnlockBuffReply()
	end
end

function VersionActivity1_3BuffView:_addAllBuff()
	self._buffList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes[1]

	for i, v in ipairs(lua_activity126_buff.configList) do
		local buffId = v.id
		local go = self["_goBuff" .. buffId]
		local pathGo = self["_gopath" .. buffId]
		local itemGO = self:getResInst(path, go)

		self._buffList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, VersionActivity1_3BuffItem, {
			v,
			pathGo
		})
	end
end

function VersionActivity1_3BuffView:onClose()
	return
end

function VersionActivity1_3BuffView:onDestroyView()
	self._simageFullBG:UnLoadImage()
	self._simageWhiteCirclePath:UnLoadImage()
end

return VersionActivity1_3BuffView
