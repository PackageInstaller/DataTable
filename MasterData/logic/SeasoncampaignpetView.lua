-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasoncampaignpetView.lua

module("logic.extensions.season.view.SeasoncampaignpetView", package.seeall)

local SeasoncampaignpetView = class("SeasoncampaignpetView", ViewComponent)

function SeasoncampaignpetView:ctor()
	SeasoncampaignpetView.super.ctor(self)
end

function SeasoncampaignpetView:unbindEvents()
	SeasoncampaignpetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
	self._customInput:RemoveListener()
end

function SeasoncampaignpetView:bindEvents()
	SeasoncampaignpetView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onStrengTipClick, self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function SeasoncampaignpetView:buildUI()
	SeasoncampaignpetView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.tip = self:getGo("tip")
	self._customInput = UICustomInput.Get(self.tip)
	self.skillCell = self:getGo("skill")

	GameUtil.SetActive(self.skillCell, false)

	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function SeasoncampaignpetView:onExit()
	SeasoncampaignpetView.super.onExit(self)
	self.scrollList:dispose()
end

function SeasoncampaignpetView:onEnter()
	SeasoncampaignpetView.super.onEnter(self)

	local petIds = self:getFirstParam()
	local list = {}

	for i, v in ipairs(petIds or {}) do
		local mo = BagModel.instance:getBagPetById(v)

		if mo then
			local tem = mo:GetClone()

			tem.level = CharacterConfig.instance:GetMaxLevel(mo.raceId)

			table.insert(list, tem)
		end
	end

	ArraySort.sortOn(list, {
		"awakenLv",
		"_zdl",
		"petId"
	}, {
		ArraySort.DESCENDING,
		ArraySort.DESCENDING,
		ArraySort.DESCENDING
	})
	self.scrollList:reloadData(list)
	GameUtil.SetActive(self.tip, false)
end

function SeasoncampaignpetView:_updateCell(view, cell, data, tag)
	local pet = goutil.findChild(cell, "pet")
	local con = goutil.findChild(cell, "pet/con")
	local skillCon = goutil.findChild(cell, "skillCon")
	local awake = goutil.findChild(cell, "awake")
	local btnAwake = goutil.findChild(cell, "awake/btnAwake")
	local imgAwake = goutil.findChild(cell, "awake/btnAwake/imgLv")
	local skinId = data.curFaceId
	local proxy = MaterialMgr.setCellByMo(data, con)

	if proxy then
		proxy:setAutoTips(false)
	end

	GameUtil.setUIImageSpriteIdx(imgAwake, data.awakenLv)
	goutil.clearChildren(skillCon)

	local skills = BagModel.instance:getPetSkills(data)

	for i, skillId in ipairs(skills or {}) do
		self:createSkill(skillId, skinId, skillCon, data)
	end

	local psychicSkills = BagModel.instance:getPetPsychicSkills(data)

	for i, skillId in ipairs(psychicSkills or {}) do
		self:createSkill(skillId, skinId, skillCon, data)
	end
end

function SeasoncampaignpetView:createSkill(skillId, skinId, skillCon, petMo)
	local skillCell = goutil.clone(self.skillCell, "skill_" .. skillId)

	GameUtil.SetActive(skillCell, true)
	goutil.addChildToParent(skillCell, skillCon)

	local skillIcon = goutil.findChild(skillCell, "skillIcon")
	local level = goutil.findChild(skillCell, "level")
	local txtLevel = goutil.findChildTextComponent(skillCell, "level/txtLevel")
	local imgSkillType = goutil.findChild(skillCell, "imgSkillType")
	local proxy = MaterialMgr.setSkillByFaceId(skillId, skinId, skillIcon)

	if proxy then
		proxy.binder:showSkillName(false)
		proxy:setAutoTips(false)
	end

	local skillCfg = BattleConfig.instance:getSkillCo(skillId)
	local type = GameEnum.SkillNameToType[skillCfg.type]
	local skicon = skillCfg.skillTopImg

	uGuiUtil.setSpriteToImage(imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))

	local skllLvl = checknumber(skillId) % 10
	local key = MaterialMgr.SkillLvlKey[type]

	if not string.nilorempty(key) and petMo[key] then
		skllLvl = petMo[key]
	end

	txtLevel.text = skllLvl

	GameUtil.SetActive(level, true)

	if skillCfg.isNotShowLvl == 1 then
		txtLevel.text = ""

		GameUtil.SetActive(level, false)
	end

	GameUtil.addClickHandler(skillCell, function()
		CommonTipsMgr.instance:openMaterialTips(skillCell, MatType.Skill, skillId, skinId, skllLvl, petMo)
	end)
end

function SeasoncampaignpetView:clearCell(cell)
	local con = goutil.findChild(cell, "pet/con")

	MaterialMgr.resetAll(con)
end

function SeasoncampaignpetView:onStrengTipClick()
	if GameUtil.GetActive(self.tip) == false then
		GameUtil.SetActive(self.tip, true)
	else
		GameUtil.SetActive(self.tip, false)
	end
end

function SeasoncampaignpetView:_onCustomInputCallback(hover)
	if not hover and GameUtil.GetActive(self.tip) then
		GameUtil.SetActive(self.tip, false)
	end
end

return SeasoncampaignpetView
