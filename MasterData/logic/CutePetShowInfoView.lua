-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetShowInfoView.lua

module("logic.extensions.cutepet.view.CutePetShowInfoView", package.seeall)

local CutePetShowInfoView = class("CutePetShowInfoView", ViewComponent)
local fixShowList = {
	"生命",
	"攻击",
	"物防",
	"魔防"
}

CutePetShowInfoView.ShowAssistSkill = 1
CutePetShowInfoView.ShowTalentSkill = 2

function CutePetShowInfoView:ctor()
	CutePetShowInfoView.super.ctor(self)

	self._fixShowAttrMap = {}

	for i, v in ipairs(fixShowList) do
		self._fixShowAttrMap[FightingPowerFormula.instance:getAttrTypeByName(v)] = true
	end
end

function CutePetShowInfoView:buildUI()
	CutePetShowInfoView.super.buildUI(self)

	self._txtName = self:getTxt("basicInfo/cutePetName/txtName")
	self._txtLevel = self:getTxt("basicInfo/txtLevel")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "basicInfo/imgQuality", "UIImageSpriteChange")
	self._imgType = goutil.findChildComponent(self.mainGO, "basicInfo/imgType", "UIImageSpriteChange")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("basicInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "basicInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._attrTable = self:getGo("attrInfo/ScrollView")
	self._attrCell = self:getGo("attrInfo/attrCell")
	self._assistanceSkill = self:getTxt("skillInfo/assistanceSkill/txtDesc")
	self._skillIntroduce = self:getGo("skillIntroduce")
	self._btnSkillClose = self:getGo("skillIntroduce/btnClose")
	self._btnSkillIntro = self:getGo("btnSkillIntro")
	self._skillTable = self:getGo("skillIntroduce/starSkill/ScrollView")
	self._skillCell = self:getGo("skillIntroduce/starSkill/skillCell")
	self._skillSizeImmediate = goutil.findChildComponent(self._skillCell, "bg", "ContentSizeImmediate")
	self._skillList = ScrollerList.create(self._skillTable, self._skillCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))

	self._skillList:regReloadFinish(GameUtil.handler(self._skillReloadFinish, self))
	self._skillList:regGetCellSize(GameUtil.handler(self._skillCellSize, self))

	self._txtCurStarSkillDesc = self:getTxt("skillInfo/starSkill/ScrollView/Nego_Viewport/Nego_Content/txtDesc")
	self._txtCurSkillStar = self:getTxt("skillInfo/starSkill/skillCell/star/txt")
	self._btnDetail = self:getGo("btnDetail")
	self._content = self:getGo("content")
	self._btnRename = self:getGo("renameBtn")
	self._btnTalent = self:getGo("skillInfo/assistanceSkill/btnTalent")
	self._changeTalent = self._btnTalent:GetComponent(typeof(UIChangeGroup))
	self._btnAssistance = self:getGo("skillInfo/assistanceSkill/btnAssistance")
	self._changeAssistance = self._btnAssistance:GetComponent(typeof(UIChangeGroup))
	self._btnRule = self:getGo("btnRule")
	self._equipPet = self:getGo("protectPet")
	self._equipPetCon = self:getGo("protectPet/con")
	self._equipPetEmpty = self:getGo("protectPet/empty")
end

function CutePetShowInfoView:destroyUI()
	CutePetShowInfoView.super.destroyUI(self)
	self._skillList:dispose()
end

function CutePetShowInfoView:bindEvents()
	CutePetShowInfoView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
	GameUtil.addClickHandler(self._btnRename, self._onClickRename, self)
	GameUtil.addClickHandler(self._btnTalent, self._onClickTalent, self)
	GameUtil.addClickHandler(self._btnAssistance, self._onClickAssistance, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnSkillIntro, self._onClickSkillIntro, self)
	GameUtil.addClickHandler(self._btnSkillClose, self._onClickSkillClose, self)
end

function CutePetShowInfoView:unbindEvents()
	CutePetShowInfoView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnRename)
	GameUtil.rmClickHandler(self._btnTalent)
	GameUtil.rmClickHandler(self._btnAssistance)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnSkillIntro)
	GameUtil.rmClickHandler(self._btnSkillClose)
end

function CutePetShowInfoView:onExit()
	CutePetShowInfoView.super.onExit(self)
	MaterialMgr.resetAll(self._qualityCon)
	self._attrList:dispose()
end

function CutePetShowInfoView:destroyUI()
	CutePetShowInfoView.super.destroyUI(self)
end

function CutePetShowInfoView:onEnter()
	self.addGEvent(self, GlobalNotify.CutePetShowPetChange, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.handlePM_CutePetRenameResp, self._refreshView, self)

	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._showState = CutePetShowInfoView.ShowTalentSkill

	self:_refreshView()
end

function CutePetShowInfoView:_refreshView()
	self._petId = CutePetModel.instance:GetCurPetId()
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo then
		return
	end

	local petTypeCfg = CutePetConfig.instance:getPetTypeCfg(self._petMo.config.type)

	self._imgQualityChange:SetState(self._petMo.curQuality - 1)
	self._imgType:SetState(self._petMo.config.type - 1)

	self._txtName.text = self._petMo.name
	self._txtLevel.text = string.format("%d", self._petMo.curLvl)
	self._maxStar = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality)

	for i = 1, #self._starList do
		if i <= self._petMo.curStar then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= self._maxStar then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end

	local list = {}
	local attrSort = self._petMo:getSortAttrList()

	for i, v in ipairs(attrSort) do
		if self._fixShowAttrMap[v] == true then
			table.insert(list, {
				attrType = v,
				num = self._petMo.attr[v]
			})
		end
	end

	for i, v in ipairs(list) do
		v.index = i
	end

	self._initProps = self._petMo:getInitialActiveProps()

	self._attrList:reloadData(list)

	local skillList = {}
	local curStarCfg

	for i, v in ipairs(CutePetConfig.instance:getStarSkillCfgs(self._petMo.raceId)) do
		table.insert(skillList, v)
	end

	table.sort(skillList, function(a, b)
		return a.star < b.star
	end)

	for i, v in ipairs(skillList) do
		if v.star <= self._petMo.curStar then
			curStarCfg = v
		end
	end

	self:_recordHeight(skillList)
	self._skillList:reloadData(skillList)
	self:_checkAssisSkillStatus()

	self._txtCurSkillStar.text = curStarCfg.star
	self._txtCurStarSkillDesc.text = curStarCfg.starBuffsDesc

	MaterialMgr.resetAll(self._equipPetCon)

	if checknumber(self._petMo.equippedPetId) > 0 then
		GameUtil.SetActive(self._equipPetEmpty, false)
		GameUtil.SetActive(self._equipPetCon, true)

		local bagPetMo = BagPetsController.instance:getPet(self._petMo.equippedPetId)
		local proxy = MaterialMgr.setCellByMo(bagPetMo, self._equipPetCon)

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				BagPetsController.instance:openBagPetView(bagPetMo.petId, 7)
			end)
		end
	else
		GameUtil.SetActive(self._equipPetEmpty, true)
		GameUtil.SetActive(self._equipPetCon, false)
	end
end

function CutePetShowInfoView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "bg/txtDesc")
	local txtColorChange = goutil.findChildComponent(go, "bg/txtDesc", "UITextColorChange")
	local lock = goutil.findChild(go, "lock")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")

	for i = 1, 6 do
		local star = goutil.findChild(go, "starLv/star_" .. i)

		if i <= data.star then
			GameUtil.SetActive(star, true)
		else
			GameUtil.SetActive(star, false)
		end
	end

	go.name = "star_" .. data.star

	if data.star <= self._petMo.curStar then
		txtColorChange:SetState(0)
		GameUtil.SetActive(lock, false)
	else
		txtColorChange:SetState(1)
		GameUtil.SetActive(lock, true)
	end

	txtDesc.text = data.starBuffsDesc
	txtStar.text = data.star
end

function CutePetShowInfoView:_clearSkillCell(cell)
	return
end

function CutePetShowInfoView:_skillReloadFinish()
	if self._petMo then
		self._skillList:MoveCellInView(self._petMo.curStar - 1, true)
	end
end

function CutePetShowInfoView:_skillCellSize(view, index)
	local height = self.heightList[index + 1]

	return 326, height
end

function CutePetShowInfoView:_recordHeight(skillList)
	goutil.setActive(self._skillCell, true)

	self.heightList = {}

	for k, data in ipairs(skillList) do
		self:_updateSkillCell(nil, self._skillCell, data)

		local size = self._skillSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y))
	end

	goutil.setActive(self._skillCell, false)
end

function CutePetShowInfoView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local bgChange = go:GetComponent(ComponentType.UIImageColorChange)
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local txtQuality = goutil.findChildTextComponent(go, "txtQuality")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtColorChange = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	txtType.text = GameEnum.AttrTypeName[data.attrType]

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.num >= 1 and string.format("%d", math.floor(data.num)) or string.format("%.2f%%", data.num * 100)

	bgChange:SetState(data.index % 2)

	local gradingCfgs = CutePetConfig.instance:getPropertyGradingCfg(GameEnum.AttrTypeName[data.attrType])

	txtQuality.text = ""

	if gradingCfgs and self._initProps[data.attrType] then
		for i, v in ipairs(gradingCfgs) do
			if self._initProps[data.attrType] >= v.genRange[1] and self._initProps[data.attrType] < v.genRange[2] then
				txtQuality.text = v.grade

				txtColorChange:SetState(v.color - 1)

				break
			end
		end
	else
		txtQuality.text = ""
	end
end

function CutePetShowInfoView:_clearAttrCell(cell)
	return
end

function CutePetShowInfoView:_checkAssisSkillStatus()
	if self._showState == CutePetShowInfoView.ShowAssistSkill then
		self._changeTalent:SetState(1)
		self._changeAssistance:SetState(0)

		local assistanceCfg = CutePetConfig.instance:getAssistanceCfg(self._petMo.config.type, self._petMo.curQuality)

		self._assistanceSkill.text = assistanceCfg.desc
	elseif self._showState == CutePetShowInfoView.ShowTalentSkill then
		self._changeTalent:SetState(0)
		self._changeAssistance:SetState(1)

		local talentCfg = CutePetConfig.instance:getTalentCfg(self._petMo.initialTalent)

		self._assistanceSkill.text = talentCfg.desc
	end
end

function CutePetShowInfoView:_onClickClose()
	self:close()
end

function CutePetShowInfoView:_onClickDetail()
	local goOrPos = self._content
	local pos = goOrPos
	local sizeDelta = {
		0,
		0
	}

	if goOrPos and goOrPos.gameObject then
		local rect = goOrPos.gameObject:GetComponent("RectTransform")

		if rect ~= nil then
			sizeDelta = {
				rect.sizeDelta.x,
				rect.sizeDelta.y
			}
		end

		pos = goOrPos.gameObject.transform.position

		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		pos = uiCamera:WorldToScreenPoint(pos)
	end

	UIStateManager.instance:open(ViewName.CutePetAttrPopUpView, pos, sizeDelta, self._viewPresentor, self._petId, self._fixShowAttrMap)
end

function CutePetShowInfoView:_onClickRename()
	UIStateManager.instance:push(ViewName.CutePetRenameView, self._petId)
end

function CutePetShowInfoView:_onClickTalent()
	self._showState = CutePetShowInfoView.ShowTalentSkill

	self:_checkAssisSkillStatus()
end

function CutePetShowInfoView:_onClickAssistance()
	self._showState = CutePetShowInfoView.ShowAssistSkill

	self:_checkAssisSkillStatus()
end

function CutePetShowInfoView:_onClickSkillIntro()
	GameUtil.SetActive(self._skillIntroduce, true)

	local skillList = {}

	for i, v in ipairs(CutePetConfig.instance:getStarSkillCfgs(self._petMo.raceId)) do
		table.insert(skillList, v)
	end

	table.sort(skillList, function(a, b)
		return a.star < b.star
	end)
	self:_recordHeight(skillList)
	self._skillList:reloadData(skillList)
end

function CutePetShowInfoView:_onClickSkillClose()
	GameUtil.SetActive(self._skillIntroduce, false)
end

function CutePetShowInfoView:_onClickRule()
	TipsFacade.instance:openRulesView("cute_pet_show_info_rule")
end

return CutePetShowInfoView
