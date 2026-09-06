-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makingmooncake/view/MakingMoonCakeSelectView.lua

module("logic.extensions.makingmooncake.view.MakingMoonCakeSelectView", package.seeall)

local MakingMoonCakeSelectView = class("MakingMoonCakeSelectView", ViewComponent)

function MakingMoonCakeSelectView:unbindEvents()
	MakingMoonCakeSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnclose)
	GameUtil.rmClickHandler(self._btnSure)
end

function MakingMoonCakeSelectView:bindEvents()
	MakingMoonCakeSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnclose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function MakingMoonCakeSelectView:buildUI()
	MakingMoonCakeSelectView.super.buildUI(self)

	self._btnclose = self:getGo("btnclose")
	self._btnSure = self:getGo("btnSure")
	self._cell = self:getGo("cell")
	self._cells = self:getGo("cells")
end

function MakingMoonCakeSelectView:onExit()
	MakingMoonCakeSelectView.super.onExit(self)
	GlobalDispatcher:removeListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)

	for idx, cell in ipairs(self._cellList) do
		local imgCharacter = goutil.findChild(cell, "imgCharacter")

		uGuiUtil.clearImage(imgCharacter)
		GameUtil.rmClickHandler(cell)
	end
end

function MakingMoonCakeSelectView:onEnter()
	MakingMoonCakeSelectView.super.onEnter(self)
	GlobalDispatcher:addListener(MakingMoonCakeController.PM_MakingMoonCakeStartGameRes, self._handlePM_MakingMoonCakeStartGameRes, self)

	self._qPetResouces = MakingMoonCakeConfig.instance:getProgressQPetSources()
	self._hasChoosePetId = false
	self._curQPetCharacterResource = ""
	self._curSelectIdx = 0
	self._cellList = {}
	self._activityInfo = MakingMoonCakeController.instance:getActivityInfo()

	local qPetNameArr = MakingMoonCakeConfig.instance:getProgressQPetNames()

	for idx, characterResource in ipairs(self._qPetResouces) do
		local go = self:getGo("cells/cell" .. idx)

		if go == nil then
			go = goutil.cloneAndSetParent(self._cell, self._cells.transform, "cell" .. idx)
		end

		local selectGo = self:getGo("cells/cell" .. idx .. "/selectGo")
		local imgCharacter = self:getGo("cells/cell" .. idx .. "/imgCharacter")
		local txtName = self:getTxt("cells/cell" .. idx .. "/txtName")

		txtName.text = qPetNameArr and qPetNameArr[idx]

		GameUtil.SetActive(go, true)
		GameUtil.SetActive(selectGo, false)
		uGuiUtil.clearImage(imgCharacter)
		uGuiUtil.setSpriteToImage(imgCharacter, uGuiUtil.SpriteType.BigBg, "ui/bigbg/yuanxiao/" .. characterResource .. ".png")
		table.insert(self._cellList, go)
		GameUtil.addClickHandler(go, GameUtil.handler(self._onClickCell, self, characterResource, idx), self)
	end

	GameUtil.SetActive(self._cell, false)
end

function MakingMoonCakeSelectView:_updateUI()
	for idx, cell in ipairs(self._cellList) do
		local selectGo = goutil.findChild(cell, "selectGo")

		GameUtil.SetActive(selectGo, idx == self._curSelectIdx)
	end
end

function MakingMoonCakeSelectView:_onClickCell(characterResource, idx)
	self._hasChoosePetId = true
	self._curSelectIdx = idx

	self:_updateUI()
end

function MakingMoonCakeSelectView:_onClickBtnSure()
	if not self._hasChoosePetId then
		FloatWordMgr.instance:show("未选择角色，请先选择")

		return
	end

	local _clientKey = math.random(0, 16384)

	MakingMoonCakeAgent.instance:sendPM_MakingMoonCakeStartGameReq(self._activityInfo.activityId, _clientKey)
end

function MakingMoonCakeSelectView:_handlePM_MakingMoonCakeStartGameRes()
	UIStateManager.instance:push(ViewName.MakingMoonCakeView, self._activityInfo.activityId, self._curSelectIdx)
	self:close()
end

return MakingMoonCakeSelectView
