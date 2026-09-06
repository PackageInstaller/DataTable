-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/MissionDomainSkillsView.lua

module("logic.extensions.common.mission.view.MissionDomainSkillsView", package.seeall)

local MissionDomainSkillsView = class("MissionDomainSkillsView", ViewComponent)

function MissionDomainSkillsView:buildUI()
	MissionDomainSkillsView.super.buildUI(self)

	self._petsLayout = self:getGo("PetsView/Viewport/Content/items"):GetComponent(ComponentType.UILayoutSingleLine)
	self._petsContentNode = self:getGo("PetsView/Viewport/Content")
	self._skillsContentNode = self:getGo("SkillsView/Viewport/Content")
	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
end

function MissionDomainSkillsView:bindEvents()
	MissionDomainSkillsView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function MissionDomainSkillsView:unbindEvents()
	MissionDomainSkillsView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function MissionDomainSkillsView:onEnter()
	MissionDomainSkillsView.super.onEnter(self)

	self._petsData = self:getFirstParam()

	self:_selectPet(self._petsData[1])
end

function MissionDomainSkillsView:_selectPet(petData)
	self._currPetData = petData

	local skinId = petData.raceId

	if checknumber(petData.curFaceId) > 0 then
		skinId = checknumber(petData.curFaceId)
	end

	local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

	self:_refreshSkillsView(petCo.domainSkillId, skinId)
	self:_refreshPetsView()
end

function MissionDomainSkillsView:_refreshSkillsView(skillId, skinId)
	local curCfg = BattleConfig.instance:getSkillCo(skillId, skinId)
	local layerCos = BattleConfig.instance:getDomainSkillLevels(skillId)
	local transform = self._skillsContentNode.transform
	local childCount = transform.childCount
	local cnt = #layerCos

	while childCount < cnt do
		UGUIToolHelper.AddChild(transform.gameObject, transform:GetChild(0).gameObject)

		childCount = childCount + 1
	end

	local posx, posy = 4, -20

	for i = 1, cnt do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(true)

		local layerName = goutil.findChildTextComponent(go, "layerName")
		local desc = goutil.findChildTextComponent(go, "TxtC_Desc")
		local descBg = goutil.findChild(go, "descBg")

		layerName.text = curCfg.name .. GameUtil.toRomanNumber(i)
		desc.text = layerCos[i].desc

		Framework.TransformUtil.SetLocalPos(go.transform, posx, posy, 0)

		local preferredHeight = desc.preferredHeight

		posy = posy - 54 - preferredHeight

		local bgSize = descBg.transform.sizeDelta

		bgSize.y = preferredHeight + 10
		descBg.transform.sizeDelta = bgSize
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = self._skillsContentNode.transform.sizeDelta

	sizeDelta.y = -posy + 10
	self._skillsContentNode.transform.sizeDelta = sizeDelta
end

function MissionDomainSkillsView:_refreshPetsView()
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
	end

	for i = cnt + 1, childCount do
		local go = transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	local sizeDelta = self._petsContentNode.transform.sizeDelta

	sizeDelta.y = cnt * 125
	self._petsContentNode.transform.sizeDelta = sizeDelta
end

function MissionDomainSkillsView:onExit()
	local transform = self._petsLayout.transform

	for i = 1, transform.childCount do
		local go = transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end

	self._petsData = nil
	self._currPetData = nil

	MissionDomainSkillsView.super.onExit(self)
end

function MissionDomainSkillsView:_onClickSure()
	self:close()
end

function MissionDomainSkillsView:_onClickClose()
	self:close()
end

return MissionDomainSkillsView
