-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplaceupView.lua

module("logic.extensions.nineplace.view.NineplaceupView", package.seeall)

local NineplaceupView = class("NineplaceupView", ViewComponent)

function NineplaceupView:ctor()
	NineplaceupView.super.ctor(self)

	self.config = NinePlaceConfig.instance
	self.model = FormationNewModel.instance
	self.attrCacheList = {}
end

function NineplaceupView:buildUI()
	NineplaceupView.super.buildUI(self)

	self.goodsCon = self:getGo("right/goodsCon")
	self.closeBtn = self:getBtn("winCon/closeBtn")
	self.tipBtn = self:getBtn("winCon/tipBtn")
	self.upBtn = self:getBtn("right/upBtn")
	self.staticText = self:getGo("right/text")
	self.emptyGo = goutil.findChild(self.mainGO, "empty")
	self.rightGo = goutil.findChild(self.mainGO, "right")
	self.maxLvText = goutil.findChildTextComponent(self.rightGo, "maxLvText")
	self.nameText = goutil.findChildTextComponent(self.rightGo, "nameText")
	self.desText = goutil.findChildTextComponent(self.rightGo, "desText")
	self.lvNowText = goutil.findChildTextComponent(self.rightGo, "lvNowText")
	self.lvNextText = goutil.findChildTextComponent(self.rightGo, "lvNextText")
	self.attrNowText = goutil.findChildTextComponent(self.rightGo, "attrNowText")
	self.attrNextText = goutil.findChildTextComponent(self.rightGo, "attrNextText")
	self.dot = goutil.findChild(self.rightGo, "dot")
	self.imgName = goutil.findChild(self.rightGo, "imgName"):GetComponent(ComponentType.UIImageSpriteChange)
	self.cellGo = self:getGo("itemCon/cell")
	self.itemCon = self:getGo("itemCon")
	self.itemGroup = ItemGroup.New(self.itemCon, self.cellGo, nil, nil, true)

	GameUtil.SetActive(self.rightGo, false)
	GameUtil.SetActive(self.emptyGo, false)

	self.rightLightsList = {}

	local place = self:getGo("right/place")

	for i = 1, 9 do
		self.rightLightsList[i] = goutil.findChild(place, "cell" .. i):GetComponent(ComponentType.UIImageSpriteChange)
	end
end

function NineplaceupView:bindEvents()
	NineplaceupView.super.bindEvents(self)
	self.closeBtn:AddClickListener(self.close, self)
	self.tipBtn:AddClickListener(self.onClickTip, self)
end

function NineplaceupView:unbindEvents()
	NineplaceupView.super.unbindEvents(self)
	self.closeBtn:RemoveClickListener()
	self.tipBtn:RemoveClickListener()
end

function NineplaceupView:destroyUI()
	NineplaceupView.super.destroyUI(self)
end

function NineplaceupView:onEnter()
	NineplaceupView.super.onEnter(self)

	self.currStageId = self.model:getCurrBuffFormId()

	self.upBtn:AddClickListener(self.onClickUp, self)
	GlobalDispatcher:addListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
	GlobalDispatcher:addListener(GlobalNotify.BuffFormStrengthSuccessed, self.initView, self)
	self:initView()
end

function NineplaceupView:onEnterFinished()
	NineplaceupView.super.onEnterFinished(self)
end

function NineplaceupView:onExit()
	NineplaceupView.super.onExit(self)
	self.upBtn:RemoveClickListener()
	GlobalDispatcher:removeListener(NinePlaceModel.GetNinePlaceProcessInfoRes, self.initView, self)
	GlobalDispatcher:removeListener(GlobalNotify.BuffFormStrengthSuccessed, self.initView, self)
	MaterialMgr.resetAll(self.goodsCon)
end

function NineplaceupView:onExitFinished()
	NineplaceupView.super.onExitFinished(self)
end

function NineplaceupView:onClickTip()
	TipsFacade.instance:openRulesView("nineplaceupgrade")
end

function NineplaceupView:onClickUp()
	local stageId = self.currStageId
	local info = self.model:getFormStrengthInfo(stageId)

	if not info then
		return
	end

	local cfg = self.config:getStageCfgById(stageId)
	local maxLv = BattleConfig.instance:getFormStrengthMaxLv(stageId)

	if maxLv <= info.formStrengthLv then
		FloatWordMgr.instance:show("阵型等级已满级")

		return
	end

	if self.goodsEnough == false then
		FloatWordMgr.instance:show("当前材料不足")

		return
	end

	FormationFacade.instance:upgradeNinePlaceForm(stageId)
end

function NineplaceupView:initView()
	local cfgs = self.config:getStageCfgs()
	local spaceX = 200
	local spaceY = -200

	self.itemGroup:updateWithMoArray(cfgs, function(item, data)
		local x = (item.index - 1) % 3 * spaceX
		local y = (math.ceil(item.index / 3) - 1) * spaceY

		GameUtil.setLocalPos(item.mainGO, x, y, 0)

		item.mainGO.name = "cell_" .. item.index

		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local lvText = goutil.findChildTextComponent(item.mainGO, "lvText")
		local lock = goutil.findChild(item.mainGO, "lock")
		local upImg = goutil.findChild(item.mainGO, "upImg")
		local dot = goutil.findChild(item.mainGO, "dot")
		local btn = GameUtil.asBtn(goutil.findChild(item.mainGO, "raycast"))
		local place = goutil.findChild(item.mainGO, "place")
		local selectGo = goutil.findChild(item.mainGO, "select")
		local lightList = {}

		for i = 1, 9 do
			lightList[i] = goutil.findChild(place, "cell" .. i):GetComponent(ComponentType.UIImageSpriteChange)
		end

		local tempList = {}

		for i, v in ipairs(data.lights) do
			tempList[v] = true
		end

		for i, v in ipairs(lightList) do
			v:SetState(tempList[i] and 1 or 0)
		end

		nameText.text = data.name

		local info = self.model:getFormStrengthInfo(data.stageId)

		GameUtil.SetActive(upImg, info and info.formStrengthLv < BattleConfig.instance:getFormStrengthMaxLv(data.stageId))
		GameUtil.SetActive(lock, not info)

		if info then
			lvText.text = "Lv" .. info.formStrengthLv or ""
		end

		GameUtil.SetActive(dot, self.model:checkStageCanUpgrade(data.stageId))

		if data.stageId == self.currStageId then
			self:_setSelect(selectGo)
		end

		btn:AddClickListener(function()
			local reach = FuncOpenController.instance:getConditionReached(data.openCondition)

			if not reach then
				FloatWordMgr.instance:show(data.lockTip)

				return
			end

			if not info then
				local list = NinePlaceConfig.instance:getMonstersCfgByStageId(data.stageId)
				local creepsCfg = list[1]
				local str = "当前 " .. data.name .. " 尚未解锁，是否前往九宫八阵挑战 " .. creepsCfg.name .. " 开启 " .. data.name .. "?"

				local function okFunc()
					local fOpen = FuncOpenModel.instance:getFuncIsOpen(97)

					if not fOpen then
						local fCfg = FuncOpenConfig.instance:getFunctionOpenById(97)

						FloatWordMgr.instance:show(FuncOpenController.instance:getLockTips(fCfg))

						return
					end

					UIStateManager.instance:push(ViewName.NineplaceMissionView, data.stageId, creepsCfg.creepsMasterId)
				end

				TipsFacade.instance:openPopupWindow("提示", str, okFunc)

				return
			end

			self:_setSelect(selectGo)
			self:setNinePlaceDetail(data.stageId)
		end)
	end)

	local initStageId = self.currStageId

	if initStageId then
		self:setNinePlaceDetail(initStageId)
	end

	GameUtil.SetActive(self.rightGo, initStageId)
end

function NineplaceupView:_setSelect(selectGo)
	if self._lastSelectGo then
		goutil.setActive(self._lastSelectGo, false)
	end

	self._lastSelectGo = selectGo

	goutil.setActive(selectGo, true)
end

function NineplaceupView:setNinePlaceDetail(stageId)
	GameUtil.SetActive(self.rightGo, true)

	local cfg = self.config:getStageCfgById(stageId)

	if not cfg then
		return
	end

	self:setRightLights(cfg.lights)

	self.currStageId = stageId

	self.model:setCurrBuffFormId(stageId)
	self.imgName:ChangeSprite(cfg.upLvViewResName)

	self.desText.text = cfg.description

	local info = self.model:getFormStrengthInfo(stageId)
	local cfgNext

	if info then
		cfgNext = BattleConfig.instance:getFormStrengthLvCfg(info.formStrengthId, info.formStrengthLv + 1)
	end

	GameUtil.SetActive(self.goodsCon, cfgNext)
	self:setLvAndAttr(stageId)

	local showGoods = cfgNext and not string.nilorempty(cfgNext.upgradeCost)

	GameUtil.SetActive(self.goodsCon, showGoods)
	GameUtil.SetActive(self.dot, self.model:checkStageCanUpgrade(stageId))

	self.goodsEnough = nil

	if showGoods then
		local upgradeCost = cfgNext and cfgNext.upgradeCost
		local arr = string.split(upgradeCost, ":")
		local matType, matId = checknumber(arr[1]), checknumber(arr[2])
		local useNum = checknumber(arr[3])
		local proxy = MaterialMgr.setCellByCfg(upgradeCost, self.goodsCon)
		local has_num = MaterialFacade.instance:getMatNumber(matType, matId)

		if useNum <= has_num then
			if not (has_num .. "/" .. useNum) then
				local numStr = "<color=red>" .. has_num .. "/" .. useNum .. "</color>"

				self.goodsEnough = useNum <= has_num

				local function callBack()
					if not self.goodsEnough then
						MaterialMgr.openGetSource(matType, matId)
					else
						CommonTipsMgr.instance:openMaterialTips(self.goodsCon, matType, matId, 0)
					end
				end

				proxy.binder:setCallBack(callBack)
				proxy.binder:setNumStr(numStr)
				proxy.binder:setAutoTips(false)
			end
		end
	end

	self.maxLvText.text = cfgNext and "" or "已升至最高级"

	GameUtil.SetActive(self.upBtn, cfgNext)
	GameUtil.SetActive(self.staticText, cfgNext)
	GameUtil.SetGray(self.upBtn, not self.goodsEnough)
end

function NineplaceupView:setRightLights(list)
	local temp = {}

	for i, v in ipairs(list) do
		temp[v] = true
	end

	for i, v in ipairs(self.rightLightsList) do
		v:SetState(temp[i] and 1 or 0)
	end
end

function NineplaceupView:setLvAndAttr(stageId)
	local info = self.model:getFormStrengthInfo(stageId)

	if info then
		local maxLv = BattleConfig.instance:getFormStrengthMaxLv(stageId)
		local formStrengthId, formStrengthLv = info.formStrengthId, info.formStrengthLv
		local isMax = maxLv <= info.formStrengthLv
		local nowLv = formStrengthLv
		local nextLv = isMax and formStrengthLv or formStrengthLv + 1
		local cfgNow = BattleConfig.instance:getFormStrengthLvCfg(formStrengthId, nowLv)
		local cfgNext = BattleConfig.instance:getFormStrengthLvCfg(formStrengthId, nextLv)

		self.lvNowText.text = "Lv" .. nowLv
		self.lvNextText.text = "Lv" .. nextLv
		self.attrCacheList[cfgNow.properties] = self.attrCacheList[cfgNow.properties] or FightingPowerFormula.instance:parseAttrValues(cfgNow.properties)
		self.attrCacheList[cfgNext.properties] = self.attrCacheList[cfgNext.properties] or FightingPowerFormula.instance:parseAttrValues(cfgNext.properties)

		local attrNowList = self.attrCacheList[cfgNow.properties]
		local attrNextList = self.attrCacheList[cfgNext.properties]
		local nowStr = ""
		local nextStr = ""

		for k, v in pairs(attrNowList) do
			local name, value, _, str = GameUtil.getPropertyInfo(k, v, "#11a568")

			nowStr = nowStr .. " " .. str
		end

		for k, v in pairs(attrNextList) do
			local name, value, _, str = GameUtil.getPropertyInfo(k, v, "#11a568")

			nextStr = nextStr .. " " .. str
		end

		self.attrNowText.text = nowStr
		self.attrNextText.text = nextStr
	end
end

return NineplaceupView
