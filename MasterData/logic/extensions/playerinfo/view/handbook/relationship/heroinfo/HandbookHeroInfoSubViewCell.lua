-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroInfoSubViewCell.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroInfoSubViewCell", package.seeall)

local M = class("HandbookHeroInfoSubViewCell")

M.showUIName = {
	campInfo = 1,
	roleName = 1,
	rolePlot = 1
}

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
end

function M:buildUI()
	local transRoot = self._mainGo.transform

	for i = 0, transRoot.childCount - 1 do
		local tmp = transRoot:GetChild(i).gameObject

		goutil.setActive(tmp, self.showUIName[tmp.name])
	end

	self._name1Txt = self._registry:getText("role_infomation_panel_1369686116")
	self._name2Txt = self._registry:getText("role_infomation_panel_1234785271")
	self._cvNameTxt = self._registry:getText("role_infomation_panel_790779509")
	self._campIcon = self._registry:getImage("role_infomation_panel_166126107")
	self._organizationNameTxt = self._registry:getText("role_infomation_panel_-959963927")
	self._expressionPhotoCentrPointGo = self._registry:getGo("role_infomation_panel_-1609194873")
	self._rolePlotGo = self._registry:getGo("dialogue_-1584339662")
	self._txtRolePlotContent = self._registry:getText("dialogue_-471327988")

	self._rolePlotGo:SetActive(false)

	self._guiAnimation = goutil.addComponentOnce(self._mainGo, typeof(Astral.GUITimelineAniLua))
end

function M:destroyUI()
	self._name1Txt = nil
	self._name2Txt = nil
	self._cvNameTxt = nil
	self._campIcon = nil
	self._organizationNameTxt = nil
	self._expressionPhotoCentrPointGo = nil
	self._rolePlotGo = nil
	self._txtRolePlotContent = nil
	self._guiAnimation = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:setShow(show)
	if self._mainGo.activeSelf ~= show then
		goutil.setActive(self._mainGo, show)

		if show then
			self._guiAnimation:StopTimelineAni()
			self._guiAnimation:PlayAniByName("open")
		end
	end
end

function M:getExpressionSpineTransform()
	return self._expressionPhotoCentrPointGo.transform
end

function M:refreshRolePlot(_, isInVoiceView, data)
	self._rolePlotGo:SetActive(isInVoiceView)

	local faceStr = ExpressionConfig.instance:getDefaultFace(self._modelId)

	if not defualtFace then
		faceStr = "changtai"
	end

	if isInVoiceView then
		self._txtRolePlotContent.text = data.qipaoContent
		faceStr = ExpressionConfig.instance:getFaceResByName(self._modelId, data.expressionName)
	end
end

function M:refreshHeroInfo(heroId)
	self._heroId = heroId

	local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

	self._modelId = cfgCharacter and cfgCharacter.modelId or 0

	local heroInfoCO = PastInfoConfig.instance:getCharacterInfo(heroId)
	local orgInfoCO = PastInfoConfig.instance:getOrgInfo(heroInfoCO.organization)

	self._name1Txt.text = heroInfoCO.code
	self._name2Txt.text = heroInfoCO.name
	self._cvNameTxt.text = "CV." .. heroInfoCO.CV
	self._organizationNameTxt.text = orgInfoCO.name

	IconLoader.setSprite(self._campIcon, IconType.CharacterInfoCamp, orgInfoCO.OrganizationId)
end

return M
