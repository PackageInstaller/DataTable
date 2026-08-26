-- chunkname: @modules/logic/permanent/model/PermanentActivityListModel.lua

module("modules.logic.permanent.model.PermanentActivityListModel", package.seeall)

local PermanentActivityListModel = class("PermanentActivityListModel", ListScrollModel)

function PermanentActivityListModel:refreshList()
	local permanentDic = PermanentModel.instance:getActivityDic()
	local unlockList = {}
	local lockList = {}

	for _, infoMo in pairs(permanentDic) do
		if infoMo.online then
			if infoMo.permanentUnlock then
				table.insert(unlockList, infoMo)
			else
				table.insert(lockList, infoMo)
			end
		elseif SLFramework.FrameworkSettings.IsEditor then
			logNormal("PermanentActivityListModel:refreshList online false:", tostring(infoMo.id))
		end
	end

	table.sort(unlockList, SortUtil.keyLower("id"))
	table.sort(lockList, SortUtil.keyLower("id"))
	tabletool.addValues(unlockList, lockList)
	table.insert(unlockList, {
		id = -999
	})
	self:setList(unlockList)
end

PermanentActivityListModel.instance = PermanentActivityListModel.New()

return PermanentActivityListModel
