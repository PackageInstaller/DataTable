-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/FmtFeatureTipView.lua

module("logic.extensions.mission.view.FmtFeatureTipView", package.seeall)

local FmtFeatureTipView = class("FmtFeatureTipView", ViewComponent)

function FmtFeatureTipView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._txtName = self:getGo("bg/icon/name/txtName"):GetComponent(goutil.Type_UIText)
	self._petIcon1 = self:getGo("bg/icon/petIcon1")
	self._petIcon2 = self:getGo("bg/icon/petIcon2")
	self._txtDesc1 = self:getGo("bg/txtDesc1"):GetComponent(goutil.Type_UIText)
	self._txtDesc2 = self:getGo("bg/txtDesc2"):GetComponent(goutil.Type_UIText)
end

function FmtFeatureTipView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function FmtFeatureTipView:unbindEvents()
	self._closeButton:RemoveClickListener()
end

function FmtFeatureTipView:onEnter()
	local params = self:getOpenParam()
	local cfg = params[1]
	local bagPetMo1 = params[2]
	local bagPetMo2 = params[3]

	self._txtName.text = cfg.name
	self._txtDesc1.text = cfg.desc

	local awakenName = CharacterConfig.instance:getAwakenName(cfg.activeNeedAwakenLv)

	self._txtDesc2.text = langPara("handbookpetbasicview__tips", "<color=red>", awakenName, "</color>")

	MaterialMgr.setCellByData(MatType.Pet, bagPetMo1, self._petIcon1)
	MaterialMgr.setCellByData(MatType.Pet, bagPetMo2, self._petIcon2)
end

function FmtFeatureTipView:onExit()
	MaterialMgr.resetAll(self._petIcon1)
	MaterialMgr.resetAll(self._petIcon2)
end

function FmtFeatureTipView:_onClickClose()
	self:close()
end

return FmtFeatureTipView
