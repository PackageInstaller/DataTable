-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/view/LotusbattlepetselectView.lua

module("logic.extensions.lotusbattle.view.LotusbattlepetselectView", package.seeall)

local LotusbattlepetselectView = class("LotusbattlepetselectView", ViewComponent)

function LotusbattlepetselectView:ctor()
	LotusbattlepetselectView.super.ctor(self)
end

function LotusbattlepetselectView:unbindEvents()
	LotusbattlepetselectView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function LotusbattlepetselectView:bindEvents()
	LotusbattlepetselectView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function LotusbattlepetselectView:buildUI()
	LotusbattlepetselectView.super.buildUI(self)

	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableView = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnSure = self:getBtn("btnSure")
	self._txtBtnSure = self:getTxt("btnSure/Text")
	self._txtTip = self:getTxt("txtTip")
	self._txtDesc = self:getTxt("txtDesc")
end

function LotusbattlepetselectView:onExit()
	LotusbattlepetselectView.super.onExit(self)
	self._tableView:dispose()
	removetimer(self._tick, self)
end

function LotusbattlepetselectView:onEnter()
	LotusbattlepetselectView.super.onEnter(self)

	self._activityId = LotusbattleModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self:_resetParams()
	goutil.setActive(self._txtDesc.gameObject, self._modelCfg.usePackage)

	self._creepsCfgs = self:_getCreepsCfgs()
	self._isTimeout = false

	settimer(1, self._tick, self, true)
	self:_tick()
	self:_updateUI()
end

function LotusbattlepetselectView:_resetParams()
	self._tickTime = LotusbattleConfig.instance:getStageTime(self._activityId, "selectPetTime")
	self._targetTickTime = ServerTime.now() + self._tickTime
	self._creepIds = {}
	self._cachePetMos = {}
	self._totalSelectPetNumLimit = LotusbattleConfig.instance:getInitPetMaxNum(self._activityId)
	self._txtTip.text = langPara("最多可选%s只精灵（%s/%s）", self._totalSelectPetNumLimit, 0, self._totalSelectPetNumLimit)

	local modelId = LotusbattleModel.instance:getModelId()

	self._modelCfg = LotusbattleConfig.instance:getModelCfg(self._activityId, modelId)
end

function LotusbattlepetselectView:_getCreepsCfgs()
	local params = self:getOpenParam()
	local creepsIds = params[1]
	local bagCreepIds = params[2]
	local list = {}
	local creepsId_kv = {}

	if self._modelCfg.usePackage then
		for i, creepId in ipairs(bagCreepIds) do
			creepsId_kv[creepId] = creepId
		end
	end

	for i, creepsId in ipairs(creepsIds) do
		local creepsCfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

		if not creepsId_kv[creepsCfg.creepsId] then
			table.insert(list, creepsCfg)
		end
	end

	return list
end

function LotusbattlepetselectView:_onClickbtnSure()
	local num = table.nums(self._creepIds)

	if num < self._totalSelectPetNumLimit then
		FloatWordMgr.instance:show(string.format("数量不足%s只", self._totalSelectPetNumLimit))

		return
	end

	if self._isTimeout then
		FloatWordMgr.instance:show("选择精灵超时，请稍等")

		return
	end

	local list = {}

	for k, v in pairs(self._creepIds) do
		if v then
			table.insert(list, v.petId)
		end
	end

	if #list <= 0 then
		FloatWordMgr.instance:show("先选择首发精灵")

		return
	end

	LotusBattleFieldAgent.instance:sendPM_LBFSelectInitialPetReq(list)
	removetimer(self._tick, self)
	self:close()
end

function LotusbattlepetselectView:_updateUI()
	self._tableView:reloadData(self._creepsCfgs)
end

function LotusbattlepetselectView:_updateCell(view, goCell, creepsCfg)
	local cell = self:_clearCell(goCell)
	local data = self._cachePetMos[creepsCfg.creepsId]

	if not data then
		data = LotusbattleController.instance:getPetMoByCreepsId(creepsCfg.creepsId)
		self._cachePetMos[creepsCfg.creepsId] = data
	end

	local proxy = MaterialMgr.setCellByMo(data, cell.posPet)

	proxy:setCallBack(function()
		CommonTipsMgr.instance:showPetTips(data)
	end)
	goutil.setActive(cell.mark, self._creepIds[data.petId])
	GameUtil.addClickHandler(cell.btnSelect, GameUtil.handler(self._onClickSelect, self, data))

	for i = 1, data.awakenLv do
		goutil.setActive(cell.stars[i], true)
	end

	cell.txtName.text = data:getName()
end

function LotusbattlepetselectView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.posPet = goutil.findChild(cell.go, "posPet")
	cell.btnSelect = cell.go.gameObject
	cell.mark = goutil.findChild(cell.go, "btnSelect/mark")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")

	goutil.setActive(cell.mark, false)
	GameUtil.rmClickHandler(cell.btnSelect)
	MaterialMgr.resetAll(cell.posPet)

	cell.stars = {}

	for i = 1, 6 do
		cell.stars[i] = goutil.findChild(cell.go, "starLv/star_" .. i)

		goutil.setActive(cell.stars[i], false)
	end

	return cell
end

function LotusbattlepetselectView:_tick()
	local leftTime = self._targetTickTime - ServerTime.now()

	self._txtBtnSure.text = string.format("确定(%ss)", leftTime)

	if leftTime <= 0 then
		self._isTimeout = true

		removetimer(self._tick, self)
		goutil.setActive(self._btnSure.gameObject, false)

		self._txtBtnSure.text = "选择超时"
	end
end

function LotusbattlepetselectView:_onClickSelect(petMo)
	local petSelectCount = table.nums(self._creepIds)

	if petMo then
		if self._creepIds[petMo.petId] then
			self._creepIds[petMo.petId] = nil
			petSelectCount = petSelectCount - 1
		elseif petSelectCount >= self._totalSelectPetNumLimit then
			FloatWordMgr.instance:show(string.format("最多可选中%s只精灵", self._totalSelectPetNumLimit))

			return
		else
			self._creepIds[petMo.petId] = petMo
			petSelectCount = petSelectCount + 1
		end

		self._tableView:refresh()
	end

	self._txtTip.text = langPara("最多可选%s只精灵（%s/%s）", self._totalSelectPetNumLimit, petSelectCount, self._totalSelectPetNumLimit)
end

return LotusbattlepetselectView
