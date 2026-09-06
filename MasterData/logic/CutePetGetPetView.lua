-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutePetGetPetView.lua

module("logic.extensions.cutepet.view.CutePetGetPetView", package.seeall)

local CutePetGetPetView = class("CutePetGetPetView", ViewComponent)
local inputLenLimit = 7
local regex = "^[\\u4E00-\\u9FA5A-Za-z0-9_]+$"
local resultCode = {}

resultCode[0] = "宠物名可以由<color=#ffffff>2-7个汉字、大写字母、小写字母、数字、下划线</color>组成。"
resultCode[-13526] = "宠物名不可为空"
resultCode[-13530] = "宠物名字不能<color=#ffffff>少于2个汉字或字母</color>哦！"
resultCode[-13528] = "宠物名字太长了"
resultCode[-1505] = "有些字不太合适宠物哦，再想想看？"
resultCode[-1513] = "宠物名字格式有误哦(只能由汉字、字母、数字和下划线等组成，且不能全为数字或下划线)"
CutePetGetPetView.ShowAssistSkill = 1
CutePetGetPetView.ShowTalentSkill = 2

function CutePetGetPetView:ctor()
	CutePetGetPetView.super.ctor(self)
end

function CutePetGetPetView:buildUI()
	CutePetGetPetView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnClose_2 = self:getGo("btnClose_2")
	self._btnSure = self:getGo("btnGet")
	self._btnCancel = self:getGo("btnAbandon")
	self._inputName = self:getInput("petInfo/InputC_Search")

	self._inputName:SetCharacterLimit(inputLenLimit)

	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("petInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "petInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._imgType = goutil.findChildComponent(self.mainGO, "petInfo/imgType", "UIImageSpriteChange")
	self._txtTypeName = self:getTxt("petInfo/txtTypeName")
	self._imgQualityChange = goutil.findChildComponent(self.mainGO, "petInfo/imgQuality", "UIImageSpriteChange")
	self._txtName = self:getTxt("petInfo/cutePetName/txtName")
	self._txtLevel = self:getTxt("petInfo/txtLevel")
	self._attrTable = self:getGo("petInfo/attrInfo/ScrollView")
	self._attrCell = self:getGo("petInfo/attrInfo/attrCell")
	self._txtSkill = self:getTxt("petInfo/skillInfo/starSkill/ScrollView/Viewport/txtDesc")
	self._petCon = self:getGo("petInfo/petCon")
	self._btnTalent = self:getGo("petInfo/skillInfo/assistanceSkill/btnTalent")
	self._changeTalent = self._btnTalent:GetComponent(typeof(UIChangeGroup))
	self._btnAssistance = self:getGo("petInfo/skillInfo/assistanceSkill/btnAssistance")
	self._changeAssistance = self._btnAssistance:GetComponent(typeof(UIChangeGroup))
	self._assistanceSkill = self:getTxt("petInfo/skillInfo/assistanceSkill/txtDesc")
	self._txtScore = self:getTxt("score/txt")
end

function CutePetGetPetView:bindEvents()
	CutePetGetPetView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnCancel, self._onClickCancel, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnClose_2, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnTalent, self._onClickTalent, self)
	GameUtil.addClickHandler(self._btnAssistance, self._onClickAssistance, self)
	self._inputName:AddOnValueChanged(self._onValueChanged, self)
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):AddClickListener(self._onClickInput, self, nil)
end

function CutePetGetPetView:unbindEvents()
	CutePetGetPetView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnClose_2)
	GameUtil.rmClickHandler(self._btnTalent)
	GameUtil.rmClickHandler(self._btnAssistance)
	self._inputName:RemoveOnValueChanged()
	Framework.UIClickTrigger.Get(self._inputName.input.gameObject):RemoveClickListener()
end

function CutePetGetPetView:onExit()
	CutePetGetPetView.super.onExit(self)
	CutePetModelMgr.instance:popViewWithModel(self._viewPresentor.viewName)
end

function CutePetGetPetView:destroyUI()
	CutePetGetPetView.super.destroyUI(self)
end

function CutePetGetPetView:onEnter()
	CutePetGetPetView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_GainOrFreeGuestHouseSlotCutePetResp, self.close, self)
	self.addGEvent(self, GlobalNotify.handlePM_ReleaseCutePetResp, self.close, self)

	local params = self:getOpenParam()

	self._petMo = params[1]
	self._sureHandler = params[2]
	self._cancelHandler = params[3]
	self._closeHandler = params[4]
	self._attrList = ScrollerList.create(self._attrTable, self._attrCell, GameUtil.handler(self._updateAttrCell, self), GameUtil.handler(self._clearAttrCell, self))
	self._txtName.text = self._petMo.name

	self._imgQualityChange:SetState(self._petMo.curQuality - 1)

	self._txtLevel.text = self._petMo.curLvl

	local typeCfg = CutePetConfig.instance:getPetTypeCfg(self._petMo.config.type)

	self._txtTypeName.text = typeCfg.name

	self._imgType:SetState(typeCfg.type - 1)
	CutePetModelMgr.instance:pushViewWithModel(self._petCon, self._viewPresentor.viewName, 1, 1, 180)

	local list = {}
	local attrSort = self._petMo:getSortAttrList()

	for i, v in ipairs(attrSort) do
		table.insert(list, {
			attrType = v,
			num = self._petMo.attr[v]
		})
	end

	self._initProps = self._petMo:getInitialActiveProps()

	self._attrList:reloadData(list)

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

	self._showState = CutePetGetPetView.ShowTalentSkill

	self:_checkAssisSkillStatus()

	local skillCfg = CutePetConfig.instance:getStarSkillCfg(self._petMo.raceId, self._petMo.curStar)

	self._txtSkill.text = skillCfg.starBuffsDesc
	self._curName = self._petMo.name

	self._inputName:SetText(self._curName)

	self._txtScore.text = langPara("萌宠评分：%d", self._petMo.score)

	CutePetModelMgr.instance:resetModel(1, self._petMo.config.modelId)
	CutePetModelMgr.instance:setOffset(1, CutePetConfig.instance:getPetOffsetInDefaultView(self._petMo.config.raceId))
end

function CutePetGetPetView:_updateAttrCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local txtQuality = goutil.findChildTextComponent(go, "txtQuality")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")
	local txtColorChange = goutil.findChildComponent(go, "txtQuality", "UITextColorChange")
	local typeChange = goutil.findChildComponent(go, "icon", "UIImageSpriteChange")

	txtType.text = GameEnum.AttrTypeName[data.attrType]

	typeChange:SetState(data.attrType - 1)

	txtNum.text = data.num >= 1 and string.format("%d", math.floor(data.num)) or string.format("%.2f%%", data.num * 100)

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

function CutePetGetPetView:_clearAttrCell(cell)
	return
end

function CutePetGetPetView:_onClickInput()
	if self._inputName.input.isFocused then
		-- block empty
	end
end

function CutePetGetPetView:_showTips(status)
	FloatWordMgr.instance:show(lang(resultCode[status] or ""))
end

function CutePetGetPetView:_onValueChanged()
	local value = self._inputName:GetText()
	local t = StringUtil.utf8split(value)
	local result = ""
	local count = math.min(inputLenLimit, #t)

	for i = 1, count do
		result = result .. t[i]
	end

	self._inputName:SetText(result)
end

function CutePetGetPetView:_checkNameValid(name)
	local realLen, isAllNum, isAllUnderLine = LoginConfig.instance:getNameRealLen(name)
	local isValid = false

	if string.len(name) == 0 then
		self:_showTips(-13526)
	elseif not System.Text.RegularExpressions.Regex.IsMatch(name, regex) then
		self:_showTips(-13530)
	elseif realLen < 2 then
		self:_showTips(-13526)
	elseif isAllNum then
		self:_showTips(-1513)
	elseif isAllUnderLine then
		self:_showTips(-1513)
	elseif realLen > inputLenLimit then
		self:_showTips(-13528)
	else
		isValid = true
	end

	return isValid
end

function CutePetGetPetView:_checkAssisSkillStatus()
	if self._showState == CutePetGetPetView.ShowAssistSkill then
		self._changeTalent:SetState(1)
		self._changeAssistance:SetState(0)

		local assistanceCfg = CutePetConfig.instance:getAssistanceCfg(self._petMo.config.type, self._petMo.curQuality)

		self._assistanceSkill.text = assistanceCfg.desc
	elseif self._showState == CutePetGetPetView.ShowTalentSkill then
		self._changeTalent:SetState(0)
		self._changeAssistance:SetState(1)

		local talentCfg = CutePetConfig.instance:getTalentCfg(self._petMo.initialTalent)

		self._assistanceSkill.text = talentCfg.desc
	end
end

function CutePetGetPetView:_onClickSure()
	self._curName = self._inputName:GetText()

	local isValid = self:_checkNameValid(self._curName)

	if isValid == true then
		if self._sureHandler then
			if GameUtil.callBack(self._sureHandler, self._curName) == true then
				self:close()
			end
		else
			self:close()
		end
	end
end

function CutePetGetPetView:_onClickCancel()
	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	if self._cancelHandler then
		UIStateManager.instance:push(ViewName.CutePetReleaseView, self._petMo, self._cancelHandler)
	else
		self:close()
	end
end

function CutePetGetPetView:_onClickClose()
	if self._closeHandler then
		GameUtil.callBack(self._closeHandler)
		self:close()
	else
		self:close()
	end
end

function CutePetGetPetView:_onClickTalent()
	self._showState = CutePetGetPetView.ShowTalentSkill

	self:_checkAssisSkillStatus()
end

function CutePetGetPetView:_onClickAssistance()
	self._showState = CutePetGetPetView.ShowAssistSkill

	self:_checkAssisSkillStatus()
end

return CutePetGetPetView
