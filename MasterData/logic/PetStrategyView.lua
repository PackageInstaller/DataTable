-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petstrategy/view/PetStrategyView.lua

module("logic.extensions.petstrategy.view.PetStrategyView", package.seeall)

local PetStrategyView = class("PetStrategyView", ViewComponent)

function PetStrategyView:ctor()
	PetStrategyView.super.ctor(self)

	self._xingshenList = nil
end

function PetStrategyView:buildUI()
	PetStrategyView.super.buildUI(self)

	self._radarProerty = goutil.findChildComponent(self.mainGO, "radarProerty", "RadarProperty")
	self._radarLine = goutil.findChildComponent(self.mainGO, "radarProerty/radarLine", "RadarProperty")
	self._proerty = {}

	for i = 1, 5 do
		self._proerty[i] = goutil.findChildComponent(self._radarProerty.gameObject, "proerty_" .. i, "UIImageSpriteChange")
	end

	self._petIcon = self:getGo("left/petIcon")
	self._quality = goutil.findChildComponent(self._petIcon, "quality", "UIImageSpriteChange")
	self._resume = goutil.findChildTextComponent(self._petIcon, "resume")
	self._petName = goutil.findChildTextComponent(self.mainGO, "left/petName/Text")
	self._raceBg = goutil.findChildComponent(self.mainGO, "left/jobBg", "UIImageSpriteChange")
	self._jobIcon = goutil.findChildComponent(self.mainGO, "left/jobBg/icon", "UIImageSpriteChange")
	self._evaluate = goutil.findChildTextComponent(self.mainGO, "evaluate/txtEvalute")
	self._evaluateDescribe = goutil.findChildTextComponent(self.mainGO, "evaluate/describe/Viewport/Content")
	self._recommendFormation = {}

	for i = 1, 6 do
		self._recommendFormation[i] = self:getGo("recommend/formation/pet_" .. i)
	end

	self._standPosition = goutil.findChildComponent(self.mainGO, "stand/position", "TestRecordPos")
	self._standDescribe = goutil.findChildTextComponent(self.mainGO, "stand/describe")
	self._runeIcon = goutil.findChildComponent(self.mainGO, "rune/stargod/icon", "UIImageSpriteChange")
	self._runeName = goutil.findChildTextComponent(self.mainGO, "rune/stargod/name")
	self._runeDescribe = goutil.findChildTextComponent(self.mainGO, "rune/describe")
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._commentBtn = self:getBtn("commentBtn")
	self._closeBtn = self:getBtn("closeBtn")

	local runeGo = self:getGo("runeGo")

	self._xingshenList = {}

	for i = 1, 4 do
		local name = "xsGo_" .. i

		self._xingshenList[i] = {
			itemGo = goutil.findChild(runeGo, name),
			name = goutil.findChild(runeGo, name .. "/nameText")
		}
	end
end

function PetStrategyView:bindEvents()
	PetStrategyView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._leftBtn:AddClickListener(self._onClickLeft, self)
	self._rightBtn:AddClickListener(self._onClickRight, self)
	self._commentBtn:AddClickListener(self._onClickComment, self)
end

function PetStrategyView:unbindEvents()
	PetStrategyView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
	self._commentBtn:RemoveClickListener()
end

function PetStrategyView:destroyUI()
	PetStrategyView.super.destroyUI(self)

	self._xingshenList = nil
end

function PetStrategyView:onEnter()
	PetStrategyView.super.onEnter(self)

	local openParam = self:getOpenParam()

	GlobalDispatcher:addListener(PetStrategyConfig.UPDATE, self.update, self)

	self.petMo = openParam[1]

	self:_loadPetStrategy()
end

function PetStrategyView:onEnterFinished()
	PetStrategyView.super.onEnterFinished(self)
end

function PetStrategyView:onExit()
	PetStrategyView.super.onExit(self)
	GlobalDispatcher:removeListener(PetStrategyConfig.UPDATE, self.update, self)
	uGuiUtil.clearImage(self._petIcon)

	for _, item in pairs(self._xingshenList or {}) do
		if item and item.itemGo then
			MaterialMgr.resetAll(item.itemGo)
		end
	end

	for i, value in ipairs(self._recommendFormation) do
		MaterialMgr.resetAll(value)
	end
end

function PetStrategyView:onExitFinished()
	PetStrategyView.super.onExitFinished(self)
end

function PetStrategyView:_loadPetStrategy()
	local raceId = checknumber(self.petMo.raceId)
	local modelCfg = CharacterConfig.instance:getModelCo(raceId)
	local petCo = CharacterConfig.instance:getPetCo(raceId)
	local petStrategy = PetStrategyConfig.instance:getStrategyById(raceId)

	self._quality:SetState(petCo.rare - 1)

	self._resume.text = petStrategy.resume
	self._petName.text = petCo.name

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(self.petMo.curFaceId)

	race = race % 10

	self._raceBg:SetState(race - 1)

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(self.petMo.curFaceId)

	self._jobIcon:SetState(firstJobIdx - 1)

	self._evaluate.text = petStrategy.evaluate
	self._evaluateDescribe.text = petStrategy.evaluateDescribe

	self:_CreateAllXingshenItem(petCo.SGPRecommendId)

	if petStrategy.formation == nil then
		FloatWordMgr.instance:show(string.format("%d:%s的布阵配置信息为空", petCo.raceId, petCo.name))

		return
	end

	for i, value in ipairs(self._recommendFormation) do
		if petStrategy.formation[i] then
			goutil.setActive(value, true)
			MaterialMgr.setCell(MatType.Pet, petStrategy.formation[i], value)
		else
			goutil.setActive(value, false)
		end
	end

	self._standPosition:LoadPlan(petStrategy.plan - 1)

	self._standDescribe.text = petStrategy.stand

	if petStrategy.proerty == nil then
		FloatWordMgr.instance:show(string.format("%d:%s的属性配置信息为空", petCo.raceId, petCo.name))

		return
	end

	local temArr = {
		petCo.hpScore,
		petCo.attScore,
		petCo.defPhyScore,
		petCo.defMagScore,
		petCo.speedScore
	}

	self._radarProerty.sides = #temArr
	self._radarLine.sides = #temArr

	for i = 0, self._radarProerty.sides - 1 do
		local luaIndex = i + 1
		local val = temArr[luaIndex]
		local perVal = val / 6

		self._radarProerty.VerticesDistances[i] = perVal
		self._radarLine.VerticesDistances[i] = perVal

		self._proerty[luaIndex]:SetState(val)
	end

	goutil.setActive(self._radarProerty.gameObject, false)
	goutil.setActive(self._radarLine.gameObject, false)
	uGuiUtil.setSpriteToImage(self._petIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCfg.cardName), function()
		self._radarProerty:Refresh()
		self._radarLine:Refresh()
		goutil.setActive(self._radarProerty.gameObject, true)
		goutil.setActive(self._radarLine.gameObject, true)
	end)
end

function PetStrategyView:_CreateAllXingshenItem(SGPRecommendId)
	local temp = {}

	for i = 1, 4 do
		local cfg = StargodplusConfig.instance:getRecommendCfg(SGPRecommendId, i)

		for j, id in ipairs(cfg.recommend) do
			if temp[id] then
				temp[id].num = temp[id].num + 1
			else
				temp[id] = {
					num = 1,
					id = id
				}
			end
		end
	end

	local stargods = {}

	for k, v in pairs(temp) do
		table.insert(stargods, v)
	end

	table.sort(stargods, function(a, b)
		return a.num > b.num
	end)

	for i, value in ipairs(self._xingshenList) do
		local cfgStr = MatType.StarGodPlus .. ":" .. stargods[i].id

		MaterialMgr.setCellByCfg(cfgStr, value.itemGo)

		local cfg = StargodplusConfig.instance:getFillerCfg(stargods[i].id)

		value.name:GetComponent(goutil.Type_UIText).text = cfg.name

		value.name:GetComponent("UITextColorChange"):SetState(cfg.quality)
		value.name.transform:SetAsLastSibling()
	end
end

function PetStrategyView:update(leftFlag, rightFlag)
	self.petMo = BagPetsController.instance:GetCurPetMo()

	if PetStrategyConfig.instance:getStrategyById(self.petMo.raceId) then
		self:_loadPetStrategy()
	else
		FloatWordMgr.instance:show(string.format("没有%s的攻略信息", self.petMo.name))
	end
end

function PetStrategyView:_onClickLeft()
	GlobalDispatcher:dispatch(PetStrategyConfig.LEFTBTN, true)
end

function PetStrategyView:_onClickRight()
	GlobalDispatcher:dispatch(PetStrategyConfig.RIGHTBTN, false)
end

function PetStrategyView:_onClickComment()
	ViewMgr.instance:open(ViewName.PetComment, self.petMo.raceId)
end

return PetStrategyView
