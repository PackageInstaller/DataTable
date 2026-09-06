-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonholystripeView.lua

module("logic.extensions.season.view.SeasonholystripeView", package.seeall)

local SeasonholystripeView = class("SeasonholystripeView", ViewComponent)

function SeasonholystripeView:ctor()
	SeasonholystripeView.super.ctor(self)
end

function SeasonholystripeView:unbindEvents()
	SeasonholystripeView.super.unbindEvents(self)
	self._instructionBg:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnRules)
	GameUtil.rmClickHandler(self._btn_close)
end

function SeasonholystripeView:bindEvents()
	SeasonholystripeView.super.bindEvents(self)
	self._instructionBg:AddClickListener(function()
		goutil.setActive(self._instructionBg.gameObject, false)
	end)
	GameUtil.addClickHandler(self._btnRules, self._onClickbtnRule, self)
	GameUtil.addClickHandler(self._btn_close, self.close, self)
end

function SeasonholystripeView:buildUI()
	SeasonholystripeView.super.buildUI(self)

	self._btn_close = self:getGo("topleft/btn_close")
	self._btnRules = self:getGo("topleft/btnRules")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:regValueChanged(GameUtil.handler(self.onScrollValueChange, self))

	self._instructionBg = self:getBtn("instructionBg")
	self._instruction = self:getGo("instructionBg/instruction")
	self._adjustPosition = self._instruction:GetComponent("UIAdjustPosition")
	self._equipList = self:getGo("instructionBg/instruction/equiplist")
	self._equipCell = self:getGo("instructionBg/instruction/cell")
	self._equipScrollList = ScrollerList.create(self._equipList, self._equipCell, GameUtil.handler(self._updateEquipCell, self), GameUtil.handler(self._clearItemCell, self))

	self._equipScrollList:regGetCellSize(function()
		return 400, 100
	end)
end

function SeasonholystripeView:onExit()
	SeasonholystripeView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtHolyStripesInfo, self.onRefreshUI, self)
end

function SeasonholystripeView:onEnter()
	SeasonholystripeView.super.onEnter(self)

	self.teamId = checknumber(self:getFirstParam())
	self.curSelectPetMo = nil

	SeasonController.instance:sendGetHolyStripesinfo(self.teamId)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtHolyStripesInfo, self.onRefreshUI, self)
	self:onRefreshUI()
end

function SeasonholystripeView:onRefreshUI()
	local teamMO = SeasonTeamsModel.instance:getTeam(self.teamId)

	self.holyStripesMap = teamMO:getHolyStripesInfoMap()

	local petList = teamMO:getPetMoList()

	self.scrollList:reloadData(petList)
end

function SeasonholystripeView:_updateCell(view, cell, data, tag)
	local petIcon = goutil.findChild(cell, "content/peticon")
	local equipIcon = goutil.findChild(cell, "content/equipicon")
	local descTxt = goutil.findChildTextComponent(cell, "content/desctxt")
	local name = goutil.findChildTextComponent(cell, "content/name")
	local replace = goutil.findChild(cell, "content/replace")
	local redpoint = goutil.findChild(cell, "content/replace/redpoint")
	local info = data

	GameUtil.asBtn(replace):RemoveClickListener()
	GameUtil.asBtn(replace):AddClickListener(function()
		self:_setTipsPos(cell)
		self:_updateEquipList(data)
	end)
	uGuiUtil.clearImage(petIcon)
	uGuiUtil.clearImage(equipIcon)

	local skinId = info.curFaceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if not modelCo then
		return
	end

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
	GameUtil.SetActive(equipIcon, false)
	GameUtil.SetActive(redpoint, false)

	descTxt.text = lang("当前精灵还没装备灵纹")
	name.text = ""

	local id = checknumber(self.holyStripesMap[data.raceId])

	if id > 0 then
		local cfg = SeasonConfig.instance:getHolyStripeCfg(id)

		GameUtil.SetActive(equipIcon, true)
		uGuiUtil.setSpriteToImage(equipIcon, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/items/%s.png", cfg.suitIcon))

		descTxt.text = cfg.suitDesc
		name.text = cfg.suitName
	else
		GameUtil.SetActive(redpoint, true)
	end
end

function SeasonholystripeView:clearCell(cell)
	local petIcon = goutil.findChild(cell, "content/peticon")
	local equipIcon = goutil.findChild(cell, "content/equipicon")

	uGuiUtil.clearImage(petIcon)
	uGuiUtil.clearImage(equipIcon)
end

function SeasonholystripeView:_clearItemCell(cell)
	local iconBg = goutil.findChild(cell, "iconBg")

	uGuiUtil.clearImage(iconBg)
end

function SeasonholystripeView:_updateEquipList(petMo)
	self.curSelectPetMo = petMo

	goutil.setActive(self._instructionBg.gameObject, true)

	local cfgList = SeasonConfig.instance:getHolyStripeCfgList()
	local list = {}

	for i, v in ipairs(cfgList) do
		table.insert(list, v)
	end

	self._equipScrollList:reloadData(list)
end

function SeasonholystripeView:_updateEquipCell(view, cell, data)
	local descTxt = goutil.findChildTextComponent(cell, "desctxt")
	local name = goutil.findChildTextComponent(cell, "txtName")
	local iconBg = goutil.findChild(cell, "iconBg")
	local lock = goutil.findChild(cell, "lock")

	descTxt.text = data.suitDesc
	name.text = data.suitName

	uGuiUtil.setSpriteToImage(iconBg, uGuiUtil.SpriteType.BigBg, string.format("ui/icon/items/%s.png", data.suitIcon))

	local mainLevel = SeasonMainCampModel.instance:getCampLv()

	GameUtil.SetActive(lock, true)

	if mainLevel >= data.camplv then
		GameUtil.SetActive(lock, false)
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	GameUtil.asBtn(cell):AddClickListener(function()
		if mainLevel >= data.camplv then
			goutil.setActive(self._instructionBg.gameObject, false)

			local id = checknumber(self.holyStripesMap[self.curSelectPetMo.raceId])

			if id ~= data.holyStripesType then
				SeasonController.instance:sendAndSetPetHolystripeInfo(self.teamId, self.curSelectPetMo.raceId, data.holyStripesType)
			end
		else
			TipsFacade.instance:openCommonTips(langPara("主营地等级达到%s解锁", data.camplv))
		end
	end)
end

function SeasonholystripeView:_setTipsPos(goOrPos)
	local pos
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

	if pos then
		self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
	else
		Framework.TransformUtil.SetLocalPos(self._instruction.transform, 0, 0, 0)
	end
end

function SeasonholystripeView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("seasonholystripeview")
end

function SeasonholystripeView:onScrollValueChange(tableview)
	local viewPortTrans = tableview:GetViewport()
	local content = tableview:GetContent()
	local conX, _, _ = Framework.TransformUtil.GetLocalPos(content.transform, 0, 0, 0)
	local width = goutil.getWidth(viewPortTrans)
	local ofh = 20
	local hw = width * 0.5
	local R = ofh + hw * hw / ofh
	local r = R * 0.5
	local a = hw
	local b = -r + ofh
	local count = tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = tableview:GetCellByIndex(i)

		if cell then
			local locx, locy, locz = Framework.TransformUtil.GetLocalPos(cell.transform, 0, 0, 0)
			local ofx = conX + locx
			local xx = ofx - a
			local ta = math.atan2(-b, xx)
			local yy = r * math.sin(ta) + b
			local angle = math.deg(ta)
			local cellContent = goutil.findChild(cell, "content")

			GameUtil.setLocalPos(cellContent.transform, 0, yy, 0)
			GameUtil.setLocalRotation(cellContent, 0, 0, angle - 90)
		end
	end
end

return SeasonholystripeView
