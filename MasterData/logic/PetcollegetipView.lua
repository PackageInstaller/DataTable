-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegetipView.lua

module("logic.extensions.petcollege.view.PetcollegetipView", package.seeall)

local PetcollegetipView = class("PetcollegetipView", ViewComponent)

function PetcollegetipView:ctor()
	PetcollegetipView.super.ctor(self)
end

function PetcollegetipView:destroyUI()
	PetcollegetipView.super.destroyUI(self)
end

function PetcollegetipView:onExitFinished()
	PetcollegetipView.super.onExitFinished(self)
end

function PetcollegetipView:onEnterFinished()
	PetcollegetipView.super.onEnterFinished(self)
end

function PetcollegetipView:unbindEvents()
	PetcollegetipView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetcollegetipView:bindEvents()
	PetcollegetipView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetcollegetipView:onExit()
	PetcollegetipView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRoleGo)
end

function PetcollegetipView:buildUI()
	PetcollegetipView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "ScrollView/Viewport/Content")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._trContent = self:getGo("ScrollView/Viewport/Content").transform
	self._imgRoleGo = self:getGo("imgRole")
end

function PetcollegetipView:onEnter()
	PetcollegetipView.super.onEnter(self)

	local param = self:getOpenParam()

	self:_doWithParams(param)
end

function PetcollegetipView:_doWithParams(param)
	GameUtil.SetActive(self._recordBtn, false)

	local challengeId = param[1]
	local stageId = param[2]
	local cfg = PetCollegeConfig.instance:getTeamCfgByStage(challengeId, stageId)

	self._txtContent.text = cfg.description
	self._txtTitle.text = cfg.name

	local resName = PetCollegeConfig.instance:getStageCfgByStageId(challengeId, stageId).SpritesName

	uGuiUtil.setSpriteToImage(self._imgRoleGo, nil, GameUrl.getBigbgFolderUrl("petcollegetip", resName))
end

function PetcollegetipView:_onClickClose()
	self:close()
end

return PetcollegetipView
