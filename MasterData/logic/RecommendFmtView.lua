-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/view/RecommendFmtView.lua

module("logic.extensions.recommendfmt.view.RecommendFmtView", package.seeall)

local RecommendFmtView = class("RecommendFmtView", ViewComponent)

function RecommendFmtView:ctor()
	RecommendFmtView.super.ctor(self)
end

function RecommendFmtView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)

	for i = 1, 3 do
		printInfo("test 添加了几个", i)
		self._pageBtns[i]:AddClickListener(function()
			printInfo("test 执行了", i)
			self:_onPageClick(i)
		end)
	end
end

function RecommendFmtView:unbindEvents()
	self._closeButton:RemoveClickListener()

	for i = 1, 3 do
		self._pageBtns[i]:RemoveClickListener()
	end
end

function RecommendFmtView:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._pageBtns = {}
	self._imgSelects = {}

	for i = 1, 3 do
		self._pageBtns[i] = self:getBtn("pageBtns/btn" .. i)
		self._imgSelects[i] = self:getGo("pageBtns/btn" .. i .. "/imgSelect")
	end

	self._tableview = self:getGo("scrollList"):GetComponent("UITableview")
	self._tableCell = self:getGo("scrollList/item")

	self._tableCell:SetActive(false)
end

function RecommendFmtView:onEnter()
	self._loader = {}
	self._lastCallBack = {}
	self._chara = {}

	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	self:_initAllPageInfos()
	self:_setPage(1)
end

function RecommendFmtView:onExit()
	FuncOpenController.instance.onRecomentSelCallback = nil
	FuncOpenController.instance.onRecomentSelCallbackObj = nil

	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function RecommendFmtView:_onClickClose()
	self:close()
end

function RecommendFmtView:_onPageClick(pageIndex)
	self:_setPage(pageIndex)
end

function RecommendFmtView:_initAllPageInfos()
	self._allPageInfos = {}

	for i = 1, #self._pageBtns do
		self._allPageInfos[i] = {}

		local cfgs = RecommendFmtConfig.instance:getCfgsById(i)

		for j = 1, #cfgs do
			self._allPageInfos[i][j] = {}
			self._allPageInfos[i][j].desc = cfgs[j].desc
			self._allPageInfos[i][j].fightId = cfgs[j].fightId
		end
	end
end

function RecommendFmtView:_setPage(pageIndex)
	printInfo("打开了页数：", pageIndex)

	for i = 1, #self._imgSelects do
		self._imgSelects[i]:SetActive(pageIndex == i)
	end

	self:_updateList(pageIndex)
end

function RecommendFmtView:_updateList(pageIndex)
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = self._allPageInfos[pageIndex]
	self.charactorIndexs = {}

	self._tableview:ReloadData()
end

function RecommendFmtView:_numInView()
	return #self._curViewDatas
end

function RecommendFmtView:_cellSize()
	return 340, 518
end

function RecommendFmtView:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function RecommendFmtView:_updateCell(view, cell, data)
	local txtTitle = goutil.findChild(cell, "txtTitle"):GetComponent(goutil.Type_UIText)
	local txtSpeed = goutil.findChild(cell, "speed/txtSpeed"):GetComponent(goutil.Type_UIText)
	local txtPower = goutil.findChild(cell, "txtPower"):GetComponent(goutil.Type_UIText)
	local txtFmtName = goutil.findChild(cell, "fmtName/txtFmtName"):GetComponent(goutil.Type_UIText)
	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn_Use")
	local fightMonsterCfg = ChallengeConfig.instance:getMissionCfg(data.fightId)
	local fightCreepsCfgs = ChallengeConfig.instance:getCreepCfg(data.fightId)

	self:_removeSpineCharactor(cell)

	self.charactorIndexs[cell] = {}
	self._loader[cell] = {}
	self._lastCallBack[cell] = {}
	self._chara[cell] = {}

	local ImgC_Forbids = {}
	local imgNotGets = {}
	local Btn_Summons = {}
	local ImgC_Infos = {}
	local btnClicks = {}
	local charactors = {}
	local str = "formation/Item_Seat_%d/"

	for i = 1, 9 do
		local path = string.format(str, i)

		btnClicks[i] = Framework.ButtonAdapter.GetFrom(cell.gameObject, path)
		ImgC_Forbids[i] = goutil.findChild(cell, path .. "ImgC_Forbid"):GetComponent("UIImageSpriteChange")
		imgNotGets[i] = goutil.findChild(cell, path .. "imgNotGet")
		Btn_Summons[i] = goutil.findChild(cell, path .. "Btn_Summon")
		ImgC_Infos[i] = goutil.findChild(cell, path .. "ImgC_Info"):GetComponent(typeof(UIImageSpriteChange))
		charactors[i] = goutil.findChild(cell, path .. "charactor")

		ImgC_Forbids[i]:SetState(0)
		imgNotGets[i]:SetActive(false)
		Btn_Summons[i]:SetActive(false)
		ImgC_Infos[i].gameObject:SetActive(false)
		btnClicks[i]:RemoveClickListener()
	end

	local getPetNum = 0
	local powerFormula = FightingPowerFormula.instance
	local team = {}
	local _curMasterId = 0
	local _targetId = 0
	local curFaceId = 0
	local masterId = 0
	local summonId = 0

	for i = 1, #fightCreepsCfgs do
		local posId = fightCreepsCfgs[i].posId
		local raceId = fightCreepsCfgs[i].raceId
		local skinId = fightCreepsCfgs[i].faceId

		if checknumber(skinId) == 0 then
			skinId = raceId
		end

		self:_showSpineCharactor(cell, i, raceId, charactors[posId])

		self.charactorIndexs[cell][i] = i

		ImgC_Forbids[posId]:SetState(1)
		ImgC_Infos[posId].gameObject:SetActive(true)
		self:_setRaceType(ImgC_Infos[posId], raceId, skinId)

		local summonMasterId = checknumber(fightCreepsCfgs[i].summonMasterId)

		if summonMasterId > 0 then
			Btn_Summons[posId]:SetActive(true)
		end

		local isGetPet = BagModel.instance:isExistRaceId(raceId)

		imgNotGets[posId]:SetActive(not isGetPet)

		if isGetPet then
			getPetNum = getPetNum + 1
		end

		local mo = FightingPowerPetMo.New(0, 0)

		mo:fromChallengeCreepCo(fightCreepsCfgs[i], fightCreepsCfgs)

		local addPower = mo:getFightingPower()

		table.insert(team, mo)
		btnClicks[posId]:AddClickListener(function()
			printInfo("此处点击的是", fightCreepsCfgs[i].creepsName)

			local summonedPetRaceId

			if not string.nilorempty(fightCreepsCfgs[i].summonedPetId) then
				local cfg = fightCreepsCfgs[checknumber(fightCreepsCfgs[i].summonedPetId)]

				summonedPetRaceId = cfg.raceId
			end

			CommonTipsMgr.instance:showMaxLvlPetTips(raceId)
		end)

		local elementalMasterId = checknumber(fightCreepsCfgs[i].elementalMasterId)
		local elementalTargetId = checknumber(fightCreepsCfgs[i].elementalTargetId)

		if elementalMasterId > 0 then
			_curMasterId = elementalMasterId
			curFaceId = mo.curFaceId
		end

		if elementalTargetId > 0 then
			_targetId = elementalTargetId
		end

		if checknumber(mo.summonMasterId) then
			masterId = mo.petId
		end

		if checknumber(mo.summonedPetId) then
			summonId = mo.petId
		end
	end

	local _elementRelationMap = {}

	if _targetId > 0 then
		_elementRelationMap[_targetId] = PetSkinConfig.instance:getFisrtEleAttrIdx(curFaceId)
	end

	txtTitle.text = data.desc
	txtSpeed.text = powerFormula:getTeamSpeed(team)
	txtFmtName.text = self:_getFmtName(fightMonsterCfg.creepsMasterId)
	txtPower.text = self:_getPowerNum(powerFormula, team, fightMonsterCfg, _elementRelationMap, masterId, summonId)

	btnUse:AddClickListener(function()
		if getPetNum == 0 then
			FloatWordMgr.instance:show("您无法使用此阵容")
		elseif getPetNum < #fightCreepsCfgs then
			local title = "提示"
			local content = "阵容中存在未获得的精灵，是否继续使用此阵容？"
			local btnTxt = "确认"

			local function func()
				self:_setFmtToCurFmt(fightCreepsCfgs)
				self:_onClickClose()
			end

			TipsFacade.instance:openTipWindow(title, content, func, btnTxt)
		else
			self:_setFmtToCurFmt(fightCreepsCfgs)
			self:_onClickClose()
		end
	end)
end

function RecommendFmtView:_setFmtToCurFmt(fightCreepsCfgs)
	local onRecomentSelCallback = FuncOpenController.instance.onRecomentSelCallback
	local onRecomentSelCallbackObj = FuncOpenController.instance.onRecomentSelCallbackObj

	FuncOpenController.instance.onRecomentSelCallback = nil
	FuncOpenController.instance.onRecomentSelCallbackObj = nil

	if onRecomentSelCallback then
		if onRecomentSelCallbackObj then
			FuncOpenController.instance.onRecomentSelCallback(onRecomentSelCallbackObj, fightCreepsCfgs)
		else
			FuncOpenController.instance.onRecomentSelCallback(fightCreepsCfgs)
		end
	else
		self:_defaultCallBack(fightCreepsCfgs)
	end
end

function RecommendFmtView:_defaultCallBack(fightCreepsCfgs)
	FastFormation.instance:clean()

	for i = 1, #fightCreepsCfgs do
		local raceId = fightCreepsCfgs[i].raceId
		local petId = BagModel.instance:getPetIdByRaceId(raceId)

		if petId ~= nil then
			local posId = fightCreepsCfgs[i].posId

			FormationController.instance:ChangePosition(posId, petId)
		end
	end

	FormationController.instance:SaveFormationEx()
	FloatWordMgr.instance:show("更换阵型成功")
end

function RecommendFmtView:_getFmtName(formationId)
	return ""
end

function RecommendFmtView:_getPowerNum(powerFormula, team, fightMonsterCfg, elementRelationMap, masterId, summonId)
	if fightMonsterCfg.heroSkillId and fightMonsterCfg.heroSkillId ~= "" then
		local heroSkillId = checknumber(fightMonsterCfg.heroSkillId)

		return powerFormula:getTeamFightingPower(team, heroSkillId, 0, 0, elementRelationMap, 0, 0, masterId, summonId)
	else
		local heroSkills = powerFormula:getHeroValidSkills(team, elementRelationMap, masterId, summonId)
		local cnt = #heroSkills

		return powerFormula:getTeamFightingPower(team, (cnt > 0 or nil) and checknumber(heroSkills[1]), 0, 0, elementRelationMap, 0, 0, masterId, summonId)
	end
end

function RecommendFmtView:_setRaceType(uiImageSpriteChange, raceId, skinId)
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	uiImageSpriteChange:SetState(targetValue)
end

function RecommendFmtView:_clearTableview(cell)
	self:_removeSpineCharactor(cell)

	self.charactorIndexs[cell] = nil

	local btnClicks = {}
	local str = "formation/Item_Seat_%d/"

	for i = 1, 9 do
		local path = string.format(str, i)

		btnClicks[i] = Framework.ButtonAdapter.GetFrom(cell.gameObject, path)

		btnClicks[i]:RemoveClickListener()
	end

	local btnUse = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn_Use")

	btnUse:RemoveClickListener()
end

function RecommendFmtView:_removeSpineCharactor(cell)
	if not self.charactorIndexs or not self.charactorIndexs[cell] then
		return
	end

	for k, index in pairs(self.charactorIndexs[cell]) do
		self._loader[cell][index], self._lastCallBack[cell][index], self._chara[cell][index] = RoleObjectPool.instance:resetLoader(self._loader[cell][index], self._lastCallBack[cell][index], self._chara[cell][index])
	end
end

function RecommendFmtView:_showSpineCharactor(cell, index, raceId, parentGo)
	local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	local cfg = CharacterConfig.instance:getPetCo(raceId)

	self._loader[cell][index], self._lastCallBack[cell][index] = RoleObjectPool.instance:getRoleAsset(cfg.faceIds, function(go)
		go:SetActive(true)
		goutil.addChildToParent(go, parentGo)
		uGuiUtil.setLocalPosition(go)
		uGuiUtil.setLocalScale(go, Vector3.New(scale * 0.3, scale * 0.3, 1))
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), 0, -15)

		self._chara[cell][index] = go
	end, false)
end

return RecommendFmtView
