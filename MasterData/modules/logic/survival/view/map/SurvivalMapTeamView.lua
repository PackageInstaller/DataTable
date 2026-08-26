-- chunkname: @modules/logic/survival/view/map/SurvivalMapTeamView.lua

module("modules.logic.survival.view.map.SurvivalMapTeamView", package.seeall)

local SurvivalMapTeamView = class("SurvivalMapTeamView", BaseView)

function SurvivalMapTeamView:onInitView()
	self._txtWeight = gohelper.findChildTextMesh(self.viewGO, "Panel/Weight/#txt_WeightNum")
	self._root = gohelper.findChild(self.viewGO, "Panel/#go_Overview")
	self._goherocontent = gohelper.findChild(self._root, "Team/Scroll View/Viewport/#go_content")
	self._txtheronum = gohelper.findChildTextMesh(self._root, "Team/Title/txt_Team/#txt_MemberNum")
	self._gonpccontent = gohelper.findChild(self._root, "Partner/Scroll View/Viewport/#go_content")
	self._txtnpcnum = gohelper.findChildTextMesh(self._root, "Partner/Title/txt_Partner/#txt_MemberNum")
	self._btnequip = gohelper.findChildButtonWithAudio(self._root, "Left/#btn_equip")
	self._goinfo = gohelper.findChild(self.viewGO, "Panel/#go_info")
	self._btnCloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#go_info/#btn_closeinfo")
	self.image_LeaderCard = gohelper.findChildSingleImage(self._root, "Left/image_LeaderCard")
	self.txt_Leader = gohelper.findChildTextMesh(self._root, "Left/Name/txt_Leader")
	self.survivalroleleveltipcomp = gohelper.findChild(self._root, "survivalroleleveltipcomp")
	self.survivalrolelevelcomp = gohelper.findChild(self._root, "Left/#go_level/survivalrolelevelcomp")
	self.survivalRoleLevelComp = GameFacade.createLuaCompByGo(self.survivalrolelevelcomp, SurvivalRoleLevelComp)

	self.survivalRoleLevelComp:setOnClickFunc(self.onClickBtnLevel, self)

	self.survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	self.survivalroleattrcomp = gohelper.findChild(self._root, "Left/survivalroleattrcomp")

	if self.survivalShelterRoleMo:haveRole() then
		self.survivalRoleAttrComp = GameFacade.createLuaCompByGo(self.survivalroleattrcomp, SurvivalRoleAttrComp, nil, self.viewContainer)
	end
end

function SurvivalMapTeamView:addEvents()
	self._btnCloseTips:AddClickListener(self._btnCloseTipsOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTeamNpc, self._showNpcInfoView, self)
end

function SurvivalMapTeamView:removeEvents()
	self._btnCloseTips:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTeamNpc, self._showNpcInfoView, self)
end

function SurvivalMapTeamView:onOpen()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._btnequip.gameObject, SurvivalEquipBtnComp)
	gohelper.setActive(self._goinfo, false)

	self._teamInfoMo = SurvivalMapModel.instance:getSceneMo().teamInfo
	self._initGroupMo = SurvivalMapModel.instance:getInitGroup()

	self:_initHeroItemList()
	self:_updateHeroList()
	self:_initNPCItemList()
	self:_updateNPCList()
	self.survivalRoleAttrComp:setData(2, self.survivalShelterRoleMo.roleId)
	self.survivalRoleLevelComp:setData()

	local cardPath = SurvivalRoleConfig.instance:getRoleCardImage(self.survivalShelterRoleMo.roleId)

	if not string.nilorempty(cardPath) then
		self.image_LeaderCard:LoadImage(ResUrl.getSurvivalTeamIcon(cardPath))
	end

	self.txt_Leader.text = lua_survival_role.configDict[self.survivalShelterRoleMo.roleId].name
end

function SurvivalMapTeamView:onDestroyView()
	self.image_LeaderCard:UnLoadImage()
end

function SurvivalMapTeamView:_btnCloseTipsOnClick()
	gohelper.setActive(self._goinfo, false)
end

function SurvivalMapTeamView:_btnequipOnClick()
	SurvivalController.instance:openEquipView()
end

function SurvivalMapTeamView:_initHeroItemList()
	self._heroItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes.initHeroItemSmall
	local canCarryNum = self._initGroupMo:getCarryHeroCount()
	local itemCount = math.max(canCarryNum, self._initGroupMo:getCarryHeroMax())

	for i = 1, itemCount do
		local itemGo = self:getResInst(path, self._goherocontent)

		itemGo.name = "item_" .. tostring(i)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SurvivalInitTeamHeroSmallItem)

		item:setIndex(i)
		item:setIsLock(canCarryNum < i)
		item:setNoShowAdd()
		item:setParentView(self)
		table.insert(self._heroItemList, item)
	end
end

function SurvivalMapTeamView:_updateHeroList()
	local count = 0

	for i, heroItem in ipairs(self._heroItemList) do
		local heroUid = self._teamInfoMo.heros[i]
		local heroMo, isAssist = self._teamInfoMo:getHeroMo(heroUid)

		heroItem:setTrialValue(isAssist)
		heroItem:onUpdateMO(heroMo)

		if heroMo then
			count = count + 1
		end
	end

	self._txtheronum.text = string.format("(%d/%d)", count, self._initGroupMo:getCarryHeroCount())

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	self._txtWeight.text = weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Weight)
end

function SurvivalMapTeamView:_initNPCItemList()
	self._npcItemList = self:getUserDataTb_()

	local path = self.viewContainer:getSetting().otherRes.initNpcItemSmall
	local canCarryNum = self._initGroupMo:getCarryNPCCount()
	local itemCount = math.max(canCarryNum, self._initGroupMo:getCarryNPCMax())

	for i = 1, itemCount do
		local itemGo = self:getResInst(path, self._gonpccontent)

		itemGo.name = "item_" .. tostring(i)

		local item = MonoHelper.addNoUpdateLuaComOnceToGo(itemGo, SurvivalInitNPCSmallItem)

		item:setNoShowAdd()
		item:setIsLock(canCarryNum < i)
		item:setIndex(i)
		item:setParentView(self)
		table.insert(self._npcItemList, item)
	end
end

function SurvivalMapTeamView:_updateNPCList()
	local count = 0

	for i, npcItem in ipairs(self._npcItemList) do
		local npcId = self._teamInfoMo.npcId[i]
		local npcMo = SurvivalShelterModel.instance:getWeekInfo():getNpcInfo(npcId)

		npcItem:onUpdateMO(npcMo)

		if npcMo then
			count = count + 1
		end
	end

	self._txtnpcnum.text = string.format("(%d/%d)", count, self._initGroupMo:getCarryNPCCount())
end

function SurvivalMapTeamView:_showNpcInfoView(npcMo)
	if not self.npcInfoView then
		local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
		local infoGo = self:getResInst(infoViewRes, self._goinfo)

		self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalSelectNPCInfoPart)
	end

	gohelper.setActive(self._goinfo, true)
	self._infoPanel:updateMo(npcMo, true)
end

function SurvivalMapTeamView:onClickBtnLevel()
	GameFacade.openTipPopView(ViewName.SurvivalRoleLevelTipPopView, self.survivalroleleveltipcomp)
end

return SurvivalMapTeamView
