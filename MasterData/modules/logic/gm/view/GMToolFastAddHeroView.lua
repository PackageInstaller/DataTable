-- chunkname: @modules/logic/gm/view/GMToolFastAddHeroView.lua

module("modules.logic.gm.view.GMToolFastAddHeroView", package.seeall)

local GMToolFastAddHeroView = class("GMToolFastAddHeroView", BaseView)

function GMToolFastAddHeroView:onInitView()
	self._goinputcontainer = gohelper.findChild(self.viewGO, "container/#go_inputcontainer")
	self._goinptucontainer = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer")
	self._goheroid = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid")
	self._inputheroid = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/#input_heroid")
	self._goherolv = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv")
	self._inputherolv = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_herolv/#input_herolv")
	self._goranklv = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv")
	self._inputranklv = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/#input_ranklv")
	self._gotalentlv = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv")
	self._inputtalentlv = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/#input_talentlv")
	self._goexskilllv = gohelper.findChild(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv")
	self._inputexskilllv = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/#input_exskilllv")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_inputcontainer/#btn_fastadd")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "container/#go_inputcontainer/#btn_switch")
	self._goherolistcontainer = gohelper.findChild(self.viewGO, "container/#go_herolistcontainer")
	self._inputfilter = gohelper.findChildTextMeshInputField(self.viewGO, "container/#go_herolistcontainer/#input_filter")
	self._goheroitem = gohelper.findChild(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem")
	self._txtheroname = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_heroname")
	self._txtherolv = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_herolv")
	self._txtranklv = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_ranklv")
	self._txttalentlv = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_talentlv")
	self._txtexskilllv = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/scroll/Viewport/Content/#go_heroitem/#txt_exskilllv")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_close")
	self._goaddItem = gohelper.findChild(self.viewGO, "container/#go_addItem")
	self._goitem = gohelper.findChild(self.viewGO, "container/#go_addItem/scroll/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GMToolFastAddHeroView:addEvents()
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function GMToolFastAddHeroView:removeEvents()
	self._btnfastadd:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function GMToolFastAddHeroView:_btncloseOnClick()
	self:closeThis()
end

function GMToolFastAddHeroView:_btnfastaddOnClick()
	if self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		local heroId = tonumber(self._inputheroid:GetText())

		if not heroId then
			return
		end

		local heroLv = tonumber(self._inputherolv:GetText()) or 180
		local rankLv = tonumber(self._inputranklv:GetText()) or 3
		local talentLv = tonumber(self._inputtalentlv:GetText()) or 10
		local exskillLv = tonumber(self._inputexskilllv:GetText()) or 0

		GameFacade.showToast(ToastEnum.GMToolFastAddHero, string.format(" 等级%d 洞悉%d 共鸣%d 塑造%d", heroLv, rankLv, talentLv, exskillLv))
		GMRpc.instance:sendGMRequest(string.format("add heroAttr %d#%d#%d#%d#%d", heroId, heroLv, rankLv, talentLv, exskillLv))
	elseif self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		local equipId = tonumber(self._inputheroid:GetText())

		if not equipId then
			return
		end

		local equipLv = tonumber(self._inputherolv:GetText()) or 1
		local refineLv = tonumber(self._inputranklv:GetText()) or 0

		GMRpc.instance:sendGMRequest(string.format("add equip %d#%d#%d", equipId, equipLv, refineLv))
	end
end

function GMToolFastAddHeroView:_btnswitchOnClick()
	GMFastAddHeroHadHeroItemModel.instance:changeShowType()

	self.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()
	self.filterText = ""

	self:refreshUI()
end

function GMToolFastAddHeroView:_editableInitView()
	self._txtheroidlabel = gohelper.findChildText(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_heroid/label")
	self._txtranklvlabel = gohelper.findChildText(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_ranklv/label")
	self._txttalentlvlabel = gohelper.findChildText(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_talentlv/label")
	self._txtexskilllvlabel = gohelper.findChildText(self.viewGO, "container/#go_inputcontainer/#go_inptucontainer/#go_exskilllv/label")
	self._txtnewlabel = gohelper.findChildText(self.viewGO, "container/#go_inputcontainer/newlabelbutton/#txt_newlabel")
	self._txthadlabel = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/hadlabelbutton/#txt_hadlabel")
	self._txtplaceholder = gohelper.findChildText(self.viewGO, "container/#go_herolistcontainer/#input_filter/textarea/Placeholder")

	gohelper.setActive(self._goaddItem, false)
	gohelper.setActive(self._goitem, false)
	gohelper.setActive(self._goheroitem, false)

	self.heroIdClick = gohelper.getClick(self._goheroid)

	self.heroIdClick:AddClickListener(self.onClickHeroId, self)

	self.addItemClick = gohelper.getClick(self._goaddItem)

	self.addItemClick:AddClickListener(self.onClickAddItem, self)

	self.inputHeroIdClick = gohelper.getClick(self._inputheroid.gameObject)

	self.inputHeroIdClick:AddClickListener(self.onClickHeroId, self)
	self._inputfilter:AddOnValueChanged(self.inputFilterValueChange, self)

	self.filterText = ""
end

function GMToolFastAddHeroView:onClickHeroId()
	self:showAddItemContainer()
end

function GMToolFastAddHeroView:onClickAddItem()
	self:hideAddItemContainer()
end

function GMToolFastAddHeroView:inputFilterValueChange(text)
	if self.filterText ~= text then
		self.filterText = text

		self:refreshHaveHeroList()
	end
end

function GMToolFastAddHeroView:onUpdateParam()
	return
end

function GMToolFastAddHeroView:onOpen()
	GMAddItemModel.instance:setFastAddHeroView(self)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(self)
	GMFastAddHeroHadHeroItemModel.instance:setShowType(GMFastAddHeroHadHeroItemModel.ShowType.Hero)

	self.showType = GMFastAddHeroHadHeroItemModel.instance:getShowType()

	self:refreshUI()
	self:resetInputText()
	self._inputfilter:SetText("")
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshHaveHeroList, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.refreshHaveHeroList, self)
end

function GMToolFastAddHeroView:refreshUI()
	self:refreshAddItemCoList()
	self:refreshHaveHeroList()
	self:refreshLabelUI()
end

function GMToolFastAddHeroView:refreshLabelUI()
	if self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		self:showHeroLabelUI()
	elseif self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		self:showEquipLabelUI()
	else
		self:showHeroLabelUI()
	end
end

function GMToolFastAddHeroView:showEquipLabelUI()
	self._txtheroidlabel.text = "装备ID"
	self._txtranklvlabel.text = "精炼"
	self._txttalentlvlabel.text = ""
	self._txtexskilllvlabel.text = ""

	gohelper.setActive(self._inputexskilllv.gameObject, false)
	gohelper.setActive(self._inputtalentlv.gameObject, false)

	self._txtnewlabel.text = "新增装备"
	self._txthadlabel.text = "已有装备"
	self._txtplaceholder.text = "搜索装备..."
end

function GMToolFastAddHeroView:showHeroLabelUI()
	self._txtheroidlabel.text = "角色ID"
	self._txtranklvlabel.text = "洞悉"
	self._txttalentlvlabel.text = "共鸣"
	self._txtexskilllvlabel.text = "塑造"

	gohelper.setActive(self._inputexskilllv.gameObject, true)
	gohelper.setActive(self._inputtalentlv.gameObject, true)

	self._txtnewlabel.text = "新增英雄"
	self._txthadlabel.text = "已有英雄"
	self._txtplaceholder.text = "搜索英雄..."
end

function GMToolFastAddHeroView:onAddItemOnClick(characterCo)
	self:hideAddItemContainer()
	self:resetInputText()
	self._inputheroid:SetText(characterCo.id)

	if self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
		self:refreshCharacterCoShow(characterCo)
	elseif self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
		self:refreshEquipCoShow(characterCo)
	else
		self:refreshCharacterCoShow(characterCo)
	end
end

function GMToolFastAddHeroView:refreshCharacterCoShow(characterCo)
	local heroMo = HeroModel.instance:getByHeroId(characterCo.id)

	if heroMo then
		self._inputherolv:SetText(heroMo.level)
		self._inputranklv:SetText(heroMo.rank)
		self._inputtalentlv:SetText(heroMo.talent)
		self._inputexskilllv:SetText(heroMo.exSkillLevel)
	end
end

function GMToolFastAddHeroView:refreshEquipCoShow(equipCo)
	self._inputherolv:SetText(1)
	self._inputranklv:SetText(1)
	self._inputtalentlv:SetText(1)
end

function GMToolFastAddHeroView:showAddItemContainer()
	gohelper.setActive(self._goaddItem, true)
end

function GMToolFastAddHeroView:hideAddItemContainer()
	gohelper.setActive(self._goaddItem, false)
end

function GMToolFastAddHeroView:resetInputText()
	self._inputheroid:SetText("")
	self._inputherolv:SetText("")
	self._inputranklv:SetText("")
	self._inputtalentlv:SetText("")
	self._inputexskilllv:SetText("")
end

function GMToolFastAddHeroView:refreshAddItemCoList()
	local coList = {
		{
			id = 0,
			name = "All",
			rare = 5
		}
	}
	local tempList = self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero and lua_character.configList or self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip and lua_equip.configList or lua_character.configList
	local len = #tempList

	for i = len, 1, -1 do
		table.insert(coList, tempList[i])
	end

	GMAddItemModel.instance:setList(coList)
end

function GMToolFastAddHeroView:refreshHaveHeroList()
	local moList

	GMFastAddHeroHadHeroItemModel.instance:refreshList(self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero and self:getHeroMoList() or self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip and self:getEquipMoList() or {})
end

function GMToolFastAddHeroView:getHeroMoList()
	local heroList = {}

	if string.nilorempty(self.filterText) then
		heroList = HeroModel.instance:getList()
	else
		for _, heroMo in ipairs(HeroModel.instance:getList()) do
			if string.match(heroMo.config.name, self.filterText) then
				table.insert(heroList, heroMo)
			end
		end
	end

	return heroList
end

function GMToolFastAddHeroView:getEquipMoList()
	local equipList = {}

	if string.nilorempty(self.filterText) then
		for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
			table.insert(equipList, equipMo)
		end
	else
		for _, equipMo in ipairs(EquipModel.instance:getEquips()) do
			if string.match(equipMo.config.name, self.filterText) then
				table.insert(equipList, equipMo)
			end
		end
	end

	local needDeleteEquipMo = {}

	for _, equipMo in ipairs(equipList) do
		if equipMo == nil or equipMo.config == nil then
			logError(string.format("equipId %s not config, uid is %s", equipMo.equipId, equipMo.id))
			table.insert(needDeleteEquipMo, equipMo)
		end
	end

	for _, value in ipairs(needDeleteEquipMo) do
		local index = tabletool.indexOf(equipList, value)

		table.remove(equipList, index)
	end

	return equipList
end

function GMToolFastAddHeroView:changeSelectHeroItemMo(mo)
	if mo then
		self._inputheroid:SetText(mo.config.id)
		self._inputherolv:SetText(mo.level)

		if self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Hero then
			self._inputranklv:SetText(mo.rank)
			self._inputtalentlv:SetText(mo.talent)
			self._inputexskilllv:SetText(mo.exSkillLevel)
		elseif self.showType == GMFastAddHeroHadHeroItemModel.ShowType.Equip then
			self._inputranklv:SetText(mo.refineLv)
			self._inputtalentlv:SetText(mo.breakLv)
		else
			self._inputranklv:SetText(mo.rank)
			self._inputtalentlv:SetText(mo.talent)
			self._inputexskilllv:SetText(mo.exSkillLevel)
		end
	else
		self._inputheroid:SetText("")
		self._inputherolv:SetText("")
		self._inputranklv:SetText("")
		self._inputtalentlv:SetText("")
		self._inputexskilllv:SetText("")
	end
end

function GMToolFastAddHeroView:onClose()
	self.heroIdClick:RemoveClickListener()
	self.addItemClick:RemoveClickListener()
	self.inputHeroIdClick:RemoveClickListener()
	self._inputfilter:RemoveOnValueChanged()
	GMAddItemModel.instance:setFastAddHeroView(nil)
	GMFastAddHeroHadHeroItemModel.instance:setFastAddHeroView(nil)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshHaveHeroList, self)
	self.removeEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.refreshHaveHeroList, self)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function GMToolFastAddHeroView:onDestroyView()
	return
end

return GMToolFastAddHeroView
