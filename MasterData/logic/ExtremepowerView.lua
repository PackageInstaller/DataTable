-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/ExtremepowerView.lua

module("logic.extensions.handbook.view.ExtremepowerView", package.seeall)

local ExtremepowerView = class("ExtremepowerView", ViewComponent)

function ExtremepowerView:ctor()
	ExtremepowerView.super.ctor(self)
end

function ExtremepowerView:unbindEvents()
	ExtremepowerView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
end

function ExtremepowerView:bindEvents()
	ExtremepowerView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
end

function ExtremepowerView:buildUI()
	ExtremepowerView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.title = self:getGo("title")
	self.cell = self:getGo("cell")
	self.tableview = self:getGo("tableview")
	self.imgNum = self:getGo("totalPower/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.scrollList = ScrollerList.create(self.tableview, {
		self.title,
		self.cell
	}, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:regGetTagByIdx(GameUtil.handler(self.getCellTag, self))
end

function ExtremepowerView:onExit()
	ExtremepowerView.super.onExit(self)
	self.scrollList:dispose()
end

function ExtremepowerView:onEnter()
	ExtremepowerView.super.onEnter(self)

	self.closeGroup = {}

	local petMo = self:getFirstParam()

	if petMo then
		self.curPetMo = petMo

		local maxMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(petMo.raceId)

		self.maxPetMo = maxMo

		self.imgNum:SetNum(maxMo:getFightingPower())
		self:updateList()
	end
end

function ExtremepowerView:onClickTitle(data)
	self.closeGroup[data.group] = not checkbool(self.closeGroup[data.group])

	self:updateList()
end

function ExtremepowerView:updateList()
	local petMo = self:getFirstParam()
	local petCfg = CharacterConfig.instance:getPetCo(petMo.raceId)
	local list = HandbookConfig.instance:getPowerCheckDetailList()
	local temp = {}

	for i, v in ipairs(list) do
		if v.tag == 1 then
			table.insert(temp, v)
		elseif self.closeGroup[v.group] == true then
			-- block empty
		elseif v.value == "petSourceTraceAttr" then
			if PetSkinConfig.instance:checkHasJob(petCfg.raceId, GameEnum.JobZhDefine.SourceTrace) then
				table.insert(temp, v)
			end
		else
			table.insert(temp, v)
		end
	end

	self.scrollList:reloadData(temp)
end

function ExtremepowerView:getCellTag(data, idx)
	return data.tag
end

local TipsMap = {
	petHolyStripesAttr = "extremepowerview_other_tips_1"
}

function ExtremepowerView:_updateCell(view, cell, data, tag)
	if tag == 1 then
		local txt = goutil.findChildTextComponent(cell, "txt")
		local up = goutil.findChild(cell, "up")
		local down = goutil.findChild(cell, "down")
		local top = goutil.findChild(cell, "top")

		txt.text = data.keyName

		GameUtil.SetActive(up, not self.closeGroup[data.group] == true)
		GameUtil.SetActive(down, self.closeGroup[data.group] == true)
		GameUtil.addClickHandler(top, GameUtil.handler(self.onClickTitle, self, data))
	else
		local txtName = goutil.findChildTextComponent(cell, "txtName")
		local tips = goutil.findChild(cell, "txtName/tips")
		local btnTip = goutil.findChild(cell, "txtName/tips/btnTip")
		local txtLowest = goutil.findChildTextComponent(cell, "txtLowest")
		local txtMax = goutil.findChildTextComponent(cell, "txtMax")
		local txtPower = goutil.findChildTextComponent(cell, "slider/FillArea/Fill/txtPower")
		local txtExtreme = goutil.findChildTextComponent(cell, "extreme/txt")
		local sliderGo = goutil.findChild(cell, "slider")
		local maxGo = goutil.findChild(cell, "slider/MAX")
		local slider = Framework.SliderAdapter.Get(sliderGo)

		txtName.text = data.keyName
		txtLowest.text = data.minDesc
		txtMax.text = data.maxDesc

		local zdl = 0
		local maxZdl = 1

		GameUtil.SetActive(tips, false)

		if data.value == "OTHER_ATTR" then
			GameUtil.SetActive(tips, true)

			local attrMo = self.curPetMo.attrMo
			local attr = attrMo.withoutPercentTotalAttr
			local ot = AttrMo.calcFightPowerByAttrs(attr)

			zdl = self.curPetMo:getFightingPower() - ot

			local attrMo = self.maxPetMo.attrMo
			local attr = attrMo.withoutPercentTotalAttr
			local ot = AttrMo.calcFightPowerByAttrs(attr)

			maxZdl = self.maxPetMo:getFightingPower() - ot

			GameUtil.addClickHandler(btnTip, function()
				CommonTipsMgr.instance:showTips(lang("extremepowerview_other_tips"), btnTip)
			end)
		else
			local attrMo = self.curPetMo.attrMo
			local attr = attrMo[data.value]

			zdl = AttrMo.calcFightPowerByAttrs(attr)

			local maxMo = self.maxPetMo.attrMo
			local attr2 = maxMo[data.value]

			maxZdl = AttrMo.calcFightPowerByAttrs(attr2)

			local tipsLang = TipsMap[data.value]

			if not string.nilorempty(tipsLang) then
				GameUtil.SetActive(tips, true)
				GameUtil.addClickHandler(btnTip, function()
					CommonTipsMgr.instance:showTips(lang(tipsLang), btnTip)
				end)
			end
		end

		GameUtil.SetActive(maxGo, maxZdl <= zdl)

		txtPower.text = maxZdl <= zdl and "" or langPara("extremepowerview__zdl", zdl)
		txtExtreme.text = langPara("extremepowerview__maxZdl", maxZdl)

		slider:SetValue(math.min(1, zdl / maxZdl))
	end
end

function ExtremepowerView:clearCell(cell)
	return
end

return ExtremepowerView
