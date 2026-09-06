-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetQualityUpShowView.lua

module("logic.extensions.cutepet.view.CutePetQualityUpShowView", package.seeall)

local CutePetQualityUpShowView = class("CutePetQualityUpShowView", ViewComponent)

function CutePetQualityUpShowView:ctor()
	CutePetQualityUpShowView.super.ctor(self)
end

function CutePetQualityUpShowView:unbindEvents()
	CutePetQualityUpShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutePetQualityUpShowView:bindEvents()
	CutePetQualityUpShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutePetQualityUpShowView:buildUI()
	CutePetQualityUpShowView.super.buildUI(self)

	self._tableView = self:getGo("attrs/attrsScr")
	self._tableCell = self:getGo("attrs/cell")
	self._petCon = self:getGo("itemCell/item")
	self._txtPetName = self:getTxt("itemCell/nameText")
	self._starInfo = self:getGo("starLimitUpInfo")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("starLimitUpInfo/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "starLimitUpInfo/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._starNextList = {}

	for i = 1, 6 do
		table.insert(self._starNextList, {
			star = self:getGo("starLimitUpInfo/starLvNext/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "starLimitUpInfo/starLvNext/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._txtSkillInfo = self:getTxt("attrs/txtDesc")
	self._btnClose = GameUtil.asBtn(self:getGo("viewBoxGo"))
end

function CutePetQualityUpShowView:onExit()
	CutePetQualityUpShowView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	MaterialMgr.resetAll(self._petCon)
end

function CutePetQualityUpShowView:onEnter()
	CutePetQualityUpShowView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petId = params[1]
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo or self._petMo.curQuality < 2 then
		self:close()
	end

	self._attrList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local attr = {}
	local result = {}

	result = self._petMo.curQuality > 1 and self._petMo:calcAttr(self._petMo.curQuality - 1, nil, nil) or self._petMo.attr

	local attrSort = self._petMo:getSortAttrList()

	for i, v in ipairs(attrSort) do
		if checknumber(self._petMo.attr[v]) ~= checknumber(result[v]) then
			table.insert(attr, {
				attrType = v,
				nextNum = checknumber(self._petMo.attr[v]),
				nowNum = result[v]
			})
		end
	end

	for i, v in ipairs(attr) do
		v.index = i
	end

	self._attrList:reloadData(attr)
	MaterialMgr.setCellByMo(self._petMo, self._petCon)

	self._txtPetName.text = self._petMo.name
	self._maxStar = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality - 1)

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

	self._maxStarNext = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality)

	for i = 1, #self._starNextList do
		if i <= self._petMo.curStar then
			self._starNextList[i].starChange:SetState(0)
		else
			self._starNextList[i].starChange:SetState(1)
		end

		if i <= self._maxStarNext then
			GameUtil.SetActive(self._starNextList[i].star, true)
		else
			GameUtil.SetActive(self._starNextList[i].star, false)
		end
	end

	GameUtil.SetActive(self._starInfo, self._maxStar ~= self._maxStarNext)

	local skillCfg = CutePetConfig.instance:getAssistanceCfg(self._petMo.config.type, self._petMo.curQuality)

	self._txtSkillInfo.text = skillCfg.desc
end

function CutePetQualityUpShowView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local attrIcon = goutil.findChildComponent(go, "attrIcon", "UIImageSpriteChange")
	local txtAttrName = goutil.findChildTextComponent(go, "txtName")
	local txtNow = goutil.findChildTextComponent(go, "txtNow")
	local txtNext = goutil.findChildTextComponent(go, "txtNext")
	local bgChange = goutil.findChildComponent(go, "bg", "UIImageColorChange")
	local tagNew = goutil.findChild(go, "tagNew")

	attrIcon:SetState(data.attrType - 1)

	txtAttrName.text = GameEnum.AttrTypeName[data.attrType]

	bgChange:SetState(data.index % 2)

	txtNow.text = not data.nowNum and (data.nextNum >= 1 and "0" or "0%") or data.nowNum >= 1 and string.format("%d", math.floor(data.nowNum)) or string.format("%.2f%%", data.nowNum * 100)
	txtNext.text = data.nextNum >= 1 and string.format("%d", math.floor(data.nextNum)) or string.format("%.2f%%", data.nextNum * 100)

	GameUtil.SetActive(tagNew, not data.nowNum)
end

function CutePetQualityUpShowView:_clearCell(cell)
	return
end

return CutePetQualityUpShowView
