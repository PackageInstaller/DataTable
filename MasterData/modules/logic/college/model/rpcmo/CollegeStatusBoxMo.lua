-- chunkname: @modules/logic/college/model/rpcmo/CollegeStatusBoxMo.lua

module("modules.logic.college.model.rpcmo.CollegeStatusBoxMo", package.seeall)

local CollegeStatusBoxMo = pureTable("CollegeStatusBoxMo")

function CollegeStatusBoxMo:init(data)
	self.statuses, self.statusesMap = GameUtil.rpcInfosToListAndMap(data.statuses, CollegeStatusMo, "uid", self.statusesMap)
end

function CollegeStatusBoxMo:getStatusMo(id)
	return self.statusesMap[id]
end

function CollegeStatusBoxMo:updateState(status)
	local newMoList

	for i, v in ipairs(status) do
		local statusMo = self.statusesMap[v.uid]

		if not statusMo then
			statusMo = GameUtil.rpcInfoToMo(v, CollegeStatusMo)
			self.statusesMap[v.uid] = statusMo

			table.insert(self.statuses, statusMo)
			CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_status_add"), statusMo.co.name))

			newMoList = newMoList or {}

			table.insert(newMoList, statusMo)
		else
			statusMo:init(v)
		end
	end

	return newMoList
end

function CollegeStatusBoxMo:removeState(uids)
	for i, v in ipairs(uids) do
		local statusMo = self.statusesMap[v]

		if statusMo then
			CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_status_remove"), statusMo.co.name))
			tabletool.removeValue(self.statuses, statusMo)

			self.statusesMap[v] = nil
		end
	end
end

function CollegeStatusBoxMo:compareWith(otherMo)
	if type(otherMo) ~= "table" or otherMo.__cname ~= "CollegeStatusBoxMo" then
		return false
	end

	local isSame = true

	if #self.statuses ~= #otherMo.statuses then
		isSame = false

		logError(string.format("CollegeStatusBoxMo compareWith statuses count not same: %s >> %s", #self.statuses, #otherMo.statuses))
	else
		for i = 1, #self.statuses do
			local otherStatusMo = otherMo.statusesMap[self.statuses[i].uid]

			if not otherStatusMo or not self.statuses[i]:compareWith(otherStatusMo) then
				isSame = false

				logError(string.format("CollegeStatusBoxMo compareWith statuses not same: uid=%s", self.statuses[i].uid))

				break
			end
		end
	end

	return isSame
end

return CollegeStatusBoxMo
