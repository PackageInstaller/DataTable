-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegetipInBattleView.lua

module("logic.extensions.petcollege.view.PetcollegetipInBattleView", package.seeall)

local PetcollegetipInBattleView = class("PetcollegetipInBattleView", ViewComponent)

function PetcollegetipInBattleView:ctor()
	PetcollegetipInBattleView.super.ctor(self)
end

function PetcollegetipInBattleView:destroyUI()
	PetcollegetipInBattleView.super.destroyUI(self)
end

function PetcollegetipInBattleView:onExitFinished()
	PetcollegetipInBattleView.super.onExitFinished(self)
end

function PetcollegetipInBattleView:onEnterFinished()
	PetcollegetipInBattleView.super.onEnterFinished(self)
end

function PetcollegetipInBattleView:unbindEvents()
	PetcollegetipInBattleView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetcollegetipInBattleView:bindEvents()
	PetcollegetipInBattleView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function PetcollegetipInBattleView:onExit()
	PetcollegetipInBattleView.super.onExit(self)
	uGuiUtil.clearImage(self._imgRoleGo)
	BattleController.instance:setBattlePause(false)
	removetimer(self.close, self)
	GuideController.instance:finishGuide()
end

function PetcollegetipInBattleView:buildUI()
	PetcollegetipInBattleView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtContent = goutil.findChildTextComponent(self.mainGO, "ScrollView/Viewport/Content")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._trContent = self:getGo("ScrollView/Viewport/Content").transform
	self._imgRoleGo = self:getGo("imgRole")
end

function PetcollegetipInBattleView:onEnter()
	PetcollegetipInBattleView.super.onEnter(self)
	BattleController.instance:setBattlePause(true)

	local guide = self:getFirstParam()

	if guide then
		self:_doWithParams(guide)
	end
end

function PetcollegetipInBattleView:_doWithParams(guide)
	GameUtil.SetActive(self._recordBtn, false)

	if guide then
		local param = guide:getJsonParams()
		local arr = param.college
		local challengeId = checknumber(arr[1])
		local stageId = checknumber(arr[2])

		self._txtContent.text = guide.guide.dialogue
		self._txtTitle.text = param.collegeName

		uGuiUtil.setSpriteToImage(self._imgRoleGo, nil, GameUrl.getBigbgFolderUrl("petcollegetip", challengeId < 10 and "board_jlsy_0" .. challengeId or "board_jlsy_" .. challengeId))

		local autoNextTime = param.autoNextTime

		if autoNextTime and checknumber(autoNextTime) > 0 then
			settimer(checknumber(autoNextTime), self.close, self, false)
		end
	end
end

function PetcollegetipInBattleView:_onClickClose()
	self:close()
end

return PetcollegetipInBattleView
