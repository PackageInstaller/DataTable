-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountCultivateView.lua

module("logic.extensions.mount.view.MountCultivateView", package.seeall)

local MountCultivateView = class("MountCultivateView", ViewComponent)
local MAX_POTENTIAL_STATE = 3
local MAX_LIGHT_NUM = 5

function MountCultivateView:ctor()
	MountCultivateView.super.ctor(self)
end

function MountCultivateView:unbindEvents()
	MountCultivateView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMinus)
	GameUtil.rmClickHandler(self._btnLevelUp)
	GameUtil.rmClickHandler(self._btnPre)
	GameUtil.rmClickHandler(self._btnNext)
	self._sliderAdapter:RemoveOnValueChanged()
end

function MountCultivateView:bindEvents()
	MountCultivateView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnMinus, self._onClickMinus, self)
	GameUtil.addClickHandler(self._btnLevelUp, self._onClickLevelUp, self)
	GameUtil.addClickHandler(self._btnPre, self._onClickPre, self)
	GameUtil.addClickHandler(self._btnNext, self._onClickNext, self)
	self._sliderAdapter:AddOnValueChanged(self._setSliderValue, self)
end

function MountCultivateView:buildUI()
	MountCultivateView.super.buildUI(self)

	self._mount = self:getGo("mount")
	self._potentials = {}

	for i = 1, 5 do
		local potential = {}

		potential.ball = goutil.findChildComponent(self.mainGO, "info/potency/ball" .. i, "UIImageSpriteChange")
		potential.line = goutil.findChildComponent(self.mainGO, "info/potency/line" .. i, "UIImageSpriteChange")

		table.insert(self._potentials, potential)
	end

	self._attrs = {}

	for i = 1, 4 do
		local attr = {}

		attr.go = goutil.findChild(self.mainGO, "info/attribute/attr" .. i)
		attr.icon = goutil.findChildComponent(attr.go, "icon", ComponentType.UIImageSpriteChange)
		attr.txtName = goutil.findChildTextComponent(attr.go, "txtName")
		attr.txtVal = goutil.findChildTextComponent(attr.go, "txtVal")
		attr.txtBarrage = goutil.findChildTextComponent(attr.go, "txtBarrage")
		self._attrs[i] = attr
	end

	self._btnClose = self:getGo("btnClose")
	self._cultivateTime = self:getGo("cultivateTime")
	self._levelSlider = self:getGo("cultivateTime/timeSlider")
	self._sliderAdapter = Framework.SliderAdapter.Get(self._levelSlider)
	self._btnAdd = self:getGo("cultivateTime/btnAdd")
	self._btnMinus = self:getGo("cultivateTime/btnMinus")
	self._txTimes = self:getTxt("cultivateTime/txTimes")
	self._costTablecell = self:getGo("costTableview/costTablecell")
	self._costTableview = self:getGo("costTableview")
	self._costTableList = ScrollerList.create(self._costTableview, self._costTablecell, GameUtil.handler(self._updateCostCell, self), GameUtil.handler(self._clearCostCell, self))
	self._tweeners = {}
	self._btnLevelUp = self:getGo("btnLevelUp")
	self._cultivateMax = self:getGo("cultivateMax")
	self._txtName = self:getTxt("name/txt")
	self._markUp = self:getGo("markUp")
	self._txtMarkUp = self:getTxt("markUp/txtAtt")
	self._btnPre = self:getGo("btnPre")
	self._btnNext = self:getGo("btnNext")
end

function MountCultivateView:onExit()
	MountCultivateView.super.onExit(self)
	uGuiUtil.clearImage(self._mount)

	for k, tween in pairs(self._tweeners) do
		if tween then
			tween:Kill(false)

			self._tweeners[k] = nil
		end
	end
end

function MountCultivateView:onEnter()
	MountCultivateView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MountAttributeShow, self._showBarrage, self)
	self.addGEvent(self, MountAgent.MountBreachRes, self._handlePM_MountBreachRes, self)

	local params = self:getOpenParam()

	self._selectMountId = checknumber(params[1])

	local mountCfgs = params[2]

	self._mountCfgs = {}

	for i, v in ipairs(mountCfgs) do
		if checknumber(v.levelUpPlan) ~= 0 then
			table.insert(self._mountCfgs, v)
		end
	end

	self:_initView()
end

function MountCultivateView:_initView()
	local mountCfg = MountConfig.instance:getMountCo(self._selectMountId)

	uGuiUtil.clearImage(self._mount)
	uGuiUtil.setSpriteToImage(self._mount, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/mount/%s.png", mountCfg.AssistCardName))

	self._txtName.text = mountCfg.name
	self._curTimes = 1
	self._maxCultivateTimes = 100

	for i, v in ipairs(self._mountCfgs) do
		if v.id == self._selectMountId then
			self._selectIndex = i
		end
	end

	for i = 1, 4 do
		GameUtil.SetActive(self._attrs[i].txtBarrage, false)
	end

	self:_refreshView()
	self:_refreshCostView()
end

function MountCultivateView:_refreshView()
	local curAtt = MountModel.instance:getCurAtt(self._selectMountId)
	local lockMo = MountModel.instance:getLockmountsById(self._selectMountId)
	local level = lockMo and checknumber(lockMo.level) or 0
	local mountCo = MountConfig.instance:getMountCo(self._selectMountId)
	local attMaxList = MountModel.instance:getAttMax(self._selectMountId, level)

	for i, attr in ipairs(self._attrs) do
		local type = attMaxList[i].type
		local curVal = curAtt[i].value

		attr.txtVal.text = tostring(curVal)
		attr.txtName.text = ConstString.Attr[type]

		attr.icon:SetState(checknumber(type) - 1)
	end

	for i = 1, 5 do
		local state = self:_getPotentialState(i, level)

		self._potentials[i].ball:SetState(state)

		if self._potentials[i].line then
			self._potentials[i].line:SetState(state)
		end
	end

	self:_calcTotalCultivateTime()
	self._sliderAdapter:SetValue(1)

	local isReachMax = self._needTime == 0 and level == #self._cultivateTimesList

	GameUtil.SetActive(self._costTableview, not isReachMax)
	GameUtil.SetActive(self._cultivateTime, not isReachMax)
	GameUtil.SetActive(self._btnLevelUp, not isReachMax)
	GameUtil.SetActive(self._cultivateMax, isReachMax)
	GameUtil.SetActive(self._btnPre, self._mountCfgs[self._selectIndex - 1] ~= nil)
	GameUtil.SetActive(self._btnNext, self._mountCfgs[self._selectIndex + 1] ~= nil and MountController:getIfLock(self._mountCfgs[self._selectIndex + 1].id))
end

function MountCultivateView:_getPotentialState(index, level)
	local res = 0

	for i = MAX_POTENTIAL_STATE, 0, -1 do
		if level >= index + i * MAX_LIGHT_NUM then
			res = i + 1

			break
		end
	end

	return res
end

function MountCultivateView:_calcTotalCultivateTime()
	local mountCo = MountConfig.instance:getMountCo(self._selectMountId)

	self._cultivateTimesList = MountConfig.instance:getCultivateTimeConfigs(mountCo.levelUpPlan)

	local lockMo = MountModel.instance:getLockmountsById(self._selectMountId)
	local level = lockMo and checknumber(lockMo.level) or 0
	local attMaxList = MountModel.instance:getAttMax(self._selectMountId, level)
	local attrPlanLvCfg = MountConfig.instance:getAttrByPlanLvl(self._selectMountId, level)
	local curAtt = MountModel.instance:getCurAtt(self._selectMountId)

	self._isEnoughMat = true
	self._needTime = 0

	for i, attr in ipairs(self._attrs) do
		local type = attMaxList[i].type
		local maxVal = checknumber(attMaxList[i].value)
		local curVal = curAtt[i].value
		local addLevelValue = MountConfig.instance:getAttAddValue(attrPlanLvCfg.attributePlan, GameEnum.AttrTypeName[type])
		local addTime = math.ceil((maxVal - curVal) / addLevelValue)

		self._needTime = self._needTime + addTime
	end

	local maxCultivate = self._needTime

	for i = level + 1, #self._cultivateTimesList do
		maxCultivate = maxCultivate + self._cultivateTimesList[i]
	end

	local maxCultivateTimes = 0
	local costMatMap = {}

	for i = level, #self._cultivateTimesList do
		local checkTimes = 0

		checkTimes = i == level and self._needTime or self._cultivateTimesList[i]

		local planCfg = MountConfig.instance:getAttrByPlanLvl(self._selectMountId, i)
		local matType, matId, matNum = MaterialMgr.getMatParams(planCfg.levelUpConsume)
		local matStr = string.format("%d:%d", matType, matId)

		if self:_checkIsMatEnoughByMatMap(costMatMap, matType, matId, checkTimes * matNum) == true then
			maxCultivateTimes = maxCultivateTimes + checkTimes
			costMatMap[matStr] = costMatMap[matStr] or 0
			costMatMap[matStr] = costMatMap[matStr] + checkTimes * matNum

			local breachMatType, breachMatId, breachMatNum = MaterialMgr.getMatParams(planCfg.breachConsume)

			if self:_checkIsMatEnoughByMatMap(costMatMap, breachMatType, breachMatId, breachMatNum) == true then
				local breachMatStr = string.format("%d:%d", breachMatType, breachMatId)

				costMatMap[breachMatStr] = costMatMap[breachMatStr] or 0
				costMatMap[breachMatStr] = costMatMap[breachMatStr] + breachMatNum
			else
				self._isEnoughMat = false

				break
			end
		else
			local curMatNum = MaterialModel.instance:getMaterialsNumber(matType, matId)
			local addTimes = math.floor((curMatNum - costMatMap[matStr]) / matNum)

			maxCultivateTimes = maxCultivateTimes + addTimes
			self._isEnoughMat = false

			break
		end
	end

	if maxCultivateTimes == 0 then
		self._maxCultivateTimes = 1
		self._sliderAdapter.slider.maxValue = self._maxCultivateTimes
	else
		self._maxCultivateTimes = maxCultivateTimes
		self._sliderAdapter.slider.maxValue = self._maxCultivateTimes
	end
end

function MountCultivateView:_checkIsMatEnoughByMatMap(matMap, matType, matId, matNum)
	local matStr = string.format("%d:%d", matType, matId)

	matMap[matStr] = matMap[matStr] or 0

	return MaterialModel.instance:IsEnough(matType, matId, matMap[matStr] + matNum) == true
end

function MountCultivateView:_refreshCostView()
	self._txTimes.text = self._curTimes

	local lockMo = MountModel.instance:getLockmountsById(self._selectMountId)
	local level = lockMo and checknumber(lockMo.level) or 0
	local times = self._curTimes
	local materialInfo = {}
	local isActiveForce = false
	local reachLevel = level

	for i = level, #self._cultivateTimesList do
		local checkTimes = i == level and self._needTime or self._cultivateTimesList[i]

		if checkTimes <= times then
			self:_addCultivateMat(materialInfo, i, checkTimes, false)

			times = times - checkTimes

			if times > 0 then
				self:_addBreachMat(materialInfo, i, checkTimes == 0)
			end

			if self._maxCultivateTimes == 1 and checkTimes == 0 then
				isActiveForce = true
			end
		else
			self:_addCultivateMat(materialInfo, i, times, checkTimes ~= 0 and not isActiveForce)

			times = 0
		end

		reachLevel = i

		if times <= 0 then
			break
		end
	end

	local resultList = {}

	for i, v in pairs(materialInfo) do
		if v > 0 then
			table.insert(resultList, string.format("%s:%d", i, v))
		end
	end

	self._costTableList:reloadData(resultList)

	local mountCo = MountConfig.instance:getMountCo(self._selectMountId)
	local levelCfg = MountConfig.instance:getMountLevel(mountCo.levelUpPlan, reachLevel)

	self._txtMarkUp.text = levelCfg.attribute
end

function MountCultivateView:_addCultivateMat(matMap, level, times, force)
	local planCfg = MountConfig.instance:getAttrByPlanLvl(self._selectMountId, level)
	local matType, matId, matNum = MaterialMgr.getMatParams(planCfg.levelUpConsume)
	local matStr = string.format("%d:%d", matType, matId)

	matMap[matStr] = matMap[matStr] or 0

	if MaterialModel.instance:IsEnough(matType, matId, matMap[matStr] + matNum * times) == true or force == true then
		matMap[matStr] = matMap[matStr] + matNum * times

		return true
	else
		return false
	end
end

function MountCultivateView:_addBreachMat(matMap, level, force)
	local planCfg = MountConfig.instance:getAttrByPlanLvl(self._selectMountId, level)
	local breachMatType, breachMatId, breachMatNum = MaterialMgr.getMatParams(planCfg.breachConsume)
	local breachMatStr = string.format("%d:%d", breachMatType, breachMatId)

	matMap[breachMatStr] = matMap[breachMatStr] or 0

	if MaterialModel.instance:IsEnough(breachMatType, breachMatId, matMap[breachMatStr] + breachMatNum) == true or force == true then
		matMap[breachMatStr] = matMap[breachMatStr] + breachMatNum

		return true
	else
		return false
	end
end

function MountCultivateView:_updateCostCell(view, cell, data, tag)
	local go = cell.gameObject

	MaterialMgr.setCellByCfg(data, go)
end

function MountCultivateView:_clearCostCell(cell)
	MaterialMgr.resetAll(cell)
end

function MountCultivateView:_setSliderValue(value)
	if value > self._curTimes and self._maxCultivateTimes == value then
		if self._isEnoughMat ~= true then
			FloatWordMgr.instance:show(lang("材料不足"))
		else
			FloatWordMgr.instance:show(lang("已达到上限"))
		end
	end

	self._curTimes = value

	self:_refreshCostView()
end

function MountCultivateView:_showBarrage(property)
	self:_refreshView()
	self:_refreshCostView()

	local curAttrList = MountModel.instance:getCurAtt(self._selectMountId)

	if curAttrList then
		for i = 1, #curAttrList do
			for k, v in pairs(property) do
				if curAttrList[i].type == v.propertyType then
					GameUtil.SetActive(self._attrs[i].txtBarrage, true)

					if self._tweeners[i] then
						self._tweeners[i]:Kill(false)

						self._tweeners[i] = nil
					end

					self._tweeners[i] = TweenUtil.ValueTo(1, 0, 2, function(val)
						self._attrs[i].txtBarrage.text = "+" .. v.propertyValue
					end, function()
						self._tweeners[i] = nil

						GameUtil.SetActive(self._attrs[i].txtBarrage, false)
					end, self)
				end
			end
		end
	end
end

function MountCultivateView:_onClickAdd()
	if self._maxCultivateTimes == self._curTimes then
		if self._isEnoughMat ~= true then
			FloatWordMgr.instance:show(lang("材料不足"))
		else
			FloatWordMgr.instance:show(lang("已达到上限"))
		end
	end

	if self._curTimes < self._maxCultivateTimes then
		self._sliderAdapter:SetValue(self._curTimes + 1)
	end
end

function MountCultivateView:_onClickMinus()
	if self._curTimes > 1 then
		self._sliderAdapter:SetValue(self._curTimes - 1)
	end
end

function MountCultivateView:_onClickLevelUp()
	if self._needTime == 0 then
		local level = MountModel.instance:getLockmountsById(self._selectMountId).level
		local consume = MountModel.instance:getBreachConsume(self._selectMountId, level)
		local arr = string.split(consume, ":")
		local useNum = checknumber(arr[3])
		local has_num = MaterialFacade.instance:getMatNumber(checknumber(arr[1]), checknumber(arr[2]))

		if useNum <= has_num then
			local attrPlanLvCfg = MountConfig.instance:getAttrByPlanLvl(self._selectMountId, level + 1)

			if attrPlanLvCfg then
				local matType, matId, matNum = MaterialMgr.getMatParams(attrPlanLvCfg.levelUpConsume)

				if not MaterialModel.instance:IsEnough(matType, matId, matNum) then
					MountAgent.instance:sendMountBreachReq(self._selectMountId)

					return
				else
					MountAgent.instance:sendOneClickDevelopMountReq(self._selectMountId, self._curTimes)
				end
			else
				MountAgent.instance:sendMountBreachReq(self._selectMountId)
			end
		else
			FloatWordMgr.instance:show(lang("材料不足"))
		end
	else
		local realTimes = MountController.instance:canCultivateTime(self._selectMountId)

		if realTimes == 0 then
			FloatWordMgr.instance:show(lang("材料不足"))
		else
			MountAgent.instance:sendOneClickDevelopMountReq(self._selectMountId, self._curTimes)
		end
	end
end

function MountCultivateView:_onClickNext()
	self._selectMountId = self._mountCfgs[self._selectIndex + 1].id

	self:_initView()
end

function MountCultivateView:_onClickPre()
	self._selectMountId = self._mountCfgs[self._selectIndex - 1].id

	self:_initView()
end

function MountCultivateView:_handlePM_MountBreachRes()
	self:_refreshView()
	self:_refreshCostView()
end

return MountCultivateView
