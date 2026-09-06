-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/view/MiracleHeroPettipsView.lua

module("logic.extensions.miraclehero.view.MiracleHeroPettipsView", package.seeall)

local MiracleHeroPettipsView = class("MiracleHeroPettipsView", ViewComponent)

function MiracleHeroPettipsView:ctor()
	MiracleHeroPettipsView.super.ctor(self)
end

function MiracleHeroPettipsView:unbindEvents()
	MiracleHeroPettipsView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function MiracleHeroPettipsView:bindEvents()
	MiracleHeroPettipsView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function MiracleHeroPettipsView:buildUI()
	MiracleHeroPettipsView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._Nego_Content = self:getGo("Nego_Content")
	self._TxtC_Name = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._ImgC_Con = self:getGo("Nego_Content/Nego_Top/ImgC_Con")
	self._TxtC_Level = self:getTxt("Nego_Content/Nego_Top/TxtC_Level")
	self._attrIcon = self:getGo("Nego_Content/Nego_Top/Nego_Attr/Img_attr"):GetComponent("UIImageSpriteChange")
	self._Nego_Attr = self:getGo("Nego_Content/Nego_Top/Nego_Attr")
	self._TxtC_Buff = self:getTxt("Nego_Content/Nego_Top/TxtC_Buff")

	self:_buildSkillsView()
end

function MiracleHeroPettipsView:_buildSkillsView()
	self._skills = {}
	self._skills[1] = {}
	self._skills[1].go = self:getGo("Nego_Content/Nego_Skill")
	self._skills[1].negoCon = self:getGo("Nego_Content/Nego_Skill/scrollview/viewport/Nego_Con")
	self._skills[1].skillBtn = self:getGo("Nego_Content/Nego_Skill/skillBtn")
	self._skills[1].txtBattleSkillType = self:getTxt("Nego_Content/Nego_Skill/BattleSkillType/Text")
	self.skillDesc = self:getTxt("Nego_Content/Nego_desc/ScrollView/Viewport/txtDesc")
	self.skillType = self:getTxt("Nego_Content/Nego_desc/txtType")
	self.skillName = self:getTxt("Nego_Content/Nego_desc/txtName")
	self._scroll = self:getGo("Nego_Content/Nego_desc/ScrollView"):GetComponent("ScrollRect")
	self.labelGroup = self:getGo("Nego_Content/Nego_desc/labelGroup")
	self.label = self:getGo("Nego_Content/Nego_desc/label")
end

function MiracleHeroPettipsView:onExit()
	MiracleHeroPettipsView.super.onExit(self)
	MaterialMgr.resetAll(self._ImgC_Con)
end

function MiracleHeroPettipsView:onEnter()
	MiracleHeroPettipsView.super.onEnter(self)

	local params = self:getOpenParam()

	self._info = params[1]

	Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
	self:_initPetTip()
end

function MiracleHeroPettipsView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function MiracleHeroPettipsView:_initPetTip()
	local assistId = checknumber(self._info.assistId)
	local activityId = checknumber(self._info.actId)
	local raceId = checknumber(self._info.raceId)
	local buffContent = self._info.buffContent
	local faceId = -1
	local skillIds = {}

	if assistId > 0 then
		goutil.setActive(self._Nego_Attr, false)

		local assistCfg = MiracleHeroConfig.instance:getAssistCfg(activityId, assistId)

		goutil.setActive(self._Nego_Attr, false)

		self._TxtC_Name.text = assistCfg.name
		faceId = checknumber(assistCfg.faceIds)

		table.insert(skillIds, assistCfg.ultSkillId)
	else
		local petCfg = MiracleHeroConfig.instance:getPetCfg(activityId, raceId)

		goutil.setActive(self._Nego_Attr, true)

		local cfg = MiracleHeroConfig.instance:getRaceType(petCfg.elementId)

		self._attrIcon:SetState(petCfg.elementId - 1)

		self._TxtC_Name.text = petCfg.name
		faceId = checknumber(petCfg.faceIds)

		table.insert(skillIds, petCfg.normalSkillId)
		table.insert(skillIds, petCfg.ultSkillId)
	end

	local skinId = checknumber(faceId)
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local showRaceId = petSkinCfg.raceId
	local proxy = MaterialMgr.setCell(MatType.Pet, showRaceId, self._ImgC_Con)

	if proxy then
		proxy:setAutoTips(false)
		proxy.binder:setSkin(skinId)
	end

	self:setSkills(skillIds, skinId, self._skills[1])
	GameUtil.SetActive(self._TxtC_Buff, not string.nilorempty(buffContent))

	self._TxtC_Buff.text = buffContent
end

function MiracleHeroPettipsView:setSkills(skillIds, skinId, skillCfg)
	skillCfg.items = skillCfg.items or {}

	for i = 1, #skillCfg.items do
		local view = skillCfg.items[i]

		goutil.destroy(view)
	end

	skillCfg.items = {}

	local count = 0

	goutil.clearChildren(skillCfg.negoCon)

	for k, skillId in ipairs(skillIds) do
		local item = goutil.clone(skillCfg.skillBtn, "item" .. k)

		goutil.addChildToParent(item, skillCfg.negoCon)
		GameUtil.SetActive(item, true)
		table.insert(skillCfg.items, item)

		count = count + 1

		local con = goutil.findChild(item, "con")

		GameUtil.addClickHandler(item, GameUtil.handler(self.onClickSkillIdx, self, skillId, count, skillCfg))

		if count == 1 then
			self:onClickSkillIdx(skillId, count, skillCfg)
		end

		local skillCo = MiracleHeroConfig.instance:getSkillCfg(skillId)

		uGuiUtil.setSpriteToImage(con, uGuiUtil.SpriteType.BigBg, skillCo.skillImg)
	end
end

function MiracleHeroPettipsView:onClickSkillIdx(skillId, idx, skillCfg)
	for i, v in ipairs(skillCfg.items) do
		local select = goutil.findChild(v, "selected")

		GameUtil.SetActive(select, i == idx)
	end

	for i = 1, #self._skills do
		if self._skills[i] ~= skillCfg and self._skills[i].items then
			for j, v in ipairs(self._skills[i].items) do
				local select = goutil.findChild(v, "selected")

				GameUtil.SetActive(select, false)
			end
		end
	end

	local skillCo = MiracleHeroConfig.instance:getSkillCfg(skillId)

	goutil.clearChildren(self.labelGroup)

	self.skillDesc.text = skillCo.skillDesc

	if GameUtil.isEmptyString(skillCo.skillType) then
		self._skills[1].txtBattleSkillType.text = ""
	else
		local showTxt = "类型："
		local typeStrs = string.split(skillCo.skillType, "#")

		for i, str in ipairs(typeStrs) do
			showTxt = showTxt .. string.format("【%s】", str)
		end

		self._skills[1].txtBattleSkillType.text = showTxt
	end

	self.skillType.text = skillCo.type
end

return MiracleHeroPettipsView
