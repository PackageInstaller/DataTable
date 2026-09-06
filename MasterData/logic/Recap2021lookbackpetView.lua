-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021lookbackpetView.lua

module("logic.extensions.recap2021.view.Recap2021lookbackpetView", package.seeall)

local Recap2021lookbackpetView = class("Recap2021lookbackpetView", TableViewComponent)

function Recap2021lookbackpetView:ctor()
	Recap2021lookbackpetView.super.ctor(self)

	self._cacheV2 = Vector2.New(0, 0)
	self._cacheV2.y = 112
end

function Recap2021lookbackpetView:unbindEvents()
	Recap2021lookbackpetView.super.unbindEvents(self)
end

function Recap2021lookbackpetView:bindEvents()
	Recap2021lookbackpetView.super.bindEvents(self)
end

function Recap2021lookbackpetView:buildUI()
	Recap2021lookbackpetView.super.buildUI(self)

	self._itemGo = self:getGo("part1/item")
	self._itemconGo = self:getGo("part1/itemcon")
	self._itemGroup = ItemGroup.New(self._itemconGo, self._itemGo, nil, nil, true)
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "part1/txtDesc")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._part1Go = self:getGo("part1")
	self._part2Go = self:getGo("part2")
	self._txtTotalGet = goutil.findChildTextComponent(self.mainGO, "part2/txtTotalGet")
	self._txtOver = goutil.findChildTextComponent(self.mainGO, "part2/txtOver")
	self._emojiGo = self:getGo("part1/emoji")
	self._txtSixPet = self:getTxt("part2/txtSixPet")
end

function Recap2021lookbackpetView:onExit()
	Recap2021lookbackpetView.super.onExit(self)
	self._itemGroup:dispose(function(item)
		local goIcon = goutil.findChild(item.mainGO, "root/icon")

		MaterialMgr.resetAll(goIcon)
		uGuiUtil.clearImage(goIcon)
	end)
	removetimer(self._updateItemsPos, self)
end

function Recap2021lookbackpetView:onEnter()
	Recap2021lookbackpetView.super.onEnter(self)

	self._personLookbackMo = self:getFirstParam()

	local partNum = checkint(self._personLookbackMo.viewCfg.param)

	goutil.setActive(self._part1Go, partNum == 1 or partNum == 3)
	goutil.setActive(self._part2Go, partNum == 2)
	goutil.setActive(self._emojiGo, partNum == 3)

	self._hidePetIcon = partNum == 3

	if partNum == 1 then
		self:_updatePart1()
	elseif partNum == 2 then
		self:_updatePart2()
	elseif partNum == 3 then
		self:_updatePart3()
	end

	self._txtTitle.text = self._personLookbackMo.viewCfg.name
end

function Recap2021lookbackpetView:_updatePart1()
	local cfgs = self._personLookbackMo:getCfgs()

	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)
	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		self:_updatePart1Cell(item, cfg)
	end)
end

function Recap2021lookbackpetView:_updatePart3()
	local cfgs = self._personLookbackMo:getCfgs()

	self._needMoveItems = {}
	self._runTime = 0
	self._duration = 0.3

	settimer(0, self._updateItemsPos, self, true)
	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		self:_updatePart1Cell(item, cfg)
	end)
end

function Recap2021lookbackpetView:_updatePart2()
	local data1 = self._personLookbackMo:getCfgs()[1]
	local value = Recap2021Model.instance:getDescByDataId(data1.dataId)

	value = checkint(value)

	if value > 0 then
		self._txtTotalGet.text = string.format(data1.desc, value)
	end

	local data2 = self._personLookbackMo:getCfgs()[2]
	local valueStr = Recap2021Model.instance:getDescByDataId(data2.dataId)

	if valueStr == -1 then
		self._curViewDatas = {
			-1,
			-1,
			-1,
			-1,
			-1,
			-1
		}
		self._txtSixPet.text = data2.noDataDesc
	else
		self._txtSixPet.text = "你战力最高的六只精灵是："
		self._curViewDatas = string.split(valueStr, ",")
	end

	self:reloadData()

	local overDesc = ""

	if data1.overPlanId > 0 then
		local ocfgs = Recap2021Config.instance:getOverPlanCfgs(data1.overPlanId)

		value = checkint(value)

		if value <= 0 then
			value = 0
		end

		for _, ocfg in ipairs(ocfgs) do
			local nums = string.split(ocfg.verifyStr, ",")
			local num1 = checkint(nums[1])
			local num2 = checkint(nums[2])

			if num1 <= value and (value <= num2 or num2 == -1) then
				overDesc = ocfg.desc

				break
			end
		end
	end

	self._txtOver.text = overDesc
end

function Recap2021lookbackpetView:_updatePart1Cell(item, cfg)
	local bgTr = goutil.findChild(item.mainGO, "root/bg").transform
	local img2Tr = goutil.findChild(item.mainGO, "root/img2").transform
	local goIconBg = goutil.findChild(item.mainGO, "root/bg/iconBg")
	local goIcon = goutil.findChild(item.mainGO, "root/icon")
	local goRoot = goutil.findChild(item.mainGO, "root")
	local goRootChangeGroup = goRoot:GetComponent(ComponentType.UIChangeGroup)
	local txtDesc = goutil.findChildTextComponent(item.mainGO, "root/txtDesc")
	local txtPet = goutil.findChildTextComponent(item.mainGO, "root/txtPet")
	local canvasGroup = goRoot:GetComponent(typeof(UnityEngine.CanvasGroup))
	local petName = Recap2021Model.instance:getDescByDataId(cfg.dataId)
	local value = Recap2021Model.instance:getVaueByDataId(cfg.dataId)
	local raceId = checknumber(value)
	local isNumberType = Recap2021Model.instance:isNumberValueByDataId(cfg.dataId)

	goRootChangeGroup:SetState(item.index - 1)

	txtDesc.text = cfg.desc

	goutil.setActive(goIconBg, not self._hidePetIcon)
	goutil.setActive(goIcon, not self._hidePetIcon)

	txtPet.text = petName ~= -1 and (isNumberType and raceId > 0 or not string.nilorempty(petName)) and petName or string.format("<size=26>%s</size>", cfg.noDataDesc)

	if isNumberType and raceId > 0 and CharacterConfig.instance:getPetCo(raceId) then
		MaterialMgr.setIcon(goIcon, MatType.Pet, raceId)
	else
		uGuiUtil.setSpriteToImage(goIcon, nil, GameUrl.getCharacterIconUrl("icon_common_jinglingjianying"))
	end

	local addNum = 50

	if self._hidePetIcon then
		Framework.TransformUtil.SetAnchoredPos(img2Tr, 137 + addNum, -10)

		self._cacheV2.x = 431 + addNum
	else
		self._cacheV2.x = 524

		Framework.TransformUtil.SetAnchoredPos(img2Tr, 280, -10)
	end

	bgTr.sizeDelta = self._cacheV2

	local moveDistance = 300
	local startPosX = moveDistance + (item.index - 1) * 80

	canvasGroup.alpha = 0

	Framework.TransformUtil.SetAnchoredPos(goRoot.transform, startPosX, 0)

	self._needMoveItems[goRoot] = {
		runTime = 0,
		isFinish = false,
		currPosX = 0,
		transform = goRoot.transform,
		canvasGroup = canvasGroup,
		startTime = self._duration * 0.8 * (item.index - 1),
		startPosX = startPosX,
		endPosX = startPosX - moveDistance
	}
end

function Recap2021lookbackpetView:_updateItemsPos()
	self._runTime = self._runTime + Time.deltaTime

	local isMove = false

	for k, v in pairs(self._needMoveItems) do
		if not v.isFinish then
			isMove = true

			if self._runTime >= v.startTime then
				if v.runTime < self._duration then
					local percent = v.runTime / self._duration

					v.runTime = v.runTime + Time.deltaTime
					v.canvasGroup.alpha = percent
					v.currPosX = v.startPosX - (v.startPosX - v.endPosX) * percent
				else
					v.currPosX = v.endPosX
					v.canvasGroup.alpha = 1
					v.isFinish = true
				end

				Framework.TransformUtil.SetAnchoredPos(v.transform, v.currPosX, 0)
			end
		end
	end

	if not isMove then
		removetimer(self._updateItemsPos, self)
	end
end

function Recap2021lookbackpetView:_getPath()
	return {
		cellPath = "part2/tablecell",
		viewPath = "part2/tableview"
	}
end

function Recap2021lookbackpetView:_updateCell(view, cell, raceId)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "icon")

	raceId = checknumber(raceId)

	if raceId <= 0 then
		uGuiUtil.setSpriteToImage(goIcon, nil, GameUrl.getCharacterIconUrl("icon_common_jinglingjianying"))
	else
		MaterialMgr.setIcon(goIcon, MatType.Pet, raceId)
	end
end

function Recap2021lookbackpetView:_clearTableview(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(goIcon)
	uGuiUtil.clearImage(goIcon)
end

return Recap2021lookbackpetView
