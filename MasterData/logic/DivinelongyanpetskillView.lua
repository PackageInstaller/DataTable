-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinelongyan/view/DivinelongyanpetskillView.lua

module("logic.extensions.divinelongyan.view.DivinelongyanpetskillView", package.seeall)

local DivinelongyanpetskillView = class("DivinelongyanpetskillView", ViewComponent)

DivinelongyanpetskillView.SKILL_TYPE_LEVEL = {
	"passiveSkillLv",
	"normalSkillLv",
	"ultimateSkillLv",
	nil,
	nil,
	"psychicedUltimateSkillLv",
	"psychicedNormalSkillLv"
}
DivinelongyanpetskillView.SKILL_ID = {
	"passiveSkillId",
	"normalSkillId",
	"ultSkillId",
	nil,
	nil,
	"psychicedUltSkillId",
	"psychicedNormalSkillId"
}

local SkillTypeCount = 9

function DivinelongyanpetskillView:ctor()
	DivinelongyanpetskillView.super.ctor(self)
end

function DivinelongyanpetskillView:buildUI()
	DivinelongyanpetskillView.super.buildUI(self)

	self._stateHero = self:getGo("bom/stateHero")
	self._stateUpgrade = self:getGo("bom/stateUpgrade")
	self._stateMax = self:getGo("bom/stateMax")
	self._stateDomain = self:getGo("bom/stateDomain")
	self._statePsychiced = self:getGo("bom/statePsychiced")
	self._stateShenYao = self:getGo("bom/stateShenYao")
	self._tableGo = self:getGo("mid/tableview")
	self._itemGo = self:getGo("mid/tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._tableview:regReloadFinish(GameUtil.handler(self.reloadFinish, self))
	self._tableview:regGetCellSize(GameUtil.handler(self._cellSize, self))

	self._txtSkillDetails = goutil.findChildTextComponent(self.mainGO, "mid/scrollSkillDetails/viewport/content/txtContent")
	self._goSkillDetails = self:getGo("mid/scrollSkillDetails")
	self._txtSkillHeroDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillHeroDetails")
	self._txtSkillDomainDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillDomainDetails")
	self._txtSkillPsychicedDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillPsychicedDetails")
	self._txtSkillDescDetails = goutil.findChildTextComponent(self.mainGO, "mid/txtSkillDescDetails")
	self._txtDetail = goutil.findChildTextComponent(self._itemGo, "anchor/txtDetail")
	self._itemSizeImmediate = goutil.findChildComponent(self._itemGo, "anchor/txtDetail", "ContentSizeImmediate")
	self.txtTip = self:getTxt("bom/stateUpgrade/txtTip")
	self.txtTipGo = self:getGo("bom/stateUpgrade/txtTip")
	self.txtTipIcon = self:getGo("bom/stateUpgrade/txtTip/icon")
	self._condition = self:getGo("bom/stateUpgrade/condition")
	self._txtCondition = goutil.findChildTextComponent(self.mainGO, "bom/stateUpgrade/condition/txt")
	self._consumeList = {}

	for i = 1, 3 do
		local single = {}

		single.go = self:getGo("bom/stateUpgrade/mats/" .. i)
		single.btn = self:getBtn("bom/stateUpgrade/mats/" .. i)
		single.txtNum = goutil.findChildTextComponent(single.go, "txtNum")
		single.itemPoint = goutil.findChild(single.go, "itemPoint")
		single.toGet = goutil.findChild(single.go, "img_add")
		single.rareIcon = goutil.findChild(single.go, "quality"):GetComponent("UIImageSpriteChange")

		table.insert(self._consumeList, single)
	end

	self._btnUpgrade = self:getBtn("bom/stateUpgrade/btn_uplv")
	self._upgradeRedPoint = self:getGo("bom/stateUpgrade/btn_uplv/redPoint")

	self:_buildSkillItems()
end

function DivinelongyanpetskillView:_buildSkillItems()
	self._itemList = {}

	for i = 1, SkillTypeCount do
		local single = {}

		single.go = self:getGo("top/View/Viewport/Content/skills/item" .. i)
		single.txtName = self:getTxt("top/View/Viewport/Content/skills/item" .. i .. "/txtName")
		single.icon = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/icon")
		single.txtLevel = self:getTxt("top/View/Viewport/Content/skills/item" .. i .. "/txtLevel")
		single.select = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/select")
		single.btn = self:getBtn("top/View/Viewport/Content/skills/item" .. i)
		single.imgSkillType = goutil.findChild(single.go, "imgSkillType")
		single.redPoint = self:getGo("top/View/Viewport/Content/skills/item" .. i .. "/redPoint")

		table.insert(self._itemList, single)
	end

	self._skillItemsContent = self:getGo("top/View/Viewport/Content").transform
	self._skillItemsLayout = self:getGo("top/View/Viewport/Content/skills"):GetComponent(ComponentType.UILayoutSingleLine)
	self._skillItemsView = self:getGo("top/View"):GetComponent(ComponentType.ScrollRect)
end

function DivinelongyanpetskillView:bindEvents()
	DivinelongyanpetskillView.super.bindEvents(self)

	for i = 1, SkillTypeCount do
		self._itemList[i].btn:AddClickListener(function()
			self:_onClickSkill(i)
		end)
	end

	self._btnUpgrade:AddClickListener(self._upgradeSkill, self)
end

function DivinelongyanpetskillView:unbindEvents()
	DivinelongyanpetskillView.super.unbindEvents(self)

	for i = 1, 3 do
		self._consumeList[i].btn:RemoveClickListener()
	end

	for i = 1, SkillTypeCount do
		self._itemList[i].btn:RemoveClickListener()
	end

	self._btnUpgrade:RemoveClickListener()
end

function DivinelongyanpetskillView:destroyUI()
	DivinelongyanpetskillView.super.destroyUI(self)
end

function DivinelongyanpetskillView:onEnter()
	DivinelongyanpetskillView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineLongYanUpgradeSkillRes, self._refreshAll, self)

	local activityId = self:getFirstParam()

	self._activityId = activityId and activityId or DivinelongyanModel.instance:getActivityId()

	local cfg = DivinelongyanConfig.instance:getActCfg(self._activityId) or {}

	if not cfg.costMp then
		local costMp = ""

		self._costType, self._costId = MaterialMgr.getMatParams(costMp)
		self._selectType = 3

		self:_refreshAll()
	end
end

function DivinelongyanpetskillView:onEnterFinished()
	DivinelongyanpetskillView.super.onEnterFinished(self)
end

function DivinelongyanpetskillView:onExit()
	DivinelongyanpetskillView.super.onExit(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._consumeList[i].itemPoint)
	end

	for i = 1, SkillTypeCount do
		MaterialMgr.resetAll(self._itemList[i].icon)
	end

	removetimer(self._finishLayout, self)
	self._tableview:dispose()
end

function DivinelongyanpetskillView:onExitFinished()
	DivinelongyanpetskillView.super.onExitFinished(self)
end

function DivinelongyanpetskillView:_cellSize(view, index)
	local height = self.heightList[index + 1]

	return 300, height
end

function DivinelongyanpetskillView:_recordHeight()
	goutil.setActive(self._itemGo, true)

	self.heightList = {}

	local mo = self._petMo
	local scrollData = self:_getSkillLevelData(mo.curFaceId)

	for k, data in ipairs(scrollData) do
		self:_updateCell(nil, self._itemGo, data)

		local size = self._itemSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y + 19.5))
	end

	goutil.setActive(self._itemGo, false)
end

function DivinelongyanpetskillView:_getSkillLevelData(skinId, maxLevel)
	local scrollData = {}
	local skillInfocfg

	if self._selectType == 5 then
		local petCo = PetSkinConfig.instance:getPetSkinCfg(skinId)

		skillInfocfg = BattleConfig.instance:getDomainSkillLevels(petCo.domainSkillId)
	else
		skillInfocfg = CharacterConfig.instance:getSkillInfoById(skinId)
	end

	for k, v in pairs(skillInfocfg) do
		if maxLevel then
			if k <= maxLevel then
				table.insert(scrollData, v)
			end
		else
			table.insert(scrollData, v)
		end
	end

	table.sort(scrollData, function(a, b)
		return a.level < b.level
	end)

	return scrollData
end

function DivinelongyanpetskillView:_refreshAllAndResetPos()
	self:_refreshAll()

	self._skillItemsView.horizontalNormalizedPosition = 0
end

function DivinelongyanpetskillView:_refreshAll()
	self._petMo = DivinelongyanModel.instance:getCurSuppopPetMo(self._activityId) or {}

	self:_refreshSelectTab()
	self:_recordHeight()
	self:_refreshData()

	local num = -1
	local mo = self._petMo
	local list = DivinelongyanConfig.instance:getSkillCfgList(self._activityId, self._selectType)
	local lv = self.curLevel

	for i, v in ipairs(list) do
		if lv >= v.skillLevel or v.petLevelLimit > mo.level then
			-- block empty
		else
			num = v.cost

			break
		end
	end

	GameUtil.SetActive(self.txtTipGo, num > 0)

	self.txtTip.text = langPara("消耗:%s", num)

	MaterialMgr.setIcon(self.txtTipIcon, self._costType, self._costId)
end

function DivinelongyanpetskillView:_refreshSelectTab()
	local mo = self._petMo
	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local skinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

	self._skillIds = {}

	table.insert(self._skillIds, skinCo.passiveSkillId)
	table.insert(self._skillIds, skinCo.normalSkillId)
	table.insert(self._skillIds, skinCo.ultSkillId)
	table.insert(self._skillIds, skinCo.heroSkillId)
	table.insert(self._skillIds, skinCo.domainSkillId)
	table.insert(self._skillIds, skinCo.psychicedUltSkillId)
	table.insert(self._skillIds, skinCo.psychicedNormalSkillId)
	table.insert(self._skillIds, skinCo.psychicSkillId)
	table.insert(self._skillIds, skinCo.shenyaoSkillId)
	table.insert(self._skillIds, skinCo.carriedSkillId)
	table.insert(self._skillIds, skinCo.oracleSkillId)

	if self._selectType and self._skillIds[self._selectType] == 0 then
		for i = SkillTypeCount, 1, -1 do
			if self._skillIds[i] ~= 0 then
				self._selectType = i

				break
			end
		end
	end
end

function DivinelongyanpetskillView:_refreshData()
	local mo = self._petMo

	self._petId = mo.petId

	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petSkinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
	local skillLevelStrategyId = petCo.skillLevelStrategyId

	if mo and petCo then
		local skillCount = 0

		for i = 1, SkillTypeCount do
			if self._skillIds[i] == 0 then
				self._itemList[i].go:SetActive(false)
			else
				skillCount = skillCount + 1

				self._itemList[i].go:SetActive(true)

				local proxy = MaterialMgr.setSkillByFaceId(self._skillIds[i], mo.curFaceId, self._itemList[i].icon)

				if proxy then
					proxy:setAutoTips(false)
				end

				local skillCfg = BattleConfig.instance:getSkillCo(self._skillIds[i])
				local level = checknumber(mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[i]])

				if level == 0 then
					level = 1
				end

				self._itemList[i].txtName.text = skillCfg.name
				self._itemList[i].txtLevel.text = level

				goutil.setActive(self._itemList[i].select, i == self._selectType)

				local skicon = skillCfg.skillTopImg

				uGuiUtil.setSpriteToImage(self._itemList[i].imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))
				goutil.setActive(self._itemList[i].redPoint, false)
			end
		end

		local skillInfocfg = CharacterConfig.instance:getSkillInfoById(mo.curFaceId)

		self.curLevel = mo[DivinelongyanpetskillView.SKILL_TYPE_LEVEL[self._selectType]] or 1

		if self.curLevel == 0 then
			self.curLevel = 1
		end

		local maxLevel = BagPetsController.instance:getPetSkillMaxLevel(mo.curFaceId, self._selectType)
		local state = self._selectType == 4 and 1 or self._selectType == 5 and 4 or self._selectType == 8 and 5 or self._selectType == 9 and 6 or self.curLevel and maxLevel > self.curLevel and 2 or 3

		goutil.setActive(self._tableGo, state ~= 1 and state ~= 5)
		goutil.setActive(self._stateHero, state == 1)
		goutil.setActive(self._stateUpgrade, state == 2)
		goutil.setActive(self._stateMax, state == 3)
		goutil.setActive(self._stateDomain, state == 4)
		goutil.setActive(self._statePsychiced, state == 5)
		goutil.setActive(self._stateShenYao, state == 6)

		if state ~= 1 and state ~= 4 and state ~= 5 and state ~= 6 then
			local skillInfocfg = CharacterConfig.instance:getSkillInfoById(mo.curFaceId)
			local skillLevelCfg = skillInfocfg[self.curLevel]
			local skillId = skillLevelCfg[DivinelongyanpetskillView.SKILL_ID[self._selectType]]
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDetails.text = skillCo.desc or ""
			end
		elseif state == 1 then
			local skillId = petSkinCo.heroSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillHeroDetails.text = skillCo.desc or ""
			end
		elseif state == 5 then
			local skillId = petSkinCo.psychicSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillPsychicedDetails.text = skillCo.desc or ""
			end
		elseif state == 4 then
			local skillId = petSkinCo.domainSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDomainDetails.text = skillCo.desc or ""
			end
		elseif state == 6 then
			local skillId = petSkinCo.shenyaoSkillId
			local skillCo = BattleConfig.instance:getSkillCo(skillId)

			if skillCo then
				self._txtSkillDescDetails.text = skillCo.desc or ""
			end
		end

		self._goSkillDetails.gameObject:SetActive(false)
		self._txtSkillHeroDetails.gameObject:SetActive(state == 1)
		self._txtSkillDomainDetails.gameObject:SetActive(state == 4)
		self._txtSkillPsychicedDetails.gameObject:SetActive(state == 5)
		self._txtSkillDescDetails.gameObject:SetActive(state == 6)

		if state ~= 1 and state ~= 5 then
			local scrollData = self:_getSkillLevelData(mo.curFaceId, maxLevel)

			self._tableview:reloadData(scrollData)
		end

		if state == 2 then
			local consumeCfg = CharacterConfig.instance:getSkillLevelStrategyById(skillLevelStrategyId, self._selectType, self.curLevel + 1)

			if consumeCfg then
				self._limitLevel = checknumber(consumeCfg.petLevelLimit)
				self._enoughLevel = mo.level >= self._limitLevel

				if self._limitLevel > 0 and not self._enoughLevel then
					self._txtCondition.text = langPara("精灵达到%d级后解锁升级", self._limitLevel)

					goutil.setActive(self._condition, true)
				else
					goutil.setActive(self._condition, false)
				end

				goutil.setActive(self._upgradeRedPoint, false)
			end
		end

		self:_updateSkillView(skillCount)
		self._skillItemsLayout:Layout()
	end
end

function DivinelongyanpetskillView:_updateSkillView(skillCount)
	if skillCount <= 3 then
		Framework.TransformUtil.SetAnchoredPos(self._skillItemsLayout.transform, 250, 34)

		self._skillItemsView.enabled = false
		self._skillItemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.HorizontalCenter
	else
		Framework.TransformUtil.SetAnchoredPos(self._skillItemsLayout.transform, 80, 34)

		self._skillItemsView.enabled = true
		self._skillItemsLayout.layoutOption = UILayoutSingleLine.LayoutOption.LeftRight
	end

	local sizeDelta = self._skillItemsContent.sizeDelta

	sizeDelta.x = skillCount * self._skillItemsLayout.horizontalSpace + 30
	self._skillItemsContent.sizeDelta = sizeDelta
end

function DivinelongyanpetskillView:_refreshBottom()
	return
end

function DivinelongyanpetskillView:_updateCell(view, cell, data)
	if cell == nil then
		return
	end

	local go = cell.gameObject
	local txtLevel = goutil.findChildTextComponent(go, "anchor/txtLevel")
	local txtLevelColorChange = txtLevel:GetComponent(typeof(UITextColorChange))
	local txtDetail = goutil.findChildTextComponent(go, "anchor/txtDetail")
	local txtDetailColorChange = txtDetail:GetComponent(typeof(UITextColorChange))

	if self._selectType == 5 then
		local mo = self._petMo
		local petCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
		local skillCfg = BattleConfig.instance:getSkillCo(petCo.domainSkillId)

		txtLevel.text = skillCfg.name .. GameUtil.toRomanNumber(data.level)
		txtDetail.text = data.desc

		if view then
			txtLevelColorChange:SetState(0)
			txtDetailColorChange:SetState(0)
		end
	else
		txtLevel.text = langPara("%d级", data.level)

		local skillKey = DivinelongyanpetskillView.SKILL_ID[self._selectType]
		local skillId = data[skillKey]
		local cfg = BattleConfig.instance:getSkillCo(skillId, self._petMo.curFaceId) or {}
		local des = cfg.desc

		if string.nilorempty(des) then
			des = "  "
		end

		txtDetail.text = langPara("%s", des)

		if view then
			txtLevelColorChange:SetState(cell.index < self.curLevel and 1 or 0)
			txtDetailColorChange:SetState(cell.index < self.curLevel and 1 or 0)
		end
	end

	if view then
		GameUtil.setHeight(go, self.heightList[cell.data])

		local line = goutil.findChild(go, "imgline")

		GameUtil.setLocalPos(line, 243, -self.heightList[cell.data], 0)
	end
end

function DivinelongyanpetskillView:_clearCell(cell)
	return
end

function DivinelongyanpetskillView:_onClickSkill(index)
	if index ~= checknumber(self._selectType) then
		self._selectType = index

		self:_refreshAll()
	end
end

function DivinelongyanpetskillView:_upgradeSkill()
	local mo = self._petMo
	local list = DivinelongyanConfig.instance:getSkillCfgList(self._activityId, self._selectType)
	local lv = self.curLevel

	for i, v in ipairs(list) do
		if lv < v.skillLevel then
			if v.petLevelLimit > mo.level then
				TipsFacade.instance:openCommonTips(langPara("精灵等级需要达到%s时才可以升级此技能", v.petLevelLimit))

				return
			else
				local name = MaterialMgr.getMaterialsName(self._costType, self._costId)
				local content = langPara("确认消耗<color=#C54949>%s</color>%s将该技能\n由<color=#C54949>Lv%s</color>强化到<color=#C54949>Lv%s</color>吗？", v.cost, name, lv, v.skillLevel)

				if list[i + 1] ~= nil then
					local obj = list[i + 1]

					content = content .. langPara("\n下一次<color=#C54949>Lv%s</color>强化到<color=#C54949>Lv%s</color>需消耗<color=#C54949>%s</color>%s", v.skillLevel, obj.skillLevel, obj.cost, name)
				end

				TipsFacade.instance:openPopupCostMatViewNew(self._costType, self._costId, v.cost, content, function()
					local serType = CharacterConfig.skillTypeMap[self._selectType]

					DivineLongYanChallengeAgent.instance:sendPM_DivineLongYanUpgradeSkillReq(self._activityId, serType)
				end)

				return
			end
		end
	end

	TipsFacade.instance:openCommonTips(lang("当前技能已满级"))
end

function DivinelongyanpetskillView:reloadFinish()
	if self.curLevel then
		self._tableview:MoveCellInView(self.curLevel - 1, true)
	end
end

return DivinelongyanpetskillView
