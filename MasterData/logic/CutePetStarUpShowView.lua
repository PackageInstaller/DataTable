-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/showInfo/CutePetStarUpShowView.lua

module("logic.extensions.cutepet.view.CutePetStarUpShowView", package.seeall)

local CutePetStarUpShowView = class("CutePetStarUpShowView", ViewComponent)

function CutePetStarUpShowView:ctor()
	CutePetStarUpShowView.super.ctor(self)
end

function CutePetStarUpShowView:unbindEvents()
	CutePetStarUpShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutePetStarUpShowView:bindEvents()
	CutePetStarUpShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function CutePetStarUpShowView:buildUI()
	CutePetStarUpShowView.super.buildUI(self)

	self._tableView = self:getGo("attrs/attrsScr")
	self._tableCell = self:getGo("attrs/cell")
	self._petCon = self:getGo("itemCell/item")
	self._txtPetName = self:getTxt("itemCell/nameText")
	self._petInfoStarList = {}

	for i = 1, 6 do
		table.insert(self._petInfoStarList, {
			star = self:getGo("itemCell/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "itemCell/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._skillStarList = {}

	for i = 1, 6 do
		table.insert(self._skillStarList, {
			star = self:getGo("attrs/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "attrs/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._txtSkillInfo = self:getTxt("attrs/txtDesc")
	self._btnClose = GameUtil.asBtn(self:getGo("viewBoxGo"))
end

function CutePetStarUpShowView:onExit()
	CutePetStarUpShowView.super.onExit(self)

	if self._effs then
		for _, eff in ipairs(self._effs) do
			UIEffectManager.instance:stopEffect(eff)

			eff = nil
		end
	end

	MaterialMgr.resetAll(self._petCon)
end

function CutePetStarUpShowView:onEnter()
	CutePetStarUpShowView.super.onEnter(self)

	local params = self:getOpenParam()

	self._petId = params[1]
	self._petMo = CutePetModel.instance:getCutePeMo(self._petId)

	if not self._petMo or self._petMo.curStar < 2 then
		self:close()
	end

	self._attrList = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	local attr = {}
	local result = {}

	result = self._petMo.curStar > 1 and self._petMo:calcAttr(nil, nil, self._petMo.curStar - 1) or self._petMo.attr

	local attrSort = self._petMo:getSortAttrList(result)

	for i, v in ipairs(attrSort) do
		if checknumber(self._petMo.attr[v]) ~= checknumber(result[v]) and checknumber(result[v]) > 0 then
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
	self._maxStar = CutePetConfig.instance:getMaxStar(self._petMo.config.starUpPlan, self._petMo.curQuality)

	for i = 1, #self._petInfoStarList do
		if i <= self._petMo.curStar then
			self._petInfoStarList[i].starChange:SetState(0)
		else
			self._petInfoStarList[i].starChange:SetState(1)
		end

		if i <= self._maxStar then
			GameUtil.SetActive(self._petInfoStarList[i].star, true)
		else
			GameUtil.SetActive(self._petInfoStarList[i].star, false)
		end
	end

	for i = 1, #self._skillStarList do
		if i <= self._petMo.curStar then
			self._skillStarList[i].starChange:SetState(0)
		else
			self._skillStarList[i].starChange:SetState(1)
		end

		if i <= self._petMo.curStar then
			GameUtil.SetActive(self._skillStarList[i].star, true)
		else
			GameUtil.SetActive(self._skillStarList[i].star, false)
		end
	end

	local starSkillCfg = CutePetConfig.instance:getStarSkillCfg(self._petMo.raceId, self._petMo.curStar)

	self._txtSkillInfo.text = starSkillCfg.starBuffsDesc
end

function CutePetStarUpShowView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local attrIcon = goutil.findChildComponent(go, "attrIcon", "UIImageSpriteChange")
	local txtAttrName = goutil.findChildTextComponent(go, "txtName")
	local txtNow = goutil.findChildTextComponent(go, "txtNow")
	local txtNext = goutil.findChildTextComponent(go, "txtNext")
	local bgChange = goutil.findChildComponent(go, "bg", "UIImageColorChange")

	attrIcon:SetState(data.attrType - 1)

	txtAttrName.text = GameEnum.AttrTypeName[data.attrType]

	bgChange:SetState(data.index % 2)

	txtNow.text = data.nowNum >= 1 and string.format("%d", math.floor(data.nowNum)) or string.format("%.2f%%", data.nowNum * 100)
	txtNext.text = data.nextNum >= 1 and string.format("%d", math.floor(data.nextNum)) or string.format("%.2f%%", data.nextNum * 100)
end

function CutePetStarUpShowView:_clearCell(cell)
	return
end

return CutePetStarUpShowView
