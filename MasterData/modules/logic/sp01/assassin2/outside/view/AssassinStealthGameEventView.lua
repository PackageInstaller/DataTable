-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinStealthGameEventView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEventView", package.seeall)

local AssassinStealthGameEventView = class("AssassinStealthGameEventView", BaseView)

function AssassinStealthGameEventView:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/#simage_icon")
	self._btnclick = gohelper.findChildClickWithAudio(self.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtname = gohelper.findChildText(self.viewGO, "root/name/#txt_name")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/eff/txt_desc")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinStealthGameEventView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnclick:AddClickListener(self._btnCloseOnClick, self)
end

function AssassinStealthGameEventView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function AssassinStealthGameEventView:_btnCloseOnClick()
	self:closeThis()
end

function AssassinStealthGameEventView:_editableInitView()
	self._dirGOList = self:getUserDataTb_()
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/moveDir/Dir/up/#go_upLight")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/moveDir/Dir/down/#go_downLigth")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/moveDir/Dir/left/#go_leftLight")
	self._dirGOList[#self._dirGOList + 1] = gohelper.findChild(self.viewGO, "root/moveDir/Dir/right/#go_rightLight")
end

function AssassinStealthGameEventView:onUpdateParam()
	return
end

function AssassinStealthGameEventView:onOpen()
	local eventId = AssassinStealthGameModel.instance:getEventId()
	local img = AssassinConfig.instance:getEventImg(eventId)

	if not string.nilorempty(img) then
		local imgPath = ResUrl.getSp01AssassinSingleBg("stealth/" .. img)

		self._simageicon:LoadImage(imgPath)
	end

	self._txtname.text = AssassinConfig.instance:getEventName(eventId)
	self._txtdesc.text = AssassinConfig.instance:getEventDesc(eventId)

	local moveDir = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for dir, dirGo in ipairs(self._dirGOList) do
		gohelper.setActive(dirGo, dir == moveDir)
	end

	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_openmap)
end

function AssassinStealthGameEventView:onClose()
	return
end

function AssassinStealthGameEventView:onDestroyView()
	self._simageicon:UnLoadImage()
end

return AssassinStealthGameEventView
