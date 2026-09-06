-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetSkillView.lua

module("logic.extensions.bag.view.PetSkillView", package.seeall)

local PetSkillView = class("PetSkillView", ViewComponent)

PetSkillView.SKILL_TYPE_LEVEL = {
	"passiveSkillLv",
	"normalSkillLv",
	"ultimateSkillLv",
	nil,
	nil,
	"psychicedUltimateSkillLv",
	"psychicedNormalSkillLv"
}
PetSkillView.SKILL_ID = {
	"passiveSkillId",
	"normalSkillId",
	"ultSkillId",
	nil,
	nil,
	"psychicedUltSkillId",
	"psychicedNormalSkillId",
	nil,
	nil,
	nil,
	"heavenAwakenSkillId"
}

function PetSkillView:ctor()
	PetSkillView.super.ctor(self)
end

function PetSkillView:buildUI()
	PetSkillView.super.buildUI(self)

	self._stateUpgrade = self:getGo("bom/stateUpgrade")
	self._stateMax = self:getGo("bom/stateMax")
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
	self._skillDescDetailsGo = self:getGo("mid/skillDescDetails")
	self._txtSkillDescDetails = self:getTxt("mid/skillDescDetails/Viewport/txtSkillDescDetails")
	self._txtDetail = goutil.findChildTextComponent(self._itemGo, "anchor/txtDetail")
	self._itemSizeImmediate = goutil.findChildComponent(self._itemGo, "anchor/txtDetail", "ContentSizeImmediate")
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
	self._txtNoLevel = self:getTxt("bom/stateNoLevel/Text")
	self._stateNoLevelGo = self:getGo("bom/stateNoLevel")
	self._toptableview = self:getGo("top/toptableview")
	self._toptablecell = self:getGo("top/toptablecell")
	self._topscrollList = ScrollerList.create(self._toptableview, self._toptablecell, GameUtil.handler(self._updateTopCell, self), GameUtil.handler(self._clearTopCell, self))

	self._topscrollList:setCenterMode(true)
end

function PetSkillView:bindEvents()
	PetSkillView.super.bindEvents(self)
	self._btnUpgrade:AddClickListener(self._upgradeSkill, self)
end

function PetSkillView:unbindEvents()
	PetSkillView.super.unbindEvents(self)

	for i = 1, 3 do
		self._consumeList[i].btn:RemoveClickListener()
	end

	self._btnUpgrade:RemoveClickListener()
end

function PetSkillView:destroyUI()
	PetSkillView.super.destroyUI(self)
end

function PetSkillView:onEnter()
	PetSkillView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.OnPetSelect, self._onSelectPetChange, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._refreshData, self)

	self._dontResetSkillView = false
	self._selectType = 3

	self:_refreshAll()
end

function PetSkillView:onEnterFinished()
	PetSkillView.super.onEnterFinished(self)
end

function PetSkillView:onExit()
	self._dontResetSkillView = nil

	PetSkillView.super.onExit(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._consumeList[i].itemPoint)
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnPetSelect, self._onSelectPetChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._refreshData, self)
	removetimer(self._finishLayout, self)
	self._tableview:dispose()
	self._topscrollList:dispose()
end

function PetSkillView:onExitFinished()
	PetSkillView.super.onExitFinished(self)
end

function PetSkillView:_cellSize(view, index)
	local height = self.heightList[index + 1]

	return 300, height
end

function PetSkillView:_recordHeight()
	goutil.setActive(self._itemGo, true)

	self.heightList = {}

	local mo = BagPetsController.instance:GetCurPetMo()
	local scrollData = self:_getSkillLevelData(mo.curFaceId)

	for k, data in ipairs(scrollData) do
		self:_updateCell(nil, self._itemGo, data)

		local size = self._itemSizeImmediate:GetPreferredSize()

		table.insert(self.heightList, math.max(25, size.y + 19.5))
	end

	goutil.setActive(self._itemGo, false)
end

function PetSkillView:_getSkillLevelData(skinId, maxLevel)
	local scrollData = {}
	local skillInfocfg

	for k, v in pairs((CharacterConfig.instance:getSkillInfoById(skinId))) do
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

function PetSkillView:_refreshAll()
	self:_refreshSelectTab()
	self:_recordHeight()
	self:_refreshData()
end

function PetSkillView:_refreshSelectTab()
	local mo = BagPetsController.instance:GetCurPetMo()
	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local skinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)

	self._skillIds = {}

	for i, key in ipairs(BagModel.KEY_LIST) do
		table.insert(self._skillIds, checknumber(skinCo[key]))
	end

	if self._selectType and self._skillIds[self._selectType] == 0 then
		for i, skillId in ipairs(self._skillIds) do
			self._selectType = i

			break
		end
	end
end

function PetSkillView:_updateTopCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local icon = goutil.findChild(cell, "icon")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local select = goutil.findChild(cell, "select")
	local imgSkillType = goutil.findChild(cell, "imgSkillType")
	local redPoint = goutil.findChild(cell, "redPoint")
	local mo = BagPetsController.instance:GetCurPetMo()

	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickSkill, self, data.idx))

	local proxy = MaterialMgr.setSkillByFaceId(data.skillId, mo.curFaceId, icon)

	if proxy then
		proxy:setAutoTips(false)
	end

	local skillCfg = BattleConfig.instance:getSkillCo(data.skillId)
	local level = checknumber(mo[BagModel.SKILL_TYPE_LEVEL_MAP[data.idx]])

	if level == 0 then
		level = 1
	end

	txtName.text = skillCfg.name
	txtLevel.text = level

	goutil.setActive(select, data.idx == self._selectType)

	local skicon = skillCfg.skillTopImg

	uGuiUtil.setSpriteToImage(imgSkillType.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getSkillIconUrl(skicon))
	goutil.setActive(redPoint, BagPetsController.instance:getIfPetSkillUpgrade(mo.petId, data.skillKey))
end

function PetSkillView:_clearTopCell(cell)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local icon = goutil.findChild(cell, "icon")
	local txtLevel = goutil.findChildTextComponent(cell, "txtLevel")
	local select = goutil.findChild(cell, "select")
	local imgSkillType = goutil.findChild(cell, "imgSkillType")
	local redPoint = goutil.findChild(cell, "redPoint")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(cell)
end

function PetSkillView:_refreshData()
	local mo = BagPetsController.instance:GetCurPetMo()

	self._petId = mo.petId

	local raceId = mo.raceId
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petSkinCo = PetSkinConfig.instance:getPetSkinCfg(mo.curFaceId)
	local skillLevelStrategyId = petCo.skillLevelStrategyId

	if mo and petCo then
		local topDataList = {}

		for i, key in ipairs(BagModel.KEY_LIST) do
			local skillId = checknumber(petSkinCo[key])

			if skillId ~= 0 then
				local temp = {}

				temp.idx = i
				temp.skillId = skillId
				temp.skillKey = key

				table.insert(topDataList, temp)
			end
		end

		self._topscrollList:reloadData(topDataList)

		self.curLevel = mo[BagModel.SKILL_TYPE_LEVEL_MAP[self._selectType]] or 1

		if self.curLevel == 0 then
			self.curLevel = 1
		end

		local skillKey = BagModel.KEY_LIST[self._selectType]
		local maxLevel = BagPetsController.instance:getPetSkillMaxLevelByCfgKey(mo.curFaceId, skillKey)
		local scrollData = self:_getSkillLevelData(mo.curFaceId, maxLevel)

		self._tableview:reloadData(scrollData)
		goutil.setActive(self._tableGo, true)
		goutil.setActive(self._stateUpgrade, maxLevel > self.curLevel)
		goutil.setActive(self._stateMax, maxLevel <= self.curLevel)
		goutil.setActive(self._stateNoLevelGo, false)
		self._goSkillDetails.gameObject:SetActive(false)
		self._txtSkillHeroDetails.gameObject:SetActive(false)
		self._txtSkillDomainDetails.gameObject:SetActive(false)
		self._txtSkillPsychicedDetails.gameObject:SetActive(false)
		self._skillDescDetailsGo.gameObject:SetActive(false)

		if maxLevel > self.curLevel then
			local serType = BagModel.SERVER_ID[skillKey]
			local consumeCfg = CharacterConfig.instance:getSkillLevelCfgById(skillLevelStrategyId, serType, self.curLevel + 1)

			if consumeCfg then
				self._limitLevel = checknumber(consumeCfg.petLevelLimit)
				self._enoughLevel = mo.curLv >= self._limitLevel

				if self._limitLevel > 0 and not self._enoughLevel then
					self._txtCondition.text = langPara("精灵达到%d级后解锁升级", self._limitLevel)

					goutil.setActive(self._condition, true)
				else
					goutil.setActive(self._condition, false)
				end

				local str = consumeCfg.costMp
				local strs = string.split(str, "#")

				self._enoughItem = true
				self._needItem = nil

				for i = 1, 3 do
					if i <= #strs then
						goutil.setActive(self._consumeList[i].go, true)

						local consume = strs[i]
						local arr = string.split(consume, ":")
						local useNum = checknumber(arr[3])
						local has_num = MaterialFacade.instance:getMatNumber(arr[1], arr[2])

						self._consumeList[i].txtNum.text = langPara("%d/%d", has_num, useNum)

						MaterialMgr.setIcon(self._consumeList[i].itemPoint, arr[1], arr[2])

						local itemNotEnough = has_num < useNum

						self._consumeList[i].btn:AddClickListener(function()
							self:_clickConsumeItem(self._consumeList[i].itemPoint, not itemNotEnough, consume)
						end)
						goutil.setActive(self._consumeList[i].toGet, itemNotEnough)

						if itemNotEnough then
							self._enoughItem = false
							self._needItem = consume
						end

						local mtCfg = MaterialMgr.getMatCfg(arr[1], arr[2])

						self._consumeList[i].rareIcon:SetState(1 + (mtCfg.quality or 0))
					else
						goutil.setActive(self._consumeList[i].go, false)
					end
				end

				self._enoughUpgrade = self._enoughLevel and self._enoughItem

				goutil.setActive(self._upgradeRedPoint, self._enoughUpgrade)
			end
		end
	end
end

function PetSkillView:_refreshBottom()
	return
end

function PetSkillView:_updateCell(view, cell, data)
	local txtLevel = goutil.findChildTextComponent(cell, "anchor/txtLevel")
	local txtLevelColorChange = txtLevel:GetComponent(typeof(UITextColorChange))
	local txtDetail = goutil.findChildTextComponent(cell, "anchor/txtDetail")
	local txtDetailColorChange = txtDetail:GetComponent(typeof(UITextColorChange))
	local mo = BagPetsController.instance:GetCurPetMo()

	txtLevel.text = langPara("%d级", data.level)

	local skillKey = BagModel.KEY_LIST[self._selectType]
	local skillId = data[skillKey]
	local cfg = BattleConfig.instance:getSkillCo(skillId, mo.curFaceId) or {}
	local des = cfg.desc

	if string.nilorempty(des) then
		des = "  "
	end

	txtDetail.text = langPara("%s", des)

	if view then
		txtLevelColorChange:SetState(cell.index < self.curLevel and 1 or 0)
		txtDetailColorChange:SetState(cell.index < self.curLevel and 1 or 0)
	end

	if view then
		GameUtil.setHeight(cell, self.heightList[cell.data])

		local line = goutil.findChild(cell, "imgline")

		GameUtil.setLocalPos(line, 243, -self.heightList[cell.data], 0)
	end
end

function PetSkillView:_clearCell(cell)
	return
end

function PetSkillView:_onClickSkill(index)
	if index ~= checknumber(self._selectType) then
		self._selectType = index

		self:_refreshAll()
	end
end

function PetSkillView:_upgradeSkill()
	print(">>>>>>>>>>>>>>>>>self._selectTypeself._selectTypeself._selectType", self._selectType)

	local petMo = BagPetsController.instance:getPet(self._petId)

	if petMo and petMo:isBorrowPet() then
		FloatWordMgr.instance:show(lang("租借精灵不可升级"))

		return
	end

	if self._enoughUpgrade then
		local curLevel = self.curLevel

		self._dontResetSkillView = true

		local skillKey = BagModel.KEY_LIST[self._selectType]
		local serType = BagModel.SERVER_ID[skillKey]

		BagPetsController.instance:upgradePetSkillByServerType(self._petId, serType, function()
			local params = {}
			local petSkinCo = PetSkinConfig.instance:getPetSkinCfg(petMo.curFaceId) or {}
			local skillId = checknumber(petSkinCo[skillKey])
			local skillCfg = BattleConfig.instance:getSkillCo(skillId) or {}

			params.skillName = skillCfg.name or ""
			params.skillLevel = curLevel + 1

			UIStateManager.instance:open(ViewName.PetskillsuccessView, params)
		end)
	elseif not self._enoughItem then
		MopupModel.instance:setPetTalentUpCostStr(self._needItem)
		MaterialMgr.openGetSourceByStr(self._needItem)
	elseif not self._enoughLevel then
		FloatWordMgr.instance:show(langPara("精灵达到%s级后解锁升级", self._limitLevel))
	end
end

function PetSkillView:_clickConsumeItem(cell, enough, cfg)
	if enough then
		local arr = string.split(cfg, ":")

		CommonTipsMgr.instance:openMaterialTips(cell, checknumber(arr[1]), checknumber(arr[2]), 0)
	else
		MopupModel.instance:setPetTalentUpCostStr(cfg)
		MaterialMgr.openGetSourceByStr(cfg)
	end
end

function PetSkillView:reloadFinish()
	if self.curLevel then
		self._tableview:MoveCellInView(self.curLevel - 1, true)
	end
end

function PetSkillView:_onSelectPetChange()
	self:_refreshAll()
end

return PetSkillView
