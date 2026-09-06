-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcollege/view/PetcollegeView.lua

module("logic.extensions.petcollege.view.PetcollegeView", package.seeall)

local PetcollegeView = class("PetcollegeView", TableViewComponent)

function PetcollegeView:ctor()
	PetcollegeView.super.ctor(self)

	self.battleCfg = nil
	self.showItemCount = 5
	self.height = 90
	self.rewardGoList = nil
end

function PetcollegeView:_onReloadFinish()
	self:OnCellUpdatePosition()
end

function PetcollegeView:bindEvents()
	PetcollegeView.super.bindEvents(self)
	self.viewCloseBtn:AddClickListener(self.close, self)
	self.viewTipBtn:AddClickListener(self._onClickTip, self)
	self.battleBtn:AddClickListener(function()
		if self._currStageId ~= 1 and self._currStageId > self._currPassStageId + 1 then
			FloatWordMgr.instance:show("请先通关前面的关卡！")

			return
		end

		PetCollegeModel.instance:setCurrChallenge(self._challengeId, self._currStageId)
		UIStateManager.instance:push(ViewName.PetcollegemissionView, self._challengeId, self._currStageId)
	end, self)
	self._tableview:AddOnScrollValueChanged(self.OnCellUpdatePosition, self)
end

function PetcollegeView:unbindEvents()
	PetcollegeView.super.unbindEvents(self)
	self.viewCloseBtn:RemoveClickListener()
	self.viewTipBtn:RemoveClickListener()
	self.battleBtn:RemoveClickListener()
	self._tableview:UnRegisterAllCallbacks()
end

function PetcollegeView:buildUI()
	PetcollegeView.super.buildUI(self)

	local upShowGo = self:getGo("upShowGo")

	self.viewCloseBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewCloseBtn")
	self.viewTipBtn = Framework.ButtonAdapter.GetFrom(upShowGo, "viewTitleTxt/viewTipBtn")
	self.nameTypeTxt = self:getGo("roleNameInfo/nameTypeTxt"):GetComponent("Text")
	self._pointRare = self:getGo("roleNameInfo/pointRare")
	self.nameShowTxt = self:getGo("roleNameInfo/nameShowTxt"):GetComponent("Text")
	self.nameTypeTxt.text = ""
	self.nameShowTxt.text = ""
	self.battleBtn = self:getBtn("rewardBgTran/battleBtn")

	if self.rewardGoList == nil or #self.rewardGoList == 0 then
		self.rewardGoList = {
			self:getGo("rewardBgTran/rewardTran1"),
			(self:getGo("rewardBgTran/rewardTran2"))
		}
	end

	self.viewEffPos = self:getGo("viewEffPos")
	self._viewTitleTxt = goutil.findChildTextComponent(self.mainGO, "upShowGo/viewTitleTxt")
	self._jobGo = goutil.findChild(self.mainGO, "job")
	self._scroll = goutil.findChild(self._jobGo, "scroll")

	local scrollPath = "Viewport/Content"

	self._txtFreture = goutil.findChildTextComponent(self._scroll, string.format("%s/%s", scrollPath, "txtFreture"))
	self._txtPhychic = goutil.findChildTextComponent(self._scroll, string.format("%s/%s", scrollPath, "txtPhychic"))
	self._Nego_Skill = goutil.findChild(self._scroll, string.format("%s/%s", scrollPath, "skill/Nego_Skill"))

	local skillCell = goutil.findChild(self._scroll, string.format("%s/%s", scrollPath, "skill/cell"))

	self._Skills = {}

	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(self._Nego_Skill.transform, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._roleImgGo = self:getGo("roleRoot/roleImg")
	self._petPhoto = PetPhotoShow.Get(self._roleImgGo)
end

function PetcollegeView:onEnterFinished()
	PetcollegeView.super.onEnterFinished(self)
end

function PetcollegeView:onExitFinished()
	return
end

function PetcollegeView:onExit()
	PetcollegeView.super.onExit(self)

	if self.pmEff then
		UIEffectManager.instance:stopEffect(self.pmEff)
	end

	self.pmEff = nil

	self._petPhoto:destroy()
	MaterialMgr.resetAll(self._pointRare)
end

function PetcollegeView:destroyUI()
	PetcollegeView.super.destroyUI(self)

	self.battleCfg = nil
	self.battleInfo = nil
	self.rewardGoList = nil
end

function PetcollegeView:onEnter()
	PetcollegeView.super.onEnter(self)

	self._challengeId = checkint(self:getFirstParam())
	self._challengeCfg = PetCollegeConfig.instance:getChallegenCfg(self._challengeId)

	if not self._challengeCfg then
		printError("challengeId:" .. self._challengeId .. " no cfg")

		return
	end

	self._viewTitleTxt.text = self._challengeCfg.name
	self._curViewDatas = PetCollegeConfig.instance:getStageCfg(self._challengeId)

	self:ShowRoleModel()

	self._currPassStageId = PetCollegeModel.instance:getCurrPassStageId(self._challengeId)

	local currStageId = self._currPassStageId

	if PetCollegeConfig.instance:getStageCfgByStageId(self._challengeId, currStageId + 1) then
		currStageId = currStageId + 1
	end

	self:ChoiseBattleStageShow(currStageId, true)

	local effPath = "fx_ui_wangzhezhilu/fx_ui_wangzhezhilu_star.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.viewEffPos, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.viewEffPos.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)

	if not string.nilorempty(self._challengeCfg.phychic) then
		self._jobGo:SetActive(true)

		self._txtFreture.text = self._challengeCfg.featrue or ""
		self._txtPhychic.text = self._challengeCfg.phychic or ""

		self:_updateSkills()
	else
		self._jobGo:SetActive(false)
	end
end

function PetcollegeView:_updateSkills()
	local petCo = PetSkinConfig.instance:getPetSkinCfg(self._challengeCfg.raceId)
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txtSkillName = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local imgSkillType = goutil.findChild(go, "imgSkillType")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, self._challengeCfg.raceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))

			local skicon = skillCfg.skillTagImg

			uGuiUtil.setSpriteToImage(imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))

			txtSkillName.text = skillCfg.name
		end

		if skillType == GameEnum.SkillRaceType.Summon then
			go:SetActive(false)
		end
	end
end

function PetcollegeView:ChoiseBattleStageShow(stageId, isForce)
	local lastIsPass = stageId <= 1 or PetCollegeModel.instance:isStagePass(self._challengeId, stageId - 1)

	if not lastIsPass then
		FloatWordMgr.instance:show("请先通关上一关卡")

		return
	end

	local isPass = PetCollegeModel.instance:isStagePass(self._challengeId, stageId)

	if not isForce and stageId == self._currStageId then
		return
	end

	self._currStageId = stageId

	self._tableview:ReloadData()

	if self.rewardGoList and #self.rewardGoList > 0 then
		for i, go in ipairs(self.rewardGoList) do
			goutil.setActive(go, false)
		end

		for i = 1, #self.rewardGoList do
			MaterialMgr.resetAll(self.rewardGoList[i])
		end
	end

	local goodsList = PetCollegeConfig.instance:getStageGoods(self._challengeId, stageId)

	if goodsList == nil or #goodsList == 0 then
		return
	end

	for i = 1, #goodsList do
		local go = self.rewardGoList[i]

		if not string.nilorempty(goodsList[i]) and go then
			goutil.setActive(go, true)

			local itemCon = goutil.findChild(go, "item")
			local getText = goutil.findChild(go, "tag/text"):GetComponent(goutil.Type_UIText)

			getText.text = isPass and "已领取" or "首通"

			local imgChange = goutil.findChild(go, "tag"):GetComponent(typeof(UIImageColorChange))
			local list = string.split(goodsList[i], ":")

			imgChange:SetState(isPass and 0 or 1)

			if list and #list >= 2 then
				local goodsType = checknumber(list[1])
				local goodsId = checknumber(list[2])
				local goodsCount = list[3] and checknumber(list[3]) or 1
				local jlLua = MaterialMgr.setCell(goodsType, goodsId, itemCon)

				GameUtil.setLocalScale(jlLua.view, 0.8, 0.8, 0.8)
				jlLua.binder:setNum(goodsCount)
			end
		end
	end
end

function PetcollegeView:_OnClickSkill(skillType, skillId, go)
	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._challengeCfg.raceId)
end

function PetcollegeView:ShowRoleModel()
	local petCfg = CharacterConfig.instance:getPetCo(self._challengeCfg.raceId)

	if petCfg == nil then
		printError("精灵配置为空 ,id", self._challengeCfg.raceId)

		return
	end

	local skinId = self._challengeCfg.raceId

	if checknumber(self._challengeCfg.faceId) > 0 then
		skinId = self._challengeCfg.faceId
	end

	self._petPhoto:showPetEffect(skinId, true)

	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.initAwakenLv, petCfg.raceId)

	MaterialMgr.setCell(MatType.PetSkin_Rare, skinId, self._pointRare)

	if checknumber(self._challengeCfg.faceId) > 0 then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if skinCfg then
			self.nameShowTxt.text = skinCfg.skinName or ""
		end
	else
		self.nameShowTxt.text = petCfg.name
	end
end

function PetcollegeView:_getPath()
	return {
		cellPath = "lunPanItem",
		viewPath = "lunPanSR"
	}
end

function PetcollegeView:_cellSize()
	return 330, self.height
end

function PetcollegeView:_updateCell(view, cell, data)
	local itemGo = goutil.findChild(cell, "itemGo")
	local choiIconGo = goutil.findChild(itemGo, "choiIconGo")
	local indexTxt = goutil.findChildTextComponent(itemGo, "indexTxt")
	local lineIconGo = goutil.findChild(itemGo, "lineIconGo")
	local lockImaGo = goutil.findChild(itemGo, "lockImaGo")
	local passGo = goutil.findChild(itemGo, "passGo")
	local redpointGo = goutil.findChild(itemGo, "redpointGo")

	lockImaGo:SetActive(data.stageId > self._currPassStageId + 1)
	passGo:SetActive(data.stageId <= self._currPassStageId)

	if data.stageId == self._currStageId and false then
		redpointGo:SetActive(true)
	else
		redpointGo:SetActive(false)
	end

	if data.stageId == self._currStageId then
		lineIconGo:SetActive(false)
		choiIconGo:SetActive(true)

		indexTxt.text = string.format("<color=#253053><size=30>%s</size></color>", data.stageName)
	else
		choiIconGo:SetActive(false)
		lineIconGo:SetActive(true)

		indexTxt.text = string.format("<color=#ffffff><size=24>%s</size></color>", data.stageName)
	end

	GameUtil.asBtn(itemGo):AddClickListener(function()
		self:ChoiseBattleStageShow(data.stageId)
	end)
end

function PetcollegeView:OnCellUpdatePosition(pos)
	local count = self._tableview:GetVisibleCount()

	for i = 0, count - 1 do
		local cell = self._tableview:GetCellByIndex(i)

		if cell then
			local subGo = goutil.findChild(cell, "itemGo")

			if subGo then
				local conPosY = self:CalculationLocalPosition(self._tableview:GetContent())
				local newX = math.abs(cell.transform.localPosition.y) - conPosY
				local rem = newX - math.floor(newX / (self.height * self.showItemCount)) * (self.height * self.showItemCount)

				if rem < self.height or rem >= self.height * (self.showItemCount - 1) then
					Framework.TransformUtil.SetLocalPos(subGo.transform, 45, 0, 0)
				elseif rem >= self.height and rem < self.height * 2 or rem >= self.height * 3 and rem < self.height * (self.showItemCount - 1) then
					Framework.TransformUtil.SetLocalPos(subGo.transform, 5, 0, 0)
				else
					Framework.TransformUtil.SetLocalPos(subGo.transform, -20, 0, 0)
				end
			end
		end
	end
end

function PetcollegeView:CalculationLocalPosition(go)
	if go == nil then
		return 8
	end

	local posY = go.transform.localPosition.y

	if posY < 0 then
		return 8
	end

	if self._curViewDatas == nil or #self._curViewDatas <= self.showItemCount then
		return 8
	end

	local differ = (#self._curViewDatas - self.showItemCount) * self.height

	if differ < posY then
		return differ
	end

	return posY + 8
end

function PetcollegeView:_onClickTip()
	TipsFacade.instance:openRulesView("petcollege")
end

return PetcollegeView
