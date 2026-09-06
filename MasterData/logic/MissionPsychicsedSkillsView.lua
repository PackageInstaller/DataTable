-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionPsychicsedSkillsView.lua

module("logic.extensions.common.mission.view.MissionPsychicsedSkillsView", package.seeall)

local MissionPsychicsedSkillsView = class("MissionPsychicsedSkillsView", ViewComponent)

function MissionPsychicsedSkillsView:buildUI()
	MissionPsychicsedSkillsView.super.buildUI(self)

	self._petsLayout = self:getGo("PetsView/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._petsContentNode = self:getGo("PetsView/Viewport/Content")
	self._skillDesc = self:getTxt("TxtC_Desc")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnClose = self:getBtn("btnClose")
	self._petViewportSize = self:getGo("PetsView/Viewport").transform.rect.height
	self._txtTitle = self:getTxt("title/txt")
end

function MissionPsychicsedSkillsView:bindEvents()
	MissionPsychicsedSkillsView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
end

function MissionPsychicsedSkillsView:unbindEvents()
	MissionPsychicsedSkillsView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function MissionPsychicsedSkillsView:onEnter()
	MissionPsychicsedSkillsView.super.onEnter(self)

	self._currSkillId = self:getFirstParam()
	self._petsData = self:getOpenParam()[2] or {}
	self._isPreview = self:getOpenParam()[3]

	self:_refreshPets()
	self:_updatePreview()
end

function MissionPsychicsedSkillsView:_updatePreview()
	if self._isPreview then
		self._txtTitle.text = "通灵技"

		self._btnSure.gameObject:SetActive(false)
		Framework.TransformUtil.SetLocalPos(self._btnCancel.transform, 64, -180, 0)
	else
		self._txtTitle.text = "选择通灵技"

		self._btnSure.gameObject:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._btnCancel.transform, -100, -180, 0)
	end
end

function MissionPsychicsedSkillsView:_refreshPets()
	self._currPetData = nil

	local showIndex = 0

	for i = 1, #self._petsData do
		local petCo = PetSkinConfig.instance:getPetSkinCfg(self._petsData[i].curFaceId)

		if petCo.psychicSkillId == self._currSkillId then
			self._currPetData = self._petsData[i]
			showIndex = i

			break
		end
	end

	self:_selectPet(self._currPetData)

	local offset = showIndex * 125
	local viewSize = self._petViewportSize

	Framework.TransformUtil.SetAnchoredPos(self._petsContentNode.transform, 0, (viewSize < offset or nil) and offset - viewSize)
end

function MissionPsychicsedSkillsView:_selectPet(petData)
	self._currPetData = petData

	local petCo = PetSkinConfig.instance:getPetSkinCfg((checknumber(petData.curFaceId) > 0 or nil) and checknumber(petData.curFaceId))
	local skillCo = BattleConfig.instance:getSkillCo(petCo.psychicSkillId)

	if skillCo then
		self._skillDesc.text = skillCo.desc or ""
	end

	self:_refreshPetsView()
end

function MissionPsychicsedSkillsView:_refreshPetsView()
	local transform = self._petsLayout.transform
	local childCount = transform.childCount
	local cnt = #self._petsData

	while childCount < cnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	for i = 1, cnt do
		local data = self._petsData[i]
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local proxy = MaterialMgr.setCellByMo(data, go)

		if proxy then
			proxy.binder:setSelected(self._currPetData == data)

			if self._currPetData == data then
				self.lastSelectProxy = proxy
			end

			proxy.binder:setCallBack(function()
				self:_selectPet(data)
			end)
		end

		GameUtil.setAnchoredPos(go, 0, (i - 1) * -125)

		go.name = string.format("petCell_%s", data.raceId)
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = self._petsContentNode.transform.sizeDelta

	sizeDelta.y = cnt * 125
	self._petsContentNode.transform.sizeDelta = sizeDelta
end

function MissionPsychicsedSkillsView:onExit()
	local transform = self._petsLayout.transform

	for i = 1, transform.childCount do
		local go = transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)

		go.name = "petCell"
	end

	self._petsData = nil
	self._currPetData = nil
	self._isPreview = nil

	MissionPsychicsedSkillsView.super.onExit(self)
end

function MissionPsychicsedSkillsView:_onClickSure()
	if self._currPetData then
		local petCo = PetSkinConfig.instance:getPetSkinCfg(self._currPetData.curFaceId)

		GlobalDispatcher:dispatch(GlobalNotify.FormationSelectPsychicedSkill, petCo.psychicSkillId)
	end

	self:close()
end

function MissionPsychicsedSkillsView:_onClickClose()
	self:close()
end

return MissionPsychicsedSkillsView
