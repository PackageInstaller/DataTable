-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/view/PetsearchsuccessView.lua

module("logic.extensions.petsearch.view.PetsearchsuccessView", package.seeall)

local PetsearchsuccessView = class("PetsearchsuccessView", ViewComponent)

function PetsearchsuccessView:ctor()
	PetsearchsuccessView.super.ctor(self)
end

function PetsearchsuccessView:buildUI()
	PetsearchsuccessView.super.buildUI(self)

	self._goSearch = self:getGo("btnSearch")
	self._btnSearch = GameUtil.asBtn(self._goSearch)
	self._btnChallenge = self:getBtn("btnChallenge")
	self._btnAgain = self:getBtn("btnAgain")
	self._txtCost = self:getTxt("btnAgain/txtCost")
	self._cell = self:getGo("right/reward/cell")
	self._table = self:getGo("right/reward/tableview")
	self._tableView = ScrollerList.create(self._table, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtRule = self:getTxt("right/rule/txtscrollContent/txtContent")
	self.info = self:getGo("info")
	self._txtName = goutil.findChildTextComponent(self.info, "name/txt_name")
	self._txtPos1 = goutil.findChildTextComponent(self.info, "txt_pos1")
	self._txtPos2 = goutil.findChildTextComponent(self.info, "txt_pos2")
	self._imgJob = goutil.findChildComponent(self.info, "attrs/job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.info, "attrs/job1/icon", "UIImageSpriteChange")
	self._imgAttr = goutil.findChildComponent(self.info, "attrs/attr/icon", "UIImageSpriteChange")
	self._goJob1 = self._imgJob1.transform.parent.gameObject
	self._rarePoint = goutil.findChild(self.info, "point_rare")
	self._imgRareBg = goutil.findChildComponent(self._rarePoint, "imgRareBg", typeof(UIImageSpriteChange))
	self._btnClose = self:getBtn("btnClose")
	self.petPhoto = PetPhotoShow.Get(self:getGo("con"))
	self._zdlTxt = self:getGo("zdl/imgRecZdl"):GetComponent("UIImgNumeralText")
end

function PetsearchsuccessView:bindEvents()
	PetsearchsuccessView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnAgain:AddClickListener(self._onClickBtnAgain, self)
	self._btnSearch:AddClickListener(self._onClickBtnSearch, self)
	self._btnChallenge:AddClickListener(self._onClickBtnChallenge, self)
end

function PetsearchsuccessView:unbindEvents()
	PetsearchsuccessView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnAgain:RemoveClickListener()
	self._btnSearch:RemoveClickListener()
	self._btnChallenge:RemoveClickListener()
end

function PetsearchsuccessView:destroyUI()
	PetsearchsuccessView.super.destroyUI(self)
end

function PetsearchsuccessView:onEnter()
	PetsearchsuccessView.super.onEnter(self)

	self._bossId = PetsearchModel.instance:getCurBossId()

	if self._bossId and self._bossId > 0 then
		self._cfg = PetsearchConfig.instance:getSearchPetCfg(self._bossId)
		self._teamCfg = PetsearchConfig.instance:getTeamCfgByBossId(self._bossId)
		self._raceId = PetsearchConfig.instance:getTeamCfg(self._cfg.creepsMasterId).introdRaceId

		self:_updateRightUI()
		self:_updateLeftUI()

		local zdl = math.floor(PetsearchModel.instance:getCurZDL() * self._cfg.fightCoefficient / 10000)

		self._zdlTxt:SetText(zdl)
	else
		self:close()
	end
end

function PetsearchsuccessView:onEnterFinished()
	PetsearchsuccessView.super.onEnterFinished(self)
end

function PetsearchsuccessView:onExit()
	PetsearchsuccessView.super.onExit(self)
	MaterialMgr.resetAll(self._rarePoint)
	self.petPhoto:clear()
end

function PetsearchsuccessView:onExitFinished()
	PetsearchsuccessView.super.onExitFinished(self)
end

function PetsearchsuccessView:_updateRightUI()
	self._txtRule.text = self._teamCfg.description
	self._curRreshCost = PetsearchModel.instance:getCurRreshCost()
	self._costType, self._costId, self._curMatNum = MaterialMgr.getMatParams(self._curRreshCost)
	self._txtCost.text = "x " .. self._curMatNum

	local dataList = {}
	local prizeList = MaterialMgr.changeItemStrArr(self._cfg.prize)
	local perfectPrizeList = MaterialMgr.changeItemStrArr(self._cfg.perfectPrize)

	for k, v in pairs(prizeList) do
		local data = {}

		data.matStr = v
		data.isShowMark = false

		table.insert(dataList, data)
	end

	for k, v in pairs(perfectPrizeList) do
		local data = {}

		data.matStr = v
		data.isShowMark = true

		table.insert(dataList, data)
	end

	self._tableView:reloadData(dataList)
end

function PetsearchsuccessView:_updateLeftUI()
	local teamCfg = PetsearchConfig.instance:getTeamCfg(self._cfg.creepsMasterId)
	local petRaceId = teamCfg.introdRaceId
	local skinId = teamCfg.introdRaceId
	local petCo = CharacterConfig.instance:getPetCo(petRaceId)

	self._txtName.text = petCo.name

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	self._imgAttr:SetState(race - 1)
	self:_setPetExtraInfo(petRaceId)

	local rare = petCo.rare

	rare = Mathf.Clamp(rare, 1, 4)

	self._imgRareBg:SetState(rare - 1)

	local proxy = MaterialMgr.setCell(MatType.Rare, petRaceId, self._rarePoint)

	proxy.binder:setRare(rare)
	proxy.binder:playEffect()
	self.petPhoto:showPetEffect(petRaceId, true, 4)
end

function PetsearchsuccessView:_updateCell(view, cell, data)
	MaterialMgr.resetAll(cell)

	local itemCell = goutil.findChild(cell, "itemcell")
	local mark = goutil.findChild(cell, "mark")

	MaterialMgr.setCellByCfg(data.matStr, itemCell)
	goutil.setActive(mark, data.isShowMark)
end

function PetsearchsuccessView:_clearCell(cell)
	local itemCell = goutil.findChild(cell, "itemcell")

	MaterialMgr.resetAll(itemCell)
end

function PetsearchsuccessView:_setPetExtraInfo(id)
	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(id)

	if petInfoCfg ~= nil then
		local t = string.split(petInfoCfg.stragegy, "\n")

		if #t >= 1 then
			self._txtPos1.text = t[1] or "待定"
		end

		if #t >= 2 then
			self._txtPos2.text = t[2] or ""
		end
	else
		self._txtPos1.text = "待定"
		self._txtPos2.text = ""
	end
end

function PetsearchsuccessView:_onClickBtnClose()
	UIStateManager.instance:popByName(ViewName.PetsearchmainView)
	self:close()
end

function PetsearchsuccessView:_onClickBtnAgain()
	local content = langPara("是否花费<color=#ebad32>%s%s</color>刷新当前精灵%s？", self._curMatNum, MaterialMgr.getMaterialsName(self._costType, self._costId), self._txtName.text)

	TipsFacade.instance:openPopupCostMatViewNew(self._costType, self._costId, self._curMatNum, content, function()
		PetsearchController.instance:sendSeekPetRefresh()
	end)
end

function PetsearchsuccessView:_onClickBtnSearch()
	UIStateManager.instance:push(ViewName.PetsearchdirectView)
end

function PetsearchsuccessView:_onClickBtnChallenge()
	self:close()
	UIStateManager.instance:push(ViewName.PetsearchMissionView, self._bossId)
end

return PetsearchsuccessView
