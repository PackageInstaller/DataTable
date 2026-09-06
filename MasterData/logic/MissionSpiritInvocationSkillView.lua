-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionSpiritInvocationSkillView.lua

module("logic.extensions.common.mission.view.MissionSpiritInvocationSkillView", package.seeall)

local MissionSpiritInvocationSkillView = class("MissionSpiritInvocationSkillView", ViewComponent)

function MissionSpiritInvocationSkillView:buildUI()
	MissionSpiritInvocationSkillView.super.buildUI(self)

	self._petsLayout = self:getGo("PetsView/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._petsContentNode = self:getGo("PetsView/Viewport/Content")
	self._skillDesc = self:getTxt("descview/viewport/TxtC_Desc")
	self._btnSure = self:getBtn("btnSure")
	self._btnCancel = self:getBtn("btnCancel")
	self._btnClose = self:getBtn("btnClose")
	self._petViewportSize = self:getGo("PetsView/Viewport").transform.rect.height
	self._txtTitle = self:getTxt("title/txt")
end

function MissionSpiritInvocationSkillView:bindEvents()
	MissionSpiritInvocationSkillView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnCancel:AddClickListener(self._onClickClose, self)
end

function MissionSpiritInvocationSkillView:unbindEvents()
	MissionSpiritInvocationSkillView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function MissionSpiritInvocationSkillView:onEnter()
	MissionSpiritInvocationSkillView.super.onEnter(self)

	self._currPetId = checknumber(self:getFirstParam())
	self._petsData = self:getOpenParam()[2] or {}
	self._isPreview = self:getOpenParam()[3]

	self:_refreshPets()
	self:_updatePreview()
end

function MissionSpiritInvocationSkillView:_updatePreview()
	if self._isPreview then
		self._txtTitle.text = "唤灵技"

		self._btnSure.gameObject:SetActive(false)
		Framework.TransformUtil.SetLocalPos(self._btnCancel.transform, 64, -180, 0)
	else
		self._txtTitle.text = "选择唤灵技"

		self._btnSure.gameObject:SetActive(true)
		Framework.TransformUtil.SetLocalPos(self._btnCancel.transform, -100, -180, 0)
	end
end

function MissionSpiritInvocationSkillView:_refreshPets()
	self._currPetData = nil

	local showIndex = 1

	for i = 1, #self._petsData do
		local petData = self._petsData[i]

		if checknumber(petData.petId) == self._currPetId then
			self._currPetData = petData
			showIndex = i

			break
		end
	end

	self._currPetData = self._currPetData or self._petsData[1]

	if not self._currPetData then
		self._skillDesc.text = ""

		self:_refreshPetsView()

		return
	end

	self:_selectPet(self._currPetData)

	local offset = showIndex * 125
	local viewSize = self._petViewportSize

	Framework.TransformUtil.SetAnchoredPos(self._petsContentNode.transform, 0, (viewSize < offset or nil) and offset - viewSize)
end

function MissionSpiritInvocationSkillView:_selectPet(petData)
	if not petData then
		return
	end

	self._currPetData = petData
	self._currPetId = checknumber(petData.petId)

	local petCo = PetSkinConfig.instance:getPetSkinCfg((checknumber(petData.curFaceId) > 0 or nil) and checknumber(petData.curFaceId))

	self._currSkillId = petCo.spiritInvocationSkillId

	local skillCo = BattleConfig.instance:getSkillCo(self._currSkillId)

	if skillCo then
		self._skillDesc.text = skillCo.desc or ""
	end

	self:_refreshPetsView()
end

function MissionSpiritInvocationSkillView:_refreshPetsView()
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

function MissionSpiritInvocationSkillView:onExit()
	local transform = self._petsLayout.transform

	for i = 1, transform.childCount do
		local go = transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)

		go.name = "petCell"
	end

	self._petsData = nil
	self._currPetData = nil
	self._currPetId = nil
	self._currSkillId = nil
	self._isPreview = nil

	MissionSpiritInvocationSkillView.super.onExit(self)
end

function MissionSpiritInvocationSkillView:_onClickSure()
	if self._currPetData then
		GlobalDispatcher:dispatch(GlobalNotify.FormationSelectSpiritInvocationSkill, self._currPetData.petId)
	end

	self:close()
end

function MissionSpiritInvocationSkillView:_onClickClose()
	self:close()
end

return MissionSpiritInvocationSkillView
