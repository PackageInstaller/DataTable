-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/view/GlorycutepetsimpletipView.lua

module("logic.extensions.glorybattle.view.GloryGlorycutepetsimpletipView", package.seeall)

local GlorycutepetsimpletipView = class("GlorycutepetsimpletipView", ViewComponent)

function GlorycutepetsimpletipView:ctor()
	GlorycutepetsimpletipView.super.ctor(self)

	self._clearGo = {}
end

function GlorycutepetsimpletipView:buildUI()
	GlorycutepetsimpletipView.super.buildUI()

	self._Nego_Content = self:getGo("Nego_Content")
	self._txtName = self:getTxt("Nego_Content/Nego_Top/TxtC_Name")
	self._txtLv = self:getTxt("Nego_Content/Nego_Top/TxtC_Level")
	self._itemGo = self:getGo("Nego_Content/Nego_Top/ImgC_Con")
	self._starList = {}

	for i = 1, 6 do
		table.insert(self._starList, {
			star = self:getGo("Nego_Content/Nego_Top/starLv/star_" .. i),
			starChange = goutil.findChildComponent(self.mainGO, "Nego_Content/Nego_Top/starLv/star_" .. i, "UIImageSpriteChange")
		})
	end

	self._txtAssist = self:getTxt("Nego_Content/Nego_Assist/txtDesc")
	self._txtTalent = self:getTxt("Nego_Content/Nego_Talent/txtDesc")
	self._skillTableView = self:getGo("Nego_Content/Nego_Skill/ScrollView")
	self._skillCell = self:getGo("Nego_Content/Nego_Skill/cell")
	self._skillList = ScrollerList.create(self._skillTableView, self._skillCell, GameUtil.handler(self._updateSkillCell, self), GameUtil.handler(self._clearSkillCell, self))
	self._adjustPosition = goutil.findChildComponent(self.mainGO, "Nego_Content", "UIAdjustPosition")
	self._customInput = UICustomInput.Get(self:getGo("Nego_Content"))
end

function GlorycutepetsimpletipView:destroyUI()
	CutePetShowInfoView.super.destroyUI(self)
	self._skillList:dispose()
end

function GlorycutepetsimpletipView:bindEvents()
	GlorycutepetsimpletipView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function GlorycutepetsimpletipView:unbindEvents()
	GlorycutepetsimpletipView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function GlorycutepetsimpletipView:onEnter()
	GlorycutepetsimpletipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._cutePetId = params[1]
	self._level = params[2] or 0

	self:_udpateUI()
end

function GlorycutepetsimpletipView:onExit()
	GlorycutepetsimpletipView.super.onExit(self)
	MaterialMgr.resetAll(self._itemGo)
end

function GlorycutepetsimpletipView:_udpateUI()
	local cutePetCfgs = GlorybattleConfig.instance:getCutePetCfgs(self._cutePetId)
	local cutePetCfg0 = cutePetCfgs[0]
	local raceId = cutePetCfgs[0].raceId
	local maxLevel = #cutePetCfgs
	local proxy = MaterialMgr.setCell(MatType.CutePet, raceId, self._itemGo)
	local name = MaterialMgr.getMaterialsName(MatType.CutePet, raceId)

	for i = 1, #self._starList do
		if i <= self._level then
			self._starList[i].starChange:SetState(0)
		else
			self._starList[i].starChange:SetState(1)
		end

		if i <= maxLevel then
			GameUtil.SetActive(self._starList[i].star, true)
		else
			GameUtil.SetActive(self._starList[i].star, false)
		end
	end

	local list = {}

	for i = 0, #cutePetCfgs do
		table.insert(list, cutePetCfgs[i])
	end

	self._txtTalent.text = cutePetCfg0.talentDesc
	self._txtAssist.text = cutePetCfg0.assistDesc
	self._txtLv.text = string.format("Lv.%s", self._level)
	self._txtName.text = name

	self._skillList:reloadData(list)
end

function GlorycutepetsimpletipView:_updateSkillCell(view, cell, data, tag)
	local go = cell.gameObject
	local lock = goutil.findChild(go, "lock")
	local txtDesc = goutil.findChildTextComponent(go, "descbg/txtDesc")
	local txtColorChange = goutil.findChildComponent(go, "descbg/txtDesc", "UITextColorChange")
	local txtStar = goutil.findChildTextComponent(go, "star/txt")

	if data.level <= self._level then
		txtColorChange:SetState(0)
		GameUtil.SetActive(lock, false)
	else
		txtColorChange:SetState(1)
		GameUtil.SetActive(lock, true)
	end

	txtDesc.text = data.desc
	txtStar.text = data.level
end

function GlorycutepetsimpletipView:_clearSkillCell(cell)
	return
end

function GlorycutepetsimpletipView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return GlorycutepetsimpletipView
