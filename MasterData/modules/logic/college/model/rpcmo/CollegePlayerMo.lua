-- chunkname: @modules/logic/college/model/rpcmo/CollegePlayerMo.lua

module("modules.logic.college.model.rpcmo.CollegePlayerMo", package.seeall)

local CollegePlayerMo = pureTable("CollegePlayerMo")

function CollegePlayerMo:init(data)
	self.statusBox = GameUtil.rpcInfoToMo(data.statusBox, CollegeStatusBoxMo, self.statusBox)
	self.attributeContainer = GameUtil.rpcInfoToMo(data.attributeContainer, CollegeAttributeContainerMo, self.attributeContainer)
end

function CollegePlayerMo:update(data)
	self.attributeContainer = GameUtil.rpcInfoToMo(data.attributeContainer, CollegeAttributeContainerMo, self.attributeContainer)

	local curUids = {}
	local removeUids = {}

	for i, v in ipairs(data.statusBox.statuses) do
		curUids[v.uid] = true
	end

	local newStatusList = self.statusBox:updateState(data.statusBox.statuses)

	for k, v in pairs(self.statusBox.statusesMap) do
		if not curUids[k] then
			table.insert(removeUids, k)
		end
	end

	self.statusBox:removeState(removeUids)
	CollegeController.instance:dispatchEvent(CollegeEvent.UpdateState)

	if newStatusList and #newStatusList > 0 then
		CollegeController.instance:dispatchEvent(CollegeEvent.OnGetNewState, newStatusList)
	end
end

function CollegePlayerMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegePlayerMo" then
		return false
	end

	local isSame = true

	if not self.statusBox:compareWith(otherMo.statusBox) then
		isSame = false

		logError("CollegePlayerMo compareWith statusBox not same")
	end

	if not self.attributeContainer:compareWith(otherMo.attributeContainer) then
		isSame = false

		logError("CollegePlayerMo compareWith attributeContainer not same")
	end

	return isSame
end

return CollegePlayerMo
