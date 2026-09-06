-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/view/PkcreateroomView.lua

module("logic.extensions.pk.view.PkcreateroomView", package.seeall)

local PkcreateroomView = class("PkcreateroomView", ViewComponent)

PkcreateroomView.PlayType = {
	PVP = 1,
	PVE = 2,
	BREAK = 3
}

function PkcreateroomView:ctor()
	PkcreateroomView.super.ctor(self)
end

function PkcreateroomView:unbindEvents()
	PkcreateroomView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnModepvp:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnCommonAttr:RemoveClickListener()
	self._btnModepve:RemoveClickListener()
	self._btnRoomState:RemoveClickListener()
	self._btnChangeName:RemoveClickListener()
	self._btnTxtPetPower:RemoveClickListener()
	self._btnModebreak:RemoveClickListener()
end

function PkcreateroomView:bindEvents()
	PkcreateroomView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnModepvp:AddClickListener(self._onClickbtnModepvp, self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnCommonAttr:AddClickListener(self._onClickbtnCommonAttr, self)
	self._btnModepve:AddClickListener(self._onClickbtnModepve, self)
	self._btnRoomState:AddClickListener(self._onClickbtnRoomState, self)
	self._btnChangeName:AddClickListener(self._onClickbtnChangeName, self)
	self._btnTxtPetPower:AddClickListener(self._onClicktxtPetPower, self)
	self._btnModebreak:AddClickListener(self._onClickbtnModebreak, self)
end

function PkcreateroomView:buildUI()
	PkcreateroomView.super.buildUI(self)

	self._btnClose = self:getBtn("viewnode/btnClose")
	self._btnModepvp = self:getBtn("childnode/mode/btnModepvp")
	self._btnSure = self:getBtn("viewnode/btnSure")
	self._btnCommonAttr = self:getBtn("childnode/pvp/btnCommonAttr")
	self._btnModepve = self:getBtn("childnode/mode/btnModepve")
	self._btnRoomState = self:getBtn("childnode/mode/btnRoomState")
	self._btnChangeName = self:getBtn("childnode/pvp/btnChangeName")
	self._modepveselectGo = self:getGo("childnode/mode/btnModepve/select")
	self._modepvpselectGo = self:getGo("childnode/mode/btnModepvp/select")
	self._modebreakselectGo = self:getGo("childnode/mode/btnModebreak/select")
	self._roomstateselectOnGo = self:getGo("childnode/mode/btnRoomState/on")
	self._roomstateselectOffGo = self:getGo("childnode/mode/btnRoomState/off")
	self._commonattrselectOnGo = self:getGo("childnode/pvp/btnCommonAttr/on")
	self._commonattrselectOffGo = self:getGo("childnode/pvp/btnCommonAttr/off")
	self._pveGo = self:getGo("childnode/pve")
	self._pvpGo = self:getGo("childnode/pvp")
	self._txtPetPower = self:getTxt("childnode/pve/txtPetPower")
	self._txtMyPower = self:getTxt("childnode/pvp/txtMyPower")
	self._btnTxtPetPower = self:getBtn("childnode/pve/txtPetPower")
	self._txtRoomName = self:getTxt("childnode/pvp/txtRoomName")
	self._txtPetTotalPower = self:getTxt("childnode/pve/txtPetTotalPower")
	self._btnModebreak = self:getBtn("childnode/mode/btnModebreak")
	self._breakGo = self:getGo("childnode/break")
	self._txtMyPowerBreak = self:getTxt("childnode/break/txtMyPower")
	self._txtBreakDesc = self:getTxt("childnode/break/txtBreakDesc")
end

function PkcreateroomView:onExit()
	PkcreateroomView.super.onExit(self)
end

function PkcreateroomView:onEnter()
	PkcreateroomView.super.onEnter(self)

	self._playType = PkcreateroomView.PlayType.PVP
	self._roomOpenState = true
	self._isOpenCommonAttrState = true
	self._minPerPetPower = TraincampqiecuoConfig.instance:getPVEFormationMinPower()
	self._maxPerPetPower = TraincampqiecuoConfig.instance:getPVEFormationMaxPower()
	self._perPetPower = self._minPerPetPower

	self:_updateUI()
end

function PkcreateroomView:_onClickbtnClose()
	self:close()
end

function PkcreateroomView:_onClickbtnModepvp()
	self._playType = PkcreateroomView.PlayType.PVP

	self:_updateUI()
end

function PkcreateroomView:_onClickbtnModepve()
	self._playType = PkcreateroomView.PlayType.PVE
	self._roomOpenState = false

	self:_updateUI()
end

function PkcreateroomView:_onClickbtnModebreak()
	self._playType = PkcreateroomView.PlayType.BREAK
	self._roomOpenState = false

	self:_updateUI()
end

function PkcreateroomView:_onClickbtnSure()
	local isPVP = self:_isPVP()
	local isPVE = self:_isPVE()
	local isBreak = self:_isBreak()

	if self:_isPVP() then
		TraincampqiecuoController.instance:sendPM_TC_CreateTeamReq(self._roomNameId, not self._roomOpenState, self._isOpenCommonAttrState)
	elseif isPVE then
		local power = self:_getModPower()

		TraincampqiecuoController.instance:enterPVE(power)
	elseif isBreak then
		TraincampdefenseController.instance:openListView()
	end

	self:close()
end

function PkcreateroomView:_onClickbtnCommonAttr()
	self._isOpenCommonAttrState = not self._isOpenCommonAttrState

	self:_updatePVP()
end

function PkcreateroomView:_onClickbtnRoomState()
	local isPVP = self:_isPVP()

	if not isPVP then
		FloatWordMgr.instance:show("该模式下房间不可公开")

		return
	end

	self._roomOpenState = not self._roomOpenState

	self:_setRoomState()
end

function PkcreateroomView:_onClickbtnChangeName()
	self._roomNameId = TraincampqiecuoConfig.instance:getRandomNameId()

	self:_setRoomName()
end

function PkcreateroomView:_onClicktxtPetPower()
	UIStateManager.instance:push(ViewName.PksetenemypowerView, self._perPetPower, function(power)
		self._perPetPower = power

		self:_setPetPower()
	end, self._minPerPetPower, self._maxPerPetPower)
end

function PkcreateroomView:_updateUI()
	local isPVP = self:_isPVP()
	local isPVE = self:_isPVE()
	local isBreak = self:_isBreak()

	if isPVP then
		self:_updatePVP()
	elseif isPVE then
		self:_updatePVE()
	elseif isBreak then
		self:_updateBreak()
	end

	self:_setRoomState()
	self:_setPlayMode()
	self:_setRoomName()
end

function PkcreateroomView:_isPVP()
	return self._playType == PkcreateroomView.PlayType.PVP
end

function PkcreateroomView:_isPVE()
	return self._playType == PkcreateroomView.PlayType.PVE
end

function PkcreateroomView:_isBreak()
	return self._playType == PkcreateroomView.PlayType.BREAK
end

function PkcreateroomView:_updatePVP()
	self:_setCommonAttrState()

	self._txtMyPower.text = RoleModel.instance:getMaxPower()
end

function PkcreateroomView:_updatePVE()
	self._roomOpenState = false

	self:_setRoomState()
	self:_setPetPower()
end

function PkcreateroomView:_updateBreak()
	self._txtMyPowerBreak.text = RoleModel.instance:getMaxPower()
	self._txtBreakDesc.text = lang("自选切磋模式下玩家需要先设置自己的守阵，方可在守阵列表中找到与自己战力差距较大或相近的玩家守阵列表；可自行选择挑战的玩家对其发起进攻")
end

function PkcreateroomView:_setRoomState()
	goutil.setActive(self._roomstateselectOnGo, self._roomOpenState)
	goutil.setActive(self._roomstateselectOffGo, not self._roomOpenState)
end

function PkcreateroomView:_setPlayMode()
	local isPVP = self:_isPVP()
	local isPVE = self:_isPVE()
	local isBreak = self:_isBreak()

	goutil.setActive(self._modepvpselectGo, isPVP)
	goutil.setActive(self._modepveselectGo, isPVE)
	goutil.setActive(self._modebreakselectGo, isBreak)
	goutil.setActive(self._pvpGo, isPVP)
	goutil.setActive(self._pveGo, isPVE)
	goutil.setActive(self._breakGo, isBreak)
end

function PkcreateroomView:_setPetPower()
	local power = self:_getModPower()

	self._txtPetPower.text = string.format("%sW", power / 10000)
	self._txtPetTotalPower.text = string.format("%sW", power * 6 / 10000)
end

function PkcreateroomView:_getModPower()
	return math.ceil(self._perPetPower / 10000) * 10000
end

function PkcreateroomView:_setCommonAttrState()
	goutil.setActive(self._commonattrselectOnGo, self._isOpenCommonAttrState)
	goutil.setActive(self._commonattrselectOffGo, not self._isOpenCommonAttrState)
end

function PkcreateroomView:_setRoomName()
	self._roomNameId = self._roomNameId or TraincampqiecuoConfig.instance:getRandomNameId()

	local cfg = TraincampqiecuoConfig.instance:getRoomNameCfg(self._roomNameId)

	self._txtRoomName.text = cfg.name
end

return PkcreateroomView
