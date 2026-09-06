-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonCutePetShowView.lua

module("logic.extensions.season.view.SeasonCutePetShowView", package.seeall)

local SeasonCutePetShowView = class("SeasonCutePetShowView", ViewComponent)

function SeasonCutePetShowView:ctor()
	SeasonCutePetShowView.super.ctor(self)
end

function SeasonCutePetShowView:unbindEvents()
	SeasonCutePetShowView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRules)
	GameUtil.rmClickHandler(self._btn_close)
end

function SeasonCutePetShowView:bindEvents()
	SeasonCutePetShowView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRules, self._onClickbtnRule, self)
	GameUtil.addClickHandler(self._btn_close, self.close, self)
end

function SeasonCutePetShowView:buildUI()
	SeasonCutePetShowView.super.buildUI(self)

	self._btn_close = self:getGo("topleft/btn_close")
	self._btnRules = self:getGo("topleft/btnRules")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))

	self.scrollList:regValueChanged(GameUtil.handler(self.onScrollValueChange, self))
end

function SeasonCutePetShowView:onExit()
	SeasonCutePetShowView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(GlobalNotify.SeasonFmtCutePetInfo, self.onRefreshUI, self)
end

function SeasonCutePetShowView:onEnter()
	SeasonCutePetShowView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonFmtCutePetInfo, self.onRefreshUI, self)

	self.teamId = checknumber(self:getFirstParam())
	self.curSelectPetMo = nil

	SeasonController.instance:sendGetCutePetInfo(self.teamId)
end

function SeasonCutePetShowView:onRefreshUI()
	local teamMO = SeasonTeamsModel.instance:getTeam(self.teamId)

	self.cutePetMap = teamMO:getCutePetInfoMap()

	local petList = teamMO:getPetMoList()

	self.scrollList:reloadData(petList)
end

function SeasonCutePetShowView:_updateCell(view, cell, data, tag)
	local petIcon = goutil.findChild(cell, "content/peticon")
	local descTxt = goutil.findChildTextComponent(cell, "content/desctxt")
	local name = goutil.findChildTextComponent(cell, "content/name")
	local replace = goutil.findChild(cell, "content/replace")
	local cutePetHeadInfo = goutil.findChild(cell.gameObject, "content/equipicon/cutepet")
	local headIcon = goutil.findChild(cutePetHeadInfo, "ImgIcon")
	local changePetJob = goutil.findChildComponent(cutePetHeadInfo, "imgType", "UIImageSpriteChange")
	local skillInfo = goutil.findChild(cell.gameObject, "content/skillInfo")
	local txtTalent = goutil.findChildTextComponent(skillInfo, "Viewport/Content/descTalent/descBg/txt")
	local txtSkill = goutil.findChildTextComponent(skillInfo, "Viewport/Content/descSkill/descBg/txt")
	local emptyReplace = goutil.findChild(cell, "content/emptyReplace")
	local emptyIcon = goutil.findChild(cell, "content/equipicon/empty")
	local info = data

	GameUtil.asBtn(replace):RemoveClickListener()
	GameUtil.asBtn(replace):AddClickListener(function()
		UIStateManager.instance:push(ViewName.SeasonCutePetInfoView, self.teamId, data)
	end)
	GameUtil.asBtn(emptyReplace):RemoveClickListener()
	GameUtil.asBtn(emptyReplace):AddClickListener(function()
		UIStateManager.instance:push(ViewName.SeasonCutePetInfoView, self.teamId, data)
	end)
	uGuiUtil.clearImage(petIcon)

	local skinId = info.curFaceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(skinId))

	if not modelCo then
		return
	end

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	name.text = ""

	uGuiUtil.clearImage(headIcon)

	local cutePetInfo = self.cutePetMap[data.raceId]

	if cutePetInfo then
		GameUtil.SetActive(emptyReplace, false)
		GameUtil.SetActive(emptyIcon, false)
		GameUtil.SetActive(cutePetHeadInfo, true)
		GameUtil.SetActive(skillInfo, true)
		GameUtil.SetActive(replace, true)

		local typeId = checknumber(cutePetInfo.cutePetType)
		local talentId = checknumber(cutePetInfo.cutePetTalentId)
		local cutePetCfg = SeasonMainCampConfig.instance:getCutePetInfo(typeId)

		changePetJob:SetState(cutePetCfg.cutePetJob - 1)

		name.text = cutePetCfg.cutePetName

		uGuiUtil.setSpriteToImage(headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCutePetIconUrl(cutePetCfg.cutePetIcon))

		local cfgs = SeasonMainCampConfig.instance:getCutePetLevelInfo(typeId)
		local maxLevel = 0
		local mainLevel = SeasonMainCampModel.instance:getCampLv()

		for i, v in pairs(cfgs) do
			if maxLevel < v.campLv and mainLevel >= v.campLv then
				maxLevel = v.campLv
			end
		end

		if maxLevel > 0 then
			local cfg = cfgs[maxLevel]

			txtSkill.text = cfg.desc
		end

		local talentCfgs = SeasonMainCampConfig.instance:getCutePetTalentInfo(typeId)

		if talentCfgs then
			local talentCfgList = talentCfgs[talentId]

			maxLevel = 0

			if talentCfgList then
				for i, v in pairs(talentCfgList) do
					if maxLevel < v.campLv and mainLevel >= v.campLv then
						maxLevel = v.campLv
					end
				end
			end

			if maxLevel > 0 then
				local cfg = talentCfgList[maxLevel]

				txtTalent.text = cfg.desc
			end
		end
	else
		GameUtil.SetActive(emptyReplace, true)
		GameUtil.SetActive(emptyIcon, true)
		GameUtil.SetActive(cutePetHeadInfo, false)
		GameUtil.SetActive(skillInfo, false)
		GameUtil.SetActive(replace, false)
	end
end

function SeasonCutePetShowView:clearCell(cell)
	local petIcon = goutil.findChild(cell, "content/peticon")
	local cutePetHeadInfo = goutil.findChild(cell.gameObject, "content/equipicon/cutepet")
	local headIcon = goutil.findChild(cutePetHeadInfo, "ImgIcon")
	local replace = goutil.findChild(cell, "content/replace")
	local emptyReplace = goutil.findChild(cell, "content/emptyReplace")

	uGuiUtil.clearImage(petIcon)
	uGuiUtil.clearImage(headIcon)
	GameUtil.asBtn(replace):RemoveClickListener()
	GameUtil.asBtn(emptyReplace):RemoveClickListener()
end

function SeasonCutePetShowView:_onClickbtnRule()
	TipsFacade.instance:openRulesView("chongwu_rule")
end

function SeasonCutePetShowView:onScrollValueChange(tableview)
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

return SeasonCutePetShowView
