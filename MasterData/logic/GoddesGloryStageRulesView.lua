-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddessglory/view/GoddesGloryStageRulesView.lua

module("logic.extensions.goddessglory.view.GoddesGloryStageRulesView", package.seeall)

local GoddesGloryStageRulesView = class("GoddesGloryStageRulesView", ViewComponent)

function GoddesGloryStageRulesView:buildUI()
	GoddesGloryStageRulesView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._imgRule = Framework.ImageBigBG.Get(self:getGo("main/imgRule"))
	self._tipsNode = self:getGo("main/tipsNode")
	self._tipsText = self:getTxt("main/tipsNode/txt1")
	self._petsNode = self:getGo("main/pets")
	self._pets = self:getGo("main/pets/pets"):GetComponent(ComponentType.UILayoutSingleLine)
	self._togSelect = Framework.ToggleAdapter.GetFrom(self.mainGO, "main/togSelect")
end

function GoddesGloryStageRulesView:bindEvents()
	GoddesGloryStageRulesView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function GoddesGloryStageRulesView:unbindEvents()
	GoddesGloryStageRulesView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function GoddesGloryStageRulesView:onEnter()
	GoddesGloryStageRulesView.super.onEnter(self)

	local openParams = self:getOpenParam()

	if openParams then
		self._closeCallFunc = openParams[1]
		self._closeCallFuncObj = openParams[2]
	end

	local challengeId = GoddessGloryModel.instance:getCurGoddessGloryId()
	local stageId = GoddessGloryModel.instance:getCurStageId()
	local stageCo = GoddessGloryConfig.instance:getStageCo(challengeId, stageId)

	self:_showBg(stageCo)
	self:_showPets(stageCo)

	self._tipsText.text = stageCo.rulesTips
	self._togSelect.isOn = false
	self._challengeId = challengeId
	self._stageId = stageId
end

function GoddesGloryStageRulesView:onExit()
	GoddesGloryStageRulesView.super.onExit(self)

	self._closeCallFunc = nil
	self._closeCallFuncObj = nil
end

function GoddesGloryStageRulesView:onExitFinished()
	self._imgRule:ClearImage()

	local childCount = self._pets.transform.childCount

	for i = 1, childCount do
		local go = self._pets.transform:GetChild(i - 1).gameObject
		local node = goutil.findChild(go, "node")

		MaterialMgr.resetAll(node)
	end
end

function GoddesGloryStageRulesView:_showBg(stageCo)
	local imgPath = "ui/bigbg/goddessgloryrules/" .. stageCo.rulesBg

	if not string.find(imgPath, "png") then
		imgPath = imgPath .. ".png"
	end

	self._imgRule:SetImage(imgPath)
end

function GoddesGloryStageRulesView:_showPets(stageCo)
	local petsCount = 0

	if stageCo.rulesPetId then
		petsCount = #stageCo.rulesPetId
	end

	if petsCount == 0 then
		self._petsNode:SetActive(false)

		return
	end

	self._petsNode:SetActive(true)

	local childCount = self._pets.transform.childCount

	while childCount < petsCount do
		UGUIToolHelper.AddChild(self._pets.gameObject, self._pets.transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, petsCount do
		local raceId = stageCo.rulesPetId[i]
		local go = self._pets.transform:GetChild(i - 1).gameObject
		local petCo = CharacterConfig.instance:getPetCo(raceId)

		go:SetActive(true)

		local node = goutil.findChild(go, "node")
		local txtName = goutil.findChildTextComponent(go, "name/txtName")

		MaterialMgr.resetAll(node)
		MaterialMgr.setCell(MatType.Pet, raceId, node)

		txtName.text = petCo.name
	end

	for i = petsCount + 1, childCount do
		local go = self._pets.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._pets:Layout()
end

function GoddesGloryStageRulesView:_onClickClose()
	if self._togSelect.isOn then
		GoddessGloryModel.instance:setGoddessGloryStageRulesShowed(self._challengeId, self._stageId, true)
	end

	if self._closeCallFunc then
		if self._closeCallFuncObj then
			self._closeCallFunc(self._closeCallFuncObj)
		else
			self._closeCallFunc()
		end
	end

	self:close()
end

return GoddesGloryStageRulesView
