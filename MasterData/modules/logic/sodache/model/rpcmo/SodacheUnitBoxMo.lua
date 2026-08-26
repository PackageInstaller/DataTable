-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheUnitBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheUnitBoxMo", package.seeall)

local SodacheUnitBoxMo = pureTable("SodacheUnitBoxMo")

function SodacheUnitBoxMo:init(data)
	self.units, self.unitsMap = GameUtil.rpcInfosToListAndMap(data.units, SodacheUnitMo, "uid", self.unitsMap)
end

function SodacheUnitBoxMo:addUnits(unitMos)
	for k, v in ipairs(unitMos) do
		local unitMo = self.unitsMap[v.uid]

		if unitMo then
			logError("事件已存在，添加失败" .. v.uid)
			unitMo:init(v)
		else
			unitMo = SodacheUnitMo.New()

			unitMo:init(v)
			table.insert(self.units, unitMo)

			self.unitsMap[v.uid] = unitMo
		end
	end
end

function SodacheUnitBoxMo:removeUnits(uids)
	for k, v in ipairs(uids) do
		local unitMo = self.unitsMap[v]

		if unitMo then
			GameUtil.tabletool_fastRemoveValueByValue(self.units, unitMo)

			self.unitsMap[v] = nil
		else
			logError("删除事件失败" .. v)
		end
	end
end

return SodacheUnitBoxMo
