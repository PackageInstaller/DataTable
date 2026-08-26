-- chunkname: @modules/logic/survival/view/shelter/SurvivalEquipOverView.lua

module("modules.logic.survival.view.shelter.SurvivalEquipOverView", package.seeall)

local SurvivalEquipOverView = class("SurvivalEquipOverView", BaseView)

function SurvivalEquipOverView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_Close")
	self._goLeft = gohelper.findChild(self.viewGO, "Panel/Left")
	self._imageSkill = gohelper.findChildSingleImage(self.viewGO, "Panel/Left/image_Icon")
	self._goEmpty = gohelper.findChild(self.viewGO, "Panel/go_empty")
	self._goScroll = gohelper.findChild(self.viewGO, "Panel/#scroll_List")
	self._goScrollBig = gohelper.findChild(self.viewGO, "Panel/#scroll_ListBig")
	self._godesc = gohelper.findChild(self.viewGO, "Panel/Left/#scroll_Descr/viewport/Content/#txt_Descr")
	self._txtName = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/#txt_Name")
	self._txtTotalScore = gohelper.findChildTextMesh(self.viewGO, "Panel/Assess/image_NumBG/#txt_Num")
	self._imageScore = gohelper.findChildImage(self.viewGO, "Panel/Assess/image_NumBG/#txt_Num/image_AssessIon")
	self._imageFrequency = gohelper.findChildImage(self.viewGO, "Panel/Left/Frequency/item1/image_FrequencyIcon")
	self._txtFrequency = gohelper.findChildTextMesh(self.viewGO, "Panel/Left/Frequency/item1/#txt_Num")
	self._goitemFrequency = gohelper.findChild(self.viewGO, "Panel/Left/Frequency/item2")
	self._btnClick = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/Frequency/#btn_click")
	self._btnSwitch = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/#btn_switch")
	self._txtSwitch = gohelper.findChildTextMesh(self.viewGO, "Panel/#btn_switch/txt_switch")
end

function SurvivalEquipOverView:addEvents()
	self._btnClick:AddClickListener(self._onClickFrequency, self)
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnSwitch:AddClickListener(self.changeSwitch, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnEquipDescSimpleChange, self._refreshView, self)
end

function SurvivalEquipOverView:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnSwitch:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnEquipDescSimpleChange, self._refreshView, self)
end

local scoreColor = {
	"#617B8E",
	"#855AA1",
	"#AF490B"
}

function SurvivalEquipOverView:onOpen()
	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoRoot = gohelper.create2d(self.viewGO, "#go_info")
	local infoGo = self:getResInst(infoViewRes, infoRoot)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setCloseShow(true)
	self._infoPanel:setShowBtns(false)
	self._infoPanel:updateMo()

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes

	self._item = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self._item, false)

	self._equipBox = SurvivalShelterModel.instance:getWeekInfo().equipBox

	local equipFoundCo = lua_survival_equip_found.configDict[self._equipBox.maxTagId]

	gohelper.setActive(self._goLeft, equipFoundCo)
	gohelper.setActive(self._goScroll, equipFoundCo)
	gohelper.setActive(self._goScrollBig, not equipFoundCo)

	self._equipFoundCo = equipFoundCo

	if equipFoundCo then
		self._txtName.text = equipFoundCo.name
	end

	local equips = {}
	local flag = true

	for k, v in pairs(self._equipBox.jewelrySlots) do
		if not v.item:isEmpty() then
			table.insert(equips, {
				type = 1,
				item = v.item,
				isFirst = flag
			})

			flag = false
		end
	end

	flag = true

	for k, v in pairs(self._equipBox.slots) do
		if not v.item:isEmpty() then
			table.insert(equips, {
				type = 2,
				item = v.item,
				isFirst = flag
			})

			flag = false
		end
	end

	self._totalScore = self._equipBox:getAllScore()
	self._equips = equips

	self:_refreshFrequency()
	self:_refreshScore()
	self:_refreshView()
	gohelper.setActive(self._goEmpty, #equips == 0)
	gohelper.setActive(self._btnSwitch, #equips ~= 0)
end

local showIds = {
	[1001] = true,
	[1002] = true,
	[1004] = true
}

function SurvivalEquipOverView:_refreshFrequency()
	if not self._equipFoundCo then
		return
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageFrequency, self._equipFoundCo.value)

	self._txtFrequency.text = self._equipBox.values[self._equipFoundCo.value] or 0

	local others = {}

	for k, v in pairs(self._equipBox.values) do
		if k ~= self._equipFoundCo.value and v > 0 and showIds[k] then
			table.insert(others, {
				key = k,
				value = v
			})
		end
	end

	gohelper.CreateObjList(self, self._createFrequencyItem, others, nil, self._goitemFrequency, nil, nil, nil, 3)
end

function SurvivalEquipOverView:_onClickFrequency()
	local datas = {}

	for k, v in pairs(self._equipBox.values) do
		if v > 0 and showIds[k] then
			local co = lua_survival_attr.configDict[k]

			if co then
				table.insert(datas, {
					title = co.name,
					desc = SkillHelper.buildDesc(co.desc, nil, "#5283ca")
				})
			end
		end
	end

	ViewMgr.instance:openView(ViewName.SurvivalCommonTipsView, {
		list = datas,
		pivot = Vector2(1, 1)
	})
end

function SurvivalEquipOverView:_createFrequencyItem(obj, data, index)
	local imageFrequency = gohelper.findChildImage(obj, "image_FrequencyIcon")
	local txtFrequency = gohelper.findChildTextMesh(obj, "#txt_Num")

	UISpriteSetMgr.instance:setSurvivalSprite(imageFrequency, data.key)

	txtFrequency.text = data.value
end

function SurvivalEquipOverView:_refreshScore()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local worldLevel = weekInfo:getAttr(SurvivalEnum.AttrType.WorldLevel)
	local str = lua_survival_equip_score.configDict[worldLevel][2].level
	local level = 1

	if not string.nilorempty(str) then
		for i, v in ipairs(string.splitToNumber(str, "#")) do
			if v <= self._totalScore then
				level = i + 1
			end
		end
	end

	UISpriteSetMgr.instance:setSurvivalSprite(self._imageScore, "survivalequip_scoreicon_" .. level)

	self._txtTotalScore.text = string.format("<color=%s>%s</color>", scoreColor[level] or scoreColor[1], self._totalScore)
end

function SurvivalEquipOverView:_refreshView()
	local itemGo

	if self._equipFoundCo then
		self._imageSkill:LoadImage(ResUrl.getSurvivalEquipIcon(self._equipFoundCo.icon))

		local list = {}
		local desc = self._equipFoundCo.desc

		if SurvivalModel.instance._isUseSimpleDesc == 1 then
			desc = self._equipFoundCo.desc1
		end

		if not string.nilorempty(desc) then
			local list1 = {}
			local list2 = {}

			for i, v in ipairs(string.split(desc, "|")) do
				local val, active = SurvivalDescExpressionHelper.instance:parstDesc(v, self._equipBox.values)

				if active then
					table.insert(list1, {
						val,
						active
					})
				else
					table.insert(list2, {
						val,
						active
					})
				end
			end

			tabletool.addValues(list, list1)
			tabletool.addValues(list, list2)
		end

		gohelper.CreateObjList(self, self._createDescItem, list, nil, self._godesc)

		itemGo = gohelper.findChild(self._goScroll, "viewport/Content/#go_Item")
	else
		itemGo = gohelper.findChild(self._goScrollBig, "viewport/Content/#go_Item")
	end

	gohelper.CreateObjList(self, self._createEquipItem, self._equips, nil, itemGo)

	self._txtSwitch.text = SurvivalModel.instance._isUseSimpleDesc == 1 and luaLang("survival_equipoverview_simple") or luaLang("survival_equipoverview_exdesc")
end

function SurvivalEquipOverView:changeSwitch()
	SurvivalModel.instance:changeDescSimple()
end

function SurvivalEquipOverView:_createDescItem(obj, data, index)
	local txtDesc = gohelper.findChildTextMesh(obj, "")
	local point = gohelper.findChildImage(obj, "image_Point")
	local descComp = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, SurvivalSkillDescComp)

	descComp:updateInfo(txtDesc, data[1], 3028)
	ZProj.UGUIHelper.SetColorAlpha(txtDesc, data[2] and 1 or 0.5)

	point.color = data[2] and GameUtil.parseColor("#000000") or GameUtil.parseColor("#808080")
end

function SurvivalEquipOverView:_createEquipItem(obj, data, index)
	local desc = gohelper.findChildTextMesh(obj, "#txt_Descr")
	local name = gohelper.findChildTextMesh(obj, "#txt_Descr/#txt_Name")
	local score = gohelper.findChildTextMesh(obj, "#txt_Descr/Assess/image_NumBG/#txt_Num")
	local item = gohelper.findChild(obj, "#txt_Descr/#go_Item")
	local frequencyIcon = gohelper.findChildImage(obj, "#txt_Descr/Assess/image_NumBG/image_FrequencyIcon")
	local frequencyNum = gohelper.findChildTextMesh(obj, "#txt_Descr/Assess/image_NumBG/#txt_FrequencyNum")
	local imageLine = gohelper.findChild(obj, "#txt_Descr/Assess/image_NumBG/image_Line")
	local title = gohelper.findChild(obj, "#go_SmallTitle")
	local title1 = gohelper.findChild(obj, "#go_SmallTitle/#go_Type1")
	local title2 = gohelper.findChild(obj, "#go_SmallTitle/#go_Type2")

	gohelper.setActive(title, data.isFirst)
	gohelper.setActive(title1, data.type == 1)
	gohelper.setActive(title2, data.type == 2)

	if self._equipFoundCo then
		local isShowFrequency = data.type == 2

		gohelper.setActive(frequencyIcon, isShowFrequency)
		gohelper.setActive(frequencyNum, isShowFrequency)
		gohelper.setActive(imageLine, isShowFrequency)

		local list = data.item:getEquipEffectDesc()
		local txt = ""

		for _, v in ipairs(list) do
			if not string.nilorempty(txt) then
				txt = txt .. "\n"
			end

			txt = v[2] and txt .. v[1] or txt .. "<color=#22222280>" .. v[1] .. "</color>"
		end

		local descComp = MonoHelper.addNoUpdateLuaComOnceToGo(desc.gameObject, SurvivalSkillDescComp)

		descComp:updateInfo(desc, txt, 3028)

		name.text = data.item.co.name
		score.text = data.item.equipCo.score + data.item.exScore

		local itemGO = gohelper.clone(self._item, item)

		gohelper.setActive(itemGO, true)

		local itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(itemGO, SurvivalBagItem)

		itemComp:updateMo(data.item)
		itemComp:setClickCallback(self._onClickItem, self)

		if isShowFrequency then
			local tagCo = lua_survival_equip_found.configDict[self._equipBox.maxTagId]

			if tagCo then
				UISpriteSetMgr.instance:setSurvivalSprite(frequencyIcon, tagCo.value)

				frequencyNum.text = data.item.equipValues[tagCo.value] or 0
			end
		end
	end
end

function SurvivalEquipOverView:_onClickItem(item)
	self._infoPanel:updateMo(item._mo)
end

function SurvivalEquipOverView:onClickModalMask()
	self:closeThis()
end

return SurvivalEquipOverView
