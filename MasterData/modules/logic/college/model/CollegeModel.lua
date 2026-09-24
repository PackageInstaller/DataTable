-- chunkname: @modules/logic/college/model/CollegeModel.lua

module("modules.logic.college.model.CollegeModel", package.seeall)

local CollegeModel = class("CollegeModel", BaseModel)

function CollegeModel:onInit()
	self.hideViewConditions = {}
	self._sceneMo = nil
	self.toastList = {}
	self.lockMsgUpdate = false
	self.cacheMsgPushs = {}
	self.curFocusData = nil
	self.curSceneType = nil
end

function CollegeModel:reInit()
	self:onInit()
end

function CollegeModel:isViewVisible(viewName)
	for i, v in pairs(self.hideViewConditions) do
		if #v == 0 or tabletool.indexOf(v, viewName) then
			return false
		end
	end

	return true
end

function CollegeModel:updateSceneMo(msg)
	self.hideViewConditions = {}
	self.lockMsgUpdate = false
	self.cacheMsgPushs = {}
	self.curFocusData = nil
	self.curSceneType = nil
	self._sceneMo = self._sceneMo or CollegeSceneMo.New()

	self._sceneMo:init(msg.scene)
end

function CollegeModel:getSceneMo()
	return self._sceneMo
end

function CollegeModel:getCoinCount()
	return self:getItemCount(CollegeConfig.instance:getConstNum(CollegeEnum.ConstId.CoinId))
end

function CollegeModel:getItemCount(id)
	return self._sceneMo.bag:getItemCount(id)
end

function CollegeModel:isEnoughItems(str, ...)
	if string.nilorempty(str) then
		return true
	end

	return self:isEnoughItemsTb(GameUtil.splitString2(str, true, "&", ":"), ...)
end

function CollegeModel:isEnoughItemsTb(tb, ...)
	if not tb or #tb == 0 then
		return true
	end

	local paramCount = select("#", ...)

	for i, v in ipairs(tb) do
		local id, num = v[1], v[2]

		if paramCount > 0 then
			local total = 0

			for index = 1, paramCount do
				total = total + math.floor(num * select(index, ...))
			end

			num = total
		end

		if num > self:getItemCount(id) then
			return false
		end
	end

	return true
end

function CollegeModel:slotOper(operMo, uids, callback, callobj)
	local type = operMo.type
	local id = operMo.id
	local messageBoxId

	for i, v in ipairs(uids) do
		local characterMo = self._sceneMo.characterBox.charactersMap[v]

		if characterMo and characterMo.inLocationStatus and characterMo.inLocationStatus ~= operMo then
			messageBoxId = MessageBoxIdDefine.CollegeSlotOperTip

			break
		end
	end

	if #uids == 0 and #operMo.slotCharacterUid > 0 then
		messageBoxId = MessageBoxIdDefine.CollegeSlotOperTip2
	end

	local function cb()
		if type == CollegeEnum.SceneType.City then
			CollegeRpc.instance:sendCollegeBuildingSlotOper(id, uids, callback, callobj)
		else
			CollegeRpc.instance:sendCollegeWorldMapSlotOper(id, uids, callback, callobj)
		end
	end

	if messageBoxId then
		GameFacade.showMessageBox(messageBoxId, MsgBoxEnum.BoxType.Yes_No, cb)
	else
		cb()
	end
end

function CollegeModel:setMsgLock(isLock)
	if isLock then
		self.lockMsgUpdate = true
	else
		self.lockMsgUpdate = false

		for i, v in ipairs(self.cacheMsgPushs) do
			self:updatePush(v)
		end

		self.cacheMsgPushs = {}

		CollegeController.instance:dispatchEvent(CollegeEvent.OnServerMsgUpdate)
	end
end

function CollegeModel:updatePushs(msgs)
	if self.lockMsgUpdate then
		tabletool.addValues(self.cacheMsgPushs, msgs)

		return
	end

	for i, v in ipairs(msgs) do
		self:updatePush(v)
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.OnServerMsgUpdate)
end

function CollegeModel:updatePush(msg)
	if self.lockMsgUpdate then
		table.insert(self.cacheMsgPushs, msg)

		return
	end

	if not ViewMgr.instance:isOpen(ViewName.CollegeMainView) then
		logError("没有打开学院主界面，竟然收到数据更新？？如果是GM操作的，请忽略")

		return
	end

	CollegeMsgHelper.instance:setMsg(msg)

	if not CollegeEnum.MsgPushTypeToName[msg.type] then
		local typeName = ""
		local func = CollegeMsgHelper["process_" .. typeName]

		if func then
			func(CollegeMsgHelper.instance)
		end

		CollegeMsgHelper.instance:setMsg()
	end
end

function CollegeModel:getBuildingMoByType(buildingType)
	return self._sceneMo.buildingBox:getBuildingMoByType(buildingType)
end

function CollegeModel:isAnyRewardCanGet()
	local mileStoneBox = self._sceneMo.milestoneBox

	for _, rewardCo in ipairs(lua_college_reward.configList) do
		if mileStoneBox:getRewardStatus(rewardCo.id) == CollegeEnum.RewardStatus.Canget then
			return true
		end
	end
end

function CollegeModel:updateCharacterState(id)
	self._sceneMo.milestoneBox.readStateId[id] = true
end

function CollegeModel:getCharacterState(id)
	return self._sceneMo.milestoneBox.readStateId[id]
end

CollegeModel.instance = CollegeModel.New()

return CollegeModel
